; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ======================================================================
; CODIGO 0xa000..0xa068  (104 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Cola de p02 0x9FF7, que cruza la frontera de pagina (los seis ultimos
; bytes de la pagina 2 caen aqui). Entra con IX en un hueco libre, IY
; en el coche que manda y B = el tipo. Escoge la velocidad objetivo con
; el byte de pista que le toca -bit 7 del tipo puesto: (iy-0C); sin el:
; (iy-0D)- y la EXIGE contra la del jugador: con bit 7 el rival tiene
; que salir mas rapido, sin bit 7 mas lento. Si no cuadra, p02 0x9FE3
; suelta el hueco y devuelve CY.
; ----------------------------------------------------------------------
OBJETO_ARRANCA:		; cola de p02 0x9FF7: tipo, velocidad objetivo y el examen contra la del jugador
	ld (ix+000h),b		;a000   ; el tipo, que p02 0x9FF7 dejo en B con push af / pop bc
	push bc			;a003   ; B hace falta luego, y 0xA8C6 -donde acaba 0xA592- lo pisa con `ld b,a`
	bit 7,b		;a004   ; bit 7 del tipo: este rival tiene que ir mas rapido que el jugador
	ld a,(iy-00dh)		;a006   ; (iy-0D): el byte de pista de la primera sonda de 0xBA9F (0xBAD9)
	jr z,L_A01D		;a009
	ld a,(iy-00ch)		;a00b   ; (iy-0C): el de la segunda sonda (0xBB09)
	ld (ix+017h),a		;a00e   ; de este byte sale la velocidad objetivo
	call VELOCIDAD_OBJETIVO		;a011   ; 0xA592 deja en (ix+19,1A) la velocidad objetivo del rival
	call 09fe9h		;a014   ; p02 0x9FE9 compara la del jugador (iy+10,11) con ella: CY = el jugador es mas lento
	pop bc			;a017
	jp nc,09fe3h		;a018   ; el jugador NO es mas lento: el rival no sirve, se suelta el hueco
	jr L_A02A		;a01b   ; sirve: a colocarlo
L_A01D:
	ld (ix+017h),a		;a01d   ; sin bit 7 la velocidad sale del byte de la primera sonda
	call VELOCIDAD_OBJETIVO		;a020
	call 09fe9h		;a023
	pop bc			;a026
	jp c,09fe3h		;a027   ; el jugador es mas lento: tampoco sirve, se suelta el hueco
L_A02A:
	ld e,(ix+019h)		;a02a   ; la velocidad objetivo...
	ld d,(ix+01ah)		;a02d
	ld (ix+010h),e		;a030   ; ...pasa a ser tambien la de partida
	ld (ix+011h),d		;a033
OBJETO_ENTRA_EN_PISTA:		; dueno, x de entrada y los fotogramas que espera antes de aparecer
	call PON_DUENO_Y_ENTRADA		;a036   ; dueno, x de entrada y bit 2 de (ix+30), todo segun el bit 7 del tipo
	ld a,(0e244h)		;a039   ; E244 = 1 es "se ha pedido la repeticion" (p02 0x91F7)
	dec a			;a03c
	ld a,001h		;a03d   ; en repeticion el objeto entra al fotograma siguiente
	jr z,L_A043		;a03f
	ld a,019h		;a041   ; en carrera normal espera 0x19 = 25 fotogramas
L_A043:
	ld (ix+020h),a		;a043   ; (ix+20): lo que p02 0x9DB2 va descontando mientras el bit 5 este puesto

; ----------------------------------------------------------------------
; Da de alta el objeto: velocidad base, contadores, color y la rutina
; de su tipo. OJO, tiene DOS entradas: por 0xA046 se llega desde arriba
; y por 0xA049 entra p02 0x9FCC (el jr $+104 de 0x9FE1 -bytes 18 66-),
; que se salta el 0xA0EA: lo que crea 0x9FCC no lleva velocidad y se
; queda con la que le dejo 0xA3AB, cero (la explosion del coche, tipo
; 0x0F desde p02 0x8CA2, es uno de esos).
; ----------------------------------------------------------------------
OBJETO_ALTA:		; velocidad base, cuentas, color y la rutina del tipo
	call PON_VELOCIDAD_BASE		;a046   ; (ix+1B,1C) = velocidad base del tipo en esta categoria
	call SUBE_LAS_CUENTAS		;a049   ; aqui entra p02 0x9FCC (jr $+104 en 0x9FE1); 0xA54F sube E91C y el contador del jugador
	ld a,(0e1c2h)		;a04c   ; bit 5 de E1C2 = dos jugadores
	bit 5,a		;a04f
	jr nz,L_A057		;a051
	set 7,(ix+031h)		;a053   ; con un solo jugador, bit 7 de (ix+31) en todos los objetos
L_A057:
	ld a,(ix+000h)		;a057   ; el tipo, ya sin los bits de estado
	and 00fh		;a05a
	push af			;a05c
	call 09fbfh		;a05d   ; p02 0x9FBF: (ix+0F) = el color que E1F3 + tipo le da a ese tipo
	pop af			;a060
	dec a			;a061   ; la tabla empieza en el tipo 1, asi que el indice es tipo - 1
	cp 00fh		;a062
	ret nc			;a064   ; el tipo 0 (0xFF tras el dec) y cualquiera por encima de 15 se van sin rutina
	call 04abdh		;a065   ; p00 0x4ABD: salta a la palabra A de la tabla que sigue al call

; ----------------------------------------------------------------------
; DATOS tabla_A065: 15 palabras del despachador de 0xA065 (`call 0x4ABD`, la
;   variante que cambia la direccion de retorno por la palabra A de la tabla
;   que sigue al call); el indice es (ix+0) & 0x0F menos 1, acotado con `dec a
;   / cp 0x0F / ret nc`. Estaba trazada como codigo por error hasta el
;   2026-08-20. Las QUINCE palabras, leidas de la ROM: B986 B9B3 B9D8 BA02
;   BA2C BA53 BA96 B977 B977 B96F A086 A086 A086 A086 B598, o sea que los
;   tipos 11, 12, 13 y 14 apuntan al `ret` suelto de 0xA086 y no hacen nada, y
;   los tipos 7 y 8 comparten rutina. El tipo 0 ni llega: el `dec a` lo deja
;   en 0xFF y el `ret nc` se lo come
;   0xa068..0xa086  (30 bytes)
DATA_tabla_A065:
	defw 0b986h	; a068  -> AJUSTA_ATRAS_Y_MARCA
	defw 0b9b3h	; a06a  -> L_B9B3
	defw 0b9d8h	; a06c  -> L_B9D8
	defw 0ba02h	; a06e  -> L_BA02
	defw 0ba2ch	; a070  -> L_BA2C
	defw 0ba53h	; a072  -> L_BA53
	defw 0ba96h	; a074  -> L_BA96
	defw 0b977h	; a076  -> L_B977
	defw 0b977h	; a078  -> L_B977
	defw 0b96fh	; a07a  -> L_B96F
	defw 0a086h	; a07c  -> L_A086
	defw 0a086h	; a07e  -> L_A086
	defw 0a086h	; a080  -> L_A086
	defw 0a086h	; a082  -> L_A086
	defw 0b598h	; a084  -> L_B598

; ======================================================================
; CODIGO 0xa086..0xa0be  (56 bytes)
; ======================================================================


L_A086:
	ret			;a086   ; aqui apuntan las entradas 10 a 13 de la tabla: los tipos 11, 12, 13 y 14 no hacen nada
L_A087:
	jr L_A087		;a087   ; cuelgue (18 FE) detras del ret, como el de p01 0x7C3C; no lo alcanza nadie

; ----------------------------------------------------------------------
; Reparte los TURNOS entre los diez huecos: (ix+37) de cada uno con la
; tabla de su jugador. 0xA8A7 suma ese byte al contador de fotogramas
; E1C3 y solo trabaja cuando la suma es multiplo de 8, asi que el
; repaso de los objetos se reparte en un ciclo de ocho fotogramas.
; Lo llama p00 0x59C6, justo detras de borrar las dos listas.
; ----------------------------------------------------------------------
TURNOS_DE_LOS_OBJETOS:		; (ix+37) de los diez huecos: el fotograma de cada ocho en que le toca a cada uno
	ld ix,0e800h		;a089   ; los cinco huecos del jugador 1
	ld b,005h		;a08d   ; cinco, y 0x38 bytes de uno al siguiente
	ld de,00038h		;a08f
L_A092:
	ld a,005h		;a092   ; el indice va de 0 a 4 (B baja de 5 a 1)
	sub b			;a094
	ld hl,0a0beh		;a095
	call 040d0h		;a098   ; p00 0x40D0: HL += A
	ld a,(hl)			;a09b
	ld (ix+037h),a		;a09c   ; (ix+37) = el turno de este hueco
	add ix,de		;a09f
	djnz L_A092		;a0a1
	ld ix,0e928h		;a0a3   ; y ahora los cinco del jugador 2
	ld b,005h		;a0a7
	ld de,00038h		;a0a9
L_A0AC:
	ld a,005h		;a0ac
	sub b			;a0ae
	ld hl,0a0c3h		;a0af   ; con su propia tabla, la de 0xA0C3
	call 040d0h		;a0b2
	ld a,(hl)			;a0b5
	ld (ix+037h),a		;a0b6
	add ix,de		;a0b9
	djnz L_A0AC		;a0bb
	ret			;a0bd

; ----------------------------------------------------------------------
; DATOS tabla_A0BE: cinco bytes (00 01 02 03 00) que 0xA092 mete en (ix+37) de
;   las cinco estructuras de 0x38 bytes desde E800; el indice es 5-B (`ld a,5
;   / sub b / ld hl,0xA0BE / call HL_MAS_A / ld a,(hl)`). (ix+37) es el TURNO
;   del hueco: 0xA8A7 hace `ld a,(E1C3) / add a,(ix+37) / and 7 / ret nz`, o
;   sea que cada hueco solo repasa su curva y su aceleracion uno de cada ocho
;   fotogramas. Los cinco del jugador 1 usan los turnos 0, 1, 2, 3 y otra vez
;   0
;   0xa0be..0xa0c3  (5 bytes)
DATA_tabla_A0BE:
	defb 000h,001h,002h,003h,000h	; a0be

; ----------------------------------------------------------------------
; DATOS tabla_A0C3: los mismos cinco bytes (04 05 06 07 01) para las
;   estructuras desde E928; los lee igual 0xA0AC. Los turnos del jugador 2 son
;   4, 5, 6, 7 y otra vez 1: entre los diez huecos se reparten los ocho
;   fotogramas del ciclo, y solo el turno 0 y el 1 llevan dos huecos
;   0xa0c3..0xa0c8  (5 bytes)
DATA_tabla_A0C3:
	defb 004h,005h,006h,007h,001h	; a0c3

; ======================================================================
; CODIGO 0xa0c8..0xa3a4  (732 bytes)
; ======================================================================


VELOCIDAD_BASE_A_LOS_10:		; (ix+1B,1C) de los diez huecos de golpe; sin llamador conocido
	push ix		;a0c8   ; IX es del llamador
	ld ix,0e800h		;a0ca   ; los cinco del jugador 1
	ld b,005h		;a0ce
	call APLICA_A_LAS_5_ESTRUCTURAS		;a0d0
	ld ix,0e928h		;a0d3   ; y los cinco del 2
	ld b,005h		;a0d7
	call APLICA_A_LAS_5_ESTRUCTURAS		;a0d9
	pop ix		;a0dc
	ret			;a0de
APLICA_A_LAS_5_ESTRUCTURAS:		; `call 0xA0EA / ld de,0x38 / add ix,de / djnz`: repite 0xA0EA en B estructuras de 0x38 bytes seguidas desde IX
	call PON_VELOCIDAD_BASE		;a0df
	ld de,00038h		;a0e2   ; 0x38 bytes de un hueco al siguiente
	add ix,de		;a0e5
	djnz APLICA_A_LAS_5_ESTRUCTURAS		;a0e7
	ret			;a0e9
PON_VELOCIDAD_BASE:		; (ix+1B,1C) = la palabra de la tabla de la categoria
	call VELOCIDAD_DE_TABLA		;a0ea   ; la palabra que le corresponde por categoria, tipo y variante
	ld (ix+01bh),e		;a0ed   ; (ix+1B,1C) = velocidad base; 0xA8C6 y 0xA908 la convierten en la objetivo (ix+19,1A)
	ld (ix+01ch),d		;a0f0
	ret			;a0f3
VELOCIDAD_DE_TABLA:		; DE = tablas_A9FD de la categoria, entrada (tipo-1)*2 + (iy+56)
	ld a,(0e25bh)		;a0f4   ; la categoria elegida, 0 a 5
	ld hl,0a9fdh		;a0f7   ; tabla_A9FD: un puntero por categoria
	call 04a44h		;a0fa   ; p00 0x4A44: HL = la palabra A de la tabla HL
	ld a,(ix+000h)		;a0fd   ; el tipo del objeto
	and 00fh		;a100
	dec a			;a102   ; la tabla empieza en el tipo 1
	add a,a			;a103   ; dos palabras por tipo
	add a,(iy+056h)		;a104   ; (iy+56) escoge cual de las dos; lo pone p02 0x8149 desde la tabla de tramos de p15
	add a,a			;a107   ; y de palabras a bytes
	ld e,a			;a108
	ld d,000h		;a109
	add hl,de			;a10b
	ld e,(hl)			;a10c   ; DE = la velocidad base de ese tipo
	inc hl			;a10d
	ld d,(hl)			;a10e
	ret			;a10f

; ----------------------------------------------------------------------
; EL PASO DE LOS RIVALES, una vez por fotograma desde p00 0x5C4B, justo
; detras del paso de los objetos (p02 0x9D06). Con dos jugadores lo hace
; dos veces, primero para el coche 2 y luego para el 1, y antes mide lo
; que separa a los dos coches.
; ----------------------------------------------------------------------
PASO_DE_LOS_RIVALES:		; desde p00 0x5C4B: mete rivales nuevos y, con dos jugadores, espeja los objetos
	ld a,(0e1c2h)		;a110   ; bit 5 de E1C2: dos jugadores
	bit 5,a		;a113
	jr z,L_A143		;a115   ; con uno solo no hay nada que medir ni que espejar
	ld iy,0e380h		;a117   ; el coche 2
	call MIDE_SEPARACION		;a11b   ; E918/E919/E91A = lo que separa a los dos coches; E91B, cual va delante
	ld ix,0e928h		;a11e   ; los cinco huecos del jugador 2
	call PASO_RIVALES_DE_UN_COCHE		;a122
	ld iy,0e2c0h		;a125   ; y ahora el coche 1...
	ld ix,0e800h		;a129   ; ...con sus cinco huecos, cayendo en 0xA12D
PASO_RIVALES_DE_UN_COCHE:		; sonda de pista, espejo y, si toca, un rival nuevo
	call L_BA9F		;a12d   ; 0xBA9F sondea la pista por delante y deja los dos bytes en (iy-0D) y (iy-0C)
	call ESPEJO_ENTRE_JUGADORES		;a130   ; espejo de los objetos entre jugadores y cuentas atras de los huecos reservados
L_A133:
	ld a,(iy+055h)		;a133   ; (iy+55): la carrera ha arrancado; lo pone a 1 p01 0x7EC2 en el GO de la salida
	or a			;a136
	ret z			;a137   ; antes del GO no sale ningun rival
	call TOCA_RIVAL_NUEVO		;a138   ; A = el tipo del rival que ha entrado; CY = no ha entrado ninguno
	ret c			;a13b
	ld b,a			;a13c   ; B = el tipo, que 0xA212 mira por el bit 7
	call 08193h		;a13d   ; p02 0x8193: pasa a la entrada siguiente de la tabla de rivales y recarga (iy+61)
	jp OBJETO_ENTRA_EN_PISTA		;a140   ; y le da el alta
L_A143:
	ld iy,0e2c0h		;a143   ; con un solo jugador siempre manda el coche 1
	ld (iy+05ah),0e8h		;a147   ; (iy+5A) = 0xE8: con un jugador este coche no se pinta en ninguna otra vista
	call L_BA9F		;a14b
	jr L_A133		;a14e
TOCA_RIVAL_NUEVO:		; CY = no ha entrado ninguno; si entra, devuelve su tipo en A
	call 08059h		;a150   ; p02 0x8059 lleva la cadencia de los rivales; devuelve CY cuando toca sacar uno
	ccf			;a153   ; se le da la vuelta: de aqui en adelante CY = no hay nada que hacer
	ret c			;a154
	call CABE_OTRO_RIVAL		;a155   ; cabe otro?
	ret c			;a158
	call METE_RIVAL		;a159   ; monta el rival; si no ha podido, p02 0x9FE3 suelta el hueco y devuelve CY
	jp c,09fe3h		;a15c
	ret			;a15f
L_A160:
	pop hl			;a160   ; se come la vuelta a 0xA159 para devolver CY directamente a quien llamo a 0xA150
L_A161:
	scf			;a161   ; cola comun de "no ha entrado ningun rival"
	ret			;a162
CABE_OTRO_RIVAL:		; NC si cabe: filtro de velocidad minima y, si los coches van lejos, tope de tres por jugador
	call VELOCIDAD_MINIMA_CATEGORIA		;a163   ; el filtro de velocidad minima de la categoria
	ret c			;a166   ; el coche no llega al minimo: no cabe
	ld hl,(0e919h)		;a167   ; la parte alta de lo que separa a los dos coches; con un jugador vale 0
	ld a,h			;a16a
	or l			;a16b
	ret z			;a16c   ; si van a menos de 256 (o hay un solo jugador), cabe sin mirar la cuenta
	ld a,(iy+009h)		;a16d   ; el contador del jugador: E91D el 1, E91E el 2
	dec a			;a170
	ld hl,0e91dh		;a171
	jr z,L_A177		;a174
	inc l			;a176
L_A177:
	ld a,(hl)			;a177
	cp 003h		;a178   ; con tres o mas objetos suyos ya no cabe otro
	ccf			;a17a   ; se le da la vuelta: CY = no cabe
	ret			;a17b

; ----------------------------------------------------------------------
; OJO: la tabla que lee esta rutina es la de 0xA3A4, que hasta el
; 2026-08-20 figuraba en estas notas como "siete bytes de relleno sin
; lector". Lector tiene, y es este ld hl,0xA3A4. Lo que pasa es que
; los seis bytes valen cero, asi que la comparacion nunca corta.
; ----------------------------------------------------------------------
VELOCIDAD_MINIMA_CATEGORIA:		; CY si (iy+11) no llega al minimo de la categoria; tambien la llama p02 0x9DB2
	ld a,(0e25bh)		;a17c   ; la categoria, 0 a 5
	ld hl,0a3a4h		;a17f   ; la tabla de 0xA3A4, la que se daba por relleno
	call 040d0h		;a182
	ld h,(hl)			;a185   ; H = el minimo de esa categoria; en esta ROM los seis son cero
	ld a,(iy+011h)		;a186   ; la velocidad del coche, byte alto
	cp h			;a189   ; CY si no llega; con el minimo a cero eso no pasa nunca
	ret			;a18a

; ----------------------------------------------------------------------
; Mete un rival nuevo. Con un jugador basta con que haya hueco. Con
; dos, y solo si los coches estan a menos de 512, ademas se EXIGE que
; el rival salga del tipo que toca: 0x20 (mas lento que el jugador) o
; 0xA0 (mas rapido), segun de que jugador sea el coche y cual de los
; dos va delante (E91B). Si sale del otro, se abandona.
; ----------------------------------------------------------------------
METE_RIVAL:		; busca hueco y monta el rival; CY si no ha podido
	ld a,(0e1c2h)		;a18b   ; bit 5 de E1C2: dos jugadores
	bit 5,a		;a18e
	jr nz,L_A1DA		;a190   ; con dos hay que mirar tambien como quedaria en la otra vista
L_A192:
	push bc			;a192
	call CABE_Y_HUECO_LIBRE		;a193   ; 0xA412 busca hueco libre; NZ = no hay
	pop bc			;a196
	jr nz,L_A160		;a197   ; sin hueco, se sale con CY por 0xA160
L_A199:
	push hl			;a199   ; IX = el hueco
	pop ix		;a19a
	call LIMPIA_HUECO		;a19c   ; 0xA3AB pone a cero los 0x36 primeros bytes del hueco
	ld (ix+000h),c		;a19f   ; el tipo, tal como lo trae la entrada de rival de p15 (en C)
	ld (ix+036h),b		;a1a2   ; (ix+36) = el tercer byte de esa entrada (en B)
	call PON_VELOCIDAD_BASE		;a1a5   ; (ix+1B,1C) = velocidad base del tipo
	ld a,(iy-00dh)		;a1a8   ; se prueba primero con el byte de la primera sonda, (iy-0D)
	ld (ix+017h),a		;a1ab
	call VELOCIDAD_OBJETIVO		;a1ae   ; 0xA592 deja la velocidad objetivo en (ix+19,1A)
	call 09fe9h		;a1b1   ; y p02 0x9FE9 la compara con la del jugador
	ld a,020h		;a1b4   ; 0x20 = solo el bit 5: entra esperando
	jr nc,L_A1C8		;a1b6   ; el jugador va igual o mas rapido: vale, es un rival al que va a adelantar
	ld a,(iy-00ch)		;a1b8   ; no valia: segunda prueba, con el byte de la otra sonda, (iy-0C)
	ld (ix+017h),a		;a1bb
	call VELOCIDAD_OBJETIVO		;a1be
	call 09fe9h		;a1c1   ; y se vuelve a comparar
	ccf			;a1c4   ; si con esta el jugador tampoco es mas lento, se abandona con CY
	ret c			;a1c5
	ld a,0a0h		;a1c6   ; 0xA0 = bit 5 y bit 7: rival mas rapido que el jugador
L_A1C8:
	or c			;a1c8   ; el tipo con sus bits de estado
	ld (ix+000h),a		;a1c9
	ld e,(ix+019h)		;a1cc   ; la velocidad objetivo...
	ld d,(ix+01ah)		;a1cf
	ld (ix+010h),e		;a1d2   ; ...pasa a ser tambien la de partida
	ld (ix+011h),d		;a1d5
	or a			;a1d8   ; NC = rival montado, y A lleva su tipo
	ret			;a1d9
L_A1DA:
	ld de,00002h		;a1da   ; a menos de 512 los dos coches comparten lo que pasa por delante
	ld hl,(0e919h)		;a1dd
	or a			;a1e0
	sbc hl,de		;a1e1
	jr nc,L_A192		;a1e3   ; lejos: se monta sin exigirle nada al tipo
	ld a,(iy+009h)		;a1e5
	dec a			;a1e8
	ld de,020a0h		;a1e9   ; para el jugador 1: D = 0x20 (lento), E = 0xA0 (rapido)
	jr z,L_A1F1		;a1ec
	ld de,0a020h		;a1ee   ; y al reves para el 2
L_A1F1:
	ld a,(0e91bh)		;a1f1   ; con E91B = 1 se queda con E; con 2, con D
	dec a			;a1f4
	jr z,L_A1F8		;a1f5
	ld e,d			;a1f7
L_A1F8:
	push de			;a1f8   ; E = el tipo exigido; hay que guardarlo porque 0xA412 usa DE
	push bc			;a1f9
	call CABE_Y_HUECO_LIBRE		;a1fa
	pop bc			;a1fd
	pop de			;a1fe
	jp nz,L_A160		;a1ff   ; sin hueco, fuera con CY
	push bc			;a202
	push de			;a203
	call L_A199		;a204   ; se monta el rival como en el caso normal
	pop de			;a207
	pop bc			;a208
	ret c			;a209
	and 0f0h		;a20a   ; el nibble alto del tipo que ha salido
	cp e			;a20c   ; tiene que ser el exigido
	jp nz,L_A161		;a20d   ; no lo es: CY, y 0xA15C suelta el hueco con p02 0x9FE3
	or a			;a210   ; NC = rival montado
	ret			;a211
PON_DUENO_Y_ENTRADA:		; (ix+09) = el jugador de IY, y la x de entrada segun el bit 7 del tipo
	ld a,(iy+009h)		;a212   ; de que jugador es el coche que manda
	ld (ix+009h),a		;a215   ; el objeto queda a su nombre
	bit 7,b		;a218   ; bit 7 del tipo: el rival es mas rapido que el jugador
	jr nz,L_A225		;a21a
	ld (ix+004h),000h		;a21c   ; el lento entra por x = 0
	res 2,(ix+030h)		;a220   ; y con el bit 2 de (ix+30) quitado
	ret			;a224
L_A225:
	ld (ix+004h),0b7h		;a225   ; el rapido entra por x = 0xB7, justo debajo del 0xB8 con el que p02 0x9E31 los retira
	set 2,(ix+030h)		;a229   ; y con el bit 2 de (ix+30) puesto
	ret			;a22d

; ----------------------------------------------------------------------
; Lo que hay que hacer una vez por coche y fotograma: pasarle a cada
; coche el (iy+4B) del otro, decidir donde cae ESTE coche en la vista
; DEL OTRO, y descontar las cuentas atras de los cinco huecos.
; ----------------------------------------------------------------------
ESPEJO_ENTRE_JUGADORES:		; intercambia (+4B), calcula donde cae este coche en la vista del otro y descuenta los cinco huecos
	ld a,(0e30bh)		;a22e   ; (E30B) es el (iy+4B) del coche 1...
	ld (0e3dbh),a		;a231   ; ...y va al +5B del coche 2
	ld a,(0e3cbh)		;a234   ; (E3CB) es el (iy+4B) del coche 2...
	ld (0e31bh),a		;a237   ; ...y va al +5B del coche 1
	ld (iy+05ah),0e8h		;a23a   ; de partida, este coche no se ve en la vista del otro
	ld hl,(0e919h)		;a23e   ; la parte alta de lo que separa a los dos coches
	ld a,h			;a241
	or l			;a242
	call z,ESPEJA_LOS_5_OBJETOS		;a243   ; si caben en la misma vista (separacion menor de 256), se calcula donde
	exx			;a246   ; el bucle vive en los registros alternos porque 0xA257 usa BC y DE
	ld de,00038h		;a247
	ld b,005h		;a24a
L_A24C:
	exx			;a24c   ; los cinco huecos, uno por vuelta
	call CUENTA_ATRAS_DEL_HUECO		;a24d
	exx			;a250
	add ix,de		;a251   ; 0x38 bytes al siguiente
	djnz L_A24C		;a253
	exx			;a255
	ret			;a256
CUENTA_ATRAS_DEL_HUECO:		; huecos con el bit 4: descuenta (ix+1D,1E) y, al llegar a cero, saca el objeto de verdad
	bit 4,(ix+000h)		;a257   ; bit 4 = hueco reservado con cuenta atras; si no, no hay nada que hacer
	ret z			;a25b
	ld l,(ix+01dh)		;a25c   ; la cuenta atras que le puso p02 0x9F08
	ld h,(ix+01eh)		;a25f
	dec hl			;a262   ; un fotograma menos
	ld (ix+01dh),l		;a263
	ld (ix+01eh),h		;a266
	ld a,h			;a269
	or l			;a26a
	ret nz			;a26b   ; todavia no toca
	ld a,(ix+000h)		;a26c   ; el tipo sin el bit 4
	and 0efh		;a26f
	push af			;a271
	ld (ix+000h),000h		;a272   ; el hueco se suelta...
	ld hl,0e91ch		;a276   ; ...y las cuentas bajan: E91C el total
	dec (hl)			;a279
	ld a,(ix+009h)		;a27a   ; y E91D o E91E, segun de quien sea
	dec a			;a27d
	ld hl,0e91dh		;a27e
	jr z,L_A284		;a281
	inc l			;a283
L_A284:
	dec (hl)			;a284
	pop af			;a285
	call PUEDE_ENTRAR_ESTE		;a286   ; 0xA4C2 dice si el objeto puede entrar de verdad
	ret c			;a289   ; no puede: se queda sin salir
	set 5,a		;a28a   ; bit 5: entrara esperando
	exx			;a28c   ; el bucle de 0xA24C vive en los registros alternos
	push bc			;a28d
	push de			;a28e
	push ix		;a28f
	exx			;a291
	call 09ff7h		;a292   ; p02 0x9FF7 busca hueco y cae en 0xA000
	exx			;a295
	pop ix		;a296
	pop de			;a298
	pop bc			;a299
	exx			;a29a
	ret			;a29b
ESPEJA_LOS_5_OBJETOS:		; calcula el (iy+5A) de este coche y copia a la otra lista los cinco objetos
	call POSICION_EN_LA_OTRA_VISTA		;a29c   ; (iy+5A) = donde cae ESTE coche en la vista del otro
	ld a,(0e918h)		;a29f   ; lo que separa a los dos coches, byte bajo
	cp 0b8h		;a2a2   ; de 0xB8 en adelante ya no comparten vista: no hay nada que espejar
	ret nc			;a2a4
	push ix		;a2a5
	exx			;a2a7
	ld de,00038h		;a2a8
	ld b,005h		;a2ab   ; los cinco huecos
L_A2AD:
	exx			;a2ad   ; el juego alterno guarda el puntero mientras se hace la cuenta
	call ESPEJA_UN_OBJETO		;a2ae
	exx			;a2b1
	add ix,de		;a2b2
	djnz L_A2AD		;a2b4
	exx			;a2b6
	pop ix		;a2b7
	ret			;a2b9
ESPEJA_UN_OBJETO:		; copia el objeto a la lista del otro jugador con la x corregida por la separacion
	ld a,(ix+000h)		;a2ba   ; hueco libre: nada
	and a			;a2bd
	ret z			;a2be
	and 070h		;a2bf   ; con los bits 4, 5 o 6 puestos todavia no esta en pista
	ret nz			;a2c1
	ld a,(ix+023h)		;a2c2   ; (ix+23): esto ya es una copia, y una copia no se copia
	and a			;a2c5
	ret nz			;a2c6
	ld a,(iy+009h)		;a2c7   ; el jugador 1 corrige la x con el signo contrario
	dec a			;a2ca
	jp z,L_A2F4		;a2cb
	call HUECO_PARA_EL_ESPEJO		;a2ce   ; busca donde ponerlo en la lista del otro jugador
	ret nz			;a2d1   ; no hay sitio
	ld (ix+024h),e		;a2d2   ; (ix+24,25) = la pareja, en la lista del otro
	ld (ix+025h),d		;a2d5
	push ix		;a2d8
	pop hl			;a2da
	push bc			;a2db
	ld bc,00036h		;a2dc   ; 0x36 y no 0x38: la copia no se lleva ni (ix+36) ni el turno (ix+37)
	ldir		;a2df
	pop bc			;a2e1
	ld hl,0e918h		;a2e2   ; lo que separa a los dos coches
	ld a,(0e91bh)		;a2e5   ; E91B dice cual va delante
	dec a			;a2e8
	ld a,(ix+004h)		;a2e9   ; la x del objeto, byte alto
	jr z,L_A2F1		;a2ec
	add a,(hl)			;a2ee   ; en la otra vista cae en x + la separacion...
	jr L_A318		;a2ef
L_A2F1:
	sub (hl)			;a2f1   ; ...o en x - la separacion
	jr L_A318		;a2f2
L_A2F4:
	call HUECO_PARA_EL_ESPEJO		;a2f4   ; la misma copia para el jugador 1
	ret nz			;a2f7
	ld (ix+024h),e		;a2f8
	ld (ix+025h),d		;a2fb
	push ix		;a2fe
	pop hl			;a300
	push bc			;a301
	ld bc,00036h		;a302
	ldir		;a305
	pop bc			;a307
	ld hl,0e918h		;a308
	ld a,(0e91bh)		;a30b
	dec a			;a30e
	ld a,(ix+004h)		;a30f   ; la x del objeto, byte alto
	jr z,L_A317		;a312
	sub (hl)			;a314   ; aqui las dos ramas van al reves que en las del jugador 2
	jr L_A318		;a315
L_A317:
	add a,(hl)			;a317
L_A318:
	jr c,L_A31E		;a318   ; se ha salido del byte: no cabe en la otra vista
	cp 0b8h		;a31a   ; y de 0xB8 en adelante tampoco
	jr c,L_A334		;a31c
L_A31E:
	ld (ix+024h),000h		;a31e   ; no cabe: se deshace la pareja...
	ld (ix+025h),000h		;a322
	ld hl,(0ea60h)		;a326   ; ...y se borran los 0x38 bytes del hueco que se habia cogido
	ld e,l			;a329
	ld d,h			;a32a
	inc de			;a32b
	ld bc,00037h		;a32c
	ld (hl),000h		;a32f
	ldir		;a331
	ret			;a333
L_A334:
	push ix		;a334   ; HL = el objeto original
	pop hl			;a336
	ld ix,(0ea60h)		;a337   ; IX = la copia
	ld (ix+004h),a		;a33b   ; su x, ya corregida por la separacion
	ld (ix+023h),001h		;a33e   ; (ix+23) = 1: es una copia, y p02 0x9D2A no le da paso propio
	ld (ix+024h),l		;a342   ; y apunta de vuelta al original
	ld (ix+025h),h		;a345
	push hl			;a348   ; IX vuelve a ser el original
	pop ix		;a349
	ret			;a34b
HUECO_PARA_EL_ESPEJO:		; (EA60) = donde va la copia; (EA64) = 1 si reaprovecha la pareja de antes, 0 si el hueco es nuevo
	ld e,(ix+024h)		;a34c   ; la pareja que ya tenia, si tenia
	ld d,(ix+025h)		;a34f
	ld a,d			;a352
	or e			;a353
	ld a,001h		;a354   ; A = 1: se reaprovecha la de antes
	jr nz,L_A36B		;a356   ; ya tenia pareja: no hay que buscar
	ld a,(iy+009h)		;a358   ; el jugador 1 escribe en la lista del 2 (E928) y al reves
	dec a			;a35b
	ld hl,0e800h		;a35c
	jr nz,L_A364		;a35f
	ld hl,0e928h		;a361
L_A364:
	call HUECO_LIBRE_EN_HL		;a364   ; 0xA440 busca un hueco con el tipo a cero; NZ = no hay
	ret nz			;a367
	push hl			;a368
	pop de			;a369
	xor a			;a36a   ; A = 0: el hueco es nuevo
L_A36B:
	ld (0ea60h),de		;a36b   ; (EA60) = donde va la copia
	ld (0ea64h),a		;a36f   ; (EA64) = si la pareja es nueva o no
	xor a			;a372   ; se vuelve siempre con Z
	ret			;a373
POSICION_EN_LA_OTRA_VISTA:		; CORRIGE lo publicado: (iy+5A) NO es donde cae el otro coche en esta vista, es la coordenada vertical con la que ESTE coche se pinta en la vista DEL OTRO. Lo dice p01 0x6F47: con IX = 0xE380 (coche 2) e IY = 0xE2C0 (coche 1, de quien sale el (iy+4B) de la camara) se pinta con E = (ix+5A), o sea el +5A del coche 2 en la mitad del jugador 1; y 0x6F65 hace lo simetrico. Cuadra con los signos: sumar (E918) al propio +04 es justo pasar de una vista a la otra
	ld a,(iy+009h)		;a374   ; el jugador 1 suma donde el 2 resta
	dec a			;a377
	jr z,L_A38C		;a378
	ld hl,0e918h		;a37a   ; lo que separa a los dos coches, byte bajo
	ld a,(0e91bh)		;a37d   ; E91B: cual va delante
	dec a			;a380
	ld a,(iy+004h)		;a381   ; la x del coche, byte alto
	jr z,L_A389		;a384
	add a,(hl)			;a386   ; uno suma...
	jr L_A39C		;a387
L_A389:
	sub (hl)			;a389   ; ...y el otro resta
	jr L_A39C		;a38a
L_A38C:
	ld hl,0e918h		;a38c
	ld a,(0e91bh)		;a38f
	dec a			;a392
	ld a,(iy+004h)		;a393   ; la x del coche, byte alto (rama del jugador 1)
	jr z,L_A39B		;a396
	sub (hl)			;a398
	jr L_A39C		;a399
L_A39B:
	add a,(hl)			;a39b
L_A39C:
	ret c			;a39c   ; se ha salido del byte: se queda con el 0xE8 que puso 0xA23A
	cp 0c8h		;a39d   ; y de 0xC8 en adelante tampoco se pinta
	ret nc			;a39f
	ld (iy+05ah),a		;a3a0   ; (iy+5A) = la vertical con la que este coche se pinta en la vista del otro; lo lee p01 0x6F4B / 0x6F6D
	ret			;a3a3

; ----------------------------------------------------------------------
; DATOS velocidad_minima_categoria: seis bytes, uno por categoria (E25B): la
;   velocidad minima (byte alto de (iy+11)) que tiene que llevar el coche para
;   que entre un rival. La lee 0xA17C (`ld a,(E25B) / ld hl,0xA3A4 / call
;   HL_MAS_A / ld h,(hl) / ld a,(iy+11) / cp h`), y tambien p02 0x9DB2 al
;   llamar a 0xA17C. En esta ROM los seis valen CERO, o sea que el filtro
;   nunca corta. CORRIGE lo publicado el 2026-08-20, que los daba por relleno
;   sin lector
;   0xa3a4..0xa3aa  (6 bytes)
DATA_velocidad_minima_categoria:
	defb 000h,000h,000h,000h,000h,000h	; a3a4

; ----------------------------------------------------------------------
; DATOS relleno_A3AA: el septimo byte, a cero: 0xA17C solo llega hasta el
;   sexto (E25B va de 0 a 5) y ningun otro lo lee
;   0xa3aa..0xa3ab  (1 bytes)
DATA_relleno_A3AA:
	defb 000h	; a3aa

; ======================================================================
; CODIGO 0xa3ab..0xa65e  (691 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Borra un hueco recien cogido. OJO: el hueco lo trae HL, no IX; es el
; que acaban de devolver 0xA412 o 0xA433, y el llamador ya lo ha
; copiado a IX. Borra 0x36 bytes y no 0x38, igual que la copia espejo
; de 0xA2DC: (ix+36) y el turno (ix+37) se salvan. Lo llaman 0xA19C
; (rival nuevo), 0xA6E8 (parrilla) y p02 0x9FD9 (CREA_OBJETO_EN).
; ----------------------------------------------------------------------
LIMPIA_HUECO:		; (HL..HL+0x35) = 0, dejando (ix+36) y el turno (ix+37) como estaban
	push bc			;a3ab   ; BC lleva el tipo y el tercer byte de la entrada de rival: hay que devolverlo entero
	ld bc,00036h		;a3ac   ; 0x36, no 0x38
	call 04b87h		;a3af   ; p00 0x4B87 RELLENA_RAM_CERO
	pop bc			;a3b2
	ret			;a3b3

; ----------------------------------------------------------------------
; EL BORDE DERECHO DE LA CALZADA en la fila que marque E. Arranca en la
; COLUMNA 31 (por eso el ld d,0FFh: 0x4A9D se queda con D>>3) y va
; restando columnas hasta encontrar la primera casilla de clase 9 a 14;
; las 32 pruebas son exactamente el ancho de una fila, asi que nunca se
; mete en la de al lado. Luego RETROCEDE (EA7D) columnas HACIA DENTRO de
; la pista y devuelve el resultado en pixeles (x8) en D, listo para
; (ix+06). (EA7D) lo pone la rutina del tipo de rival justo antes de
; llamar: vale 1 en 0xB986, 4 en 0xB9B3 y 0xB9D8, 2 en 0xBA02, 5 en
; 0xBA2C y 1 en 0xBA53 y 0xBA96. O sea: pegate al borde y metete N
; casillas. El nombre "ATRAS" es solo el sentido del dec l.
; ----------------------------------------------------------------------
BUSCA_CASILLA_ATRAS:		; el BORDE DERECHO de la calzada en la fila que marca E: desde la columna 31 del buffer de nombres (p00 0x4A9D) baja con dec l las 32 columnas de la fila hasta dar con un tile de clase 9 a 14 -o sea con (tile - (E26C)) menor que (E272)-(E26C)-, se mete (EA7D) columnas hacia dentro y devuelve NC y D = esa columna por 8, en pixeles, lista para (ix+06). CY si la fila entera esta fuera de la calzada
	ld d,0ffh		;a3b4   ; D = 0xFF -> 0x4A9D lo convierte en la columna 31, el borde derecho de la pantalla
	call 04a9dh		;a3b6   ; HL = la casilla del buffer de nombres del jugador (0xE400 o 0xEC00 + fila*32 + columna)
	ld a,(0e26ch)		;a3b9   ; (E26C), el umbral entre la clase 8 y la 9; se queda en D
	ld d,a			;a3bc
	ld a,(0e272h)		;a3bd   ; E = (E272) - (E26C): el ancho de la ventana de clases 9 a 14
	sub d			;a3c0
	ld e,a			;a3c1
	ld b,010h		;a3c2   ; 16 vueltas y dos pruebas por vuelta = las 32 columnas de la fila
L_A3C4:
	ld a,(hl)			;a3c4   ; la casilla, y a la de la izquierda
	dec l			;a3c5
	sub d			;a3c6   ; resta-y-compara sin signo: si tile - (E26C) cae dentro de la ventana, es calzada
	cp e			;a3c7
	jr c,L_A3D4		;a3c8
	ld a,(hl)			;a3ca   ; la segunda prueba de la vuelta, identica
	dec l			;a3cb
	sub d			;a3cc
	cp e			;a3cd
	jr c,L_A3D4		;a3ce
	djnz L_A3C4		;a3d0
	scf			;a3d2   ; fila entera sin calzada: CY
	ret			;a3d3
L_A3D4:
	ld a,(0ea7dh)		;a3d4   ; (EA7D): cuantas columnas se mete hacia dentro desde el borde
	ld b,a			;a3d7
	ld a,l			;a3d8   ; L ya paso de largo, la casilla buena es L+1
	inc a			;a3d9
L_A3DA:
	dec a			;a3da   ; restar B veces es restar (EA7D) columnas, o sea meterse hacia la izquierda
	djnz L_A3DA		;a3db
	add a,a			;a3dd   ; de columnas a pixeles: x8
	add a,a			;a3de
	add a,a			;a3df
	ld d,a			;a3e0   ; D = la x que va a (ix+06); NC = encontrada
	or a			;a3e1
	ret			;a3e2

; ----------------------------------------------------------------------
; El BORDE IZQUIERDO, la gemela exacta de 0xA3B4: arranca en la columna
; 0 (ld d,0), avanza con inc l y, cuando encuentra la calzada, SUMA
; las (EA7D) columnas en vez de restarlas. Las dos se meten hacia
; dentro de la pista, cada una desde su lado.
; ----------------------------------------------------------------------
BUSCA_CASILLA_ADELANTE:		; el BORDE IZQUIERDO, la gemela de 0xA3B4: empieza en la columna 0, sube con inc l y SUMA las (EA7D) columnas en vez de restarlas, o sea que tambien se mete hacia dentro de la pista
	ld d,000h		;a3e3   ; D = 0 -> columna 0, el borde izquierdo
	call 04a9dh		;a3e5   ; misma casilla de partida que la gemela, solo cambia por donde empieza
	ld a,(0e26ch)		;a3e8
	ld d,a			;a3eb
	ld a,(0e272h)		;a3ec
	sub d			;a3ef
	ld e,a			;a3f0
	ld b,010h		;a3f1
L_A3F3:
	ld a,(hl)			;a3f3   ; la casilla, y a la de la derecha
	inc l			;a3f4
	sub d			;a3f5
	cp e			;a3f6
	jr c,L_A403		;a3f7
	ld a,(hl)			;a3f9
	inc l			;a3fa
	sub d			;a3fb
	cp e			;a3fc
	jr c,L_A403		;a3fd
	djnz L_A3F3		;a3ff
	scf			;a401   ; fila entera sin calzada: CY
	ret			;a402
L_A403:
	ld a,(0ea7dh)		;a403   ; aqui se SUMA (EA7D): hacia dentro es hacia la derecha
	ld b,a			;a406
	ld a,l			;a407   ; L ya paso de largo, la casilla buena es L-1
	dec a			;a408
L_A409:
	inc a			;a409
	djnz L_A409		;a40a
	add a,a			;a40c
	add a,a			;a40d
	add a,a			;a40e
	ld d,a			;a40f   ; D = la x que va a (ix+06); NC = encontrada
	or a			;a410
	ret			;a411

; ----------------------------------------------------------------------
; CABE UN OBJETO MAS? Dos topes: uno global -2 objetos en RALLY
; (categoria 0) y 4 en las otras cinco- y otro por coche, el (iy-13)
; que p02 0x813D saca de la tabla de tramos de p15 y 0x80A7 retoca;
; p02 0x8029 lo arranca a 5. Si cabe, 0xA433 devuelve el hueco.
; La llaman 0xA193, 0xA1FA y p02 0x9FF8.
; ----------------------------------------------------------------------
CABE_Y_HUECO_LIBRE:		; topes global y por coche, y si pasan, HL = un hueco libre (Z), o A = 0xFF (NZ)
	ld a,(0e25bh)		;a412   ; la categoria elegida, 0 a 5
	and a			;a415
	ld b,004h		;a416   ; tope general de objetos en pista: 4...
	jr nz,L_A41C		;a418
	ld b,002h		;a41a   ; ...salvo en RALLY, que son 2
L_A41C:
	ld a,(0e91ch)		;a41c   ; E91C: cuantos objetos hay entre los dos jugadores
	cp b			;a41f
	jr nc,L_A44B		;a420   ; lleno: no cabe
	ld a,(0e91dh)		;a422   ; E91D: los del jugador 1
	bit 0,(iy+009h)		;a425   ; (iy+09) es 1 o 2, asi que el bit 0 basta para distinguirlos
	jr nz,L_A42E		;a429
	ld a,(0e91eh)		;a42b   ; E91E: los del jugador 2
L_A42E:
	cp (iy-013h)		;a42e   ; (iy-13) es el tope de ese coche en el tramo de pista que se este corriendo
	jr nc,L_A44B		;a431
HUECO_DE_ESTE_COCHE:		; HL = la lista del coche de IY y sigue en 0xA440; la llama p02 0x9FCE
	ld a,(iy+009h)		;a433   ; de que jugador es el coche que manda
	cp 001h		;a436
	ld hl,0e800h		;a438   ; sus cinco huecos: E800 el jugador 1...
	jr z,HUECO_LIBRE_EN_HL		;a43b
	ld hl,0e928h		;a43d   ; ...y E928 el 2
HUECO_LIBRE_EN_HL:		; recorre cinco estructuras de 0x38 desde HL y para en la primera con el tipo a cero
	ld b,005h		;a440   ; los cinco huecos
	ld de,00038h		;a442   ; 0x38 bytes de uno al siguiente
	xor a			;a445   ; hueco libre es (hl) = 0
L_A446:
	cp (hl)			;a446
	ret z			;a447   ; Z y HL = el hueco
	add hl,de			;a448
	djnz L_A446		;a449
L_A44B:
	or 0ffh		;a44b   ; ninguno libre: A = 0xFF y NZ
	ret			;a44d

; ----------------------------------------------------------------------
; LO QUE SEPARA A LOS DOS COCHES. La medida de cada coche son tres
; bytes: (+41,+42) cuenta cuantas veces se ha dado la vuelta la
; fraccion (+3F,+40) -que p00 0x55CB va RESTANDO segun la velocidad-,
; asi que el avance de verdad es (+41,+42)*256 MENOS (+40). Por eso
; 0xA46D resta el byte bajo al reves que los altos: no es un error, es
; que ese byte cuenta hacia atras. 0xA44E lo resta en un sentido y, si
; sale negativo, en el otro, de modo que E918/E919/E91A queda siempre
; positivo y E91B dice cual de los dos coches va delante. Solo la
; llaman 0xA11B y 0xA76B, las dos con dos jugadores.
; ----------------------------------------------------------------------
MIDE_SEPARACION:		; E918/E919/E91A = lo que separa a los dos coches (siempre positivo) y E91B = cual va delante
	ld de,(0e3c1h)		;a44e   ; DE = (+41,+42) del coche 2
	ld a,(0e3c0h)		;a452   ; C = su (+40), el byte que cuenta hacia atras
	ld c,a			;a455
	ld hl,(0e301h)		;a456   ; HL = (+41,+42) del coche 1
	ld a,(0e300h)		;a459   ; B = su (+40)
	ld b,a			;a45c
	call RESTA_AVANCES_1_2		;a45d   ; coche 1 menos coche 2
	ld a,002h		;a460   ; sin acarreo: se queda con esa resta
	jr nc,L_A469		;a462
	call RESTA_AVANCES_2_1		;a464   ; salio negativa: se rehace al reves para que la separacion sea positiva
	ld a,001h		;a467
L_A469:
	ld (0e91bh),a		;a469   ; E91B = el numero del coche que va delante
	ret			;a46c
RESTA_AVANCES_1_2:		; E918/E919/E91A = avance del coche 1 - avance del coche 2; CY si sale negativo
	push bc			;a46d   ; 0xA44E necesita los seis bytes intactos por si hay que repetir al reves
	push de			;a46e
	push hl			;a46f
	ld a,c			;a470   ; el byte bajo del coche 2
	and a			;a471
	jr nz,L_A475		;a472
	inc e			;a474   ; neg de cero NO pone acarreo: se compensa a mano el prestamo que falta
L_A475:
	neg		;a475   ; el byte bajo va con el signo cambiado porque cuenta hacia atras
	ld c,a			;a477
	ld a,b			;a478   ; lo mismo con el byte bajo del coche 1
	and a			;a479
	jr nz,L_A47D		;a47a
	inc l			;a47c
L_A47D:
	neg		;a47d
	sub c			;a47f   ; -c1 - (-c2) = c2 - c1, que es lo que avanza el coche 1 sobre el 2
	ld (0e918h),a		;a480   ; E918: la parte que cabe en una pantalla
	ld a,l			;a483
	sbc a,e			;a484   ; y de aqui arriba, la resta normal coche 1 - coche 2
	ld (0e919h),a		;a485
	ld a,h			;a488
	sbc a,d			;a489
	ld (0e91ah),a		;a48a   ; E91A: si E919/E91A no son cero, los coches no comparten vista
	pop hl			;a48d
	pop de			;a48e
	pop bc			;a48f
	ret			;a490
RESTA_AVANCES_2_1:		; la gemela de 0xA46D con los dos coches cambiados de sitio
	push bc			;a491   ; misma cuenta, del coche 2 sobre el 1
	push de			;a492
	push hl			;a493
	ld a,b			;a494
	and a			;a495
	jr nz,L_A499		;a496
	inc l			;a498   ; la misma compensacion del neg de cero, ahora en el otro orden
L_A499:
	neg		;a499   ; el contador de la cadencia baja hasta cero y ahi se queda
	ld b,a			;a49b
	ld a,c			;a49c
	and a			;a49d
	jr nz,L_A4A1		;a49e
	inc e			;a4a0
L_A4A1:
	neg		;a4a1
	sub b			;a4a3   ; -c2 - (-c1) = c1 - c2
	ld (0e918h),a		;a4a4
	ld a,e			;a4a7
	sbc a,l			;a4a8
	ld (0e919h),a		;a4a9
	ld a,d			;a4ac
	sbc a,h			;a4ad
	ld (0e91ah),a		;a4ae   ; E91A del reves; 0xA44E llega aqui cuando 0xA46D le dio negativo
	pop hl			;a4b1
	pop de			;a4b2
	pop bc			;a4b3
	ret			;a4b4

; ----------------------------------------------------------------------
; Sin llamador: los dos bytes de esta direccion no aparecen en ninguna
; parte de los 128 KB de la ROM, y por eso esta declarada a mano en
; p03.entries. Es un contador de dos escalones: sube (HL) y, cuando
; llega a C, lo pone a cero y sube (HL+3).
; ----------------------------------------------------------------------
CUENTA_Y_ACARREA:		; (HL)++ y, al llegar a C, (HL) = 0 y (HL+3)++; nadie la llama
	inc (hl)			;a4b5   ; un paso mas
	ld a,(hl)			;a4b6
	cp c			;a4b7   ; C es el tope
	ret nz			;a4b8   ; sin llegar al tope no hay nada mas que hacer
	xor a			;a4b9
	ld (hl),a			;a4ba
	push hl			;a4bb
	inc hl			;a4bc
	inc hl			;a4bd
	inc hl			;a4be
	inc (hl)			;a4bf   ; tres bytes mas alla vive el escalon de arriba
	pop hl			;a4c0
	ret			;a4c1

; ----------------------------------------------------------------------
; QUIEN PUEDE ENTRAR AHORA MISMO. Con un jugador, cualquiera. Con dos,
; mientras los coches esten lejos (E919/E91A distintos de cero, o mas
; de 0xB8 de separacion) tambien. Pero si comparten vista, el coche que
; va DELANTE solo admite rivales mas rapidos (bit 7 del tipo puesto) y
; el que va DETRAS solo mas lentos: si no, el rival apareceria dentro
; de la pantalla del otro. Es la misma regla que 0xA1E9-0xA1F8 aplica
; al crearlos; aqui se vuelve a mirar cuando el objeto ya estaba
; esperando (0xA286, cuando vence la cuenta atras, y p02 0x9DC3,
; cuando vence el (ix+20)).
; ----------------------------------------------------------------------
PUEDE_ENTRAR_ESTE:		; CY si el tipo que trae A no encaja con quien va delante; A vuelve intacto
	ld b,a			;a4c2   ; el tipo se guarda en B porque A hace falta para leer variables
	ld a,(0e1c2h)		;a4c3   ; bit 5 de E1C2: dos jugadores
	bit 5,a		;a4c6
	ld a,b			;a4c8
	jr z,L_A4EB		;a4c9   ; con uno solo entra siempre
	ld hl,(0e919h)		;a4cb   ; la parte alta de la separacion
	ld a,h			;a4ce
	or l			;a4cf
	ld a,b			;a4d0
	ret nz			;a4d1   ; a mas de 255 no comparten vista: entra
	ld a,(0e918h)		;a4d2   ; y de 0xB8 en adelante tampoco caben los dos en la misma pantalla
	cp 0b8h		;a4d5
	ld a,b			;a4d7
	ret nc			;a4d8
	ld a,(iy+009h)		;a4d9   ; de que jugador es el coche
	dec a			;a4dc
	jr z,L_A4F4		;a4dd
	ld a,(0e91bh)		;a4df   ; E91B = 2 quiere decir que el que va delante es este mismo coche, el 2...
	dec a			;a4e2
	ld a,b			;a4e3
	jr z,L_A4ED		;a4e4
	bit 7,b		;a4e6   ; ...y el de delante solo admite rivales mas rapidos
	jp z,L_A161		;a4e8
L_A4EB:
	or a			;a4eb   ; NC = puede entrar
	ret			;a4ec
L_A4ED:
	bit 7,b		;a4ed   ; el jugador 2 con el coche 1 delante: yendo detras, solo mas lentos
	jp nz,L_A161		;a4ef
	or a			;a4f2
	ret			;a4f3
L_A4F4:
	ld a,(0e91bh)		;a4f4   ; el jugador 1: E91B = 1 es "voy yo delante"
	dec a			;a4f7
	ld a,b			;a4f8
	jr z,L_A502		;a4f9
	bit 7,b		;a4fb   ; con el 2 delante, solo mas lentos
	jp nz,L_A161		;a4fd
	or a			;a500
	ret			;a501
L_A502:
	bit 7,b		;a502   ; yendo delante, solo mas rapidos
	jp z,L_A161		;a504
	or a			;a507
	ret			;a508

; ----------------------------------------------------------------------
; LAS DOS CUENTAS DEL COCHE: cuantos rivales se le ven por DELANTE y
; cuantos por DETRAS. Viven en los bits 3, 4 y 5 de (coche+30) y de
; (coche+5E) -los otros bits de esos dos bytes son banderas-, y por eso
; se suma y se resta de 8 en 8. El tope de arriba lo pone el bit 6
; (0x38 = siete rivales) y el de abajo el bit 7 (cero). Quien las lee
; es 0xAE22 (ld a,(ix+5E) / rra rra rra / and 7) para decidir la
; posicion, y 0xB1DC/0xB1E4 las borra con and 0C7h. HL entra siendo
; el coche.
; ----------------------------------------------------------------------
MAS_UNO_DELANTE:		; (HL+0x30) += 8 hasta 0x38: un rival mas por delante
	ld a,030h		;a509   ; +0x30 es la cuenta de los de delante
	call 040d0h		;a50b   ; p00 0x40D0: HL += A
	jr SUMA_8_CON_TOPE		;a50e
MENOS_UNO_DELANTE:		; (HL+0x30) -= 8 hasta 0
	ld a,030h		;a510   ; el mismo byte, para bajar la cuenta
	call 040d0h		;a512
	jr RESTA_8_CON_SUELO		;a515
MAS_UNO_DETRAS:		; (HL+0x5E) += 8 hasta 0x38: un rival mas por detras
	ld a,05eh		;a517   ; +0x5E es la cuenta de los de detras
	call 040d0h		;a519
SUMA_8_CON_TOPE:		; (HL) += 8 y solo se guarda si no se pasa de 0x38
	ld a,(hl)			;a51c   ; el byte de la cuenta, con sus banderas en los bits 0 a 2
	add a,008h		;a51d   ; un rival mas
	bit 6,a		;a51f   ; 0x38 + 8 = 0x40 enciende el bit 6: se ha pasado, no se guarda
	ret nz			;a521
	ld (hl),a			;a522
	ret			;a523
MENOS_UNO_DETRAS:		; (HL+0x5E) -= 8 hasta 0
	ld a,05eh		;a524   ; la cuenta de los de detras, para bajarla
	call 040d0h		;a526
RESTA_8_CON_SUELO:		; (HL) -= 8 y solo se guarda si no baja de cero
	ld a,(hl)			;a529   ; la cuenta con sus banderas
	sub 008h		;a52a   ; un rival menos
	bit 7,a		;a52c   ; por debajo de cero se enciende el bit 7: no se guarda
	ret nz			;a52e
	ld (hl),a			;a52f
	ret			;a530

; ----------------------------------------------------------------------
; Cuando p02 0x9E35 QUITA_OBJETO retira un objeto, esta rutina baja la
; cuenta que toque. Llega con A = (EA67), que vale 1 si el objeto se
; habia salido por ARRIBA (su +04 pasaba de 0xE0) y 0 si se salio por
; abajo, y con B = el tipo por dos (p02 0x9E55 hizo add a,a); el
; rra de 0xA533 lo devuelve entero porque el acarreo trae el bit 7.
; No cuentan ni el tipo 15 ni los tipos 8 y 9, y solo se toca la cuenta
; si (ix+30) tiene el bit 7 puesto y el 6 quitado, que es la marca que
; pone 0xA5F1 y que 0xAEC3 borra cuando el adelantamiento ya se ha
; apuntado. IY es el coche.
; ----------------------------------------------------------------------
BAJA_LA_CUENTA:		; al retirar un objeto, resta 8 a la cuenta de delante o a la de detras
	ld c,a			;a531   ; C = (EA67): 1 si se salio por arriba, 0 si por abajo
	ld a,b			;a532   ; B = el tipo por dos...
	rra			;a533   ; ...y el acarreo del add a,a de p02 0x9E55 devuelve el bit 7: A vuelve a ser el tipo
	and 00fh		;a534
	cp 00fh		;a536   ; el tipo 15 (la explosion) no cuenta
	ret z			;a538
	sub 008h		;a539   ; los tipos 8 y 9 tampoco (son los que p02 0x9E40 manda a p01 0x7FFC)
	cp 002h		;a53b
	ret c			;a53d
	ld a,(ix+030h)		;a53e   ; bit 7 puesto y bit 6 quitado: este objeto todavia estaba contado
	and 0c0h		;a541
	cp 080h		;a543
	ret nz			;a545
	ld a,c			;a546   ; (EA67) otra vez
	push iy		;a547   ; las dos rutinas de abajo esperan el coche en HL
	pop hl			;a549
	dec a			;a54a   ; se salio por abajo: baja la cuenta de los de detras
	jr nz,MENOS_UNO_DETRAS		;a54b
	jr MENOS_UNO_DELANTE		;a54d   ; se salio por arriba: baja la de los de delante
SUBE_LAS_CUENTAS:		; E91C++ y E91D o E91E, segun de quien sea el objeto; desde OBJETO_ALTA
	push hl			;a54f   ; HL es del llamador
	ld hl,0e91ch		;a550   ; E91C: el total de objetos
	inc (hl)			;a553
	ld a,(iy+009h)		;a554   ; de que jugador es
	dec a			;a557
	ld hl,0e91dh		;a558   ; E91D el jugador 1...
	jr z,L_A55E		;a55b
	inc l			;a55d   ; ...y E91E el 2
L_A55E:
	inc (hl)			;a55e
	pop hl			;a55f
	ret			;a560

; ----------------------------------------------------------------------
; Coloca al rival pegado a un borde de la calzada. (iy+66) es el
; interruptor: a cero el rival no busca borde y se queda con la x que
; ya tenia. Las llaman las rutinas de tipo de 0xB986 a 0xBA96, cada
; una tras dejar en (EA7D) cuantas casillas quiere meterse.
; ----------------------------------------------------------------------
AJUSTA_CON_CASILLA_ATRAS:		; pega el rival al borde DERECHO de la calzada: si (iy+66) no es cero, E = (ix+4) -su fila-, BUSCA_CASILLA_ATRAS, (ix+6) = D y 0xB8FF; si es cero, (ix+15) = (ix+6) y (ix+0E) = 0xFF
	ld a,(iy+066h)		;a561   ; (iy+66): si es cero, este rival no busca borde
	and a			;a564
	jr z,SIN_BUSCAR_BORDE		;a565
	ld e,(ix+004h)		;a567   ; E = la fila, que es la coordenada vertical del rival
	call BUSCA_CASILLA_ATRAS		;a56a   ; el borde derecho de la calzada en esa fila
	ld (ix+006h),d		;a56d   ; (ix+06) = la x que ha salido
	call PON_IX15_CASILLA_ATRAS		;a570   ; y 0xB8FF vuelve a buscar, con E = 0xC8, para dejar (ix+15)
	ret			;a573
AJUSTA_CON_CASILLA_ADELANTE:		; la gemela de 0xA561 por el borde IZQUIERDO, con BUSCA_CASILLA_ADELANTE y 0xB90B
	ld a,(iy+066h)		;a574   ; misma cuenta por el lado izquierdo
	and a			;a577
	jr z,SIN_BUSCAR_BORDE		;a578
	ld e,(ix+004h)		;a57a
	call BUSCA_CASILLA_ADELANTE		;a57d   ; el borde izquierdo
	ld (ix+006h),d		;a580
	call PON_IX15_CASILLA_ADELANTE		;a583   ; y 0xB90B para el (ix+15)
	ret			;a586
SIN_BUSCAR_BORDE:		; cola de las dos: (ix+15) = (ix+06) y (ix+0E) = 0xFF
	ld a,(ix+006h)		;a587   ; sin buscar borde, el objetivo es donde ya esta
	ld (ix+015h),a		;a58a
	ld (ix+00eh),0ffh		;a58d   ; 0xFF en (ix+0E) es "sin objetivo"
	ret			;a591

; ----------------------------------------------------------------------
; La velocidad OBJETIVO del rival sale del byte de pista con el que
; entro, (ix+17): si es cero -recta- se coge tal cual la velocidad base
; del tipo; si no es cero es una curva, se marca el bit 4 de (ix+01) y
; 0xA8C6 le aplica la frenada de la tabla 0xA955.
; ----------------------------------------------------------------------
VELOCIDAD_OBJETIVO:		; (ix+19,1A) segun el byte de pista (ix+17): recta o frenada de curva
	ld a,(ix+017h)		;a592   ; el byte de pista con el que entro el rival
	and a			;a595
	jr z,L_A5A2		;a596   ; a cero es recta
	set 4,(ix+001h)		;a598   ; bit 4 de (ix+01): viene con curva por delante
	ld (ix+032h),a		;a59c   ; (ix+32) = el byte de pista guardado, que es lo que mira 0xA8C6
	jp L_A8C6		;a59f   ; 0xA8C6 resta la frenada de curva a la velocidad base
L_A5A2:
	ld (ix+032h),a		;a5a2   ; recta: (ix+32) = 0
	call VELOCIDAD_DE_TABLA		;a5a5   ; la velocidad base del tipo en esta categoria
	ld (ix+019h),e		;a5a8   ; y esa misma es la objetivo
	ld (ix+01ah),d		;a5ab
	ret			;a5ae
RESTA_24_BITS:		; B:HL -= C:DE, con B y C los bytes bajos; solo la llama p00 0x52BB
	ld a,b			;a5af   ; los bytes bajos
	sub c			;a5b0
	ld b,a			;a5b1
	ld a,l			;a5b2   ; los medios, con el prestamo
	sbc a,e			;a5b3
	ld l,a			;a5b4
	ld a,h			;a5b5   ; y los altos
	sbc a,d			;a5b6
	ld h,a			;a5b7
	ret			;a5b8

; ----------------------------------------------------------------------
; LA PARRILLA DE SALIDA, desde p00 0x5A13 (medido en el emulador).
; 0xA673 reparte las seis plazas -el jugador 1 sale tercero y el 2
; cuarto- y crea de rival todo lo que no sea un coche de jugador.
; Luego, para cada coche, se mira uno por uno a sus cinco rivales: el
; que este por delante (su +04 mas arriba en la pantalla) se marca como
; mas rapido y suma a la cuenta de delante, y el que este por detras
; suma a la de detras. Al final 0xA649 convierte la plaza de la
; parrilla en la posicion de verdad dentro del peloton.
; ----------------------------------------------------------------------
MONTA_LA_PARRILLA:		; parrilla de salida, quien va delante de quien y la posicion de partida de cada coche
	call L_A673		;a5b9   ; 0xA673 coloca los seis coches de la parrilla
	ld a,(0e1c2h)		;a5bc   ; bit 5 de E1C2: dos jugadores
	bit 5,a		;a5bf
	call nz,QUIEN_VA_DELANTE		;a5c1   ; con dos, apunta cual de los dos va delante del otro
	ld ix,0e2c0h		;a5c4   ; el coche 1 y sus cinco huecos
	ld iy,0e800h		;a5c8
	call REPASA_LOS_5_DE_SALIDA		;a5cc
	ld a,(0e1c2h)		;a5cf   ; con un solo jugador ya esta
	bit 5,a		;a5d2
	ret z			;a5d4
	ld ix,0e380h		;a5d5   ; el coche 2 y los suyos, cayendo en 0xA5DD
	ld iy,0e928h		;a5d9
REPASA_LOS_5_DE_SALIDA:		; por cada rival de la parrilla: delante o detras, y las cuentas del coche
	ld b,005h		;a5dd   ; los cinco huecos
	ld de,00038h		;a5df   ; 0x38 bytes de uno al siguiente
L_A5E2:
	ld a,(iy+000h)		;a5e2   ; hueco vacio: nada que mirar
	and a			;a5e5
	jr z,L_A621		;a5e6
	ld a,(ix+004h)		;a5e8   ; la vertical del coche menos la del rival
	sub (iy+004h)		;a5eb
	ld (iy+029h),a		;a5ee   ; (iy+29) guarda esa diferencia; su bit 7 es "el otro va detras"
	set 7,(iy+030h)		;a5f1   ; bit 7 de (iy+30) = este objeto cuenta para los adelantamientos...
	res 6,(iy+030h)		;a5f5   ; ...y bit 6 quitado = todavia no se ha apuntado ninguno
	jr c,L_A60F		;a5f9   ; con acarreo el rival esta mas abajo, o sea por detras
	set 7,(iy+000h)		;a5fb   ; por delante: se marca como mas rapido, que es el que se escapa
	set 2,(iy+030h)		;a5ff   ; bit 2 de (iy+30): va por delante
	res 3,(iy+030h)		;a603
	push ix		;a607
	pop hl			;a609
	call MAS_UNO_DELANTE		;a60a   ; y suma a la cuenta de los de delante del coche
	jr L_A621		;a60d
L_A60F:
	res 7,(iy+000h)		;a60f   ; por detras: ni mas rapido...
	res 2,(iy+030h)		;a613   ; ...ni bit 2
	res 3,(iy+030h)		;a617
	push ix		;a61b
	pop hl			;a61d
	call MAS_UNO_DETRAS		;a61e   ; y suma a la cuenta de los de detras
L_A621:
	add iy,de		;a621   ; al hueco siguiente
	djnz L_A5E2		;a623
	ld a,(ix+071h)		;a625   ; (ix+71) = la plaza de la parrilla, 3 o 4
	call POSICION_DE_SALIDA		;a628   ; 0xA649 le suma el peloton que va por delante sin verse
	ld (ix+071h),a		;a62b   ; y ya es la posicion de salida de verdad
	ret			;a62e
QUIEN_VA_DELANTE:		; bit 7 de (E2E9) = el coche 2 va por DETRAS del 1, el mismo criterio que el (iy+29) de un rival; solo con dos jugadores
	ld ix,0e2c0h		;a62f   ; el coche 1...
	ld iy,0e380h		;a633   ; ...y el coche 2
	ld a,(ix+071h)		;a637   ; (ix+71) es la posicion: cuanto mas baja, mejor
	cp (iy+071h)		;a63a
	jr c,L_A644		;a63d
	res 7,(ix+029h)		;a63f   ; el 1 no va delante: bit 7 quitado
	ret			;a643
L_A644:
	set 7,(ix+029h)		;a644   ; el 1 va delante, o sea el 2 va detras. En la salida siempre se llega aqui: 0xA673 acaba de poner 3 y 4
	ret			;a648

; ----------------------------------------------------------------------
; De la plaza de la parrilla a la posicion de verdad. Los seis coches
; que se ven salen en las plazas 1 a 6, pero la clasificacion de la
; carrera es mucho mas larga: esta rutina suma el byte de la carrera de
; la tabla 0xA65E, y saliendo tercero en la primera carrera (0x14 = 20)
; se empieza el 23. En la modalidad de dos jugadores alternos (E240
; distinto de cero) no se suma nada y la parrilla es la clasificacion.
; ----------------------------------------------------------------------
POSICION_DE_SALIDA:		; A = plaza de la parrilla + el byte de la carrera de 0xA65E, salvo con E240
	ex af,af'			;a649   ; la plaza se guarda en el juego alterno de registros
	ld a,(0e240h)		;a64a   ; E240 distinto de cero es la tercera opcion del menu, los dos jugadores alternos
	or a			;a64d
	jr nz,SIN_SUMAR_POSICION		;a64e
	ld a,(0e25ch)		;a650   ; la carrera, 0 a 20
	ld hl,0a65eh		;a653
	call 040d0h		;a656   ; p00 0x40D0: HL += A
	ex af,af'			;a659
	add a,(hl)			;a65a   ; la plaza mas los coches que van delante sin verse
	ret			;a65b
SIN_SUMAR_POSICION:		; con E240 la plaza se queda como esta
	ex af,af'			;a65c   ; se recupera la plaza sin tocarla y se devuelve tal cual
	ret			;a65d

; ----------------------------------------------------------------------
; DATOS posicion_extra_por_carrera: 21 bytes, uno por carrera (E25C): los
;   coches que en esa carrera van por delante SIN VERSE. 0xA649 se lo suma a
;   la plaza de la parrilla (3 el jugador 1, 4 el 2, las pone 0xA673) y de ahi
;   sale la posicion de salida real, la que p01 0x6A50 pinta en el ranking: 3
;   + 20 = 23 en la primera carrera, 3 + 50 = 53 en la segunda. Los valores
;   son 20, 50, 15, 40, 40, 23, seis veces 25 y nueve veces 30. Con E240
;   distinto de cero (dos jugadores alternos) no se suma nada
;   0xa65e..0xa673  (21 bytes)
DATA_posicion_extra_por_carrera:
	defb 014h,032h,00fh,028h,028h,017h,019h,019h,019h,019h,019h,019h,01eh,01eh,01eh,01eh,01eh,01eh,01eh,01eh,01eh	; a65e  .2.((................

; ======================================================================
; CODIGO 0xa673..0xa7b9  (326 bytes)
; ======================================================================


L_A673:
	xor a			;a673   ; la parrilla: el jugador 1 sale TERCERO (E331 = 3) y el 2 CUARTO
	ld (0ea7fh),a		;a674
	ld a,003h		;a677
	ld (0e331h),a		;a679
	ld a,004h		;a67c
	ld (0e3f1h),a		;a67e
	ld ix,0e2c0h		;a681
	ld iy,0e380h		;a685
	call L_A860		;a689   ; antes de colocar a nadie se apuntan las dos posiciones
	ld b,006h		;a68c   ; seis plazas que repartir
	ld a,(0e25ch)		;a68e
	ld hl,0a7b9h		;a691   ; y cada carrera tiene su punto de salida en la pista
	call 04a44h		;a694
	ex de,hl			;a697
	ld ix,0e800h		;a698
L_A69C:
	ld a,(0e240h)		;a69c   ; con E240 -dos jugadores alternos- la parrilla se monta de otra manera
	and a			;a69f
	jp nz,L_A785		;a6a0
	ld hl,0a7e3h		;a6a3
	ld a,(0e25ch)		;a6a6
	call 04a44h		;a6a9
	ld a,b			;a6ac
	ld iy,0e2c0h		;a6ad   ; si la plaza es la del jugador 1, ahi va el jugador y no un rival
	cp (iy+071h)		;a6b1
	jp z,L_A73D		;a6b4
	ld a,(0e1c2h)		;a6b7
	bit 5,a		;a6ba
	ld a,b			;a6bc
	jr z,L_A6C9		;a6bd
	ld iy,0e380h		;a6bf
	cp (iy+071h)		;a6c3
	jp z,L_A73D		;a6c6
L_A6C9:
	call 04a44h		;a6c9   ; la rejilla dice cuanto se aparta esta plaza del punto de salida
	push ix		;a6cc   ; el hueco se guarda mientras se monta el rival
	exx			;a6ce
	ld de,0e800h		;a6cf
	push ix		;a6d2
	pop hl			;a6d4
	or a			;a6d5
	sbc hl,de		;a6d6
	ld iy,0e2c0h		;a6d8
	jr z,L_A6E2		;a6dc
	ld iy,0e380h		;a6de
L_A6E2:
	call HUECO_DE_ESTE_COCHE		;a6e2   ; se le busca hueco en la lista del coche que toque
	push hl			;a6e5
	pop ix		;a6e6
	call LIMPIA_HUECO		;a6e8
	exx			;a6eb
	push hl			;a6ec
	ld hl,0ea7fh		;a6ed   ; EA7F cuenta las plazas ya repartidas, y de ahi sale el tipo de rival
	ld a,(hl)			;a6f0
	inc (hl)			;a6f1
	ld hl,0a85bh		;a6f2
	call 040d0h		;a6f5
	ld a,(hl)			;a6f8
	ld (ix+000h),a		;a6f9
	pop hl			;a6fc
	ld a,(iy+009h)		;a6fd
	ld (ix+009h),a		;a700
	set 2,(ix+001h)		;a703   ; el bit 2 de las banderas marca a los coches de la parrilla
	ld a,d			;a707   ; la posicion es el punto de salida mas el desplazamiento de la rejilla
	add a,h			;a708
	ld (ix+006h),a		;a709
	ld a,e			;a70c
	add a,l			;a70d
	ld (ix+004h),a		;a70e
	exx			;a711
	call OBJETO_ALTA		;a712
	call 0996ah		;a715
	ld a,(ix+011h)		;a718   ; la velocidad se guarda como objetivo y el coche arranca parado
	ld (ix+01ah),a		;a71b
	ld (ix+011h),000h		;a71e
	pop hl			;a722
	ld a,(0e1c2h)		;a723
	bit 5,a		;a726
	jr z,L_A736		;a728
	ld de,0e800h		;a72a
	or a			;a72d
	sbc hl,de		;a72e
	ld ix,0e928h		;a730
	jr z,L_A73A		;a734
L_A736:
	ld ix,0e800h		;a736
L_A73A:
	exx			;a73a
	jr L_A761		;a73b
L_A73D:
	call 04a44h		;a73d   ; la plaza del jugador no crea rival: se le coloca a el
	ld a,d			;a740
	add a,h			;a741
	ld (iy+006h),a		;a742
	ld a,e			;a745
	add a,l			;a746
	ld (iy+004h),a		;a747
	ld hl,0a831h		;a74a   ; y su camara sale de otra tabla, segun sea plaza par o impar
	ld a,(0e25ch)		;a74d
	call 04a44h		;a750
	bit 0,(iy+071h)		;a753
	ld a,l			;a757
	jr nz,L_A75B		;a758
	ld a,h			;a75a
L_A75B:
	ld (iy+04bh),a		;a75b
	ld (iy+054h),a		;a75e
L_A761:
	dec b			;a761   ; y a la plaza siguiente
	jp nz,L_A69C		;a762
	ld a,(0e1c2h)		;a765
	bit 5,a		;a768
	ret z			;a76a
	call MIDE_SEPARACION		;a76b   ; con dos jugadores hay que medir la separacion y copiar las listas
	ld ix,0e800h		;a76e
	ld iy,0e2c0h		;a772
	call ESPEJA_LOS_5_OBJETOS		;a776
	ld iy,0e928h		;a779   ; ERRATA DEL CARTUCHO: los bytes son FD 21 28 E9 FD 21 80 E3, o sea ld iy,0E928h y en la instruccion siguiente ld iy,0E380h; la de aqui no hace nada. Por el patron de las dos de arriba (0xA76E ld ix,0E800h / 0xA772 ld iy,0E2C0h) el prefijo tendria que ser DD y no FD, y asi la segunda llamada a 0xA29C repite la lista del jugador 1 en vez de recorrer la del 2. Que la carga se pisa esta LEIDO; que se queria escribir DD es inferencia
	ld iy,0e380h		;a77d
	call ESPEJA_LOS_5_OBJETOS		;a781
	ret			;a784
L_A785:
	ld hl,0a7e3h		;a785   ; la version de dos jugadores alternos: solo se colocan los dos coches
	ld a,(0e25ch)		;a788
	call 04a44h		;a78b
	ld a,b			;a78e
	ld iy,0e2c0h		;a78f
	cp (iy+071h)		;a793
	jp z,L_A7A3		;a796
	ld iy,0e380h		;a799
	cp (iy+071h)		;a79d
	jp nz,L_A761		;a7a0
L_A7A3:
	ld a,(0ea7fh)		;a7a3   ; tres plazas como mucho, y la posicion sale de restarlas de tres
	inc a			;a7a6
	cp 003h		;a7a7
	jp z,L_A761		;a7a9
	ld (0ea7fh),a		;a7ac
	sub 003h		;a7af
	neg		;a7b1
	ld (iy+071h),a		;a7b3
	jp L_A73D		;a7b6

; ----------------------------------------------------------------------
; DATOS salida_por_carrera: 21 palabras, una por carrera (E25C): la posicion
;   de salida (E = byte bajo -> (ix+4), D = byte alto -> (ix+6)). La lee
;   0xA691 (`ld hl,0xA7B9 / call HL_PALABRA_A / ex de,hl`)
;   0xa7b9..0xa7e3  (42 bytes)
DATA_salida_por_carrera:
	defw 07c58h	; a7b9
	defw 0945ch	; a7bb
	defw 07c5ch	; a7bd
	defw 09464h	; a7bf
	defw 09464h	; a7c1
	defw 09464h	; a7c3
	defw 09464h	; a7c5
	defw 09464h	; a7c7
	defw 07c5ch	; a7c9
	defw 0945ch	; a7cb
	defw 09464h	; a7cd
	defw 09464h	; a7cf
	defw 09464h	; a7d1
	defw 09464h	; a7d3
	defw 09464h	; a7d5
	defw 09464h	; a7d7
	defw 09464h	; a7d9
	defw 09464h	; a7db
	defw 09464h	; a7dd
	defw 09464h	; a7df
	defw 07c5ch	; a7e1

; ----------------------------------------------------------------------
; DATOS rejilla_por_carrera: 21 palabras, una por carrera (E25C): puntero a la
;   rejilla de salida. La lee 0xA6A3 y 0xA785 (`ld hl,0xA7E3 / ld a,(E25C) /
;   call HL_PALABRA_A`)
;   0xa7e3..0xa80d  (42 bytes)
DATA_rejilla_por_carrera:
	defw 0a80bh	; a7e3
	defw 0a817h	; a7e5
	defw 0a80bh	; a7e7
	defw 0a823h	; a7e9
	defw 0a823h	; a7eb
	defw 0a823h	; a7ed
	defw 0a823h	; a7ef
	defw 0a823h	; a7f1
	defw 0a80bh	; a7f3
	defw 0a817h	; a7f5
	defw 0a823h	; a7f7
	defw 0a823h	; a7f9
	defw 0a823h	; a7fb
	defw 0a823h	; a7fd
	defw 0a823h	; a7ff
	defw 0a823h	; a801
	defw 0a823h	; a803
	defw 0a823h	; a805
	defw 0a823h	; a807
	defw 0a823h	; a809
	defw 0a80bh	; a80b

; ----------------------------------------------------------------------
; DATOS rejillas_de_salida: tres rejillas de 6 palabras (desplazamiento del
;   coche B respecto a la posicion de salida: byte bajo a (ix+4), alto a
;   (ix+6)). Los punteros de arriba valen 0xA80B, 0xA817 y 0xA823, dos bytes
;   MENOS que la primera entrada, porque el indice B va de 6 a 1 y no de 0 a 5
;   (`call HL_PALABRA_A` en 0xA6C9)
;   0xa80d..0xa831  (36 bytes)
DATA_rejillas_de_salida:
	defw 00000h	; a80d
	defw 01808h	; a80f
	defw 00020h	; a811
	defw 01828h	; a813
	defw 00040h	; a815
	defw 01848h	; a817
	defw 00000h	; a819
	defw 0e808h	; a81b
	defw 00020h	; a81d
	defw 0e828h	; a81f
	defw 00040h	; a821
	defw 0e848h	; a823
	defw 00000h	; a825
	defw 0e810h	; a827
	defw 00020h	; a829
	defw 0e830h	; a82b
	defw 00040h	; a82d
	defw 0e850h	; a82f

; ----------------------------------------------------------------------
; DATOS tabla_A831: 21 palabras, una por carrera (E25C): 0xA74A escoge L o H
;   segun el bit 0 de (iy+71) y lo mete en (iy+4B) y (iy+54)
;   0xa831..0xa85b  (42 bytes)
DATA_tabla_A831:
	defw 05840h	; a831
	defw 04058h	; a833
	defw 05840h	; a835
	defw 04058h	; a837
	defw 04058h	; a839
	defw 04058h	; a83b
	defw 04058h	; a83d
	defw 04058h	; a83f
	defw 05840h	; a841
	defw 04058h	; a843
	defw 04058h	; a845
	defw 04058h	; a847
	defw 04058h	; a849
	defw 04058h	; a84b
	defw 04058h	; a84d
	defw 04058h	; a84f
	defw 04058h	; a851
	defw 04058h	; a853
	defw 04058h	; a855
	defw 04058h	; a857
	defw 05840h	; a859

; ----------------------------------------------------------------------
; DATOS tabla_A85B: bytes indexados por (EA7F), que 0xA6F1 va incrementando y
;   0xA7A7 acota a 3: solo se usan los tres primeros (02 04 05). Los mete en
;   (ix+0)
;   0xa85b..0xa860  (5 bytes)
DATA_tabla_A85B:
	defb 002h,004h,005h,002h,001h	; a85b

; ======================================================================
; CODIGO 0xa860..0xa94f  (239 bytes)
; ======================================================================


L_A860:
	ld a,(ix+071h)		;a860   ; EA7C dice cual de los dos jugadores va delante: 1 o 2
	cp (iy+071h)		;a863
	ccf			;a866
	ld a,000h		;a867
	rla			;a869
	inc a			;a86a
	ld (0ea7ch),a		;a86b
	ld a,(ix+071h)		;a86e
	cp 007h		;a871   ; ninguno de los dos pasa de la plaza 6
	jr c,L_A87A		;a873
	ld a,006h		;a875
	ld (ix+071h),a		;a877
L_A87A:
	ld a,(0e1c2h)		;a87a
	bit 5,a		;a87d
	ret z			;a87f
	ld a,(iy+071h)		;a880   ; y el jugador 2 tampoco pasa de la plaza 6
	cp 007h		;a883
	jr c,L_A88C		;a885
	ld a,006h		;a887
	ld (iy+071h),a		;a889
L_A88C:
	ld a,(ix+071h)		;a88c   ; y si los dos coinciden en la misma plaza, al de detras se le baja una
	cp (iy+071h)		;a88f
	ret nz			;a892
	ld a,(0ea7ch)		;a893
	dec a			;a896
	jr z,L_A89D		;a897
	push iy		;a899
	pop ix		;a89b
L_A89D:
	dec (ix+071h)		;a89d
	ret			;a8a0
L_A8A1:
	call L_AAF9		;a8a1   ; el turno del rival: cada uno se atiende uno de cada ocho fotogramas
	ld a,(0e1c3h)		;a8a4
	add a,(ix+037h)		;a8a7   ; (ix+37) es su turno, y por eso los cinco no caen todos en el mismo fotograma
	and 007h		;a8aa
	ret nz			;a8ac
	call L_A8B4		;a8ad
	call L_A915		;a8b0
	ret			;a8b3
L_A8B4:
	ld a,(ix+032h)		;a8b4   ; (ix+32) trae la curva que viene: el bit 7 dice si es nueva
	and a			;a8b7
	jr z,L_A8FF		;a8b8
	cp 080h		;a8ba
	jr z,L_A8FF		;a8bc
	bit 7,a		;a8be
	ret z			;a8c0
	and 07fh		;a8c1
	ld (ix+032h),a		;a8c3
L_A8C6:
	set 4,(ix+001h)		;a8c6   ; el bit 4 de las banderas marca que este rival esta frenando por curva
	ld b,a			;a8ca
	ld a,(ix+01fh)		;a8cb
	and 00fh		;a8ce
	ld (ix+01fh),a		;a8d0
	ld a,b			;a8d3
	and 003h		;a8d4   ; los dos bits bajos eligen una de las tres listas de frenada
	jr z,L_A908		;a8d6
	dec a			;a8d8
	ld hl,0a94fh		;a8d9
	call 04a44h		;a8dc
	ld a,(ix+000h)		;a8df   ; y el tipo de rival elige la palabra dentro de la lista
	and 00fh		;a8e2
	dec a			;a8e4
	add a,a			;a8e5
	ld e,a			;a8e6
	ld d,000h		;a8e7
	add hl,de			;a8e9
	ld e,(hl)			;a8ea
	inc hl			;a8eb
	ld d,(hl)			;a8ec
	ld l,(ix+01bh)		;a8ed   ; a la velocidad base se le RESTA lo que diga la lista: eso es la velocidad objetivo en la curva
	ld h,(ix+01ch)		;a8f0
	ex de,hl			;a8f3
	add hl,de			;a8f4
	jr nc,L_A8F8		;a8f5   ; y si la resta se sale, se queda en la base
	ex de,hl			;a8f7
L_A8F8:
	ld (ix+019h),e		;a8f8
	ld (ix+01ah),d		;a8fb
	ret			;a8fe
L_A8FF:
	and 07fh		;a8ff   ; sin curva la velocidad objetivo es la base pelada
	ld (ix+032h),a		;a901
	call L_AB62		;a904
	ret c			;a907
L_A908:
	ld e,(ix+01bh)		;a908
	ld d,(ix+01ch)		;a90b
	ld (ix+019h),e		;a90e
	ld (ix+01ah),d		;a911
	ret			;a914
L_A915:
	ld d,(ix+01ah)		;a915   ; la aceleracion del rival sale de comparar su velocidad con la objetivo
	ld e,(ix+019h)		;a918
	ld l,(ix+010h)		;a91b
	ld h,(ix+011h)		;a91e
	ld a,h			;a921
	or a			;a922
	sbc hl,de		;a923
	ld h,a			;a925
	ld a,000h		;a926   ; si van iguales, aceleracion cero
	jr z,L_A944		;a928
	ld a,0e8h		;a92a   ; y si se pasa, 0xE8: frena
	jr nc,L_A944		;a92c
	ld a,h			;a92e
	push af			;a92f
	ld hl,0a991h		;a930   ; cuando falta velocidad, la aceleracion sale de una tabla por categoria y por lo lejos que este
	ld a,(0e25bh)		;a933
	call 04a44h		;a936
	pop af			;a939
	cp 010h		;a93a   ; la diferencia se recorta a dieciseis, que es lo que tiene la tabla
	jr c,L_A940		;a93c
	ld a,00fh		;a93e
L_A940:
	call 040d0h		;a940
	ld a,(hl)			;a943
L_A944:
	ld (ix+012h),a		;a944
	ret			;a947
L_A948:
	ld e,(ix+01bh)		;a948   ; estas tres instrucciones solo devuelven la velocidad base; la tabla de debajo no es suya
	ld d,(ix+01ch)		;a94b
	ret			;a94e

; ----------------------------------------------------------------------
; DATOS tabla_curvas_A94F: 3 punteros a las listas de abajo, indexados por
;   ((ix+32) & 3) - 1. Los lee 0xA8D9 (`ld hl,0xA94F / call HL_PALABRA_A`), NO
;   0xA948 como se publico: 0xA948 son tres instrucciones que devuelven
;   (ix+1B,1C) en DE y lo unico que tienen que ver con la tabla es que estan
;   justo delante
;   0xa94f..0xa955  (6 bytes)
DATA_tabla_curvas_A94F:
	defw 0a955h	; a94f  -> DATA_curvas_A955
	defw 0a969h	; a951
	defw 0a97dh	; a953

; ----------------------------------------------------------------------
; DATOS curvas_A955: 3 listas de 10 palabras con signo, decrecientes y
;   estabilizadas al final: -412..-435, -1032..-1088 y -2064..-2048 (esta
;   ultima salta a -2048 en la octava). YA IDENTIFICADAS (2026-08-21): lo que
;   se le RESTA a la velocidad base de un rival (ix+1B,1C) para dar su
;   velocidad objetivo (ix+19,1A) en 0xA8ED-0xA8FE. La lista la escoge
;   ((ix+32) & 3) - 1, o sea los dos bits bajos del byte de pista que 0xBA9F
;   leyo por delante del coche, y dentro de la lista la palabra es la del tipo
;   de rival ((ix+0) & 0x0F) - 1. Son las tres frenadas de curva, de la mas
;   suave a la mas dura
;   0xa955..0xa991  (60 bytes)
DATA_curvas_A955:
	defw 0fe64h	; a955
	defw 0fe60h	; a957
	defw 0fe5dh	; a959
	defw 0fe5ah	; a95b
	defw 0fe57h	; a95d
	defw 0fe54h	; a95f
	defw 0fe50h	; a961
	defw 0fe4dh	; a963
	defw 0fe4dh	; a965
	defw 0fe4dh	; a967
	defw 0fbf8h	; a969
	defw 0fbf0h	; a96b
	defw 0fbe8h	; a96d
	defw 0fbe0h	; a96f
	defw 0fbd8h	; a971
	defw 0fbd0h	; a973
	defw 0fbc8h	; a975
	defw 0fbc0h	; a977
	defw 0fbc0h	; a979
	defw 0fbc0h	; a97b
	defw 0f7f0h	; a97d
	defw 0f7e0h	; a97f
	defw 0f7d0h	; a981
	defw 0f7c0h	; a983
	defw 0f7b0h	; a985
	defw 0f7a0h	; a987
	defw 0f790h	; a989
	defw 0f800h	; a98b
	defw 0f800h	; a98d
	defw 0f800h	; a98f

; ----------------------------------------------------------------------
; DATOS tabla_A991: 6 punteros, uno por categoria (E25B), a las seis listas de
;   abajo; los lee 0xA930 (`ld hl,0xA991 / ld a,(E25B) / call HL_PALABRA_A`)
;   0xa991..0xa99d  (12 bytes)
DATA_tabla_A991:
	defw 0a99dh	; a991  -> DATA_listas_A991
	defw 0a9adh	; a993
	defw 0a9bdh	; a995
	defw 0a9cdh	; a997
	defw 0a9ddh	; a999
	defw 0a9edh	; a99b

; ----------------------------------------------------------------------
; DATOS listas_A991: seis listas de 16 bytes (una por categoria); 0xA940 coge
;   el byte de indice A acotado a 15 (`cp 0x10 / jr c / ld a,0x0F / call
;   HL_MAS_A / ld a,(hl)`) y lo mete en (ix+12)
;   0xa99d..0xa9fd  (96 bytes)
DATA_listas_A991:
	defb 050h,040h,030h,02ch,018h,018h,018h,018h,010h,00dh,009h,004h,003h,002h,002h,001h	; a99d  P@0,............
	defb 038h,02ch,021h,01eh,010h,010h,010h,010h,00bh,009h,006h,002h,002h,001h,001h,000h	; a9ad  8,!.............
	defb 030h,026h,01ch,01ah,00eh,00eh,00eh,00eh,006h,004h,002h,001h,001h,001h,001h,000h	; a9bd  0&..............
	defb 040h,033h,026h,023h,013h,013h,013h,013h,00ch,00ah,007h,003h,002h,001h,001h,000h	; a9cd  @3&#............
	defb 053h,043h,033h,02fh,018h,018h,018h,018h,010h,00dh,009h,004h,003h,002h,002h,001h	; a9dd  SC3/............
	defb 060h,04ch,039h,034h,01ch,01ch,01ch,01ch,013h,00fh,00ah,004h,003h,002h,002h,001h	; a9ed  `L94............

; ----------------------------------------------------------------------
; DATOS tabla_A9FD: 6 punteros, uno por categoria (E25B), a las seis tablas de
;   abajo; los lee 0xA0F7 (`ld hl,0xA9FD / call HL_PALABRA_A`)
;   0xa9fd..0xaa09  (12 bytes)
DATA_tabla_A9FD:
	defw 0aa09h	; a9fd  -> DATA_tablas_A9FD
	defw 0aa31h	; a9ff
	defw 0aa59h	; aa01
	defw 0aa81h	; aa03
	defw 0aaa9h	; aa05
	defw 0aad1h	; aa07

; ----------------------------------------------------------------------
; DATOS tablas_A9FD: seis tablas de 20 palabras (una por categoria): la
;   VELOCIDAD BASE de cada tipo de rival, dos variantes por tipo. 0xA0FD
;   indexa con (((ix+0) & 0x0F) - 1)*2 + (iy+56), por dos, y devuelve la
;   palabra en DE, que 0xA0EA guarda en (ix+1B,1C). Que es una velocidad se ve
;   en 0xA5A5 (0xA592 la copia a (ix+19,1A), la velocidad objetivo) y en
;   0xA02A (de ahi a (ix+10,11), la velocidad actual). 20 palabras = los 10
;   tipos de rival que p02 0x9D2A trata como coches, por las dos variantes que
;   escoge (iy+56)
;   0xaa09..0xaaf9  (240 bytes)
DATA_tablas_A9FD:
	defw 00600h	; aa09
	defw 00733h	; aa0b
	defw 00580h	; aa0d
	defw 00699h	; aa0f
	defw 005c0h	; aa11
	defw 006e6h	; aa13
	defw 00540h	; aa15
	defw 0064ch	; aa17
	defw 00560h	; aa19
	defw 00673h	; aa1b
	defw 006c0h	; aa1d
	defw 00819h	; aa1f
	defw 00580h	; aa21
	defw 00699h	; aa23
	defw 00730h	; aa25
	defw 00730h	; aa27
	defw 00580h	; aa29
	defw 00580h	; aa2b
	defw 00500h	; aa2d
	defw 00600h	; aa2f
	defw 008cch	; aa31
	defw 00a73h	; aa33
	defw 008f4h	; aa35
	defw 00aa3h	; aa37
	defw 008a3h	; aa39
	defw 00a41h	; aa3b
	defw 0085bh	; aa3d
	defw 009ech	; aa3f
	defw 00870h	; aa41
	defw 00a04h	; aa43
	defw 0088eh	; aa45
	defw 00a29h	; aa47
	defw 00866h	; aa49
	defw 009f9h	; aa4b
	defw 00b80h	; aa4d
	defw 00b80h	; aa4f
	defw 00980h	; aa51
	defw 00980h	; aa53
	defw 007ach	; aa55
	defw 0091eh	; aa57
	defw 00bd0h	; aa59
	defw 00d20h	; aa5b
	defw 00bb2h	; aa5d
	defw 00d00h	; aa5f
	defw 00bd0h	; aa61
	defw 00d20h	; aa63
	defw 00b40h	; aa65
	defw 00c80h	; aa67
	defw 00b78h	; aa69
	defw 00cc0h	; aa6b
	defw 00bd4h	; aa6d
	defw 00d26h	; aa6f
	defw 00bb2h	; aa71
	defw 00d00h	; aa73
	defw 00e00h	; aa75
	defw 00e20h	; aa77
	defw 00d00h	; aa79
	defw 00d20h	; aa7b
	defw 00acch	; aa7d
	defw 00c00h	; aa7f
	defw 00c31h	; aa81
	defw 00d10h	; aa83
	defw 00b51h	; aa85
	defw 00c21h	; aa87
	defw 00bc1h	; aa89
	defw 00c98h	; aa8b
	defw 00ae3h	; aa8d
	defw 00baah	; aa8f
	defw 00b1ah	; aa91
	defw 00be5h	; aa93
	defw 00d80h	; aa95
	defw 00e77h	; aa97
	defw 00b51h	; aa99
	defw 00c21h	; aa9b
	defw 00e60h	; aa9d
	defw 00e60h	; aa9f
	defw 00d00h	; aaa1
	defw 00d00h	; aaa3
	defw 00a73h	; aaa5
	defw 00b31h	; aaa7
	defw 00c71h	; aaa9
	defw 00db0h	; aaab
	defw 00b8eh	; aaad
	defw 00cb5h	; aaaf
	defw 00c00h	; aab1
	defw 00d31h	; aab3
	defw 00b1ch	; aab5
	defw 00c38h	; aab7
	defw 00b55h	; aab9
	defw 00c77h	; aabb
	defw 00dc7h	; aabd
	defw 00f27h	; aabf
	defw 00b8eh	; aac1
	defw 00cb5h	; aac3
	defw 00f00h	; aac5
	defw 00f00h	; aac7
	defw 00d80h	; aac9
	defw 00d80h	; aacb
	defw 00aaah	; aacd
	defw 00bbah	; aacf
	defw 00d00h	; aad1
	defw 00ef1h	; aad3
	defw 00b8eh	; aad5
	defw 00d48h	; aad7
	defw 00c00h	; aad9
	defw 00dcch	; aadb
	defw 00b1ch	; aadd
	defw 00cc7h	; aadf
	defw 00b55h	; aae1
	defw 00d07h	; aae3
	defw 00caah	; aae5
	defw 00e90h	; aae7
	defw 00b8eh	; aae9
	defw 00d48h	; aaeb
	defw 010f0h	; aaed
	defw 010f0h	; aaef
	defw 00f30h	; aaf1
	defw 00f30h	; aaf3
	defw 00aaah	; aaf5
	defw 00c43h	; aaf7

; ======================================================================
; CODIGO 0xaaf9..0xac22  (297 bytes)
; ======================================================================


L_AAF9:
	call L_B353		;aaf9   ; el rival mira la pista que tiene por delante para saber si viene curva
	ret nc			;aafc
	bit 6,a		;aafd   ; el bit 6 del byte de pista no es curva: es un aviso especial
	jp nz,L_AB24		;aaff
	bit 4,(ix+001h)		;ab02   ; si ya venia frenando, un cero se ignora
	jr nz,L_AB20		;ab06
L_AB08:
	and 07fh		;ab08
	ld b,a			;ab0a
L_AB0B:
	ld a,(ix+032h)		;ab0b   ; y si la curva es la misma que ya tenia, no hay nada que cambiar
	cp b			;ab0e
	ret z			;ab0f
	ld a,b			;ab10
	or 080h		;ab11   ; el bit 7 marca la curva como nueva, que es lo que mira 0xA8B4
	ld (ix+032h),a		;ab13
	ld a,(ix+017h)		;ab16
	and 080h		;ab19
	or b			;ab1b
	ld (ix+017h),a		;ab1c
	ret			;ab1f
L_AB20:
	and a			;ab20   ; el cero solo cuenta si no se estaba frenando
	ret z			;ab21
	jr L_AB08		;ab22
L_AB24:
	and 03fh		;ab24   ; los seis bits bajos separan las tres ordenes: 0 meta, 1 fin de curva y 2 otra cosa
	jr z,L_AB34		;ab26
	dec a			;ab28
	jr nz,L_AB5B		;ab29
	res 4,(ix+001h)		;ab2b   ; fin de curva: se apaga el bit 4 y la velocidad objetivo vuelve a la base
	ld b,000h		;ab2f
	jp L_AB0B		;ab31
L_AB34:
	bit 1,(iy+001h)		;ab34   ; UN RIVAL QUE CRUZA LA META TE CUESTA UN PUESTO: sube E331 (o E3F1) en uno, con tope 99
	ret z			;ab38
	ld a,(0e214h)		;ab39   ; y solo cuenta desde que el jugador ha llegado
	dec a			;ab3c
	ret nz			;ab3d
	bit 1,(ix+001h)		;ab3e   ; cada rival lo cobra una sola vez: el bit 1 de sus banderas
	ret nz			;ab42
	bit 0,(iy+009h)		;ab43
	ld hl,0e331h		;ab47
	jr z,L_AB4F		;ab4a
	ld hl,0e3f1h		;ab4c
L_AB4F:
	ld a,(hl)			;ab4f
	cp 063h		;ab50
	jr nc,L_AB55		;ab52
	inc a			;ab54
L_AB55:
	ld (hl),a			;ab55
	set 1,(ix+001h)		;ab56
	ret			;ab5a
L_AB5B:
	dec a			;ab5b
	ret nz			;ab5c
	set 4,(ix+017h)		;ab5d   ; la tercera orden solo enciende el bit 4 de (ix+17)
	ret			;ab61
L_AB62:
	ret			;ab62   ; un `ret` pelado: la rutina que llamaba 0xA904 no hace nada
L_AB63:
	ld a,(0e1c2h)		;ab63   ; con dos jugadores hay tres pasadas y con uno solo una
	bit 5,a		;ab66
	jr z,L_AB74		;ab68
	call L_AB7B		;ab6a
	call L_AC32		;ab6d
	call L_ACC0		;ab70
	ret			;ab73
L_AB74:
	call L_AB86		;ab74
	call L_ACCB		;ab77
	ret			;ab7a
L_AB7B:
	ld ix,0e380h		;ab7b
	ld iy,0e928h		;ab7f
	call L_AB8E		;ab83
L_AB86:
	ld ix,0e2c0h		;ab86
	ld iy,0e800h		;ab8a
L_AB8E:
	ld b,005h		;ab8e
L_AB90:
	ld a,(iy+000h)		;ab90   ; los cinco rivales del coche, uno por uno
	or a			;ab93
	jr z,L_ABAF		;ab94
	push bc			;ab96
	call L_AD26		;ab97
	jr c,L_ABA0		;ab9a
	ld (iy+026h),000h		;ab9c
L_ABA0:
	call c,L_AEEF		;aba0   ; con acarreo hay contacto y se resuelve
	res 2,(ix+05eh)		;aba3
	ld a,(iy+026h)		;aba7
	and a			;abaa
	call nz,L_ABB7		;abab
	pop bc			;abae
L_ABAF:
	ld de,00038h		;abaf
	add iy,de		;abb2
	djnz L_AB90		;abb4
	ret			;abb6
L_ABB7:
	call L_ABF8		;abb7   ; (iy+26) encendido es "este rival esta pegado al coche"
	ld a,(ix+004h)		;abba   ; se compara la vertical del coche con la del rival
	sub 008h		;abbd
	sub (iy+004h)		;abbf
	jr nc,L_ABD5		;abc2
	ld h,(iy+01ah)		;abc4   ; el que va detras se queda con la mitad de la velocidad objetivo: se descuelga
	ld l,(iy+019h)		;abc7
	sra h		;abca
	rr l		;abcc
	ld (iy+01ah),h		;abce
	ld (iy+019h),l		;abd1
	ret			;abd4
L_ABD5:
	ld a,(ix+006h)		;abd5   ; y el que va delante se aparta de lado si esta muy pegado al borde
	sub 007h		;abd8
	ld a,(iy+006h)		;abda
	cp 00fh		;abdd
	ret nc			;abdf
	ld h,(iy+008h)		;abe0
	ld l,(iy+007h)		;abe3
	ld d,h			;abe6
	ld e,l			;abe7
	sra h		;abe8   ; vx se multiplica por 1,75: dos corrimientos y la suma
	rr l		;abea
	sra h		;abec
	rr l		;abee
	add hl,de			;abf0
	ld (iy+008h),h		;abf1
	ld (iy+007h),l		;abf4
	ret			;abf7
L_ABF8:
	ld a,(iy+006h)		;abf8   ; los dos bytes que se escriben dicen por que lado se esquiva, y cambian segun quien vaya arriba
	cp (ix+006h)		;abfb
	ld hl,00104h		;abfe
	jr nc,L_AC06		;ac01
	ld hl,00203h		;ac03
L_AC06:
	ld (ix+002h),h		;ac06
	ld (ix+034h),l		;ac09
	ret			;ac0c
L_AC0D:
	ld a,(iy+000h)		;ac0d   ; la permutacion de 0xAC22 cambia el tipo de rival por otro: los tipos 1 y 2 se van al 6 y al 7
	ld c,a			;ac10
	and 00fh		;ac11   ; el nibble bajo es el tipo
	ld l,a			;ac13
	ld h,000h		;ac14
	ld de,0ac22h		;ac16
	add hl,de			;ac19
	ld a,c			;ac1a
	and 0f0h		;ac1b
	or (hl)			;ac1d
	ld (iy+000h),a		;ac1e
	ret			;ac21

; ----------------------------------------------------------------------
; DATOS tabla_AC22: 16 bytes (00 03 04 05 06 07 01 02 08 09 0A 0B 0C 0D 0E 0F)
;   que 0xAC16 usa como permutacion del nibble bajo de (iy+0) (`ld de,0xAC22 /
;   add hl,de / or (hl)`)
;   0xac22..0xac32  (16 bytes)
DATA_tabla_AC22:
	defb 000h,003h,004h,005h,006h,007h,001h,002h,008h,009h,00ah,00bh,00ch,00dh,00eh,00fh	; ac22  ................

; ======================================================================
; CODIGO 0xac32..0xb52c  (2298 bytes)
; ======================================================================


L_AC32:
	ld iy,0e380h		;ac32   ; el choque entre los dos jugadores solo se mira con los dos en estado 0
	ld ix,0e2c0h		;ac36
	ld a,(ix+05dh)		;ac3a   ; los dos coches tienen que estar en estado 0
	cp 000h		;ac3d
	ret nz			;ac3f
	ld a,(iy+05dh)		;ac40
	cp 000h		;ac43
	ret nz			;ac45
	call L_AC55		;ac46
	jp c,L_AFD1		;ac49
	res 0,(ix+05eh)		;ac4c
	res 0,(iy+05eh)		;ac50
	ret			;ac54
L_AC55:
	ld a,(0e214h)		;ac55   ; y no despues de que alguien haya llegado a meta
	and a			;ac58
	ret nz			;ac59
	ld hl,0ea71h		;ac5a
	ld a,(ix+004h)		;ac5d   ; la distancia vertical entre los dos coches, que se guarda en EA71 y en (ix+29)
	sub (iy+05ah)		;ac60
	ld d,(ix+029h)		;ac63
	ld (hl),a			;ac66
	ld (ix+029h),a		;ac67
	add a,00fh		;ac6a   ; si estan a mas de quince pixeles no hay nada que mirar
	cp 01eh		;ac6c
	jp nc,L_ADA5		;ac6e
	ld a,(ix+006h)		;ac71   ; y luego lo mismo de lado, con ocho
	sub (iy+006h)		;ac74
	add a,008h		;ac77
	cp 010h		;ac79
	push af			;ac7b
	ld a,d			;ac7c
	xor (ix+029h)		;ac7d   ; el `xor` con el valor anterior dice si se han cruzado en este fotograma
	rla			;ac80
	jp nc,L_ADA4		;ac81
	call L_AC89		;ac84
	pop af			;ac87
	ret			;ac88
L_AC89:
	ld a,(iy+071h)		;ac89   ; al cruzarse, los dos coches se intercambian el puesto
	ld b,(ix+071h)		;ac8c
	ld (ix+071h),a		;ac8f
	ld (iy+071h),b		;ac92
	bit 0,(iy+030h)		;ac95
	ret nz			;ac99
	ld l,(ix+010h)		;ac9a
	ld h,(ix+011h)		;ac9d
	ld e,(iy+010h)		;aca0
	ld d,(iy+011h)		;aca3
	or a			;aca6
	sbc hl,de		;aca7
	call c,04b04h		;aca9   ; la diferencia de velocidad en valor absoluto
	ld de,00200h		;acac   ; y solo con mas de 0x200 de diferencia suena el 3: el adelantamiento se oye
	or a			;acaf
	sbc hl,de		;acb0
	jp c,L_ADA2		;acb2
	set 0,(iy+030h)		;acb5
	ld a,003h		;acb9
	call 04174h		;acbb
	or a			;acbe
	ret			;acbf
L_ACC0:
	ld ix,0e928h		;acc0   ; y aqui se miran los rivales entre si, todos contra todos
	ld a,(ix+000h)		;acc4
	and a			;acc7
	call nz,L_ACCF		;acc8
L_ACCB:
	ld ix,0e800h		;accb
L_ACCF:
	ld b,004h		;accf
L_ACD1:
	push bc			;acd1
	push ix		;acd2
	pop iy		;acd4
	ld de,00038h		;acd6
	add iy,de		;acd9
L_ACDB:
	ld a,(ix+000h)		;acdb   ; los cinco rivales del otro coche, uno por uno
	and a			;acde
	push bc			;acdf
	call nz,L_ACF4		;ace0   ; el objeto vacio se salta
	call c,L_AF4C		;ace3
	pop bc			;ace6
	ld de,00038h		;ace7
	add iy,de		;acea
	djnz L_ACDB		;acec
	pop bc			;acee
	add ix,de		;acef
	djnz L_ACD1		;acf1
	ret			;acf3
L_ACF4:
	ld b,a			;acf4   ; los tipos con algun bit del nibble alto no chocan, y el tipo 15 tampoco
	and 070h		;acf5   ; el nibble alto ocupado significa que el objeto esta en otro estado
	ret nz			;acf7
	ld a,b			;acf8
	and 00fh		;acf9
	cp 00fh		;acfb
	ret z			;acfd
	ld a,(iy+000h)		;acfe
	and a			;ad01
	ret z			;ad02
	ld b,a			;ad03
	and 070h		;ad04
	ret nz			;ad06
	ld a,b			;ad07
	and 00fh		;ad08
	cp 00fh		;ad0a
	ret z			;ad0c
	ld a,(ix+004h)		;ad0d   ; la misma prueba de siempre: quince pixeles de alto y ocho de ancho
	sub (iy+004h)		;ad10
	ld (0ea71h),a		;ad13
	add a,00fh		;ad16   ; quince pixeles de alto...
	cp 01eh		;ad18
	ret nc			;ad1a
	ld a,(ix+006h)		;ad1b
	sub (iy+006h)		;ad1e
	add a,008h		;ad21   ; ...y ocho de ancho, la misma ventana de siempre
	cp 010h		;ad23
	ret			;ad25
L_AD26:
	ld a,(ix+004h)		;ad26   ; aqui se compara el coche del jugador con uno de sus rivales
	sub (iy+004h)		;ad29
	ld d,(iy+029h)		;ad2c
	ld (iy+029h),a		;ad2f
	add a,00fh		;ad32
	cp 01eh		;ad34
	jr nc,L_ADA5		;ad36
	ld a,(ix+006h)		;ad38
	sub (iy+006h)		;ad3b
	add a,008h		;ad3e
	cp 010h		;ad40
	push af			;ad42
	ld a,d			;ad43
	xor (iy+029h)		;ad44   ; y el `xor` con la distancia anterior dice si se acaban de cruzar
	rla			;ad47
	jr nc,L_ADA4		;ad48
	call L_AD4F		;ad4a
	pop af			;ad4d
	ret			;ad4e
L_AD4F:
	ld a,(iy+000h)		;ad4f   ; al cruzarse con un rival se le adelanta -o te adelanta a ti-
	and 00fh		;ad52
	cp 00fh		;ad54
	ret z			;ad56
	call L_ADAA		;ad57
	ld a,(ix+05dh)		;ad5a
	cp 006h		;ad5d   ; el coche parado no adelanta a nadie
	ret z			;ad5f
	bit 0,(iy+030h)		;ad60
	ret nz			;ad64
	ld l,(ix+010h)		;ad65
	ld h,(ix+011h)		;ad68
	ld e,(iy+010h)		;ad6b
	ld d,(iy+011h)		;ad6e
	or a			;ad71
	sbc hl,de		;ad72
	call c,04b04h		;ad74   ; la diferencia de velocidad en valor absoluto
	ld de,00180h		;ad77
	or a			;ad7a
	sbc hl,de		;ad7b   ; por debajo de 0x180 el adelantamiento no suena
	ret c			;ad7d
	ld de,00300h		;ad7e
	set 0,(iy+030h)		;ad81
	ld a,(0e1c2h)		;ad85
	bit 5,a		;ad88
	jr z,L_AD97		;ad8a
	ld a,006h		;ad8c   ; con dos jugadores suenan los sonidos 6 y 8 y con uno el 4 y el 5, segun lo fuerte que sea el cruce
	sbc hl,de		;ad8e
	jr nc,L_AD94		;ad90
	ld a,008h		;ad92
L_AD94:
	jp 0867bh		;ad94
L_AD97:
	ld a,004h		;ad97
	sbc hl,de		;ad99
	jr nc,L_AD9F		;ad9b
	ld a,005h		;ad9d
L_AD9F:
	call 04174h		;ad9f
L_ADA2:
	or a			;ada2
	ret			;ada3
L_ADA4:
	pop af			;ada4
L_ADA5:
	res 0,(iy+030h)		;ada5   ; al separarse se limpia la marca: el cruce siguiente volvera a contar
	ret			;ada9
L_ADAA:
	ld a,(0e214h)		;adaa   ; aqui se recalcula el puesto del jugador al cruzarse con un rival
	and a			;adad
	ret nz			;adae
	bit 1,(iy+001h)		;adaf   ; ni el que ya llego ni el rival que ya llego cuentan
	ret nz			;adb3
	bit 1,(ix+001h)		;adb4
	ret nz			;adb8
	bit 6,(iy+030h)		;adb9
	ret nz			;adbd
	bit 7,(iy+030h)		;adbe
	jr nz,L_AE03		;adc2
	ld a,(ix+071h)		;adc4
	dec a			;adc7   ; el que va primero no puede subir mas
	jr z,L_AE03		;adc8
	ld a,(ix-002h)		;adca
	and a			;adcd
	jr z,L_AE03		;adce
	ld hl,0e1fch		;add0   ; y hasta que no falten menos de dos vueltas, el puesto no se toca
	sub (hl)			;add3
	cp 002h		;add4
	jr c,L_AE03		;add6
	ld a,(ix+07eh)		;add8   ; (ix+7E) es el ritmo: por debajo de el no se sube de puesto
	cp (ix+071h)		;addb
	jr z,L_AE03		;adde
	jp m,L_AE03		;ade0
	ld a,(ix+030h)		;ade3
	xor 002h		;ade6   ; el `xor 2` alterna: solo uno de cada dos cruces cuenta
	ld (ix+030h),a		;ade8
	bit 1,(ix+030h)		;adeb
	jr nz,L_AE03		;adef
L_ADF1:
	bit 7,(iy+000h)		;adf1   ; el bit 7 del tipo del rival dice si es de los rapidos
	jp z,L_AEC3		;adf5
	jr L_AE0E		;adf8
L_ADFA:
	bit 7,(iy+000h)		;adfa
	jp nz,L_AEC3		;adfe
	jr L_AE0E		;ae01
L_AE03:
	ld a,(ix+071h)		;ae03   ; los puestos 1 y 99 se tratan aparte: son los extremos
	cp 001h		;ae06
	jr z,L_ADF1		;ae08
	cp 063h		;ae0a
	jr z,L_ADFA		;ae0c
L_AE0E:
	bit 7,(iy+029h)		;ae0e   ; el bit 7 de la distancia dice si el rival va por detras
	ld b,(ix+071h)		;ae12
	jr nz,L_AE6E		;ae15
	call L_AEE5		;ae17   ; los rivales rapidos van por otra rama
	jr c,L_AE3F		;ae1a
	bit 7,(iy+030h)		;ae1c   ; el bit 7 dice si el rival ya conto en un cruce anterior
	jr nz,L_AE60		;ae20
	ld a,(ix+05eh)		;ae22
	rra			;ae25
	rra			;ae26
	rra			;ae27
	and 007h		;ae28
	bit 2,(ix+030h)		;ae2a
	jr nz,L_AE31		;ae2e
	inc a			;ae30
L_AE31:
	sub 064h		;ae31   ; el puesto se cuenta desde 99 hacia abajo
	neg		;ae33
	inc b			;ae35
	cp b			;ae36
	jp z,L_AEC3		;ae37
	ld (ix+071h),b		;ae3a
	jr L_AE4E		;ae3d
L_AE3F:
	inc b			;ae3f   ; adelantado por el rival: un puesto mas, sin pasar de 99
	ld a,b			;ae40
	cp 064h		;ae41
	jr nc,L_AEBF		;ae43
	ld (ix+071h),b		;ae45
	set 2,(ix+030h)		;ae48
	jr L_AE51		;ae4c
L_AE4E:
	call L_AECE		;ae4e
L_AE51:
	set 7,(iy+030h)		;ae51   ; y se marca el rival como ya contado
	ld a,(ix+071h)		;ae55
	cp 063h		;ae58
	ret nz			;ae5a
	res 7,(iy+000h)		;ae5b
	ret			;ae5f
L_AE60:
	inc b			;ae60   ; la otra rama, la del rival que ya contaba
	ld a,b			;ae61
	cp 064h		;ae62
	jr nc,L_AEC3		;ae64
	ld (ix+071h),b		;ae66
	call L_AEC8		;ae69
	jr L_AE51		;ae6c
L_AE6E:
	call L_AEE5		;ae6e   ; y todo lo de arriba otra vez, para el caso de que el rival vaya delante
	jr c,L_AE91		;ae71
	bit 7,(iy+030h)		;ae73
	jr nz,L_AEAE		;ae77
	ld a,(ix+030h)		;ae79
	rra			;ae7c
	rra			;ae7d
	rra			;ae7e
	and 007h		;ae7f   ; tres bits de (ix+30): cuantos puestos se ganan de golpe
	bit 2,(ix+030h)		;ae81
	jr z,L_AE88		;ae85
	inc a			;ae87
L_AE88:
	dec b			;ae88
	cp b			;ae89
	jr nc,L_AEC3		;ae8a
	ld (ix+071h),b		;ae8c
	jr L_AE9D		;ae8f
L_AE91:
	dec b			;ae91   ; adelantar sube un puesto, hasta el primero
	jr z,L_AEB9		;ae92
	ld (ix+071h),b		;ae94
	res 2,(ix+030h)		;ae97
	jr L_AEA0		;ae9b
L_AE9D:
	call L_AEDA		;ae9d
L_AEA0:
	set 7,(iy+030h)		;aea0
	ld a,(ix+071h)		;aea4
	dec a			;aea7
	ret nz			;aea8
	set 7,(iy+000h)		;aea9   ; y al llegar al primero se le quita al rival la marca de rapido
	ret			;aead
L_AEAE:
	dec b			;aeae
	jr z,L_AEB9		;aeaf
	ld (ix+071h),b		;aeb1
	call L_AED4		;aeb4
	jr L_AEA0		;aeb7
L_AEB9:
	res 2,(ix+030h)		;aeb9
	jr L_AEC3		;aebd
L_AEBF:
	set 2,(ix+030h)		;aebf   ; y aqui se enciende, que se ha ido al ultimo
L_AEC3:
	set 6,(iy+030h)		;aec3   ; el bit 6 marca al rival como ya contado en este cruce
	ret			;aec7
L_AEC8:
	push ix		;aec8   ; las cuatro puertas de aqui abajo suben o bajan las cuentas de los de delante y los de detras
	pop hl			;aeca
	call MENOS_UNO_DETRAS		;aecb
L_AECE:
	push ix		;aece
	pop hl			;aed0
	jp MAS_UNO_DELANTE		;aed1
L_AED4:
	push ix		;aed4
	pop hl			;aed6
	call MENOS_UNO_DELANTE		;aed7
L_AEDA:
	push ix		;aeda
	pop hl			;aedc
	jp MAS_UNO_DETRAS		;aedd
L_AEE0:
	ld a,(ix+000h)		;aee0
	jr L_AEE8		;aee3
L_AEE5:
	ld a,(iy+000h)		;aee5   ; los tipos 8 y 9 son los rivales rapidos
L_AEE8:
	and 00fh		;aee8
	sub 008h		;aeea
	cp 002h		;aeec
	ret			;aeee
L_AEEF:
	ld a,(ix+05dh)		;aeef   ; el toque entre el coche y un rival, con los dos rodando
	cp 000h		;aef2
	ret nz			;aef4
	ld a,(iy+000h)		;aef5
	and 00fh		;aef8
	cp 00fh		;aefa
	ret z			;aefc
	ld a,(ix+004h)		;aefd
	add a,008h		;af00   ; ocho pixeles de margen para que se considere toque
	cp (iy+004h)		;af02
	call c,L_AF32		;af05
	ret c			;af08
	set 7,(ix+001h)		;af09   ; los dos quedan marcados con el bit 7: el toque los descoloca
	set 7,(iy+001h)		;af0d
	ld a,(iy+026h)		;af11
	and a			;af14
	jp nz,L_B158		;af15
	ld a,017h		;af18   ; el sonido 0x17 es el golpe
	call 0867bh		;af1a
	ld (ix+026h),001h		;af1d   ; uno queda como 1 y el otro como 2: quien empujo a quien
	ld (iy+026h),002h		;af21
	call L_B24A		;af25   ; y el golpe desgasta al coche
	add a,(ix+064h)		;af28
	ld (ix+064h),a		;af2b
	exx			;af2e
	jp L_B01D		;af2f
L_AF32:
	ld a,(iy+000h)		;af32   ; los rivales rapidos solo cuentan si ademas van mas despacio
	and 00fh		;af35
	sub 008h		;af37
	cp 002h		;af39
	ccf			;af3b
	ret nc			;af3c
	ld a,(ix+008h)		;af3d   ; solo si ademas el rival va mas despacio
	sub 001h		;af40
	cp (iy+008h)		;af42
	ccf			;af45
	ret nc			;af46
	call L_B15C		;af47
	scf			;af4a
	ret			;af4b
L_AF4C:
	call L_B00C		;af4c   ; el toque entre dos rivales: se separan un pixel cada uno
	ld a,(ix+004h)		;af4f
	cp (iy+004h)		;af52
	ld d,001h		;af55   ; D dice hacia donde se aparta cada uno
	jr nc,L_AF5B		;af57
	ld d,0ffh		;af59
L_AF5B:
	ld a,d			;af5b
	add a,(ix+004h)		;af5c
	ld (ix+004h),a		;af5f
	ld a,d			;af62
	neg		;af63
	add a,(iy+004h)		;af65
	ld (iy+004h),a		;af68
	bit 7,d		;af6b
	call L_AFAB		;af6d   ; y al que va detras se le quita velocidad
	ld a,(ix+006h)		;af70
	cp (iy+006h)		;af73
	ld d,010h		;af76   ; de lado el empujon es de 0x10, y se reparte entre los dos
	jr nc,L_AF7C		;af78
	ld d,0f0h		;af7a
L_AF7C:
	ld a,(ix+036h)		;af7c
	call L_AFC3		;af7f   ; la suma con tope, para no pasarse de lado
	ld (ix+036h),c		;af82
	ld a,d			;af85
	neg		;af86
	ld d,a			;af88
	ld a,(iy+036h)		;af89   ; y lo mismo con el otro coche
	call L_AFC3		;af8c
	ld (iy+036h),c		;af8f
	sra d		;af92   ; cuatro corrimientos con signo: el empujon de lado se aplica en decimosextas partes
	sra d		;af94
	sra d		;af96
	sra d		;af98
	ld a,d			;af9a
	add a,(iy+006h)		;af9b
	ld (iy+006h),a		;af9e
	ld a,d			;afa1
	neg		;afa2
	add a,(ix+006h)		;afa4
	ld (ix+006h),a		;afa7
	ret			;afaa
L_AFAB:
	bit 7,d		;afab   ; el que pierde velocidad es siempre el de detras
	jr nz,L_AFB9		;afad
	ld a,(ix+011h)		;afaf
	sub 001h		;afb2
	ret c			;afb4
	ld (ix+011h),a		;afb5
	ret			;afb8
L_AFB9:
	ld a,(iy+011h)		;afb9
	sub 001h		;afbc
	ret c			;afbe
	ld (iy+011h),a		;afbf
	ret			;afc2
L_AFC3:
	or a			;afc3   ; la suma con tope: si al sumar cambia el signo, se queda como estaba
	ld e,a			;afc4
	jp p,L_AFCB		;afc5
	sub d			;afc8
	jr L_AFCC		;afc9
L_AFCB:
	add a,d			;afcb
L_AFCC:
	ld c,a			;afcc
	xor e			;afcd
	ret p			;afce
	ld c,e			;afcf
	ret			;afd0
L_AFD1:
	set 7,(ix+001h)		;afd1   ; el choque entre los DOS JUGADORES: los dos marcados y los dos desgastados
	set 7,(iy+001h)		;afd5
	bit 0,(ix+05eh)		;afd9
	ret nz			;afdd
	ld a,(0e161h)		;afde   ; y el sonido no se repite si ya estaba sonando
	cp 017h		;afe1
	jr z,L_AFEA		;afe3
	ld a,017h		;afe5
	call 04174h		;afe7
L_AFEA:
	set 0,(ix+05eh)		;afea
	set 0,(iy+05eh)		;afee   ; los dos coches quedan marcados
	ld (ix+026h),001h		;aff2   ; los dos quedan marcados como tocados
	ld (iy+026h),001h		;aff6
	call L_B24A		;affa
	add a,(ix+064h)		;affd
	ld (ix+064h),a		;b000
	add a,(iy+064h)		;b003
	ld (iy+064h),a		;b006
	exx			;b009
	jr L_B01D		;b00a
L_B00C:
	ld a,(iy+000h)		;b00c   ; el tipo 15 no participa en golpes
	and 00fh		;b00f
	cp 00fh		;b011
	ret z			;b013
	ld a,(ix+000h)		;b014
	and 00fh		;b017
	cp 00fh		;b019
	ret z			;b01b
	exx			;b01c
L_B01D:
	ld c,(iy+007h)		;b01d   ; el reparto del golpe: primero vx de los dos...
	ld b,(iy+008h)		;b020
	ld e,(ix+007h)		;b023
	ld d,(ix+008h)		;b026
	call L_B060		;b029
	ld (iy+007h),l		;b02c
	ld (iy+008h),h		;b02f
	exx			;b032
	ld (ix+007h),l		;b033
	ld (ix+008h),h		;b036
	exx			;b039
	call L_B265		;b03a   ; ...y luego vy
	ld c,(iy+00ah)		;b03d
	ld b,(iy+00bh)		;b040
	ld e,(ix+00ah)		;b043
	ld d,(ix+00bh)		;b046
	call L_B0A8		;b049
	ld (iy+00ah),l		;b04c
	ld (iy+00bh),h		;b04f
	exx			;b052
	ld (ix+00ah),l		;b053
	ld (ix+00bh),h		;b056
	exx			;b059
	call L_B2F6		;b05a   ; y al final se copia el resultado a las parejas de dos jugadores
	jp L_B0E8		;b05d
L_B060:
	ld h,b			;b060   ; la vx nueva de los dos es la media mas o menos la cuarta parte de la diferencia: un choque elastico a medias
	ld l,c			;b061
	add hl,de			;b062
	sra h		;b063   ; la media de las dos velocidades
	rr l		;b065
	ex de,hl			;b067
	or a			;b068
	sbc hl,de		;b069
	push hl			;b06b
	ld a,h			;b06c
	cpl			;b06d
	ld h,a			;b06e
	ld a,l			;b06f
	cpl			;b070
	ld l,a			;b071
	inc hl			;b072
	sra h		;b073   ; y la diferencia entre ellas, en valor absoluto, dividida por cuatro
	rr l		;b075
	sra h		;b077
	rr l		;b079
	or a			;b07b
	adc hl,de		;b07c
	jp m,L_B084		;b07e   ; si sale positiva se queda a cero: no se puede rebotar hacia delante
	ld hl,00000h		;b081
L_B084:
	push hl			;b084   ; la vy del segundo se calcula igual que la del primero
	ld h,b			;b085
	ld l,c			;b086
	or a			;b087
	sbc hl,de		;b088
	push hl			;b08a
	ld a,h			;b08b   ; la diferencia, esta vez del otro
	cpl			;b08c
	ld h,a			;b08d
	ld a,l			;b08e
	cpl			;b08f
	ld l,a			;b090
	inc hl			;b091
	sra h		;b092
	rr l		;b094
	sra h		;b096
	rr l		;b098
	or a			;b09a
	adc hl,de		;b09b
	jp m,L_B0A3		;b09d   ; y tampoco puede salir positiva
	ld hl,00000h		;b0a0
L_B0A3:
	exx			;b0a3
	pop bc			;b0a4
	pop hl			;b0a5
	pop de			;b0a6
	ret			;b0a7
L_B0A8:
	ld h,b			;b0a8   ; lo mismo con vy, pero repartiendo por OCHO en vez de por cuatro: de lado el golpe es mas suave
	ld l,c			;b0a9
	add hl,de			;b0aa
	sra h		;b0ab
	rr l		;b0ad
	ex de,hl			;b0af   ; la media queda en DE y la diferencia se calcula contra ella
	or a			;b0b0
	sbc hl,de		;b0b1
	push hl			;b0b3
	ld a,h			;b0b4
	cpl			;b0b5
	ld h,a			;b0b6
	ld a,l			;b0b7
	cpl			;b0b8
	ld l,a			;b0b9
	inc hl			;b0ba
	sra h		;b0bb   ; tres corrimientos, o sea entre ocho
	rr l		;b0bd
	sra h		;b0bf
	rr l		;b0c1
	sra h		;b0c3
	rr l		;b0c5
	add hl,de			;b0c7
	push hl			;b0c8   ; la vy nueva del primero
	ld h,b			;b0c9
	ld l,c			;b0ca
	or a			;b0cb
	sbc hl,de		;b0cc
	push hl			;b0ce   ; y ahora la del segundo, con la resta al reves
	ld a,h			;b0cf
	cpl			;b0d0
	ld h,a			;b0d1
	ld a,l			;b0d2
	cpl			;b0d3
	ld l,a			;b0d4
	inc hl			;b0d5
	sra h		;b0d6
	rr l		;b0d8
	sra h		;b0da
	rr l		;b0dc
	sra h		;b0de
	rr l		;b0e0
	add hl,de			;b0e2   ; el resultado se suma a la media
	exx			;b0e3
	pop bc			;b0e4
	pop hl			;b0e5
	pop de			;b0e6
	ret			;b0e7
L_B0E8:
	push ix		;b0e8   ; y aqui la velocidad del golpe se le copia a la pareja del objeto en la otra pantalla
	ld l,(ix+024h)		;b0ea
	ld h,(ix+025h)		;b0ed
	ld a,h			;b0f0
	or l			;b0f1
	jr z,L_B10F		;b0f2
	ld e,(ix+007h)		;b0f4   ; las dos velocidades del objeto
	ld d,(ix+008h)		;b0f7
	ld c,(ix+00ah)		;b0fa
	ld b,(ix+00bh)		;b0fd
	push hl			;b100
	pop ix		;b101
	ld (ix+007h),e		;b103   ; y se escriben en su pareja de la otra pantalla
	ld (ix+008h),d		;b106
	ld (ix+00ah),c		;b109
	ld (ix+00bh),b		;b10c
L_B10F:
	ld l,(iy+024h)		;b10f   ; lo mismo para el otro
	ld h,(iy+025h)		;b112
	ld a,h			;b115
	or l			;b116
	jr z,L_B134		;b117
	ld e,(iy+007h)		;b119   ; lo mismo para el segundo
	ld d,(iy+008h)		;b11c
	ld c,(iy+00ah)		;b11f
	ld b,(iy+00bh)		;b122
	push hl			;b125
	pop ix		;b126
	ld (ix+007h),e		;b128
	ld (ix+008h),d		;b12b
	ld (ix+00ah),c		;b12e
	ld (ix+00bh),b		;b131
L_B134:
	pop ix		;b134
	ret			;b136
L_B137:
	ld e,(ix+00ah)		;b137   ; con los dos parados de lado, uno se aparta ocho pixeles
	ld d,(ix+00bh)		;b13a
	ld a,e			;b13d
	or d			;b13e
	ret nz			;b13f
	ld e,(iy+00ah)		;b140
	ld d,(iy+00bh)		;b143
	ld a,e			;b146
	or d			;b147
	ret nz			;b148
	ld a,(0ea70h)		;b149   ; y el bit 7 de EA70 decide hacia que lado
	bit 7,a		;b14c
	ld a,008h		;b14e
	jr z,L_B154		;b150
	neg		;b152
L_B154:
	ld (ix+00ch),a		;b154
	ret			;b157
L_B158:
	dec (iy+026h)		;b158   ; (iy+26) baja: el toque se va gastando
	ret nz			;b15b
L_B15C:
	push bc			;b15c   ; aqui se intercambian IX e IY para resolver el golpe desde el otro lado
	push ix		;b15d
	push iy		;b15f
	push ix		;b161
	pop hl			;b163
	push iy		;b164
	pop ix		;b166
	push hl			;b168
	pop iy		;b169
	call L_B559		;b16b
	ld e,(ix+024h)		;b16e
	ld d,(ix+025h)		;b171
	ld a,021h		;b174   ; el sonido 0x21 es el roce entre coches
	call 08674h		;b176
	ld a,d			;b179
	or e			;b17a
	jr z,L_B183		;b17b
	push de			;b17d   ; y si el objeto tiene pareja en la otra pantalla, se le hace lo mismo
	pop ix		;b17e
	call L_B559		;b180
L_B183:
	pop iy		;b183
	pop ix		;b185
	pop bc			;b187
	ret			;b188
L_B189:
	ld a,(0e1c2h)		;b189   ; con dos jugadores esto no corre: los puestos van por otro lado
	bit 5,a		;b18c
	ret nz			;b18e
	call L_B1D3		;b18f
	bit 7,(ix+029h)		;b192
	jr nz,L_B1BB		;b196
	call L_AEE0		;b198
	jr c,L_B1C1		;b19b
	ld b,(iy+071h)		;b19d
	ld a,(iy+030h)		;b1a0
	rra			;b1a3   ; tres bits de (iy+30): cuantos puestos vale el adelantamiento
	rra			;b1a4
	rra			;b1a5
	and 007h		;b1a6
	bit 2,(iy+030h)		;b1a8
	jr z,L_B1AF		;b1ac
	inc a			;b1ae
L_B1AF:
	dec b			;b1af   ; y no se sube por encima de lo que ya tiene el de delante
	cp b			;b1b0
	ret nc			;b1b1
	bit 6,(ix+030h)		;b1b2
	ret nz			;b1b6
	ld (iy+071h),b		;b1b7
	ret			;b1ba
L_B1BB:
	call L_AEE0		;b1bb
	jr c,L_B1CE		;b1be
	ret			;b1c0
L_B1C1:
	res 2,(iy+030h)		;b1c1   ; el rival adelantado baja un puesto, sin llegar a cero
	ld a,(iy+071h)		;b1c5
	dec a			;b1c8
	ret z			;b1c9
	ld (iy+071h),a		;b1ca
	ret			;b1cd
L_B1CE:
	res 2,(iy+030h)		;b1ce
	ret			;b1d2
L_B1D3:
	push ix		;b1d3   ; antes de recolocar se repasan los cinco rivales para saber cuantos van delante y cuantos detras
	set 3,(ix+030h)		;b1d5
	ld a,(iy+030h)		;b1d9   ; se limpian los bits de cuenta antes de recontar
	and 0c7h		;b1dc
	ld (iy+030h),a		;b1de
	ld a,(iy+05eh)		;b1e1
	and 0c7h		;b1e4
	ld (iy+05eh),a		;b1e6
	ld ix,0e800h		;b1e9
	ld de,00038h		;b1ed
	ld b,005h		;b1f0
L_B1F2:
	ld a,(ix+000h)		;b1f2
	and a			;b1f5
	jr z,L_B23F		;b1f6
	cp 00fh		;b1f8   ; el tipo 15 no cuenta, ni los que tienen algo en el nibble alto
	jr z,L_B23F		;b1fa
	and 070h		;b1fc
	jr nz,L_B23F		;b1fe
	bit 3,(ix+030h)		;b200
	jr nz,L_B23F		;b204
	call L_AEE0		;b206
	jr c,L_B23F		;b209
	bit 6,(ix+030h)		;b20b
	jr nz,L_B23F		;b20f
	ld a,(iy+004h)		;b211   ; y se reparten en dos cuentas segun vayan por delante o por detras
	cp (ix+004h)		;b214
	jr nc,L_B22D		;b217
	bit 7,(ix+030h)		;b219
	jr nz,L_B225		;b21d
	bit 2,(ix+030h)		;b21f
	jr nz,L_B23F		;b223
L_B225:
	push iy		;b225
	pop hl			;b227
	call MAS_UNO_DETRAS		;b228
	jr L_B23F		;b22b
L_B22D:
	bit 7,(ix+030h)		;b22d
	jr nz,L_B239		;b231
	bit 2,(ix+030h)		;b233
	jr z,L_B23F		;b237
L_B239:
	push iy		;b239
	pop hl			;b23b
	call MAS_UNO_DELANTE		;b23c
L_B23F:
	res 3,(ix+030h)		;b23f
	add ix,de		;b243
	djnz L_B1F2		;b245
	pop ix		;b247
	ret			;b249
L_B24A:
	exx			;b24a   ; el desgaste del golpe sale de la diferencia de velocidades entre cuatro, mas uno
	ld e,(ix+010h)		;b24b
	ld d,(ix+011h)		;b24e
	ld l,(iy+010h)		;b251
	ld h,(iy+011h)		;b254
	or a			;b257
	sbc hl,de		;b258
	call c,04b04h		;b25a   ; la diferencia en valor absoluto
	ld a,h			;b25d
	srl a		;b25e
	srl a		;b260
	inc a			;b262
	exx			;b263
	ret			;b264
L_B265:
	ld a,(ix+000h)		;b265   ; el golpe tambien mueve el angulo: cuatro grados por un lado y ocho por el otro
	or a			;b268
	jr z,L_B291		;b269
	ld a,(iy+000h)		;b26b   ; con los dos siendo objetos, el reparto es otro
	or a			;b26e
	jr nz,L_B2C7		;b26f
	call L_B291		;b271
	bit 7,d		;b274
	ld a,004h		;b276
	jr nz,L_B27C		;b278
	neg		;b27a
L_B27C:
	add a,(ix+00ch)		;b27c
	ld (ix+00ch),a		;b27f
	bit 7,b		;b282   ; el segundo giro, de ocho grados
	ld a,008h		;b284
	jr nz,L_B28A		;b286
	neg		;b288
L_B28A:
	add a,(ix+00ch)		;b28a
	ld (ix+00ch),a		;b28d
	ret			;b290
L_B291:
	ld h,(ix+004h)		;b291   ; y separa a los dos por su eje largo, restando dos veces
	ld l,(ix+003h)		;b294
	or a			;b297
	sbc hl,de		;b298
	or a			;b29a
	sbc hl,de		;b29b   ; la segunda resta: el desplazamiento es el doble
	call L_B2B9		;b29d
	ld (ix+004h),h		;b2a0
	ld (ix+003h),l		;b2a3
	ld h,(iy+004h)		;b2a6   ; y al otro coche se le hace lo mismo en sentido contrario
	ld l,(iy+003h)		;b2a9
	or a			;b2ac
	sbc hl,bc		;b2ad
	or a			;b2af
	sbc hl,bc		;b2b0
	ld (iy+004h),h		;b2b2
	ld (iy+003h),l		;b2b5
	ret			;b2b8
L_B2B9:
	ld a,(iy+000h)		;b2b9   ; con un rival rapido la separacion es de tres restas y no de dos
	and 00fh		;b2bc
	sub 008h		;b2be
	cp 002h		;b2c0
	ret nc			;b2c2
	or a			;b2c3
	sbc hl,de		;b2c4
	ret			;b2c6
L_B2C7:
	call L_B291		;b2c7   ; cuando los dos son objetos, las velocidades se promedian: se quedan casi iguales
	ld b,(ix+011h)		;b2ca
	ld c,(ix+010h)		;b2cd
	ld d,(iy+011h)		;b2d0
	ld e,(iy+010h)		;b2d3
	ld h,b			;b2d6
	ld l,c			;b2d7
	add hl,de			;b2d8   ; la media de las dos...
	sra h		;b2d9
	rr l		;b2db
	ex de,hl			;b2dd
	add hl,de			;b2de   ; ...y luego cada uno se acerca a la media a medias
	sra h		;b2df
	rr l		;b2e1
	ld (iy+011h),h		;b2e3
	ld (iy+010h),l		;b2e6
	ex de,hl			;b2e9
	add hl,bc			;b2ea
	sra h		;b2eb
	rr l		;b2ed
	ld (ix+011h),h		;b2ef
	ld (ix+010h),l		;b2f2
	ret			;b2f5
L_B2F6:
	ld h,(ix+006h)		;b2f6   ; y por el eje corto, el mismo reparto
	ld l,(ix+005h)		;b2f9
	or a			;b2fc   ; dos restas: la separacion por el eje corto
	sbc hl,de		;b2fd
	or a			;b2ff
	sbc hl,de		;b300
	call L_B2B9		;b302
	ld (ix+006h),h		;b305
	ld (ix+005h),l		;b308
	ld h,(iy+006h)		;b30b   ; y al otro se le suma lo mismo por el lado contrario
	ld l,(iy+005h)		;b30e
	or a			;b311
	sbc hl,bc		;b312
	or a			;b314
	sbc hl,bc		;b315
	ld (iy+006h),h		;b317
	ld (iy+005h),l		;b31a
	ld a,(ix+000h)		;b31d
	or a			;b320
	ld hl,00810h		;b321   ; el giro del golpe es mayor si el que lo recibe es el coche del jugador (8 y 16) que si es un rival (3 y 3)
	jr z,L_B329		;b324
	ld hl,00303h		;b326
L_B329:
	bit 7,d		;b329
	ld a,h			;b32b
	jr nz,L_B330		;b32c
	neg		;b32e
L_B330:
	add a,(ix+00ch)		;b330
	ld (ix+00ch),a		;b333
	bit 7,b		;b336   ; y el segundo, con el otro valor de la pareja
	ld a,l			;b338
	jr nz,L_B33D		;b339
	neg		;b33b
L_B33D:
	add a,(ix+00ch)		;b33d
	ld (ix+00ch),a		;b340
	ret			;b343
L_B344:
	push hl			;b344   ; el bit 6 de E1C2 dice si hay jugador 1
	ld hl,0e1c2h		;b345
	bit 6,(hl)		;b348
	pop hl			;b34a
	jr nz,L_B365		;b34b
	jr L_B368		;b34d
L_B34F:
	ld e,080h		;b34f   ; por aqui se entra con la fila ya puesta
	jr L_B362		;b351
L_B353:
	ld a,(0e1c3h)		;b353   ; el rival mira la pista un fotograma de cada dos, y a cada uno le toca uno
	add a,(ix+009h)		;b356
	and 001h		;b359
	ret nz			;b35b
	ld a,(ix+004h)		;b35c
	sub 018h		;b35f   ; veinticuatro pixeles por delante del coche
	ld e,a			;b361
L_B362:
	call 04adch		;b362
L_B365:
	xor a			;b365
	ld c,000h		;b366
L_B368:
	cp (hl)			;b368   ; cuatro casillas de la fila, de dos en dos columnas y con la vuelta del `res 6,l`
	call nz,L_B387		;b369
	inc l			;b36c   ; dos columnas de separacion y la vuelta con `res 6,l`
	inc l			;b36d
	res 6,l		;b36e
	cp (hl)			;b370
	call nz,L_B387		;b371
	inc l			;b374
	inc l			;b375
	res 6,l		;b376
	cp (hl)			;b378
	call nz,L_B387		;b379
	inc l			;b37c   ; la tercera casilla
	inc l			;b37d
	res 6,l		;b37e
	cp (hl)			;b380
	call nz,L_B387		;b381
	ld a,c			;b384
	scf			;b385
	ret			;b386
L_B387:
	ld a,c			;b387   ; la primera casilla que no coincida se queda como candidata
	or a			;b388
	jr nz,L_B38E		;b389
	ld c,(hl)			;b38b
	xor a			;b38c
	ret			;b38d
L_B38E:
	call L_B394		;b38e
	ld c,a			;b391
	xor a			;b392
	ret			;b393
L_B394:
	ld b,a			;b394   ; los tiles 0xC0, 0xC6 y 0xC7 mandan sobre los demas: si sale uno de ellos, es el que cuenta
	ld a,0c0h		;b395
	cp b			;b397
	ret z			;b398
	cp c			;b399
	ret z			;b39a
	ld a,0c6h		;b39b   ; los tres tiles que mandan son el 0xC0, el 0xC6 y el 0xC7
	cp b			;b39d
	ret z			;b39e
	cp c			;b39f
	ret z			;b3a0
	ld a,0c7h		;b3a1   ; y el ultimo de ellos
	cp b			;b3a3
	ret z			;b3a4
	cp c			;b3a5
	ret z			;b3a6
	ld a,c			;b3a7
	ret			;b3a8
L_B3A9:
	xor a			;b3a9   ; la lectura del teclado para escribir la contrasena, linea por linea de la matriz
	ld d,a			;b3aa
	ld e,030h		;b3ab
	call L_B418		;b3ad
	ld a,001h		;b3b0
	call 00141h		;b3b2   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | la linea 1 son los digitos y las dos primeras letras
	cpl			;b3b5
	and 003h		;b3b6
	jr z,L_B3C2		;b3b8
	cp 003h		;b3ba
	jr nz,L_B3BF		;b3bc
	dec a			;b3be
L_B3BF:
	add a,037h		;b3bf
	ld e,a			;b3c1
L_B3C2:
	ld a,002h		;b3c2
	call 00141h		;b3c4   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | la linea 2 son las letras siguientes
	cpl			;b3c7
	rla			;b3c8
	rla			;b3c9
	rla			;b3ca
	and 003h		;b3cb   ; tres rotaciones para llegar a los bits que interesan
	jr z,L_B3D7		;b3cd
	cp 003h		;b3cf
	jr nz,L_B3D4		;b3d1
	dec a			;b3d3
L_B3D4:
	add a,040h		;b3d4
	ld e,a			;b3d6
L_B3D7:
	ld a,003h		;b3d7
	ld d,e			;b3d9
	ld e,043h		;b3da
	call L_B418		;b3dc   ; la linea 3 son mas letras
	ld a,004h		;b3df
	ld d,e			;b3e1
	ld e,04bh		;b3e2
	call L_B418		;b3e4   ; la 4 y la 5, el resto del abecedario
	ld a,005h		;b3e7
	ld d,e			;b3e9
	ld e,053h		;b3ea
	call L_B418		;b3ec
	ld a,007h		;b3ef
	call 00141h		;b3f1   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | la linea 7 trae el intro y el borrado
	rla			;b3f4
	jr c,L_B3F9		;b3f5
	ld e,00dh		;b3f7
L_B3F9:
	rla			;b3f9
	rla			;b3fa
	jr c,L_B3FF		;b3fb
	ld e,008h		;b3fd
L_B3FF:
	ld a,008h		;b3ff   ; y la 8 el espacio
	call 00141h		;b401   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;b404
	jr c,L_B409		;b405
	ld e,020h		;b407
L_B409:
	ld a,(0e243h)		;b409   ; la tecla se guarda en E243, y solo cuenta si es distinta de la de antes: eso es el flanco
	ld d,a			;b40c
	ld a,e			;b40d
	ld (0e243h),a		;b40e
	and a			;b411
	jr z,L_B416		;b412
	cp d			;b414
	ret nz			;b415
L_B416:
	scf			;b416
	ret			;b417
L_B418:
	call 00141h		;b418   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix | ocho bits por linea, y el primero que este pulsado gana
	cpl			;b41b
	ld b,008h		;b41c
L_B41E:
	rra			;b41e
	ret c			;b41f
	inc e			;b420
	djnz L_B41E		;b421
	ld e,d			;b423
	ret			;b424   ; y si ninguna tecla de la linea vale, se devuelve la de antes
L_B425:
	ld ix,0e2c0h		;b425   ; el bloque de sombra del coche 2 se rellena con la posicion del 1: la escena y el reloj lo usan de referencia
	ld iy,0e380h		;b429
	ld a,(ix+006h)		;b42d
	ld (iy+006h),a		;b430
	ld a,(ix+004h)		;b433
	ld (iy+004h),a		;b436
	ld l,(ix+03fh)		;b439
	ld h,(ix+040h)		;b43c
	add hl,hl			;b43f   ; la posicion por cuatro
	add hl,hl			;b440
	ld (iy+03fh),l		;b441
	ld (iy+040h),h		;b444
	ld (iy+009h),002h		;b447   ; y (iy+9) = 2 manda el dibujo al buffer de EC00
	ret			;b44b
L_B44C:
	call L_B425		;b44c   ; solo con la repeticion en marcha (E244 >= 2) se pinta el objeto de tiles del coche
	ld iy,0e2c0h		;b44f
	ld a,(0e244h)		;b453
	cp 002h		;b456
	ret c			;b458
	ld de,0e928h		;b459
	ld ix,0e2c0h		;b45c
	jp L_B49E		;b460
L_B463:
	ld ix,0e3d8h		;b463   ; las tres fichas de E3D8 -los rivales de boxes- pintadas como objetos de tiles
	ld b,003h		;b467
	exx			;b469
	ld de,0e947h		;b46a
	exx			;b46d
L_B46E:
	ld a,(ix+000h)		;b46e
	and a			;b471
	jr z,L_B496		;b472
	call L_B4D5		;b474   ; la ficha que no se pinta se salta
	jr c,L_B496		;b477
	ld iy,0e380h		;b479
	call 04a9dh		;b47d   ; la casilla se calcula con el bloque de sombra y luego se devuelve el bueno
	ld iy,0e2c0h		;b480
	ld a,l			;b484
	exx			;b485
	ld l,a			;b486
	ld (de),a			;b487
	inc de			;b488
	exx			;b489
	ld a,h			;b48a   ; los dos bytes de la casilla se guardan en el juego alterno y en la lista
	exx			;b48b
	ld h,a			;b48c
	ld (de),a			;b48d
	inc de			;b48e
	ld a,(ix+002h)		;b48f
	call L_B4B7		;b492
	exx			;b495
L_B496:
	ld de,00008h		;b496   ; ocho bytes de una ficha a la siguiente
	add ix,de		;b499
	djnz L_B46E		;b49b
	ret			;b49d
L_B49E:
	push de			;b49e   ; 0x4080 es fila 8, columna 16: donde va el objeto del coche en la repeticion
	ld de,04080h		;b49f
	ld iy,0e380h		;b4a2
	call 04a9dh		;b4a6
	ld iy,0e2c0h		;b4a9
	pop de			;b4ad
L_B4AE:
	ld a,l			;b4ae   ; la entrada del objeto de tiles: destino, destino y variante
	ld (de),a			;b4af
	inc de			;b4b0
	ld a,h			;b4b1
	ld (de),a			;b4b2
	inc de			;b4b3
	ld a,(ix+018h)		;b4b4
L_B4B7:
	sub 003h		;b4b7   ; el `sub 3` en bucle es un modulo 3: la carroceria se reduce a tres variantes de dibujo
	jr nc,L_B4B7		;b4b9
	add a,003h		;b4bb
	ld (de),a			;b4bd
	inc de			;b4be
	ld a,007h		;b4bf
L_B4C1:
	ldi		;b4c1   ; siete filas de cuatro tiles, con la vuelta del kilobyte
	ldi		;b4c3
	ldi		;b4c5
	ldi		;b4c7
	res 2,h		;b4c9   ; el bit 2 de H es la vuelta dentro del kilobyte
	ld bc,0001ch		;b4cb
	add hl,bc			;b4ce
	set 2,h		;b4cf
	dec a			;b4d1
	jr nz,L_B4C1		;b4d2
	ret			;b4d4
L_B4D5:
	ld a,(ix+001h)		;b4d5   ; solo las banderas entre 0x54 y 0x92 valen; el resto no se pinta
	sub 054h		;b4d8
	cp 03fh		;b4da
	ccf			;b4dc
	ret c			;b4dd
	sub 00ch		;b4de
	add a,a			;b4e0
	add a,a			;b4e1
	ld e,a			;b4e2
	ld d,070h		;b4e3   ; 0x70 en D: la plantilla de estos objetos vive en otro sitio
	or a			;b4e5
	ret			;b4e6
L_B4E7:
	set 7,(ix+001h)		;b4e7   ; el rival retirado: se frena solo y parpadea entre los colores 15 y 6
	call RESTA_OCTAVA_PARTE_A_DOS_PALABRAS		;b4eb
	ld a,(0e1c3h)		;b4ee
	and 003h		;b4f1   ; el color cambia uno de cada cuatro fotogramas
	ld a,00fh		;b4f3
	jr z,L_B4F9		;b4f5
	ld a,006h		;b4f7
L_B4F9:
	ld (ix+00fh),a		;b4f9
	ld a,(0e1c3h)		;b4fc   ; y cada ocho fotogramas se cuenta un paso mas
	and 007h		;b4ff
	ret nz			;b501
	ld a,(ix+027h)		;b502
	inc a			;b505   ; y a los tres pasos el objeto se quita del todo
	ld (ix+027h),a		;b506
	cp 003h		;b509
	jp nc,09e2dh		;b50b   ; a los tres pasos el objeto desaparece
	and 001h		;b50e
	ld l,a			;b510
	ld h,000h		;b511
	ld de,0b52ch		;b513
	add hl,de			;b516
	ld a,(hl)			;b517
	ld (ix+00eh),a		;b518
	ld (ix+033h),a		;b51b
	ld a,(ix+008h)		;b51e   ; parado del todo, el dibujo es otro (0xF8)
	or a			;b521
	ret nz			;b522
	ld (ix+00eh),0f8h		;b523
	ld (ix+033h),0f8h		;b527
	ret			;b52b

; ----------------------------------------------------------------------
; DATOS tabla_B52C: dos bytes (E8 F0) que 0xB513 escoge con el bit 0 de
;   (ix+27) y mete en (ix+0E) y (ix+33) (`ld de,0xB52C / add hl,de / ld
;   a,(hl)`)
;   0xb52c..0xb52e  (2 bytes)
DATA_tabla_B52C:
	defb 0e8h,0f0h	; b52c

; ======================================================================
; CODIGO 0xb52e..0xb6ec  (446 bytes)
; ======================================================================


RESTA_OCTAVA_PARTE_A_DOS_PALABRAS:		; resta a la palabra (ix+0A,0B) y a la (ix+07,08) su octava parte con signo (p00 0x4A8A = tres `sra h / rr l`)
	ld h,(ix+00bh)		;b52e   ; las dos palabras -vy y vx- pierden su octava parte: es el rozamiento del retirado
	ld l,(ix+00ah)		;b531
	ld d,h			;b534   ; la palabra se copia para poder dividirla sin perderla
	ld e,l			;b535
	call 04a8ah		;b536
	ex de,hl			;b539
	or a			;b53a
	sbc hl,de		;b53b
	ld (ix+00bh),h		;b53d
	ld (ix+00ah),l		;b540
	ld h,(ix+008h)		;b543   ; y ahora vx
	ld l,(ix+007h)		;b546
	ld d,h			;b549
	ld e,l			;b54a
	call 04a8ah		;b54b
	ex de,hl			;b54e
	or a			;b54f
	sbc hl,de		;b550
	ld (ix+008h),h		;b552
	ld (ix+007h),l		;b555
	ret			;b558
L_B559:
	ld a,(ix+000h)		;b559   ; aqui se retira un rival: el tipo pasa a 0x0F, que es el de "ya no corre"
	or a			;b55c
	ret z			;b55d
	and 00fh		;b55e
	sub 008h		;b560
	cp 002h		;b562
	call c,07ff6h		;b564   ; los rivales rapidos avisan a p01 antes de irse
	ld a,(iy+05ah)		;b567
	cp 0e0h		;b56a   ; si el coche no se ve en la otra pantalla, se quita sin mas
	jr nz,L_B574		;b56c
	bit 0,(ix+031h)		;b56e
	jr z,L_B590		;b572
L_B574:
	call L_B189		;b574
	ld (ix+000h),00fh		;b577
L_B57B:
	ld (ix+00fh),006h		;b57b
	ld (ix+027h),000h		;b57f   ; el contador de la retirada empieza a cero
	set 7,(ix+001h)		;b583   ; el retirado se marca con el bit 7 y se le da el dibujo de humo
	ld (ix+00eh),0e8h		;b587
	ld (ix+033h),0e8h		;b58b
	ret			;b58f
L_B590:
	push ix		;b590
	call 09e2dh		;b592
	pop ix		;b595
	ret			;b597
L_B598:
	ld (ix+006h),d		;b598   ; el rival nuevo se coloca donde diga DE y con las dos velocidades a cero
	ld (ix+004h),e		;b59b
	ld a,(iy+009h)		;b59e
	ld (ix+009h),a		;b5a1
	ld (ix+008h),000h		;b5a4
	ld (ix+007h),000h		;b5a8
	ld (ix+00bh),000h		;b5ac
	ld (ix+00ah),000h		;b5b0
	jr L_B57B		;b5b4
L_B5B6:
	ld a,(0e1c3h)		;b5b6   ; la tabla de EB00 del jugador se limpia un fotograma de cada dos
	xor (iy+009h)		;b5b9
	rrca			;b5bc
	ret nc			;b5bd
	bit 0,(iy+009h)		;b5be
	ld l,001h		;b5c2   ; el jugador 1 usa EB01 y el 2 EB81
	jr nz,L_B5C8		;b5c4
	ld l,081h		;b5c6
L_B5C8:
	ld h,0ebh		;b5c8
	ld b,020h		;b5ca
	xor a			;b5cc
L_B5CD:
	ld (hl),a			;b5cd   ; las 32 filas de la tabla, de dos en dos bytes
	inc l			;b5ce
	inc l			;b5cf
	djnz L_B5CD		;b5d0
	ret			;b5d2
L_B5D3:
	call L_B5E0		;b5d3   ; la reaccion del rival: la separacion que guarda y el volante
	ld a,(0e1c3h)		;b5d6
	xor (ix+009h)		;b5d9   ; a cada coche le toca un fotograma
	rrca			;b5dc
	ret nc			;b5dd
	jr L_B643		;b5de
L_B5E0:
	ld a,(ix+011h)		;b5e0   ; (ix+62) es la separacion que quiere guardar: 12 despacio, 8 a media y 4 rapido
	cp 004h		;b5e3
	ld d,00ch		;b5e5
	jr c,L_B5F5		;b5e7
	cp 008h		;b5e9
	ld d,008h		;b5eb
	jr c,L_B5F5		;b5ed
	ld d,004h		;b5ef
	ld (ix+049h),001h		;b5f1   ; y a partir de cierta velocidad se enciende (ix+49): ya ha cogido ritmo
L_B5F5:
	ld a,(ix+049h)		;b5f5
	or a			;b5f8
	jr z,L_B5FF		;b5f9
	ld (ix+062h),d		;b5fb
	ret			;b5fe
L_B5FF:
	ld (ix+062h),001h		;b5ff
	ret			;b603
L_B604:
	call L_B63A		;b604   ; (ix+34) es la correccion de trayectoria que se le acumula al objetivo
	ld a,(ix+034h)		;b607
	or a			;b60a
	jr z,L_B619		;b60b
	add a,(ix+015h)		;b60d
	ld (ix+015h),a		;b610
	ld (ix+02dh),001h		;b613   ; y (ix+2D) marca que se ha corregido en este paso
	scf			;b617
	ret			;b618
L_B619:
	ld a,(ix+02dh)		;b619   ; al dejar de corregir, la trayectoria se compara con la de partida
	or a			;b61c
	ret z			;b61d
	ld (ix+02dh),000h		;b61e
	ld a,(ix+015h)		;b622
	sub (ix+016h)		;b625
	ld b,a			;b628
	xor (ix+036h)		;b629   ; si el signo cambia, se reduce a un solo bit: la correccion se satura
	rlca			;b62c
	jr nc,L_B635		;b62d
	ld a,(ix+036h)		;b62f
	rlca			;b632
	sbc a,a			;b633
	ld b,a			;b634
L_B635:
	ld (ix+036h),b		;b635
	or a			;b638
	ret			;b639
L_B63A:
	ld a,(0e1c3h)		;b63a   ; un fotograma de cada dos por rival
	xor (ix+009h)		;b63d
	rrca			;b640
	jr c,L_B652		;b641
L_B643:
	bit 5,(ix+000h)		;b643   ; y el que tiene el bit 5 no se apunta en la tabla de filas
	ret nz			;b647
	call 04ad9h		;b648   ; el rival se apunta en la tabla de EB00 de su fila, para que los demas lo vean
	inc l			;b64b
	ld a,(ix+006h)		;b64c
	ld (hl),a			;b64f
	or a			;b650
	ret			;b651
L_B652:
	ld (ix+034h),000h		;b652   ; aqui se decide hacia donde tira el rival: mira su fila y las siete de delante
	ld a,(ix+004h)		;b656
	sub 044h		;b659   ; 0x44 pixeles por delante
	ld e,a			;b65b
	call 04adch		;b65c
	call L_B68B		;b65f
	ccf			;b662
	ret nc			;b663
	push bc			;b664
	call L_B899		;b665
	pop bc			;b668
	and c			;b669   ; el `and c` y el `xor 5` eligen el hueco por el que se va
	jr nz,L_B66F		;b66a
	ld a,c			;b66c
	xor 005h		;b66d
L_B66F:
	ld b,a			;b66f
	ld a,(ix+011h)		;b670   ; despacio la correccion se divide por ocho: los rivales lentos se mueven poco
	cp 006h		;b673
	ld a,(iy+062h)		;b675
	jr nc,L_B680		;b678
	sra a		;b67a
	sra a		;b67c
	sra a		;b67e
L_B680:
	rr b		;b680
	jr c,L_B686		;b682
	neg		;b684
L_B686:
	ld (ix+034h),a		;b686
	scf			;b689
	ret			;b68a
L_B68B:
	ld d,000h		;b68b   ; siete filas por delante, mirando la tabla de EB00
	inc l			;b68d
	ld c,000h		;b68e
	ld b,007h		;b690
L_B692:
	ld a,(hl)			;b692
	or a			;b693
	call nz,L_B6A6		;b694
	inc l			;b697   ; dos columnas y la vuelta dentro de la fila
	res 6,l		;b698
	inc l			;b69a
	djnz L_B692		;b69b
	ld a,d			;b69d   ; con tres o mas coches por delante ya no hay hueco
	cp 003h		;b69e
	ccf			;b6a0
	ret c			;b6a1
	ld a,c			;b6a2
	cp 001h		;b6a3
	ret			;b6a5
L_B6A6:
	inc d			;b6a6   ; catorce pixeles de margen a cada lado para considerar que estorba
	sub (ix+015h)		;b6a7
	add a,00eh		;b6aa
	cp 01dh		;b6ac
	ret nc			;b6ae
	sub 00eh		;b6af
	ld c,004h		;b6b1
	ret p			;b6b3
	ld c,001h		;b6b4
	ret			;b6b6
L_B6B7:
	ld c,000h		;b6b7
L_B6B9:
	ld a,(ix+00ch)		;b6b9   ; el volante del rival sale de una tabla indexada por su angulo
	neg		;b6bc
	add a,030h		;b6be
	ld e,a			;b6c0
	ld d,000h		;b6c1
	add hl,de			;b6c3
	ld hl,0b6ech		;b6c4
	add hl,de			;b6c7
	ld h,(hl)			;b6c8
	ld a,(ix+006h)		;b6c9
	sub c			;b6cc
	add a,h			;b6cd
	sub (ix+015h)		;b6ce
	cp 080h		;b6d1   ; el resultado se compara con 0x80 para saber el signo
	rr l		;b6d3
	add a,002h		;b6d5
	cp 005h		;b6d7   ; y con menos de cinco pixeles de desvio el volante se queda a cero
	jr c,L_B6E7		;b6d9
	rl l		;b6db
	ld a,003h		;b6dd
	jr c,L_B6E3		;b6df
	neg		;b6e1
L_B6E3:
	ld (ix+013h),a		;b6e3
	ret			;b6e6
L_B6E7:
	ld (ix+013h),000h		;b6e7
	ret			;b6eb

; ----------------------------------------------------------------------
; DATOS tabla_B6EC: tabla de bytes que crece de 0xC8 a 0x37 (dando la vuelta);
;   0xB6C4 la lee con el indice 0x30 - (ix+0C) (`ld hl,0xB6EC / add hl,de / ld
;   h,(hl)`) y usa el valor para decidir (ix+13)
;   0xb6ec..0xb74d  (97 bytes)
DATA_tabla_B6EC:
	defb 0c8h,0c8h,0c8h,0c8h,0c8h,0c8h,0c9h,0c9h,0c9h,0cah,0cah,0cah,0cch,0cch,0cdh,0cdh	; b6ec  ................
	defb 0ceh,0cfh,0d1h,0d2h,0d3h,0d3h,0d4h,0d5h,0d8h,0d9h,0dah,0dbh,0dch,0ddh,0e0h,0e2h	; b6fc  ................
	defb 0e3h,0e4h,0e5h,0e6h,0eah,0ebh,0edh,0eeh,0efh,0f1h,0f5h,0f6h,0f7h,0f9h,0fah,0fbh	; b70c  ................
	defb 000h,001h,002h,004h,005h,006h,00ah,00ch,00dh,00eh,010h,011h,015h,016h,017h,019h	; b71c  ................
	defb 01ah,01bh,01fh,020h,021h,022h,023h,024h,027h,028h,029h,02ah,02bh,02ch,02eh,02fh	; b72c  ... !"#$'()*+,./
	defb 030h,030h,031h,032h,033h,034h,034h,035h,035h,035h,036h,037h,037h,037h,037h,037h	; b73c  0012344555677777
	defb 037h	; b74c

; ======================================================================
; CODIGO 0xb74d..0xb82f  (226 bytes)
; ======================================================================


L_B74D:
	call L_B604		;b74d   ; los rivales adelantan uno de cada cuatro turnos
	ret c			;b750
	ld a,(ix+017h)		;b751   ; uno de cada cuatro turnos
	and 003h		;b754
	call z,L_B75C		;b756
	jp L_B789		;b759
L_B75C:
	ld a,(ix+002h)		;b75c
	or a			;b75f
	ret nz			;b760
	ld a,(0e1c3h)		;b761   ; y solo uno de cada 32 fotogramas
	and 01ch		;b764
	ret nz			;b766
	ld a,(ix+004h)		;b767
	add a,050h		;b76a   ; 0x50 pixeles de margen para plantearse el adelantamiento
	sub (iy+004h)		;b76c
	cp 050h		;b76f
	ret nc			;b771
	ld a,(iy+006h)		;b772
	sub (ix+015h)		;b775
	sbc a,a			;b778   ; el `sbc a,a` convierte el signo en 0 o 0xFF, y de ahi salen los ocho pixeles a un lado o a otro
	add a,a			;b779
	add a,a			;b77a
	add a,a			;b77b
	add a,004h		;b77c
	add a,(ix+015h)		;b77e
	ld (ix+015h),a		;b781
	ret			;b784
L_B785:
	ld a,001h		;b785   ; EA7F reparte: 1 desde aqui y 0 desde 0xB789
	jr L_B78B		;b787
L_B789:
	ld a,000h		;b789
L_B78B:
	ld (0ea7fh),a		;b78b
	ld a,(ix+002h)		;b78e   ; (ix+2) dice de que tabla se saca la correccion: 0, 1 o 2
	and 00fh		;b791
	dec a			;b793
	jr z,L_B79E		;b794
	jp p,L_B7B1		;b796
	ld hl,0b82fh		;b799
	jr L_B7C4		;b79c
L_B79E:
	ld hl,0b83fh		;b79e   ; con el bit 4 de (ix+17) el rival cambia de lado y vuelve
	call L_B7C4		;b7a1
	ld a,(ix+017h)		;b7a4
	and 010h		;b7a7
	cp 010h		;b7a9
	ret nz			;b7ab
	ld (ix+002h),002h		;b7ac
	ret			;b7b0
L_B7B1:
	ld hl,0b837h		;b7b1   ; la tercera tabla de correccion
	call L_B7C4		;b7b4
	ld a,(ix+017h)		;b7b7
	and 010h		;b7ba
	cp 010h		;b7bc
	ret nz			;b7be
	ld (ix+002h),001h		;b7bf
	ret			;b7c3
L_B7C4:
	push hl			;b7c4   ; se miran tres casillas por delante y de ahi salen tres bits: por donde hay sitio
	ld a,0c8h		;b7c5
	add a,(ix+004h)		;b7c7
	ld e,a			;b7ca
	ld d,(ix+015h)		;b7cb
	call L_B89F		;b7ce
	ld e,a			;b7d1
	ld d,000h		;b7d2
	pop hl			;b7d4
	add hl,de			;b7d5
	ld a,(hl)			;b7d6   ; la tabla convierte esos tres bits en cuanto se desvia
	ld d,a			;b7d7
	add a,(ix+015h)		;b7d8
	ld (ix+015h),a		;b7db
	bit 1,e		;b7de   ; y si el bit 1 esta apagado, ademas se le quita la correccion acumulada
	jr nz,L_B7E8		;b7e0
	sub (ix+034h)		;b7e2
	ld (ix+015h),a		;b7e5
L_B7E8:
	ld a,(0ea7fh)		;b7e8
	dec a			;b7eb
	jr nz,L_B7F4		;b7ec
	ld a,(ix+017h)		;b7ee   ; y solo cuando el turno lo permite
	and 003h		;b7f1
	ret nz			;b7f3
L_B7F4:
	ld a,(ix+034h)		;b7f4
	and a			;b7f7
	ret nz			;b7f8
	ld a,e			;b7f9   ; con los tres bits a 7 -todo libre- el rival vuelve poco a poco a su carril
	cp 007h		;b7fa
	ret nz			;b7fc
	bit 7,(ix+036h)		;b7fd
	jr z,L_B816		;b801
	ld a,(ix+015h)		;b803   ; y segun el signo de (ix+36), vuelve por un lado o por el otro
	sub (ix+016h)		;b806
	ld d,0feh		;b809
	jr nc,L_B827		;b80b
	cp (ix+036h)		;b80d
	jr nc,L_B827		;b810
	ld d,002h		;b812
	jr L_B827		;b814
L_B816:
	ld a,(ix+015h)		;b816
	sub (ix+016h)		;b819
	ld d,001h		;b81c   ; el signo decide si se vuelve por un lado o por el otro
	jr c,L_B827		;b81e
	cp (ix+036h)		;b820
	jr c,L_B827		;b823
	ld d,0ffh		;b825
L_B827:
	ld a,(ix+015h)		;b827
	add a,d			;b82a
	ld (ix+015h),a		;b82b
	ret			;b82e

; ----------------------------------------------------------------------
; DATOS tablas_B82F: tres filas de 8 bytes; las escogen 0xB79A (0xB82F),
;   0xB79F/0xB851 (0xB83F) y 0xB7B2/0xB848/0xB9FD (0xB837), y de cada una
;   0xB85D coge el byte de indice A y lo suma a (ix+16)
;   0xb82f..0xb847  (24 bytes)
DATA_tablas_B82F:
	defb 00ch,00ch,000h,006h,0f4h,00ch,0fah,000h	; b82f  ........
	defb 0f4h,00ch,000h,000h,0f4h,0f4h,0fah,0feh	; b837  ........
	defb 00ch,00ch,000h,006h,0f4h,00ch,000h,002h	; b83f  ........

; ======================================================================
; CODIGO 0xb847..0xbb0d  (710 bytes)
; ======================================================================


L_B847:
	ld hl,0b837h		;b847   ; la misma faena para el otro objetivo, el de (ix+16)
	bit 7,(ix+036h)		;b84a
	jr z,L_B853		;b84e
	ld hl,0b83fh		;b850
L_B853:
	push hl			;b853
	ld a,0c8h		;b854
	add a,(ix+004h)		;b856
	ld e,a			;b859   ; 0xC8 pixeles por delante del coche
	ld d,(ix+016h)		;b85a
	call L_B89F		;b85d
	ld e,a			;b860
	ld d,000h		;b861
	pop hl			;b863
	add hl,de			;b864
	ld a,(hl)			;b865   ; y de la tabla sale cuanto se corrige
	add a,(ix+016h)		;b866
	ld (ix+016h),a		;b869
	ret			;b86c
L_B86D:
	ld a,(ix+017h)		;b86d   ; las dos rutinas de aqui son gemelas y opuestas: una manda al rival a la izquierda y la otra a la derecha
	and 03ch		;b870
	cp 030h		;b872
	ret nc			;b874
	and 00ch		;b875
	cp 008h		;b877
	jr z,L_B894		;b879
	cp 004h		;b87b
	ret nz			;b87d
	jr L_B88F		;b87e
L_B880:
	ld a,(ix+017h)		;b880
	and 03ch		;b883   ; el mismo reparto que su gemela, pero al reves
	cp 030h		;b885
	ret nc			;b887
	cp 004h		;b888
	jr z,L_B894		;b88a
	cp 008h		;b88c
	ret nz			;b88e
L_B88F:
	ld (ix+002h),001h		;b88f
	ret			;b893
L_B894:
	ld (ix+002h),002h		;b894
	ret			;b898
L_B899:
	ld d,(ix+006h)		;b899   ; tres casillas de la fila, separadas tres columnas, 0x18 pixeles por delante
	ld e,(ix+004h)		;b89c
L_B89F:
	ld a,d			;b89f
	sub 018h		;b8a0
	ld d,a			;b8a2
	call 04a9dh		;b8a3
	ld a,(0e26ch)		;b8a6   ; E26C y E272 marcan otra vez el rango de la calzada
	ld d,a			;b8a9
	ld a,(0e272h)		;b8aa
	sub d			;b8ad
	ld e,a			;b8ae
	ld a,l			;b8af   ; la fila se recorta al principio para no salirse de ella
	and 0e0h		;b8b0
	ld b,a			;b8b2
	ld a,(hl)			;b8b3
	sub d			;b8b4
	cp e			;b8b5
	rl c		;b8b6   ; el `rl c` va juntando los tres bits, uno por casilla
	ld a,l			;b8b8
	add a,003h		;b8b9   ; tres columnas de separacion entre las casillas que se miran
	and 01fh		;b8bb
	or b			;b8bd
	ld l,a			;b8be
	ld a,(hl)			;b8bf
	sub d			;b8c0
	cp e			;b8c1
	rl c		;b8c2
	ld a,l			;b8c4
	add a,003h		;b8c5   ; y otras tres para la tercera
	and 01fh		;b8c7
	or b			;b8c9
	ld l,a			;b8ca
	ld a,(hl)			;b8cb
	sub d			;b8cc
	cp e			;b8cd
	rl c		;b8ce
	ld a,c			;b8d0
	and 007h		;b8d1
	ret			;b8d3
L_B8D4:
	ld d,(ix+006h)		;b8d4   ; la misma prueba, pero solo 0x10 pixeles por delante
	ld e,(ix+004h)		;b8d7
	ld a,d			;b8da
	sub 010h		;b8db   ; 0x10 pixeles por delante en vez de 0x18
	ld d,a			;b8dd
	call 04a9dh		;b8de
	ld a,(0e26ch)		;b8e1
	ld d,a			;b8e4
	ld a,(0e272h)		;b8e5
	sub d			;b8e8
	ld e,a			;b8e9
	ld a,(hl)			;b8ea   ; aqui las tres casillas van seguidas, no separadas
	inc hl			;b8eb
	sub d			;b8ec
	cp e			;b8ed
	rl c		;b8ee
	ld a,(hl)			;b8f0
	inc hl			;b8f1
	sub d			;b8f2
	cp e			;b8f3
	rl c		;b8f4
	ld a,(hl)			;b8f6
	sub d			;b8f7
	cp e			;b8f8
	rl c		;b8f9
	ld a,c			;b8fb
	and 007h		;b8fc
	ret			;b8fe
PON_IX15_CASILLA_ATRAS:		; 0xB917, luego E = 0xC8, BUSCA_CASILLA_ATRAS y (ix+15) = D
	call PON_IX16_SEGUN_SENTIDO		;b8ff
	ld e,0c8h		;b902
	call BUSCA_CASILLA_ATRAS		;b904
	ld (ix+015h),d		;b907
	ret			;b90a
PON_IX15_CASILLA_ADELANTE:		; la gemela de 0xB8FF con BUSCA_CASILLA_ADELANTE
	call PON_IX16_SEGUN_SENTIDO		;b90b
	ld e,0c8h		;b90e
	call BUSCA_CASILLA_ADELANTE		;b910
	ld (ix+015h),d		;b913
	ret			;b916
PON_IX16_SEGUN_SENTIDO:		; E = 0xC8; con el bit 7 de (ix+36) escoge BUSCA_CASILLA_ATRAS o BUSCA_CASILLA_ADELANTE y mete D en (ix+16)
	ld e,0c8h		;b917
	bit 7,(ix+036h)		;b919   ; el bit 7 de (ix+36) dice por que borde busca
	jr nz,L_B926		;b91d
	call BUSCA_CASILLA_ADELANTE		;b91f
	ld (ix+016h),d		;b922
	ret			;b925
L_B926:
	call BUSCA_CASILLA_ATRAS		;b926
	ld (ix+016h),d		;b929
	ret			;b92c

; ----------------------------------------------------------------------
; LAS NUEVE RUTINAS DE TIPO DE RIVAL, una por entrada de la tabla
; de p02 0x9F53. Todas siguen el mismo molde: ajustar el carril con
; 0xB847, decidir el desvio (0xB604 y el reparto por (ix+17)) y por
; ultimo el volante (0xB6B7). Lo que cambia de una a otra es
; cuantas columnas se meten desde el borde -(EA7D): 1, 4, 2, 5 o
; 1- y que dibujo lleva el rival ((ix+18)).
; ----------------------------------------------------------------------
L_B92D:
	bit 1,(ix+030h)		;b92d   ; el bit 1 de (ix+30) marca al rival ya colocado
	jr nz,L_B951		;b931
	bit 7,(ix+000h)		;b933   ; el bit 7 del tipo dice si es de los rapidos: los lentos se aparcan en x = 0
	ld a,000h		;b937
	jp nz,L_B95A		;b939
	jr L_B94D		;b93c
L_B93E:
	bit 1,(ix+030h)		;b93e
	jr nz,L_B951		;b942
	bit 7,(ix+000h)		;b944
	ld a,0bfh		;b948   ; y los rapidos en 0xBF, o sea por detras
	jp z,L_B95A		;b94a
L_B94D:
	set 1,(ix+030h)		;b94d
L_B951:
	call L_B847		;b951
	call L_B960		;b954
	jp L_B6B7		;b957
L_B95A:
	ld (ix+004h),a		;b95a   ; el rival que no cabe se quita de la lista
	jp 09e2dh		;b95d
L_B960:
	call L_B604		;b960   ; el molde: desvio y adelantamiento
	ret c			;b963   ; con acarreo el desvio ya esta hecho
	ld a,(ix+017h)		;b964
	and 003h		;b967
	call z,L_B75C		;b969
	jp L_B785		;b96c
L_B96F:
	call AJUSTA_ATRAS_Y_MARCA		;b96f   ; este tipo va con el color 12
	ld (ix+00fh),00ch		;b972
	ret			;b976
L_B977:
	ld a,00ah		;b977   ; y este ademas avisa a p02 con E209 = 10
	ld (0e209h),a		;b979
	call AJUSTA_ATRAS_Y_MARCA		;b97c
	ld (ix+00fh),004h		;b97f
	jp 080f4h		;b983
AJUSTA_ATRAS_Y_MARCA:		; (EA7D) = 1, AJUSTA_CON_CASILLA_ATRAS, 0xB996 y (ix+18) = 0
	ld a,001h		;b986   ; EA7D = 1: se pega al borde
	ld (0ea7dh),a		;b988
	call AJUSTA_CON_CASILLA_ATRAS		;b98b   ; EA7D ya esta puesto: se busca el borde y se ajusta
	call PON_IX02_A_1		;b98e
	ld (ix+018h),000h		;b991
	ret			;b995
PON_IX02_A_1:		; `ld (ix+02),1 / ret`
	ld (ix+002h),001h		;b996   ; (ix+2) = 1 fija por que tabla de desvio va
	ret			;b99a
L_B99B:
	call L_B847		;b99b
	call L_B9A4		;b99e
	jp L_B6B7		;b9a1
L_B9A4:
	call L_B604		;b9a4
	ret c			;b9a7
	ld a,(ix+017h)		;b9a8
	and 003h		;b9ab   ; el mismo reparto por turnos
	call z,L_B75C		;b9ad
	jp L_B789		;b9b0
L_B9B3:
	ld a,004h		;b9b3   ; aqui son cuatro columnas desde el borde
	ld (0ea7dh),a		;b9b5
	call AJUSTA_CON_CASILLA_ATRAS		;b9b8
	ld (ix+018h),001h		;b9bb
	ret			;b9bf
L_B9C0:
	call L_B847		;b9c0
	call L_B9C9		;b9c3
	jp L_B6B7		;b9c6
L_B9C9:
	call L_B604		;b9c9
	ret c			;b9cc
	ld a,(ix+017h)		;b9cd
	and 003h		;b9d0   ; y aqui igual
	call z,L_B75C		;b9d2
	jp L_B789		;b9d5
L_B9D8:
	ld a,004h		;b9d8   ; tambien cuatro, pero con otro dibujo
	ld (0ea7dh),a		;b9da
	call AJUSTA_CON_CASILLA_ATRAS		;b9dd
	ld (ix+018h),003h		;b9e0
	ret			;b9e4
L_B9E5:
	call L_B847		;b9e5
	call L_B9F0		;b9e8
	ld c,008h		;b9eb
	jp L_B6B9		;b9ed
L_B9F0:
	call L_B604		;b9f0
	ret c			;b9f3
	ld a,(ix+017h)		;b9f4
	and 003h		;b9f7   ; el reparto de este tipo se salta 0xB75C
	jp z,L_B789		;b9f9
	ld hl,0b837h		;b9fc
	jp L_B7C4		;b9ff
L_BA02:
	ld a,002h		;ba02   ; y aqui dos
	ld (0ea7dh),a		;ba04
	call AJUSTA_CON_CASILLA_ATRAS		;ba07
	ld (ix+018h),000h		;ba0a
	ret			;ba0e
L_BA0F:
	call L_B847		;ba0f
	call L_BA18		;ba12
	jp L_B6B7		;ba15
L_BA18:
	call L_B604		;ba18
	ret c			;ba1b
	ld a,(ix+017h)		;ba1c
	and 00fh		;ba1f   ; el `and 0x0f` de aqui no hace nada: el `and 3` de la linea siguiente ya recorta mas
	and 003h		;ba21
	jp z,L_B789		;ba23
	ld hl,0b83fh		;ba26
	jp L_B7C4		;ba29
L_BA2C:
	ld a,005h		;ba2c   ; cinco: este va por el centro de la calzada
	ld (0ea7dh),a		;ba2e
	call AJUSTA_CON_CASILLA_ATRAS		;ba31
	ld (ix+018h),002h		;ba34
	ret			;ba38
L_BA39:
	call L_B847		;ba39
	call L_BA44		;ba3c
	ld c,00ch		;ba3f
	jp L_B6B9		;ba41
L_BA44:
	call L_B604		;ba44
	ret c			;ba47
	ld a,(ix+017h)		;ba48
	and 003h		;ba4b   ; y aqui tambien
	call z,L_B75C		;ba4d
	jp L_B785		;ba50
L_BA53:
	ld a,001h		;ba53   ; este entra por el otro borde, buscando la casilla hacia delante
	ld (0ea7dh),a		;ba55
	call AJUSTA_CON_CASILLA_ADELANTE		;ba58
	ld a,(ix+015h)		;ba5b   ; y si ya esta a menos de ocho pixeles de su sitio, se queda
	sub (ix+006h)		;ba5e
	add a,008h		;ba61
	cp 010h		;ba63
	jr nc,L_BA70		;ba65
	ld (ix+018h),002h		;ba67
	ld (ix+01fh),002h		;ba6b
	ret			;ba6f
L_BA70:
	ld a,(ix+000h)		;ba70   ; si no, se le cambia el tipo por el 1 y se recoloca
	and 0f0h		;ba73
	or 001h		;ba75
	ld (ix+000h),a		;ba77
	call AJUSTA_ATRAS_Y_MARCA		;ba7a
	ret			;ba7d
L_BA7E:
	call L_B847		;ba7e
	call L_BA87		;ba81
	jp L_B6B7		;ba84
L_BA87:
	call L_B604		;ba87
	ret c			;ba8a
	ld a,(ix+017h)		;ba8b
	and 003h		;ba8e   ; el ultimo tipo, con el mismo molde
	call z,L_B75C		;ba90
	jp L_B789		;ba93
L_BA96:
	ld a,001h		;ba96   ; el ultimo tipo solo se pega al borde y nada mas
	ld (0ea7dh),a		;ba98
	call AJUSTA_CON_CASILLA_ATRAS		;ba9b
	ret			;ba9e
L_BA9F:
	ld a,(0e1c3h)		;ba9f   ; un fotograma de cada dos: aqui es donde el rival lee la pista que viene
	xor (iy+009h)		;baa2
	rrca			;baa5
	ret c			;baa6
	ld e,0e8h		;baa7   ; 0xE8 pixeles por delante, casi una pantalla entera
	call 04af0h		;baa9
	call L_B344		;baac
	ld b,a			;baaf
	cp 0c1h		;bab0
	jr z,L_BAC9		;bab2
	and a			;bab4
	jr z,L_BACF		;bab5
	and 0c0h		;bab7
	cp 080h		;bab9
	jr nz,L_BADC		;babb
	bit 0,(iy-00eh)		;babd
	jr nz,L_BADC		;bac1
	set 0,(iy-00eh)		;bac3
	jr L_BAD6		;bac7
L_BAC9:
	res 0,(iy-00eh)		;bac9
	jr L_BADC		;bacd
L_BACF:
	bit 0,(iy-00eh)		;bacf
	jp nz,L_BADC		;bad3
L_BAD6:
	ld a,b			;bad6
	and 07fh		;bad7
	ld (iy-00dh),a		;bad9
L_BADC:
	ld e,098h		;badc   ; la segunda lectura de pista, mas cerca: 0x98 pixeles
	call 04af0h		;bade
	call L_B344		;bae1   ; y el mismo reparto de tiles que manda
	ld b,a			;bae4
	cp 0c1h		;bae5
	jr z,L_BAFC		;bae7
	and a			;bae9
	jr z,L_BB01		;baea
	and 0c0h		;baec
	cp 080h		;baee
	ret nz			;baf0
	bit 1,(iy-00eh)		;baf1
	ret nz			;baf5
	set 1,(iy-00eh)		;baf6
	jr L_BB06		;bafa
L_BAFC:
	res 1,(iy-00eh)		;bafc
	ret			;bb00
L_BB01:
	bit 1,(iy-00eh)		;bb01
	ret nz			;bb05
L_BB06:
	ld a,b			;bb06
	and 07fh		;bb07
	ld (iy-00ch),a		;bb09
	ret			;bb0c

; ----------------------------------------------------------------------
; DATOS ficha_dibujos_bb0d: 18 punteros a dibujo de ficha, 18 en uso: el paso
;   0/2 de la eleccion, indexado por el valor; p01 0x6644, y p01 0x6657 lo
;   descomprime con la pagina 9 en 0xA000
;   0xbb0d..0xbb31  (36 bytes)
DATA_ficha_dibujos_bb0d:
	defw 0b151h	; bb0d
	defw 0b177h	; bb0f
	defw 0b196h	; bb11
	defw 0b1b4h	; bb13
	defw 0b1d3h	; bb15  -> L_B1D3
	defw 0b1f8h	; bb17
	defw 0b108h	; bb19
	defw 0b11eh	; bb1b
	defw 0b139h	; bb1d
	defw 0b0c0h	; bb1f
	defw 0b0d8h	; bb21
	defw 0b0f0h	; bb23
	defw 0b063h	; bb25
	defw 0b082h	; bb27
	defw 0b0a1h	; bb29
	defw 0b024h	; bb2b
	defw 0b039h	; bb2d
	defw 0b04eh	; bb2f

; ----------------------------------------------------------------------
; DATOS ficha_dibujos_bb31: 36 punteros a dibujo de ficha, 36 en uso: el paso
;   1 de la eleccion, indexado por el valor; p01 0x6644, y p01 0x6657 lo
;   descomprime con la pagina 9 en 0xA000
;   0xbb31..0xbb79  (72 bytes)
DATA_ficha_dibujos_bb31:
	defw 0b42ah	; bb31
	defw 0b45ch	; bb33
	defw 0b486h	; bb35
	defw 0b4b3h	; bb37
	defw 0b4e3h	; bb39
	defw 0b50ah	; bb3b
	defw 0b42ah	; bb3d
	defw 0b45ch	; bb3f
	defw 0b486h	; bb41
	defw 0b4b3h	; bb43
	defw 0b4e3h	; bb45
	defw 0b50ah	; bb47
	defw 0b42ah	; bb49
	defw 0b45ch	; bb4b
	defw 0b486h	; bb4d
	defw 0b4b3h	; bb4f
	defw 0b4e3h	; bb51
	defw 0b50ah	; bb53
	defw 0b42ah	; bb55
	defw 0b45ch	; bb57
	defw 0b486h	; bb59
	defw 0b4b3h	; bb5b
	defw 0b4e3h	; bb5d
	defw 0b50ah	; bb5f
	defw 0b42ah	; bb61
	defw 0b45ch	; bb63
	defw 0b486h	; bb65
	defw 0b4b3h	; bb67
	defw 0b4e3h	; bb69
	defw 0b50ah	; bb6b
	defw 0b42ah	; bb6d
	defw 0b45ch	; bb6f
	defw 0b486h	; bb71
	defw 0b4b3h	; bb73
	defw 0b4e3h	; bb75
	defw 0b50ah	; bb77

; ----------------------------------------------------------------------
; DATOS ficha_dibujos_bb79: 6 punteros a dibujo de ficha, 6 en uso: el paso 3
;   de la eleccion, indexado por el valor; p01 0x6644, y p01 0x6657 lo
;   descomprime con la pagina 9 en 0xA000
;   0xbb79..0xbb85  (12 bytes)
DATA_ficha_dibujos_bb79:
	defw 0b5dch	; bb79
	defw 0b616h	; bb7b
	defw 0b656h	; bb7d
	defw 0b5dch	; bb7f
	defw 0b616h	; bb81
	defw 0b656h	; bb83

; ----------------------------------------------------------------------
; DATOS ficha_dibujos_bb85: 6 punteros a dibujo de ficha, 6 en uso: el paso 4
;   de la eleccion, indexado por el valor; p01 0x6644, y p01 0x6657 lo
;   descomprime con la pagina 9 en 0xA000
;   0xbb85..0xbb91  (12 bytes)
DATA_ficha_dibujos_bb85:
	defw 0b5a6h	; bb85
	defw 0b570h	; bb87
	defw 0b53fh	; bb89
	defw 0b5a6h	; bb8b
	defw 0b570h	; bb8d
	defw 0b53fh	; bb8f

; ----------------------------------------------------------------------
; DATOS ficha_dibujos_bb91: 9 punteros a dibujo de ficha, 6 en uso: el paso 5
;   de la eleccion, indexado por el valor (las 3 ultimas repiten las primeras
;   y ningun valor las alcanza); p01 0x6644, y p01 0x6657 lo descomprime con
;   la pagina 9 en 0xA000
;   0xbb91..0xbba3  (18 bytes)
DATA_ficha_dibujos_bb91:
	defw 0b697h	; bb91
	defw 0b6b6h	; bb93
	defw 0b6ddh	; bb95
	defw 0b697h	; bb97
	defw 0b6b6h	; bb99
	defw 0b6ddh	; bb9b
	defw 0b697h	; bb9d
	defw 0b6b6h	; bb9f
	defw 0b6ddh	; bba1

; ----------------------------------------------------------------------
; DATOS sprites_BBA3: ocho atributos de sprite (y, x, patron, color); p00
;   0x5FAA copia el de 0xBBA7 a EA88 con `ld bc,4 / ldir`. De los otros siete
;   no se ha encontrado lector
;   0xbba3..0xbbc3  (32 bytes)
DATA_sprites_BBA3:
	defb 098h,040h,000h,00fh	; bba3
	defb 0a0h,040h,000h,00fh	; bba7
	defb 098h,040h,000h,00fh	; bbab
	defb 090h,008h,000h,00fh	; bbaf
	defb 030h,048h,004h,008h	; bbb3
	defb 018h,030h,000h,00fh	; bbb7
	defb 018h,0c0h,000h,00fh	; bbbb
	defb 010h,010h,000h,00fh	; bbbf

; ----------------------------------------------------------------------
; DATOS posiciones_cursor: 20 parejas (y, x) del sprite del cursor; p01 0x626C
;   (CURSOR_A_POSICION) copia a EA88 la pareja de indice (E27E) (`add a,a /
;   call HL_MAS_A / ld bc,2 / ldir`), con HL = 0xBBC3 o 0xBBC5 segun (E25B),
;   que pone p00 0x5FEA/0x5FEF
;   0xbbc3..0xbbeb  (40 bytes)
DATA_posiciones_cursor:
	defb 098h,040h	; bbc3
	defb 0a0h,040h	; bbc5
	defb 0a8h,040h	; bbc7
	defb 0b0h,040h	; bbc9
	defb 098h,040h	; bbcb
	defb 0a8h,040h	; bbcd
	defb 0b8h,040h	; bbcf
	defb 090h,008h	; bbd1
	defb 098h,008h	; bbd3
	defb 0a0h,008h	; bbd5
	defb 0a8h,008h	; bbd7
	defb 0b0h,008h	; bbd9
	defb 090h,088h	; bbdb
	defb 018h,030h	; bbdd
	defb 028h,030h	; bbdf
	defb 018h,0c0h	; bbe1
	defb 028h,0c0h	; bbe3
	defb 010h,010h	; bbe5
	defb 048h,010h	; bbe7
	defb 080h,010h	; bbe9

; ----------------------------------------------------------------------
; DATOS tabla_coches: 18 coches predefinidos de 5 bytes (motor, carroceria,
;   (ix+77), (ix+76), (ix+75)|bit7); p01 0x6568 copia a E297/E357 el que se
;   elige en el paso 0
;   0xbbeb..0xbc45  (90 bytes)
DATA_tabla_coches:
	defb 00ch,000h,003h,000h,080h	; bbeb
	defb 00dh,001h,004h,000h,001h	; bbf0
	defb 00eh,002h,005h,001h,002h	; bbf5
	defb 006h,003h,000h,003h,080h	; bbfa
	defb 007h,004h,001h,003h,001h	; bbff
	defb 008h,005h,002h,004h,002h	; bc04
	defb 000h,006h,000h,003h,083h	; bc09
	defb 001h,007h,001h,003h,004h	; bc0e
	defb 002h,008h,002h,004h,005h	; bc13
	defb 012h,009h,000h,003h,083h	; bc18
	defb 013h,00ah,001h,003h,004h	; bc1d
	defb 014h,00bh,002h,004h,005h	; bc22
	defb 018h,00ch,000h,003h,083h	; bc27
	defb 019h,00dh,001h,003h,004h	; bc2c
	defb 01ah,00eh,002h,004h,005h	; bc31
	defb 01eh,00fh,000h,003h,083h	; bc36
	defb 01fh,010h,001h,003h,004h	; bc3b
	defb 020h,011h,002h,004h,005h	; bc40

; ----------------------------------------------------------------------
; DATOS tabla_eleccion: 6 categorias (E25B) x 6 punteros (E251) a las listas
;   de valores de abajo; p01 0x676C
;   0xbc45..0xbc8d  (72 bytes)
DATA_tabla_eleccion:
	defw 0bc8dh,0bca5h,0bccfh,0bce7h,0bcefh,0bcf7h	; bc45
	defw 0bc91h,0bcach,0bcd3h,0bcebh,0bcf3h,0bcfbh	; bc51
	defw 0bc95h,0bcb3h,0bcd7h,0bcebh,0bcf3h,0bcffh	; bc5d
	defw 0bc99h,0bcbah,0bcdbh,0bcebh,0bcf3h,0bcffh	; bc69
	defw 0bc9dh,0bcc1h,0bcdfh,0bcebh,0bcf3h,0bcffh	; bc75
	defw 0bca1h,0bcc8h,0bce3h,0bcebh,0bcf3h,0bcffh	; bc81

; ----------------------------------------------------------------------
; DATOS valores_bc8d: 3 valores y 0xFF: 00 01 02; los elige el paso 0 de la
;   categoria 0 (RALLY)
;   0xbc8d..0xbc91  (4 bytes)
DATA_valores_bc8d:
	defb 000h,001h,002h,0ffh	; bc8d

; ----------------------------------------------------------------------
; DATOS valores_bc91: 3 valores y 0xFF: 03 04 05; los elige el paso 0 de la
;   categoria 1 (STOCK)
;   0xbc91..0xbc95  (4 bytes)
DATA_valores_bc91:
	defb 003h,004h,005h,0ffh	; bc91

; ----------------------------------------------------------------------
; DATOS valores_bc95: 3 valores y 0xFF: 06 07 08; los elige el paso 0 de la
;   categoria 2 (ENDURANCE)
;   0xbc95..0xbc99  (4 bytes)
DATA_valores_bc95:
	defb 006h,007h,008h,0ffh	; bc95

; ----------------------------------------------------------------------
; DATOS valores_bc99: 3 valores y 0xFF: 09 0A 0B; los elige el paso 0 de la
;   categoria 3 (F3)
;   0xbc99..0xbc9d  (4 bytes)
DATA_valores_bc99:
	defb 009h,00ah,00bh,0ffh	; bc99

; ----------------------------------------------------------------------
; DATOS valores_bc9d: 3 valores y 0xFF: 0C 0D 0E; los elige el paso 0 de la
;   categoria 4 (F3000)
;   0xbc9d..0xbca1  (4 bytes)
DATA_valores_bc9d:
	defb 00ch,00dh,00eh,0ffh	; bc9d

; ----------------------------------------------------------------------
; DATOS valores_bca1: 3 valores y 0xFF: 0F 10 11; los elige el paso 0 de la
;   categoria 5 (F1)
;   0xbca1..0xbca5  (4 bytes)
DATA_valores_bca1:
	defb 00fh,010h,011h,0ffh	; bca1

; ----------------------------------------------------------------------
; DATOS valores_bca5: 6 valores y 0xFF: 0C 0D 0E 0F 10 11; los elige el paso 1
;   de la categoria 0 (RALLY)
;   0xbca5..0xbcac  (7 bytes)
DATA_valores_bca5:
	defb 00ch,00dh,00eh,00fh,010h,011h,0ffh	; bca5

; ----------------------------------------------------------------------
; DATOS valores_bcac: 6 valores y 0xFF: 06 07 08 09 0A 0B; los elige el paso 1
;   de la categoria 1 (STOCK)
;   0xbcac..0xbcb3  (7 bytes)
DATA_valores_bcac:
	defb 006h,007h,008h,009h,00ah,00bh,0ffh	; bcac

; ----------------------------------------------------------------------
; DATOS valores_bcb3: 6 valores y 0xFF: 00 01 02 03 04 05; los elige el paso 1
;   de la categoria 2 (ENDURANCE)
;   0xbcb3..0xbcba  (7 bytes)
DATA_valores_bcb3:
	defb 000h,001h,002h,003h,004h,005h,0ffh	; bcb3

; ----------------------------------------------------------------------
; DATOS valores_bcba: 6 valores y 0xFF: 12 13 14 15 16 17; los elige el paso 1
;   de la categoria 3 (F3)
;   0xbcba..0xbcc1  (7 bytes)
DATA_valores_bcba:
	defb 012h,013h,014h,015h,016h,017h,0ffh	; bcba

; ----------------------------------------------------------------------
; DATOS valores_bcc1: 6 valores y 0xFF: 18 19 1A 1B 1C 1D; los elige el paso 1
;   de la categoria 4 (F3000)
;   0xbcc1..0xbcc8  (7 bytes)
DATA_valores_bcc1:
	defb 018h,019h,01ah,01bh,01ch,01dh,0ffh	; bcc1

; ----------------------------------------------------------------------
; DATOS valores_bcc8: 6 valores y 0xFF: 1E 1F 20 21 22 23; los elige el paso 1
;   de la categoria 5 (F1)
;   0xbcc8..0xbccf  (7 bytes)
DATA_valores_bcc8:
	defb 01eh,01fh,020h,021h,022h,023h,0ffh	; bcc8

; ----------------------------------------------------------------------
; DATOS valores_bccf: 3 valores y 0xFF: 00 01 02; los elige el paso 2 de la
;   categoria 0 (RALLY)
;   0xbccf..0xbcd3  (4 bytes)
DATA_valores_bccf:
	defb 000h,001h,002h,0ffh	; bccf

; ----------------------------------------------------------------------
; DATOS valores_bcd3: 3 valores y 0xFF: 03 04 05; los elige el paso 2 de la
;   categoria 1 (STOCK)
;   0xbcd3..0xbcd7  (4 bytes)
DATA_valores_bcd3:
	defb 003h,004h,005h,0ffh	; bcd3

; ----------------------------------------------------------------------
; DATOS valores_bcd7: 3 valores y 0xFF: 06 07 08; los elige el paso 2 de la
;   categoria 2 (ENDURANCE)
;   0xbcd7..0xbcdb  (4 bytes)
DATA_valores_bcd7:
	defb 006h,007h,008h,0ffh	; bcd7

; ----------------------------------------------------------------------
; DATOS valores_bcdb: 3 valores y 0xFF: 09 0A 0B; los elige el paso 2 de la
;   categoria 3 (F3)
;   0xbcdb..0xbcdf  (4 bytes)
DATA_valores_bcdb:
	defb 009h,00ah,00bh,0ffh	; bcdb

; ----------------------------------------------------------------------
; DATOS valores_bcdf: 3 valores y 0xFF: 0C 0D 0E; los elige el paso 2 de la
;   categoria 4 (F3000)
;   0xbcdf..0xbce3  (4 bytes)
DATA_valores_bcdf:
	defb 00ch,00dh,00eh,0ffh	; bcdf

; ----------------------------------------------------------------------
; DATOS valores_bce3: 3 valores y 0xFF: 0F 10 11; los elige el paso 2 de la
;   categoria 5 (F1)
;   0xbce3..0xbce7  (4 bytes)
DATA_valores_bce3:
	defb 00fh,010h,011h,0ffh	; bce3

; ----------------------------------------------------------------------
; DATOS valores_bce7: 3 valores y 0xFF: 03 04 05; los elige el paso 3 de la
;   categoria 0 (RALLY)
;   0xbce7..0xbceb  (4 bytes)
DATA_valores_bce7:
	defb 003h,004h,005h,0ffh	; bce7

; ----------------------------------------------------------------------
; DATOS valores_bceb: 3 valores y 0xFF: 00 01 02; los elige el paso 3 de las
;   categorias 1 STOCK, 2 ENDURANCE, 3 F3, 4 F3000, 5 F1
;   0xbceb..0xbcef  (4 bytes)
DATA_valores_bceb:
	defb 000h,001h,002h,0ffh	; bceb

; ----------------------------------------------------------------------
; DATOS valores_bcef: 3 valores y 0xFF: 00 01 02; los elige el paso 4 de la
;   categoria 0 (RALLY)
;   0xbcef..0xbcf3  (4 bytes)
DATA_valores_bcef:
	defb 000h,001h,002h,0ffh	; bcef

; ----------------------------------------------------------------------
; DATOS valores_bcf3: 3 valores y 0xFF: 03 04 05; los elige el paso 4 de las
;   categorias 1 STOCK, 2 ENDURANCE, 3 F3, 4 F3000, 5 F1
;   0xbcf3..0xbcf7  (4 bytes)
DATA_valores_bcf3:
	defb 003h,004h,005h,0ffh	; bcf3

; ----------------------------------------------------------------------
; DATOS valores_bcf7: 3 valores y 0xFF: 80 01 02; los elige el paso 5 de la
;   categoria 0 (RALLY)
;   0xbcf7..0xbcfb  (4 bytes)
DATA_valores_bcf7:
	defb 080h,001h,002h,0ffh	; bcf7

; ----------------------------------------------------------------------
; DATOS valores_bcfb: 3 valores y 0xFF: 80 01 02; los elige el paso 5 de la
;   categoria 1 (STOCK)
;   0xbcfb..0xbcff  (4 bytes)
DATA_valores_bcfb:
	defb 080h,001h,002h,0ffh	; bcfb

; ----------------------------------------------------------------------
; DATOS valores_bcff: 3 valores y 0xFF: 83 04 05; los elige el paso 5 de las
;   categorias 2 ENDURANCE, 3 F3, 4 F3000, 5 F1
;   0xbcff..0xbd03  (4 bytes)
DATA_valores_bcff:
	defb 083h,004h,005h,0ffh	; bcff

; ----------------------------------------------------------------------
; DATOS tabla_BD03: 6 punteros por (E251) a listas del cargador de tiles (las
;   entradas 0 y 2 apuntan a la tabla 0xBD0F, que se indexa otra vez por
;   (E25B)); p01 0x6787
;   0xbd03..0xbd0f  (12 bytes)
DATA_tabla_BD03:
	defw 0bd0fh	; bd03  -> DATA_tabla_BD0F
	defw 06f70h	; bd05
	defw 0bd0fh	; bd07  -> DATA_tabla_BD0F
	defw 06f95h	; bd09
	defw 06fcch	; bd0b
	defw 07009h	; bd0d

; ----------------------------------------------------------------------
; DATOS tabla_BD0F: 6 punteros a listas del cargador de tiles; por (E25B)
;   desde las entradas 0 y 2 de la tabla 0xBD03 (p01 0x6799)
;   0xbd0f..0xbd1b  (12 bytes)
DATA_tabla_BD0F:
	defw 06f39h	; bd0f
	defw 06ef0h	; bd11
	defw 06eb9h	; bd13
	defw 06e82h	; bd15
	defw 06e4bh	; bd17
	defw 06e14h	; bd19

; ----------------------------------------------------------------------
; DATOS ficha_textos_bd1b: 18 punteros a texto de ficha, 18 en uso: el paso 0
;   de la eleccion, indexado por el valor; p01 0x67A2; los textos son los de
;   la pagina 9 que lee tools/textos.py
;   0xbd1b..0xbd3f  (36 bytes)
DATA_ficha_textos_bd1b:
	defw 0acb5h	; bd1b
	defw 0acc2h	; bd1d
	defw 0acd3h	; bd1f
	defw 0ace3h	; bd21
	defw 0acf3h	; bd23
	defw 0ad01h	; bd25
	defw 0ac7ah	; bd27
	defw 0ac8bh	; bd29
	defw 0ac9eh	; bd2b
	defw 0ad58h	; bd2d
	defw 0ad65h	; bd2f
	defw 0ad72h	; bd31
	defw 0ad3ch	; bd33
	defw 0ad45h	; bd35
	defw 0ad4fh	; bd37  -> L_AD4F
	defw 0ad11h	; bd39
	defw 0ad1eh	; bd3b
	defw 0ad2fh	; bd3d

; ----------------------------------------------------------------------
; DATOS ficha_textos_bd3f: 36 punteros a texto de ficha, 36 en uso: el paso 1
;   de la eleccion, indexado por el valor; p01 0x67A2; los textos son los de
;   la pagina 9 que lee tools/textos.py
;   0xbd3f..0xbd87  (72 bytes)
DATA_ficha_textos_bd3f:
	defw 0adaah	; bd3f  -> L_ADAA
	defw 0adcbh	; bd41
	defw 0ade2h	; bd43
	defw 0adf7h	; bd45
	defw 0ae0dh	; bd47
	defw 0ae25h	; bd49
	defw 0ad83h	; bd4b
	defw 0ad8ah	; bd4d
	defw 0ad90h	; bd4f
	defw 0ad96h	; bd51
	defw 0ad9dh	; bd53
	defw 0ada3h	; bd55
	defw 0ad83h	; bd57
	defw 0ad8ah	; bd59
	defw 0ad90h	; bd5b
	defw 0ad96h	; bd5d
	defw 0ad9dh	; bd5f
	defw 0ada3h	; bd61
	defw 0adb4h	; bd63
	defw 0adbfh	; bd65
	defw 0add7h	; bd67
	defw 0adedh	; bd69
	defw 0ae01h	; bd6b
	defw 0ae19h	; bd6d
	defw 0ae31h	; bd6f  -> L_AE31
	defw 0ae37h	; bd71
	defw 0ae3dh	; bd73
	defw 0ae44h	; bd75
	defw 0ae4bh	; bd77
	defw 0ae52h	; bd79
	defw 0ae59h	; bd7b
	defw 0ae60h	; bd7d  -> L_AE60
	defw 0ae67h	; bd7f
	defw 0ae6dh	; bd81
	defw 0ae74h	; bd83
	defw 0ae7bh	; bd85

; ----------------------------------------------------------------------
; DATOS ficha_textos_bd87: 18 punteros a texto de ficha, 18 en uso: el paso 2
;   de la eleccion, indexado por el valor; p01 0x67A2; los textos son los de
;   la pagina 9 que lee tools/textos.py
;   0xbd87..0xbdab  (36 bytes)
DATA_ficha_textos_bd87:
	defw 0ae83h	; bd87
	defw 0ae94h	; bd89
	defw 0aea9h	; bd8b
	defw 0ae83h	; bd8d
	defw 0ae94h	; bd8f
	defw 0aea9h	; bd91
	defw 0ae83h	; bd93
	defw 0ae94h	; bd95
	defw 0aea9h	; bd97
	defw 0ae83h	; bd99
	defw 0ae94h	; bd9b
	defw 0aea9h	; bd9d
	defw 0ae83h	; bd9f
	defw 0ae94h	; bda1
	defw 0aea9h	; bda3
	defw 0ae83h	; bda5
	defw 0ae94h	; bda7
	defw 0aea9h	; bda9

; ----------------------------------------------------------------------
; DATOS ficha_textos_bdab: 6 punteros a texto de ficha, 6 en uso: el paso 3 de
;   la eleccion, indexado por el valor; p01 0x67A2; los textos son los de la
;   pagina 9 que lee tools/textos.py
;   0xbdab..0xbdb7  (12 bytes)
DATA_ficha_textos_bdab:
	defw 0af3ah	; bdab
	defw 0af42h	; bdad
	defw 0af4bh	; bdaf
	defw 0af3ah	; bdb1
	defw 0af42h	; bdb3
	defw 0af4bh	; bdb5

; ----------------------------------------------------------------------
; DATOS ficha_textos_bdb7: 6 punteros a texto de ficha, 6 en uso: el paso 4 de
;   la eleccion, indexado por el valor; p01 0x67A2; los textos son los de la
;   pagina 9 que lee tools/textos.py
;   0xbdb7..0xbdc3  (12 bytes)
DATA_ficha_textos_bdb7:
	defw 0af2dh	; bdb7
	defw 0af16h	; bdb9
	defw 0af06h	; bdbb
	defw 0af2dh	; bdbd
	defw 0af16h	; bdbf
	defw 0af06h	; bdc1

; ----------------------------------------------------------------------
; DATOS ficha_textos_bdc3: 9 punteros a texto de ficha, 6 en uso: el paso 5 de
;   la eleccion, indexado por el valor (las 3 ultimas repiten las primeras y
;   ningun valor las alcanza); p01 0x67A2; los textos son los de la pagina 9
;   que lee tools/textos.py
;   0xbdc3..0xbdd5  (18 bytes)
DATA_ficha_textos_bdc3:
	defw 0aebbh	; bdc3
	defw 0aec4h	; bdc5
	defw 0aedeh	; bdc7
	defw 0aebbh	; bdc9
	defw 0aec4h	; bdcb
	defw 0aedeh	; bdcd
	defw 0aebbh	; bdcf
	defw 0aec4h	; bdd1
	defw 0aedeh	; bdd3

; ----------------------------------------------------------------------
; DATOS ritmo_por_categoria: seis filas de 3 bytes, una por categoria (E25B):
;   la primera es el multiplicador y las otras dos la palabra con la que
;   compara RITMO_COCHE (p01 0x7F85: `ld de,0xBDD5 / hl = de + 3*(E25B)`). El
;   patron de filas de 3 sigue hasta 0xBE14, pero este lector solo llega a la
;   sexta
;   0xbdd5..0xbde7  (18 bytes)
DATA_ritmo_por_categoria:
	defb 058h,028h,05ch	; bdd5
	defb 04eh,088h,088h	; bdd8
	defb 0b5h,0dbh,0b6h	; bddb
	defb 08eh,074h,0d1h	; bdde
	defb 0b0h,051h,0b8h	; bde1
	defb 062h,000h,0c0h	; bde4

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (45 bytes)
;   0xbde7..0xbe14  (45 bytes)
DATA_pendiente_de_trazar:
	defb 08fh,083h,0bah,093h,000h,0c0h,08dh,0c5h,0b7h,0adh,0dbh,0b6h,0c6h,083h,0bah,0d6h	; bde7  ................
	defb 02eh,0bah,0bdh,05eh,0bdh,0bdh,05eh,0bdh,0bdh,05eh,0bdh,0a2h,02eh,0bah,0bdh,05eh	; bdf7  ...^..^..^.....^
	defb 0bdh,097h,099h,0b1h,0a2h,02eh,0bah,0c3h,0a1h,0c2h,0a2h,02eh,0bah	; be07  .............

; ======================================================================
; CODIGO 0xbe14..0xbe8a  (118 bytes)
; ======================================================================


PANTALLA_INICIAL:		; estado 0/0: borra nombres (0x3800) y patrones, descomprime 0xBE8A con 0x485C (pagina 0) y pinta 6 filas de 21 tiles desde el 0x40 en 0x3907
	ld hl,03800h		;be14
	ld bc,00300h		;be17
	xor a			;be1a
	call 00056h		;be1b   ; BIOS FILVRM - Fills VRAM with value
	ld hl,00000h		;be1e
	ld bc,03000h		;be21
	xor a			;be24
	call 04bb9h		;be25
	ld hl,00000h		;be28
	ld (0e1d0h),hl		;be2b
	ld de,0be8ah		;be2e
	call 0485ch		;be31
	ld hl,00a00h		;be34
	ld bc,003f0h		;be37
	xor a			;be3a
	call 00056h		;be3b   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03907h		;be3e
	ld a,040h		;be41
	ld c,006h		;be43
	ld de,0000bh		;be45
L_BE48:
	ld b,015h		;be48
L_BE4A:
	call 0004dh		;be4a   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;be4d
	inc a			;be4e
	djnz L_BE4A		;be4f
	add hl,de			;be51
	dec c			;be52
	jr nz,L_BE48		;be53
	ret			;be55
PANTALLA_INICIAL_2:		; estado 0/1: escribe 21 patrones (0xF0) por fila a partir de 0x0A00 + 8*(...); cuenta E1D0 y devuelve NZ hasta la sexta
	ld bc,(0e1d0h)		;be56
	ld a,0ebh		;be5a
	inc b			;be5c
L_BE5D:
	add a,015h		;be5d   ; 0x15 por fila: veintiuna casillas de ancho
	djnz L_BE5D		;be5f
	ld l,a			;be61
	ld h,b			;be62
	add hl,hl			;be63   ; por ocho: cada patron son ocho bytes
	add hl,hl			;be64
	add hl,hl			;be65
	ld de,00a00h		;be66
	add hl,de			;be69
	ld a,c			;be6a
	call 040d0h		;be6b
	ld b,015h		;be6e
	ld de,00008h		;be70
	ld a,0f0h		;be73
L_BE75:
	call 0004dh		;be75   ; BIOS WRTVRM - Writes data in VRAM | veintiun patrones seguidos, de ocho en ocho bytes
	add hl,de			;be78
	djnz L_BE75		;be79   ; y ocho bytes hasta el patron de la fila de abajo
	ld hl,0e1d0h		;be7b
	ld a,(hl)			;be7e
	inc a			;be7f
	and 007h		;be80
	ld (hl),a			;be82
	ret nz			;be83
	inc hl			;be84
	inc (hl)			;be85
	ld a,(hl)			;be86
	cp 006h		;be87
	ret			;be89

; ----------------------------------------------------------------------
; DATOS pantalla_titulo: flujo RLE de la pantalla del titulo: cabecera 0x2A00
;   (destino en VRAM) y 352 bytes de codigos que PANTALLA_INICIAL descomprime
;   con `ld de,0xBE8A / call 0x485C` (0xBE2E); escribe 1008 bytes
;   0xbe8a..0xbfec  (354 bytes)
DATA_pantalla_titulo:
	defb 000h,02ah,018h,000h,002h,007h,003h,00fh,002h,01fh,081h,03fh,008h,0ffh,002h,0f8h	; be8a  .*.........?....
	defb 003h,0f0h,003h,0e0h,07fh,000h,00dh,000h,087h,001h,003h,00fh,07fh,03fh,07fh,07fh	; be9a  .............?..
	defb 00ah,0ffh,082h,0fch,0f0h,003h,0c0h,002h,080h,07fh,000h,083h,001h,003h,007h,003h	; beaa  ................
	defb 00fh,081h,03fh,009h,0ffh,087h,0feh,0fch,0f8h,0f8h,0f0h,0f8h,0c0h,00bh,000h,002h	; beba  ..?.............
	defb 001h,083h,003h,07fh,07fh,00bh,0ffh,002h,0feh,083h,0fch,080h,080h,006h,000h,002h	; beca  ................
	defb 03ch,002h,078h,092h,079h,0f3h,0f7h,0ffh,01fh,03eh,07ch,0f9h,0f3h,0e3h,0c3h,087h	; beda  <.x.y....>|.....
	defb 01fh,07fh,0f8h,0f0h,0e0h,0e0h,003h,0c0h,084h,0f0h,0f8h,078h,078h,003h,079h,002h	; beea  ...........xx.y.
	defb 07fh,083h,0ffh,0f7h,0f7h,003h,0e7h,002h,00fh,003h,01eh,003h,03ch,088h,003h,007h	; befa  ............<...
	defb 00fh,00eh,01eh,03ch,038h,078h,005h,0e0h,003h,0e1h,002h,07eh,083h,0feh,0f6h,0f6h	; bf0a  ...<8x.....~....
	defb 003h,0eeh,002h,00fh,088h,01fh,01dh,03dh,03bh,07bh,073h,0f1h,0f1h,003h,0e3h,003h	; bf1a  .......=;{s.....
	defb 0c7h,002h,0e0h,003h,0c0h,003h,080h,008h,000h,003h,01fh,003h,03fh,002h,07fh,008h	; bf2a  ............?...
	defb 0ffh,083h,0f0h,0e0h,0e0h,003h,0c0h,002h,080h,007h,000h,087h,007h,003h,007h,007h	; bf3a  ................
	defb 00fh,01fh,03fh,009h,0ffh,089h,0f8h,0fch,0f8h,0f8h,0f0h,0e0h,0c0h,000h,000h,003h	; bf4a  ..?.............
	defb 001h,003h,003h,002h,007h,088h,0efh,0e7h,0e7h,0c7h,0c7h,0c3h,083h,083h,003h,087h	; bf5a  ................
	defb 003h,0c7h,092h,0e3h,0e0h,080h,080h,081h,081h,083h,0c7h,0ffh,0feh,0fbh,0f3h,0f3h	; bf6a  ................
	defb 0f7h,0e7h,0c7h,08fh,00fh,003h,0c7h,003h,087h,002h,007h,002h,078h,088h,079h,0f1h	; bf7a  ............x.y.
	defb 0f3h,0f7h,0e7h,0efh,070h,0f0h,003h,0ffh,002h,081h,081h,001h,003h,0e3h,003h,0e7h	; bf8a  ....p...........
	defb 002h,0efh,002h,0ceh,081h,0cfh,003h,08fh,002h,00fh,088h,0f7h,0e7h,0c7h,0cfh,08fh	; bf9a  ................
	defb 08fh,01eh,01eh,003h,08fh,003h,01eh,002h,03ch,090h,007h,008h,017h,014h,017h,014h	; bfaa  ........<.......
	defb 008h,007h,080h,040h,020h,0a0h,020h,0a0h,040h,080h,011h,000h,085h,003h,00fh,01fh	; bfba  ...@ . .@.......
	defb 03fh,07fh,00bh,0ffh,086h,0fch,0f0h,0e0h,0c0h,080h,080h,07fh,000h,00ah,000h,003h	; bfca  ?...............
	defb 001h,003h,003h,002h,007h,009h,0ffh,002h,0feh,003h,0fch,002h,0f8h,07fh,000h,009h	; bfda  ................
	defb 000h,000h	; bfea

; ----------------------------------------------------------------------
; DATOS relleno_BFEC: veinte bytes a 0xFF hasta el final de la pagina
;   (comprobado byte a byte)
;   0xbfec..0xc000  (20 bytes)
DATA_relleno_BFEC:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfec  ................
	defb 0ffh,0ffh,0ffh,0ffh	; bffc
