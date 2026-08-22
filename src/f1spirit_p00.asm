; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 00 (se ejecuta en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; DATOS cabecera: "AB", INIT=0x40E4, STATEMENT/DEVICE/TEXT a cero y reserva;
;   en 0x4010 la firma "CD" 07 "R" FF de Konami y en 0x4015 un `jp 0xBE2E`
;   (entrada para otro cartucho; no se sabe aun quien salta ahi ni con que
;   pagina en 0xA000)
;   0x4000..0x4018  (24 bytes)
DATA_cabecera:
	defb 041h,042h	; 4000
	defw 040e4h,00000h,00000h,00000h	; 4002  -> INIT 0x0000 0x0000 0x0000
	defb 000h,000h,000h,000h,000h,000h	; 400a
	defb 043h,044h,007h,052h,0ffh	; 4010
	defb 0c3h,02eh,0beh	; 4015

; ======================================================================
; CODIGO 0x4018..0x41a0  (392 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; La interrupcion: cada fotograma. Lee el estado del VDP, guarda la
; sombra del mapper, mapea D/E/F para el sonido (0x6AA5 en la pagina
; 13), vuelve a poner D/E/F, vacia la cola de ordenes de sonido, y
; restaura los bancos guardados antes de la logica del juego.
;
; DOS CANDADOS Y UN FRENO, que es lo que hace que esto funcione. La
; logica del juego (0x40AC) puede tardar MAS DE UN FOTOGRAMA, y se
; llama desde dentro de la interrupcion; las rutinas de banco
; (0x43FE y siguientes) acaban en `ei`, asi que la interrupcion
; vuelve a entrar mientras la logica sigue corriendo. De ahi:
; - bit 1 de E1C5: hay una interrupcion dentro de otra -> la de
; fuera se va por 0x40B5 sin tocar nada.
; - bit 0 de E1C5: la logica ya esta en curso -> la interrupcion
; hace su parte de sonido y se va; asi el sonido nunca se para.
; - F0FC: cuenta interrupciones. En los estados 2 (la demo) y 5
; (la carrera) la logica no da un paso hasta que haya tres, y al
; darlo pone la cuenta a cero. La carrera avanza a un paso de
; cada tres interrupciones -unos 17 por segundo en PAL- pase lo
; que pase con lo que tarde el codigo: es un reloj fijo, no una
; velocidad que dependa de la maquina.
; ----------------------------------------------------------------------
INTERRUPCION:		; gancho H.KEYI; candado en el bit 1 de E1C5
	call 0013eh		;4018   ; BIOS RDVDP - Reads VDP status register | RDVDP: lee y limpia el estado del VDP
	ld hl,0e1c5h		;401b
	bit 1,(hl)		;401e   ; bit 1 de E1C5: ya hay una interrupcion dentro -> fuera
	jp nz,L_40B5		;4020
	ld a,(hl)			;4023
	and 07fh		;4024   ; de paso baja el bit 7, el que p02 0x8666 levanta para quedarse esperando al fotograma siguiente
	or 002h		;4026
	ld (hl),a			;4028
	di			;4029   ; de aqui a 0x4046 se toca el mapper: una interrupcion en medio dejaria los bancos cruzados
	ld hl,0f0f1h		;402a   ; F0F1/F0F2/F0F3: la sombra del mapper; se guarda en D/E/A y se pone D/E/F
	ld a,00dh		;402d
	ld (07000h),a		;402f
	ld d,(hl)			;4032
	ld (hl),a			;4033
	inc hl			;4034
	ld a,00eh		;4035
	ld (09000h),a		;4037
	ld e,(hl)			;403a
	ld (hl),a			;403b
	inc hl			;403c
	ld a,00fh		;403d
	ld (0b000h),a		;403f
	ld a,(hl)			;4042   ; el hueco de 0xA000 se guarda en A porque no quedan registros libres, y entonces el `ld (hl),a` de 0x4043 devuelve a la sombra el valor VIEJO: F0F3 no se entera del 0x0F. Nadie lee la sombra en esta ventana, asi que no se nota; el mismo codigo copiado en 0x42DA hace lo mismo
	ld (hl),a			;4043
	push de			;4044
	push af			;4045
	call 06aa5h		;4046   ; el paso del reproductor de sonido, en la pagina 13
	ld a,00dh		;4049   ; D/E/F otra vez: el driver toca 0x9000 para el SCC y deja la pagina 2 en 0x8000
	ld (07000h),a		;404b
	inc a			;404e
	ld (09000h),a		;404f
	inc a			;4052
	ld (0b000h),a		;4053
	ld a,(0e1c5h)		;4056   ; el bit 0 al acarreo: el repintado de 0x40BB solo cabe ENTRE pasos de logica, nunca dentro de uno
	rrca			;4059
	call nc,REPINTA_PENDIENTE		;405a
	call VACIA_COLA_SONIDO		;405d   ; vacia la cola de ordenes de sonido (call 0x6000 de la pagina 13 por orden)
	di			;4060
	call 06422h		;4061   ; 0x6422 de la pagina 13 (D/E/F siguen mapeadas)
	call CUENTA_ATRAS_F0F7		;4064   ; esta cuenta atras baja una vez por INTERRUPCION, no por paso de logica: es tiempo real (la carga p01 0x7DF3 y la mira p02 0x865C)
	di			;4067
	pop af			;4068
	pop de			;4069
	ld hl,0f0f3h		;406a   ; restaura en el mapper y en la sombra los tres bancos guardados
	ld (0b000h),a		;406d
	ld (hl),a			;4070
	dec hl			;4071
	ld a,e			;4072
	ld (09000h),a		;4073
	ld (hl),a			;4076
	dec hl			;4077
	ld a,d			;4078
	ld (07000h),a		;4079
	ld (hl),a			;407c
	ld hl,0e1c5h		;407d
	res 1,(hl)		;4080   ; el candado se suelta ANTES de la logica: las interrupciones que lleguen mientras dura entraran a alimentar el sonido
	ld hl,0f0fch		;4082
	inc (hl)			;4085   ; F0FC cuenta todas las interrupciones, tambien las que se caen en 0x408B
	ld hl,0e1c5h		;4086
	bit 0,(hl)		;4089   ; bit 0 de E1C5: la logica del juego ya esta en curso (se salto un fotograma)
	jr nz,L_40B5		;408b
	set 0,(hl)		;408d
	ld a,(0e1c0h)		;408f   ; solo la demo (estado 2) y la carrera (estado 5) llevan freno de fotogramas
	cp 005h		;4092
	jr z,L_409A		;4094
	cp 002h		;4096
	jr nz,L_40A4		;4098
L_409A:
	ld hl,0f0fch		;409a
	ld a,(hl)			;409d
	cp 003h		;409e   ; menos de tres interrupciones desde el ultimo paso: este fotograma no hay logica
	jr c,L_40AF		;40a0
	ld (hl),000h		;40a2   ; y al darlo la cuenta vuelve a cero. O sea que entre dos pasos pasan AL MENOS tres interrupciones: es un techo de velocidad, no un compas fijo. Si un paso tarda mas de tres, al acabar la cuenta ya esta por encima y el siguiente sale sin esperar
L_40A4:
	call LEE_ENTRADAS		;40a4   ; lee mandos y teclas
	ld hl,0f0ffh		;40a7   ; F0FF = 3, y ninguna de las 16 paginas lo vuelve a leer por direccion
	ld (hl),003h		;40aa
	call ESTADOS		;40ac   ; el despachador de estados del juego
L_40AF:
	di			;40af   ; aqui dentro han podido pasar varios fotogramas; el `di` protege el candado
	ld hl,0e1c5h		;40b0
	res 0,(hl)		;40b3
L_40B5:
	call 0013eh		;40b5   ; BIOS RDVDP - Reads VDP status register
	or a			;40b8
	ei			;40b9   ; `ei` y se devuelve el control a la BIOS: por eso la interrupcion es reentrante y hacen falta los candados
	ret			;40ba
REPINTA_PENDIENTE:		; si (E1D5) != 0 lo pone a cero y repinta: sprites (0x477C), la ventana de la pista (0x450C) y los rotulos del HUD (0x4887)
	ld a,(0e1d5h)		;40bb   ; E1D5 = "hay pantalla que refrescar": lo levanta el paso de carrera (0x5BF0) y lo bajan los repintados gordos (p01 0x70D9) para que la interrupcion no les pise la VRAM
	or a			;40be
	ret z			;40bf
	sub a			;40c0
	ld (0e1d5h),a		;40c1   ; un aviso, un repintado: solo el primer hueco libre despues de cada paso de logica
	call SPRITES_A_VRAM		;40c4   ; los atributos de sprites de EA80 a la VRAM 0x3B00, alternando el orden en los fotogramas impares
	call PINTA_VENTANA_PISTA		;40c7   ; la ventana de la pista: 24 filas desde 0x3802 (fila 0, columna 2)
	jp HUD_DE_LOS_COCHES		;40ca   ; y los rotulos del HUD: PIT IN, RETIRE, EMPTY y GOAL
VDP_REG:		; escribe el registro C del VDP con B (BIOS WRTVDP)
	jp 00047h		;40cd   ; BIOS WRTVDP - Writes data in the VDP-register
HL_MAS_A:		; hl += a (sin signo)
	add a,l			;40d0   ; la suma de 8 sobre 16 bits de todo el cartucho: indices de tabla, filas y desplazamientos pasan por aqui
	ld l,a			;40d1
	ret nc			;40d2
	inc h			;40d3
	ret			;40d4
DE_MAS_A:		; de += a (sin signo)
	add a,e			;40d5   ; la misma con DE (0x4A3B recorre con ella las tablas de palabras)
	ld e,a			;40d6
	ret nc			;40d7
	inc d			;40d8
	ret			;40d9
DESPACHA:		; el "call seguido de tabla" de Konami: salta a la palabra A de la tabla que sigue al call
	pop hl			;40da   ; el retorno que acaba de dejar el `call` ES la tabla: se saca de la pila y sirve de base
	add a,a			;40db   ; por dos, que las entradas son palabras
	call HL_MAS_A		;40dc
	ld e,(hl)			;40df
	inc hl			;40e0
	ld d,(hl)			;40e1
	ex de,hl			;40e2
	jp (hl)			;40e3   ; salto, no llamada: como el retorno del `call 0x40DA` ya se gasto, el `ret` del destino vuelve a quien llamo al despachador (o a lo que este empujara antes, como 0x427C)

; ----------------------------------------------------------------------
; INIT: la BIOS llega aqui por la cabecera. Habilita el cartucho en
; 0x8000-0xBFFF, instala la interrupcion, borra la RAM, arranca el
; sonido, busca otros cartuchos (0xBF50 de la pagina 15), deja 1/2/3
; mapeadas y se para en `jr $`.
; ----------------------------------------------------------------------
INIT:		; punto de entrada del cartucho (cabecera)
	di			;40e4
	call 00138h		;40e5   ; BIOS RSLREG - Reads the primary slot register | RSLREG: la ranura primaria de cada pagina
	rrca			;40e8
	rrca			;40e9
	and 003h		;40ea
	ld c,a			;40ec
	ld b,000h		;40ed
	ld hl,0fcc1h		;40ef   ; EXPTBL/SLTTBL: compone el identificador de ranura del cartucho
	add hl,bc			;40f2
	ld a,(hl)			;40f3
	and 080h		;40f4
	or c			;40f6
	ld c,a			;40f7
	inc hl			;40f8
	inc hl			;40f9
	inc hl			;40fa
	inc hl			;40fb
	ld a,(hl)			;40fc
	and 00ch		;40fd
	or c			;40ff
	ld h,080h		;4100
	call 00024h		;4102   ; BIOS ENASLT - Switches to specified slot and page definitively | ENASLT con H=0x80: el cartucho tambien en 0x8000-0xBFFF
	xor a			;4105
	ld (0f3dbh),a		;4106   ; CLIKSW = 0: fuera el clic de tecla de la BIOS
	ld a,0c3h		;4109   ; `jp 0x4018` en H.KEYI (FD9A)
	ld (0fd9ah),a		;410b
	ld hl,INTERRUPCION		;410e
	ld (0fd9bh),hl		;4111
	ld sp,0f0f0h		;4114   ; pila en 0xF0F0 y RAM 0xE000-0xF0FF a cero
	ld hl,0e000h		;4117
	ld de,0e001h		;411a
	ld bc,010ffh		;411d
	ld (hl),000h		;4120
	ldir		;4122
	ld a,001h		;4124
	ld (0e1c5h),a		;4126   ; bit 0 de E1C5 a 1 antes de abrir las interrupciones: el gancho ya esta puesto, y sin esto la maquina de estados arrancaria a media inicializacion
	call ARRANCA_SONIDO		;4129   ; arranca el sonido (pagina 13) y pide el sonido 0x46
	call 0013eh		;412c   ; BIOS RDVDP - Reads VDP status register
	xor a			;412f
	ld (0e1c5h),a		;4130   ; y aqui se suelta, con la RAM limpia y el sonido en marcha
	di			;4133
	call MAPEA_D_E_F		;4134
	di			;4137   ; D/E/F y 0xBF50 de la pagina 15: busca otros cartuchos Konami en las ranuras
	call 0bf50h		;4138
	call MAPEA_1_2_3_B		;413b   ; 1/2/3 en 6000/8000/A000: el mapeo con el que arranca el juego
BUCLE_FINAL:		; aqui se queda INIT; todo lo demas pasa en la interrupcion
	jr BUCLE_FINAL		;413e
VACIA_COLA_SONIDO:		; hasta 10 ordenes en E246..: cada una `call 0x6000` (pagina 13) con A
	ld hl,0e245h		;4140   ; E245 es la cuenta y E246.. las ordenes; sin ordenes no hay nada que hacer
	ld a,(hl)			;4143
	or a			;4144
	ret z			;4145
	ld (hl),000h		;4146   ; la cuenta se pone a cero ANTES de recorrer la cola
	ld b,a			;4148
L_4149:
	inc l			;4149
	ld a,(hl)			;414a
	push hl			;414b
	push bc			;414c
	call 06000h		;414d   ; p13 0x6000 con el numero de sonido en A: D/E/F siguen mapeadas desde 0x4049
	pop bc			;4150
	pop hl			;4151
	djnz L_4149		;4152   ; diez como mucho, que es lo que deja meter 0x417E
	ret			;4154
CUENTA_ATRAS_F0F7:		; decrementa el contador de 16 bits F0F7/F0F8; A=0xFF si seguia contando
	ld a,(0f0f7h)		;4155   ; no es un `dec hl`: los dos bytes se guardan y se leen sueltos
	or a			;4158
	jr nz,L_4160		;4159
	ld a,(0f0f8h)		;415b   ; con el byte bajo a cero todavia puede quedar cuenta en el alto
	or a			;415e
	ret z			;415f
L_4160:
	ld a,(0f0f7h)		;4160   ; el que cuenta es el bajo...
	sub 001h		;4163
	ld (0f0f7h),a		;4165
	jr nc,L_4171		;4168
	ld a,(0f0f8h)		;416a   ; ...y su acarreo baja el alto
	dec a			;416d
	ld (0f0f8h),a		;416e
L_4171:
	or 0ffh		;4171   ; A = 0xFF avisa de que seguia contando; p02 0x865C prefiere mirar los dos bytes por su cuenta
	ret			;4173
ENCOLA_SONIDO:		; mete A en la cola de E245 (maximo 10); F0FA es solo el sitio donde deja A mientras HL trabaja
	di			;4174   ; `di`: la interrupcion vacia esta misma cola
	push hl			;4175
	ld (0f0fah),a		;4176   ; F0FA no guarda nada que se lea despues: es un apano para soltar A
	ld hl,0e245h		;4179
	ld a,(hl)			;417c
	inc a			;417d
	cp 00bh		;417e   ; once seria pasarse, y la orden se pierde sin avisar a nadie
	jr nc,L_4189		;4180
	ld (hl),a			;4182
	add a,l			;4183   ; la ranura libre es E245 + la cuenta nueva
	ld l,a			;4184
	ld a,(0f0fah)		;4185
	ld (hl),a			;4188
L_4189:
	pop hl			;4189
	ei			;418a
	ret			;418b
ESTADOS:		; suma 1 a E1C3 y despacha por (E1C0); si < 3 deja 0x427C como retorno
	ld hl,0e1c3h		;418c
	inc (hl)			;418f   ; E1C3 es el contador de fotogramas de LOGICA, no de interrupciones: de el cuelgan los parpadeos del HUD (p01 0x760D) y los turnos de los rivales (p03 0xA8A7)
	ld hl,0427ch		;4190   ; el retorno que se va a empujar para los estados de la presentacion
	ld bc,(0e1c0h)		;4193   ; de una tacada C = el estado (E1C0) y B = el subestado (E1C1): cada manejador recibe su subestado en B
	ld a,c			;4197
	cp 003h		;4198   ; estados 0, 1 y 2: al volver el manejador se cae en 0x427C, que mira el mando
	jr nc,L_419D		;419a
	push hl			;419c
L_419D:
	call DESPACHA		;419d

; ----------------------------------------------------------------------
; DATOS tabla_estados: 9 palabras del despachador de 0x419D: estados 0..8 de
;   (E1C0)
;   0x41a0..0x41b2  (18 bytes)
DATA_tabla_estados:
	defw 041b2h	; 41a0  -> ESTADO_0
	defw 041e3h	; 41a2  -> ESTADO_1
	defw 041eah	; 41a4  -> ESTADO_2
	defw 04221h	; 41a6  -> ESTADO_3
	defw 04252h	; 41a8  -> ESTADO_4
	defw 04279h	; 41aa  -> ESTADO_5
	defw 041b2h	; 41ac  -> ESTADO_0
	defw 041b2h	; 41ae  -> ESTADO_0
	defw 041b2h	; 41b0  -> ESTADO_0

; ======================================================================
; CODIGO 0x41b2..0x4328  (374 bytes)
; ======================================================================


ESTADO_0:		; estados 0, 6, 7 y 8: subestado en (E1C1) via djnz; 0xBE14/0xBE56 (pagina 3)
	djnz L_41C0		;41b2   ; subestado 1 aqui, 2 en 0x41C2 y 0 en 0x41CE: el djnz baja B antes de mirarlo
	ld a,(0e1c3h)		;41b4   ; subestado 1: solo trabaja en los fotogramas impares
	rra			;41b7
	ret nc			;41b8
	call 0be56h		;41b9   ; p03 0xBE56 escribe una fila mas del titulo y devuelve NZ mientras le queden
	ret nz			;41bc
	xor a			;41bd
	jr L_4219		;41be   ; puestas las seis filas, E1C4 = 0 y subestado 2
L_41C0:
	djnz L_41CE		;41c0
	ld hl,0e1c4h		;41c2   ; subestado 2: E1C4 entro a cero, o sea que da la vuelta -> 256 fotogramas de titulo quieto
	dec (hl)			;41c5
	ret nz			;41c6
	call PRESENTACION_MONTA_Y_PASO		;41c7   ; 0x5D16 rehace la pantalla del titulo y pone E1DD a cero
	xor a			;41ca
	jp L_426D		;41cb   ; y al estado 1 con E1C4 = 0
L_41CE:
	call VDP_REGISTROS		;41ce   ; subestado 0: los ocho registros del VDP
	ld hl,00000h		;41d1   ; los ocho colores del tile 0 a cero, en los tres tercios
	ld bc,00008h		;41d4
	xor a			;41d7
	call LLENA_VRAM_3_TERCIOS_B		;41d8
	call BORRA_SPRITES_Y_NOMBRES		;41db   ; borra los sprites y la tabla de nombres entera
	call 0be14h		;41de   ; p03 0xBE14 dibuja el titulo
	jr L_421C		;41e1
ESTADO_1:		; la ronda de pantallas de presentacion: un paso de 0x5D19 (el despachador de E1DD) por fotograma
	call PRESENTACION_PASO		;41e3   ; un paso de la ronda por fotograma
	ret nc			;41e6   ; mientras E1DD < 10 no hay acarreo y se sigue en el estado 1
	jp L_426B		;41e7   ; gastada la ronda entera, al estado 2: la demo
ESTADO_2:		; la demo: 0x5876 reproduce la partida grabada que toque (E1CD)
	djnz L_41FB		;41ea
	call DEMO_PASO		;41ec   ; subestado 1: 0x5876 mueve un fotograma de la partida grabada
	ld a,(0e1f3h)		;41ef   ; E1F3 lo baja el propio reproductor cuando la partida se acaba
	or a			;41f2
	ret nz			;41f3
	call 08735h		;41f4   ; p02 0x8735: E190 = 0, callados los canales del motor
	ld a,00ah		;41f7   ; diez fotogramas de cortesia y subestado 2
	jr L_4219		;41f9
L_41FB:
	djnz L_4210		;41fb
	ld hl,0e1c4h		;41fd   ; subestado 2: los diez fotogramas
	dec (hl)			;4200
	ret nz			;4201
L_4202:
	call 0869ah		;4202   ; p02 0x869A para la musica
	xor a			;4205
	ld (0e1c0h),a		;4206   ; y vuelta al estado 0, a pintar el titulo desde cero
	ld a,020h		;4209
	ld (0e1c4h),a		;420b   ; este 0x20 no llega a usarse: el subestado 1 del estado 0 pisa E1C4 con cero
	jr L_4274		;420e
L_4210:
	call CORTINILLA_COLUMNA		;4210   ; subestado 0: 0x49C7 gasta E1C4 borrando una columna de pantalla por fotograma
	ret p			;4213
	call DEMO_SIGUIENTE		;4214   ; acabado el borrado, 0x57D9 monta la escena siguiente (E1CD y la tabla de 0x584D)
	ld a,020h		;4217
L_4219:
	ld (0e1c4h),a		;4219   ; la salida comun de "cambio de subestado": E1C4 = A...
L_421C:
	ld hl,0e1c1h		;421c   ; ...y un subestado mas
	inc (hl)			;421f
	ret			;4220
ESTADO_3:		; la partida ya esta empezando: borra "PUSH SPACE KEY" y hace parpadear "PLAY START" mientras cuenta 0x28 fotogramas
	djnz L_4234		;4221   ; subestado 1: la cuenta atras del parpadeo
	ld hl,0e1c4h		;4223
	dec (hl)			;4226
	jr z,L_421C		;4227   ; llegada a cero, subestado 2
	ld de,0b011h		;4229   ; p09 0xB011, que expandido es "  PLAY START   " en la fila 20  --> "(20)(10)  PLAY START   "
	bit 2,(hl)		;422c   ; el bit 2 de la cuenta lo enciende y lo apaga cada cuatro fotogramas: cinco parpadeos en 0x28
	jp z,PINTA_ROTULO		;422e   ; 0x4B8F lo pinta (tile = letra - 0x20) y 0x4B99 lo borra (tile 0) en los mismos huecos
	jp BORRA_ROTULO		;4231
L_4234:
	djnz L_423B		;4234
	call L_497A		;4236   ; subestado 2: 0x497A limpia la RAM de la partida y aplica el desbloqueo (E1DE = 2 -> E1DF = 1)
	jr L_426B		;4239   ; y al estado 4
L_423B:
	ld a,(0e1ddh)		;423b   ; subestado 0
	cp 005h		;423e
	call c,PINTA_LOGOTIPO		;4240   ; si la ronda de presentacion se corto pronto (E1DD < 5), 0x5DD5 pinta antes la linea de p09 0xAFF6 (el logotipo y "1987")
	ld de,0b000h		;4243   ; borra "PUSH SPACE KEY" (p09 0xB000) del sitio donde va a parpadear el otro rotulo  --> "(20)(9)PUSH SPACE KEY"
	call BORRA_ROTULO		;4246
	ld a,034h		;4249
	call 0884ch		;424b   ; p02 0x884C: la musica 0x34
	ld a,028h		;424e   ; 0x28 fotogramas de parpadeo y subestado 1
	jr L_4219		;4250
ESTADO_4:		; numera los dos bloques de coche y pasa al 5; no tiene subestados
	ld hl,0e250h		;4252   ; E250..E254 a cero: el subestado de la carrera y sus contadores
	ld bc,00004h		;4255
	call RELLENA_RAM_CERO		;4258
	ld ix,0e2c0h		;425b
	ld (ix+009h),001h		;425f   ; (ix+09) es el numero de jugador dentro del bloque de coche, y de el sale a que buffer de nombres pinta (E400 o EC00)
	ld ix,0e380h		;4263   ; el segundo coche vive en E380
	ld (ix+009h),002h		;4267
L_426B:
	ld a,020h		;426b   ; la salida comun de "estado siguiente": E1C4 = 0x20...
L_426D:
	ld (0e1c4h),a		;426d
	ld hl,0e1c0h		;4270   ; ...un estado mas...
	inc (hl)			;4273
L_4274:
	xor a			;4274   ; ...y a empezar por el subestado 0
	ld (0e1c1h),a		;4275
	ret			;4278
ESTADO_5:		; la carrera: 0x5A27 y su despachador de 32 entradas por (E250)
	jp PASO_DE_LA_CARRERA		;4279   ; el estado 5 es la carrera entera, del semaforo al final
TRAS_ESTADO_012:		; retorno empujado por 0x418C para los estados 0, 1 y 2: mira F006 y los mandos
	ld a,(0f006h)		;427c   ; F006 lo enciende el truco UJM3EDC de p01 0x74C4; con el puesto, la presentacion no atiende al mando (parece el modo de GRABAR demos: 0x58E2 y 0x5BCE escriben en el buffer que apunta F002, y el primero de la tabla de 0x5909 es 0xC000, o sea RAM) (?)
	or a			;427f
	ret nz			;4280
	call LEE_MANDO_1		;4281   ; el mando 1 se lee aqui aparte: en la presentacion LEE_ENTRADAS no lo toca, porque el bit 6 de E1C2 esta apagado
	ld hl,0e1e1h		;4284
	call FLANCOS		;4287   ; E1E1 = lo que hay pulsado ahora, E1E0 = lo que acaba de pulsarse; A vuelve con lo segundo
	or a			;428a
	ret z			;428b
	ld hl,0e1c0h		;428c
	ld de,0e1e2h		;428f
	ld b,(hl)			;4292   ; B = el estado; el djnz deja pasar al 1 y manda los estados 0 y 2 a 0x42AC
	djnz L_42AC		;4293
	and 030h		;4295   ; bits 4 y 5 = los dos botones, y la barra espaciadora entra por el bit 4 (0x4367)
	jr z,L_42B4		;4297
	ld a,(de)			;4299   ; E1E2 es el uno-o-dos-jugadores que se cambia con las direcciones en 0x42B4
	or a			;429a
	ld a,040h		;429b   ; 0x40 = un jugador, 0x60 = dos: el bit 6 abre la lectura del mando 1 y el bit 5 la del 2 (0x4335)
	jr z,L_42A1		;429d
	ld a,060h		;429f
L_42A1:
	ld (0e1c2h),a		;42a1
	ld (hl),003h		;42a4   ; al estado 3...
	inc hl			;42a6
	ld c,000h		;42a7   ; ...por su subestado 0
	ld (hl),c			;42a9
	dec c			;42aa   ; el `dec c` no lo lee nadie: de aqui se vuelve a la interrupcion (0x40AF)
	ret			;42ab
L_42AC:
	ld (hl),001h		;42ac   ; estados 0 y 2: cualquier tecla devuelve a la ronda de presentacion
	call 0869ah		;42ae   ; p02 0x869A calla la musica y 0x5D16 rehace el titulo desde cero
	jp PRESENTACION_MONTA_Y_PASO		;42b1
L_42B4:
	ld a,(de)			;42b4   ; sin boton, las direcciones cambian entre uno y dos jugadores
	xor 001h		;42b5
	ld (de),a			;42b7
	ret			;42b8
ARRANCA_SONIDO:		; pone a 1 los 16 bits de E17E/E17F para que 0x6CE9 de la pagina 13 vuelque TODOS los registros del SCC, restaura los bancos, deja el PSG R7 en 0xBF, pide el sonido 0x46 y vuelve a 1/2/3
	ld a,0ffh		;42b9   ; los 16 bits de E17E/E17F marcan "este registro del SCC ha cambiado": todos a 1 = volcado entero
	ld hl,0e17eh		;42bb
	ld (hl),a			;42be
	inc hl			;42bf
	ld (hl),a			;42c0
	di			;42c1
	ld hl,0f0f1h		;42c2   ; el mismo baile de bancos de la interrupcion, copiado byte a byte: aqui no hay interrupcion que lo haga
	ld a,00dh		;42c5
	ld (07000h),a		;42c7
	ld d,(hl)			;42ca
	ld (hl),a			;42cb
	inc hl			;42cc
	ld a,00eh		;42cd
	ld (09000h),a		;42cf
	ld e,(hl)			;42d2
	ld (hl),a			;42d3
	inc hl			;42d4
	ld a,00fh		;42d5
	ld (0b000h),a		;42d7
	ld a,(hl)			;42da   ; la misma pega que en 0x4042: la sombra de 0xA000 se queda con el valor viejo
	ld (hl),a			;42db
	push de			;42dc
	push af			;42dd
	call 06ce9h		;42de   ; p13 0x6CE9 escribe de una vez los 16 registros del SCC
	di			;42e1
	pop af			;42e2
	pop de			;42e3
	ld hl,0f0f3h		;42e4   ; y devuelve los tres bancos que habia
	ld (0b000h),a		;42e7
	ld (hl),a			;42ea
	dec hl			;42eb
	ld a,e			;42ec
	ld (09000h),a		;42ed
	ld (hl),a			;42f0
	dec hl			;42f1
	ld a,d			;42f2
	ld (07000h),a		;42f3
	ld (hl),a			;42f6
	ld a,0bfh		;42f7   ; registro 7 del PSG = 0xBF: tono y ruido callados y el puerto A como salida, que hace falta para elegir fila de teclado y mando
	ld (0e176h),a		;42f9   ; E176 es la copia en RAM de ese registro, y p13 0x6422 la reescribe en cada interrupcion
	ld e,a			;42fc
	ld a,007h		;42fd
	call 00093h		;42ff   ; BIOS WRTPSG - Writes data to PSG-register
	call MAPEA_D_E_F		;4302
	ld a,046h		;4305   ; el sonido 0x46 por p13 0x6000, con D/E/F puestas
	call 06000h		;4307
	jp MAPEA_1_2_3		;430a   ; y de vuelta al mapeo de siempre
L_430D:
	ld hl,00000h		;430d   ; los 16 KB de VRAM a cero: ninguna de las 16 paginas llama aqui, siempre se entra por 0x4317
	ld bc,04000h		;4310
	xor a			;4313
	call 00056h		;4314   ; BIOS FILVRM - Fills VRAM with value
VDP_REGISTROS:		; escribe R0..R7 desde la tabla de 0x4328
	ld hl,04328h		;4317   ; ocho registros seguidos, R0..R7, desde la tabla
	ld d,008h		;431a
	ld c,000h		;431c
L_431E:
	ld b,(hl)			;431e   ; B = el valor y C = el numero de registro, que es lo que pide WRTVDP
	call 00047h		;431f   ; BIOS WRTVDP - Writes data in the VDP-register
	inc hl			;4322
	inc c			;4323
	dec d			;4324
	jr nz,L_431E		;4325
	ret			;4327

; ----------------------------------------------------------------------
; DATOS tabla_vdp: los ocho registros del VDP: R0=02 (G2), R1=E2, R2=0E
;   (nombres 0x3800), R3=7F (colores 0x0000), R4=07 (patrones 0x2000), R5=76
;   (atributos de sprites 0x3B00), R6=03 (patrones de sprites 0x1800), R7=E4
;   (fondo azul oscuro)
;   0x4328..0x4330  (8 bytes)
DATA_tabla_vdp:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e4h	; 4328  .....v..

; ======================================================================
; CODIGO 0x4330..0x4961  (1585 bytes)
; ======================================================================


VDP_REG_7:		; solo el registro 7 (color de texto y borde) con el valor en B; 0x5CBE lo usa con 0xE0 para dejar el borde negro
	ld c,007h		;4330   ; el unico registro que se retoca suelto
	jp VDP_REG		;4332

; ----------------------------------------------------------------------
; Las entradas. Todo el juego las lee por aqui, una vez por paso de
; logica (0x40A4). Un mando es UN byte con el reparto de bits del
; PSG: 0 arriba, 1 abajo, 2 izquierda, 3 derecha, 4 boton A, 5 boton
; B. Las teclas se cuelan en esos mismos bits, asi que de aqui en
; adelante nadie distingue si el jugador va con mando o con teclado,
; y las dos cosas a la vez se suman.
; El teclado del jugador 1 son los cursores, el ESPACIO como boton A
; y la M o la N como boton B; el del jugador 2, W A S D con SHIFT y
; CTRL. Cada entrada guarda dos bytes seguidos en RAM: lo que hay
; pulsado AHORA y, en el byte de antes, lo que ACABA de pulsarse.
; Son E1D9/E1D8 las teclas de funcion, E1C9/E1C8 el mando 1 y
; E1CC/E1CB el mando 2.
; ----------------------------------------------------------------------
LEE_ENTRADAS:		; teclas F, mando 1 (E1D9/E1D8 ahora/flancos) y, si E1C2 lo pide, mando 2 (E1CC)
	call LEE_TECLAS_F		;4335   ; las cinco teclas de funcion se leen siempre; los mandos, solo si E1C2 lo pide
	ld hl,0e1d9h		;4338   ; E1D9 = F1..F5 ahora, E1D8 = las que acaban de pulsarse
	call FLANCOS		;433b
	ld a,(0e1c2h)		;433e   ; bit 6 de E1C2 = hay jugador 1. Apagado -y en la presentacion lo esta- aqui se acaba la rutina
	and 040h		;4341
	ret z			;4343
	call LEE_MANDO_1		;4344   ; el mando 1 a E1C9, y sus flancos a E1C8
	call FLANCOS_E1C9		;4347
	ld a,(0e1c2h)		;434a   ; bit 5 de E1C2 = hay jugador 2
	and 020h		;434d
	ret z			;434f
	call LEE_MANDO_2		;4350
	ld hl,0e1cch		;4353   ; E1CC lo de ahora, E1CB los flancos
	jr FLANCOS		;4356   ; `jr` y no `call`: el `ret` de FLANCOS es el que cierra LEE_ENTRADAS
FLANCOS_E1CC:		; flancos del mando 2
	ld hl,0e1cch		;4358   ; aqui entra LA DEMO: 0x589A le pasa el byte grabado del mando 2 (F005) y 0x5894 hace lo mismo con el del mando 1 por 0x435D. La partida grabada mueve el juego por la misma puerta que los mandos de verdad
	jr FLANCOS		;435b
FLANCOS_E1C9:		; flancos en E1C9/E1C8
	ld hl,0e1c9h		;435d   ; y la del mando 1
FLANCOS:		; (hl) = A; (hl-1) = bits que acaban de pulsarse
	ld c,(hl)			;4360   ; C = lo que habia en el paso anterior...
	ld (hl),a			;4361   ; ...y (hl) pasa a ser lo de ahora
	xor c			;4362   ; los bits que han cambiado...
	and (hl)			;4363   ; ...y de esos, los que ahora valen 1: el flanco de PULSAR. Soltar no deja rastro
	dec hl			;4364
	ld (hl),a			;4365   ; los flancos van en el byte de ANTES, por eso las dos parejas estan pegadas en RAM
	ret			;4366
LEE_MANDO_1:		; joystick 1 por el PSG (0x43EC) mas cursores y espacio del teclado (filas 8 y 4)
	call LEE_JOY_PSG		;4367   ; primero el joystick del puerto 1
	ld e,a			;436a   ; E se queda con lo del joystick y las teclas se van sumando encima
	ld a,004h		;436b   ; fila 4 de la matriz del teclado: K L M N O P Q R
	call 00141h		;436d   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 00ch		;4370   ; bits 2 y 3 = M y N; el `xor` deja cero solo si NINGUNA de las dos esta pulsada
	xor 00ch		;4372
	jr z,MANDO_1_TECLADO		;4374
	set 5,e		;4376   ; cualquiera de las dos hace de boton B
MANDO_1_TECLADO:		; la fila 8 (espacio y cursores) repartida a los bits del mando con rotaciones
	ld a,008h		;4378   ; fila 8: ESPACIO, HOME, INS, DEL y los cuatro cursores
	call 00141h		;437a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;437d   ; en la matriz un cero es tecla pulsada: `cpl` y a partir de aqui se trabaja con unos
	rrca			;437e   ; dos rotaciones y una mascara por grupo de bits. B guarda el valor rotado para la vuelta siguiente, asi la fila se lee UNA vez y no cuatro
	rrca			;437f
	ld b,a			;4380
	and 004h		;4381   ; izquierda: del bit 4 de la fila al bit 2, que es el suyo en el mando
	or e			;4383
	ld c,a			;4384
	ld a,b			;4385
	rrca			;4386   ; dos rotaciones mas
	rrca			;4387
	ld b,a			;4388
	and 018h		;4389   ; derecha al bit 3 y ESPACIO al bit 4, o sea que el espacio es el boton A
	or c			;438b
	ld c,a			;438c
	ld a,b			;438d
	rrca			;438e   ; y una mas
	and 003h		;438f   ; arriba al bit 0 y abajo al bit 1
	or c			;4391
	or e			;4392   ; encima de lo que dijera el joystick: mando y teclado se suman, no se elige uno
	ret			;4393
LEE_MANDO_2:		; joystick 2 por el PSG (E=0xCF) mas teclas de las filas 6, 3, 2 y 5
	ld e,0cfh		;4394   ; 0xCF y no 0x8F: el bit 6 del registro 15 del PSG es el que elige puerto de mando, y este es el segundo
	call LEE_JOY_PSG_E		;4396
	ld e,a			;4399   ; las teclas del jugador 2 no son las del 1: W A S D con SHIFT y CTRL
	ld a,006h		;439a   ; fila 6: SHIFT, CTRL, GRAPH, CAPS, CODE, F1, F2, F3
	call 00141h		;439c   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;439f
	and 003h		;43a0   ; SHIFT y CTRL, que estan en los bits 0 y 1...
	add a,a			;43a2   ; ...cuatro veces por dos, o sea al bit 4 (boton A) y al bit 5 (boton B)
	add a,a			;43a3
	add a,a			;43a4
	add a,a			;43a5
	or e			;43a6
	ld e,a			;43a7
	ld a,003h		;43a8   ; fila 3: C D E F G H I J
	call 00141h		;43aa   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;43ad   ; la D, al bit 3: derecha
	jr nz,MANDO_2_IZQUIERDA		;43af
	set 3,e		;43b1
MANDO_2_IZQUIERDA:		; la A de la fila 2
	ld a,002h		;43b3   ; fila 2: apostrofe, acento, coma, punto, barra, subrayado, A y B
	call 00141h		;43b5   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 6,a		;43b8   ; la A, al bit 2: izquierda
	jr nz,MANDO_2_ABAJO		;43ba
	set 2,e		;43bc
MANDO_2_ABAJO:		; la S de la fila 5
	ld a,005h		;43be   ; fila 5: S T U V W X Y Z
	call 00141h		;43c0   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 0,a		;43c3   ; la S, al bit 1: abajo
	jr nz,MANDO_2_ARRIBA		;43c5
	set 1,e		;43c7
MANDO_2_ARRIBA:		; la W, de la misma fila 5
	bit 4,a		;43c9   ; y de la misma fila la W, al bit 0: arriba
	jr nz,MANDO_2_DEVUELVE		;43cb
	set 0,e		;43cd
MANDO_2_DEVUELVE:		; A = el byte del mando 2 ya montado
	ld a,e			;43cf   ; el resultado sale en A, como el del mando 1
	ret			;43d0
LEE_TECLAS_F:		; F1..F5 en los bits 0..4 (filas 7 y 6 del teclado)
	ld a,007h		;43d1   ; fila 7: F4, F5, ESC, TAB, STOP, BS, SELECT y RETURN
	call 00141h		;43d3   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;43d6
	and 003h		;43d7   ; F4 y F5, que estan en los bits 0 y 1...
	add a,a			;43d9   ; ...tres veces por dos: a los bits 3 y 4
	add a,a			;43da
	add a,a			;43db
	push af			;43dc   ; y a la pila, que hace falta A para la otra fila
	ld a,006h		;43dd   ; fila 6: F1, F2 y F3 ocupan los bits 5, 6 y 7
	call 00141h		;43df   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;43e2
	rlca			;43e3   ; tres rotaciones a la IZQUIERDA los bajan a los bits 0, 1 y 2
	rlca			;43e4
	rlca			;43e5
	and 007h		;43e6
	ld d,a			;43e8
	pop af			;43e9
	or d			;43ea   ; F1 a F5 en los bits 0 a 4, en orden
	ret			;43eb
LEE_JOY_PSG:		; E=0x8F: joystick 1; entra en 0x43EE con E=0xCF para el 2
	ld e,08fh		;43ec   ; 0x8F: bit 6 a cero (puerto de mando 1) y las salidas del PSG en alto
LEE_JOY_PSG_E:		; PSG R15=E, lee R14, invierte, 6 bits
	ld a,00fh		;43ee   ; el registro 15 del PSG elige que puerto de mando se va a leer...
	call 00093h		;43f0   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;43f3   ; ...y el 14 lo devuelve
	di			;43f5   ; `di` alrededor de la lectura: la interrupcion tambien escribe en el PSG (p13 0x6422) y dejaria el registro 15 apuntando a otro sitio entre la escritura y la lectura
	call 00096h		;43f6   ; BIOS RDPSG - Reads value from PSG-register
	ei			;43f9
	cpl			;43fa   ; en el PSG el cero es "pulsado"
	and 03fh		;43fb   ; seis bits: cuatro direcciones y dos botones
	ret			;43fd

; ----------------------------------------------------------------------
; Las rutinas de banco. El mapper Konami SCC: escribir N en 0x7000,
; 0x9000 o 0xB000 pone la pagina N en 0x6000, 0x8000 o 0xA000 (0x5000
; nunca se toca: la pagina 0 es fija). Cada escritura se apunta en la
; sombra F0F1/F0F2/F0F3. Las paginas van siempre en grupos de tres
; consecutivas (1/2/3, 4/5/6, 7/8/9, A/B/C, D/E/F), y sueltas solo a
; la ranura que les toca por su numero: tools/paginas.py.
; ----------------------------------------------------------------------
MAPEA_1_2_3:		; 1/2/3 en 6000/8000/A000: el mapeo "por defecto"
	di			;43fe   ; el `di` no es opcional: la interrupcion cambia los tres bancos por su cuenta (0x4029) y volveria con otros puestos
	push hl			;43ff   ; HL se respeta, que es con el que anda por las tablas quien llama
	ld hl,0f0f1h		;4400   ; F0F1 es la sombra de 0x6000, F0F2 la de 0x8000 y F0F3 la de 0xA000
	ld a,001h		;4403
	ld (07000h),a		;4405   ; escribir en 0x7000 es lo que mueve el banco de 0x6000; el mapper mira el bloque, no la direccion exacta
	ld (hl),a			;4408   ; y la sombra se entera del cambio
	inc a			;4409   ; 1, 2 y 3 van seguidas: un `inc a` por ranura
	ld (09000h),a		;440a
	inc hl			;440d
	ld (hl),a			;440e
	inc a			;440f
	ld (0b000h),a		;4410
	inc hl			;4413
	ld (hl),a			;4414
	pop hl			;4415
	ei			;4416   ; aqui se vuelven a abrir las interrupciones, y eso es lo que hace reentrante a la logica del juego: ver el bloque de 0x4018
	ret			;4417
MAPEA_4_5_6:		; 4/5/6 por 0x441B
	di			;4418   ; este `di` lo repite el de 0x441B: entrar por aqui o por alla da igual
	ld a,004h		;4419
MAPEA_DESDE_A:		; A, A+1, A+2 en 6000/8000/A000
	di			;441b   ; la version generica: A, A+1 y A+2. Las cinco entradas de arriba solo ponen el numero y caen aqui
	push hl			;441c
	ld hl,0f0f1h		;441d   ; los tres bytes de la sombra van seguidos...
	ld (07000h),a		;4420
	ld (hl),a			;4423
	inc l			;4424   ; ...asi que basta `inc l`: F0F1 a F0F3 no cruzan pagina
	inc a			;4425
	ld (09000h),a		;4426   ; la segunda ranura, 0x8000
	ld (hl),a			;4429
	inc l			;442a
	inc a			;442b
	ld (0b000h),a		;442c   ; y la tercera, 0xA000. Esta SI deja bien la sombra, al reves que la copia de la interrupcion (0x4042)
	ld (hl),a			;442f
	pop hl			;4430
	ei			;4431   ; con `ei`, como todas
	ret			;4432
MAPEA_1_2_3_B:		; como 0x43FE pero por 0x441B
	di			;4433   ; hace lo mismo que 0x43FE en cinco bytes en vez de veintiseis; las dos estan vivas y las dos se llaman
	ld a,001h		;4434
	jr MAPEA_DESDE_A		;4436
MAPEA_7_8_9:		; 7/8/9 por 0x441B
	di			;4438
	ld a,007h		;4439   ; 7/8/9: la que trae las secuencias de circuito (p07) y sus dos vecinas
	jr MAPEA_DESDE_A		;443b
MAPEA_A_B_C:		; A/B/C por 0x441B
	di			;443d
	ld a,00ah		;443e   ; A/B/C: las tablas de piezas y de metatiles (p10 a p12)
	jr MAPEA_DESDE_A		;4440
MAPEA_D_E_F:		; la pagina del sonido (13) y las 14 y 15
	di			;4442
	ld a,00dh		;4443   ; D/E/F: el motor de sonido (p13) y los datos residentes (p15)
	jr MAPEA_DESDE_A		;4445
MAPEA_A_EN_8000:		; A en 8000 y A+1 en A000
	di			;4447   ; esta pareja no toca 0x6000 y no necesita HL: escribe la sombra por direccion
	ld (0f0f2h),a		;4448
	ld (09000h),a		;444b
	inc a			;444e   ; A y A+1, en ese orden: quien llama pide un par consecutivo
	ld (0f0f3h),a		;444f
	ld (0b000h),a		;4452
	ei			;4455   ; y a soltar las interrupciones
	ret			;4456
MAPEA_A_EN_A000:		; A en A000 (la llaman las paginas 1 y 2)
	di			;4457
	ld (0f0f3h),a		;4458   ; solo la ranura de 0xA000: es la unica que las paginas 1 y 2 pueden cambiar sin quedarse ellas mismas sin sitio
	ld (0b000h),a		;445b
	ei			;445e
	ret			;445f
LIMPIA_EA80_Y_ATRIBUTOS:		; borra 0x80 bytes de RAM desde EA80 (con 0xE0) y los atributos de sprites (0x3B00, 0x80 bytes a 0xE0 = fuera de pantalla). El BC de 0x7F no enganna: RELLENA_RAM siembra el primer byte con `ld (hl),a` y el `ldir` copia otros BC, o sea EA80..EAFF
	ld hl,0ea80h		;4460   ; EA80 es la copia en RAM de los atributos de sprites, la que vuelca 0x477C en cada repintado
	ld bc,0007fh		;4463
	ld a,0e0h		;4466   ; 0xE0 en los cuatro bytes de las 32 entradas. Como Y, 224: con sprites de 16x16 y sin ampliar (R1 = 0xE2) ninguno asoma por las 192 lineas de pantalla
	call RELLENA_RAM		;4468
	ld hl,03b00h		;446b   ; y lo mismo en la VRAM, para que no se vea nada hasta el vuelco siguiente
	ld bc,00080h		;446e
	jp 00056h		;4471   ; BIOS FILVRM - Fills VRAM with value
TILES_16_58_F0:		; como 0x4476 con A=0xF0, y ese 0xF0 es el COLOR, no el patron: cae en 0x4476, que llena los COLORES de los tiles 16..58 con A y trae los patrones del RLE de p15 0xB777. La nota anterior decia "patrones llenos de 0xF0" y su propia vecina de 0x4476 ya lo desmentia
	ld a,0f0h		;4474   ; 0xF0 como byte de color es tinta 15 sobre fondo 0: blanco sobre transparente
TILES_16_58_A:		; mapea D/E/F, llena los colores de los tiles 16..58 con A, trae sus patrones de p15:0xB777 (RLE) y vuelve a 1/2/3
	push af			;4476   ; A es el color y hay que salvarlo: MAPEA_D_E_F lo usa
	call MAPEA_D_E_F		;4477   ; los patrones estan en la pagina 15, o sea hay que ponerla en 0xA000
	pop af			;447a
	call COLORES_16_58_A		;447b   ; primero el color de los 43 tiles y despues sus patrones
	call PATRONES_16_DESDE_B777		;447e
	jp MAPEA_1_2_3		;4481   ; `jp`: el `ret` de MAPEA_1_2_3 es el que cierra la rutina
PATRONES_16_DESDE_B777:		; descomprime (RLE) p15:0xB777 en los patrones desde el tile 16 (VRAM 0x2080), 3 tercios
	ld de,0b777h		;4484   ; p15:0xB777, comprimido con el RLE de 0x4862
	ld hl,02080h		;4487   ; VRAM 0x2080 = el patron del tile 16 (0x2000 + 16*8)
	jp RLE_VRAM_3_TERCIOS		;448a
COLORES_16_58_A:		; llena 0x158 bytes de la tabla de colores desde el tile 16 (VRAM 0x0080) con A, 3 tercios
	ld hl,00080h		;448d   ; VRAM 0x0080 = el color del tile 16
	ld bc,00158h		;4490   ; 0x158 bytes son 43 tiles de 8, o sea del 16 al 58
	jp LLENA_VRAM_3_TERCIOS		;4493
TILES_0_15_MACIZOS:		; mapea D/E/F; patrones de los tiles 0..15 a cero y el color del tile i = i (fondo del color i): 16 bloques macizos, 3 tercios; vuelve a 1/2/3
	call MAPEA_D_E_F		;4496   ; aqui NO se lee nada de la pagina 15: entre este `call` y el `jp` del final solo hay escrituras a la VRAM por la BIOS. Es el mismo par de llamadas que en 0x4476, que si lo necesita
	ld hl,02000h		;4499   ; los patrones de los tiles 0 a 15, a cero: en el tile no queda un solo pixel de tinta
	ld bc,00080h		;449c
	xor a			;449f   ; y como el patron es todo ceros, el que manda es el nibble BAJO del byte de color
	call LLENA_VRAM_3_TERCIOS		;44a0
	ld hl,00000h		;44a3
	ld de,00008h		;44a6
	ld b,010h		;44a9   ; dieciseis tiles
BUCLE_TILES_0_15:		; un tile por vuelta: 8 bytes de color A (= indice) en VRAM HL, HL += 8
	push bc			;44ab   ; B lleva la cuenta de tiles y BC el tamano de la llenada: hay que guardarlo
	ld bc,00008h		;44ac   ; ocho bytes = las ocho filas de un tile
	push hl			;44af
	call LLENA_VRAM_3_TERCIOS		;44b0   ; en los tres tercios, que en la pantalla 2 cada uno tiene su propia tabla de color
	pop hl			;44b3
	add hl,de			;44b4   ; el tile siguiente, ocho bytes mas alla
	inc a			;44b5   ; y su color es su propio numero: el tile 5 sale macizo del color 5
	pop bc			;44b6
	djnz BUCLE_TILES_0_15		;44b7
	jp MAPEA_1_2_3		;44b9
VUELCA_NOMBRES_E400:		; copia los 768 bytes del buffer de pantalla E400 a la tabla de nombres (0x3800)
	ld hl,0e400h		;44bc   ; E400 es el buffer de nombres del jugador 1
	jr VUELCA_768_A_NOMBRES		;44bf
VUELCA_NOMBRES_EC00:		; la gemela con el buffer del jugador 2; la llaman p01 0x7D19 y 0x7D33 (la escena de meta)
	ld hl,0ec00h		;44c1   ; y EC00 el del jugador 2
VUELCA_768_A_NOMBRES:		; HL = buffer de RAM; SETWRT 0x3800 y 3 x 256 bytes por el puerto del VDP
	push hl			;44c4
	ld hl,03800h		;44c5   ; 0x3800 es la tabla de nombres entera, 24 filas de 32
	call PREPARA_ESCRITURA_VRAM		;44c8   ; SETWRT y, de paso, el puerto de datos del VDP en el C del OTRO juego de registros
	pop hl			;44cb
	exx			;44cc
	ld a,c			;44cd   ; y estas cuatro instrucciones lo traen al C de este, porque el vuelco no juega con los dos juegos
	exx			;44ce
	ld c,a			;44cf
	call OUT_256_VRAM		;44d0   ; 768 bytes son tres vueltas de 256, y la tercera es la caida a 0x44D6
	call OUT_256_VRAM		;44d3
OUT_256_VRAM:		; 256 bytes desde (HL) al puerto del VDP (C' lo dejo 0x4673)
	ld b,000h		;44d6   ; B = 0 son 256 vueltas
OUT_256_BUCLE:		; un byte por vuelta
	ld a,(hl)			;44d8   ; un byte por vuelta y sin escribir en la VRAM la direccion: la deja el SETWRT y la va subiendo el propio VDP
	inc hl			;44d9
	out (c),a		;44da
	djnz OUT_256_BUCLE		;44dc
	ret			;44de

; ----------------------------------------------------------------------
; El repintado de la pista, lo que llama la interrupcion en 0x40C7.
; Cada jugador tiene en RAM un buffer de nombres de 1 KB -E400 el
; jugador 1 y EC00 el 2- que es un mapa de 32 x 32 casillas CIRCULAR
; en los dos sentidos: la pista se va escribiendo ahi fila a fila
; (0x564C) y de ahi se copia a la VRAM la ventana que toque.
;
; La casilla por la que empieza la ventana la da 0x4A9D: fila =
; (iy+40) / 8 y columna = (ix+54) / 8, o sea la camara en pixeles
; partida por el tamano del tile, las dos modulo 32.
;
; 0x45F7 vuelca UNA fila de la ventana, quince casillas con `outi`.
; Las dos vueltas del mapa estan ahi: si el puntero llega al final de
; su fila de 32 bytes, 0x4656 lo hace retroceder 32 -la vuelta
; horizontal-; y al acabar, la fila siguiente es HL + 0x20, con `res
; 2,h / inc h / set 2,h` para no salirse del kilobyte -la vertical-.
;
; Con un jugador la ventana son 15 columnas x 24 filas desde 0x3802,
; o sea la columna 2, los pixeles 16 a 135; y es tambien el
; x desde 16 y 118 pixeles de ancho.
; Con dos, la pantalla va partida y DESPLAZADA: el jugador 2 ocupa
; las columnas 0..14 en las filas 0..20, el jugador 1 las columnas
; 17..31 en las filas 3..23, y entre los dos van las columnas 15 y
; 16 con una barra que sale de una tabla de 18 bytes de p15:0xB764
; (00 DE, trece F7, E3, 00, 00). Los dos huecos que quedan -arriba a
; la derecha y abajo a la izquierda- son los marcadores.
; ----------------------------------------------------------------------
VENTANA_JUGADOR_2:		; la ventana de un jugador pero con el bloque del coche 2 (E380) y el buffer EC00; la llaman 0x520A y 0x5C5C
	ld iy,0e380h		;44df   ; el bloque del segundo coche, que es el que mueven las escenas fijas (0x5755)
	ld de,00000h		;44e3   ; D = 0 es la columna 0 y E = 0 no desplaza la fila: esta ventana NO sigue a la camara horizontal, arranca siempre por el principio de la fila
	ld (iy+009h),002h		;44e6   ; (iy+9) = 2 fuerza el buffer EC00 en 0x4A9D, que es donde pintan esas escenas
	ld ix,0e380h		;44ea
	call CASILLA_BUFFER_NOMBRES		;44ee   ; la casilla del buffer por la que empieza la ventana
	jr VENTANA_1_JUGADOR		;44f1   ; y de ahi en adelante, la ventana de un jugador de siempre
BORRA_VENTANA_PISTA:		; pone a cero las 15 columnas x 24 filas de la ventana de un jugador (desde 0x3802); la llaman p02 0x91F1 y 0x9263
	ld b,018h		;44f3   ; 24 filas, la pantalla entera de alto
	ld hl,03802h		;44f5   ; 0x3802: fila 0, columna 2, la esquina de la ventana
BORRA_VENTANA_FILA:		; una fila de la ventana por vuelta
	call PREPARA_ESCRITURA_VRAM		;44f8   ; SETWRT en la fila, y el puerto de datos queda en el C del otro juego de registros
	ld de,00020h		;44fb   ; la fila siguiente, 32 casillas mas alla
	add hl,de			;44fe
	exx			;44ff   ; al juego donde esta el puerto
	ld b,01eh		;4500
	xor a			;4502
BORRA_VENTANA_BUCLE:		; una casilla por vuelta
	out (c),a		;4503   ; el cero que borra la casilla
	dec b			;4505   ; este `dec b` no es un descuido: con el `djnz` B baja DOS veces por vuelta, asi que 0x1E son 15 casillas y no 30, justo el ancho de la ventana. Y de paso mete cuatro estados entre `out` y `out`: con el `out` a 12 y el `djnz` a 13 salen 29, que es lo que el VDP pide entre dos bytes (?)
	djnz BORRA_VENTANA_BUCLE		;4506
	exx			;4508   ; y de vuelta al juego que lleva la direccion de VRAM
	djnz BORRA_VENTANA_FILA		;4509
	ret			;450b
PINTA_VENTANA_PISTA:		; la ventana de la pista a la tabla de nombres: con un jugador 15 x 24 desde 0x3802 (0x4523), con dos la pantalla partida (0x4538)
	ld hl,0e1c2h		;450c   ; bit 5 de E1C2: si hay jugador 2, la pantalla va partida
	bit 5,(hl)		;450f
	jr nz,VENTANA_2_JUGADORES		;4511
	ld ix,0e2c0h		;4513   ; con uno solo manda el bloque del coche 1 (E2C0), que es tambien la camara
	ld iy,0e2c0h		;4517
	ld d,(ix+054h)		;451b   ; D = (ix+54), la camara en pixeles: 0x4A9D se queda con la columna, que es D / 8
	ld e,000h		;451e   ; E = 0: la fila es (iy+40) / 8 sin desplazar
	call CASILLA_BUFFER_NOMBRES		;4520   ; HL = la casilla del buffer por la que empieza la ventana
VENTANA_1_JUGADOR:		; 24 filas de 15 casillas desde 0x3802: el juego principal lleva el puntero del buffer y el alterno la direccion de VRAM
	exx			;4523   ; se cambia de juego de registros: HL' llevara la VRAM y HL el buffer
	ld b,018h		;4524   ; 24 filas
	ld hl,03802h		;4526   ; fila 0, columna 2
VENTANA_FILA:		; una fila de la ventana por vuelta
	call PREPARA_ESCRITURA_VRAM		;4529   ; SETWRT con HL' y, desde dentro, el puerto en el C del juego principal
	ld de,00020h		;452c   ; la fila de VRAM siguiente, 32 casillas mas alla
	add hl,de			;452f
	exx			;4530   ; al juego principal, el que lleva el buffer
	call VUELCA_FILA_VENTANA		;4531   ; y ahi van las 15 casillas de esta fila
	exx			;4534
	djnz VENTANA_FILA		;4535
	ret			;4537
VENTANA_2_JUGADORES:		; pantalla partida: el coche 2 (E380) a la izquierda -columnas 0..14, filas 0..20-, el coche 1 (E2C0) a la derecha -columnas 17..31, filas 3..23- y entre ellos la barra de p15:0xB764
	ld a,(00007h)		;4538   ; el puerto de datos del VDP (el byte 7 de la BIOS)...
	ld c,a			;453b
	exx			;453c   ; ...y se deja en el C de LOS DOS juegos de registros, porque aqui se salta de uno a otro en cada fila
	ld c,a			;453d
	exx			;453e
	ld hl,03800h		;453f   ; la esquina de arriba a la izquierda: en la pantalla partida no sobra ni una columna
	call 00053h		;4542   ; BIOS SETWRT - Enables VDP to write
	ld ix,0e2c0h		;4545   ; el juego principal se queda con la casilla del coche 1
	ld iy,0e2c0h		;4549
	ld d,(ix+054h)		;454d
	ld e,000h		;4550
	call CASILLA_BUFFER_NOMBRES		;4552
	exx			;4555   ; y el alterno con la del coche 2
	ld ix,0e380h		;4556
	ld iy,0e380h		;455a
	ld d,(ix+054h)		;455e
	ld e,000h		;4561
	call CASILLA_BUFFER_NOMBRES		;4563
	call VUELCA_FILA_VENTANA		;4566   ; las filas 0, 1 y 2 son solo del jugador 2: encima de la mitad derecha va su marcador
	push hl			;4569
	ld hl,03820h		;456a
	call 00053h		;456d   ; BIOS SETWRT - Enables VDP to write
	pop hl			;4570
	call VUELCA_FILA_VENTANA		;4571
	push hl			;4574
	ld hl,03840h		;4575
	call 00053h		;4578   ; BIOS SETWRT - Enables VDP to write
	pop hl			;457b
	call VUELCA_FILA_VENTANA		;457c
	push hl			;457f
	ld hl,03860h		;4580   ; de la fila 3 solo se deja hecho el SETWRT: la vuelca ya el bucle de abajo, que escribe la fila entera
	call 00053h		;4583   ; BIOS SETWRT - Enables VDP to write
	pop hl			;4586
	ld ix,0b764h		;4587   ; la barra que separa las dos mitades: 18 bytes en la pagina 15, uno por fila. Cuando esto corre, D/E/F estan mapeadas -la interrupcion las deja puestas en 0x4049 y el otro llamador, 0x4BE9, llama antes a MAPEA_D_E_F-, asi que 0xB764 es p15 y no p03
	call FILA_PARTIDA		;458b   ; dieciocho filas enteras de 32 casillas, de la 3 a la 20
	call FILA_PARTIDA		;458e
	call FILA_PARTIDA		;4591
	call FILA_PARTIDA		;4594
	call FILA_PARTIDA		;4597
	call FILA_PARTIDA		;459a
	call FILA_PARTIDA		;459d
	call FILA_PARTIDA		;45a0
	call FILA_PARTIDA		;45a3
	call FILA_PARTIDA		;45a6
	call FILA_PARTIDA		;45a9
	call FILA_PARTIDA		;45ac
	call FILA_PARTIDA		;45af
	call FILA_PARTIDA		;45b2
	call FILA_PARTIDA		;45b5
	call FILA_PARTIDA		;45b8
	call FILA_PARTIDA		;45bb
	call FILA_PARTIDA		;45be
	exx			;45c1   ; al juego del coche 1: le faltan tres filas por abajo
	push hl			;45c2
	ld hl,03ab1h		;45c3   ; 0x3AB1 es la fila 21, columna 17; luego la 22 y la 23. Debajo de la mitad izquierda va el otro marcador
	call 00053h		;45c6   ; BIOS SETWRT - Enables VDP to write
	pop hl			;45c9
	call VUELCA_FILA_VENTANA		;45ca
	push hl			;45cd
	ld hl,03ad1h		;45ce
	call 00053h		;45d1   ; BIOS SETWRT - Enables VDP to write
	pop hl			;45d4
	call VUELCA_FILA_VENTANA		;45d5
	push hl			;45d8
	ld hl,03af1h		;45d9
	call 00053h		;45dc   ; BIOS SETWRT - Enables VDP to write
	pop hl			;45df
	jp VUELCA_FILA_VENTANA		;45e0   ; la ultima por `jp`: el `ret` de 0x45F7 cierra la rutina
FILA_PARTIDA:		; una fila entera de la pantalla partida: 15 casillas del jugador 2, la barra dos veces y 15 del jugador 1
	call VUELCA_FILA_VENTANA		;45e3   ; la mitad izquierda, con el juego de registros que viene puesto
	ld a,(ix+000h)		;45e6   ; el trozo de barra que le toca a esta fila
	out (c),a		;45e9
	nop			;45eb   ; entre las dos escrituras van dos `nop` y el `inc ix`: avanzan la tabla y ademas separan los dos `out` 18 estados, que con los 12 del propio `out` son los 30 que necesita el VDP (?)
	nop			;45ec
	inc ix		;45ed
	out (c),a		;45ef   ; el mismo byte en las dos columnas: la barra es igual de ancha en todas las filas
	exx			;45f1   ; se cambia de coche...
	call VUELCA_FILA_VENTANA		;45f2   ; ...y va la mitad derecha
	exx			;45f5   ; y el juego se deja como estaba, que el bucle de arriba cuenta con ello
	ret			;45f6
VUELCA_FILA_VENTANA:		; 15 casillas desde (HL) al puerto del VDP, dando la vuelta por la izquierda al llegar al final de la fila de 32 del buffer; al salir HL apunta a la fila siguiente, tambien con vuelta
	push hl			;45f7   ; HL vuelve a salir del final: la fila siguiente se cuenta desde donde se entro, no desde donde acabo el vuelco
	ld a,l			;45f8   ; los cinco bits bajos de L son la columna dentro de la fila de 32...
	and 01fh		;45f9
	cpl			;45fb   ; ...y `cpl` mas 0x21 los convierte en 32 - columna, o sea lo que falta para el final de la fila
	add a,021h		;45fc
	ld b,a			;45fe   ; ese es el B de los `outi`
	outi		;45ff   ; quince `outi` desenrollados, uno por casilla: quince es el ancho de la ventana
	call z,RETROCEDE_FILA_BUFFER		;4601   ; el `outi` deja Z cuando B llega a cero, que es justo al pasarse del final de la fila; entonces 0x4656 retrocede las 32 casillas y la ventana da la vuelta por la izquierda. Solo puede saltar una vez, porque el `outi` siguiente deja B en 0xFF
	outi		;4604
	call z,RETROCEDE_FILA_BUFFER		;4606
	outi		;4609
	call z,RETROCEDE_FILA_BUFFER		;460b
	outi		;460e
	call z,RETROCEDE_FILA_BUFFER		;4610
	outi		;4613
	call z,RETROCEDE_FILA_BUFFER		;4615
	outi		;4618
	call z,RETROCEDE_FILA_BUFFER		;461a
	outi		;461d
	call z,RETROCEDE_FILA_BUFFER		;461f
	outi		;4622
	call z,RETROCEDE_FILA_BUFFER		;4624
	outi		;4627
	call z,RETROCEDE_FILA_BUFFER		;4629
	outi		;462c
	call z,RETROCEDE_FILA_BUFFER		;462e
	outi		;4631
	call z,RETROCEDE_FILA_BUFFER		;4633
	outi		;4636
	call z,RETROCEDE_FILA_BUFFER		;4638
	outi		;463b
	call z,RETROCEDE_FILA_BUFFER		;463d
	outi		;4640
	call z,RETROCEDE_FILA_BUFFER		;4642
	outi		;4645
	call z,RETROCEDE_FILA_BUFFER		;4647
	pop hl			;464a   ; la casilla por la que se entro
	ld a,020h		;464b   ; 32 casillas mas abajo: la fila siguiente del buffer
	add a,l			;464d
	ld l,a			;464e
	ret nc			;464f   ; sin acarreo no se ha salido del bloque de 256 y no hay nada mas que hacer
	res 2,h		;4650   ; y con acarreo, esto sube H sin salirse del kilobyte: E4 a E5 a E6 a E7 y otra vez E4, o EC a ED a EE a EF y otra vez EC. El bit 2 de H vale 1 en las dos bases, asi que borrarlo, sumar uno y volver a ponerlo es sumar 1 modulo 4 a los dos bits de abajo
	inc h			;4652
	set 2,h		;4653
	ret			;4655
RETROCEDE_FILA_BUFFER:		; HL -= 32: la vuelta horizontal dentro de la fila del buffer
	ld de,0ffe0h		;4656   ; -32 en complemento a dos, que no hay `sub hl,de`
	add hl,de			;4659
	ret			;465a
BORRA_SPRITES_Y_NOMBRES:		; deja la pantalla en blanco: los atributos de sprites de RAM a 0xE0, el sprite 0 con Y = 0xD0 (que apaga TODOS) y la tabla de nombres a cero
	ld a,0e0h		;465b   ; 0xE0 en los 128 bytes de EA80: los sprites, aparcados por debajo de la pantalla
	ld hl,0ea80h		;465d
	ld bc,0007fh		;4660
	call RELLENA_RAM		;4663
	call APAGA_TODOS_LOS_SPRITES		;4666   ; y ademas Y = 0xD0 en el sprite 0 de la VRAM, que en el TMS9918 no es una posicion: es el fin de la lista, y de un byte apaga los 32
	ld hl,03800h		;4669   ; 0x300 bytes son las 24 filas de 32 de la tabla de nombres
	ld bc,00300h		;466c
	xor a			;466f   ; el tile 0, que despues de 0x4496 es un bloque macizo del color 0, o sea del fondo
	jp 00056h		;4670   ; BIOS FILVRM - Fills VRAM with value
PREPARA_ESCRITURA_VRAM:		; SETWRT en HL y deja en C' el puerto de datos del VDP (byte de la BIOS 0x0007)
	ex af,af'			;4673   ; AF se guarda en AF' y vuelve al salir: quien llama no pierde ni A ni las banderas
	call 00053h		;4674   ; BIOS SETWRT - Enables VDP to write
	exx			;4677   ; el puerto se deja en el OTRO juego de registros, que es justo como lo quiere el bucle de la ventana (0x4529): alli HL' lleva la VRAM y el C de aqui, el dato
	ld a,(00007h)		;4678   ; el byte 0x0007 de la BIOS es el puerto de datos del VDP de esta maquina, que no tiene por que ser el 0x98
	ld c,a			;467b
	exx			;467c
	ex af,af'			;467d
	ret			;467e
PREPARA_LECTURA_VRAM:		; la gemela de lectura: SETRD en HL y el puerto de LECTURA (byte 0x0006 de la BIOS) en C'. Codigo muerto: los bytes 7F 46 no aparecen en los 128 KB del cartucho ni detras de un `call`, ni detras de un `jp`, ni sueltos en ninguna tabla
	call 00050h		;467f   ; BIOS SETRD - Enables VDP to read | SETRD en vez de SETWRT...
	exx			;4682
	ld a,(00006h)		;4683   ; ...y el byte 0x0006 en vez del 0x0007
	ld c,a			;4686
	exx			;4687   ; y sin el `ex af,af'` de su gemela: esta devuelve en A el numero de puerto
	ret			;4688
FOTOGRAMAS_COCHES:		; 4/5/6; el coche 1 (E2C0 -> patrones 0x1800) y, con el bit 5 de E1C2, el 2 (E380 -> 0x1840); vuelve a 1/2/3
	call MAPEA_4_5_6		;4689   ; los fotogramas de los coches estan en la pagina 4 (0x6000) y en la 5 (0x8000)
	ld ix,0e2c0h		;468c   ; el bloque del coche 1...
	ld hl,01800h		;4690   ; ...y su fotograma va a VRAM 0x1800, que con R6 = 03 es el principio de los patrones de sprite: los 64 bytes de los sprites 0 y 1 de 16x16
	call FOTOGRAMA_COCHE		;4693
	ld a,(0e1c2h)		;4696
	bit 5,a		;4699   ; el coche 2 solo si esta jugando: si no, sus patrones se quedan como estaban
	ld ix,0e380h		;469b
	ld hl,01840h		;469f   ; los del coche 2 van 0x40 bytes mas alla, en los sprites 2 y 3
	call nz,FOTOGRAMA_COCHE		;46a2
	jp MAPEA_1_2_3		;46a5   ; y a dejar el mapeo de siempre
FOTOGRAMA_COCHE:		; si (ix-3) != 0 -> patrones del objeto de pista (0x4701); fotograma (ix+0E): >= 0x80 -> 0x46DF, bit 6 -> 0x4740; si cambio respecto a (ix+3E), 64 bytes del juego (tabla p04 0x7431 por (ix+18)) + fotograma*64 a VRAM HL
	ld a,(ix-003h)		;46a8   ; (ix-3) no es un fotograma: es el aviso de que hay dos tiles de objeto de pista pendientes de cargar, y se atiende ANTES que el coche y en vez de el. Lo pone 0x5ECA con el dibujo que toca
	or a			;46ab
	jr nz,TILES_OBJETO_PISTA		;46ac
	ld a,(ix+00eh)		;46ae   ; (ix+0E) es el numero de fotograma que dejo p02 0x9A01 mirando el angulo del coche; aqui solo se copia
	cp 080h		;46b1   ; de 0x80 para arriba no es un fotograma del coche: es un efecto -su tabla la eligen 0x9A83/0x9A93- y sus patrones estan en otra pagina
	jr nc,FOTOGRAMA_COCHE_80		;46b3
	bit 6,a		;46b5   ; el bit 6 parte los diecisiete angulos en dos juegos de dibujo: la tabla p02 0x9AA3 da 0x40..0x44 para los nueve angulos de en medio y 0..4 para los siete de los extremos
	jp nz,FOTOGRAMA_COCHE_40		;46b7
	cp (ix+03eh)		;46ba   ; (ix+3E) es el fotograma que YA esta en la VRAM: mientras no cambie no se copian los 64 bytes, que es una vez por fotograma y por coche
	ret z			;46bd
	ld (ix+03eh),a		;46be   ; y en cuanto cambia se apunta, antes de copiar nada
	push hl			;46c1
	ld a,(ix+018h)		;46c2   ; (ix+18) es la carroceria, 0 a 17 (p02 0x8943 la saca de los cinco bytes del coche elegido)
	ld de,07431h		;46c5   ; 21 palabras, las tres ultimas a cero: las 18 carrocerias repiten puntero cuando comparten dibujo, asi que juegos distintos hay menos
	call DE_PALABRA_A		;46c8
	ld l,(ix+00eh)		;46cb   ; seis `add hl,hl` = fotograma * 64...
	ld h,000h		;46ce
	add hl,hl			;46d0
	add hl,hl			;46d1
	add hl,hl			;46d2
	add hl,hl			;46d3
	add hl,hl			;46d4
	add hl,hl			;46d5
	add hl,de			;46d6
	ex de,hl			;46d7
	pop hl			;46d8
	ld bc,00040h		;46d9   ; ...porque un fotograma son 64 bytes, o sea los dos patrones de sprite de 16x16 que forman un coche
	jp COPIA_A_VRAM		;46dc
FOTOGRAMA_COCHE_80:		; fotogramas 0x80..: (fotograma & 0x0F)*64 desde p05 0x8A71 (E25B < 3) o 0x8BF1
	push hl			;46df
	and 00fh		;46e0   ; del efecto solo cuentan los cuatro bits de abajo: dieciseis fotogramas como mucho
	ld l,a			;46e2
	ld h,000h		;46e3
	add hl,hl			;46e5
	add hl,hl			;46e6
	add hl,hl			;46e7
	add hl,hl			;46e8
	add hl,hl			;46e9
	add hl,hl			;46ea
	ld a,(0e25bh)		;46eb   ; E25B es la categoria: 0 RALLY, 1 STOCK, 2 ENDURANCE, 3 F3, 4 F3000, 5 F1
	ld de,08bf1h		;46ee   ; de F3 para arriba el juego de 0x8BF1...
	cp 003h		;46f1
	jr nc,L_46F8		;46f3
	ld de,08a71h		;46f5   ; ...y en las tres primeras el de 0x8A71: el efecto se dibuja sobre el coche, y un turismo y un monoplaza no tienen la misma silueta
L_46F8:
	add hl,de			;46f8
	ex de,hl			;46f9
	pop hl			;46fa
	ld bc,00040h		;46fb   ; los mismos 64 bytes y al mismo sitio de la VRAM que un fotograma normal: el efecto SUSTITUYE al coche, no se le suma
	jp COPIA_A_VRAM		;46fe
TILES_OBJETO_PISTA:		; (ix-3) = 1..6: los 16 bytes (dos tiles apilados, 8x16 pixeles) de p04 0x75D1 + (n-1)*16 a los patrones del tile 206 (bit 0 de ix+9) o del 208, en los tres tercios
	ld (ix-003h),000h		;4701   ; el aviso se consume aqui: los patrones se recargan una vez y hasta que 0x5ECA vuelva a pedirlo
	dec a			;4705   ; el aviso va de 1 a 6 y la tabla empieza en el dibujo 1, de ahi el `dec a`
	add a,a			;4706   ; cuatro `add a,a` = n * 16, que son los dos tiles de cada dibujo
	add a,a			;4707
	add a,a			;4708
	add a,a			;4709
	ld l,a			;470a
	ld h,000h		;470b
	ld de,075d1h		;470d   ; la tabla esta en la pagina 4, ya mapeada en 0x6000 por 0x4689
	add hl,de			;4710
	ex de,hl			;4711
	ld hl,02670h		;4712   ; 0x2670 es el patron del tile 206 (0x2000 + 206*8) y 0x2680 el del 208
	bit 0,(ix+009h)		;4715   ; (ix+9) es el numero de jugador: cada uno tiene reservada su pareja de tiles -206/207 uno, 208/209 el otro-, porque en pantalla partida los dos buffers se pintan a la vez con objetos distintos
	jr nz,TILES_OBJETO_PISTA_TERCIOS		;4719
	ld hl,02680h		;471b
TILES_OBJETO_PISTA_TERCIOS:		; los tres LDIRVM de 16 bytes: el mismo dibujo en los tres tercios de la tabla de patrones
	push de			;471e   ; DE (origen) y HL (destino) se guardan y se recuperan porque COPIA_A_VRAM los machaca
	push hl			;471f
	ld bc,00010h		;4720
	call COPIA_A_VRAM		;4723
	pop hl			;4726
	pop de			;4727
	push de			;4728
	push hl			;4729
	ld bc,00800h		;472a   ; 0x800 mas alla esta el mismo tile en el segundo tercio de la pantalla...
	add hl,bc			;472d
	ld bc,00010h		;472e
	call COPIA_A_VRAM		;4731
	pop hl			;4734
	pop de			;4735
	ld bc,01000h		;4736   ; ...y 0x1000 en el tercero. En G2 cada tercio tiene su juego de patrones, asi que un tile que puede salir en cualquier fila hay que cargarlo tres veces
	add hl,bc			;4739
	ld bc,00010h		;473a
	jp COPIA_A_VRAM		;473d
FOTOGRAMA_COCHE_40:		; fotogramas con el bit 6: (fotograma & 0xBF)*64 desde el juego de la tabla p04 0x745B por (ix+18)
	push hl			;4740
	ld a,(ix+018h)		;4741   ; la misma carroceria, pero otra tabla de punteros: el segundo juego de dibujos
	ld de,0745bh		;4744
	call DE_PALABRA_A		;4747
	ld l,(ix+00eh)		;474a
	res 6,l		;474d   ; quitado el bit 6 queda el numero de fotograma dentro de ese juego, 0 a 4
	ld h,000h		;474f
	add hl,hl			;4751
	add hl,hl			;4752
	add hl,hl			;4753
	add hl,hl			;4754
	add hl,hl			;4755
	add hl,hl			;4756
	add hl,de			;4757
	ex de,hl			;4758
	pop hl			;4759
	ld bc,00040h		;475a   ; y los mismos 64 bytes al mismo sitio: para el VDP los dos juegos son el mismo par de sprites
	jp COPIA_A_VRAM		;475d
SPRITE_31_A_VRAM:		; los 4 bytes del sprite 31 de la copia (EAFC) al sprite 0 de la VRAM si hay jugador 1, y al sprite 2 si no lo hay
	exx			;4760
	ld a,(0e1c2h)		;4761   ; bit 6 de E1C2 = hay jugador 1
	and 040h		;4764
	ld hl,03b08h		;4766   ; sin jugador 1 -o sea en la presentacion- este sprite va al 2...
	jr z,L_476E		;4769
	ld hl,03b00h		;476b   ; ...y jugando, al 0
L_476E:
	call PREPARA_ESCRITURA_VRAM		;476e
	exx			;4771
	ld hl,0eafch		;4772   ; EAFC es el ultimo bloque de la copia, el sprite 31
	ld de,00000h		;4775
	ld b,004h		;4778   ; cuatro bytes: Y, X, patron y color de UN sprite
	jr OUTI_CUATRO_SPRITES		;477a
SPRITES_A_VRAM:		; los 32 sprites de la copia (EA80) a la tabla 0x3B00; en los fotogramas impares los 30 primeros van al reves (0x4794) y los dos ultimos al derecho
	exx			;477c
	ld hl,03b00h		;477d
	call PREPARA_ESCRITURA_VRAM		;4780
	exx			;4783
	ld a,(0e1c3h)		;4784   ; E1C3 es el contador de fotogramas de logica; el `rrca` deja su bit 0 en el acarreo
	rrca			;4787
	jr c,SPRITES_A_VRAM_AL_REVES		;4788
	ld hl,0ea80h		;478a   ; con el bit 0 a cero, el volcado normal: 128 bytes seguidos, los 32 sprites en su orden
	ld de,00000h		;478d
	ld b,080h		;4790   ; 0x80 = 32 sprites x 4 bytes
	jr OUTI_CUATRO_SPRITES		;4792
SPRITES_A_VRAM_AL_REVES:		; los 30 primeros del reves -EAF4 hacia abajo de ocho en ocho- y luego los sprites 30 y 31 al derecho
	ld hl,0eaf4h		;4794   ; EAF4 es el sprite 29, el ultimo de los que rotan
	ld de,0fff8h		;4797   ; -8: los cuatro `outi` avanzan cuatro, asi que restar ocho deja HL cuatro bytes MAS ATRAS, o sea en el sprite anterior
	ld b,078h		;479a   ; 0x78 = 30 sprites; el 29 acaba en el hueco 0 de la VRAM, el 28 en el 1, y asi hasta el 0, que acaba en el 29
	call OUTI_CUATRO_SPRITES		;479c
	ld hl,0eaf8h		;479f   ; y los sprites 30 y 31 se vuelcan aparte y en su sitio: no entran en la rotacion
	ld de,00000h		;47a2
	ld b,008h		;47a5
OUTI_CUATRO_SPRITES:		; el bucle: cuatro `outi` (un sprite) con tres `nop` de espera entre ellos, HL += DE y otra vuelta hasta que B llegue a cero
	outi		;47a7   ; tres `nop` entre `outi` y `outi`: la espera que pide el VDP entre dos accesos seguidos al puerto de datos
	nop			;47a9
	nop			;47aa
	nop			;47ab
	outi		;47ac
	nop			;47ae
	nop			;47af
	nop			;47b0
	outi		;47b1
	nop			;47b3
	nop			;47b4
	nop			;47b5
	outi		;47b6
	ret z			;47b8   ; `outi` deja Z cuando B llega a cero, y como solo se mira aqui, la salida cae SIEMPRE en un multiplo de cuatro: nunca se corta un sprite por la mitad
	add hl,de			;47b9   ; DE es 0 para ir hacia delante y -8 para ir hacia atras: es el unico sitio donde se decide el sentido
	jp OUTI_CUATRO_SPRITES		;47ba
DOS_SPRITES_A_VRAM:		; solo los sprites 0 y 1 de la copia, sin rotar
	exx			;47bd
	ld hl,03b00h		;47be
	call PREPARA_ESCRITURA_VRAM		;47c1
	exx			;47c4
	ld hl,0ea80h		;47c5   ; los dos primeros atributos de EA80 y nada mas: son los del coche del jugador
	ld de,00000h		;47c8
	ld b,008h		;47cb
	jr OUTI_CUATRO_SPRITES		;47cd
COPIA_A_VRAM:		; LDIRVM: BC bytes desde DE (RAM o ROM) a VRAM HL
	ex de,hl			;47cf
	jp 0005ch		;47d0   ; BIOS LDIRVM - Block transfers to VRAM from memory
COPIA_VRAM_3_TERCIOS:		; la gemela LDIRVM de LLENA_VRAM_3_TERCIOS: BC bytes de DE a HL, HL+0x800 y HL+0x1000. CODIGO MUERTO: nadie la llama, y los bytes D3 47 solo salen una vez en los 128 KB, dentro de una partitura de p14 (0x9F6F)
	exx			;47d3
	ld b,003h		;47d4   ; tres tercios, y el contador va en B' para no gastar un registro del juego de fuera
L_47D6:
	exx			;47d6
	push bc			;47d7
	push de			;47d8
	call COPIA_A_VRAM		;47d9   ; un tercio por vuelta, y DE y BC se guardan porque LDIRVM se los come
	ld de,00800h		;47dc   ; 0x800 es lo que ocupa un tercio de la tabla de patrones
	add hl,de			;47df
	pop de			;47e0
	pop bc			;47e1
	exx			;47e2
	djnz L_47D6		;47e3
	ret			;47e5
LLENA_VRAM_3_TERCIOS:		; FILVRM: BC bytes de A en VRAM HL, y otra vez en HL+0x800 y HL+0x1000
	ld d,003h		;47e6
BUCLE_LLENA_TERCIO:		; un tercio por vuelta
	push bc			;47e8
	push de			;47e9
	call 00056h		;47ea   ; BIOS FILVRM - Fills VRAM with value
	ld de,00800h		;47ed
	add hl,de			;47f0
	pop de			;47f1
	pop bc			;47f2
	dec d			;47f3
	jr nz,BUCLE_LLENA_TERCIO		;47f4
	ret			;47f6
RLE_VRAM_3_TERCIOS:		; descomprime (DE) en VRAM HL con 0x4862, tres veces (HL += 0x800), el mismo flujo cada vez
	ld b,003h		;47f7
BUCLE_RLE_TERCIO:		; un tercio por vuelta
	push bc			;47f9
	push de			;47fa
	call RLE_A_VRAM		;47fb   ; un tercio por vuelta, y el puntero de VRAM sube 0x800
	ld de,00800h		;47fe
	add hl,de			;4801
	pop de			;4802
	pop bc			;4803
	djnz BUCLE_RLE_TERCIO		;4804
	ret			;4806
PINTA_TILES_EN_HL:		; como 0x4811 pero la direccion de VRAM ya viene en HL: se salta la palabra de cabecera y entra directo al bucle
	ld c,0ffh		;4807
	ld b,000h		;4809
	jr PINTA_TILES_BUCLE		;480b
PINTA_TILES_TEXTO:		; como 0x4811 con B = 0x20: el flujo lleva caracteres ASCII y el tile es el caracter menos 0x20, o sea que el tile 0 es el espacio
	ld b,020h		;480d
	jr L_4813		;480f
PINTA_TILES:		; flujo en (DE): palabra = direccion de VRAM; luego bytes: FF fin, FE nueva direccion, 02 fila/columna (0x3800 + fila*32 + columna), otro = tile (menos B, AND C) por WRTVRM en HL++ (B=0, C=0xFF: tal cual)
	ld b,000h		;4811   ; los dos registros que mandan en todo el bucle: B es cuanto se le RESTA al byte del flujo para sacar el tile -0 si ya son tiles, 0x20 si son letras- y C la mascara -0xFF pinta, 0x00 escribe el tile 0, o sea borra-
L_4813:
	ld c,0ffh		;4813
PINTA_TILES_DIRECCION:		; lee la palabra de (DE) como nueva direccion de VRAM y sigue
	ex de,hl			;4815
	ld e,(hl)			;4816
	inc hl			;4817   ; los dos bytes que vienen detras del codigo son la direccion de VRAM nueva
	ld d,(hl)			;4818
	ex de,hl			;4819
	inc de			;481a
PINTA_TILES_BUCLE:		; un byte del flujo por vuelta
	ld a,(de)			;481b
	inc de			;481c
	cp 002h		;481d   ; el codigo 02 no es un tile: detras vienen fila y columna
	jr z,PINTA_TILES_POSICION		;481f
	cp 0ffh		;4821   ; y el 0xFF es el final del flujo
	ret z			;4823
	cp 0feh		;4824   ; el 0xFE cambia de sitio en la VRAM sin salir del flujo: una lista puede pintar en varios sitios de la pantalla
	jr z,PINTA_TILES_DIRECCION		;4826
	sub b			;4828   ; aqui se aplican los dos registros: primero la resta y luego la mascara
	and c			;4829
	call 0004dh		;482a   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;482d
	jr PINTA_TILES_BUCLE		;482e
BORRA_TILES:		; como 0x4811 con B=C=0: escribe ceros en las mismas posiciones (borra lo que pinto)
	ld bc,00000h		;4830
	jr PINTA_TILES_DIRECCION		;4833
PINTA_TILES_TEXTO_DE:		; igual que 0x483D; la fila y la columna las trae ya el DE del llamante. INALCANZABLE: no la llama nadie y los bytes 35 48 no salen ni una vez en los 128 KB
	ld c,0ffh		;4835
	jr L_4846		;4837
BORRA_TILES_TEXTO:		; la pareja de 0x483D: mismo recorrido pero con C = 0, asi que en vez de la letra escribe el tile 0. Es la que borra los rotulos que pinto su gemela (p00 0x4B99)
	ld c,000h		;4839
	jr PINTA_TILES_POSICION		;483b
PINTA_TILES_TEXTO_POSICION:		; texto empezando por el codigo de posicion: B = 0x20 (letra - 0x20) y C = 0xFF. La usa 0x4B8F para los rotulos del flujo 0xEC02
	ld c,0ffh		;483d
PINTA_TILES_POSICION:		; el codigo 02 del flujo: la palabra que viene detras es FILA y luego COLUMNA -> VRAM 0x3800 + fila*32 + columna
	ld b,020h		;483f   ; entrando por aqui B vale 0x20, o sea que este camino es siempre el del texto
	ex de,hl			;4841
	ld e,(hl)			;4842
	inc hl			;4843
	ld d,(hl)			;4844
	inc hl			;4845
L_4846:
	ld b,020h		;4846
	push hl			;4848
	ex de,hl			;4849
	ld a,h			;484a   ; el segundo byte -la columna- se guarda en A mientras HL se monta con el primero
	ld h,000h		;484b
	add hl,hl			;484d   ; cinco `add hl,hl` = fila * 32, que es lo que ocupa una fila de la tabla de nombres
	add hl,hl			;484e
	add hl,hl			;484f
	add hl,hl			;4850
	add hl,hl			;4851
	call HL_MAS_A		;4852
	ld de,03800h		;4855   ; y 0x3800 es donde empieza esa tabla
	add hl,de			;4858
	pop de			;4859   ; se recupera el flujo, que quedo apuntando al byte de detras de la posicion
	jr PINTA_TILES_BUCLE		;485a
RLE_SIGUE_PUNTERO:		; DE = la palabra de (DE): el flujo continua en otro sitio
	ex de,hl			;485c   ; sin volver a dar la direccion de VRAM: el destino sigue donde iba, solo cambia de donde se leen los datos
	ld e,(hl)			;485d
	inc hl			;485e
	ld d,(hl)			;485f
	ex de,hl			;4860
	inc de			;4861
RLE_A_VRAM:		; descomprime en VRAM HL el flujo de (DE): 0x00 = fin; 0x01..0x7F = repetir el byte siguiente n veces; 0x81..0xFF = copiar n&0x7F bytes tal cual; 0x80 = seguir en el puntero que viene (0x485C)
	call PREPARA_ESCRITURA_VRAM		;4862   ; SETWRT una sola vez: a partir de aqui todo va por `out (c),a` con el puerto en C', que es mas rapido que WRTVRM y no hace falta volver a dar la direccion
RLE_A_VRAM_BUCLE:		; un codigo del flujo por vuelta
	ld a,(de)			;4865
	and a			;4866   ; el 0 es el final, y se mira antes de nada
	ret z			;4867
	inc de			;4868
	ld b,a			;4869   ; B se queda con el codigo entero y A con sus siete bits de abajo...
	and 07fh		;486a
	cp b			;486c   ; ...asi que si son iguales el bit 7 estaba a cero: es una REPETICION
	jr z,L_487D		;486d
	and a			;486f   ; y si al quitarle el bit 7 no queda nada, el codigo era 0x80: el flujo sigue en otro sitio
	jr z,RLE_SIGUE_PUNTERO		;4870
	ld b,a			;4872
RLE_COPIA_N:		; n bytes tal cual al VDP
	ld a,(de)			;4873
	inc de			;4874
	exx			;4875   ; el `exx` es para llegar al C' que dejo PREPARA_ESCRITURA_VRAM con el puerto de datos del VDP
	out (c),a		;4876
	exx			;4878
	djnz RLE_COPIA_N		;4879
	jr RLE_A_VRAM_BUCLE		;487b
L_487D:
	ld a,(de)			;487d   ; el byte que se repite se lee UNA vez, fuera del bucle
	inc de			;487e
RLE_REPITE_N:		; el mismo byte n veces al VDP
	exx			;487f
	out (c),a		;4880
	exx			;4882
	djnz RLE_REPITE_N		;4883
	jr RLE_A_VRAM_BUCLE		;4885
HUD_DE_LOS_COCHES:		; el HUD del coche 1 (E2C0) y, si hay jugador 2 (bit 5 de E1C2), tambien el del 2 (E380)
	ld ix,0e2c0h		;4887   ; IX e IY apuntan al mismo bloque: las rutinas de abajo usan IX, pero las que llaman por debajo esperan IY
	ld iy,0e2c0h		;488b
	call HUD_DE_UN_COCHE		;488f
	ld a,(0e1c2h)		;4892
	bit 5,a		;4895
	ret z			;4897
	ld ix,0e380h		;4898
	ld iy,0e380h		;489c
HUD_DE_UN_COCHE:		; despacha por el estado (ix+5D): 2 -> PIT IN, 6 -> GOAL o RETIRE+EMPTY, cualquier otro -> el numero, mientras (ix-7) no se agote
	ld a,(ix+05dh)		;48a0   ; (ix+5D) es el estado del coche, el mismo que despacha p02 0x8B0C
	cp 002h		;48a3   ; estado 2 = en boxes
	jp z,HUD_PIT_IN		;48a5
	cp 006h		;48a8   ; estado 6 = parado
	jp z,HUD_COCHE_PARADO		;48aa
	ld a,(ix-007h)		;48ad   ; (ix-7) es la cuenta atras del rotulo, en fotogramas: a cero no se pinta nada...
	or a			;48b0
	ret z			;48b1
	dec a			;48b2   ; ...y se gasta de uno en uno; el `ret z` de detras hace que el ULTIMO fotograma tampoco pinte, asi que el numero se ve mientras (ix-7) valga 2 o mas
	ld (ix-007h),a		;48b3
	ret z			;48b6
HUD_NUMERO_6_DIGITOS:		; seis digitos desde (ix+0x78) en tres parejas separadas por el tile 0xFF, escritos de derecha a izquierda en las ocho casillas que empiezan en 0x3965 o 0x3975
	call HUD_CASILLA_DEL_JUGADOR		;48b7
	push ix		;48ba
	pop de			;48bc
	ld a,078h		;48bd   ; los seis digitos estan en el bloque del coche a partir del desplazamiento 0x78, y el primero es el de MENOS peso
	call DE_MAS_A		;48bf
	ld a,007h		;48c2
	call HL_MAS_A		;48c4   ; siete casillas mas a la derecha: el numero se escribe hacia atras, empezando por la unidad
	ld b,002h		;48c7   ; de dos en dos digitos
	ld c,0f5h		;48c9   ; el digito 0 es el tile 0xF5 con un jugador...
	ld a,(0e1c2h)		;48cb
	bit 5,a		;48ce
	jr z,HUD_DIGITOS_PAREJA		;48d0
	ld c,0d4h		;48d2   ; ...y el 0xD4 con dos, para dejar libres los tiles de las letras
HUD_DIGITOS_PAREJA:		; los dos digitos de una pareja
	ld a,(de)			;48d4
	add a,c			;48d5
	call 0004dh		;48d6   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;48d9
	dec hl			;48da   ; HL va HACIA ATRAS mientras DE avanza: por eso el digito de menos peso acaba a la derecha del todo
	djnz HUD_DIGITOS_PAREJA		;48db
	ld a,0ffh		;48dd   ; el tile 0xFF es el separador entre parejas; van dos, asi que el numero sale en tres grupos de dos
	call 0004dh		;48df   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;48e2
	ld b,002h		;48e3
L_48E5:
	ld a,(de)			;48e5
	add a,c			;48e6
	call 0004dh		;48e7   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;48ea
	dec hl			;48eb
	djnz L_48E5		;48ec
	ld a,0ffh		;48ee
	call 0004dh		;48f0   ; BIOS WRTVRM - Writes data in VRAM
	dec hl			;48f3
	ld b,002h		;48f4
L_48F6:
	ld a,(de)			;48f6
	add a,c			;48f7
	call 0004dh		;48f8   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;48fb
	dec hl			;48fc
	djnz L_48F6		;48fd
	ret			;48ff
HUD_PIT_IN:		; el rotulo "PIT IN" (0x4961), solo con dos jugadores
	ld de,04961h		;4900
	ld a,(0e1c2h)		;4903
	bit 5,a		;4906
	ret z			;4908   ; sin jugador 2 no hay sitio en los tiles para las letras: no se pinta
HUD_ROTULO_6:		; un rotulo de seis tiles en la casilla que toque
	ld b,006h		;4909
HUD_ROTULO:		; pide la casilla y escribe B tiles
	call HUD_CASILLA_DEL_JUGADOR		;490b
HUD_ROTULO_BUCLE:		; un tile por vuelta, saltandose los 0x20
	ld a,(de)			;490e
	cp 020h		;490f   ; el 0x20 del rotulo no es un espacio: es "no toques esta casilla", y por eso avanza sin escribir
	jr z,L_4916		;4911
	call 0004dh		;4913   ; BIOS WRTVRM - Writes data in VRAM
L_4916:
	inc hl			;4916
	inc de			;4917
	djnz HUD_ROTULO_BUCLE		;4918
	ret			;491a
HUD_CASILLA_DEL_JUGADOR:		; HL = 0x3965 (fila 11, columna 5) o, con dos jugadores y el bit 0 de (ix+9), 0x3975 (columna 21)
	ld hl,03965h		;491b
	ld a,(0e1c2h)		;491e
	bit 5,a		;4921
	ret z			;4923   ; con un solo jugador todo el HUD va a la izquierda
	bit 0,(ix+009h)		;4924   ; (ix+9) es el numero de jugador: el 1 pinta en la mitad derecha de la pantalla partida
	ret z			;4928
	ld hl,03975h		;4929
	ret			;492c
HUD_COCHE_PARADO:		; estado 6: con el bit 1 de (ix+1) el rotulo es "GOAL"; si no, " EMPTY" en la fila de abajo y "RETIRE" encima
	ld a,(0e1c2h)		;492d
	bit 5,a		;4930
	ret z			;4932
	bit 1,(ix+001h)		;4933   ; el bit 1 de (ix+1) separa las dos formas de acabar parado
	jr nz,HUD_GOAL		;4937
	ld a,(ix+015h)		;4939   ; (ix+15) es lo que le queda de rotulo; a cero ya no se repinta
	and a			;493c
	ret z			;493d
	dec (ix+015h)		;493e
	ld de,0496dh		;4941
	ld hl,03985h		;4944   ; 0x3985 es la fila 12 columna 5, o sea justo debajo del sitio de siempre...
	bit 0,(ix+009h)		;4947
	jr z,L_4950		;494b
	ld hl,03995h		;494d   ; ...y 0x3995 la columna 21 de esa misma fila
L_4950:
	ld b,006h		;4950
	call HUD_ROTULO_BUCLE		;4952
	ld de,04967h		;4955   ; y encima del EMPTY, en la fila 11, el RETIRE
	jr HUD_ROTULO_6		;4958
HUD_GOAL:		; el rotulo "GOAL" (0x4973), cuatro tiles
	ld de,04973h		;495a
	ld b,004h		;495d
	jr HUD_ROTULO		;495f

; ----------------------------------------------------------------------
; DATOS rotulos_hud: cuatro rotulos del HUD en codigos de tile (tile = 0xE4 +
;   numero de letra (A=1: P=0xF4, I=0xED, T=0xF8), 0x00 = tile 0 (blanco),
;   0x20 = "no escribir"): "PIT IN" (0x4961), "RETIRE" (0x4967), " EMPTY"
;   (0x496D) y "GOAL" (0x4973); los escribe con WRTVRM el bucle de 0x490E (`ld
;   a,(de) / cp 020h / jr z / call 0x004D`) con DE puesto en 0x4900, 0x4941,
;   0x4955 y 0x495A y B = 6, 6, 6 y 4
;   0x4961..0x4977  (22 bytes)
DATA_rotulos_hud:
	defb 0f4h,0edh,0f8h,000h,0edh,0f2h	; 4961
	defb 0f6h,0e9h,0f8h,0edh,0f6h,0e9h	; 4967
	defb 000h,0e9h,0f1h,0f4h,0f8h,0fdh	; 496d
	defb 0ebh,0f3h,0e5h,0f0h	; 4973

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (3 bytes)
;   0x4977..0x497a  (3 bytes)
DATA_4977:
	defb 0cah,05ch,048h	; 4977

; ======================================================================
; CODIGO 0x497a..0x49c4  (74 bytes)
; ======================================================================


L_497A:
	call 08666h		;497a   ; la RAM de la partida: 0xE13 bytes desde E1EB a cero, y de ahi cuelga todo lo que se conserva entre carreras
	ld hl,0e1ebh		;497d
	ld bc,00e13h		;4980
	call RELLENA_RAM_CERO		;4983   ; el trocito de 0x49C4 son tres bytes de arranque que no pueden quedarse a cero
	ld hl,049c4h		;4986
	ld de,0e1f0h		;4989
	ld bc,00003h		;498c
	ldir		;498f
	xor a			;4991
	ld (0e300h),a		;4992
	ld (0e1c3h),a		;4995
	dec a			;4998
	ld (0e25bh),a		;4999   ; E25B a 0xFF es "todavia no hay categoria elegida"
	ld a,(0f0feh)		;499c   ; F0FE con un 1 viene del reinicio de 0x5B90: entonces ademas se limpia el bloque de E280
	dec a			;499f
	call z,L_49AF		;49a0
	ld a,(0e1deh)		;49a3   ; E1DE es la deteccion de cartucho Konami enchufado, y vale 2 si lo hay; con 2 es el desbloqueo, y deja E1DF a 1
	cp 002h		;49a6
	ret nz			;49a8
	ld a,001h		;49a9
	ld (0e1dfh),a		;49ab
	ret			;49ae
L_49AF:
	ld a,(0e1c0h)		;49af   ; con E1C0 = 2 no se toca nada
	cp 002h		;49b2
	ret z			;49b4
	xor a			;49b5   ; F0FE se apaga: el reinicio ya esta consumido
	ld (0f0feh),a		;49b6
	ld hl,0e280h		;49b9   ; 0x15 bytes de E280 a 9: no es un borrado, es un valor de arranque
	ld bc,00015h		;49bc
	ld a,009h		;49bf
	jp RELLENA_RAM		;49c1

; ----------------------------------------------------------------------
; DATOS inicial_E1F0: los tres bytes 03 01 01 que 0x4986 copia a E1F0-E1F2
;   (`ld hl,0x49C4 / ld de,0xE1F0 / ld bc,3 / ldir`)
;   0x49c4..0x49c7  (3 bytes)
DATA_inicial_E1F0:
	defb 003h,001h,001h	; 49c4

; ======================================================================
; CODIGO 0x49c7..0x4c37  (624 bytes)
; ======================================================================


CORTINILLA_COLUMNA:		; borra de la tabla de nombres la columna que dice E1C4, las 24 filas; E1C4 baja de uno en uno y al pasar de 0 la cortinilla se acaba
	ld hl,0e1c4h		;49c7
	dec (hl)			;49ca   ; `ret m` en vez de `ret z`: la rutina se llama un fotograma de mas y es el paso a 0xFF -no el 0- el que la corta, asi que la columna 0 llega a borrarse
	ret m			;49cb
	ld a,(hl)			;49cc
	ld h,038h		;49cd
	xor 01fh		;49cf   ; invierte la cuenta: con E1C4 = 31 se borra la columna 0 y con 0 la 31, o sea que la cortinilla va de izquierda a derecha aunque el contador baje
	add a,000h		;49d1   ; este `add a,0` no hace nada, y no puede ser un hueco para parchear en caliente porque la pagina 0 es ROM; las banderas que deja tampoco las mira nadie, que las machaca el `xor a` de dos instrucciones despues
	ld l,a			;49d3
	ld b,018h		;49d4   ; 24 filas
	xor a			;49d6
	ld de,00020h		;49d7   ; 32 casillas de una fila a la de abajo: se baja en vertical por la misma columna
CORTINILLA_BUCLE:		; una fila por vuelta
	call 0004dh		;49da   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;49dd
	djnz CORTINILLA_BUCLE		;49de
APAGA_SPRITES_DEL_1:		; Y = 0xD0 en el sprite 1 si hay jugador 1 y en el 3 si no: deja vivos los del coche o los de la presentacion y apaga el resto
	ld hl,03b0ch		;49e0
	ld a,(0e1c2h)		;49e3   ; bit 6 de E1C2 = hay jugador 1
	and 040h		;49e6
	jr z,APAGA_DESDE_HL		;49e8
	ld hl,03b04h		;49ea   ; jugando, los sprites del coche 1 son el 0 y el 1, asi que se corta en el 1... y en la presentacion, dos mas alla
	jr APAGA_DESDE_HL		;49ed
APAGA_SPRITES_DEL_0:		; igual, pero cortando en el sprite 0 (jugando) o en el 2 (presentacion): no queda ninguno
	ld hl,03b08h		;49ef
	ld a,(0e1c2h)		;49f2
	and 040h		;49f5
	jr z,APAGA_DESDE_HL		;49f7
APAGA_TODOS_LOS_SPRITES:		; Y = 0xD0 en el sprite 0: el VDP lo lee como fin de la lista y no pinta ninguno
	ld hl,03b00h		;49f9
APAGA_DESDE_HL:		; escribe el 0xD0 y devuelve A = 0
	ld a,0d0h		;49fc   ; 0xD0 en el byte Y de un sprite no es una posicion: el VDP lo lee como fin de la lista y deja de pintar ESE y todos los de detras. De un byte se apagan los que hagan falta
	call 0004dh		;49fe   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;4a01
	ret			;4a02
NUMERO_BCD_TILE_D4:		; el numero BCD de (DE) hacia atras, con los digitos en los tiles 0xD4..0xDD
	exx			;4a03
	ld d,0d4h		;4a04
	exx			;4a06
	jr NUMERO_BCD		;4a07
NUMERO_BCD_TILE_10:		; el mismo, con los digitos en los tiles 0x10..0x19
	exx			;4a09
	ld d,010h		;4a0a
	exx			;4a0c
NUMERO_BCD:		; B bytes BCD leidos de (DE) hacia atras y escritos en la VRAM desde HL hacia delante, dos digitos por byte y sin los ceros de la izquierda
	ld c,000h		;4a0d   ; C es el interruptor de los ceros de delante: a 0 el `and c` convierte el digito en el tile 0 -o sea en blanco- y en cuanto sale un digito que no es cero se queda a 0xFF para el resto del numero
NUMERO_BCD_BUCLE:		; un byte -dos digitos- por vuelta
	ld a,(de)			;4a0f   ; el nibble ALTO primero: el numero se escribe de izquierda a derecha aunque los bytes se lean del reves
	rra			;4a10
	rra			;4a11
	rra			;4a12
	rra			;4a13
	and 00fh		;4a14
	jr z,L_4A1A		;4a16
	ld c,0ffh		;4a18
L_4A1A:
	dec b			;4a1a   ; si B vale 1 estamos en el ultimo byte, y ahi los ceros SI se escriben: un cero sale "0" y no en blanco
	jr nz,L_4A1F		;4a1b
	ld c,0ffh		;4a1d
L_4A1F:
	inc b			;4a1f   ; el `dec b` de arriba era solo la comparacion; aqui se deshace
	exx			;4a20
	add a,d			;4a21   ; D' es la base: el tile del digito 0. Va en el otro juego de registros para no gastar ninguno de los de aqui
	exx			;4a22
	and c			;4a23
	call 0004dh		;4a24   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;4a27
	ld a,(de)			;4a28
	and 00fh		;4a29
	jr z,L_4A2F		;4a2b
	ld c,0ffh		;4a2d
L_4A2F:
	exx			;4a2f
	add a,d			;4a30
	exx			;4a31
	and c			;4a32
	call 0004dh		;4a33   ; BIOS WRTVRM - Writes data in VRAM
	dec de			;4a36   ; DE baja y HL sube: en la RAM el byte de mas peso esta el ultimo, y en pantalla va el primero
	inc hl			;4a37
	djnz NUMERO_BCD_BUCLE		;4a38
	ret			;4a3a

; ----------------------------------------------------------------------
; Un cajon de rutinas cortas que llaman sobre todo las OTRAS paginas:
; indexar tablas de palabras, dividir con y sin signo, pasar a BCD,
; buscar en el buffer de nombres y mover rectangulos. Detras, en
; 0x4BB2, empieza el cargador de tiles.
;
; OCHO PUERTAS SIN LLAMADOR, medido byte a byte sobre la ROM: los dos
; bytes de 0x4A55, 0x4A76, 0x4A97, 0x4B48, 0x4BA3, 0x4C8C, 0x4C9A y
; 0x4CAF no aparecen NI UNA VEZ en los 128 KB del cartucho -ni como
; operando de un call ni dentro de una tabla de saltos-, y a ninguna
; se llega cayendo desde la instruccion de antes: todas van detras de
; un `ret`, un `jr` o un `jp`. Con 0x4B48 se cae ademas todo lo que
; cuelga de el (0x4B4B y COPIA_B_BYTES_ALTERNO en 0x4B5E, cuyo unico
; llamador es el `call` de 0x4B4D): el copiador de rectangulos entero
; es codigo muerto.
; ----------------------------------------------------------------------
DE_PALABRA_A:		; DE = la palabra A de la tabla DE (de += 2a)
	ld l,a			;4a3b   ; A es el indice y DE la tabla; HL se usa de cuenta y sale machacado
	ld h,000h		;4a3c
	add hl,hl			;4a3e   ; el indice por dos, que las entradas son palabras
	add hl,de			;4a3f
	ld e,(hl)			;4a40   ; la palabra apuntada sale en DE, o sea encima de la tabla que entro. La llaman ocho sitios de p01 y p02
	inc hl			;4a41
	ld d,(hl)			;4a42
	ret			;4a43
HL_PALABRA_A:		; HL = la palabra A de la tabla HL (hl += 2a; hl = (hl))
	add a,a			;4a44   ; la misma cuenta que 0x4A3B pero con la tabla en HL y sin tocar DE: por eso el indice se suma a mano al byte bajo
	add a,l			;4a45
	ld l,a			;4a46
	jr nc,L_4A4A		;4a47   ; y el acarreo se lleva a H, que la tabla puede cruzar un limite de 256
	inc h			;4a49
L_4A4A:
	ld a,(hl)			;4a4a   ; el byte bajo se aparca en A: el `ld h,(hl)` de dos lineas mas abajo machaca H antes de que L este puesto
	inc hl			;4a4b
	ld h,(hl)			;4a4c
	ld l,a			;4a4d
	ret			;4a4e
COMPARA_HL_DE:		; Z si HL = DE, comparando byte a byte
	ld a,h			;4a4f   ; primero los altos: si no coinciden sale ya, y con Z apagado
	cp d			;4a50
	ret nz			;4a51
	ld a,l			;4a52   ; y si coincidian, deciden los bajos. Lo unico que vale a la vuelta es Z: el acarreo es el de una resta de UN byte, no el de HL - DE
	cp e			;4a53
	ret			;4a54
HL_ENTRE_256:		; HL / 256 sin signo: los tres corrimientos de aqui mas los cinco de 0x4A61. SIN LLAMADOR
	srl h		;4a55   ; `srl h` mete un cero por arriba: division sin signo. Al acabar, L es la H de antes y H vale 0
	rr l		;4a57
	srl h		;4a59
	rr l		;4a5b
	srl h		;4a5d
	rr l		;4a5f
HL_ENTRE_32:		; HL / 32 sin signo: los cinco corrimientos que quedan hasta el `ret`
	srl h		;4a61   ; la usa p01 0x7AF8, el marcador de velocidad
	rr l		;4a63
	srl h		;4a65   ; cinco parejas: dividir por 32 es correr cinco veces
	rr l		;4a67
	srl h		;4a69
	rr l		;4a6b
	srl h		;4a6d
	rr l		;4a6f
	srl h		;4a71
	rr l		;4a73
	ret			;4a75
HL_ENTRE_256_CON_SIGNO:		; la escalera con signo: ocho parejas `sra h / rr l` seguidas y un `ret`, y cada entrada divide por dos tantas veces como parejas le queden por delante. SIN LLAMADOR
	sra h		;4a76   ; `sra h` repite el bit 7 en vez de meter un cero, asi que un valor negativo sigue siendolo. Ojo: redondea siempre hacia abajo, no hacia cero (-1 / 8 da -1)
	rr l		;4a78
	sra h		;4a7a
	rr l		;4a7c
HL_ENTRE_64_CON_SIGNO:		; seis parejas de aqui al `ret`
	sra h		;4a7e   ; DIVIDE POR 64, no por 8: de 0x4A7E a 0x4A96 hay seis `sra h` (los bytes son CB 2C CB 1D repetidos). Las fichas de p02 0x8DD1 y 0x98CF decian "/8" y estaba mal
	rr l		;4a80
	sra h		;4a82
	rr l		;4a84
HL_ENTRE_16_CON_SIGNO:		; cuatro parejas
	sra h		;4a86
	rr l		;4a88
HL_ENTRE_8_CON_SIGNO:		; tres parejas; es la mas llamada de las cuatro (p02 0x8717, p02 0x9B12, p03 0xB52E)
	sra h		;4a8a
	rr l		;4a8c
	sra h		;4a8e
	rr l		;4a90
	sra h		;4a92
	rr l		;4a94   ; la escalera sale con el acarreo puesto a lo ultimo que salio por abajo, y hay quien se lo come sin querer: el `sbc hl,de` de p02 0x9934 no lleva `or a` delante y le resta un 1 de mas a la velocidad
	ret			;4a96
CASILLA_BUFFER_NOMBRES_IX:		; la casilla del objeto IX: D = (ix+6) y E = (ix+4), y cae en 0x4A9D. SIN LLAMADOR
	ld d,(ix+006h)		;4a97   ; el mismo reparto que hace a mano p02 0x8E98: (ix+4) va a E -el eje de la camara, o sea la FILA- y (ix+6) a D, la columna
	ld e,(ix+004h)		;4a9a
CASILLA_BUFFER_NOMBRES:		; HL = la casilla del buffer de nombres: base -E400 si (iy+9) = 1, EC00 si no- mas fila * 32 + columna, con fila = ((iy+40) + E) / 8 y columna = D / 8, las dos modulo 32, que el buffer es un mapa circular de 1 KB
	ld a,(iy+040h)		;4a9d   ; (iy+40) es la posicion vertical de la camara en pixeles, y E el desplazamiento vertical, tambien en pixeles, que pida quien llama
	add a,e			;4aa0   ; el eje que entra por E es el que las fichas de p01, p02 y p03 llaman "x" ((ix+3,4)); pese al nombre es el VERTICAL, y esta medido: es el byte que p01 0x703A escribe en la Y del atributo de sprite, y p03 0xA21C mete por el a los rivales lentos en 0 -arriba, por delante- y a los rapidos en 0xB7 -abajo, por detras-
	rra			;4aa1   ; nueve rotaciones que parten el par A:D por ocho...
	rra			;4aa2
	rra			;4aa3
	rra			;4aa4
	rr d		;4aa5
	rra			;4aa7
	rr d		;4aa8
	rra			;4aaa
	rr d		;4aab
	ld l,d			;4aad   ; ...con lo que L acaba siendo (A & 0x38) * 4 + D / 8, o sea fila * 32 mas columna dentro de la fila
	and 003h		;4aae   ; de A solo sobreviven sus dos bits altos, los que pasan de 256: por eso la fila da la vuelta a las 32
	ld e,(iy+009h)		;4ab0   ; (iy+9) es el numero de jugador dentro del bloque; el `dec e` es la comparacion y el `ld e` de despues no toca las banderas
	dec e			;4ab3
	ld e,0e4h		;4ab4
	jr z,L_4ABA		;4ab6
	ld e,0ech		;4ab8
L_4ABA:
	add a,e			;4aba   ; el jugador 1 pinta en E400 y el 2 en EC00
	ld h,a			;4abb
	ret			;4abc
SALTA_A_PALABRA_A:		; despachador con la tabla pegada detras del `call`: salta a la palabra A de las que siguen a la llamada, y ya no vuelve aqui
	ex (sp),hl			;4abd   ; `ex (sp),hl` cambia HL por la direccion de vuelta, que es justo el principio de la tabla
	push de			;4abe
	add a,a			;4abf   ; el indice por dos, que son palabras
	ld e,a			;4ac0
	ld d,000h		;4ac1
	add hl,de			;4ac3
	ld e,(hl)			;4ac4
	inc hl			;4ac5
	ld d,(hl)			;4ac6
	ex de,hl			;4ac7   ; el destino a HL...
	pop de			;4ac8
	ex (sp),hl			;4ac9   ; ...y de vuelta a la pila: el `ret` de debajo es el salto, y HL y DE salen como entraron. La usa p03 0xA065, el despachador que en su dia se trazaba como codigo
	ret			;4aca
SALTA_A_PALABRA_A_ALTERNO:		; lo mismo con los registros alternos: no toca HL, DE ni BC, y ademas le cambia el AF al destino
	exx			;4acb   ; exx antes de tocar nada: la cuenta se hace con HL' y DE'
	pop hl			;4acc   ; la direccion de vuelta es el principio de la tabla
	add a,a			;4acd
	ld e,a			;4ace
	ld d,000h		;4acf
	add hl,de			;4ad1
	ld e,(hl)			;4ad2
	inc hl			;4ad3
	ld d,(hl)			;4ad4
	push de			;4ad5   ; el destino se empuja como nueva direccion de vuelta, y el `ret` de abajo lo consume
	exx			;4ad6
	ex af,af'			;4ad7   ; el `ex af,af'` es parte del acuerdo: al destino le llega el A del otro juego. La llama p01 0x7C46
	ret			;4ad8
FILA_TABLA_EB00_IX:		; como 0x4ADC, con el desplazamiento sacado de (ix+4)
	ld e,(ix+004h)		;4ad9
FILA_TABLA_EB00:		; HL = EB00 + fila*2 (jugador 1) o EB80 + fila*2 (el 2): una palabra por cada una de las 32 filas del buffer circular
	ld a,(iy+040h)		;4adc   ; la misma fila que calcula 0x4A9D -camara (iy+40) mas el desplazamiento E, entre ocho- pero aqui en palabras y sin columna
	add a,e			;4adf
	rra			;4ae0
	rra			;4ae1
	and 03eh		;4ae2   ; dos rotaciones y `and 0x3E`: eso es (fila mod 32) * 2
	bit 0,(ix+009h)		;4ae4   ; el bit 0 del numero de jugador reparte las dos tablas, igual que 0x4AB0 reparte los dos buffers
	jr nz,L_4AEC		;4ae8
	add a,080h		;4aea
L_4AEC:
	ld l,a			;4aec
	ld h,0ebh		;4aed
	ret			;4aef
FILA_TABLA_EB00_IY:		; igual, pero el jugador sale de (iy+9) en vez de (ix+9)
	ld a,(iy+040h)		;4af0
	add a,e			;4af3   ; la unica diferencia con 0x4ADC es de donde sale el jugador: aqui de IY
	rra			;4af4
	rra			;4af5
	and 03eh		;4af6
	bit 0,(iy+009h)		;4af8
	jr nz,L_4B00		;4afc
	add a,080h		;4afe
L_4B00:
	ld l,a			;4b00
	ld h,0ebh		;4b01
	ret			;4b03
NIEGA_HL:		; HL = -HL, que el Z80 no tiene `neg` de 16 bits
	ld a,h			;4b04   ; complementa los dos bytes...
	cpl			;4b05
	ld h,a			;4b06
	ld a,l			;4b07
	cpl			;4b08
	ld l,a			;4b09
	inc hl			;4b0a   ; ...y suma uno: complemento a dos. Los tres llamadores estan en p03 (0xACA9, 0xAD74, 0xB25A) y los tres entran con `call c,`
	ret			;4b0b
BUSCA_TILE_EN_VENTANA:		; acarreo si en la ventana de B columnas por C filas que empieza en HL hay algun tile entre D y D+E-1
	push bc			;4b0c   ; se guarda el principio de la fila para poder volver a el
	push hl			;4b0d
BUSCA_TILE_FILA:		; una casilla por vuelta
	ld a,(hl)			;4b0e   ; el `sub d` y el `cp e` juntos preguntan "esta el tile en [D, D+E)" con una sola resta y sin ramas
	sub d			;4b0f
	cp e			;4b10
	jr c,BUSCA_TILE_ENCONTRADO		;4b11
	inc hl			;4b13
	djnz BUSCA_TILE_FILA		;4b14
	pop hl			;4b16   ; fila recorrida sin encontrarlo: a la de abajo, 32 casillas mas alla y sin salirse del kilobyte del buffer (el bit 2 de H)
	ld bc,00020h		;4b17
	res 2,h		;4b1a
	add hl,bc			;4b1c
	set 2,h		;4b1d
	pop bc			;4b1f
	dec c			;4b20
	jr nz,BUSCA_TILE_EN_VENTANA		;4b21
	or a			;4b23   ; recorrida la ventana entera: el `or a` apaga el acarreo, que es la respuesta "no hay"
	ret			;4b24
BUSCA_TILE_ENCONTRADO:		; sale con el acarreo puesto
	pop hl			;4b25   ; el `pop hl` devuelve HL al principio de la FILA, asi que la casilla exacta se pierde: lo unico que se contesta es si hay o no hay. Al unico llamador, p02 0x8E98, le basta: mira 5 x 2 casillas bajo el coche para saber si esta en la calle de boxes
	pop bc			;4b26
	ret			;4b27
HL_A_BCD:		; HL binario -> seis digitos BCD en C:D:E (E las unidades), doblando y ajustando
	ld b,000h		;4b28   ; B es el peldano entre HL y el BCD: los bits salen de HL por arriba, entran en B por abajo, y de B pasan a E
	exx			;4b2a
	ld b,018h		;4b2b   ; 24 vueltas y no 16: los 16 bits de HL mas las 8 que tardan en cruzar B
	exx			;4b2d
	ld de,00000h		;4b2e   ; el resultado arranca a cero, los seis digitos
	ld c,d			;4b31
HL_A_BCD_BUCLE:		; un bit por vuelta
	add hl,hl			;4b32   ; doblar el numero y meterle por abajo el bit que sale por arriba
	ld a,b			;4b33
	adc a,a			;4b34
	ld b,a			;4b35
	ld a,e			;4b36
	adc a,a			;4b37
	daa			;4b38   ; el `daa` detras del `adc a,a` es lo que hace que el doble sea en BCD: sin el saldria el mismo numero en hexadecimal
	ld e,a			;4b39
	ld a,d			;4b3a
	adc a,a			;4b3b
	daa			;4b3c
	ld d,a			;4b3d
	ld a,c			;4b3e
	adc a,a			;4b3f
	daa			;4b40
	ld c,a			;4b41
	exx			;4b42   ; la cuenta va en B' porque B esta ocupado haciendo de peldano
	dec b			;4b43
	exx			;4b44
	jr nz,HL_A_BCD_BUCLE		;4b45
	ret			;4b47
COPIA_RECTANGULO_BUFFER:		; C filas de B bytes de (HL') a la casilla que da 0x4A9D. SIN LLAMADOR, y con el se caen 0x4B4B y COPIA_B_BYTES_ALTERNO
	call CASILLA_BUFFER_NOMBRES		;4b48
COPIA_RECTANGULO_FILA:		; una fila por vuelta
	push hl			;4b4b
	push bc			;4b4c
	call COPIA_B_BYTES_ALTERNO		;4b4d
	pop bc			;4b50
	pop hl			;4b51
	ld de,00020h		;4b52   ; 32 casillas mas abajo, con la vuelta dentro del kilobyte
	res 2,h		;4b55   ; el truco de la vuelta: borrar el bit 2 de H es restar 0x400 y volver a ponerlo es sumarlo, asi que si el `add` se sale del kilobyte el acarreo cae justo en ese bit y se lo traga. E7E0 -> E3E0 -> E400: de la fila 31 a la 0
	add hl,de			;4b57
	set 2,h		;4b58
	dec c			;4b5a
	jr nz,COPIA_RECTANGULO_FILA		;4b5b
	ret			;4b5d
COPIA_B_BYTES_ALTERNO:		; copia B bytes de (HL') a (HL): el origen va en el juego alterno de registros y el destino en el principal, alternando con exx
	exx			;4b5e
	ld a,(hl)			;4b5f
	inc hl			;4b60   ; el origen va en HL' y el destino en HL, y el `exx` cambia de uno a otro en cada byte
	exx			;4b61
	ld (hl),a			;4b62
	inc hl			;4b63
	djnz COPIA_B_BYTES_ALTERNO		;4b64
	ret			;4b66
RELLENA_RECTANGULO_BUFFER:		; el mismo rectangulo pero de un solo byte, el A que traiga quien llama
	ex af,af'			;4b67   ; el byte a escribir se aparta en A' porque 0x4A9D usa A para su cuenta; a la vuelta se recupera, y el `ex af,af'` de 0x4B6C lo vuelve a apartar
	call CASILLA_BUFFER_NOMBRES		;4b68
	ex af,af'			;4b6b
RELLENA_RECTANGULO:		; con la casilla ya en HL y el byte en A. La llaman p01 0x69DB (22 x 15 de tile 0) y p02 0x8258 y 0x8378
	ex af,af'			;4b6c
RELLENA_RECTANGULO_FILA:		; una fila por vuelta
	push bc			;4b6d   ; una fila por vuelta, con el rectangulo entero en B y C
	push hl			;4b6e
	call RELLENA_B_BYTES		;4b6f
	pop hl			;4b72
	pop bc			;4b73
	ld de,00020h		;4b74   ; la misma bajada de fila con vuelta que 0x4B52
	res 2,h		;4b77
	add hl,de			;4b79
	set 2,h		;4b7a
	dec c			;4b7c
	jr nz,RELLENA_RECTANGULO_FILA		;4b7d
	ret			;4b7f
RELLENA_B_BYTES:		; B veces el byte que espera en A'
	ex af,af'			;4b80
	ld (hl),a			;4b81
	ex af,af'			;4b82   ; el byte vive en A' toda la vuelta: asi el bucle no gasta ningun registro del juego principal
	inc hl			;4b83
	djnz RELLENA_B_BYTES		;4b84
	ret			;4b86
RELLENA_RAM_CERO:		; (HL..HL+BC) = 0, por 0x4B88
	xor a			;4b87
RELLENA_RAM:		; (HL..HL+BC) = A, por ldir
	ld d,h			;4b88   ; el destino va un byte por delante del origen: se siembra el primero a mano y el `ldir` lo arrastra, asi que se llenan BC+1 bytes
	ld e,l			;4b89
	inc de			;4b8a
	ld (hl),a			;4b8b
	ldir		;4b8c
	ret			;4b8e
PINTA_ROTULO:		; el rotulo comprimido (DE), expandido en EC02 y pintado donde diga su propio codigo de posicion
	ex de,hl			;4b8f   ; 0x690A es de la pagina 1 -la que llama siempre-: expande el texto en EC02 y lo cierra con 0xFF
	call 0690ah		;4b90
	ld de,0ec02h		;4b93
	jp PINTA_TILES_TEXTO_POSICION		;4b96   ; y 0x483D lo recorre desde el codigo de posicion, poniendo de tile la letra menos 0x20
BORRA_ROTULO:		; el mismo recorrido con el tile 0: borra lo que pinto 0x4B8F, y en el mismo sitio
	ex de,hl			;4b99   ; hay que volver a expandirlo porque el sitio lo manda el propio texto: el codigo de posicion va dentro
	call 0690ah		;4b9a
	ld de,0ec02h		;4b9d
	jp BORRA_TILES_TEXTO		;4ba0   ; la unica diferencia con 0x4B8F es a donde salta: 0x4839 escribe el tile 0 en vez de la letra
CARGA_TILES_CIRCUITO_MITAD:		; la carrera (E25C) por la SEGUNDA mitad de la tabla p04 0x61A9. SIN LLAMADOR
	call MAPEA_4_5_6		;4ba3
	ld a,(0e25ch)		;4ba6
	ld hl,061d3h		;4ba9   ; 0x61D3 es la entrada 21 de esa tabla: los 21 punteros que apuntan a la MITAD de las listas largas, para recargar solo lo que falta
	call HL_PALABRA_A		;4bac
	jp CARGA_LISTA_TILES		;4baf
COLORES_0_210_A_CERO:		; la tabla de colores de los tiles 0..210 (0x698 bytes desde 0x0000) a cero, en los 3 tercios
	ld hl,00000h		;4bb2   ; los colores viven en la VRAM desde 0x0000 y los patrones desde 0x2000
	ld bc,00698h		;4bb5   ; 0x698 bytes son 211 tiles de 8 filas: del 0 al 210, o sea todo lo que no es el panel
	xor a			;4bb8
LLENA_VRAM_3_TERCIOS_B:		; como 0x47E6: FILVRM de BC bytes de A en HL, HL+0x800 y HL+0x1000
	ld d,003h		;4bb9   ; en el modo 2 cada tercio de pantalla tiene su propia tabla, 0x800 mas alla; borrar un tile es borrarlo tres veces
BUCLE_LLENA_TERCIO_B:		; un tercio por vuelta
	push de			;4bbb   ; los tres tercios se hacen a mano porque FILVRM no sabe de tercios: se le llama tres veces con la misma cuenta
	push hl			;4bbc
	push bc			;4bbd
	push af			;4bbe
	call 00056h		;4bbf   ; BIOS FILVRM - Fills VRAM with value
	pop af			;4bc2
	pop bc			;4bc3
	pop hl			;4bc4
	ld de,00800h		;4bc5
	add hl,de			;4bc8
	pop de			;4bc9
	dec d			;4bca
	jr nz,BUCLE_LLENA_TERCIO_B		;4bcb
	ret			;4bcd

; ----------------------------------------------------------------------
; Los graficos de la pista: la lista comun 0x61FD (tiles 206-209) y
; la lista de la carrera (E25C) de la tabla p04 0x61A9 (tiles 1-205:
; la pista y los decorados; el panel son los tiles 206-255).
; El cargador de verdad es 0x4CCD, y lo unico que hace es recorrer una
; lista de la pagina 4. Todo lo de aqui arriba es elegir QUE lista
; -la comun, la de la carrera (E25C), la del panel, la de la
; categoria (E25B)- y en QUE MODO, que es la variable E1D4:
; 0          el tile entero, patrones y colores
; 0x80 + f   solo la fila f de los patrones de cada tile
; 0xC0 + f   solo la fila f de los colores
; Cargando fila a fila con una espera en medio, el dibujo aparece de
; arriba abajo en vez de salir de golpe: eso es el efecto de entrada
; del panel.
; ----------------------------------------------------------------------
CARGA_TILES_CIRCUITO:		; lista p04 0x61FD y la de la carrera (E25C) de la tabla p04 0x61A9
	ld hl,061fdh		;4bce   ; la lista comun primero: los cuatro tiles (206-209) que llevan todas las carreras
	call CARGA_LISTA_TILES		;4bd1
	call MAPEA_4_5_6		;4bd4   ; hay que volver a mapear 4/5/6 porque 0x4CCD deja puestas 1/2/3 al salir
	ld a,(0e25ch)		;4bd7   ; E25C es la carrera, y la tabla p04 0x61A9 da su lista de tiles
	ld hl,061a9h		;4bda
	call HL_PALABRA_A		;4bdd
	jp CARGA_LISTA_TILES		;4be0   ; `jp` y no `call`: la vuelta de 0x4CCD es ya la vuelta de aqui
CARGA_TILES_CIRCUITO_2_PASOS:		; 0x4689 (sprites de los coches), 0x450C con D/E/F, las listas de 0x4BCE, y los colores por filas 0-3 (0x4CA1), p01 0x6EF8, 0x477C, y filas 4-7 (0x4CA8)
	call FOTOGRAMAS_COCHES		;4be3   ; la version de dos pasos: los tiles de la carrera ya estan, y de la lista larga se vuelven a pasar solo los COLORES, en dos mitades
	call MAPEA_D_E_F		;4be6
	call PINTA_VENTANA_PISTA		;4be9
	ld hl,061fdh		;4bec   ; la lista comun si va entera, tiles y colores
	call CARGA_LISTA_TILES		;4bef
	call MAPEA_4_5_6		;4bf2
	ld a,(0e25ch)		;4bf5
	ld hl,061a9h		;4bf8
	call HL_PALABRA_A		;4bfb
	push hl			;4bfe   ; se guarda el puntero de la lista: hay que recorrerla dos veces, una por cada mitad
	ld de,00001h		;4bff   ; DE es la espera entre filas; con 1 no hay efecto, se carga de golpe
	call CARGA_COLORES_FILAS_0_3		;4c02
	call 06ef8h		;4c05   ; entre las dos mitades se cuelan p01 0x6EF8 y el volcado de sprites: eso es lo que justifica partir la carga en dos y no hacerla de una
	call SPRITES_A_VRAM		;4c08
	pop hl			;4c0b
	ld de,00001h		;4c0c
	jp CARGA_COLORES_FILAS_4_7		;4c0f   ; y la segunda mitad cierra la rutina
CARGA_TILES_PANEL:		; listas p04 0x6BBD y 0x6C7C (tiles 210-255) y la de la categoria (E25B) de la tabla 0x4C37 (tiles 250-255); con el bit 5 de E1C2 (dos jugadores) la lista 0x6C36
	ld a,(0e1c2h)		;4c12
	bit 5,a		;4c15   ; bit 5 de E1C2: dos jugadores. Su panel es otro dibujo y cabe en una sola lista
	jr nz,CARGA_TILES_PANEL_2J		;4c17
	ld hl,06bbdh		;4c19   ; el panel de un jugador va en dos listas seguidas...
	call CARGA_LISTA_TILES		;4c1c
	ld hl,06c7ch		;4c1f
	call CARGA_LISTA_TILES		;4c22
	ld hl,04c37h		;4c25   ; ...mas una tercera, la parte que cambia con la categoria (E25B). Aqui el indice NO se recorta, y en la gemela de 0x4C70 si: si E25B pasara de 5, esto leeria una palabra fuera de la tabla de 0x4C37
	ld a,(0e25bh)		;4c28
	call HL_PALABRA_A		;4c2b
	jp CARGA_LISTA_TILES		;4c2e   ; la tercera lista cierra
CARGA_TILES_PANEL_2J:		; la lista p04 0x6C36 (el panel de dos jugadores)
	ld hl,06c36h		;4c31
	jp CARGA_LISTA_TILES		;4c34

; ----------------------------------------------------------------------
; DATOS tabla_listas_panel: 6 punteros por la categoria (E25B) a la lista de
;   la parte del panel que cambia con ella (p04 0x6C6F, 0x6C62, 0x6C55: tiles
;   250-255); 0x4C70 la limita a 5
;   0x4c37..0x4c43  (12 bytes)
DATA_tabla_listas_panel:
	defw 06c6fh	; 4c37
	defw 06c6fh	; 4c39
	defw 06c62h	; 4c3b
	defw 06c55h	; 4c3d
	defw 06c55h	; 4c3f
	defw 06c55h	; 4c41

; ======================================================================
; CODIGO 0x4c43..0x4e37  (500 bytes)
; ======================================================================


CARGA_TILES_PANEL_POR_FILAS:		; colores de los tiles 211-251 a cero (3 tercios) y los de 252-255 del tercio de abajo; luego el panel (las listas de 0x4C12) cargado fila a fila con 0x4C93
	ld hl,00698h		;4c43   ; 0x698 es el primer byte de colores del tile 211: antes de pintar el panel se le borran los colores
	ld bc,00148h		;4c46   ; 0x148 son 41 tiles de 8 filas: del 211 al 251
	xor a			;4c49
	call LLENA_VRAM_3_TERCIOS_B		;4c4a
	ld hl,017e0h		;4c4d   ; y los cuatro ultimos (252-255) solo en el tercio de abajo, que es donde se ven: 0x17E0 = 0x1000 del tercio mas 252 * 8
	ld bc,00020h		;4c50
	xor a			;4c53
	call 00056h		;4c54   ; BIOS FILVRM - Fills VRAM with value
	ld a,(0e1c2h)		;4c57   ; el mismo reparto de uno o dos jugadores que 0x4C12
	bit 5,a		;4c5a
	jr nz,CARGA_TILES_PANEL_2J_POR_FILAS		;4c5c
	ld hl,06bbdh		;4c5e
	ld de,00001h		;4c61   ; DE = 1: la espera es la minima, pero el recorrido sigue siendo fila a fila, y eso es lo que hace que el panel aparezca de arriba abajo
	call CARGA_LISTA_POR_FILAS		;4c64
	ld hl,06c7ch		;4c67
	ld de,00001h		;4c6a
	call CARGA_LISTA_POR_FILAS		;4c6d
	ld hl,04c37h		;4c70
	ld a,(0e25bh)		;4c73
	cp 005h		;4c76   ; aqui la categoria SI se recorta: de 5 en adelante se usa la ultima entrada de la tabla de 0x4C37
	jr c,L_4C7C		;4c78
	ld a,005h		;4c7a
L_4C7C:
	call HL_PALABRA_A		;4c7c
	ld de,00001h		;4c7f
	jr CARGA_LISTA_POR_FILAS		;4c82
CARGA_TILES_PANEL_2J_POR_FILAS:		; la lista p04 0x6C36 fila a fila
	ld hl,06c36h		;4c84   ; el panel de dos jugadores, tambien por filas
	ld de,00001h		;4c87
	jr CARGA_LISTA_POR_FILAS		;4c8a
CARGA_LISTA_UNA_FILA:		; una sola vuelta: la fila de patron que diga A. SIN LLAMADOR
	set 7,a		;4c8c   ; `set 7,a` es el modo "solo una fila"; B = 1 (una vuelta) y C = 0 (no hay siguiente)
	ld bc,00100h		;4c8e
	jr CARGA_LISTA_FILA_A_FILA		;4c91
CARGA_LISTA_POR_FILAS:		; la lista HL una fila de patron por vuelta (E1D4 = 0x80..0x87), con DE de espera entre filas: los tiles van apareciendo de arriba abajo
	ld a,080h		;4c93   ; E1D4 = 0x80 + fila: el bit 7 dice "de cada tile, solo una fila" y los tres de abajo dicen cual
	ld bc,00801h		;4c95   ; ocho vueltas y paso 1: las filas van de arriba abajo
	jr CARGA_LISTA_FILA_A_FILA		;4c98
CARGA_LISTA_POR_FILAS_AL_REVES:		; las ocho filas de abajo arriba (empieza en 0x87 y el paso es 0xFF). SIN LLAMADOR
	ld a,087h		;4c9a
	ld bc,008ffh		;4c9c
	jr CARGA_LISTA_FILA_A_FILA		;4c9f
CARGA_COLORES_FILAS_0_3:		; solo los colores de la lista HL, filas 0..3 (E1D4 = 0xC0..0xC3)
	ld a,0c0h		;4ca1   ; el bit 6 de E1D4 es el otro modo, "solo los colores": lo mira 0x4D32 para saltarse la parte de patrones
	ld bc,00401h		;4ca3
	jr CARGA_LISTA_FILA_A_FILA		;4ca6
CARGA_COLORES_FILAS_4_7:		; solo los colores de la lista HL, filas 4..7 (E1D4 = 0xC4..0xC7)
	ld a,0c4h		;4ca8   ; las cuatro de abajo, que es la mitad que carga 0x4C0F
	ld bc,00401h		;4caa
	jr CARGA_LISTA_FILA_A_FILA		;4cad
CARGA_COLORES_POR_FILAS:		; las ocho filas de colores de una tacada (0xC0 y paso 1). SIN LLAMADOR
	ld a,0c0h		;4caf
	ld bc,00801h		;4cb1
	jr CARGA_LISTA_FILA_A_FILA		;4cb4
CARGA_LISTA_FILA_A_FILA:		; B vueltas: E1D4 = A, espera DE, carga la lista HL (0x4CD1), A += C
	ld (0e1d4h),a		;4cb6   ; el modo viaja por una variable y no por un registro porque entre medias se llama a media pagina 4
	add a,c			;4cb9   ; A += C: con C = 1 las filas bajan, con 0xFF suben y con 0 se repite la misma
	push bc			;4cba   ; se guarda todo, que el cargador de tiles no respeta ningun registro
	push af			;4cbb
	push hl			;4cbc
	push de			;4cbd
ESPERA_DE:		; bucle de espera de DE vueltas
	dec de			;4cbe   ; un bucle vacio de DE vueltas: con DE = 1 la carga es de golpe, y cuanto mas grande sea DE mas despacio va apareciendo el dibujo
	ld a,e			;4cbf
	or d			;4cc0
	jr nz,ESPERA_DE		;4cc1   ; el bucle esta vacio a proposito: es tiempo, no cuenta
	call CARGA_LISTA_TILES_MODO		;4cc3
	pop de			;4cc6
	pop hl			;4cc7
	pop af			;4cc8
	pop bc			;4cc9
	djnz CARGA_LISTA_FILA_A_FILA		;4cca
	ret			;4ccc
CARGA_LISTA_TILES:		; HL = lista de registros de 6 bytes (pagina 4); E1D4 = 0 (tiles enteros); deja 1/2/3
	xor a			;4ccd   ; el modo 0 es el normal: el tile entero, patrones y colores
	ld (0e1d4h),a		;4cce
CARGA_LISTA_TILES_MODO:		; como 0x4CCD con el modo E1D4 que traiga: IX = lista, mapea 4/5/6, recorre, tile 0 a cero, vuelve a 1/2/3
	push hl			;4cd1   ; IX es el puntero que recorre la lista
	pop ix		;4cd2
	call MAPEA_4_5_6		;4cd4
	call RECORRE_LISTA		;4cd7
	call TILE_0_A_CERO		;4cda   ; el tile 0 acaba siempre en blanco, deje lo que deje la lista: es el que 0x465B usa para borrar la pantalla
	jp MAPEA_1_2_3		;4cdd   ; y se sale dejando 1/2/3 en el mapper, que es lo que espera quien llamo
RECORRE_LISTA:		; un registro (o una orden) por vuelta hasta el 0x00
	ld a,(ix+000h)		;4ce0   ; un 0x00 cierra la lista
	cp 000h		;4ce3
	ret z			;4ce5
	call REGISTRO_DE_LISTA		;4ce6
	jr RECORRE_LISTA		;4ce9
REGISTRO_DE_LISTA:		; 0x1x = orden (0x4E2D); si no, por cada tercio marcado en los bits 5/6/7 carga el registro (0x4D19) y salta los 6 bytes
	ld a,(ix+000h)		;4ceb   ; un 0x1x en el byte de flags no es un registro: es una orden para el propio cargador (0x4E2D)
	and 0f0h		;4cee
	cp 010h		;4cf0
	jp z,ORDEN_DE_LISTA		;4cf2
	bit 5,(ix+000h)		;4cf5   ; los bits 5, 6 y 7 dicen a que tercios va el registro -el 7 el de arriba, el 6 el de en medio y el 5 el de abajo-, y cada tercio se carga por separado
	ld de,01000h		;4cf9
	call nz,CARGA_REGISTRO_TERCIO		;4cfc
	bit 6,(ix+000h)		;4cff
	ld de,00800h		;4d03
	call nz,CARGA_REGISTRO_TERCIO		;4d06
	bit 7,(ix+000h)		;4d09
	ld de,00000h		;4d0d
	call nz,CARGA_REGISTRO_TERCIO		;4d10
	ld de,00006h		;4d13   ; seis bytes por registro: flags, tile, puntero a los patrones y puntero a los colores
	add ix,de		;4d16
	ret			;4d18

; ----------------------------------------------------------------------
; Un registro de lista son seis bytes: flags, tile, puntero a los
; patrones y puntero a los colores. Los dos punteros van a un grupo
; de paginas que dicen los flags, y lo que hay al otro lado no son
; bytes sueltos sino un RLE que se descomprime DIRECTAMENTE a la
; VRAM, de ocho en ocho bytes, con el tile de paso por EA50.
;
; Los flags del registro (copiados a EA6E antes de descomprimir):
; bits 2-1  grupo de paginas: 4, 7, 0x0A o 0x0D en 0x6000
; bit 3     voltea el tile de arriba abajo
; bit 4     lo espeja de izquierda a derecha
; bits 7-6-5  a que tercios de pantalla va (arriba, medio, abajo)
; Y EA6F.7 dice si lo que se esta pasando son patrones (0) o colores
; (1), que es lo unico que distingue las dos mitades del registro.
; ----------------------------------------------------------------------
CARGA_REGISTRO_TERCIO:		; el registro IX al tercio DE: patrones (tile*8 + tercio + 0x2000) salvo con el bit 6 de E1D4, y colores (tile*8 + tercio); EA6F.7 = 0 patrones, 1 colores
	ld hl,0ea6fh		;4d19   ; primero los patrones, asi que EA6F.7 a 0: es la marca que mira 0x4DFF para no espejar los colores
	res 7,(hl)		;4d1c
	ld l,(ix+001h)		;4d1e   ; el tile por ocho es su sitio en la tabla, y el tercio se suma encima
	ld h,000h		;4d21
	add hl,hl			;4d23
	add hl,hl			;4d24
	add hl,hl			;4d25
	add hl,de			;4d26
	push hl			;4d27   ; esa direccion, sin el 0x2000, es la de los COLORES: se guarda para la segunda mitad
	ld de,02000h		;4d28
	add hl,de			;4d2b   ; los patrones viven 0x2000 mas arriba que los colores
	ld e,(ix+002h)		;4d2c   ; el puntero a los patrones son los bytes 2 y 3 del registro
	ld d,(ix+003h)		;4d2f
	ld a,(0e1d4h)		;4d32   ; dos `rlca` dejan en el acarreo el bit 6 de E1D4: si esta puesto el modo es "solo colores" y toda esta mitad se salta
	rlca			;4d35
	rlca			;4d36
	call nc,RLE_DESDE_GRUPO		;4d37
	ld hl,0ea6fh		;4d3a   ; ahora si, los colores
	set 7,(hl)		;4d3d
	pop hl			;4d3f
	ld de,00000h		;4d40   ; sumar cero no hace nada: es la simetria con el `ld de,0x2000` de la otra mitad, que quedo escrita
	add hl,de			;4d43
	ld e,(ix+004h)		;4d44   ; y el puntero a los colores son los bytes 4 y 5
	ld d,(ix+005h)		;4d47
RLE_DESDE_GRUPO:		; mapea el grupo de los bits 2..1 de los flags (4, 7, A o D en 0x6000), descomprime DE en VRAM HL y vuelve a 4/5/6
	push ix		;4d4a
	ld a,(ix+000h)		;4d4c   ; los flags viajan por EA6E porque quien los mira, 0x4D97, esta cuatro llamadas mas abajo y con los registros llenos
	ld (0ea6eh),a		;4d4f
	and 006h		;4d52   ; los bits 2 y 1 valen grupo * 2; el `rrca` los baja a grupo y el `add a,c` los deja en grupo * 3
	ld c,a			;4d54
	rrca			;4d55
	add a,c			;4d56
	add a,004h		;4d57   ; mas cuatro: los cuatro grupos son las paginas 4, 7, 0x0A y 0x0D, y cada una arrastra a las dos siguientes
	call MAPEA_DESDE_A		;4d59
	call RLE_TILES		;4d5c
	pop ix		;4d5f
	jp MAPEA_4_5_6		;4d61   ; y se vuelve a 4/5/6, que es donde vive la lista que se esta recorriendo
RLE_TILES:		; el descompresor de los tiles: (DE) -> VRAM HL por bloques de 8 bytes (EA50). Codigos: 00 fin, 01..7F repetir el byte siguiente n veces, 80 nada, 81..FF copiar n&0x7F bytes
	push hl			;4d64
	push de			;4d65
	ld (0e1d2h),hl		;4d66   ; el destino se guarda tambien en E1D2 porque en el modo por filas hace falta saber donde iba cada tile
	call PREPARA_ESCRITURA_VRAM		;4d69
	exx			;4d6c
	ld hl,0ea50h		;4d6d   ; HL' es el tile que se va montando, ocho bytes en EA50: el RLE no escribe en la VRAM byte a byte, sino tile a tile
	exx			;4d70
	pop de			;4d71
	pop hl			;4d72
RLE_TILES_BUCLE:		; un codigo por vuelta
	ld a,(de)			;4d73   ; el codigo manda: 0x00 acaba, 0x01-0x7F repite, 0x80 no hace nada y 0x81-0xFF copia n & 0x7F bytes
	inc de			;4d74
	or a			;4d75
	ret z			;4d76
	ld b,a			;4d77
	and 07fh		;4d78   ; el `and 0x7f` y el `cp b` juntos son "estaba el bit 7 apagado", sin gastar una comparacion aparte
	cp b			;4d7a
	jr z,RLE_TILES_REPITE		;4d7b
	or a			;4d7d
	jr z,RLE_TILES_BUCLE		;4d7e   ; el 0x80 pelado: cero bytes que copiar
	ld b,a			;4d80
RLE_TILES_COPIA:		; n bytes tal cual, uno a uno por 0x4D97
	ld a,(de)			;4d81
	inc de			;4d82
	exx			;4d83
	call RLE_TILES_BYTE		;4d84   ; un byte por vuelta, y el `exx` de cada lado es para dejar el tile de paso en el otro juego
	exx			;4d87
	djnz RLE_TILES_COPIA		;4d88
	jr RLE_TILES_BUCLE		;4d8a
RLE_TILES_REPITE:		; el mismo byte n veces por 0x4D97
	ld a,(de)			;4d8c
	inc de			;4d8d
RLE_TILES_REPITE_BUCLE:		; una copia por vuelta
	exx			;4d8e
	call RLE_TILES_BYTE		;4d8f
	exx			;4d92
	djnz RLE_TILES_REPITE_BUCLE		;4d93
	jr RLE_TILES_BUCLE		;4d95
RLE_TILES_BYTE:		; acumula el byte en EA50..EA57; al octavo: espejo (bit 4 de EA6E), volteo (bit 3) y vuelca el tile al VDP (8 OUTI), o solo la fila E1D4&7 si E1D4 != 0
	ld (hl),a			;4d97   ; el byte al tile de paso...
	inc l			;4d98
	bit 3,l		;4d99   ; ...y hasta que no se llenan los ocho (EA50 a EA57, o sea que L pase a tener el bit 3) no se escribe nada en la VRAM
	ret z			;4d9b
	push af			;4d9c
	ld hl,0ea6eh		;4d9d
	bit 4,(hl)		;4da0   ; el espejo y el volteo se hacen aqui, con el tile ya montado y antes de soltarlo: por eso salen gratis
	call nz,ESPEJA_TILE		;4da2
	ld hl,0ea6eh		;4da5
	bit 3,(hl)		;4da8
	call nz,VOLTEA_TILE		;4daa
	ld a,(0e1d4h)		;4dad   ; con E1D4 a cero se vuelca el tile entero; si no, solo la fila que toque
	or a			;4db0
	jr nz,RLE_TILES_SOLO_FILA		;4db1
	ld hl,0ea50h		;4db3
	ld b,010h		;4db6   ; B vale 16 y no 8 porque `outi` ya resta uno por su cuenta y el `djnz` resta otro: ocho vueltas, ocho bytes
VUELCA_TILE_BUCLE:		; los 8 bytes del tile al VDP (B = 16, pero outi ya resta uno: 8 vueltas)
	outi		;4db8
	djnz VUELCA_TILE_BUCLE		;4dba
	ld hl,0ea50h		;4dbc
	pop af			;4dbf
	ret			;4dc0
RLE_TILES_SOLO_FILA:		; modo por filas: escribe solo el byte (E1D4&7) del tile en (E1D2) + fila, y E1D2 += 8
	push bc			;4dc1
	ld hl,(0e1d2h)		;4dc2   ; el modo por filas escribe UN byte por tile, y va apuntando en E1D2 por donde iba
	ld e,l			;4dc5
	ld d,h			;4dc6
	ld bc,00008h		;4dc7   ; el siguiente tile son ocho bytes mas alla, se escriba lo que se escriba de este
	add hl,bc			;4dca
	ld (0e1d2h),hl		;4dcb
	and 007h		;4dce   ; los tres bits de abajo de E1D4 son la fila
	ld l,a			;4dd0
	ld h,000h		;4dd1
	ex de,hl			;4dd3
	add hl,de			;4dd4
	push hl			;4dd5
	exx			;4dd6
	ex (sp),hl			;4dd7
	call PREPARA_ESCRITURA_VRAM		;4dd8   ; aqui hay que preparar la VRAM en cada byte, que no son consecutivos
	pop hl			;4ddb
	exx			;4ddc
	ld hl,0ea50h		;4ddd
	add hl,de			;4de0   ; y de EA50 se saca justo la fila que se pide
	ld a,(hl)			;4de1
	out (c),a		;4de2
	ld hl,0ea50h		;4de4
	pop bc			;4de7
	pop af			;4de8
	ret			;4de9
VOLTEA_TILE:		; volteo vertical: intercambia las filas 0-7, 1-6, 2-5, 3-4 de EA50
	push bc			;4dea
	ld hl,0ea50h		;4deb   ; el volteo vertical se hace cambiando la fila 0 por la 7, la 1 por la 6, la 2 por la 5 y la 3 por la 4: cuatro parejas
	ld de,0ea57h		;4dee
	ld b,004h		;4df1
VOLTEA_TILE_BUCLE:		; una pareja de filas por vuelta
	ld c,(hl)			;4df3   ; una pareja por vuelta, un puntero subiendo y otro bajando
	ld a,(de)			;4df4
	ex de,hl			;4df5
	ld (hl),c			;4df6   ; las dos filas se cambian a la vez, una con C y otra con A
	ld (de),a			;4df7
	ex de,hl			;4df8
	inc l			;4df9
	dec e			;4dfa
	djnz VOLTEA_TILE_BUCLE		;4dfb
	pop bc			;4dfd
	ret			;4dfe
ESPEJA_TILE:		; espejo horizontal: invierte los 8 bits de cada fila (no con los colores: bit 7 de EA6F)
	ld hl,0ea6fh		;4dff   ; los colores no se espejan: en el modo 2 el byte de color de una fila no tiene izquierda ni derecha, son el color de la tinta y el del fondo
	bit 7,(hl)		;4e02
	ret nz			;4e04
	push bc			;4e05
	ld hl,0ea50h		;4e06
	ld c,008h		;4e09
ESPEJA_TILE_FILA:		; una fila por vuelta
	ld b,008h		;4e0b   ; ocho filas...
ESPEJA_TILE_BIT:		; un bit por vuelta (rr (hl) / rla)
	rr (hl)		;4e0d   ; ...y ocho bits por fila: `rr (hl)` va soltando el bit de abajo y `rla` lo va recogiendo por arriba, que es dar la vuelta al byte
	rla			;4e0f
	djnz ESPEJA_TILE_BIT		;4e10
	ld (hl),a			;4e12
	inc l			;4e13
	dec c			;4e14
	jr nz,ESPEJA_TILE_FILA		;4e15
	pop bc			;4e17
	ret			;4e18
TILE_0_A_CERO:		; patrones y colores del tile 0 a cero en los 3 tercios
	ld hl,02000h		;4e19   ; el tile 0 se deja siempre en blanco, patrones y colores, porque es el que 0x465B usa para borrar la pantalla
	ld bc,00008h		;4e1c
	xor a			;4e1f
	call LLENA_VRAM_3_TERCIOS		;4e20
	ld hl,00000h		;4e23
	ld bc,00008h		;4e26
	xor a			;4e29
	jp LLENA_VRAM_3_TERCIOS		;4e2a
ORDEN_DE_LISTA:		; despacha por los bits 1..0 de la orden (tabla 0x4E37)
	exx			;4e2d
	ld a,(ix+000h)		;4e2e   ; la orden entera se guarda en D' antes de quedarse con los dos bits de abajo: las variantes (bit 2, bits 3-4) las mira cada rama por su cuenta
	ld d,a			;4e31
	and 003h		;4e32
	call DESPACHA		;4e34

; ----------------------------------------------------------------------
; DATOS tabla_4E34: 4 palabras del despachador de 0x4E34 (indice (ix+0)&3)
;   0x4e37..0x4e3f  (8 bytes)
DATA_tabla_4E34:
	defw 04e3fh	; 4e37  -> ORDEN_COPIA_E263
	defw 04e51h	; 4e39  -> ORDEN_PALABRA_E276
	defw 04e6fh	; 4e3b  -> ORDEN_NADA
	defw 04e70h	; 4e3d  -> ORDEN_SUBLISTA

; ======================================================================
; CODIGO 0x4e3f..0x4fb2  (371 bytes)
; ======================================================================


ORDEN_COPIA_E263:		; 0x10: los 16 bytes que siguen a E263 (17 bytes de lista)
	push ix		;4e3f   ; la orden 0x10 lleva pegados 16 bytes que van tal cual a E263...
	pop hl			;4e41
	inc hl			;4e42
	ld de,0e263h		;4e43
	ld bc,00010h		;4e46
	ldir		;4e49
	ld de,00011h		;4e4b   ; ...y por eso ocupa 17 bytes de lista, uno mas que los datos
	add ix,de		;4e4e
	ret			;4e50
ORDEN_PALABRA_E276:		; 0x11/15/19/1D: la palabra que sigue a E276 + ((orden>>1)&6) (3 bytes de lista)
	exx			;4e51
	ld a,(ix+000h)		;4e52   ; la orden 0x11 y sus variantes 0x15, 0x19 y 0x1D: el `rrca` y el `and 6` las convierten en 0, 2, 4 y 6, o sea en cuatro palabras seguidas desde E276
	rrca			;4e55
	and 006h		;4e56
	ld e,a			;4e58
	ld d,000h		;4e59
	push ix		;4e5b
	pop hl			;4e5d
	inc hl			;4e5e
	ld c,(hl)			;4e5f   ; la palabra viene detras de la orden, en la propia lista
	inc hl			;4e60
	ld b,(hl)			;4e61
	ld hl,0e276h		;4e62
	add hl,de			;4e65
	ld (hl),c			;4e66
	inc hl			;4e67
	ld (hl),b			;4e68
	ld de,00003h		;4e69   ; tres bytes: la orden y su palabra
	add ix,de		;4e6c
	ret			;4e6e
ORDEN_NADA:		; 0x12: ret sin avanzar IX (se quedaria en bucle: ninguna lista la usa)
	ret			;4e6f   ; sin `add ix,de`: si alguna lista trajese un 0x12, el recorrido se quedaria dando vueltas sobre el mismo byte
ORDEN_SUBLISTA:		; 0x13: recorre la lista que sigue (puntero) y sigue con esta; 0x17 (bit 2) -> 0x4E8C
	bit 2,(ix+000h)		;4e70   ; la orden 0x13 mete una lista dentro de otra; la 0x17, que es la misma con el bit 2, es otra cosa
	jr nz,ORDEN_RECURSO		;4e74
	push ix		;4e76
	ld l,(ix+001h)		;4e78   ; el puntero a la sublista viene detras de la orden
	ld h,(ix+002h)		;4e7b
	push hl			;4e7e
	pop ix		;4e7f
	call RECORRE_LISTA		;4e81   ; y se recorre con la misma rutina: una lista puede llamar a otra
	pop ix		;4e84
	ld de,00003h		;4e86
	add ix,de		;4e89
	ret			;4e8b
ORDEN_RECURSO:		; 0x17: el recurso [1] de la tabla de 85 en el tile [2] (0x4E9F)
	push ix		;4e8c
	ld a,(ix+001h)		;4e8e   ; la orden 0x17: el recurso [1] de la tabla de 85 cargado en el tile [2]
	ld c,(ix+002h)		;4e91
	call CARGA_RECURSO_85		;4e94
	pop ix		;4e97
	ld de,00003h		;4e99
	add ix,de		;4e9c
	ret			;4e9e
CARGA_RECURSO_85:		; A = recurso de la TABLA DE 85 de p04 0x6000 (5 bytes), C = tile: monta el registro de 6 bytes en EA60 y lo carga con 0x4CE0
	ld ix,0ea60h		;4e9f   ; EA60 es un registro de seis bytes montado a mano, para poder pasarle al cargador algo que en la lista no estaba escrito
	ld (ix+001h),c		;4ea3
	ld l,a			;4ea6
	ld h,000h		;4ea7
	ld d,h			;4ea9
	ld e,l			;4eaa
	add hl,hl			;4eab   ; el recurso por cinco: las entradas de la tabla p04 0x6000 son de cinco bytes
	add hl,hl			;4eac
	add hl,de			;4ead
	add a,b			;4eae   ; suma que no se usa (A se pierde en el ld a,(hl) de 0x4EB3)
	ld de,06000h		;4eaf
	add hl,de			;4eb2
	ld a,(hl)			;4eb3   ; el primer byte del recurso son los flags, que en un registro van los primeros...
	inc hl			;4eb4
	ld (ix+000h),a		;4eb5
	ld de,0ea62h		;4eb8   ; ...y los otros cuatro son los dos punteros, que van a EA62
	ld bc,00004h		;4ebb
	ldir		;4ebe
	ld (ix+006h),000h		;4ec0   ; el 0x00 de detras cierra la lista de un solo registro
	jp RECORRE_LISTA		;4ec4
CARGA_SPRITES_CARRERA:		; 4/5/6: la lista p04 0x74A5, EB40 a cero, la lista de la categoria (E25B) de la tabla p04 0x7481 (la primera palabra de cada tres), rellena EB40 (0x4F02), 1/2/3; con E25B = 0, EB41 = EB42 = EB40
	call MAPEA_4_5_6		;4ec7   ; la lista comun de sprites primero: la traen todas las carreras
	ld hl,074a5h		;4eca
	call LISTA_SPRITES		;4ecd
	call BORRA_EB40		;4ed0
	call MAPEA_4_5_6		;4ed3
	ld a,(0e25bh)		;4ed6   ; E25B es la categoria; su entrada en la tabla p04 0x7481 ocupa tres palabras y aqui solo se usa la primera
	ld b,a			;4ed9
	add a,a			;4eda
	add a,b			;4edb
	ld hl,07481h		;4edc
	call HL_PALABRA_A		;4edf
	call LISTA_SPRITES		;4ee2
	call RELLENA_EB40		;4ee5   ; lo que la categoria no haya puesto se rellena con lo que puso la lista comun
	call MAPEA_1_2_3		;4ee8
	ld a,(0e25bh)		;4eeb   ; en la categoria 0 hay ademas dos ranuras que se igualan a mano a la primera
	or a			;4eee
	ret nz			;4eef
	ld hl,0eb40h		;4ef0
	ld a,(hl)			;4ef3
	inc hl			;4ef4
	ld (hl),a			;4ef5
	inc hl			;4ef6
	ld (hl),a			;4ef7
	ret			;4ef8
BORRA_EB40:		; EB40..EB4E a cero (15 bytes)
	ld hl,0eb40h		;4ef9   ; quince en BC, pero se borran dieciseis: RELLENA_RAM siembra el primer byte y el `ldir` copia otros BC
	ld bc,0000fh		;4efc
	jp RELLENA_RAM_CERO		;4eff
RELLENA_EB40:		; las entradas a cero de EB40..EB4F toman el valor de EB40
	ld hl,0eb40h		;4f02   ; EB40 es el patron por defecto: el que se queda en las ranuras que nadie lleno
	ld c,(hl)			;4f05
	ld b,010h		;4f06
	xor a			;4f08
RELLENA_EB40_BUCLE:		; una entrada por vuelta
	cp (hl)			;4f09   ; una ranura por vuelta, las dieciseis
	jr nz,L_4F0D		;4f0a
	ld (hl),c			;4f0c
L_4F0D:
	inc l			;4f0d
	djnz RELLENA_EB40_BUCLE		;4f0e
	ret			;4f10
CARGA_LISTA_SPRITES:		; mapea 4/5/6, carga la lista HL (0x4F1A) y vuelve a 1/2/3
	call MAPEA_4_5_6		;4f11   ; el par mapear / cargar / desmapear, para quien tenga la lista a mano
	call LISTA_SPRITES		;4f14
	jp MAPEA_1_2_3		;4f17
LISTA_SPRITES:		; un par (recurso, patron) por vuelta hasta 0xFF
	ld a,(hl)			;4f1a   ; la lista de sprites es mas simple que la de tiles: parejas de recurso y patron, y un 0xFF al final
	cp 0ffh		;4f1b
	ret z			;4f1d
	inc hl			;4f1e
	ld b,(hl)			;4f1f
	inc hl			;4f20
	push hl			;4f21
	call CARGA_RECURSO_SPRITE		;4f22
	pop hl			;4f25
	jr LISTA_SPRITES		;4f26
CARGA_RECURSO_SPRITE:		; el registro A de la tabla p04 0x7505; EB40+clase = patron B; IX = VRAM 0x1800 + B*8; tipo 0 -> RLE_A_VRAM, 1 -> nada, 2 -> LDIRVM de [4..5] bytes, FF -> nada
	ld l,a			;4f28   ; el recurso por seis: las entradas de la tabla p04 0x7505 son de seis bytes
	ld h,000h		;4f29
	add hl,hl			;4f2b
	ld d,h			;4f2c
	ld e,l			;4f2d
	add hl,hl			;4f2e
	add hl,de			;4f2f
	ld de,07505h		;4f30
	add hl,de			;4f33
	ld a,040h		;4f34   ; el primer byte del recurso no es un dato, es un indice: dice en que ranura de EB40 se apunta el patron con el que se acaba de cargar
	add a,(hl)			;4f36
	ld e,a			;4f37
	inc hl			;4f38
	ld d,0ebh		;4f39
	ld a,b			;4f3b
	ld (de),a			;4f3c
	push hl			;4f3d
	ld l,a			;4f3e   ; el patron por ocho es su sitio en la tabla de patrones de sprites, que empieza en la VRAM 0x1800
	ld h,000h		;4f3f
	add hl,hl			;4f41
	add hl,hl			;4f42
	add hl,hl			;4f43
	ld de,01800h		;4f44
	add hl,de			;4f47
	push hl			;4f48
	pop ix		;4f49
	pop hl			;4f4b
	ld a,(hl)			;4f4c   ; y el segundo byte es el tipo: 0xFF y 1 no cargan nada, 0 viene comprimido y 2 se copia tal cual
	inc hl			;4f4d
	inc a			;4f4e
	ret z			;4f4f
	dec a			;4f50
	or a			;4f51
	jr z,RECURSO_SPRITE_RLE		;4f52
	dec a			;4f54
	ret z			;4f55
	jr RECURSO_SPRITE_COPIA		;4f56
RECURSO_SPRITE_RLE:		; tipo 0: descomprime el origen en los patrones de sprites
	ld e,(hl)			;4f58   ; el tipo 0 pasa el origen por el descompresor
	inc hl			;4f59
	ld d,(hl)			;4f5a
	push ix		;4f5b
	pop hl			;4f5d
	jp RLE_A_VRAM		;4f5e
RECURSO_SPRITE_COPIA:		; tipo 2: copia [4..5] bytes tal cual
	ld e,(hl)			;4f61   ; el tipo 2 trae ademas su longitud, en los bytes 4 y 5
	inc hl			;4f62
	ld d,(hl)			;4f63
	inc hl			;4f64
	ld c,(hl)			;4f65
	inc hl			;4f66
	ld b,(hl)			;4f67
	push ix		;4f68
	pop hl			;4f6a
	jp COPIA_A_VRAM		;4f6b

; ----------------------------------------------------------------------
; Aqui vive la parada en boxes de un jugador. Se entra porque p02
; 0x8C04 -el estado 1 del coche, "entra en boxes"- pone E250 = 0x0C,
; y el despachador de 0x5A3D manda el 12 a 0x5B02 (montar la escena)
; y el 13 a 0x5B10 (un fotograma). Con dos jugadores no se pasa por
; aqui: el coche se queda en su estado 2.
;
; La escena tiene su propio subestado en E251 (0, 1, 2 y 3) y su
; cuenta atras en E25D. Los DOS MECANICOS son dos fichas de 6 bytes
; en E9B1 y E9B9, separadas 8, copiadas de la plantilla de 0x4FB2:
; +0  vivo
; +1  Y (empieza en 0xBE, abajo del todo, y sube de dos en dos)
; +2  X (0x40)
; +3  fotograma (0 a 7)
; +4  contador de la animacion
; +5  espera antes de arrancar (0 el primero, 0x12 el segundo)
; Cada mecanico son CUATRO sprites: dos arriba y dos 16 pixeles mas
; abajo, y cada pareja es el mismo dibujo en dos colores (1 y 9), que
; es como se pinta una figura de dos tintas con sprites del TMS9918.
;
; Y LO QUE DE VERDAD DUELE: mientras estas parado, los rivales te
; adelantan. Son las tres fichas de 8 bytes de E3D8; cada una baja
; de 8 en 8 desde 0x94, y al pasar de 0x80 le suma UNO a E331, que
; es tu puesto en la carrera (el que pinta p01 0x7A06), hasta el
; tope de 99. El hueco entre coche y coche lo sortea 0x51F2.
; ----------------------------------------------------------------------
BOXES_ENTRA:		; monta la escena: contadores a cero, los sprites de los mecanicos y las dos fichas de E9B1
	ld hl,00000h		;4f6e   ; E9C3 y E251 a cero: el subestado de la parada empieza en 0
	ld (0e9c3h),hl		;4f71
	xor a			;4f74
	ld (0e251h),a		;4f75
	ld (0e3b0h),a		;4f78
	ld a,012h		;4f7b   ; 0x12 fotogramas antes del primer paso
	ld (0e25dh),a		;4f7d
	ld a,(0e244h)		;4f80   ; E244 es la repeticion (0 normal, 1 pedida, 2 reproduciendose); si no se esta reproduciendo hay que apartarla antes de usar la pista para otra cosa
	cp 002h		;4f83
	call c,BOXES_GUARDA_REPETICION		;4f85
	call LIMPIA_EA80_Y_ATRIBUTOS		;4f88
	ld hl,074ech		;4f8b   ; la lista de sprites p04 0x74EC: un solo recurso, el de los mecanicos
	call CARGA_LISTA_SPRITES		;4f8e
	ld hl,04fb2h		;4f91   ; la plantilla de 0x4FB2 a E9B1 y E9B9: seis bytes copiados y dos saltados, que la ficha ocupa ocho
	ld de,0e9b1h		;4f94
	ld c,002h		;4f97
L_4F99:
	ld b,006h		;4f99
L_4F9B:
	ld a,(hl)			;4f9b
	ld (de),a			;4f9c
	inc hl			;4f9d
	inc de			;4f9e
	djnz L_4F9B		;4f9f
	inc de			;4fa1
	inc de			;4fa2
	dec c			;4fa3
	jr nz,L_4F99		;4fa4
	call TIEMPO_A_E30D		;4fa6   ; el tiempo, el reloj de pantalla y el hueco hasta el primer rival
	call RELOJ_GUARDA_Y_PINTA		;4fa9
	call RIVAL_HUECO_TIEMPO		;4fac
	jp ESTADO_MAS_UNO		;4faf   ; y 0x5BA2 sube E250: de montar la escena (12) se pasa a correrla (13)

; ----------------------------------------------------------------------
; DATOS inicial_E9B1: dos filas de 6 bytes que 0x4F91 copia a E9B1 y E9B9 (`ld
;   hl,0x4FB2 / ld de,0xE9B1 / ld c,2`, seis bytes por vuelta y dos de salto)
;   0x4fb2..0x4fbe  (12 bytes)
DATA_inicial_E9B1:
	defb 001h,0beh,040h,000h,002h,000h	; 4fb2
	defb 001h,0beh,040h,000h,004h,012h	; 4fb8

; ======================================================================
; CODIGO 0x4fbe..0x514a  (396 bytes)
; ======================================================================


BOXES_GUARDA_REPETICION:		; aparta la repeticion mientras dura la parada: E244 += 3
	xor a			;4fbe
	ld (0e1d5h),a		;4fbf
	call 09263h		;4fc2
	ld a,(0e244h)		;4fc5
	add a,003h		;4fc8   ; sumarle 3 es la marca de "estoy en boxes": el 0 pasa a 3 y el 1 a 4, y 0x50A6 se los resta al salir, asi que la repeticion sale de la parada como entro
	ld (0e244h),a		;4fca
	call 0b44ch		;4fcd
	call 070dfh		;4fd0
	jp 0923ah		;4fd3
BOXES_PASO:		; un fotograma de la parada
	ld iy,0e2c0h		;4fd6
	call 0788fh		;4fda   ; p01 0x788F es el mando dentro de boxes: con el boton devuelve acarreo -el jugador corta la parada- y con abajo reposta
	call c,BOXES_CORTA		;4fdd
	call BOXES_PINTA		;4fe0   ; lo de siempre: sprites, ventana, HUD y los objetos de tiles
	call 0760dh		;4fe3
	call RIVALES_MUEVE		;4fe6   ; los rivales que pasan y el sorteo del siguiente
	call RIVAL_NUEVO		;4fe9
	ld a,(0e251h)		;4fec   ; el subestado 3 es la salida, y por ahi no se anima nada
	cp 003h		;4fef
	jp z,BOXES_SALE		;4ff1
	call BOXES_MECANICOS		;4ff4
	call SPRITES_MECANICOS		;4ff7
	call TIEMPO_DIFERENCIA		;4ffa
	jp RELOJ_PINTA		;4ffd
BOXES_MECANICOS:		; los dos mecanicos: primero decide si estan trabajando y luego los mueve
	call HAY_TRABAJO		;5000   ; E1D6 y el bit 1 de E1C8: dos maneras de que los mecanicos se pongan a trabajar
	jr nz,L_500A		;5003
	ld a,(0e1c8h)		;5005
	and 002h		;5008
L_500A:
	call nz,BOXES_TRABAJANDO		;500a
	xor a			;500d   ; EA50 es la marca de "trabajando", y aqui empieza apagada
	ld (0ea50h),a		;500e
BOXES_POR_SUBESTADO:		; reparte por E251: 1 es la espera de abajo, 2 en adelante la salida, 0 la subida
	ld a,(0e251h)		;5011
	dec a			;5014   ; el `dec a` y el `jp p` juntos: 1 va a 0x5063, 2 y mas a 0x5073, y el 0 sigue aqui
	jr z,BOXES_SUBESTADO_1		;5015
	jp p,BOXES_A_LA_SALIDA		;5017
	ld ix,0e9b1h		;501a   ; las dos fichas, de ocho en ocho
	ld b,002h		;501e
	ld de,00008h		;5020
MECANICO_SUBE_O_ESPERA:		; mientras (ix+5) no llegue a cero el mecanico ni sube ni se anima
	ld a,(ix+005h)		;5023   ; (ix+5) es la espera: el segundo mecanico sale 0x12 fotogramas despues que el primero
	and a			;5026
	jr z,MECANICO_SUBE		;5027
	dec a			;5029
	ld (ix+005h),a		;502a
	ret			;502d
MECANICO_SUBE:		; Y -= 2 y un paso de animacion
	ld a,(ix+001h)		;502e   ; dos pixeles por fotograma hacia arriba
	sub 002h		;5031
	ld (ix+001h),a		;5033
	call MECANICO_ANIMA_LENTO		;5036
	add ix,de		;5039
	djnz MECANICO_SUBE_O_ESPERA		;503b
	ld hl,0e25dh		;503d   ; cuando los dos han subido, E25D cuenta la parada...
	dec (hl)			;5040
	ret nz			;5041
	ld a,060h		;5042   ; ...y al agotarse: 0x60 fotogramas mas, los dos mecanicos a sus poses de trabajo (2 y 4) y al subestado siguiente
	ld (0e25dh),a		;5044
	ld a,002h		;5047
	ld (0e9b5h),a		;5049
	ld (0e9b4h),a		;504c
	ld a,004h		;504f
	ld (0e9bdh),a		;5051
	ld (0e9bch),a		;5054
BOXES_SUBESTADO_MAS_UNO:		; E251++
	ld hl,0e251h		;5057
	inc (hl)			;505a
	ret			;505b
BOXES_TRABAJANDO:		; enciende la marca de EA50 y sigue por 0x5011
	ld a,001h		;505c
	ld (0ea50h),a		;505e
	jr BOXES_POR_SUBESTADO		;5061
BOXES_SUBESTADO_1:		; la parada en si: anima a los dos y cuenta hasta 0x20
	call MECANICOS_ANIMA		;5063
	ld hl,0e25dh		;5066
	dec (hl)			;5069
	ret nz			;506a
	ld a,020h		;506b   ; 0x20 fotogramas para la ultima pose antes de la salida
	ld (hl),a			;506d
	call MECANICO_1_POSE		;506e
	jr BOXES_SUBESTADO_MAS_UNO		;5071
BOXES_A_LA_SALIDA:		; el subestado 2 y los siguientes se van por 0x524F
	jp MECANICO_QUE_TOCA		;5073
BOXES_SALE:		; cuando no queda ningun rival por pasar y se agota E25D: se recarga la carrera y se vuelve a ella
	call RIVAL_HUECO		;5076   ; no se sale con un rival a medio cruzar la pantalla
	ret nz			;5079
	ld hl,0e25dh		;507a
	dec (hl)			;507d
	ret nz			;507e
	call LIMPIA_EA80_Y_ATRIBUTOS		;507f   ; la escena se desmonta entera: atributos, sprites de la carrera y el panel
	call SPRITES_A_VRAM		;5082
	call CARGA_SPRITES_CARRERA		;5085
	call SPRITES_DEMO		;5088
	call RELOJ_DEVUELVE_FONDO		;508b
	ld a,(0e244h)		;508e   ; si la repeticion venia apartada (E244 >= 3) hay que devolverla antes de correr
	cp 003h		;5091
	call nc,BOXES_DEVUELVE_REPETICION		;5093
	ld a,00bh		;5096
	call 06049h		;5098   ; p01 0x6049 con 0x0B: el estado 11, que es la vuelta a la carrera
	ld a,046h		;509b   ; el sonido 0x46 es el del coche saliendo de boxes
	call ENCOLA_SONIDO		;509d
	call 08666h		;50a0   ; p02 0x8666 espera al fotograma siguiente y 0x881D arranca el motor
	jp 0881dh		;50a3
BOXES_DEVUELVE_REPETICION:		; E244 -= 3 y p02 0x91EC
	sub 003h		;50a6
	ld (0e244h),a		;50a8
	jp 091ech		;50ab
MECANICO_1_POSE:		; a cara o cruz: la pose 6 para el primer mecanico o la 7 para el segundo
	call AZAR		;50ae   ; 0x5513 es el azar del juego, y aqui solo se mira su bit de abajo
	and 001h		;50b1
	ld a,006h		;50b3
	jr nz,L_50C2		;50b5
	ld (0e9b4h),a		;50b7
	ret			;50ba
MECANICO_2_POSE:		; si el primero ya esta en la 6, el segundo pasa a la 7; si no, el primero a la 6
	ld a,(0e9b4h)		;50bb
	cp 006h		;50be
	jr nz,MECANICO_1_POSE_6		;50c0
L_50C2:
	inc a			;50c2
	ld (0e9bch),a		;50c3
	ret			;50c6
MECANICO_1_POSE_6:		; el primero a la pose 6
	ld a,006h		;50c7
	ld (0e9b4h),a		;50c9
	ret			;50cc
BOXES_CORTA:		; el boton del jugador: 0x12 fotogramas y al subestado 3, la salida
	ld a,(0e251h)		;50cd
	cp 003h		;50d0   ; si ya se estaba saliendo no hay nada que cortar
	ret z			;50d2
	call MECANICO_1_POSE		;50d3   ; al cortar la parada se les da a los mecanicos su ultima pose
	call MECANICO_2_POSE		;50d6
	call SPRITES_MECANICOS		;50d9
	ld a,012h		;50dc
	ld (0e25dh),a		;50de
	ld a,003h		;50e1
	ld (0e251h),a		;50e3
	ret			;50e6
SONIDO_HERRAMIENTA:		; el sonido 0x23 mientras la parada no haya llegado al subestado 3
	ld a,(0e251h)		;50e7
	dec a			;50ea
	cp 002h		;50eb
	ld a,023h		;50ed
	call c,ENCOLA_SONIDO		;50ef   ; por debajo del subestado 3 la parada sigue, y con ella el sonido de la herramienta
	ret			;50f2
HAY_TRABAJO:		; Z si E1D6 vale cero
	ld a,(0e1d6h)		;50f3
	and a			;50f6
	ret			;50f7
SPRITES_MECANICOS:		; los cuatro sprites de cada mecanico a los atributos de EA88
	ld ix,0e9b1h		;50f8
	ld de,0ea88h		;50fc   ; EA88 es la segunda mitad de la tabla de atributos, la que deja libre el coche
	ld c,002h		;50ff
L_5101:
	ld b,004h		;5101   ; cuatro sprites por mecanico: la figura es de 16 x 32 y los sprites del MSX solo dan 16 x 16
L_5103:
	ld a,b			;5103   ; los dos primeros van a la altura de la ficha y los dos ultimos 16 pixeles mas abajo
	cp 003h		;5104
	ld l,000h		;5106
	jr nc,L_510C		;5108
	ld l,010h		;510a
L_510C:
	ld a,(ix+001h)		;510c   ; el byte 0 del atributo es la Y
	add a,l			;510f
	ld (de),a			;5110
	inc de			;5111
	ld a,(ix+003h)		;5112   ; en las poses 6 y 7 -las de trabajar- la figura se corre tres pixeles a la derecha
	cp 006h		;5115
	ld l,000h		;5117
	jr c,L_511D		;5119
	ld l,003h		;511b
L_511D:
	ld a,(ix+002h)		;511d
	add a,l			;5120
	ld (de),a			;5121
	inc de			;5122
	ld a,(ix+003h)		;5123   ; el patron sale de la tabla de 0x514A: ocho poses de cuatro sprites
	add a,a			;5126
	add a,a			;5127
	add a,b			;5128
	dec a			;5129
	ld hl,0514ah		;512a
	call HL_MAS_A		;512d
	ld a,(hl)			;5130
	ld (de),a			;5131
	inc de			;5132
	bit 0,b		;5133   ; y el color va alternando: la pareja de abajo del par lleva el 1 y la de arriba el 9, que es como se pinta una figura de dos tintas
	ld a,001h		;5135
	jr z,L_513B		;5137
	ld a,009h		;5139
L_513B:
	ld (de),a			;513b
	inc de			;513c
	djnz L_5103		;513d
	ex de,hl			;513f
	ld de,00008h		;5140   ; ocho bytes de una ficha a la siguiente
	add ix,de		;5143
	ex de,hl			;5145
	dec c			;5146
	jr nz,L_5101		;5147
	ret			;5149

; ----------------------------------------------------------------------
; DATOS tabla_514A: 8 grupos de 4 bytes; los lee 0x512A con A = (ix+3)*4 + B -
;   1 (`ld hl,0x514A / call HL_MAS_A / ld a,(hl)`)
;   0x514a..0x516a  (32 bytes)
DATA_tabla_514A:
	defb 024h,020h,01ch,018h	; 514a
	defb 034h,030h,02ch,028h	; 514e
	defb 044h,040h,03ch,038h	; 5152
	defb 054h,050h,04ch,048h	; 5156
	defb 064h,060h,05ch,058h	; 515a
	defb 074h,070h,06ch,068h	; 515e
	defb 084h,080h,07ch,078h	; 5162
	defb 094h,090h,08ch,088h	; 5166

; ======================================================================
; CODIGO 0x516a..0x5452  (744 bytes)
; ======================================================================


RIVAL_ADELANTA:		; el rival que cruza suma un puesto a E331, hasta 99, y solo una vez
	ld a,(iy+003h)		;516a   ; (iy+3) es la marca de "a este ya lo he contado"
	or a			;516d
	ret nz			;516e
	ld hl,0e331h		;516f
	ld a,(hl)			;5172
	cp 063h		;5173   ; el marcador se planta en 99: mas puestos no caben en dos digitos
	ret z			;5175
	inc (hl)			;5176
	ld (iy+003h),001h		;5177
	ret			;517b
SONIDO_RIVAL:		; el motor del que pasa: el sonido 0x0A o el 0x0B, a cara o cruz
	call AZAR		;517c
	and 001h		;517f
	ld a,00ah		;5181
	jr z,L_5187		;5183
	ld a,00bh		;5185
L_5187:
	jp ENCOLA_SONIDO		;5187
RIVALES_MUEVE:		; las tres fichas de E3D8: bajan de 8 en 8 y mueren al pasar de 0x40
	ld iy,0e3d8h		;518a
	ld de,00008h		;518e
	ld b,003h		;5191
L_5193:
	ld a,(iy+000h)		;5193   ; la ficha apagada no se mueve
	or a			;5196
	jr z,L_51B5		;5197
	ld a,(iy+001h)		;5199
	sub 008h		;519c   ; ocho pixeles por fotograma: el rival pasa deprisa, que tu estas parado
	ld (iy+001h),a		;519e
	cp 080h		;51a1   ; al cruzar la mitad de la pantalla es cuando cuenta el adelantamiento
	call c,RIVAL_ADELANTA		;51a3
	ld a,(iy+001h)		;51a6
	cp 040h		;51a9   ; y por debajo de 0x40 se apaga la ficha: ya ha salido por arriba
	jr nc,L_51B5		;51ab
	ld (iy+000h),000h		;51ad
	ld (iy+003h),000h		;51b1
L_51B5:
	add iy,de		;51b5
	djnz L_5193		;51b7
	ret			;51b9
RIVAL_NUEVO:		; cuando E3DC llega a cero saca otro rival, si queda hueco
	ld a,(0e251h)		;51ba
	cp 003h		;51bd   ; en la salida ya no salen mas rivales
	ret z			;51bf
	ld hl,0e3dch		;51c0
	dec (hl)			;51c3
	ret nz			;51c4
	call RIVAL_HUECO_TIEMPO		;51c5
	call RIVAL_HUECO		;51c8
	ret nz			;51cb
	ld (iy+000h),b		;51cc
	call AZAR		;51cf   ; la X del rival se sortea: 0x0F posibles carriles
	and 00fh		;51d2
	ld (iy+002h),a		;51d4
	ld (iy+001h),094h		;51d7   ; todos entran por 0x94, abajo
	jr SONIDO_RIVAL		;51db
RIVAL_HUECO:		; Z y IY en el primer hueco de las tres fichas; NZ si estan las tres ocupadas
	ld iy,0e3d8h		;51dd
	ld de,00008h		;51e1
	ld b,003h		;51e4
L_51E6:
	ld a,(iy+000h)		;51e6
	and a			;51e9   ; la primera ficha apagada vale, y sale con IY ya puesto encima
	ret z			;51ea
	add iy,de		;51eb
	djnz L_51E6		;51ed
	or 0ffh		;51ef
	ret			;51f1
RIVAL_HUECO_TIEMPO:		; sortea los fotogramas hasta el siguiente rival: (azar & 0x0F) * 2 mas 5, o mas 30 en la categoria 0
	ld b,005h		;51f2
	ld a,(0e25bh)		;51f4   ; en la categoria 0 -la de abajo- los rivales van mucho mas sueltos: el sumando es 30 en vez de 5
	and a			;51f7
	jr nz,L_51FC		;51f8
	ld b,01eh		;51fa
L_51FC:
	call AZAR		;51fc
	and 00fh		;51ff   ; los cuatro bits de abajo del azar por dos: entre 0 y 30 fotogramas de propina
	add a,a			;5201
	add a,b			;5202
	ld (0e3dch),a		;5203
	ret			;5206
BOXES_PINTA:		; el repintado de cada fotograma de la parada
	call SPRITES_A_VRAM		;5207
	call VENTANA_JUGADOR_2		;520a
	call 07134h		;520d
	call 0b44ch		;5210
	call CARRERA_EN_GRUPO		;5213
	call c,0b463h		;5216   ; solo en las carreras 0, 1, 2, 9, 10 y 11 se llama a p03 0xB463, que es quien pinta los rivales de boxes como objetos de tiles
	jp 070d9h		;5219
CARRERA_EN_GRUPO:		; acarreo si la carrera (E25C) esta en 0-2 o en 9-11; sin acarreo en 3-8 y 12-21
	ld a,(0e25ch)		;521c   ; cuatro restas encadenadas y dos `ccf`: es una tabla de rangos escrita como cuentas, sin tabla
	sub 003h		;521f
	ret c			;5221
	sub 006h		;5222   ; la segunda resta va con `ccf` porque el rango que interesa es el de EN MEDIO, y ahi el acarreo sale al reves
	ccf			;5224
	ret nc			;5225
	sub 003h		;5226
	ret c			;5228
	sub 00ah		;5229
	ccf			;522b
	ret			;522c
COPIA_RECTANGULO_VRAM:		; 24 filas de B' bytes de (DE) a la VRAM (HL), fila a fila
	ld c,018h		;522d   ; 24 filas: la pantalla entera de arriba abajo
L_522F:
	exx			;522f
	ld a,b			;5230
	exx			;5231
	ld b,a			;5232
L_5233:
	ld a,(de)			;5233
	call 0004dh		;5234   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;5237
	inc hl			;5238
	djnz L_5233		;5239
	ld a,020h		;523b   ; lo que falta hasta 32 es lo que hay que saltar en los dos punteros para caer en la fila de abajo
	exx			;523d
	sub b			;523e
	exx			;523f
	call HL_MAS_A		;5240
	ld a,020h		;5243
	exx			;5245
	sub b			;5246
	exx			;5247
	call DE_MAS_A		;5248
	dec c			;524b
	jr nz,L_522F		;524c
	ret			;524e
MECANICO_QUE_TOCA:		; el que no esta en la pose 6
	ld ix,0e9b1h		;524f
	ld a,(ix+003h)		;5253   ; el que esta en la pose 6 ya esta trabajando: le toca al otro
	cp 006h		;5256
	jr nz,MECANICO_ANIMA		;5258
	ld ix,0e9b9h		;525a
	jr MECANICO_ANIMA		;525e
MECANICOS_ANIMA:		; un paso de animacion a los dos
	ld b,002h		;5260
	ld ix,0e9b1h		;5262
	ld de,00008h		;5266
L_5269:
	call MECANICO_ANIMA		;5269
	add ix,de		;526c
	djnz L_5269		;526e
	ret			;5270
MECANICO_ANIMA_LENTO:		; un paso cada cuatro fotogramas
	dec (ix+004h)		;5271
	ret nz			;5274
	ld (ix+004h),004h		;5275
	jr L_528A		;5279
MECANICO_ANIMA:		; cambia el bit 0 del fotograma; trabajando va a cada fotograma y parado uno de cada trece
	ld a,(0ea50h)		;527b   ; EA50 encendido es "estan trabajando": entonces el cambio de pose es inmediato
	or a			;527e
	jr nz,L_528A		;527f
	inc (ix+004h)		;5281
	ld a,(ix+004h)		;5284
	and 00dh		;5287   ; el `and 0x0d` deja pasar una de cada trece vueltas, mas o menos: no es un contador limpio, es una mascara
	ret nz			;5289
L_528A:
	ld a,(ix+003h)		;528a
	xor 001h		;528d   ; el fotograma solo cambia de bit 0: las poses van por parejas, y la animacion es ir y venir entre las dos
	ld (ix+003h),a		;528f
	bit 0,a		;5292
	call nz,SONIDO_HERRAMIENTA		;5294   ; y en una de las dos suena la herramienta
	ret			;5297
TIEMPO_A_E30D:		; el cronometro (E210..E212) copiado a E30D..E30F
	ld a,(0e210h)		;5298
	ld (0e30dh),a		;529b   ; el cronometro se copia entero, byte a byte: no hay `ldir` para tres bytes que valga la pena
	ld a,(0e211h)		;529e
	ld (0e30eh),a		;52a1
	ld a,(0e212h)		;52a4
	ld (0e30fh),a		;52a7
TIEMPO_DIFERENCIA:		; la resta de los dos tiempos a EA57..EA59, por p02 0xA5AF
	ld hl,0e30dh		;52aa   ; los dos tiempos, el de ahora y el guardado, para restarlos
	ld c,(hl)			;52ad
	inc hl			;52ae
	ld e,(hl)			;52af
	inc hl			;52b0
	ld d,(hl)			;52b1
	ld hl,0e210h		;52b2   ; el cronometro en curso son tres bytes desde E210
	ld b,(hl)			;52b5
	inc hl			;52b6
	ld a,(hl)			;52b7
	inc hl			;52b8
	ld h,(hl)			;52b9
	ld l,a			;52ba
L_52BB:
	call 0a5afh		;52bb   ; la resta de 24 bits vive en la pagina 3
	ex de,hl			;52be
	ld hl,0ea57h		;52bf
	ld (hl),b			;52c2
	inc hl			;52c3
	ld (hl),e			;52c4
	inc hl			;52c5
	ld (hl),d			;52c6
	ret			;52c7
RELOJ_GUARDA_Y_PINTA:		; guarda el fondo y pinta el reloj
	call RELOJ_GUARDA_FONDO		;52c8
RELOJ_PINTA:		; el tiempo de EA51..EA56 en el buffer, con los digitos del tile 0xF5 y el 0xFF de separador
	call TIEMPO_A_DIGITOS		;52cb
	call CASILLA_DEL_RELOJ		;52ce
	ld c,0f5h		;52d1
	jr L_52D7		;52d3
RELOJ_PINTA_TILES_10:		; el mismo reloj con los digitos del tile 0x10 y el 0x1E de separador
	ld c,010h		;52d5
L_52D7:
	ld de,0ea51h		;52d7   ; se escribe de derecha a izquierda -de las centesimas a los minutos- porque asi el puntero solo tiene que bajar
	ld a,008h		;52da
	call HL_MAS_A		;52dc   ; el hueco del reloj son nueve casillas: MM : SS : cc
	ld b,002h		;52df
L_52E1:
	ld a,(de)			;52e1
	add a,c			;52e2
	ld (hl),a			;52e3
	inc de			;52e4   ; el origen sube y el destino baja: por eso salen en el orden bueno
	dec hl			;52e5
	djnz L_52E1		;52e6
	ld a,c			;52e8
	cp 0f5h		;52e9   ; el separador cambia con la fuente: 0xFF con los digitos de 0xF5 y 0x1E con los de 0x10
	ld a,0ffh		;52eb
	jr z,L_52F1		;52ed
	ld a,01eh		;52ef
L_52F1:
	ld (hl),a			;52f1
	dec hl			;52f2
	ld b,002h		;52f3
L_52F5:
	ld a,(de)			;52f5   ; la pareja de en medio, los segundos
	add a,c			;52f6
	ld (hl),a			;52f7
	inc de			;52f8
	dec hl			;52f9
	djnz L_52F5		;52fa
	ld a,c			;52fc   ; el separador de en medio, el mismo que el otro
	cp 0f5h		;52fd
	ld a,0ffh		;52ff
	jr z,L_5305		;5301
	ld a,01eh		;5303
L_5305:
	ld (hl),a			;5305
	dec hl			;5306
	ld b,002h		;5307
L_5309:
	ld a,(de)			;5309
	add a,c			;530a
	ld (hl),a			;530b   ; las centesimas, la pareja de la derecha
	inc de			;530c
	dec hl			;530d
	djnz L_5309		;530e
	ret			;5310
RELOJ_GUARDA_FONDO:		; se guarda en E9A7 lo que habia en las diez casillas del reloj
	call CASILLA_DEL_RELOJ		;5311
	ld de,0e9a7h		;5314
	ld bc,0000ah		;5317
	ldir		;531a
	ret			;531c
RELOJ_DEVUELVE_FONDO:		; y aqui se devuelve
	call CASILLA_DEL_RELOJ		;531d
	ex de,hl			;5320
	ld hl,0e9a7h		;5321   ; el fondo guardado vuelve a su sitio, diez casillas
	ld bc,0000ah		;5324
	ldir		;5327
	ret			;5329
CASILLA_DEL_RELOJ:		; la casilla del reloj: columna 6 (0x30 / 8) y la fila que salga de 0x40, sobre el bloque de sombra E380
	ld de,03040h		;532a   ; el bloque E380 lo rellena p03 0xB425 con la posicion del coche 1, y trae (iy+9) = 2, asi que el reloj se pinta en el buffer de EC00
	ld iy,0e380h		;532d
	call CASILLA_BUFFER_NOMBRES		;5331
	ld iy,0e2c0h		;5334
	ret			;5338
TIEMPO_A_DIGITOS:		; los 24 bits de EA57 pasados a minutos, segundos y milesimas, y de ahi a los siete digitos de EA50..EA56
	ld hl,0ea57h		;5339   ; el cronometro cuenta VEINTEAVOS de segundo: por eso el primer reparto es entre 20
	ld e,(hl)			;533c
	inc hl			;533d
	ld d,(hl)			;533e
	inc hl			;533f
	ld l,(hl)			;5340
	ld a,014h		;5341
	call DIVIDE_24		;5343   ; EA60..EA62 se queda con los segundos y en HL:DE queda el resto
	push de			;5346
	ld hl,0ea60h		;5347   ; los segundos se apartan en EA67, que EA60 hace falta otra vez
	ld de,0ea67h		;534a   ; los segundos se copian tal cual, tres bytes: la division los deja en EA60 y de ahi no pueden quedarse, que EA60 hace falta otra vez
	ld bc,00003h		;534d
	ldir		;5350
	pop de			;5352
	ld h,064h		;5353   ; el resto (0 a 19) por 100 y entre 2 son milesimas: cada veinteavo son 50 milesimas, asi que el digito de las unidades siempre sale 0 o 5
	call 09b4fh		;5355
	ex de,hl			;5358
	ld l,000h		;5359
	ld a,002h		;535b
	call DIVIDE_24		;535d   ; entre dos, que la multiplicacion por 100 los dejo al doble
	ld hl,0ea60h		;5360
	ld a,(hl)			;5363
	inc hl			;5364
	ld h,(hl)			;5365
	ld l,a			;5366
	call HL_A_BCD		;5367   ; las milesimas a BCD y de ahi a tres digitos: unidades, decenas y centenas
	ld hl,0ea50h		;536a
	ld a,e			;536d
	and 00fh		;536e
	ld (hl),a			;5370
	inc hl			;5371
	ld a,e			;5372
	rra			;5373
	rra			;5374
	rra			;5375
	rra			;5376
	and 00fh		;5377
	ld (hl),a			;5379
	inc hl			;537a
	ld a,d			;537b
	and 00fh		;537c
	ld (hl),a			;537e
	inc hl			;537f
	push hl			;5380   ; el sitio de los digitos se guarda: los tres bloques se escriben seguidos en EA50..EA56
	ld hl,0ea67h		;5381
	ld e,(hl)			;5384
	inc hl			;5385
	ld d,(hl)			;5386
	inc hl			;5387
	ld l,(hl)			;5388
	ld a,03ch		;5389   ; y los segundos, entre 60, dan los minutos en EA60 y los segundos en el resto
	call DIVIDE_24		;538b
	ex de,hl			;538e
	call HL_A_BCD		;538f   ; dos digitos de segundos...
	pop hl			;5392
	ld a,e			;5393
	and 00fh		;5394
	ld (hl),a			;5396
	inc hl			;5397
	ld a,e			;5398
	rra			;5399
	rra			;539a
	rra			;539b
	rra			;539c
	and 00fh		;539d
	ld (hl),a			;539f
	inc hl			;53a0
	push hl			;53a1
	ld hl,(0ea60h)		;53a2   ; y por ultimo los minutos, que son los que se pintan a la izquierda
	call HL_A_BCD		;53a5   ; ...y dos de minutos, que son los que se pintan a la izquierda
	pop hl			;53a8
	ld a,e			;53a9
	and 00fh		;53aa
	ld (hl),a			;53ac
	inc hl			;53ad
	ld a,e			;53ae
	rra			;53af
	rra			;53b0   ; las cuatro rotaciones sacan el nibble de arriba: el segundo digito de cada pareja
	rra			;53b1
	rra			;53b2
	and 00fh		;53b3
	ld (hl),a			;53b5
	ret			;53b6
DIVIDE_8_VUELTAS:		; la misma division, con el divisor ya montado y solo ocho vueltas
	ld h,000h		;53b7   ; por aqui entra quien ya trae el divisor montado y solo quiere ocho vueltas
	exx			;53b9
	push hl			;53ba
	push de			;53bb
	ld hl,0ea60h		;53bc
	ld bc,00003h		;53bf
	call RELLENA_RAM_CERO		;53c2   ; el cociente siempre empieza a cero
	pop de			;53c5
	pop hl			;53c6
	ld h,000h		;53c7
	ld b,008h		;53c9
	ld h,l			;53cb
	ld l,d			;53cc
	ld d,e			;53cd
	ld e,000h		;53ce
	jr DIVIDE_BUCLE		;53d0
DIVIDE_24:		; divide los 24 bits que traen L, D y E entre A: cociente en EA60..EA62 y resto en H:L:D:E
	ld h,000h		;53d2   ; el cociente empieza a cero, tres bytes
	push af			;53d4
	exx			;53d5
	ld hl,0ea60h		;53d6
	ld bc,00003h		;53d9
	call RELLENA_RAM_CERO		;53dc
	pop af			;53df
	ld h,a			;53e0   ; el divisor se monta arriba del todo del juego alterno -H' = A, y el resto a cero- y va bajando una posicion por vuelta: es la division a mano, la de restar y correr
	ld l,000h		;53e1
	ld de,00000h		;53e3
	ld b,018h		;53e6   ; 24 vueltas, una por bit del cociente
DIVIDE_BUCLE:		; un bit por vuelta
	call DIVISOR_BAJA_UN_BIT		;53e8   ; primero baja el divisor un lugar...
	call RESTA_32		;53eb   ; ...luego se resta a ver si cabe, y el resultado se deja en EA63..EA66 sin tocar el dividendo
	push af			;53ee
	ccf			;53ef   ; el `ccf` da la vuelta al acarreo: el prestamo es "no cabe", y el bit del cociente es justo lo contrario
	call CORRE_COCIENTE		;53f0
	pop af			;53f3
	jr c,L_5403		;53f4
	exx			;53f6   ; si cabia, la resta pasa a ser el nuevo dividendo
	ld hl,0ea63h		;53f7
	ld e,(hl)			;53fa
	inc hl			;53fb
	ld d,(hl)			;53fc
	inc hl			;53fd
	ld a,(hl)			;53fe
	inc hl			;53ff
	ld h,(hl)			;5400
	ld l,a			;5401
	exx			;5402
L_5403:
	djnz DIVIDE_BUCLE		;5403
	exx			;5405
	ret			;5406
DIVISOR_BAJA_UN_BIT:		; H:L:D:E entre dos
	srl h		;5407
	rr l		;5409
	rr d		;540b
	rr e		;540d
	ret			;540f
RESTA_32:		; EA63..EA66 = dividendo - divisor, byte a byte y cruzando los dos juegos de registros
	exx			;5410   ; la resta va byte a byte y cruzando los dos juegos de registros: el dividendo esta en uno y el divisor en el otro
	ld a,e			;5411
	exx			;5412
	sub e			;5413
	ld (0ea63h),a		;5414   ; el resultado no toca el dividendo: se deja aparte en EA63..EA66 por si no cabe
	exx			;5417
	ld a,d			;5418
	exx			;5419   ; el byte de en medio va con `sbc`: la resta de 32 bits se encadena por el acarreo
	sbc a,d			;541a
	ld (0ea64h),a		;541b
	exx			;541e
	ld a,l			;541f
	exx			;5420
	sbc a,l			;5421
	ld (0ea65h),a		;5422
	exx			;5425
	ld a,h			;5426
	exx			;5427
	sbc a,h			;5428
	ld (0ea66h),a		;5429
	ret			;542c
CORRE_COCIENTE:		; mete el acarreo por abajo en los tres bytes de EA60
	push hl			;542d   ; el cociente se va montando por abajo, un bit por vuelta
	ld hl,0ea60h		;542e
	rl (hl)		;5431
	inc hl			;5433
	rl (hl)		;5434
	inc hl			;5436
	rl (hl)		;5437
	pop hl			;5439
	ret			;543a
L_543B:
	ret			;543b
SPRITES_FINAL_INICIA:		; los tres sprites de EA90 a su sitio de salida y los contadores de E800 a cero
	ld hl,05452h		;543c   ; EA90 no es RAM cualquiera: es el sprite 4 de la copia de atributos que empieza en EA80, asi que cada fila de cuatro bytes es un sprite entero (Y, X, patron, color)
	ld de,0ea90h		;543f
	ld bc,0000ch		;5442
	ldir		;5445
	ld b,003h		;5447   ; E800, E801 y E802 son los contadores de la escena; los llaman los pasos 3 y 12 del final (p02 0x8288 y 0x830D)
	ld hl,0e800h		;5449
L_544C:
	xor a			;544c
	ld (hl),a			;544d
	inc hl			;544e
	djnz L_544C		;544f
	ret			;5451

; ----------------------------------------------------------------------
; DATOS inicial_EA90: tres filas de 4 bytes que 0x543C copia a EA90 (`ld
;   hl,0x5452 / ld de,0xEA90 / ld bc,0x0C / ldir`); las tres estructuras se
;   recorren luego con `ld de,4 / ld b,3` desde EA90 (0x54AE)
;   0x5452..0x545e  (12 bytes)
DATA_inicial_EA90:
	defb 048h,0a8h,000h,000h	; 5452
	defb 058h,0a0h,004h,000h	; 5456
	defb 070h,0a0h,008h,000h	; 545a

; ======================================================================
; CODIGO 0x545e..0x54d1  (115 bytes)
; ======================================================================


SPRITES_FINAL_PASO:		; los tres a la derecha, y el primero ademas subiendo
	ld a,(0e801h)		;545e   ; hasta que E801 no arranca, el paso 4 del final no mueve nada: lo enciende el bit 1 de E803
	and a			;5461
	jr nz,L_546A		;5462
	ld a,(0e803h)		;5464
	and 002h		;5467
	ret z			;5469
L_546A:
	ld hl,0e801h		;546a
	inc (hl)			;546d
	inc hl			;546e
	inc (hl)			;546f
	ld a,(hl)			;5470
	cp 00ch		;5471   ; a las doce vueltas se reinicia y vuelta a empezar: la escena es un bucle
	jr nc,SPRITES_FINAL_REINICIA		;5473
	ld c,001h		;5475   ; C sale de la vuelta en que se este: 3 en la 1, 2 en la 5, 6 y 8 a 11, 1 en la 7 y 0 en el resto
	cp 007h		;5477
	jr z,L_5489		;5479
	ld c,002h		;547b
	cp 005h		;547d
	jr nc,L_5489		;547f
	ld c,003h		;5481
	cp 001h		;5483
	jr z,L_5489		;5485
	ld c,000h		;5487
L_5489:
	ld b,003h		;5489
	ld hl,0ea90h		;548b
	ld de,00004h		;548e
L_5491:
	srl c		;5491   ; el `srl c` va antes de restar y no se rehace: al primer sprite le toca C/2, al segundo C/4 y al tercero C/8, o sea que **solo sube el primero**, y de un pixel en pixel
	ld a,(hl)			;5493
	sub c			;5494
	ld (hl),a			;5495
	add hl,de			;5496
	djnz L_5491		;5497
	ld b,003h		;5499
	ld ix,0ea90h		;549b
L_549F:
	ld a,(ix+001h)		;549f   ; la X sube uno en los tres: los tres se van a la derecha a la vez
	add a,001h		;54a2
	ld (ix+001h),a		;54a4
	ld de,00004h		;54a7
	add ix,de		;54aa
	djnz L_549F		;54ac
	ld ix,0ea90h		;54ae
	ld hl,054d1h		;54b2   ; y los colores se vuelven a poner cada vuelta (7, 10, 7), que la escena los cambia
	ld de,00004h		;54b5
	ld b,003h		;54b8
L_54BA:
	ld a,(hl)			;54ba   ; un byte por estructura, y de cuatro en cuatro
	ld (ix+003h),a		;54bb
	inc hl			;54be
	add ix,de		;54bf
	djnz L_54BA		;54c1
	ret			;54c3
SPRITES_FINAL_REINICIA:		; contadores a cero y otra vez al principio
	xor a			;54c4
	ld (0e802h),a		;54c5
	ld (0e803h),a		;54c8
	ld (0e801h),a		;54cb
	jp SPRITES_FINAL_INICIA		;54ce

; ----------------------------------------------------------------------
; DATOS byte3_EA90: un byte por cada una de las tres estructuras de EA90:
;   0x54B2 los mete en (ix+3) (`ld hl,0x54D1 / ld de,4 / ld b,3`)
;   0x54d1..0x54d4  (3 bytes)
DATA_byte3_EA90:
	defb 007h,00ah,007h	; 54d1

; ======================================================================
; CODIGO 0x54d4..0x54ef  (27 bytes)
; ======================================================================


NEUMATICO_POR_DESGASTE:		; cuando el desgaste (ix+64) llega a cuatro veces el byte de la carroceria, revienta un neumatico
	ld a,(ix-021h)		;54d4   ; (ix-0x21) es el byte que p02 0x89AA saca de la tabla 0x88E9 con la carroceria (ix+18): una carroceria mejor aguanta mas
	add a,a			;54d7
	add a,a			;54d8
	ld d,a			;54d9
	ld a,(ix+064h)		;54da   ; el desgaste contra ese limite; mientras no llegue no pasa nada
	sub d			;54dd
	ret c			;54de
REVIENTA_NEUMATICO:		; (ix+4A) = 6, el desgaste a cero y uno de los cuatro neumaticos al azar
	ld (ix+04ah),006h		;54df   ; tambien lo llama p02 0x8DBD: a los 0x5A fotogramas de un choque revienta igual
	ld (ix+064h),000h		;54e3   ; el desgaste vuelve a cero: lo que se ha roto ya no cuenta
	call AZAR		;54e7   ; ocho entradas para cuatro neumaticos, cada uno dos veces: la tabla es simetrica y los cuatro salen igual de probables
	and 007h		;54ea
	call DESPACHA		;54ec

; ----------------------------------------------------------------------
; DATOS tabla_54EC: 8 palabras del despachador de 0x54EC (indice A&7,
;   simetrica: 550E 54FF 5504 5509 550E 5509 5504 54FF)
;   0x54ef..0x54ff  (16 bytes)
DATA_tabla_54EC:
	defw 0550eh	; 54ef  -> NEUMATICO_4
	defw 054ffh	; 54f1  -> NEUMATICO_1
	defw 05504h	; 54f3  -> NEUMATICO_2
	defw 05509h	; 54f5  -> NEUMATICO_3
	defw 0550eh	; 54f7  -> NEUMATICO_4
	defw 05509h	; 54f9  -> NEUMATICO_3
	defw 05504h	; 54fb  -> NEUMATICO_2
	defw 054ffh	; 54fd  -> NEUMATICO_1

; ======================================================================
; CODIGO 0x54ff..0x574f  (592 bytes)
; ======================================================================


NEUMATICO_1:		; bit 0 de (ix+68)
	set 0,(ix+068h)		;54ff
	ret			;5503
NEUMATICO_2:		; bit 1
	set 1,(ix+068h)		;5504
	ret			;5508
NEUMATICO_3:		; bit 2
	set 2,(ix+068h)		;5509
	ret			;550d
NEUMATICO_4:		; bit 3
	set 3,(ix+068h)		;550e
	ret			;5512
AZAR:		; el numero al azar del juego: mezcla el contador de fotogramas (E1C3) con (E2C6) y con la semilla (E21F), suma 0xCD, rota y guarda
	push hl			;5513
	ld a,(0e1c3h)		;5514   ; el contador de fotogramas de logica es lo que hace que el resultado dependa de cuando se pida
	ld hl,0e2c6h		;5517
	xor (hl)			;551a
	ld hl,0e21fh		;551b
	xor (hl)			;551e
	add a,0cdh		;551f   ; la suma y la rotacion son todo el revoltijo: ni multiplica ni tiene tabla, y aun asi da de sobra para sortear un carril o una pose
	rrca			;5521
	ld (hl),a			;5522
	pop hl			;5523
	ret			;5524
REVUELVE_AZAR:		; mete (E303) rotado dos veces en la semilla E21F
	ld a,(0e303h)		;5525   ; se llama al empezar cada carrera (0x5A32): dos partidas distintas no reparten igual
	rrca			;5528
	rrca			;5529
	ld hl,0e21fh		;552a
	xor (hl)			;552d
	ld (hl),a			;552e
	ret			;552f
PREPARA_CIRCUITO:		; E1FE = 0x3C; (E257), (E259) y (E253) de las tres tablas por la carrera (E25C); 0x5F5D; posicion a cero (0x556B); 1/2/3
	ld a,03ch		;5530   ; E1FE = 0x3C: los 60 de la cuenta atras
	ld (0e1feh),a		;5532
	call MAPEA_7_8_9		;5535   ; la secuencia de piezas de la carrera vive en el grupo 7/8/9...
	ld hl,06000h		;5538
	ld a,(0e25ch)		;553b
	call HL_PALABRA_A		;553e
	ld (0e257h),hl		;5541
	call MAPEA_A_B_C		;5544   ; ...y las piezas y los metatiles en el A/B/C: tres tablas, las tres indexadas por la carrera (E25C)
	ld hl,0afa2h		;5547
	ld a,(0e25ch)		;554a
	call HL_PALABRA_A		;554d
	ld (0e259h),hl		;5550
	ld hl,0af78h		;5553
	ld a,(0e25ch)		;5556
	call HL_PALABRA_A		;5559
	ld (0e253h),hl		;555c
	call MAPEA_7_8_9		;555f
	call CARGA_LISTA_OBJETOS		;5562   ; y se acaba con el coche en la casilla cero de la pista
	call POSICION_PISTA_A_CERO		;5565
	jp MAPEA_1_2_3		;5568
POSICION_PISTA_A_CERO:		; vueltas (ix-2), fila (ix+45), pieza (ix+46,47), posicion (ix+3F..42) y (ix+57) a cero
	xor a			;556b   ; (ix+3F..42) es la posicion en la pista, 32 bits; (ix+45) la fila dentro de la pieza y (ix+46,47) la pieza
	ld (ix-002h),a		;556c
	ld (ix+045h),a		;556f   ; la fila dentro de la pieza y la pieza misma, todo a cero: la carrera empieza en la casilla cero de la vuelta
	ld (ix+046h),a		;5572
	ld (ix+047h),a		;5575
	ld (ix+042h),a		;5578
	ld (ix+041h),a		;557b
	ld (ix+040h),a		;557e
	ld (ix+03fh),a		;5581
	ld (ix+057h),a		;5584
	ret			;5587
PINTA_PISTA_32_FILAS:		; A/B/C; 32 veces: avanza 0x800 (una fila de 8 px) y pinta la fila: la pantalla entera de pista
	ld b,020h		;5588   ; 32 filas es la pantalla entera: se pinta de golpe antes de empezar
	call MAPEA_A_B_C		;558a
PINTA_PISTA_BUCLE:		; una fila por vuelta
	push bc			;558d
	ld de,00800h		;558e   ; 0x800 es una fila de ocho pixeles en las unidades de la posicion
	call AVANZA_POSICION		;5591
	call PINTA_FILA_PISTA		;5594
	pop bc			;5597
	djnz PINTA_PISTA_BUCLE		;5598
	jp MAPEA_1_2_3		;559a
PINTA_UNA_FILA_MAS:		; sin llamador: 0x443D, avanza 0x800 (una fila de 8 px) y pinta esa fila (0x564C); vuelve por 0x43FE. Lo que hace PINTA_PISTA_32_FILAS en cada vuelta, pero una sola vez
	call MAPEA_A_B_C		;559d
	ld de,00800h		;55a0
	call AVANZA_POSICION		;55a3
	call PINTA_FILA_PISTA		;55a6
	jp MAPEA_1_2_3		;55a9
SIN_AVANCE:		; (ix+4C) = 0: esta vuelta no hay fila nueva
	ld (ix+04ch),000h		;55ac
	ret			;55b0
AVANZA_PISTA:		; 7/8/9; DE = (ix+43,44): >= 0x1000 -> dos filas y pico (0x560F), >= 0x800 -> una y pico (0x5632), si no lo que toque (0x55CB)
	call MAPEA_7_8_9		;55b1
	ld (ix+04ch),000h		;55b4   ; (ix+4C) es cuantas filas nuevas se han pintado en este fotograma, y lo lee quien mueve el buffer
	ld (ix+06fh),000h		;55b8
	ld e,(ix+043h)		;55bc   ; (ix+43,44) es lo que avanza la pista en este fotograma, el equivalente a la velocidad
	ld d,(ix+044h)		;55bf
	ld a,d			;55c2
	cp 010h		;55c3   ; mas de 0x1000 son dos filas de golpe; mas de 0x800, una; el resto es solo mover la posicion
	jr nc,AVANZA_DOS_FILAS		;55c5
	cp 008h		;55c7
	jr nc,AVANZA_UNA_FILA		;55c9
AVANZA_POSICION:		; (ix+3F,40) -= DE (con acarreo a ix+41,42); si cruza filas de 8 px: (ix+4C) = 1 y (ix+45) += filas; a las 12 filas pasa a la pieza siguiente (ix+46,47) y (ix+6F) = 3
	ld l,(ix+03fh)		;55cb   ; la posicion BAJA: la pista viene hacia ti
	ld h,(ix+040h)		;55ce
	ld a,h			;55d1
	or a			;55d2
	sbc hl,de		;55d3
	ld (ix+03fh),l		;55d5
	ld (ix+040h),h		;55d8
	jr nc,L_55E5		;55db
	inc (ix+041h)		;55dd   ; los dos bytes de arriba llevan la cuenta larga, la de toda la carrera
	jr nz,L_55E5		;55e0
	inc (ix+042h)		;55e2
L_55E5:
	and 0f8h		;55e5   ; lo que se compara son los bits de las filas -los tres de abajo se tiran- antes y despues de restar: si cambian, hay fila nueva
	ld b,a			;55e7
	ld a,h			;55e8
	and 0f8h		;55e9
	sub b			;55eb
	neg		;55ec   ; el `neg` y las tres rotaciones convierten la diferencia en numero de filas
	rrca			;55ee
	rrca			;55ef
	rrca			;55f0
	or a			;55f1
	ret z			;55f2
	ld (ix+04ch),001h		;55f3   ; aqui si hay fila nueva...
	add a,(ix+045h)		;55f7
	ld (ix+045h),a		;55fa
	sub 00ch		;55fd   ; ...y a las doce filas se agota la pieza y se pasa a la siguiente
	ret c			;55ff
	ld (ix+045h),a		;5600
	inc (ix+046h)		;5603
	ld (ix+06fh),003h		;5606   ; (ix+6F) = 3 avisa de que ha cambiado la pieza: el bit 1 lo consume 0x5674 y el otro alguien mas
	ret nz			;560a
	inc (ix+047h)		;560b
	ret			;560e
AVANZA_DOS_FILAS:		; dos filas enteras pintadas y el resto
	push de			;560f   ; las dos filas se pintan enteras y el sobrante se aplica a la posicion sin pintar nada
	ld de,00800h		;5610
	call AVANZA_POSICION		;5613
	call PINTA_FILA_PISTA		;5616
	ld de,00800h		;5619
	call AVANZA_POSICION		;561c
	call PINTA_FILA_PISTA		;561f
	pop hl			;5622
	ld de,01000h		;5623
	or a			;5626
	sbc hl,de		;5627
	ex de,hl			;5629
	call AVANZA_POSICION		;562a
	ld (ix+04ch),003h		;562d   ; 3 en (ix+4C): dos filas nuevas y pico
	ret			;5631
AVANZA_UNA_FILA:		; una fila entera pintada y el resto
	push de			;5632
	ld de,00800h		;5633
	call AVANZA_POSICION		;5636   ; la fila que si cabe se pinta...
	call PINTA_FILA_PISTA		;5639
	pop hl			;563c
	ld de,00800h		;563d
	or a			;5640
	sbc hl,de		;5641   ; ...y lo que sobra se descuenta y se aplica a la posicion sin pintar nada
	ex de,hl			;5643
	call AVANZA_POSICION		;5644
	ld (ix+04ch),002h		;5647   ; y aqui 2: una fila nueva y pico
	ret			;564b
PINTA_FILA_PISTA:		; 7/8/9; fila del buffer de nombres (E400 o EC00, por ix+9) que toca por (ix+40); la pieza (ix+46,47) de la secuencia (E257): 0xFF = fin de vuelta (0x56D7); flags bit 6 -> columna (ix-19) += flags&0x3F (mod 8); E255 = fila de metatile; pinta los 8 metatiles (0x5705); 0x5E6C; 1/2/3
	call MAPEA_7_8_9		;564c   ; la fila de pista se pinta en el buffer del jugador que sea
	ld a,(ix+009h)		;564f
	dec a			;5652
	ld de,0e400h		;5653
	jr z,L_565B		;5656
	ld de,0ec00h		;5658
L_565B:
	call FILA_BUFFER_NOMBRES		;565b
	ex de,hl			;565e
	exx			;565f
	ld l,(ix+046h)		;5660   ; la pieza que toca (ix+46,47) por dos: la secuencia son parejas de bytes
	ld h,(ix+047h)		;5663
	ld de,(0e257h)		;5666
	add hl,hl			;566a
	add hl,de			;566b
	ld b,(hl)			;566c
	ld a,b			;566d
	cp 0ffh		;566e   ; el 0xFF cierra la secuencia: se ha completado una vuelta
	jp z,FIN_DE_VUELTA		;5670
	inc hl			;5673
	bit 1,(ix+06fh)		;5674   ; el bit 1 de (ix+6F) dice que la pieza acaba de cambiar, y solo entonces se mira si trae desplazamiento
	jr z,FILA_PISTA_SIGUE		;5678
	res 1,(ix+06fh)		;567a
	ld a,(hl)			;567e
	bit 6,a		;567f   ; el bit 6 del segundo byte de la pieza es "esta pieza mueve la pista de lado"...
	jr z,FILA_PISTA_SIGUE		;5681
	and 03fh		;5683   ; ...y los seis de abajo, cuanto: se acumulan en (ix-0x19) modulo 8, que es la columna por la que empieza a leerse la fila de metatiles
	add a,(ix-019h)		;5685
	and 007h		;5688
	ld (ix-019h),a		;568a
FILA_PISTA_SIGUE:		; (ix-1).7 = 1 solo si en esta fila se aplico un desplazamiento de columna (el `jr c` mira el acarreo que dejan los `and`, no el bit 7 de C); HL = pieza*24 + fila*8 + columna + (E259); E255 = (E253) + (3 - fila&3)*4
	res 7,(ix-001h)		;568d
	bit 7,c		;5691   ; el `jr c` mira el acarreo que dejaron los `and`, no el bit 7 de C: en la practica el bit 7 de (ix-1) se pone en las filas donde no hubo desplazamiento
	jr c,L_5699		;5693
	set 7,(ix-001h)		;5695
L_5699:
	ld l,b			;5699   ; la pieza por 24: son 3 filas de 8 metatiles
	ld h,000h		;569a
	add hl,hl			;569c
	add hl,hl			;569d
	add hl,hl			;569e
	ld d,h			;569f
	ld e,l			;56a0
	add hl,hl			;56a1
	add hl,de			;56a2
	ld a,(ix+045h)		;56a3   ; de las doce filas de la pieza, la de metatiles es la de los bits 3 y 2...
	and 00ch		;56a6
	add a,a			;56a8
	add a,(ix-019h)		;56a9
	ld e,a			;56ac
	ld d,000h		;56ad
	add hl,de			;56af
	ld de,(0e259h)		;56b0
	add hl,de			;56b4
	push hl			;56b5
	ld a,(ix+045h)		;56b6   ; ...y los dos de abajo dicen que fila del metatile toca, contada AL REVES (3 - fila), que la pista viene hacia el jugador
	and 003h		;56b9
	xor 003h		;56bb
	add a,a			;56bd
	add a,a			;56be
	ld l,a			;56bf
	ld h,000h		;56c0
	ld de,(0e253h)		;56c2
	add hl,de			;56c6
	ld (0e255h),hl		;56c7
	pop hl			;56ca
	call PINTA_8_METATILES		;56cb   ; los ocho metatiles de la fila, y detras 0x5E6C, que es quien pone encima los objetos de la pista
	call MAPEA_7_8_9		;56ce
	call OBJETOS_DE_LA_FILA		;56d1
	jp MAPEA_1_2_3		;56d4
FIN_DE_VUELTA:		; 1/2/3; fila y pieza a cero, (ix+57) = 0, (ix-2)++ (vueltas); p01 0x77A7; y pinta la fila ya desde el principio
	push ix		;56d7   ; fin de vuelta: fila y pieza a cero y una vuelta mas en (ix-2)
	call MAPEA_1_2_3_B		;56d9
	ld (ix+045h),000h		;56dc
	ld (ix+046h),000h		;56e0
	ld (ix+047h),000h		;56e4
	ld (ix+057h),000h		;56e8
	inc (ix-002h)		;56ec
	call 077a7h		;56ef   ; p01 0x77A7 se entera de la vuelta nueva (el marcador y el cronometro)
	pop ix		;56f2
	jp PINTA_FILA_PISTA		;56f4   ; y la fila que iba a pintarse se pinta ya con la secuencia desde el principio: no se pierde ninguna
FILA_BUFFER_NOMBRES:		; HL = DE + (((ix+40) - 0x40) & 0xF8) * 4: la fila de 32 bytes del buffer
	ld a,(ix+040h)		;56f7   ; (ix+40) es el byte de la posicion que cuenta filas; el -0x40 lo coloca en el buffer y el *4 lo pasa a casillas (32 por fila)
	sub 040h		;56fa
	and 0f8h		;56fc
	ld l,a			;56fe
	ld h,000h		;56ff
	add hl,hl			;5701
	add hl,hl			;5702
	add hl,de			;5703
	ret			;5704
PINTA_8_METATILES:		; A/B/C; los 8 indices de la fila HL de la pieza (rotando desde la columna l&7): por cada uno, 4 tiles de (E255) + indice*16 al buffer (HL') con ldi
	ld b,008h		;5705   ; ocho metatiles: 8 x 4 = las 32 casillas de la fila
	call MAPEA_A_B_C		;5707
	ld a,l			;570a   ; la columna de partida son los tres bits de abajo de HL; los otros cinco se guardan en D para no salirse de la fila
	and 0f8h		;570b
	ld d,a			;570d
	jr PINTA_METATILE		;570e
PINTA_METATILE_SIGUIENTE:		; siguiente columna (mod 8 dentro de la fila)
	ld a,l			;5710   ; la columna avanza modulo 8: la fila de metatiles es circular, y eso es lo que deja que la pista se desplace de lado
	inc a			;5711
	and 007h		;5712
	or d			;5714
	ld l,a			;5715
PINTA_METATILE:		; los 4 tiles de una fila del metatile
	ld a,(hl)			;5716   ; el indice del metatile por 16 -cuatro filas de cuatro tiles- mas la fila que dijo E255
	exx			;5717
	ld h,000h		;5718
	ld l,a			;571a
	add hl,hl			;571b
	add hl,hl			;571c
	add hl,hl			;571d
	add hl,hl			;571e
	ld bc,(0e255h)		;571f
	add hl,bc			;5723
	ldi		;5724   ; cuatro `ldi` y no un `ldir`: son cuatro tiles justos y asi no hay que montar BC
	ldi		;5726
	ldi		;5728
	ldi		;572a
	exx			;572c
	djnz PINTA_METATILE_SIGUIENTE		;572d
	ret			;572f
PINTA_ESCENA_FIJA:		; guarda (E257), (E259), (E253); pinta una escena de 3 piezas con las piezas HL y los metatiles DE (0x5755); y los restaura
	ld bc,(0e257h)		;5730   ; la escena fija se pinta con las mismas rutinas que la carrera, asi que hay que guardar y devolver las tres tablas
	push bc			;5734
	ld bc,(0e259h)		;5735   ; se guardan las tres tablas porque la escena las machaca y luego hay que volver a la carrera
	push bc			;5739
	ld bc,(0e253h)		;573a
	push bc			;573e
	call PINTA_ESCENA		;573f
	pop hl			;5742
	ld (0e253h),hl		;5743
	pop hl			;5746
	ld (0e259h),hl		;5747
	pop hl			;574a
	ld (0e257h),hl		;574b
	ret			;574e

; ----------------------------------------------------------------------
; DATOS secuencia_escena: la secuencia fija de las escenas: las piezas 0, 1 y
;   2 con flags 0 (la pinta 0x5588 con 32 filas, asi que nunca llega a leer
;   mas)
;   0x574f..0x5755  (6 bytes)
DATA_secuencia_escena:
	defb 000h,000h	; 574f
	defb 001h,000h	; 5751
	defb 002h,000h	; 5753

; ======================================================================
; CODIGO 0x5755..0x57d8  (131 bytes)
; ======================================================================


PINTA_ESCENA:		; IX = IY = E380 (el bloque del segundo coche): posicion a cero, (E253) = DE, (E259) = HL, (E257) = 0x574F, buffer EC00 ((iy+9) = 2), y las 32 filas (0x5588)
	push de			;5755
	push hl			;5756
	ld iy,0e380h		;5757
	ld ix,0e380h		;575b   ; IX e IY apuntan los dos al bloque de sombra: la escena no es de ningun coche, pero las rutinas de pista piden un bloque
	call POSICION_PISTA_A_CERO		;575f   ; la escena siempre se pinta desde la casilla cero
	pop hl			;5762
	pop de			;5763
	ld (0e253h),de		;5764
	ld (0e259h),hl		;5768
	ld hl,0574fh		;576b
	ld (0e257h),hl		;576e
	ld (iy+009h),002h		;5771   ; (iy+9) = 2 manda la escena al buffer de EC00
	jp PINTA_PISTA_32_FILAS		;5775
PINTA_ESCENA_7D88:		; la escena de piezas p10 0x7D88 y metatiles p10 0x7E38 (26 metatiles; que es, por ver en el emulador)
	push ix		;5778
	push iy		;577a
	ld de,07e38h		;577c   ; las piezas y los metatiles de la escena viven en la pagina 10
	ld hl,07d88h		;577f
	call PINTA_ESCENA_FIJA		;5782
	pop iy		;5785
	pop ix		;5787
	ret			;5789
PINTA_ESCENA_7DD0:		; la escena de piezas p10 0x7DD0 y metatiles p10 0x7E18 (2 metatiles macizos de los tiles 0x89 y 0x8A)
	push ix		;578a
	push iy		;578c
	ld de,07e18h		;578e
	ld hl,07dd0h		;5791   ; esta escena son dos metatiles macizos: un fondo liso
	call PINTA_ESCENA_FIJA		;5794
	pop iy		;5797
	pop ix		;5799
	ret			;579b

; ----------------------------------------------------------------------
; La demo no es una peliculita: es el JUEGO corriendo con el mando
; enchufado a una grabacion. 0x58A2 graba -parejas de (mascara,
; cuadros) segun cambia el mando- y 0x5913 reproduce, metiendo la
; mascara en F004 (jugador 1) y F005 (jugador 2) como si viniera del
; puerto. Las cinco grabaciones estan en 0x5909 y solo la primera,
; 0xC000, esta en RAM: por eso el grabador se planta si el puntero
; sale de 0xC000-0xDEFF.
; ----------------------------------------------------------------------
CAMARA_PASO:		; mueve la camara del coche IX, salvo que este en los estados altos o que lo prohiba el bit 6 de (ix-1)
	bit 6,(ix-001h)		;579c
	jr nz,CAMARA_COPIA		;57a0
	ld a,(ix+05dh)		;57a2   ; con el coche en estado 3 o mas (meta, choque, parado) la camara se queda quieta
	cp 003h		;57a5
	call c,CAMARA_AL_COCHE		;57a7
CAMARA_COPIA:		; (ix+54) = camara, pero solo si la pista ha avanzado en este fotograma
	ld a,(ix+044h)		;57aa   ; con la velocidad alta a cero se copia siempre; si no, hace falta que (ix+4C) diga que hubo fila nueva
	cp 001h		;57ad
	jr c,L_57B6		;57af
	ld a,(ix+04ch)		;57b1
	or a			;57b4
	ret z			;57b5
L_57B6:
	ld a,(ix+04bh)		;57b6
	ld (ix+054h),a		;57b9
	ret			;57bc
CAMARA_AL_COCHE:		; la camara salta a (ix+6) - E1FE si la diferencia cabe en un byte con signo
	ld a,(ix+006h)		;57bd
	sub (ix+04bh)		;57c0
	ld hl,0e1feh		;57c3   ; E1FE vale 0x3C: la camara se queda 60 pixeles por detras del coche
	sub (hl)			;57c6
	ld d,a			;57c7
	add a,040h		;57c8   ; la prueba es "esta la diferencia entre -0x40 y 0x3F"
	cp 080h		;57ca
	ld a,d			;57cc
	jr c,L_57D1		;57cd
	neg		;57cf   ; si no cabe se suma la diferencia CAMBIADA DE SIGNO, con lo que la camara se va al lado contrario; medido, no visto en el emulador
L_57D1:
	add a,(ix+04bh)		;57d1
	ld (ix+04bh),a		;57d4
	ret			;57d7

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (1 bytes)
;   0x57d8..0x57d9  (1 bytes)
DATA_57D8:
	defb 0c9h	; 57d8

; ======================================================================
; CODIGO 0x57d9..0x584d  (116 bytes)
; ======================================================================


DEMO_SIGUIENTE:		; monta la siguiente escena de la demo y la echa a andar
	xor a			;57d9
	ld (0e1fdh),a		;57da
	call LIMPIA_EA80_Y_ATRIBUTOS		;57dd
	ld a,(0e1cdh)		;57e0   ; E1CD es que escena de la demo toca; da la vuelta sola en la fila 5 de la tabla de 0x584D
	inc a			;57e3
	ld (0e1cdh),a		;57e4
	ld a,(0e1ceh)		;57e7   ; y E1CE la fuerza a la primera
	or a			;57ea
	jr z,L_57F1		;57eb
	xor a			;57ed
	ld (0e1cdh),a		;57ee
L_57F1:
	call L_497A		;57f1
	call 074b2h		;57f4
	call DEMO_MONTA_ESCENA		;57f7
	call DEMO_CARGA_GRABACION		;57fa
	ld hl,0f006h		;57fd   ; este `bit 2` no lo mira nadie: las dos instrucciones siguientes machacan HL y no tocan las banderas
	bit 2,(hl)		;5800
	ld hl,0e1f3h		;5802
	ld (hl),001h		;5805
	call SPRITES_DEMO		;5807
	ld hl,0e1c2h		;580a
	res 6,(hl)		;580d   ; bit 6 de E1C2 apagado: en la demo no hay jugador 1, y de ahi cuelga que se pinte el cartel de 0x5967
	xor a			;580f
	ld (0e1d7h),a		;5810
	ld a,035h		;5813   ; el sonido 0x35 es la musica de la demo
	jp ENCOLA_SONIDO		;5815
DEMO_PRIMERA_ESCENA:		; E1CD = 1 y a repetir
	ld a,001h		;5818
	ld (0e1cdh),a		;581a
DEMO_MONTA_ESCENA:		; copia la fila de 0x584D a E25B, E250, E1C2 y F0F6
	ld de,0584dh		;581d
	ld a,(0e1cdh)		;5820   ; cuatro bytes por fila, de ahi el indice por cuatro
	ld h,000h		;5823
	ld l,a			;5825
	add hl,hl			;5826
	add hl,hl			;5827
	add hl,de			;5828
	ld a,(hl)			;5829
	cp 0feh		;582a   ; el 0xFE de la ultima fila no es una escena: es la marca de "vuelve a la primera"
	jr z,DEMO_PRIMERA_ESCENA		;582c
	ld a,(hl)			;582e
	ld de,0e25bh		;582f   ; los cuatro `ldi` van a cuatro sitios distintos, y por eso no hay un `ldir`: categoria, subestado, banderas y grupo de paginas
	ldi		;5832
	ld de,0e250h		;5834
	ldi		;5837
	ld de,0e1c2h		;5839
	ldi		;583c
	ld de,0f0f6h		;583e
	ldi		;5841
	xor a			;5843
	ld (0e251h),a		;5844
	ld (0e27eh),a		;5847
	jp 06565h		;584a

; ----------------------------------------------------------------------
; DATOS escenas_demo: seis filas de 4 bytes indexadas por (E1CD) desde 0x581D
;   (`ld de,0x584D / hl = de + 4*(E1CD)`): categoria (E25B), subestado (E250),
;   banderas (E1C2) y grupo de paginas (F0F6), copiados con cuatro `ldi`; la
;   fila 5 empieza por 0xFE y devuelve (E1CD) a 1
;   0x584d..0x5865  (24 bytes)
DATA_escenas_demo:
	defb 0ffh,005h,000h,004h	; 584d
	defb 0ffh,005h,000h,004h	; 5851
	defb 0ffh,005h,000h,004h	; 5855
	defb 0ffh,005h,000h,00ah	; 5859
	defb 0ffh,005h,000h,00dh	; 585d
	defb 0feh,000h,000h,000h	; 5861

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (17 bytes)
;   0x5865..0x5876  (17 bytes)
DATA_5865:
	defb 004h,001h,00ah,000h,004h,002h,00ah,000h,004h,003h,00ah,000h,004h,004h,00ah,000h	; 5865  ................
	defb 004h	; 5875

; ======================================================================
; CODIGO 0x5876..0x5909  (147 bytes)
; ======================================================================


DEMO_PASO:		; un fotograma de la demo: sprites, mando grabado y el paso normal de la carrera
	call DOS_SPRITES_A_VRAM		;5876
	call DEMO_MANDO		;5879
	call PASO_DE_LA_CARRERA		;587c
	jp CARTEL_DEMO		;587f
DEMO_MANDO:		; mapea el grupo de la escena, saca el mando de la grabacion y lo mete por los flancos
	ld a,(0f006h)		;5882   ; F006 distinto de cero corta la reproduccion
	or a			;5885
	jr nz,L_58A1		;5886
	ld a,(0f0f6h)		;5888   ; la grabacion vive en la pagina que diga F0F6, que cambia con la escena
	call MAPEA_DESDE_A		;588b
	call DEMO_REPRODUCE		;588e
	ld a,(0f004h)		;5891
	call FLANCOS_E1C9		;5894   ; F004 y F005 hacen de puerto de mando: los flancos se calculan igual que con un mando de verdad
	ld a,(0f005h)		;5897
	call FLANCOS_E1CC		;589a
	jp MAPEA_1_2_3		;589d
L_58A0:
	ret			;58a0
L_58A1:
	ret			;58a1
GRABA_MANDO:		; graba el mando: una pareja (cuadros, mascara) cada vez que cambia
	ld a,(0e1deh)		;58a2   ; E1DE = 2, o sea con cartucho Konami enchufado, no se graba
	cp 002h		;58a5
	ret z			;58a7
	ld a,(0f001h)		;58a8   ; F001 cuenta cuantos fotogramas lleva sin cambiar la mascara
	ld c,a			;58ab
	ld d,000h		;58ac
	ld hl,(0f002h)		;58ae
	ld a,h			;58b1
	sub 0c0h		;58b2   ; el puntero tiene que estar entre 0xC000 y 0xDEFF: fuera de ahi se estaria escribiendo en la ROM o pisando otra cosa
	ret c			;58b4
	cp 01fh		;58b5
	ret nc			;58b7
	exx			;58b8
	ld a,(0e1c9h)		;58b9
	ld hl,0f004h		;58bc
	call GRABA_SI_CAMBIA_LA_MASCARA		;58bf
	ld a,(0e1c2h)		;58c2
	bit 5,a		;58c5   ; con dos jugadores tambien se graba el segundo, y su mascara se marca con el bit 7 (el 0x80 de D')
	jr z,L_58D6		;58c7
	exx			;58c9
	ld d,080h		;58ca
	exx			;58cc
	ld hl,0f005h		;58cd
	ld a,(0e1cch)		;58d0
	call GRABA_SI_CAMBIA_LA_MASCARA		;58d3
L_58D6:
	exx			;58d6
	ld a,c			;58d7
	exx			;58d8
	inc a			;58d9   ; y a los 255 fotogramas iguales se corta igual: el contador no da para mas
	ld (0f001h),a		;58da
	cp 0ffh		;58dd
	ret nz			;58df
	jr L_58E5		;58e0
GRABA_SI_CAMBIA_LA_MASCARA:		; si A es igual a (HL) no hace nada; si no, la guarda ahi y cae en 0x58E5, que escribe en (F002) el par (cuadros, mascara | D) y pone el contador a cero
	cp (hl)			;58e2
	ret z			;58e3
	ld (hl),a			;58e4
L_58E5:
	exx			;58e5
	ld (hl),c			;58e6
	inc hl			;58e7
	or d			;58e8   ; el `or d` es lo que marca la mascara del segundo jugador con el bit 7
	ld (hl),a			;58e9
	inc hl			;58ea
	ld (0f002h),hl		;58eb
	ld c,000h		;58ee
	exx			;58f0
	ret			;58f1
DEMO_CARGA_GRABACION:		; el puntero de la grabacion de la escena (E1CD) y los contadores a cero
	ld a,(0e1cdh)		;58f2
	ld hl,05909h		;58f5
	call HL_PALABRA_A		;58f8   ; cada escena de la demo tiene su grabacion, y la tabla de 0x5909 las reparte
	ld (0f002h),hl		;58fb
	xor a			;58fe
	ld (0f001h),a		;58ff
	ld (0f004h),a		;5902
	ld (0f005h),a		;5905
	ret			;5908

; ----------------------------------------------------------------------
; DATOS partidas_grabadas: cinco punteros a las partidas grabadas de la demo,
;   uno por (E1CD) 0..4: 0xC000, 0xBDC1, 0xBE26, 0xBF3B y 0xBAB9. Los lee
;   0x58F5 (`ld a,(E1CD) / ld hl,0x5909 / call HL_PALABRA_A / ld (F002),hl`) y
;   de ahi los va sacando el reproductor de 0x5920 (mascara, cuadros). Con el
;   grupo de paginas que pone la fila de 0x584D (4, 4, 0x0A, 0x0D) las tres
;   ultimas caen en p06 0xBDC1/0xBE26, p12 0xBF3B y p15 0xBAB9: los tres
;   bloques de pares que ya estaban medidos
;   0x5909..0x5913  (10 bytes)
DATA_partidas_grabadas:
	defw 0c000h	; 5909
	defw 0bdc1h	; 590b
	defw 0be26h	; 590d
	defw 0bf3bh	; 590f
	defw 0bab9h	; 5911

; ======================================================================
; CODIGO 0x5913..0x5993  (128 bytes)
; ======================================================================


DEMO_REPRODUCE:		; baja el contador de cuadros y, al llegar, saca la pareja siguiente
	ld a,(0f001h)		;5913
	or a			;5916   ; el cero y el uno se tratan igual: los dos piden pareja nueva
	jr z,DEMO_PAREJA		;5917
	dec a			;5919
	jr z,DEMO_PAREJA		;591a
	ld (0f001h),a		;591c
	ret			;591f
DEMO_PAREJA:		; lee (mascara, cuadros) y aplica la mascara
	ld hl,(0f002h)		;5920   ; el primer byte es la mascara y el segundo cuantos fotogramas dura
	ld d,(hl)			;5923
	inc hl			;5924
	ld c,(hl)			;5925
	inc hl			;5926
	ld (0f002h),hl		;5927
	ld a,c			;592a
	ld (0f001h),a		;592b
	push bc			;592e
	bit 6,d		;592f   ; el bit 6 de la mascara la saca de lo normal: no es un mando, es una orden
	call nz,DEMO_ORDEN		;5931
	call z,DEMO_MASCARA		;5934
	pop bc			;5937
	ld a,c			;5938   ; con cero cuadros se encadena la pareja siguiente sin gastar fotograma: asi caben dos ordenes seguidas
	or a			;5939
	ret nz			;593a
	jr DEMO_REPRODUCE		;593b
DEMO_ORDEN:		; la unica orden que hace algo es el 0x4F: apaga E1F3 y suena el 0x81
	ld a,d			;593d
	cp 04fh		;593e
	ret nz			;5940
	xor a			;5941   ; E1F3 a cero y el sonido 0x81: es la unica orden que trae la grabacion, y marca el final de la escena
	ld (0e1f3h),a		;5942
	ld a,081h		;5945
	call ENCOLA_SONIDO		;5947
	or 0ffh		;594a
	ret			;594c
DEMO_MASCARA:		; la mascara a F004, o a F005 si trae el bit 7 (el segundo jugador)
	ld a,d			;594d
	and 07fh		;594e
	cp d			;5950   ; el `and 0x7f` y el `cp d` juntos preguntan si el bit 7 estaba puesto
	jr nz,L_5957		;5951
	ld (0f004h),a		;5953
	ret			;5956
L_5957:
	ld (0f005h),a		;5957
	ret			;595a
SPRITES_DEMO:		; la lista p04 0x74F2, solo si no hay jugador 1
	ld a,(0e1c2h)		;595b
	and 040h		;595e
	ret nz			;5960
	ld hl,074f2h		;5961
	jp CARGA_LISTA_SPRITES		;5964
CARTEL_DEMO:		; dos sprites arriba a la derecha que parpadean mientras la demo se juega sola
	ld a,(0e1c2h)		;5967   ; con jugador 1 no hay cartel que pintar
	and 040h		;596a
	ret nz			;596c
	ld a,(0e1d7h)		;596d   ; y tampoco mientras esten las luces de salida (E1D7)
	or a			;5970
	jr nz,CARTEL_DEMO_BORRA		;5971
	ld de,0ea80h		;5973
	ld a,(0e1c3h)		;5976   ; el bit 3 del contador de fotogramas: ocho encendido y ocho apagado
	and 008h		;5979
	jr z,CARTEL_DEMO_BORRA		;597b
	ld hl,05993h		;597d
	ld bc,00008h		;5980
	ldir		;5983
	ex de,hl			;5985
	ret			;5986
CARTEL_DEMO_BORRA:		; los dos sprites a 0xE0, fuera de la pantalla
	ex de,hl			;5987
	ld b,002h		;5988
L_598A:
	ld (hl),0e0h		;598a   ; los atributos van de cuatro en cuatro y solo se toca la Y
	inc l			;598c
	inc l			;598d
	inc l			;598e
	inc l			;598f
	djnz L_598A		;5990
	ret			;5992

; ----------------------------------------------------------------------
; DATOS sprites_5993: dos atributos de sprite (y, x, patron, color) que 0x597D
;   copia a EA80 (`ld hl,0x5993 / ld bc,8 / ldir`): (0x10, 0xB0, 0xC0, 6) y
;   (0x10, 0xC0, 0xC4, 6)
;   0x5993..0x599b  (8 bytes)
DATA_sprites_5993:
	defb 010h,0b0h,0c0h,006h	; 5993
	defb 010h,0c0h,0c4h,006h	; 5997

; ======================================================================
; CODIGO 0x599b..0x5a40  (165 bytes)
; ======================================================================


MONTA_LA_CARRERA:		; la carrera entera montada de cero: pantalla, RAM de objetos, tiles, sprites, circuito y las 32 filas de pista de los dos coches
	call BORRA_SPRITES_Y_NOMBRES		;599b
	call LIMPIA_EA80_Y_ATRIBUTOS		;599e
	ld hl,00000h		;59a1   ; 0x3000 bytes a cero es la VRAM entera menos los sprites: patrones, colores y nombres
	ld bc,03000h		;59a4
	xor a			;59a7
	call 00056h		;59a8   ; BIOS FILVRM - Fills VRAM with value
	call MAPEA_D_E_F		;59ab
	call MAPEA_1_2_3		;59ae
	call 08762h		;59b1
	ld hl,0e800h		;59b4   ; 0x117 bytes desde E800 y otros tantos desde E928: los cinco objetos de cada jugador, de 0x38 bytes
	ld bc,00117h		;59b7
	call RELLENA_RAM_CERO		;59ba
	ld hl,0e928h		;59bd
	ld bc,00117h		;59c0
	call RELLENA_RAM_CERO		;59c3
	call 0a089h		;59c6
	xor a			;59c9
	ld (0e221h),a		;59ca
	ld (0e1d7h),a		;59cd
	call CARGA_TILES_CIRCUITO		;59d0   ; los tiles de la pista y, encima, la lista p04 0x620A
	ld hl,0620ah		;59d3
	call CARGA_LISTA_TILES		;59d6
	call COLORES_0_210_A_CERO		;59d9
	call CARGA_SPRITES_CARRERA		;59dc
	call 0887ah		;59df
	ld ix,0e2c0h		;59e2   ; el circuito se prepara dos veces, una por coche: cada uno lleva su propia posicion en la pista
	call PREPARA_CIRCUITO		;59e6
	ld ix,0e380h		;59e9
	call PREPARA_CIRCUITO		;59ed
	call 0801ah		;59f0
	call 07f3ch		;59f3
	call 07583h		;59f6
	ld ix,0e2c0h		;59f9
	call PINTA_PISTA_32_FILAS		;59fd   ; y la pantalla de pista tambien se pinta dos veces, cada una en su buffer
	ld ix,0e380h		;5a00
	call PINTA_PISTA_32_FILAS		;5a04
	call 09f74h		;5a07
	ld hl,0e91ch		;5a0a
	ld bc,00002h		;5a0d
	call RELLENA_RAM_CERO		;5a10
	call 0a5b9h		;5a13
	xor a			;5a16
	ld (0e21fh),a		;5a17   ; la semilla del azar y el contador de fotogramas a cero: la carrera empieza siempre igual
	ld (0e1c3h),a		;5a1a
	ld (0e213h),a		;5a1d
	ld (0e214h),a		;5a20
	ld (0e244h),a		;5a23   ; E244 a cero: sin repeticion pedida
	ret			;5a26
PASO_DE_LA_CARRERA:		; un fotograma del estado 5: E262++, revuelve el azar y despacha por E250
	ld a,(0f006h)		;5a27
	or a			;5a2a
	call nz,L_58A1		;5a2b
	ld hl,0e262h		;5a2e   ; E262 es el contador de fotogramas de la carrera
	inc (hl)			;5a31
	call REVUELVE_AZAR		;5a32
	ld a,(0e250h)		;5a35
	and 07fh		;5a38   ; el bit 7 de E250 se tira al despachar: solo cuentan los 32 estados de la tabla
	ld (0e250h),a		;5a3a
	call DESPACHA		;5a3d

; ----------------------------------------------------------------------
; DATOS tabla_5A3D: 32 palabras del despachador de 0x5A3D (indice (E250)&0x7F)
;   0x5a40..0x5a80  (64 bytes)
DATA_tabla_5A3D:
	defw 05a80h	; 5a40  -> L_5A80
	defw 05a83h	; 5a42  -> L_5A83
	defw 05a86h	; 5a44  -> ESTADO_2_MUSICA
	defw 05a8eh	; 5a46  -> L_5A8E
	defw 05a94h	; 5a48  -> L_5A94
	defw 05a97h	; 5a4a  -> L_5A97
	defw 05a9ah	; 5a4c  -> L_5A9A
	defw 05a9dh	; 5a4e  -> L_5A9D
	defw 05aa3h	; 5a50  -> ESTADO_MONTA_CARRERA
	defw 05aa3h	; 5a52  -> ESTADO_MONTA_CARRERA
	defw 05aa3h	; 5a54  -> ESTADO_MONTA_CARRERA
	defw 05aabh	; 5a56  -> ESTADO_11_CARRERA
	defw 05b02h	; 5a58  -> ESTADO_12_BOXES
	defw 05b10h	; 5a5a  -> ESTADO_13_BOXES
	defw 05b19h	; 5a5c  -> ESTADO_14_FINAL
	defw 05b4fh	; 5a5e  -> L_5B4F
	defw 05b52h	; 5a60  -> L_5B52
	defw 05b55h	; 5a62  -> L_5B55
	defw 05b58h	; 5a64  -> L_5B58
	defw 05b66h	; 5a66  -> L_5B66
	defw 05b66h	; 5a68  -> L_5B66
	defw 05b66h	; 5a6a  -> L_5B66
	defw 05b66h	; 5a6c  -> L_5B66
	defw 05b66h	; 5a6e  -> L_5B66
	defw 05b69h	; 5a70  -> L_5B69
	defw 05a8bh	; 5a72  -> L_5A8B
	defw 05b6ch	; 5a74  -> L_5B6C
	defw 05b6fh	; 5a76  -> L_5B6F
	defw 05b72h	; 5a78  -> ESTADO_22
	defw 05b90h	; 5a7a  -> ESTADO_25_REINICIA
	defw 05b9dh	; 5a7c  -> ESTADO_A_2
	defw 05b9dh	; 5a7e  -> ESTADO_A_2

; ======================================================================
; CODIGO 0x5a80..0x5d29  (681 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; La tabla de 0x5A40 son 32 estados y casi todos son un `jp` a otra
; pagina: aqui solo estan los que tocan la pista. Los que importan:
; 8, 9 y 10  montar la carrera (0x5AA3)
; 11         un fotograma de carrera (0x5AAB)
; 12 y 13    la parada en boxes (0x5B02 y 0x5B10)
; 14         se acabo la carrera (0x5B19)
; 25         volver al arranque (0x5B90)
;
; EL CRONOMETRO ESTA HECHO PARA 60 Hz. 0x5CAA le suma uno a E210 una
; vez por paso de logica, la interrupcion solo da un paso cada TRES
; (F0FC, ver 0x4018) y 0x5339 divide por 20 para sacar los segundos:
; 3 x 20 = 60. En una maquina NTSC el reloj va exacto; en una PAL,
; con 50 interrupciones por segundo, salen 16,67 pasos y el reloj se
; queda al 83 % - marca cinco segundos por cada seis reales.
; ----------------------------------------------------------------------
L_5A80:
	jp 0680ch		;5a80
L_5A83:
	jp 06877h		;5a83
ESTADO_2_MUSICA:		; la musica 0x35 y 0x5F6F
	ld a,035h		;5a86
	call 0884ch		;5a88
L_5A8B:
	jp MONTA_SELECCION		;5a8b
L_5A8E:
	call SELECCION_PASO		;5a8e
	jp SALTA_LA_ESPERA		;5a91
L_5A94:
	jp 07162h		;5a94
L_5A97:
	jp 071cdh		;5a97
L_5A9A:
	jp 063f7h		;5a9a
L_5A9D:
	call 06452h		;5a9d
	jp SALTA_LA_ESPERA		;5aa0
ESTADO_MONTA_CARRERA:		; monta la carrera y pasa al estado siguiente
	call MONTA_LA_CARRERA		;5aa3
	ld a,001h		;5aa6   ; el 1 es para p01 0x604C, que es a donde salta 0x5BA2 despues de subir el estado
	jp ESTADO_MAS_UNO		;5aa8
ESTADO_11_CARRERA:		; el fotograma de carrera: normal, o la repeticion si E244 vale 2
	ld a,(0e244h)		;5aab   ; E244 = 2 es la repeticion en marcha, y entonces el fotograma es otro (0x5C5C)
	cp 002h		;5aae
	jr nz,L_5AB7		;5ab0
	call FOTOGRAMA_REPETICION		;5ab2
	jr L_5ABA		;5ab5
L_5AB7:
	call FOTOGRAMA_CARRERA		;5ab7
L_5ABA:
	call 07f62h		;5aba
	call 0876eh		;5abd
	ld a,(0e221h)		;5ac0   ; E221 a 0xFF: se acabo el tiempo, y p01 0x6049 pasa al estado 14
	inc a			;5ac3
	ld a,00eh		;5ac4
	jp z,06049h		;5ac6
	ld a,(0e1fdh)		;5ac9   ; E1FD encendido: la repeticion se puede cortar con el mando
	or a			;5acc
	call nz,CORTA_REPETICION		;5acd
	ld a,(0e20ah)		;5ad0   ; y sin musica sonando no hay atajo que valga
	or a			;5ad3
	ret z			;5ad4
	ld a,(0e1c0h)		;5ad5   ; el atajo de saltarse la carrera pide varias cosas a la vez: E20A con musica, E1C0 = 5, el bit 0 de E1D8 y ningun boton pulsado
	cp 005h		;5ad8
	ret nz			;5ada
	ld a,(0e1d8h)		;5adb
	bit 0,a		;5ade
	ret z			;5ae0
	ld a,(0e1cch)		;5ae1
	ld hl,0e1c9h		;5ae4
	or (hl)			;5ae7
	ret nz			;5ae8
	call GUARDA_E1D5		;5ae9
	ld a,01ch		;5aec
	jp 06049h		;5aee
CORTA_REPETICION:		; con el bit 4 de E1D8 y sin botones, p02 0x928A
	ld a,(0e1d8h)		;5af1
	bit 4,a		;5af4   ; el bit 4 de E1D8 es la tecla de cortar
	ret z			;5af6
	ld a,(0e1cch)		;5af7
	ld hl,0e1c9h		;5afa
	or (hl)			;5afd
	ret nz			;5afe
	jp 0928ah		;5aff
ESTADO_12_BOXES:		; monta la parada y arranca su musica (la 0x3C)
	call CRONOMETRO_MAS_UNO		;5b02
	call L_543B		;5b05
	call BOXES_ENTRA		;5b08
	ld a,03ch		;5b0b
	jp 0884ch		;5b0d
ESTADO_13_BOXES:		; un fotograma de la parada
	call CRONOMETRO_MAS_UNO		;5b10
	call L_543B		;5b13
	jp BOXES_PASO		;5b16
ESTADO_14_FINAL:		; se acabo la carrera: puntos, musica y a limpiar
	ld a,(0e1c2h)		;5b19
	bit 5,a		;5b1c
	jr nz,L_5B28		;5b1e
	call 06b49h		;5b20   ; p01 0x6B49 reparte los puntos del campeonato; si dice que no (NC), el estado 16
	ld a,010h		;5b23
	jp nc,06049h		;5b25
L_5B28:
	ld hl,0e2c1h		;5b28
	ld a,(0e1c2h)		;5b2b
	bit 5,a		;5b2e   ; con dos jugadores el que manda es el que haya ganado (E91B)
	jr z,L_5B3B		;5b30
	ld a,(0e91bh)		;5b32
	dec a			;5b35
	jr nz,L_5B3B		;5b36
	ld hl,0e381h		;5b38
L_5B3B:
	ld a,03eh		;5b3b   ; con dos jugadores se mira el coche que haya ganado (E91B); el bit 1 de sus banderas es "termino"
	bit 1,(hl)		;5b3d
	jr nz,L_5B43		;5b3f
	ld a,03fh		;5b41   ; la musica 0x3E si termino y la 0x3F si no: la de la victoria y la del abandono
L_5B43:
	call 0884ch		;5b43
	call LIMPIA_EA80_Y_ATRIBUTOS		;5b46
	call ESTADO_MAS_UNO		;5b49
	jp CIERRA_GRABACION		;5b4c
L_5B4F:
	jp 06970h		;5b4f
L_5B52:
	jp 081a6h		;5b52
L_5B55:
	jp 081f7h		;5b55
L_5B58:
	ld c,011h		;5b58
	call 083bch		;5b5a   ; p02 0x83BC con C = 0x11; mientras no acabe, no se limpia nada
	ret nz			;5b5d
	call BORRA_SPRITES_Y_NOMBRES		;5b5e
	ld a,00eh		;5b61
	jp 06049h		;5b63
L_5B66:
	jp 068a7h		;5b66
L_5B69:
	jp 068a7h		;5b69
L_5B6C:
	jp 07cd0h		;5b6c
L_5B6F:
	jp 07cfdh		;5b6f
ESTADO_22:		; E1D5 = (E1DC) y, con el bit 0 de E1D8, p02 0x864B y el estado 11
	ld a,(0e1dch)		;5b72
	ld (0e1d5h),a		;5b75
	ld a,(0e1d8h)		;5b78
	bit 0,a		;5b7b   ; el bit 0 de E1D8 es lo que saca de este estado
	ret z			;5b7d
	call 0864bh		;5b7e
	ld a,00bh		;5b81
	jp 06049h		;5b83
GUARDA_E1D5:		; p02 0x863D y E1DC = (E1D5)
	call 0863dh		;5b86
	ld a,(0e1d5h)		;5b89
	ld (0e1dch),a		;5b8c
	ret			;5b8f
ESTADO_25_REINICIA:		; bit 0 en E20B y en F0FE, y vuelta al arranque de 0x4202
	ld hl,0e20bh		;5b90
	set 0,(hl)		;5b93
	ld hl,0f0feh		;5b95
	set 0,(hl)		;5b98
	jp L_4202		;5b9a
ESTADO_A_2:		; p01 0x6049 con 2
	ld a,002h		;5b9d
	jp 06049h		;5b9f
ESTADO_MAS_UNO:		; E250++ y p01 0x604C
	ld hl,0e250h		;5ba2
	inc (hl)			;5ba5
	jp 0604ch		;5ba6
SALTA_LA_ESPERA:		; en los estados 7 y 3 (con subestado), el bit 4 de E1D8 y sin botones se salta a p01 0x68A7 con E25B = 0xFF
	ld a,(0e250h)		;5ba9
	cp 007h		;5bac   ; solo desde los estados 7 y 3 se puede saltar la espera
	jr z,L_5BB8		;5bae
	cp 003h		;5bb0
	ret nz			;5bb2
	ld a,(0e251h)		;5bb3
	and a			;5bb6
	ret z			;5bb7
L_5BB8:
	ld a,(0e1c8h)		;5bb8   ; hace falta que no haya ninguna tecla ni boton pulsados: si no, el salto seria el mismo que acaba de pulsar el jugador
	ld hl,0e1cbh		;5bbb
	or (hl)			;5bbe
	ret nz			;5bbf
	ld a,(0e1d8h)		;5bc0
	bit 4,a		;5bc3
	ret z			;5bc5
	ld a,0ffh		;5bc6
	ld (0e25bh),a		;5bc8
	jp 068a7h		;5bcb
CIERRA_GRABACION:		; pone el 0xFF final a la partida grabada, si el puntero cae donde debe
	ld a,(0f006h)		;5bce   ; F006 a cero: no habia nada que grabar
	or a			;5bd1
	ret z			;5bd2
	ld hl,0f006h		;5bd3
	res 0,(hl)		;5bd6
	ld de,(0f002h)		;5bd8
	inc de			;5bdc
	ld hl,03fe0h		;5bdd   ; las dos sumas son la prueba de que el puntero esta dentro de la RAM que se puede escribir; fuera de ahi no se toca nada
	add hl,de			;5be0
	ret nc			;5be1
	ld bc,0e100h		;5be2
	add hl,bc			;5be5
	ret c			;5be6
	ex de,hl			;5be7
	ld (hl),0ffh		;5be8
	ld hl,0e1ceh		;5bea   ; E1CE = 1 hace que la demo vuelva a la primera escena
	ld (hl),001h		;5bed
	ret			;5bef
FOTOGRAMA_CARRERA:		; el fotograma normal: avanza y pinta la pista de cada coche, mueve las camaras y repinta el HUD
	ld a,001h		;5bf0
	ld (0e1d5h),a		;5bf2
	call FOTOGRAMAS_COCHES		;5bf5   ; los fotogramas de los coches se recalculan antes de nada
	call 07dcah		;5bf8
	call CRONOMETRO_MAS_UNO		;5bfb
	ld ix,0e2c0h		;5bfe
	ld iy,0e2c0h		;5c02
	call SIN_AVANCE		;5c06   ; primero se dice que no hay fila nueva y luego 0x55B1 decide cuantas hay
	call AVANZA_PISTA		;5c09
	call PINTA_FILA_PISTA		;5c0c
	ld hl,0e1c2h		;5c0f
	bit 5,(hl)		;5c12   ; el bit 5 de E1C2 es "dos jugadores": el segundo coche solo se mueve si lo hay
	jr z,L_5C27		;5c14
	ld ix,0e380h		;5c16
	ld iy,0e380h		;5c1a
	call SIN_AVANCE		;5c1e
	call AVANZA_PISTA		;5c21
	call PINTA_FILA_PISTA		;5c24
L_5C27:
	call 089ech		;5c27
	call 090e7h		;5c2a
	ld ix,0e2c0h		;5c2d
	ld iy,0e2c0h		;5c31
	call CAMARA_PASO		;5c35   ; una camara por coche, cada una siguiendo la suya
	ld ix,0e380h		;5c38
	ld iy,0e380h		;5c3c
	ld hl,0e1c2h		;5c40
	bit 5,(hl)		;5c43
	call nz,CAMARA_PASO		;5c45
	call 09d06h		;5c48
	call 0a110h		;5c4b
	call 0ab63h		;5c4e
	call 06ef8h		;5c51   ; p01 0x6EF8 vuelca los objetos y 0x760D repinta el HUD
	call 0760dh		;5c54
	call L_5C5B		;5c57
	ret			;5c5a
L_5C5B:
	ret			;5c5b
FOTOGRAMA_REPETICION:		; el mismo fotograma pero para la repeticion: un solo coche y sin mando
	call VENTANA_JUGADOR_2		;5c5c   ; en la repeticion no hay segundo coche: ni pista, ni camara, ni HUD para el
	call 07134h		;5c5f
	call 07dcah		;5c62   ; en la repeticion la pista se mueve sola: el mando no pinta nada
	call CRONOMETRO_MAS_UNO		;5c65
	ld ix,0e2c0h		;5c68
	ld iy,0e2c0h		;5c6c
	call SIN_AVANCE		;5c70
	call AVANZA_PISTA		;5c73
	call PINTA_FILA_PISTA		;5c76
	call 089ech		;5c79
	call 090e7h		;5c7c
	ld ix,0e2c0h		;5c7f
	ld iy,0e2c0h		;5c83
	call CAMARA_PASO		;5c87
	call 09d06h		;5c8a
	call 0a110h		;5c8d
	call 0ab63h		;5c90
	call 0b44ch		;5c93   ; y aqui, en cambio, si se repintan los objetos de tiles, que la repeticion los enseña igual
	call 070dfh		;5c96
	call 0760dh		;5c99
	call L_5CA0		;5c9c
	ret			;5c9f
L_5CA0:
	ret			;5ca0
CRONOMETRO_A_CERO:		; E210 y E211 a cero
	ld hl,0e210h		;5ca1
	ld bc,00002h		;5ca4
	jp RELLENA_RAM_CERO		;5ca7
CRONOMETRO_MAS_UNO:		; el cronometro de 24 bits (E210, E211, E212) sube uno por paso de logica
	ld hl,0e210h		;5caa   ; con tres interrupciones por paso, esto son 20 pasos por segundo en una maquina de 60 Hz: por eso 0x5339 divide por 20
	inc (hl)			;5cad
	ret nz			;5cae
	inc hl			;5caf
	inc (hl)			;5cb0
	ret nz			;5cb1
	inc hl			;5cb2
	inc (hl)			;5cb3
	ret			;5cb4

; ----------------------------------------------------------------------
; La presentacion tiene su propio subestado en E1DD y su despachador
; de once entradas en 0x5D26. Lo bonito es como aparece el dibujo:
; no hay paleta que tocar en un MSX1, asi que el desvanecido se hace
; pintando LOS COLORES DE LOS TILES uno a uno. La lista de 0x5E4A
; son once tramos de tres bytes -tile final, color y tile de
; arranque- y 0x5E0D/0x5E17 los recorren tile a tile, tres por
; vuelta cuando hay prisa (0x5DEA).
; ----------------------------------------------------------------------
MONTA_PRESENTACION:		; la pantalla del titulo: borra, pone el marco, carga los tiles y descomprime el dibujo
	xor a			;5cb5
	ld (0e1d5h),a		;5cb6
	ld (0e1ddh),a		;5cb9
	ld b,0e0h		;5cbc   ; 0xE0 en el registro 7 del VDP: el borde de la pantalla
	call VDP_REG_7		;5cbe
	call BORRA_SPRITES_Y_NOMBRES		;5cc1
	ld hl,0e400h		;5cc4   ; el buffer entero a 0xFF...
	ld bc,002ffh		;5cc7
	ld a,0ffh		;5cca
	call RELLENA_RAM		;5ccc
	ld hl,0e420h		;5ccf   ; ...y por dentro a cero: lo que queda de 0xFF son la fila de arriba y las dos de abajo, que hacen de marco
	ld bc,0029fh		;5cd2
	call RELLENA_RAM_CERO		;5cd5
	call TILES_16_58_F0		;5cd8
	ld hl,06d34h		;5cdb
	call CARGA_LISTA_TILES		;5cde
	ld bc,00800h		;5ce1   ; los colores de los 256 tiles a cero en los tres tercios: el dibujo esta ahi pero no se ve
	ld hl,00000h		;5ce4
	xor a			;5ce7
	call LLENA_VRAM_3_TERCIOS_B		;5ce8
	xor a			;5ceb
	ld bc,00008h		;5cec
	ld hl,020ffh		;5cef   ; ocho bytes desde 0x20FF, sin alinear con ningun tile: pilla la ultima fila del 31 y las siete primeras del 32
	call LLENA_VRAM_3_TERCIOS_B		;5cf2
	ld a,008h		;5cf5
	call MAPEA_A_EN_8000		;5cf7   ; el dibujo del titulo vive en la pagina 8 y se descomprime en el buffer, 0x20 columnas desde E4A0
	ld a,020h		;5cfa
	ld hl,0e4a0h		;5cfc
	ld de,08280h		;5cff
	call 0637ah		;5d02
	call MAPEA_1_2_3		;5d05
	call VUELCA_NOMBRES_E400		;5d08
	ld a,(0e1c0h)		;5d0b   ; con E1C0 = 5 no hay musica: se viene de otro sitio
	cp 005h		;5d0e
	ret z			;5d10
	ld a,033h		;5d11
	jp 0884ch		;5d13
PRESENTACION_MONTA_Y_PASO:		; monta la pantalla y da el primer paso
	call MONTA_PRESENTACION		;5d16
PRESENTACION_PASO:		; un paso, y acarreo cuando la presentacion se ha acabado (E1DD = 10)
	call PRESENTACION_DESPACHA		;5d19
	ld a,(0e1ddh)		;5d1c
	cp 00ah		;5d1f
	ccf			;5d21
	ret			;5d22
PRESENTACION_DESPACHA:		; por E1DD, con la tabla de 0x5D29
	ld a,(0e1ddh)		;5d23
	call DESPACHA		;5d26

; ----------------------------------------------------------------------
; DATOS tabla_5D26: 11 palabras del despachador de 0x5D26 (indice (E1DD), que
;   antes se comprobo < 10)
;   0x5d29..0x5d3f  (22 bytes)
DATA_tabla_5D26:
	defw 05d40h	; 5d29  -> PRESENTACION_0
	defw 05d4eh	; 5d2b  -> PRESENTACION_1
	defw 05d7ch	; 5d2d  -> PRESENTACION_ESPERA
	defw 05d74h	; 5d2f  -> PRESENTACION_3
	defw 05d7ch	; 5d31  -> PRESENTACION_ESPERA
	defw 05d8dh	; 5d33  -> PRESENTACION_5
	defw 05d97h	; 5d35  -> PRESENTACION_6
	defw 05d9fh	; 5d37  -> PRESENTACION_7
	defw 05d7ch	; 5d39  -> PRESENTACION_ESPERA
	defw 05dbch	; 5d3b  -> PRESENTACION_9
	defw 05d3fh	; 5d3d  -> L_5D3F

; ======================================================================
; CODIGO 0x5d3f..0x5e4a  (267 bytes)
; ======================================================================


L_5D3F:
	ret			;5d3f
PRESENTACION_0:		; arranca: E252 a cero y cuatro fotogramas de espera
	xor a			;5d40
	ld (0e252h),a		;5d41
	ld a,004h		;5d44
PRESENTACION_SIGUIENTE:		; E1DD++ y la espera en E1C4
	ld hl,0e1ddh		;5d46
	inc (hl)			;5d49
	ld (0e1c4h),a		;5d4a
	ret			;5d4d
PRESENTACION_1:		; los colores a 0xEF -blanco sobre negro- y empieza el desvanecido
	ld hl,00000h		;5d4e
	ld bc,007f8h		;5d51
	ld a,0efh		;5d54   ; 0xEF es tinta 14 y fondo 15: es el color con el que va apareciendo el dibujo
	call LLENA_VRAM_3_TERCIOS_B		;5d56
	call DESVANECIDO_EMPIEZA		;5d59
	ld a,(0e1c0h)		;5d5c   ; si se viene del estado 5 se salta directo al subestado 8: ni logotipo ni "PUSH SPACE KEY"
	cp 005h		;5d5f
	ld a,01eh		;5d61
	jr nz,PRESENTACION_SIGUIENTE		;5d63
	xor a			;5d65
	ld (0e252h),a		;5d66
	ld a,008h		;5d69
	ld (0e1ddh),a		;5d6b
	ld a,01eh		;5d6e
	ld (0e1c4h),a		;5d70
	ret			;5d73
PRESENTACION_3:		; tres tramos de desvanecido por fotograma hasta que se acaba la lista
	call DESVANECE_TRES		;5d74
	ret nc			;5d77
	ld a,014h		;5d78
	jr PRESENTACION_SIGUIENTE		;5d7a
PRESENTACION_ESPERA:		; se queda quieta hasta que E1C4 llega a cero
	call BAJA_E1C4		;5d7c
	ret nz			;5d7f
	jr PRESENTACION_SIGUIENTE		;5d80
BAJA_E1C4:		; E1C4 baja uno de cada cuatro fotogramas
	ld a,(0e1c3h)		;5d82   ; uno de cada cuatro: la espera dura cuatro veces lo que dice el numero
	and 003h		;5d85
	ret nz			;5d87
	ld hl,0e1c4h		;5d88
	dec (hl)			;5d8b
	ret			;5d8c
PRESENTACION_5:		; pinta el rotulo p09 0xAFF6 (el logotipo y el 1987) y espera
	ld de,0aff6h		;5d8d   ; --> "(16)(10):KONAMI 1987"
	call PINTA_ROTULO		;5d90
	ld a,014h		;5d93
	jr PRESENTACION_SIGUIENTE		;5d95
PRESENTACION_6:		; espera y pasa con 0x30
	call BAJA_E1C4		;5d97
	ret nz			;5d9a
	ld a,030h		;5d9b
	jr PRESENTACION_SIGUIENTE		;5d9d
PRESENTACION_7:		; hace parpadear "PUSH SPACE KEY" mientras espera
	call PARPADEA_PUSH_SPACE		;5d9f
	call BAJA_E1C4		;5da2   ; el parpadeo va por su cuenta y la espera por la suya
	ret nz			;5da5
	xor a			;5da6
	ld (0e252h),a		;5da7
	ld a,001h		;5daa
	jr PRESENTACION_SIGUIENTE		;5dac
PARPADEA_PUSH_SPACE:		; el rotulo p09 0xB000, cuatro fotogramas si y cuatro no
	ld de,0b000h		;5dae   ; --> "(20)(9)PUSH SPACE KEY"
	ld a,(0e1c3h)		;5db1   ; el bit 2 del contador de fotogramas: cuatro encendido y cuatro apagado
	and 004h		;5db4
	jp z,PINTA_ROTULO		;5db6
	jp BORRA_ROTULO		;5db9
PRESENTACION_9:		; apaga el dibujo: colores del tile 0 y la tabla de nombres entera
	ld bc,00008h		;5dbc
	ld hl,00000h		;5dbf
	xor a			;5dc2
	call LLENA_VRAM_3_TERCIOS_B		;5dc3
	ld hl,03800h		;5dc6
	ld bc,00300h		;5dc9
	xor a			;5dcc
	call 00056h		;5dcd   ; BIOS FILVRM - Fills VRAM with value | este `jr nz` cuelga de las banderas que devuelva FILVRM, que no son parte del contrato del BIOS; con el `xor a` de la linea de arriba llegan en Z tanto si el BIOS las restaura como si sale de su propia cuenta a cero, asi que el salto no se toma
	jr nz,PRESENTACION_9		;5dd0
	jp PRESENTACION_SIGUIENTE		;5dd2
PINTA_LOGOTIPO:		; el rotulo p09 0xAFF6 y el desvanecido entero de una vez
	ld de,0aff6h		;5dd5   ; --> "(16)(10):KONAMI 1987"
	call PINTA_ROTULO		;5dd8
	call DESVANECIDO_EMPIEZA		;5ddb
DESVANECE_TODO:		; tramo tras tramo hasta acabar la lista
	call TRAMO_COLOR		;5dde
	call PINTA_COLOR_TILE		;5de1
	call TRAMO_AVANZA		;5de4
	ret c			;5de7
	jr DESVANECE_TODO		;5de8
DESVANECE_TRES:		; tres pasos de desvanecido y vuelve
	ld b,003h		;5dea   ; tres tiles por fotograma: asi el dibujo tarda lo que tiene que tardar en aparecer
L_5DEC:
	push bc			;5dec
	call TRAMO_COLOR		;5ded   ; tres tiles por vuelta, y a la primera que devuelva acarreo se acabo la lista
	call PINTA_COLOR_TILE		;5df0
	call TRAMO_AVANZA		;5df3
	pop bc			;5df6
	ret c			;5df7
	djnz L_5DEC		;5df8
	or a			;5dfa
	ret			;5dfb
PINTA_COLOR_TILE:		; los ocho bytes de color del tile A a valor C, en los tres tercios
	ld l,a			;5dfc   ; el tile por ocho es su sitio en la tabla de colores, que empieza en 0
	ld a,c			;5dfd
	ld bc,00008h		;5dfe
	ld h,000h		;5e01
	add hl,hl			;5e03
	add hl,hl			;5e04
	add hl,hl			;5e05
	ld de,00000h		;5e06
	add hl,de			;5e09
	jp LLENA_VRAM_3_TERCIOS_B		;5e0a
TRAMO_COLOR:		; A = el tile por el que va (E25E) y C = el color del tramo
	call TRAMO_ACTUAL		;5e0d
	ld a,(0e25eh)		;5e10   ; E25E es el tile por el que va el desvanecido
	inc hl			;5e13
	ld c,(hl)			;5e14
	or a			;5e15
	ret			;5e16
TRAMO_AVANZA:		; un tile mas; al llegar al ultimo del tramo, pasa al siguiente
	call TRAMO_ACTUAL		;5e17
	ld a,(0e25eh)		;5e1a
	inc a			;5e1d
	ld (0e25eh),a		;5e1e
	cp (hl)			;5e21   ; el byte 0 del tramo es el tile en el que se acaba
	ccf			;5e22
	ret nc			;5e23
TRAMO_SIGUIENTE:		; E25D++ y el tile de arranque del tramo nuevo a E25E; acarreo cuando la lista se acaba
	ld hl,0e25dh		;5e24
	inc (hl)			;5e27
	call TRAMO_ACTUAL		;5e28
	ld a,(hl)			;5e2b   ; un byte 0 a cero cierra la lista
	or a			;5e2c
	scf			;5e2d
	ret z			;5e2e
	inc hl			;5e2f
	inc hl			;5e30
	ld a,(hl)			;5e31   ; y el byte 2 es por que tile empieza el tramo
	ld (0e25eh),a		;5e32
	or a			;5e35
	ret			;5e36
DESVANECIDO_EMPIEZA:		; E25D = 0xFF y el primer tramo (el `inc` de 0x5E27 lo deja en 0)
	ld a,0ffh		;5e37
	ld (0e25dh),a		;5e39
	jr TRAMO_SIGUIENTE		;5e3c
TRAMO_ACTUAL:		; HL = 0x5E4A + 3 * (E25D)
	ld a,(0e25dh)		;5e3e
	ld hl,05e4ah		;5e41
	ld b,a			;5e44
	add a,a			;5e45   ; por tres, que las filas son de tres bytes
	add a,b			;5e46
	jp HL_MAS_A		;5e47

; ----------------------------------------------------------------------
; DATOS secuencia_5E4A: filas de 3 bytes que recorre 0x5E3E con A = 3*(E25D)
;   (`ld hl,0x5E4A / jp HL_MAS_A`): el byte 0 a cero acaba la lista (0x5E2B),
;   el byte 1 lo lee 0x5E14 y el byte 2 va a (E25E) (0x5E31). Once filas y el
;   cero final
;   0x5e4a..0x5e6c  (34 bytes)
DATA_secuencia_5E4A:
	defb 0dfh,06fh,040h	; 5e4a
	defb 0dfh,04fh,09fh	; 5e4d
	defb 0efh,0afh,0dfh	; 5e50
	defb 0efh,0efh,0dfh	; 5e53
	defb 0efh,0afh,0dfh	; 5e56
	defb 0efh,0efh,0dfh	; 5e59
	defb 0efh,0afh,0dfh	; 5e5c
	defb 0efh,0efh,0dfh	; 5e5f
	defb 0efh,0afh,0dfh	; 5e62
	defb 0efh,0efh,0dfh	; 5e65
	defb 040h,05fh,010h	; 5e68
	defb 000h	; 5e6b

; ======================================================================
; CODIGO 0x5e6c..0x6000  (404 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Los carteles y los adornos del borde de la pista no van en el
; dibujo de las piezas: van en una lista aparte por circuito, que
; monta 0x5F5D -(E275) cuantos son y (E273) donde estan-. Cada
; entrada son TRES bytes: una palabra con la pieza en los 12 bits de
; arriba y la fila en los 4 de abajo, y un byte con el dibujo.
;
; Como la lista va ordenada por posicion, basta con un indice
; ((ix+57)) que avanza y no vuelve. Cuando la entrada coincide con
; la fila que se esta pintando, 0x5ECA le busca sitio; si el byte
; del dibujo trae el bit 7 no es un tile, y se guarda en la tabla de
; EB00 de esa fila (0x5F33) para que lo pinte otro.
; ----------------------------------------------------------------------
OBJETOS_DE_LA_FILA:		; los objetos de pista que caen en la fila que se acaba de pintar
	ld a,(ix+057h)		;5e6c   ; (ix+57) es por que objeto de la lista va este coche; por tres, que las entradas son de tres bytes
	ld l,a			;5e6f
	ld h,000h		;5e70
	ld e,l			;5e72
	ld d,h			;5e73
	add hl,hl			;5e74
	add hl,de			;5e75
	ld de,(0e273h)		;5e76
	add hl,de			;5e7a
OBJETO_SIGUIENTE:		; compara la entrada con la fila actual y la coloca, la salta o se para
	ld e,(hl)			;5e7b
	ld a,e			;5e7c
	inc hl			;5e7d
	ld d,(hl)			;5e7e
	srl d		;5e7f   ; cuatro corrimientos: la palabra trae la pieza arriba y la fila en el nibble de abajo
	rr e		;5e81
	srl d		;5e83
	rr e		;5e85
	srl d		;5e87
	rr e		;5e89
	srl d		;5e8b
	rr e		;5e8d
	and 00fh		;5e8f
	inc hl			;5e91
	push hl			;5e92
	ld h,(ix+045h)		;5e93   ; se compara con la pieza (ix+46,47) y la fila (ix+45) de este coche
	ld c,(ix+046h)		;5e96
	ld b,(ix+047h)		;5e99
	call COMPARA_PIEZA_Y_FILA		;5e9c
	pop hl			;5e9f
	jr c,L_5EAA		;5ea0   ; acarreo: la entrada ya ha quedado atras, se pasa a la siguiente
	jr nz,BORRA_FILA_EB00		;5ea2   ; distinta fila: no toca todavia, y solo se limpia la tabla de EB00
	call COLOCA_OBJETO		;5ea4
	jp OBJETO_A_LA_TABLA_EB00		;5ea7
L_5EAA:
	push hl			;5eaa
	call BORRA_FILA_EB00		;5eab
	pop hl			;5eae   ; el indice sube y el puntero tambien: la lista se recorre una sola vez por vuelta
	inc hl			;5eaf
	inc (ix+057h)		;5eb0
	ld b,(ix+057h)		;5eb3
	ld a,(0e275h)		;5eb6   ; y (E275) es cuantas entradas tiene la lista: al llegar al final el indice se queda ahi
	cp b			;5eb9
	jr nc,OBJETO_SIGUIENTE		;5eba
	ld (ix+057h),a		;5ebc
	ret			;5ebf
BORRA_FILA_EB00:		; las dos palabras de la fila en la tabla de EB00 a cero
	ld e,0c0h		;5ec0
	call FILA_TABLA_EB00		;5ec2   ; dos bytes por fila, que es lo que ocupa la entrada en la tabla
	xor a			;5ec5
	ld (hl),a			;5ec6
	inc hl			;5ec7
	ld (hl),a			;5ec8
	ret			;5ec9
COLOCA_OBJETO:		; le busca un hueco al objeto en la fila y lo pinta, dos tiles de alto
	ld e,0c0h		;5eca
	ld d,080h		;5ecc
	push hl			;5ece
	call CASILLA_BUFFER_NOMBRES		;5ecf
	pop de			;5ed2
	ld a,(de)			;5ed3   ; el tercer byte de la entrada es el dibujo; con el bit 7 puesto no es un tile y aqui no se pinta
	bit 7,a		;5ed4
	ret nz			;5ed6
	ld (ix-003h),a		;5ed7
	bit 0,(ix+009h)		;5eda   ; el jugador 1 usa los tiles 0xCE y 0xCF y el 2 el 0xD0 y el 0xD1
	ld c,0ceh		;5ede
	jr nz,L_5EE4		;5ee0
	ld c,0d0h		;5ee2
L_5EE4:
	ld a,l			;5ee4   ; se empieza por el principio de la fila
	and 0e0h		;5ee5
	ld l,a			;5ee7
	ld b,00ah		;5ee8   ; diez sitios, de tres en tres columnas: no se prueban las 32 casillas
	push de			;5eea
	ld a,(0e26dh)		;5eeb   ; E26D y E272 marcan el rango de tiles que se considera "sitio libre": el `sub` y el `cp` juntos preguntan si el tile esta dentro
	ld d,a			;5eee
	ld a,(0e272h)		;5eef
	sub d			;5ef2
	ld e,a			;5ef3
L_5EF4:
	ld a,(hl)			;5ef4
	sub d			;5ef5
	cp e			;5ef6
	jr nc,L_5F0E		;5ef7
	call HUECO_DE_CINCO		;5ef9   ; y ademas hacen falta cuatro casillas mas libres a la derecha (0x5F15), que ese es el hueco que pide el objeto
	jr c,L_5F0E		;5efc
	ld (hl),c			;5efe   ; el dibujo va en la casilla y el de debajo -el tile siguiente- en la fila de abajo, con la vuelta del kilobyte
	push hl			;5eff
	push de			;5f00
	res 2,h		;5f01
	ld de,00020h		;5f03
	add hl,de			;5f06
	set 2,h		;5f07
	inc c			;5f09
	ld (hl),c			;5f0a
	dec c			;5f0b
	pop de			;5f0c
	pop hl			;5f0d
L_5F0E:
	inc l			;5f0e
	inc l			;5f0f
	inc l			;5f10   ; de tres en tres columnas: se prueban diez sitios de la fila y no las 32
	djnz L_5EF4		;5f11
	pop de			;5f13
	ret			;5f14
HUECO_DE_CINCO:		; mira las cuatro casillas siguientes; sin acarreo si valen, y deja L en el centro del hueco
	push bc			;5f15
	ld b,004h		;5f16
L_5F18:
	inc l			;5f18   ; las cuatro de la derecha, una por vuelta
	ld a,(hl)			;5f19
	sub d			;5f1a
	cp e			;5f1b
	jr nc,L_5F25		;5f1c
	djnz L_5F18		;5f1e
L_5F20:
	dec l			;5f20   ; sale dos casillas por detras de la ultima mirada: el objeto se planta en el centro del hueco
	dec l			;5f21
	pop bc			;5f22
	or a			;5f23
	ret			;5f24
L_5F25:
	ld a,b			;5f25   ; si la que falla es LA CUARTA, el hueco se acepta igual: solo mandan de verdad las tres primeras
	dec a			;5f26
	jr z,L_5F20		;5f27
	ld a,005h		;5f29
	sub b			;5f2b
	ld b,a			;5f2c
L_5F2D:
	dec l			;5f2d   ; y si falla antes, L vuelve a donde estaba y se sigue buscando
	djnz L_5F2D		;5f2e
	pop bc			;5f30
	scf			;5f31
	ret			;5f32
OBJETO_A_LA_TABLA_EB00:		; el dibujo con el bit 7 no se pinta: se guarda en la tabla de EB00 de la fila
	ld a,(de)			;5f33
	bit 7,a		;5f34
	ret z			;5f36
	push de			;5f37
	ld e,0c0h		;5f38   ; la tabla de EB00 guarda un byte por fila, y ese byte lo lee quien pinta los objetos altos
	call FILA_TABLA_EB00		;5f3a
	pop de			;5f3d
	ld a,(de)			;5f3e
	ld (hl),a			;5f3f
	ret			;5f40
FILA_ABSOLUTA:		; HL = pieza * 12 + fila: la fila contada desde el principio de la vuelta
	ld l,(ix+046h)		;5f41   ; por doce, que cada pieza son doce filas de tiles
	ld h,(ix+047h)		;5f44
	ld a,(ix+045h)		;5f47
	add hl,hl			;5f4a   ; la pieza por cuatro, luego por ocho, y la suma de las dos es por doce
	add hl,hl			;5f4b
	ld c,l			;5f4c
	ld b,h			;5f4d
	add hl,hl			;5f4e
	add hl,bc			;5f4f
	ld c,a			;5f50
	ld b,000h		;5f51
	add hl,bc			;5f53
	ret			;5f54
COMPARA_PIEZA_Y_FILA:		; Z si la entrada es de esta pieza, y entonces compara la fila
	ex de,hl			;5f55
	or a			;5f56
	sbc hl,bc		;5f57   ; la resta de 16 bits es la de la pieza; la fila se compara despues, y solo si la pieza coincide
	ex de,hl			;5f59
	ret nz			;5f5a
	cp h			;5f5b
	ret			;5f5c
CARGA_LISTA_OBJETOS:		; la lista de objetos de la carrera: cuantos en (E275) y donde en (E273)
	ld hl,09b20h		;5f5d
	ld a,(0e25ch)		;5f60   ; una palabra por carrera: la lista de objetos es distinta en cada circuito
	call HL_PALABRA_A		;5f63
	ld a,(hl)			;5f66
	ld (0e275h),a		;5f67
	inc hl			;5f6a
	ld (0e273h),hl		;5f6b
	ret			;5f6e
MONTA_SELECCION:		; limpia la pantalla y monta la pantalla de eleccion
	call BORRA_SPRITES_Y_NOMBRES		;5f6f
	call TILES_16_58_F0		;5f72   ; los tiles 16, 58 y F0 son los del marco y las letras, que hacen falta en todas las pantallas
	call 06342h		;5f75
	call BORRA_BUFFER_E400		;5f78
	xor a			;5f7b
	ld (0e91fh),a		;5f7c
	ld (0e25eh),a		;5f7f   ; E25E a cero: el desvanecido empieza por el primer tile
	call DIBUJO_SELECCION		;5f82
	ld a,003h		;5f85
	call 06049h		;5f87
	jp ROTULOS_SELECCION		;5f8a
BORRA_BUFFER_E400:		; las 24 filas del buffer del jugador 1 a cero
	ld hl,0e400h		;5f8d
	ld bc,002ffh		;5f90
	jp RELLENA_RAM_CERO		;5f93
DIBUJO_SELECCION:		; el dibujo p05 0xA3B4 descomprimido en el buffer, 0x20 columnas
	ld a,005h		;5f96
	call MAPEA_A_EN_8000		;5f98
	ld de,0a3b4h		;5f9b
	call DESCOMPRIME_20_COLUMNAS		;5f9e
	jp MAPEA_1_2_3		;5fa1
ROTULOS_SELECCION:		; el cursor en EA88 y los rotulos p09 0xAB51 y 0xAB59
	ld a,(0e25bh)		;5fa4   ; con E25B = 0xFF -sin categoria elegida- se pone 1, y con categoria 2
	inc a			;5fa7
	ld a,001h		;5fa8
	ld hl,0bba7h		;5faa
	jr z,L_5FB0		;5fad
	inc a			;5faf
L_5FB0:
	ld (0e27fh),a		;5fb0
	dec a			;5fb3
	ld (0e27eh),a		;5fb4
	ld de,0ea88h		;5fb7
	ld bc,00004h		;5fba
	ldir		;5fbd   ; cuatro bytes: un atributo de sprite entero, el del cursor
	ld de,0ab51h		;5fbf   ; --> "(20)(10)GAME (2)(21)(10)COMMAND"
	call PINTA_ROTULO		;5fc2
	ld a,(0e25bh)		;5fc5   ; el segundo rotulo solo sale si ya hay categoria
	inc a			;5fc8
	ret z			;5fc9
	ld de,0ab59h		;5fca   ; --> "(19)(10)TRY AGAIN "
	jp PINTA_ROTULO		;5fcd
DESCOMPRIME_20_COLUMNAS:		; C' = 0x20 y a 0x637F
	exx			;5fd0
	ld c,020h		;5fd1
	exx			;5fd3
	jp 0637fh		;5fd4
SELECCION_PASO:		; un paso de la pantalla de eleccion
	call 0662ah		;5fd7
	call 062d3h		;5fda
	ld a,(0e251h)		;5fdd
	dec a			;5fe0
	jr z,$+118		;5fe1   ; esta rutina se sale de la pagina: el `jr` cae en 0x6057 y el `jp p` en 0x60F3, los dos ya en la pagina 1. Es legal porque p00 esta fija en 0x4000 y la 1 en 0x6000, pero el listado no puede seguir el salto
	jp p,060f3h		;5fe3
	ld a,(0e25bh)		;5fe6
	inc a			;5fe9
	ld hl,0bbc5h		;5fea   ; con categoria elegida el bloque es p03 0xBBC3 y sin ella el 0xBBC5
	jr z,L_5FF2		;5fed
	ld hl,0bbc3h		;5fef
L_5FF2:
	call 0626ch		;5ff2
	call 062ach		;5ff5   ; con Z se sale: la eleccion no ha cambiado
	ret z			;5ff8
	ld a,(0e25bh)		;5ff9
	inc a			;5ffc
	ld a,(0e27eh)		;5ffd
