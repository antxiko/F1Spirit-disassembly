; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 01 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ======================================================================
; CODIGO 0x6000..0x6135  (309 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Cola de p00 0x5FD7 (cae desde p00 0x5FFD con E251 = 0): en la
; pantalla de opciones, al pulsar el boton: opcion 0 -> E250 = 0x0A
; (E25B = min(E25C,5), E91F = 0xFF); opcion 1 -> 0x601E; resto -> E250 = 4.
; El menu va por dos variables: E251 es el paso -que pantalla de
; menu se esta ensenando- y E27E la opcion marcada, con E27F como
; ultima opcion valida. El cursor es un sprite cuyos cuatro bytes de
; atributo se copian de una tabla de p03, y los rotulos son textos
; comprimidos de p09 que pinta y borra la pareja p00 0x4B8F/0x4B99.
; ----------------------------------------------------------------------
OPCION_ELEGIDA:		; A = E27E (+1 si E25B = 0xFF); 0 -> categoria por E25C y E250 = 0x0A; 1 -> 0x601E; >1 -> E250 = 4
	jr nz,L_6003		;6000   ; se entra desde p00 0x5FFD; el Z de alli dice si hay categoria elegida
	inc a			;6002
L_6003:
	dec a			;6003   ; con el `dec` la opcion 1 sale por Z y las de mas arriba por el signo
	jr z,OPCION_1_ELEGIDA		;6004
	jp p,A_ESTADO_4		;6006
	ld a,(0e25ch)		;6009   ; E25B = E25C si < 5, si no 5
	cp 005h		;600c
	jr c,L_6012		;600e
	ld a,005h		;6010
L_6012:
	ld (0e25bh),a		;6012
	ld a,0ffh		;6015
	ld (0e91fh),a		;6017   ; E91F = 0xFF
	ld a,00ah		;601a
	jr PON_ESTADO		;601c
OPCION_1_ELEGIDA:		; E240 = 0, E27F = 2 (tres opciones), E27E = 0 y E251++ (0x6079); cursor de p03 0xBBAB a EA88; borra los textos p03 0xAB51 y 0xAB59 y pinta el 0xAB5E
	xor a			;601e
	ld (0e240h),a		;601f   ; E240 a cero, que la eleccion de jugadores empieza de nuevo
	ld a,002h		;6022
	ld (0e27fh),a		;6024   ; tres opciones: uno, dos, y la tercera
	call SIGUIENTE_PASO_MENU		;6027
	ld de,0ea88h		;602a
	ld hl,0bbabh		;602d   ; los cuatro bytes del cursor son un atributo de sprite entero (Y, X, patron y color) que se copia de p03
	ld bc,00004h		;6030
	ldir		;6033
	ld de,0ab51h		;6035   ; se borran los dos rotulos de la pantalla anterior antes de pintar el de esta
	call 04b99h		;6038
	ld de,0ab59h		;603b
	call 04b99h		;603e
	ld de,0ab5eh		;6041
	jp 04b8fh		;6044
A_ESTADO_4:		; E250 = 4
	ld a,004h		;6047
PON_ESTADO:		; E250 = A; E251 = E252 = E27E = 0
	ld (0e250h),a		;6049
SUBESTADO_A_CERO:		; E251 = E252 = E27E = 0 (lo llama p00 0x5BA2 tras E250++)
	xor a			;604c
	ld (0e251h),a		;604d   ; los tres a cero: paso, subpaso y opcion marcada
	ld (0e252h),a		;6050
	ld (0e27eh),a		;6053
	ret			;6056

; ----------------------------------------------------------------------
; p00 0x5FE1 salta aqui con E251 = 1: menu de 2 o 3 opciones con la
; tabla de cursor p03 0xBBCB; con el boton, E27E = 0 -> un jugador,
; 1 -> dos jugadores (bit 5 de E1C2; E240 = 1 si la opcion es 2).
; ----------------------------------------------------------------------
MENU_JUGADORES:		; mueve el cursor por p03 0xBBCB (0x626C); con el boton (0x62AC): bit 5 de E1C2 = (E27E != 0), E240 = 1 si E27E = 2, pinta el menu de categorias (0x6082) y E251++
	ld hl,0bbcbh		;6057
	call MUEVE_CURSOR		;605a   ; el cursor se mueve con la tabla de p03 0xBBCB, que dice donde va cada opcion
	call BOTON_PULSADO		;605d
	ret z			;6060
	ld a,(0e27eh)		;6061   ; la opcion 0 es un jugador y las otras dos son dos
	and a			;6064
	ld hl,0e1c2h		;6065   ; bit 5 de E1C2: dos jugadores
	res 5,(hl)		;6068
	jr z,L_6076		;606a
	set 5,(hl)		;606c
	dec a			;606e   ; la tercera opcion ademas enciende E240
	jr z,L_6076		;606f
	ld a,001h		;6071
	ld (0e240h),a		;6073   ; E240 = 1: la tercera opcion (hipotesis: dos jugadores alternos)
L_6076:
	call PINTA_MENU_CATEGORIAS		;6076
SIGUIENTE_PASO_MENU:		; E27E = 0 y E251++
	xor a			;6079
	ld (0e27eh),a		;607a   ; al pasar de pantalla la opcion vuelve a la primera
	ld hl,0e251h		;607d
	inc (hl)			;6080
	ret			;6081
PINTA_MENU_CATEGORIAS:		; la raya vertical (0x613A), E27E = 0 (0x619E), la lista de textos con paginas 5/6 (0x62D4), E27F = 2, cursor de p03 0xBBAF a EA88, borra el texto 0xAB5E, pinta 0xAB74; si pasa los puntos: 0xAB87 (E27F = 4) y 0xAB93 (E27F = 5); E35D = GP maximo (0x61C7) y lo pinta en 0x3A7B
	call PINTA_RAYA_MENU		;6082
	call CURSOR_A_CERO		;6085
	call PINTA_TEXTOS_CATEGORIAS		;6088
	ld a,002h		;608b
	ld (0e27fh),a		;608d
	ld de,0ea88h		;6090   ; el cursor cambia de sitio con el menu: otra tabla, otros cuatro bytes
	ld hl,0bbafh		;6093
	ld bc,00004h		;6096
	ldir		;6099
	ld de,0ab5eh		;609b
	call 04b99h		;609e
	ld de,0ab74h		;60a1
	call 04b8fh		;60a4
	call PUNTOS_MENOS_0C		;60a7   ; carry si los puntos (E295 y E355) no llegan a 0x0C: no hay mas opciones
	ret c			;60aa
	ld hl,0e27fh		;60ab
	inc (hl)			;60ae   ; ...con 0x0C dos mas (el `inc` va dos veces)...
	inc (hl)			;60af
	ld de,0ab87h		;60b0
	call 04b8fh		;60b3
	call PUNTOS_MENOS_19		;60b6   ; idem con 0x19
	ret c			;60b9
	ld hl,0e27fh		;60ba
	inc (hl)			;60bd   ; ...y con 0x19 una mas
	ld de,0ab93h		;60be
	call 04b8fh		;60c1
	xor a			;60c4
	call GP_MAXIMO		;60c5   ; A = 2 * umbrales superados (0x21..0xB4) -> E35D
	ld (0e35dh),a		;60c8
	ld hl,03a7bh		;60cb   ; fila 19, columna 27 de la tabla de nombres
	call PINTA_NUMERO_2_DIGITOS		;60ce

; ----------------------------------------------------------------------
; La fila del GP elegido (E29D): borra 13 casillas en 0x3AB3 (fila
; 21, col 19), pinta el numero E29D+1 en 0x3ADC y el nombre de la tabla 0x635A.
; ----------------------------------------------------------------------
PINTA_GP_ELEGIDO:		; FILVRM 13 ceros en 0x3AB3; numero E29D+1 en 0x3ADC (0x617E); el flujo de tiles 0x635A[E29D] en 0x3AB3 (p00 0x4807)
	xor a			;60d1
	ld bc,0000dh		;60d2   ; trece casillas borradas: el hueco del nombre del GP
	ld hl,03ab3h		;60d5
	call 00056h		;60d8   ; BIOS FILVRM - Fills VRAM with value
	ld a,(0e29dh)		;60db
	ld hl,03adch		;60de   ; fila 22, columna 28
	call PINTA_NUMERO_2_DIGITOS		;60e1
	ld a,(0e29dh)		;60e4
	ld de,0635ah		;60e7   ; tabla de 16 punteros a flujos de tiles (0x6E37..0x6ECC)
	call 04a3bh		;60ea
	ld hl,03ab3h		;60ed
	jp 04807h		;60f0   ; p00 0x4807: PINTA_TILES con la direccion HL ya dada
MENU_CATEGORIA:		; E251 = 2: cursor por p03 0xBBD1 (0x626C), textos (0x61A2, 0x62D4), si E27E = 5 mueve el GP (0x623C); con el boton: E25B = categoria de E27E (0x6128), E25C = E25B o 5 + E29D, E25F = 0 y E250 = 6
	ld hl,0bbd1h		;60f3
	call MUEVE_CURSOR		;60f6
	call PINTA_NOMBRE_CATEGORIA		;60f9   ; el nombre de la categoria se repinta en cada fotograma: cambia al mover el cursor
	call PINTA_TEXTOS_CATEGORIAS		;60fc
	ld a,(0e27eh)		;60ff
	cp 005h		;6102   ; la opcion 5 es la de F1, y ahi el mando ademas mueve el numero de GP
	call z,MUEVE_GP		;6104
	call BOTON_PULSADO		;6107
	ret z			;610a
	ld hl,0e29dh		;610b
	ld a,(0e27eh)		;610e
	call CATEGORIA_DE_OPCION		;6111   ; tabla 0x6135: opcion del menu -> categoria (1,0,3,4,2)
	ld (0e25bh),a		;6114
	cp 005h		;6117
	jr c,PON_CARRERA		;6119
	add a,(hl)			;611b   ; E25C = 5 + E29D: el GP (hipotesis: la carrera de F1 elegida)
PON_CARRERA:		; E25C = A, E25F = 0, E250 = 6
	ld (0e25ch),a		;611c
	xor a			;611f
	ld (0e25fh),a		;6120   ; E25F a cero: elige el jugador 1
	ld a,006h		;6123
	jp PON_ESTADO		;6125
CATEGORIA_DE_OPCION:		; si A < 5: A = tabla 0x6135[A]; si no A tal cual
	cp 005h		;6128
	ret nc			;612a   ; de la 5 en adelante no hay traduccion que hacer
	push hl			;612b
	ld hl,06135h		;612c
	call 040d0h		;612f
	ld a,(hl)			;6132
	pop hl			;6133
	ret			;6134

; ----------------------------------------------------------------------
; DATOS tabla_opcion_categoria: 5 bytes: la opcion del menu E27E -> categoria
;   E25B (1,0,3,4,2)
;   0x6135..0x613a  (5 bytes)
DATA_tabla_opcion_categoria:
	defb 001h,000h,003h,004h,002h	; 6135

; ======================================================================
; CODIGO 0x613a..0x6145  (11 bytes)
; ======================================================================


PINTA_RAYA_MENU:		; descomprime el flujo 0x6145 (15 columnas) en E421: una raya vertical de tiles 0x5F (7 filas) y 0x5E (7 filas)
	ld de,06145h		;613a   ; la raya que parte el menu en dos columnas no es un dibujo: es un flujo RLE de catorce filas, siete del tile 0x5F y siete del 0x5E
	ld hl,0e421h		;613d
	ld a,00fh		;6140
	jp RLE_A_BUFFER		;6142

; ----------------------------------------------------------------------
; DATOS flujo_raya_menu: flujo RLE para 0x637A: 14 filas de [14 ceros,
;   0x5F/0x5E], fin 0x00
;   0x6145..0x617e  (57 bytes)
DATA_flujo_raya_menu:
	defb 08eh,000h,001h,05fh	; 6145
	defb 08eh,000h,001h,05fh	; 6149
	defb 08eh,000h,001h,05fh	; 614d
	defb 08eh,000h,001h,05fh	; 6151
	defb 08eh,000h,001h,05fh	; 6155
	defb 08eh,000h,001h,05fh	; 6159
	defb 08eh,000h,001h,05fh	; 615d
	defb 08eh,000h,001h,05eh	; 6161
	defb 08eh,000h,001h,05eh	; 6165
	defb 08eh,000h,001h,05eh	; 6169
	defb 08eh,000h,001h,05eh	; 616d
	defb 08eh,000h,001h,05eh	; 6171
	defb 08eh,000h,001h,05eh	; 6175
	defb 08eh,000h,001h,05eh	; 6179
	defb 000h	; 617d

; ======================================================================
; CODIGO 0x617e..0x635a  (476 bytes)
; ======================================================================


PINTA_NUMERO_2_DIGITOS:		; A+1 a BCD (p00 0x4B28) y sus dos digitos en VRAM HL y HL+1 como tiles 0x10+n (decena 0 = tile 0)
	push hl			;617e
	inc a			;617f   ; el +1 es porque los numeros del menu se ensenan desde 1 y por dentro cuentan desde 0
	ld l,a			;6180
	ld h,000h		;6181
	call 04b28h		;6183
	pop hl			;6186
	ld a,e			;6187
	rra			;6188   ; las cuatro rotaciones bajan el nibble de arriba: la decena
	rra			;6189
	rra			;618a
	rra			;618b
	and 00fh		;618c
	jr z,PINTA_DIGITO_DECENA		;618e   ; una decena a cero no se pinta: se queda el tile 0, que es el fondo
	add a,010h		;6190
PINTA_DIGITO_DECENA:		; WRTVRM de la decena y luego la unidad
	call 0004dh		;6192   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;6195
	ld a,e			;6196
	and 00fh		;6197
	add a,010h		;6199   ; los digitos son los tiles 0x10 a 0x19
	jp 0004dh		;619b   ; BIOS WRTVRM - Writes data in VRAM
CURSOR_A_CERO:		; E27E = 0
	xor a			;619e
	ld (0e27eh),a		;619f
PINTA_NOMBRE_CATEGORIA:		; paginas 5/6 en 8000/A000; HL = p06 0xBC6D[categoria de E27E (+E29D si >= 5)]; descomprime 11 columnas en E423 (0x637A) y vuelve a 1/2/3
	ld a,005h		;61a2
	call 04447h		;61a4   ; MAPEA_A_EN_8000 con 5: p05 en 0x8000 y p06 en 0xA000
	ld hl,0e29dh		;61a7
	ld a,(0e27eh)		;61aa
	cp 005h		;61ad   ; de la opcion 5 en adelante el nombre depende ademas del GP elegido
	jr c,NOMBRE_CATEGORIA_INDICE		;61af
	add a,(hl)			;61b1
NOMBRE_CATEGORIA_INDICE:		; A = categoria de la opcion (0x6128) y sigue
	call CATEGORIA_DE_OPCION		;61b2
	ld hl,0bc6dh		;61b5   ; tabla de punteros en p06 (A000 = pagina 6 aqui)
	call 04a44h		;61b8
	ld de,0e423h		;61bb   ; once columnas descomprimidas en E423: el hueco del nombre en el menu
	ld a,00bh		;61be
	ex de,hl			;61c0
	call RLE_A_BUFFER		;61c1
	jp 043feh		;61c4
GP_MAXIMO:		; A = 0; por cada umbral de puntos superado (0x21,0x30,0x41,0x54,0x69,0x80,0x99,0xB4) A += 2; si pasa todos A = 15
	call PUNTOS_MENOS_21		;61c7   ; los ocho umbrales son 0x21, 0x30, 0x41, 0x54, 0x69, 0x80, 0x99 y 0xB4: la escalera de puntos que va abriendo los GP
	ret c			;61ca
	inc a			;61cb   ; dos GP mas por cada umbral pasado
	inc a			;61cc
	call PUNTOS_MENOS_30		;61cd   ; dos GP por cada umbral, y todos los umbrales van encadenados: el primero que no se pase corta
	ret c			;61d0
	inc a			;61d1
	inc a			;61d2
	call PUNTOS_MENOS_41		;61d3   ; los ocho umbrales estan escritos como ocho llamadas, una por valor
	ret c			;61d6
	inc a			;61d7
	inc a			;61d8
	call PUNTOS_MENOS_54		;61d9
	ret c			;61dc
	inc a			;61dd
	inc a			;61de
	call PUNTOS_MENOS_69		;61df
	ret c			;61e2
	inc a			;61e3
	inc a			;61e4
	call PUNTOS_MENOS_80		;61e5   ; no hay tabla: es la escalera escrita a mano
	ret c			;61e8
	inc a			;61e9
	inc a			;61ea
	call PUNTOS_MENOS_99		;61eb
	ret c			;61ee
	inc a			;61ef
	inc a			;61f0
	call PUNTOS_MENOS_B4		;61f1
	ret c			;61f4
	inc a			;61f5   ; y si se pasan los ocho, uno mas: 16 GP en total
	ret			;61f6
PUNTOS_MENOS_0C:		; DE = 0x0C y compara (0x6227)
	ld de,0000ch		;61f7
	jr COMPARA_PUNTOS		;61fa
PUNTOS_MENOS_19:		; DE = 0x19
	ld de,00019h		;61fc
	jr COMPARA_PUNTOS		;61ff
PUNTOS_MENOS_21:		; DE = 0x21
	ld de,00021h		;6201
	jr COMPARA_PUNTOS		;6204
PUNTOS_MENOS_30:		; DE = 0x30
	ld de,00030h		;6206
	jr COMPARA_PUNTOS		;6209
PUNTOS_MENOS_41:		; DE = 0x41
	ld de,00041h		;620b
	jr COMPARA_PUNTOS		;620e
PUNTOS_MENOS_54:		; DE = 0x54
	ld de,00054h		;6210
	jr COMPARA_PUNTOS		;6213
PUNTOS_MENOS_69:		; DE = 0x69
	ld de,00069h		;6215
	jr COMPARA_PUNTOS		;6218
PUNTOS_MENOS_80:		; DE = 0x80
	ld de,00080h		;621a
	jr COMPARA_PUNTOS		;621d
PUNTOS_MENOS_99:		; DE = 0x99
	ld de,00099h		;621f
	jr COMPARA_PUNTOS		;6222
PUNTOS_MENOS_B4:		; DE = 0xB4
	ld de,000b4h		;6224
COMPARA_PUNTOS:		; si E1DF != 0: NZ y sin carry; si no carry solo si (E295) < DE y (E355) < DE (los 16 bits de ix-0x2B de los dos coches)
	ld c,a			;6227   ; con E1DF encendido -el desbloqueo- no hay umbral que valga: todo abierto
	ld a,(0e1dfh)		;6228
	or a			;622b
	ld a,c			;622c
	ret nz			;622d
	ld hl,(0e295h)		;622e   ; los puntos son de 16 bits y hay dos juegos, uno por jugador
	or a			;6231
	sbc hl,de		;6232
	ret nc			;6234
	ld hl,(0e355h)		;6235   ; basta con que UNO de los dos llegue al umbral para abrirlo
	or a			;6238
	sbc hl,de		;6239
	ret			;623b
MUEVE_GP:		; flancos de los dos mandos: izquierda (bit 2) -> E29D-- (0x6255); derecha (bit 3) -> E29D++ hasta E35D; repinta nombre y numero y suena 0x25
	ld a,(0e1c8h)		;623c   ; los flancos de los dos mandos se juntan: el GP lo puede mover cualquiera de los dos
	ld hl,0e1cbh		;623f
	or (hl)			;6242
	rra			;6243   ; tres rotaciones para llegar al bit 2 (izquierda) y una mas para el 3 (derecha)
	rra			;6244
	rra			;6245
	jr c,GP_ANTERIOR		;6246
	rra			;6248
	ret nc			;6249
	ld hl,0e35dh		;624a   ; a la derecha no se pasa del GP maximo alcanzado
	ld a,(0e29dh)		;624d
	cp (hl)			;6250
	ret z			;6251
	inc a			;6252
	jr GP_NUEVO		;6253
GP_ANTERIOR:		; E29D-- si no es 0
	ld a,(0e29dh)		;6255
	or a			;6258   ; y a la izquierda no se baja del primero
	ret z			;6259
	dec a			;625a
GP_NUEVO:		; E29D = A; 0x61A2, 0x60D1 y sonido 0x25 (0x62A2)
	ld (0e29dh),a		;625b
	call PINTA_NOMBRE_CATEGORIA		;625e
	call PINTA_GP_ELEGIDO		;6261
	jr SONIDO_25		;6264
MUEVE_CURSOR_MANDO_ACTIVO:		; como 0x626C pero con los flancos del mando de E25F (0x62C5)
	ex de,hl			;6266
	call FLANCOS_MANDO_ACTIVO		;6267   ; aqui solo manda el mando del jugador que este eligiendo (E25F)
	jr MUEVE_CURSOR_FLANCOS		;626a
MUEVE_CURSOR:		; HL = tabla de posiciones (pares y,x por opcion); flancos de los dos mandos: arriba (bit 0) E27E-- / abajo (bit 1) E27E++ (tope E27F); posicion nueva a EA88 y sonido 0x25 (salvo E250 = 0x18)
	ex de,hl			;626c
	ld a,(0e1c8h)		;626d   ; los dos mandos otra vez: el cursor lo mueve cualquiera
	ld hl,0e1cbh		;6270
	or (hl)			;6273
MUEVE_CURSOR_FLANCOS:		; A = flancos: bit 0 arriba, bit 1 abajo
	rra			;6274   ; bit 0 arriba y bit 1 abajo, y se miran en ese orden
	ld hl,0e27eh		;6275
	jr c,CURSOR_ARRIBA		;6278
	rra			;627a
	ret nc			;627b
	inc (hl)			;627c
	ld a,(0e27fh)		;627d   ; E27F es la ultima opcion valida: por debajo de ella el cursor se queda clavado
	cp (hl)			;6280
	jr nc,CURSOR_ABAJO_OK		;6281
	ld (hl),a			;6283
	ret			;6284
CURSOR_ABAJO_OK:		; sigue en 0x628E
	jr CURSOR_A_POSICION		;6285
CURSOR_ARRIBA:		; E27E--; si pasa de 0 se queda en 0 y no suena
	dec (hl)			;6287   ; y hacia arriba el tope es el 0: el `inc a` detras del `dec` es la prueba de que se ha pasado
	ld a,(hl)			;6288
	inc a			;6289
	jr nz,CURSOR_A_POSICION		;628a
	ld (hl),a			;628c
	ret			;628d
CURSOR_A_POSICION:		; EA88/EA89 = el par E27E de la tabla DE; sonido 0x25 si E250 != 0x18
	ld a,(hl)			;628e   ; la opcion por dos: la tabla son parejas de (Y, X)
	ex de,hl			;628f
	add a,a			;6290
	call 040d0h		;6291
	ld de,0ea88h		;6294
	ld bc,00002h		;6297   ; solo se copian dos bytes -la posicion-, que el patron y el color del cursor ya estaban puestos
	ldir		;629a
	ld a,(0e250h)		;629c   ; en el estado 0x18 el cursor se mueve callado
	cp 018h		;629f
	ret z			;62a1
SONIDO_25:		; ENCOLA_SONIDO 0x25 (cursor)
	ld a,025h		;62a2
	jp 04174h		;62a4
BOTON_MANDO_ACTIVO:		; como 0x62AC con los flancos del mando de E25F
	call FLANCOS_MANDO_ACTIVO		;62a7
	jr BOTON_FLANCO		;62aa
BOTON_PULSADO:		; Z si ningun mando acaba de pulsar el boton (bit 4 de E1C8|E1CB); si no, sonido 0x26 (salvo E250 = 0x18) y A = 0xFF
	ld a,(0e1c8h)		;62ac
	ld hl,0e1cbh		;62af
	or (hl)			;62b2
BOTON_FLANCO:		; bit 4 de A
	and 010h		;62b3   ; el bit 4 es el boton, y tambien vale el de cualquiera de los dos mandos
	ret z			;62b5
	ld a,(0e250h)		;62b6
	cp 018h		;62b9
	jr z,BOTON_SI		;62bb
	ld a,026h		;62bd
	call 04174h		;62bf
BOTON_SI:		; A = 0xFF, NZ
	or 0ffh		;62c2
	ret			;62c4
FLANCOS_MANDO_ACTIVO:		; A = E1C8 (mando 1) si E25F = 0, si no E1CB (mando 2)
	ld a,(0e25fh)		;62c5   ; en la eleccion de coche cada jugador manda sobre lo suyo, y E25F dice de quien es el turno
	ld hl,0e1c8h		;62c8
	and a			;62cb
	jr z,FLANCOS_LEE		;62cc
	ld hl,0e1cbh		;62ce
FLANCOS_LEE:		; A = (HL)
	ld a,(hl)			;62d1
	ret			;62d2
NADA_62D3:		; ret (lo llama p00 0x5FDA)
	ret			;62d3

; ----------------------------------------------------------------------
; Los textos de la pantalla de categorias: p09 en A000 para expandir
; el texto p09 0xAC0F en EC02 (0x691B) y pintarlo en E501 (7 filas x
; 11 columnas, fuente +0x30); y los dos bloques por coche (E2C0 y E380).
; ----------------------------------------------------------------------
PINTA_TEXTOS_CATEGORIAS:		; p09 en A000; texto 0xAC0F -> EC02 -> E501 (7x11, fuente 0x30); 1/2/3; 0x6BF3 y 0x6CF4 (0x60 a E5AB/E5CB) por coche; y 0x631F para E52D (coche 1) y E54D (coche 2)
	ld a,009h		;62d4
	call 04457h		;62d6   ; MAPEA_A_EN_A000 con 9: el texto 0xAC0F esta en la pagina 9
	ld hl,0ac0fh		;62d9
	call EXPANDE_TEXTO_5F		;62dc
	call 043feh		;62df
	ld de,0ec02h		;62e2
	ld bc,0070bh		;62e5   ; siete filas de once columnas: el hueco de la tabla de la izquierda
	ld hl,0e501h		;62e8
	exx			;62eb
	ld b,030h		;62ec   ; B' = 0x30 es la fuente: al codigo de cada letra se le suma eso para dar con su tile
	exx			;62ee
	call PINTA_TEXTO_BUFFER		;62ef
	ld iy,0e2c0h		;62f2   ; los totales de los dos jugadores, uno debajo del otro
	call TOTAL_A_BCD		;62f6
	ld hl,0e5abh		;62f9
	ld b,060h		;62fc
	call PINTA_BCD_4_DIGITOS		;62fe
	ld iy,0e380h		;6301
	call TOTAL_A_BCD		;6305
	ld hl,0e5cbh		;6308
	ld b,060h		;630b
	call PINTA_BCD_4_DIGITOS		;630d
	ld de,0e2c0h		;6310   ; y el valor conseguido en la categoria que marque el cursor, tambien por jugador
	ld hl,0e52dh		;6313
	call PINTA_VALOR_COCHE		;6316
	ld de,0e380h		;6319
	ld hl,0e54dh		;631c
PINTA_VALOR_COCHE:		; HL = destino en el buffer; DE = bloque del coche: byte (DE - 0x40 + categoria) a BCD y sus digitos en HL (0x6CF0, B = 0x60)
	push hl			;631f
	ld hl,0e29dh		;6320
	ld a,(0e27eh)		;6323
	call CATEGORIA_DE_OPCION		;6326   ; el mismo apano del menu: la opcion se traduce a categoria y la 5 se suma al GP
	cp 005h		;6329
	jr nz,VALOR_COCHE_LEE		;632b
	add a,(hl)			;632d
VALOR_COCHE_LEE:		; HL = DE - 0x40 + A: el byte del coche
	ld hl,0ffc0h		;632e   ; DE - 0x40 + categoria: E280.. (coche 1) o E340.. (coche 2), un byte por categoria (hipotesis: lo conseguido en cada una)
	call 040d0h		;6331   ; 0xFFC0 es -0x40: la tabla de valores empieza 0x40 por debajo del bloque del coche
	add hl,de			;6334
	ld a,(hl)			;6335
	ld l,a			;6336
	ld h,000h		;6337
	call 04b28h		;6339
	pop hl			;633c
	ld b,060h		;633d   ; B = 0x60 es la fuente de los digitos de esta pantalla
	jp PINTA_BCD_2_DIGITOS		;633f
CARGA_TILES_MENU:		; listas de tiles p04 0x6D6B, 0x6C7C y 0x620A (CARGA_LISTA_TILES) y la lista de sprites p04 0x74EF
	ld hl,06d6bh		;6342
	call 04ccdh		;6345   ; tres listas de tiles y una de sprites: todo lo que hace falta para los menus
	ld hl,06c7ch		;6348
	call 04ccdh		;634b
	ld hl,0620ah		;634e
	call 04ccdh		;6351
	ld hl,074efh		;6354
	jp 04f11h		;6357

; ----------------------------------------------------------------------
; DATOS tabla_nombres_gp: 16 punteros (E29D) a los flujos de tiles de los
;   nombres de los GP (0x6E37..0x6EC2), para 0x60D1
;   0x635a..0x637a  (32 bytes)
DATA_tabla_nombres_gp:
	defw 06e37h	; 635a
	defw 06e3fh	; 635c
	defw 06e4bh	; 635e
	defw 06e54h	; 6360
	defw 06e5ch	; 6362
	defw 06e64h	; 6364
	defw 06e6ch	; 6366
	defw 06e7bh	; 6368
	defw 06e89h	; 636a
	defw 06e92h	; 636c
	defw 06e9bh	; 636e
	defw 06ea2h	; 6370
	defw 06each	; 6372
	defw 06eb3h	; 6374
	defw 06ebbh	; 6376
	defw 06ec2h	; 6378

; ======================================================================
; CODIGO 0x637a..0x67b7  (1085 bytes)
; ======================================================================


RLE_A_BUFFER:		; A = ancho en columnas, HL = destino, DE = flujo; EA69 = EA6A = 0, C' = A (0x66B0)
	call INICIA_CONTADORES_BUFFER		;637a   ; el ancho en columnas viaja en C' y es lo que decide donde se corta cada fila
	jr RLE_BUFFER_CODIGO		;637d
RLE_A_BUFFER_DESTINO:		; el flujo empieza por la palabra de destino (tambien codigo 0x80); C' lo trae el llamador (p00 0x5FD0: 0x20)
	ex de,hl			;637f
	ld e,(hl)			;6380   ; por aqui el flujo empieza por su propio destino, dos bytes
	inc hl			;6381
	ld d,(hl)			;6382
	ex de,hl			;6383
	inc de			;6384
RLE_BUFFER_CODIGO:		; un codigo por vuelta; 00 = fin
	ld a,(de)			;6385   ; el 0x00 acaba el flujo
	and a			;6386
	ret z			;6387
	inc de			;6388
	ld b,a			;6389
	and 07fh		;638a   ; el bit 7 del codigo separa lo que se copia tal cual de lo demas
	cp b			;638c
	jr nz,RLE_BUFFER_MAS		;638d
	and a			;638f
	jr z,RLE_A_BUFFER_DESTINO		;6390   ; un 0x80 pelado no copia nada: es la marca de "aqui viene un destino nuevo"
RLE_BUFFER_COPIA:		; n bytes tal cual (n < 0x80)
	ld a,(de)			;6392   ; copiar es byte a byte porque hay que ir contando columnas
	inc de			;6393
	ld (hl),a			;6394
	inc hl			;6395
	exx			;6396
	inc (hl)			;6397   ; EA69 cuenta la columna, y al llegar al ancho se salta a la fila de abajo
	ld a,(hl)			;6398
	cp c			;6399
	exx			;639a
	call z,RLE_BUFFER_FILA_SIGUIENTE		;639b
	djnz RLE_BUFFER_COPIA		;639e
	jr RLE_BUFFER_CODIGO		;63a0
RLE_BUFFER_MAS:		; codigos >= 0x81: repetir (< 0xE1), serie creciente (< 0xF1) o decreciente
	ld a,b			;63a2
	sub 0e1h		;63a3   ; de 0x81 a 0xE0 es repetir; de 0xE1 arriba, series
	jr nc,RLE_BUFFER_SERIES		;63a5
	res 7,b		;63a7
	ld a,(de)			;63a9   ; el byte que se repite viene detras del codigo
	inc de			;63aa
RLE_BUFFER_REPITE:		; el mismo byte n&0x7F veces
	ld (hl),a			;63ab
	push af			;63ac   ; el `push af` es para no perder el byte: el salto de fila se lleva A por delante
	inc hl			;63ad
	exx			;63ae
	inc (hl)			;63af   ; y en cada byte hay que mirar si toca cambiar de fila
	ld a,(hl)			;63b0
	cp c			;63b1
	exx			;63b2
	call z,RLE_BUFFER_FILA_SIGUIENTE		;63b3
	pop af			;63b6
	djnz RLE_BUFFER_REPITE		;63b7
	jr RLE_BUFFER_CODIGO		;63b9
RLE_BUFFER_SERIES:		; n = codigo - 0xE1: < 0x10 creciente, si no decreciente
	ld b,a			;63bb
	sub 010h		;63bc   ; por debajo de 0x10 la serie sube y de ahi arriba baja
	jr nc,RLE_BUFFER_DECRECIENTE		;63be
	inc b			;63c0
	ld a,(de)			;63c1
	inc de			;63c2
	ld c,a			;63c3
RLE_BUFFER_CRECIENTE:		; t, t+1, t+2... (n+1 valores)
	ld a,c			;63c4   ; la serie creciente escribe t, t+1, t+2...: sirve para las filas de tiles numeradas
	ld (hl),a			;63c5
	inc hl			;63c6
	exx			;63c7
	inc (hl)			;63c8   ; el contador de columna se lleva en el juego alterno para no gastar registros
	ld a,(hl)			;63c9
	cp c			;63ca
	exx			;63cb
	call z,RLE_BUFFER_FILA_SIGUIENTE		;63cc
	inc c			;63cf
	djnz RLE_BUFFER_CRECIENTE		;63d0
	jr RLE_BUFFER_CODIGO		;63d2
RLE_BUFFER_DECRECIENTE:		; t, t-1, t-2... (n+1 valores)
	ld b,a			;63d4
	inc b			;63d5
	ld a,(de)			;63d6
	inc de			;63d7
	ld c,a			;63d8
RLE_BUFFER_DECRECIENTE_BUCLE:		; un valor por vuelta
	ld a,c			;63d9   ; y esta la misma al reves
	ld (hl),a			;63da
	inc hl			;63db
	exx			;63dc
	inc (hl)			;63dd   ; lo mismo, con el valor bajando
	ld a,(hl)			;63de
	cp c			;63df
	exx			;63e0
	call z,RLE_BUFFER_FILA_SIGUIENTE		;63e1
	dec c			;63e4
	djnz RLE_BUFFER_DECRECIENTE_BUCLE		;63e5
	jr RLE_BUFFER_CODIGO		;63e7
RLE_BUFFER_FILA_SIGUIENTE:		; EA69 = 0 y HL += 32 - C' (fin de fila del rectangulo)
	push bc			;63e9   ; fin de fila: la columna vuelve a cero y el puntero salta lo que falte hasta las 32 casillas del buffer
	exx			;63ea
	xor a			;63eb
	ld (hl),a			;63ec
	ld a,020h		;63ed   ; 32 menos el ancho es lo que sobra de la fila
	sub c			;63ef
	exx			;63f0
	ld c,a			;63f1
	ld b,000h		;63f2
	add hl,bc			;63f4
	pop bc			;63f5
	ret			;63f6
ENTRA_ELECCION_COCHE:		; E250 = 6: limpia (p00 0x465B, 0x5F8D), tiles 16..58 con 0xE0 y 0..15 macizos, texto p03 0xABAD; E250++ (pasa a 7), E27F = 1, cursor 0xBBB7 y el resto de 0x6417
	call 0465bh		;63f7   ; la pantalla de eleccion de coche se monta de cero
	call 05f8dh		;63fa
	ld a,0e0h		;63fd
	call 04476h		;63ff   ; los tiles 16 a 58 en blanco (0xE0) y los 0 a 15 macizos: el marco de las fichas
	call 04496h		;6402
	ld de,0abadh		;6405
	call 04b8fh		;6408
	ld hl,0e250h		;640b
	inc (hl)			;640e
	ld a,001h		;640f
	ld (0e27fh),a		;6411   ; E27F = 1: de momento solo dos opciones
	ld hl,0bbb7h		;6414
PINTA_PANTALLA_COCHE:		; cursor HL (4 bytes) a EA88; borra E400 (0x21F bytes); VRAM (0x6635); tiles (0x6781); hasta 3 valores de la fila E251 de la tabla p03 0xBC45 (0x676C) pintados en E422/E42C/E436 (0x6611); 0xFF acaba
	ld de,0ea88h		;6417
	ld bc,00004h		;641a
	ldir		;641d
	ld hl,0e400h		;641f   ; 0x21F bytes del buffer a cero: las 17 filas de arriba
	ld bc,0021fh		;6422
	call 04b87h		;6425
	call VUELCA_544_NOMBRES		;6428
	call CARGA_TILES_FICHAS		;642b
	call FILA_TABLA_BC45		;642e   ; cada paso de la eleccion tiene su fila en la tabla p03 0xBC45, con hasta tres fichas
	ld a,(hl)			;6431
	inc a			;6432   ; un 0xFF cierra la fila: hay pasos con una ficha y pasos con tres
	ret z			;6433
	push hl			;6434
	ld de,0e422h		;6435   ; las tres fichas van a E422, E42C y E436: tres columnas separadas diez casillas
	call PINTA_FICHA		;6438
	pop hl			;643b
	inc hl			;643c
	ld a,(hl)			;643d
	inc a			;643e
	ret z			;643f
	push hl			;6440
	ld de,0e42ch		;6441
	call PINTA_FICHA		;6444
	pop hl			;6447
	inc hl			;6448
	ld a,(hl)			;6449
	inc a			;644a
	ret z			;644b
	ld de,0e436h		;644c
	jp PINTA_FICHA		;644f
ELECCION_COCHE:		; E250 = 7: VRAM (0x6635); por E251: 0 -> 0x6521, >= 6 -> 0x64F3; si E252 = 2 -> desliza (0x65DE); si no 0x6469
	call VUELCA_544_NOMBRES		;6452   ; el buffer se vuelca en cada fotograma, que la pantalla se mueve
	ld a,(0e251h)		;6455
	and a			;6458
	jp z,ELECCION_POR_E252		;6459
	cp 006h		;645c   ; del paso 6 en adelante ya no se elige nada, se contesta si o no
	jp nc,ELECCION_SI_NO		;645e
	ld a,(0e252h)		;6461
	cp 002h		;6464   ; E252 = 2 es el panel deslizandose: mientras dure, el mando no pinta nada
	jp z,DESLIZA_PANEL		;6466
ELECCION_MANDO:		; flancos del mando activo: izquierda (bit 2) -> 0x6580, derecha (bit 3) -> 0x6599, boton (bit 4): sonido 0x26, guarda la eleccion en (0x67F0)+E251-1 y pasa al paso siguiente (tabla 0x67E4 de textos) o, en el paso 5, a 0x64AC
	call FLANCOS_MANDO_ACTIVO		;6469
	rra			;646c   ; tres rotaciones para el bit 2 (izquierda), una mas para el 3 (derecha) y otra para el 4 (boton)
	rra			;646d
	rra			;646e
	jp c,ELECCION_IZQUIERDA		;646f
	rra			;6472
	jp c,ELECCION_DERECHA		;6473
	rra			;6476
	ret nc			;6477
	ld a,026h		;6478
	call 04174h		;647a
	call BLOQUE_ELECCION		;647d   ; HL = E297 (jugador 1) o E357 (jugador 2): donde se apuntan las elecciones
	ld a,(0e251h)		;6480   ; el paso 0 es el coche entero; del 1 en adelante se elige pieza a pieza
	and a			;6483
	jr z,ELECCION_PASO_0		;6484
	dec a			;6486
	call 040d0h		;6487   ; la eleccion se apunta en el bloque del jugador, un byte por paso
	push hl			;648a
	call FILA_TABLA_BC45		;648b
	call VALOR_FILA_E27E		;648e   ; A = el valor elegido (fila E251 de p03 0xBC45, columna E27E)
	pop hl			;6491
	ld (hl),a			;6492
	ld a,(0e251h)		;6493
	cp 005h		;6496   ; el paso 5 es el ultimo: la caja de cambios
	jr z,CONFIRMA_ELECCION		;6498
	ld hl,067e4h		;649a   ; tabla 0x67E4: pares (texto a borrar, texto a pintar) por paso E251 (p03 0xABE3..0xABFB)
	add a,a			;649d   ; dos palabras por paso: el texto que se borra y el que se pinta
	call 040d0h		;649e
	ld e,(hl)			;64a1
	inc hl			;64a2
	ld d,(hl)			;64a3
	inc hl			;64a4
	ld a,(hl)			;64a5
	inc hl			;64a6
	ld h,(hl)			;64a7
	ld l,a			;64a8
	jp CAMBIA_TEXTOS		;64a9
CONFIRMA_ELECCION:		; pinta p03 0xAC07; E251 = 7 (o 6 si venia de 0); cursor 0xBBBB, E27E = 0, E27F = 1
	ld de,0ac07h		;64ac
	call 04b8fh		;64af   ; el rotulo de "de acuerdo" p03 0xAC07
	ld a,(0e251h)		;64b2
	and a			;64b5
	ld a,007h		;64b6   ; si se venia del paso 0 -el coche predefinido- se salta al 7 y no al 6
	jr z,ELECCION_FIN		;64b8
	ld a,006h		;64ba
ELECCION_FIN:		; E251 = A; cursor p03 0xBBBB a EA88; E27E = 0, E27F = 1
	ld (0e251h),a		;64bc
	ld hl,0bbbbh		;64bf
	ld de,0ea88h		;64c2   ; el cursor cambia de sitio para la pregunta de si o no
	ld bc,00004h		;64c5
	ldir		;64c8
	xor a			;64ca
	ld (0e27eh),a		;64cb
	inc a			;64ce
	ld (0e27fh),a		;64cf
	ret			;64d2
ELECCION_PASO_0:		; copia los 5 bytes del coche elegido (0x6568) y confirma (0x64AC)
	call COPIA_5_BYTES_COCHE		;64d3   ; el coche predefinido trae sus cinco bytes hechos: no hay nada que elegir
	jr CONFIRMA_ELECCION		;64d6
SIGUIENTE_JUGADOR:		; con dos jugadores (bit 5 de E1C2): E25F++ y si != 2 vuelve a E250 = 6; si no limpia (0x465B) y E250 = 0x0A
	ld a,(0e1c2h)		;64d8
	bit 5,a		;64db   ; con un solo jugador no hay turno que pasar
	jr z,A_ESTADO_0A		;64dd
	ld hl,0e25fh		;64df
	inc (hl)			;64e2
	ld a,(hl)			;64e3
	cp 002h		;64e4   ; con dos jugadores se vuelve al estado 6 para que elija el segundo; cuando E25F llega a 2 ya han elegido los dos
	ld a,006h		;64e6
	jp nz,PON_ESTADO		;64e8
A_ESTADO_0A:		; p00 0x465B y E250 = 0x0A
	call 0465bh		;64eb
	ld a,00ah		;64ee
	jp PON_ESTADO		;64f0
ELECCION_SI_NO:		; E251 >= 6: cursor por p03 0xBBE1 (0x6266); boton: E27E = 0 -> 0x64D8; si no borra 0xAC07, E251 = 0 y E250 = 6 (si E251 era 7) o textos 0xABFB/0xABE3 (0x6756)
	ld hl,0bbe1h		;64f3   ; esta es la pregunta de si o no, con su propia tabla de cursor
	call MUEVE_CURSOR_MANDO_ACTIVO		;64f6
	call BOTON_MANDO_ACTIVO		;64f9
	ret z			;64fc
	ld a,(0e27eh)		;64fd   ; la opcion 0 es "si": se da por buena la eleccion
	and a			;6500
	jr z,SIGUIENTE_JUGADOR		;6501
	ld de,0ac07h		;6503
	call 04b99h		;6506
	ld a,(0e251h)		;6509   ; y con la 1 se vuelve a empezar; el paso 7 -el coche predefinido- vuelve al estado 6 entero
	cp 007h		;650c
	ld a,000h		;650e
	ld (0e251h),a		;6510
	ld a,006h		;6513
	jp z,PON_ESTADO		;6515
	ld de,0abfbh		;6518
	ld hl,0abe3h		;651b
	jp CAMBIA_TEXTOS		;651e
ELECCION_POR_E252:		; E252: 1 -> 0x6469; >= 2 -> 0x65DE; 0 -> cursor por p03 0xBBDD; boton: E27E != 0 -> textos 0xABAD/0xABD9 y 0x67CF; E27E = 0 -> borra 0xABAD, pinta 0xABCA, cursor 0xBBB3, E252++ y 0x67CF
	ld a,(0e252h)		;6521   ; E252 reparte: 0 elegir, 1 mando y 2 o mas el panel deslizandose
	dec a			;6524
	jp z,ELECCION_MANDO		;6525
	jp p,DESLIZA_PANEL		;6528
	ld hl,0bbddh		;652b
	call MUEVE_CURSOR_MANDO_ACTIVO		;652e
	call BOTON_MANDO_ACTIVO		;6531
	ret z			;6534
	ld a,(0e27eh)		;6535   ; la opcion 0 es el coche predefinido y la 1 montarlo pieza a pieza
	and a			;6538
	jr z,ELECCION_OPCION_0		;6539
	ld de,0abadh		;653b
	ld hl,0abd9h		;653e
	call CAMBIA_TEXTOS		;6541
	jp PINTA_JUGADOR		;6544
ELECCION_OPCION_0:		; borra 0xABAD, pinta 0xABCA, cursor 0xBBB3, E252++, 0x67CF
	ld de,0abadh		;6547
	call 04b99h		;654a   ; se borra el rotulo de la pregunta y se pinta el de la eleccion
	ld de,0abcah		;654d
	call 04b8fh		;6550
	ld hl,0bbb3h		;6553
	ld de,0ea88h		;6556
	ld bc,00004h		;6559   ; el cursor entero, cuatro bytes
	ldir		;655c
	ld hl,0e252h		;655e
	inc (hl)			;6561
	jp PINTA_JUGADOR		;6562
GUARDA_COCHE_ELEGIDO:		; HL = E297/E357 (0x67F0) y 0x6568
	call BLOQUE_ELECCION		;6565
COPIA_5_BYTES_COCHE:		; copia a (HL) los 5 bytes de la entrada (valor de p03 0xBC45 por E251/E27E) de la tabla p03 0xBBEB (5 bytes por entrada)
	push hl			;6568
	call FILA_TABLA_BC45		;6569   ; el valor elegido es la columna E27E de la fila E251 de la tabla de p03
	call VALOR_FILA_E27E		;656c
	ld hl,0bbebh		;656f
	ld b,a			;6572
	add a,a			;6573   ; por cinco: cada coche predefinido son cinco bytes (motor, carroceria, dos mas y caja de cambios)
	add a,a			;6574
	add a,b			;6575
	call 040d0h		;6576
	pop de			;6579
	ld bc,00005h		;657a
	ldir		;657d
	ret			;657f
ELECCION_IZQUIERDA:		; E27E--; si pasa de 0 lo deja en 0; si no, EA89 (x del cursor): si es 0x48 -> panel desde la izquierda (C = 0) (0x65B8), si no EA89 -= 0x50 y sonido 0x25
	ld hl,0e27eh		;6580
	dec (hl)			;6583   ; el `inc a` detras del `dec (hl)` es la prueba de que se ha pasado de 0
	ld a,(hl)			;6584
	inc a			;6585
	jr nz,ELECCION_IZQ_CURSOR		;6586
	inc (hl)			;6588
	ret			;6589
ELECCION_IZQ_CURSOR:		; EA89 == 0x48: entra el panel; si no, EA89 -= 0x50
	ld hl,0ea89h		;658a
	ld a,(hl)			;658d
	cp 048h		;658e   ; 0x48 es el borde izquierdo: alli el cursor ya no se mueve mas y lo que se desliza es el panel
	ld c,0b0h		;6590   ; 0xB0 es lo que retrocede el cursor cuando aun le queda sitio
	jp nz,CURSOR_SUMA_C		;6592
	ld c,000h		;6595
	jr ARRANCA_PANEL		;6597
ELECCION_DERECHA:		; E27E++; si la fila E251 de 0xBC45 no tiene mas (0xFF) lo deshace; EA89 == 0xE8 -> panel desde la derecha (C = 1), si no EA89 += 0x50 y sonido 0x25
	ld hl,0e27eh		;6599
	inc (hl)			;659c   ; se prueba a avanzar y, si la fila no tiene mas fichas (0xFF), se deshace
	call FILA_TABLA_BC45		;659d
	call VALOR_FILA_E27E		;65a0
	inc a			;65a3
	jr nz,ELECCION_DER_CURSOR		;65a4
	ld hl,0e27eh		;65a6
	dec (hl)			;65a9
	ret			;65aa
ELECCION_DER_CURSOR:		; EA89 == 0xE8: entra el panel; si no, EA89 += 0x50
	ld hl,0ea89h		;65ab
	ld a,(hl)			;65ae
	cp 0e8h		;65af   ; 0xE8 es el borde derecho
	ld c,050h		;65b1
	jp nz,CURSOR_SUMA_C		;65b3
	ld c,001h		;65b6
ARRANCA_PANEL:		; E25D = C (lado), E25E = 10 (pasos), E252 = 2; borra E920.. (0xFF bytes); pinta en E821 el valor (E251, E27E) (0x6611); sonido 0x25
	ld a,c			;65b8
	ld (0e25dh),a		;65b9   ; E25D dice por que lado entra el panel y E25E cuantos pasos le quedan
	ld a,00ah		;65bc
	ld (0e25eh),a		;65be
	ld a,002h		;65c1
	ld (0e252h),a		;65c3
	ld hl,0e920h		;65c6   ; 0xFF bytes de E920 a cero: el sitio donde se monta la ficha que entra
	ld bc,000ffh		;65c9
	call 04b87h		;65cc
	call FILA_TABLA_BC45		;65cf
	call VALOR_FILA_E27E		;65d2
	ld de,0e821h		;65d5
	inc a			;65d8   ; el `inc a` es lo que convierte el indice en el de la ficha siguiente
	call PINTA_FICHA		;65d9
	jr SONIDO_25_B		;65dc
DESLIZA_PANEL:		; un paso por fotograma: E25D = 1 -> 0x671C (hacia la derecha), si no 0x66E7 (hacia la izquierda); E25E--; al llegar a 0, E252 = 1 (o 0 si E251 = 0)
	ld a,(0e25dh)		;65de   ; un paso de deslizamiento por fotograma, diez en total
	dec a			;65e1
	jr z,DESLIZA_IZQUIERDA		;65e2
	ld hl,0e41dh		;65e4   ; hacia la derecha se copia de E41D a E41E, o sea todo un byte mas alla
	ld de,0e41eh		;65e7
	call DESPLAZA_VENTANA_DER		;65ea
	jr DESLIZA_CUENTA		;65ed
DESLIZA_IZQUIERDA:		; ventana E401.. desplazada a la izquierda
	ld hl,0e402h		;65ef   ; y hacia la izquierda al reves
	ld de,0e401h		;65f2
	call DESPLAZA_VENTANA_IZQ		;65f5
DESLIZA_CUENTA:		; E25E--; al acabar E252 = 1 (0 si E251 = 0)
	ld hl,0e25eh		;65f8
	dec (hl)			;65fb
	ret nz			;65fc
	ld a,(0e251h)		;65fd   ; al acabar, el paso 0 vuelve a 0 y los demas a 1
	and a			;6600
	ld a,001h		;6601
	jr z,DESLIZA_FIN		;6603
	dec a			;6605
DESLIZA_FIN:		; E252 = A
	ld (0e252h),a		;6606
	ret			;6609
CURSOR_SUMA_C:		; EA89 += C y sonido 0x25
	add a,c			;660a   ; el cursor se mueve C pixeles y suena
	ld (hl),a			;660b
SONIDO_25_B:		; ENCOLA_SONIDO 0x25
	ld a,025h		;660c
	jp 04174h		;660e

; ----------------------------------------------------------------------
; Pinta en el buffer (DE) la ficha A de la fila E251: el grafico de
; 8 columnas (p08/p09, tablas 0x67C3) con 0x637A, el texto (tabla
; 0x67B7, p09/p11 0xBBxx/0xBDxx) en 8 filas x 9 columnas, y el marco (0x66BC).
; ----------------------------------------------------------------------
PINTA_FICHA:		; texto de la ficha A a EA6B (0x67A2); DE = grafico (0x6644); 0x6657 los pinta en (DE); marco en DE - 0x21 (0x66BC)
	push de			;6611
	push af			;6612
	call TEXTO_FICHA		;6613   ; la ficha son tres cosas: el texto, el dibujo y el marco
	pop af			;6616
	call GRAFICO_FICHA		;6617
	pop de			;661a
	push de			;661b
	call PINTA_GRAFICO_Y_TEXTO_FICHA		;661c
	pop de			;661f
	ex de,hl			;6620
	ld de,00021h		;6621   ; el marco se pinta 0x21 casillas por delante: una fila y una columna antes
	or a			;6624
	sbc hl,de		;6625
	jp PINTA_MARCO_FICHA		;6627
VUELCA_512_NOMBRES:		; p00 0x477C (pendiente) y copia E400.. (0x200 bytes) a la tabla de nombres 0x3800
	call 0477ch		;662a
VUELCA_512_NOMBRES_SIN:		; idem sin el 0x477C
	ld hl,03800h		;662d   ; 0x200 bytes son las 16 filas de arriba de la tabla de nombres
	ld bc,00200h		;6630
	jr COPIA_BUFFER_VRAM		;6633
VUELCA_544_NOMBRES:		; p00 0x477C y copia E400.. (0x220 bytes) a VRAM 0x38E0 (desde la fila 7)
	call 0477ch		;6635
	ld hl,038e0h		;6638   ; 0x38E0 es la fila 7: las de arriba las deja quietas quien pinta el rotulo
	ld bc,00220h		;663b
COPIA_BUFFER_VRAM:		; LDIRVM de E400 (BC bytes) a VRAM HL
	ld de,0e400h		;663e   ; el origen es siempre el buffer de E400; lo que cambia es cuanto y a donde
	jp 047cfh		;6641
GRAFICO_FICHA:		; HL = tabla 0x67C3[E251] (punteros por paso); DE = entrada (A-1)&0x7F de esa tabla (flujo RLE en p08/p09)
	push af			;6644
	ld de,067c3h		;6645   ; dos tablas encadenadas: primero el paso (E251) y luego la ficha dentro del paso
	ld a,(0e251h)		;6648
	call 04a3bh		;664b
	pop af			;664e
	dec a			;664f
	and 07fh		;6650   ; el `dec a` y el `and 0x7f` son porque la ficha llega contada desde 1 y con el bit 7 puesto en algunos sitios
	call 04a3bh		;6652
	ex de,hl			;6655
	ret			;6656
PINTA_GRAFICO_Y_TEXTO_FICHA:		; paginas 8/9 en 8000/A000; descomprime el grafico (8 columnas) en HL (0x637A); el texto (EA6B) a EC02 (0x691B); y lo pinta en HL-1 en 8 filas x 9 columnas (0x666E); acaba en 1/2/3
	ex de,hl			;6657
	ld a,008h		;6658
	call 04447h		;665a   ; MAPEA_A_EN_8000 con 8: paginas 8 y 9
	ld a,008h		;665d
	call RLE_A_BUFFER		;665f   ; ocho columnas de ancho tiene el dibujo de la ficha
	push hl			;6662
	ld hl,(0ea6bh)		;6663
	call EXPANDE_TEXTO_5F		;6666
	pop hl			;6669
	dec hl			;666a
	ld bc,00809h		;666b   ; ocho filas de nueve columnas para el texto, justo debajo
PINTA_TEXTO_EC02_E0:		; texto EC02 en (HL) con la fuente +0xE0; B = filas, C = columnas (p02 0x838C llama aqui)
	ld de,0ec02h		;666e
	exx			;6671
	ld b,0e0h		;6672   ; B' = 0xE0 es la fuente pequena, la de las fichas
	exx			;6674
PINTA_TEXTO_BUFFER:		; texto (DE) en el buffer (HL+1..): caracter + B' (fuente), espacio = 0, 1 = salto de linea, 0x5F = fin (y MAPEA_1_2_3); caja de C columnas x B filas (EA69/EA6A)
	call INICIA_CONTADORES_BUFFER		;6675   ; los dos contadores -columna y fila dentro de la caja- empiezan a cero
PINTA_TEXTO_CARACTER:		; un caracter por vuelta
	ld a,(de)			;6678
	inc de			;6679
	cp 001h		;667a   ; el 1 es salto de linea y el 0x5F el final del texto
	jr z,PINTA_TEXTO_FILA		;667c
	cp 05fh		;667e
	jp z,043feh		;6680
	inc hl			;6683
	exx			;6684
	cp 020h		;6685   ; el espacio no lleva letra: se queda el tile 0
	jr z,PINTA_TEXTO_ESPACIO		;6687
	add a,b			;6689   ; a cada letra se le suma la fuente, que es lo unico que cambia entre una pantalla y otra
	jr PINTA_TEXTO_ESCRIBE		;668a
PINTA_TEXTO_ESPACIO:		; el espacio (0x20) es el tile 0
	sub 020h		;668c
PINTA_TEXTO_ESCRIBE:		; (HL) = tile; EA69++; al llegar a C, fila nueva
	exx			;668e
	ld (hl),a			;668f
	push hl			;6690
	ld hl,0ea69h		;6691
	inc (hl)			;6694   ; EA69 cuenta la columna y se compara con el ancho de la caja
	ld a,(hl)			;6695
	pop hl			;6696
	cp c			;6697
	jr nz,PINTA_TEXTO_CARACTER		;6698
PINTA_TEXTO_FILA:		; HL += 32 - columna (fila siguiente del buffer); EA6A++; al llegar a B acaba con MAPEA_1_2_3
	exx			;669a
	ld a,020h		;669b   ; fin de fila: se salta lo que falta hasta las 32 casillas del buffer
	sub (hl)			;669d
	ld (hl),000h		;669e
	inc hl			;66a0
	exx			;66a1
	call 040d0h		;66a2
	exx			;66a5
	inc (hl)			;66a6   ; y EA6A cuenta las filas: al llegar al alto, se acabo
	ld a,(hl)			;66a7
	dec hl			;66a8
	exx			;66a9
	cp b			;66aa
	jr nz,PINTA_TEXTO_CARACTER		;66ab
	jp 043feh		;66ad
INICIA_CONTADORES_BUFFER:		; EA69 = EA6A = 0; C' = A
	exx			;66b0   ; C' guarda el ancho durante todo el recorrido, que es lo unico que no cabe en la memoria de los contadores
	ld hl,0ea6ah		;66b1
	ld (hl),000h		;66b4
	dec hl			;66b6
	ld (hl),000h		;66b7
	ld c,a			;66b9
	exx			;66ba
	ret			;66bb
PINTA_MARCO_FICHA:		; marco de tiles en el buffer HL: esquinas 0x0C/0x0D y 0x0E/0x0F, lados 0x0A (horizontal) y 0x0B (vertical, 15 filas), 8 de ancho
	ld c,00ch		;66bc   ; el marco son seis tiles: dos esquinas arriba, dos abajo, uno horizontal y uno vertical
	call MARCO_HORIZONTAL		;66be
	ld a,00bh		;66c1
	ld b,00fh		;66c3   ; quince filas de alto
MARCO_LADOS:		; una fila de lados (0x0B en HL y HL+9) por vuelta
	ld (hl),a			;66c5
	ld e,009h		;66c6   ; nueve casillas separan los dos lados del marco
	ld d,000h		;66c8
	add hl,de			;66ca
	ld (hl),a			;66cb
	ld e,017h		;66cc   ; y 0x17 mas para caer en la fila siguiente
	ld d,000h		;66ce
	add hl,de			;66d0
	djnz MARCO_LADOS		;66d1
	ld c,00eh		;66d3
MARCO_HORIZONTAL:		; esquina C, 8 tiles 0x0A y esquina C+1; HL += 0x17
	ld b,008h		;66d5   ; ocho tiles horizontales entre las dos esquinas
	ld a,00ah		;66d7
	ld (hl),c			;66d9
	inc c			;66da
	inc hl			;66db
MARCO_HORIZONTAL_BUCLE:		; un tile 0x0A por vuelta
	ld (hl),a			;66dc   ; ocho tiles horizontales entre las esquinas
	inc hl			;66dd
	djnz MARCO_HORIZONTAL_BUCLE		;66de
	ld (hl),c			;66e0
	ld e,017h		;66e1
	ld d,000h		;66e3
	add hl,de			;66e5
	ret			;66e6
DESPLAZA_VENTANA_IZQ:		; 17 filas de 29 bytes desde (HL) a (DE) = HL-1 (ldir); la columna nueva de cada fila sale de E800 + fila*32 + (10 - E25E)
	ld b,011h		;66e7   ; diecisiete filas, y cada una se corre con un `ldir` de 29 bytes
DESPLAZA_IZQ_FILA:		; una fila por vuelta
	push bc			;66e9
	ld bc,0001dh		;66ea   ; 0x1D bytes por fila: 29 casillas corridas de golpe
	ldir		;66ed
	pop bc			;66ef
	push bc			;66f0
	ld a,011h		;66f1   ; la fila por 32: la columna nueva sale del bloque de E800, que es donde se monto la ficha que entra
	sub b			;66f3
	push hl			;66f4
	ld l,a			;66f5
	ld h,000h		;66f6
	add hl,hl			;66f8   ; la fila por 32, que es lo que mide una fila del buffer
	add hl,hl			;66f9
	add hl,hl			;66fa
	add hl,hl			;66fb
	add hl,hl			;66fc
	push de			;66fd
	ld de,0e800h		;66fe
	add hl,de			;6701   ; el bloque de E800 es donde se monto la ficha nueva
	pop de			;6702
	ld a,(0e25eh)		;6703
	ld b,a			;6706
	ld a,00ah		;6707   ; y la columna que toca es 10 menos lo que quede de deslizamiento
	sub b			;6709
	call 040d0h		;670a
	ldi		;670d   ; un solo `ldi`: la columna que entra es una casilla por fila
	pop hl			;670f
	inc hl			;6710   ; y de una fila a la siguiente hay que saltar dos casillas mas
	ld bc,00002h		;6711
	add hl,bc			;6714
	ex de,hl			;6715
	add hl,bc			;6716
	ex de,hl			;6717
	pop bc			;6718
	djnz DESPLAZA_IZQ_FILA		;6719
	ret			;671b
DESPLAZA_VENTANA_DER:		; 17 filas de 29 bytes con lddr (hacia la derecha); la columna nueva de E800 + fila*32 + E25E - 1
	ld b,011h		;671c   ; la misma faena al reves, con `lddr`, y la columna nueva por el otro lado
DESPLAZA_DER_FILA:		; una fila por vuelta
	push bc			;671e   ; la misma faena hacia el otro lado
	ld bc,0001dh		;671f   ; 0x1D bytes con `lddr`: de derecha a izquierda para no pisarse
	lddr		;6722
	pop bc			;6724
	push bc			;6725
	ld a,011h		;6726   ; la fila por 32 otra vez
	sub b			;6728
	push hl			;6729   ; se guarda el destino: la columna nueva se busca aparte
	ld l,a			;672a
	ld h,000h		;672b
	add hl,hl			;672d
	add hl,hl			;672e
	add hl,hl			;672f
	add hl,hl			;6730
	add hl,hl			;6731
	push de			;6732
	ld de,0e800h		;6733
	add hl,de			;6736
	pop de			;6737
	ld a,(0e25eh)		;6738   ; la columna que entra es la que diga lo que queda de deslizamiento
	dec a			;673b
	call 040d0h		;673c
	ldd		;673f   ; un solo `ldd`: el byte que entra por la derecha
	pop hl			;6741
	dec hl			;6742
	ld bc,0003eh		;6743   ; 0x3E son las dos filas que hay que subir para caer en la siguiente, ya contando el byte que se acaba de escribir
	add hl,bc			;6746
	ex de,hl			;6747
	add hl,bc			;6748
	ex de,hl			;6749
	pop bc			;674a
	djnz DESPLAZA_DER_FILA		;674b
	ret			;674d
VALOR_FILA_E27E:		; A = byte E27E de la fila HL (la entrada de la tabla p03 0xBC45 que dejo 0x676C)
	ld a,(0e27eh)		;674e   ; la columna del cursor es la que elige el valor dentro de la fila
	call 040d0h		;6751
	ld a,(hl)			;6754
	ret			;6755
CAMBIA_TEXTOS:		; borra el texto HL, pinta el DE, E27E = 0, E251++, cursor p03 0xBBB3 y repinta (0x6417)
	push hl			;6756
	call 04b99h		;6757   ; primero se borra el rotulo viejo y luego se pinta el nuevo, en el mismo sitio
	pop de			;675a
	call 04b8fh		;675b
	xor a			;675e
	ld (0e27eh),a		;675f
	ld hl,0e251h		;6762
	inc (hl)			;6765   ; y de paso se avanza el paso y se vuelve a montar la pantalla
	ld hl,0bbb3h		;6766
	jp PINTA_PANTALLA_COCHE		;6769
FILA_TABLA_BC45:		; HL = p03 0xBC45 + categoria*12 (6 palabras por categoria), palabra E251 de ahi: la fila de valores del paso E251 (acaba en 0xFF)
	ld hl,0bc45h		;676c   ; doce bytes por categoria: seis palabras, una por paso
	ld a,(0e25bh)		;676f
	add a,a			;6772   ; por cuatro y luego mas el doble: eso es por doce
	add a,a			;6773
	ld b,a			;6774
	add a,a			;6775
	add a,b			;6776
	ld e,a			;6777
	ld d,000h		;6778
	add hl,de			;677a
	ld a,(0e251h)		;677b
	jp 04a44h		;677e
CARGA_TILES_FICHAS:		; lista p04 0x6E0D (CARGA_LISTA_TILES) y la lista de la tabla p03 0xBD03[E251]; si E251 = 0 o 2, la subtabla por categoria
	ld hl,06e0dh		;6781
	call 04ccdh		;6784   ; la lista p04 0x6E0D lleva los tiles comunes de las fichas
	ld hl,0bd03h		;6787
	ld a,(0e251h)		;678a
	and a			;678d   ; los pasos 0 y 2 -el coche entero y la carroceria- tienen tiles distintos por categoria
	push af			;678e
	call 04a44h		;678f
	pop af			;6792
	jr z,CARGA_TILES_FICHAS_CATEGORIA		;6793
	cp 002h		;6795
	jr nz,CARGA_TILES_FICHAS_LISTA		;6797
CARGA_TILES_FICHAS_CATEGORIA:		; HL = tabla[E25B]
	ld a,(0e25bh)		;6799
	call 04a44h		;679c
CARGA_TILES_FICHAS_LISTA:		; CARGA_LISTA_TILES HL
	jp 04ccdh		;679f
TEXTO_FICHA:		; EA6B = tabla 0x67B7[E251] -> entrada (A-1)&0x7F (punteros a textos)
	push af			;67a2   ; el texto de la ficha se apunta en EA6B, que es de donde lo saca 0x6663
	ld hl,067b7h		;67a3
	ld a,(0e251h)		;67a6
	call 04a44h		;67a9
	pop af			;67ac
	dec a			;67ad   ; la ficha llega contada desde 1, como en el dibujo
	and 07fh		;67ae
	call 04a44h		;67b0
	ld (0ea6bh),hl		;67b3
	ret			;67b6

; ----------------------------------------------------------------------
; DATOS tabla_textos_fichas: 6 punteros (E251) a tablas de textos de las
;   fichas (p09/p11 0xBD1B, 0xBD3F, 0xBD87, 0xBDAB, 0xBDB7, 0xBDC3)
;   0x67b7..0x67c3  (12 bytes)
DATA_tabla_textos_fichas:
	defw 0bd1bh	; 67b7
	defw 0bd3fh	; 67b9
	defw 0bd87h	; 67bb
	defw 0bdabh	; 67bd
	defw 0bdb7h	; 67bf
	defw 0bdc3h	; 67c1

; ----------------------------------------------------------------------
; DATOS tabla_graficos_fichas: 6 punteros (E251) a tablas de flujos RLE de los
;   graficos de las fichas (p08/p09 0xBB0D, 0xBB31, 0xBB0D, 0xBB79, 0xBB85,
;   0xBB91)
;   0x67c3..0x67cf  (12 bytes)
DATA_tabla_graficos_fichas:
	defw 0bb0dh	; 67c3
	defw 0bb31h	; 67c5
	defw 0bb0dh	; 67c7
	defw 0bb79h	; 67c9
	defw 0bb85h	; 67cb
	defw 0bb91h	; 67cd

; ======================================================================
; CODIGO 0x67cf..0x67e6  (23 bytes)
; ======================================================================


PINTA_JUGADOR:		; pinta el texto p03 0xAC01 y en 0x386C (fila 3, col 12) el tile 0x11 (jugador 1) o 0x12 (jugador 2, E25F != 0)
	ld a,(0e25fh)		;67cf
	and a			;67d2
	ld a,011h		;67d3   ; el tile 0x11 es el 1 y el 0x12 el 2: el numero del jugador que esta eligiendo
	jr z,PINTA_JUGADOR_TILE		;67d5
	inc a			;67d7
PINTA_JUGADOR_TILE:		; el digito del jugador
	push af			;67d8
	ld de,0ac01h		;67d9
	call 04b8fh		;67dc
	ld hl,0386ch		;67df   ; fila 3, columna 12 de la tabla de nombres
	pop af			;67e2
	jp 0004dh		;67e3   ; BIOS WRTVRM - Writes data in VRAM

; ----------------------------------------------------------------------
; DATOS tabla_textos_pasos: 5 punteros a textos de p03 (borrar/pintar por paso
;   E251 = 1..3 de 0x6469): 0xABE3 0xABE9 0xABEF 0xABF5 0xABFB; el sexto,
;   0xAC01, va en el `ld de` de 0x67D9
;   0x67e6..0x67f0  (10 bytes)
DATA_tabla_textos_pasos:
	defw 0abe3h	; 67e6
	defw 0abe9h	; 67e8
	defw 0abefh	; 67ea
	defw 0abf5h	; 67ec
	defw 0abfbh	; 67ee

; ======================================================================
; CODIGO 0x67f0..0x6852  (98 bytes)
; ======================================================================


BLOQUE_ELECCION:		; HL = E297 si E25F = 0 (jugador 1), si no E357
	ld hl,0e297h		;67f0   ; los dos jugadores tienen su bloque, y E25F dice cual toca
	ld a,(0e25fh)		;67f3
	and a			;67f6
	ret z			;67f7
	ld hl,0e357h		;67f8
	ret			;67fb
L_67FC:
	ld b,a			;67fc   ; lo mismo pero con IX y cuatro bytes mas alla
	ld ix,0e29ch		;67fd
	ld a,(0e25fh)		;6801
	and a			;6804
	ld a,b			;6805
	ret z			;6806
	ld ix,0e35ch		;6807
	ret			;680b
ESTADO_0_DAMERO:		; limpia (p00 0x465B), pinta el damero (0x6822 con la tabla 0x6852), tiles de la lista p04 0x6CD1, E25E = 0 y p00 0x5BA2 (E250 = 1)
	call 0465bh		;680c   ; el damero es la pantalla de "READY": se pinta con una tabla de casillas
	ld de,06852h		;680f
	call PINTA_DAMERO		;6812
	ld hl,06cd1h		;6815
	call 04ccdh		;6818
	xor a			;681b
	ld (0e25eh),a		;681c   ; E25E hace de indice de la tabla mientras se pinta
	jp 05ba2h		;681f
PINTA_DAMERO:		; IY = E2C0, E25E = 0; una entrada de la tabla 0x6852 por vuelta (0x6833) hasta el 0xFF
	ld iy,0e2c0h		;6822
	xor a			;6826
	ld (0e25eh),a		;6827   ; se pinta de una vez, en un bucle, y no una casilla por fotograma
PINTA_DAMERO_BUCLE:		; siguiente casilla
	ld hl,06852h		;682a
	call CASILLA_DAMERO		;682d
	ret z			;6830
	jr PINTA_DAMERO_BUCLE		;6831
CASILLA_DAMERO:		; entrada E25E (3 bytes: y, x, tile) de la tabla 0x6852; 0xFF = fin (Z); si no rellena 8x8 tiles (p00 0x4B67) y NZ
	ld a,(0e25eh)		;6833
	inc a			;6836   ; el indice sube antes de leer: asi la siguiente vuelta ya apunta a la casilla siguiente
	ld (0e25eh),a		;6837
	dec a			;683a
	ld d,a			;683b
	add a,a			;683c   ; por tres, que las entradas son (y, x, tile)
	add a,d			;683d
	call 040d0h		;683e
	ld e,(hl)			;6841
	inc e			;6842   ; un 0xFF en la Y cierra la tabla
	ret z			;6843
	dec e			;6844
	inc hl			;6845
	ld d,(hl)			;6846
	inc hl			;6847
	ld a,(hl)			;6848
	ld bc,00808h		;6849   ; cada casilla del damero son 8 x 8 tiles
	call 04b67h		;684c   ; el relleno de 8 x 8 lo hace la rutina de rectangulos de p00
	or 0ffh		;684f
	ret			;6851

; ----------------------------------------------------------------------
; DATOS tabla_damero: 12 entradas (y, x, tile): casillas de 8x8 tiles (64 px)
;   de 0xFE y 0xFF alternados, 4 columnas x 3 filas, fin 0xFF
;   0x6852..0x6877  (37 bytes)
DATA_tabla_damero:
	defb 000h,000h,0feh	; 6852
	defb 000h,040h,0ffh	; 6855
	defb 000h,080h,0feh	; 6858
	defb 000h,0c0h,0ffh	; 685b
	defb 040h,000h,0ffh	; 685e
	defb 040h,040h,0feh	; 6861
	defb 040h,080h,0ffh	; 6864
	defb 040h,0c0h,0feh	; 6867
	defb 080h,000h,0feh	; 686a
	defb 080h,040h,0ffh	; 686d
	defb 080h,080h,0feh	; 6870
	defb 080h,0c0h,0ffh	; 6873
	defb 0ffh	; 6876

; ======================================================================
; CODIGO 0x6877..0x68d9  (98 bytes)
; ======================================================================


ESTADO_1_BLOQUES:		; E251 = 0: vuelca E400; cada 4 fotogramas un bloque mas (0x68AC); al acabar E25E = 0x14 y E251 = 1; luego E25E-- hasta 0 y E250 = 2
	ld a,(0e251h)		;6877   ; el estado 1 pinta la presentacion a trozos, sin bloquear el fotograma
	or a			;687a
	jr nz,ESTADO_1_ESPERA		;687b
	ld iy,0e2c0h		;687d
	call 044bch		;6881
	ld a,(0e1c3h)		;6884   ; un bloque cada cuatro fotogramas: asi la pantalla se va montando a la vista
	and 003h		;6887
	ret nz			;6889
	call PINTA_BLOQUE_PRESENTACION		;688a
	push af			;688d
	call 043feh		;688e
	pop af			;6891
	ret nz			;6892
	ld a,014h		;6893   ; y cuando se acaban los bloques, veinte fotogramas de regalo antes de seguir
	ld (0e25eh),a		;6895
	ld a,001h		;6898
	ld (0e251h),a		;689a
	ret			;689d
ESTADO_1_ESPERA:		; 20 fotogramas y E250 = 2
	ld hl,0e25eh		;689e   ; la espera del final, un fotograma por vuelta
	dec (hl)			;68a1
	ret nz			;68a2
A_ESTADO_2:		; E250 = 2
	ld a,002h		;68a3
	jr A_ESTADO_A		;68a5
A_ESTADO_19:		; E250 = 0x19 (lo llaman p00 0x5B66/0x5B69/0x5BCB y el despachador 0x71E1)
	ld a,019h		;68a7   ; el estado 0x19 es la vuelta al menu; lo piden desde varios sitios
A_ESTADO_A:		; PON_ESTADO A
	jp PON_ESTADO		;68a9
PINTA_BLOQUE_PRESENTACION:		; paginas 14/15 en 8000/A000; entrada E25E de la tabla 0x68D9 (y, x, flujo): 0xFF = fin (Z); si no descomprime el flujo (p15) en 8 columnas en la casilla (p00 0x4A9D) del buffer (0x637A); NZ
	ld a,00eh		;68ac
	call 04447h		;68ae   ; MAPEA_A_EN_8000 con 0x0E: los flujos 0xB6FC/0xB737 son de la pagina 15
	ld a,(0e25eh)		;68b1
	inc a			;68b4   ; el indice sube antes de usarse, igual que en el damero
	ld (0e25eh),a		;68b5
	dec a			;68b8
	add a,a			;68b9   ; por cuatro: cada entrada es un destino y un puntero
	add a,a			;68ba
	ld hl,068d9h		;68bb
	call 040d0h		;68be
	ld e,(hl)			;68c1
	inc e			;68c2   ; un 0xFF cierra la tabla
	ret z			;68c3
	dec e			;68c4
	inc hl			;68c5
	ld d,(hl)			;68c6
	inc hl			;68c7
	ld a,(hl)			;68c8
	inc hl			;68c9
	ld h,(hl)			;68ca
	ld l,a			;68cb
	push hl			;68cc
	call 04a9dh		;68cd   ; el destino viene como pareja (fila, columna) y 0x4A9D lo convierte en casilla del buffer
	pop de			;68d0
	ld a,008h		;68d1   ; ocho columnas de ancho tiene cada bloque
	call RLE_A_BUFFER		;68d3
	or 0ffh		;68d6
	ret			;68d8

; ----------------------------------------------------------------------
; DATOS tabla_68D9: 12 parejas (destino en el buffer, flujo en p15) y 0xFF:
;   las pantallas de 8 de ancho que pinta 0x68AC por (E25E)
;   0x68d9..0x690a  (49 bytes)
DATA_tabla_68D9:
	defw 00000h,0b6fch	; 68d9
	defw 04000h,0b737h	; 68dd
	defw 08000h,0b6fch	; 68e1
	defw 0c000h,0b737h	; 68e5
	defw 00040h,0b737h	; 68e9
	defw 04040h,0b6fch	; 68ed
	defw 08040h,0b737h	; 68f1
	defw 0c040h,0b6fch	; 68f5
	defw 00080h,0b6fch	; 68f9
	defw 04080h,0b737h	; 68fd
	defw 08080h,0b6fch	; 6901
	defw 0c080h,0b737h	; 6905
	defb 0ffh	; 6909

; ======================================================================
; CODIGO 0x690a..0x6d8e  (1156 bytes)
; ======================================================================


EXPANDE_TEXTO_FF:		; pagina 9 en A000; expande (HL) en EC02, cierra con 0xFF (para PINTA_TILES: p00 0x4B8F/0x4B99) y vuelve a 1/2/3
	ld a,009h		;690a
	call 04457h		;690c   ; el texto vive en la pagina 9, que se mapea aqui y se devuelve al acabar
	ld de,0ec02h		;690f
	call EXPANDE_TEXTO		;6912
	ld a,0ffh		;6915   ; el 0xFF cierra el texto para el pintador de tiles de p00
	ld (de),a			;6917
	jp 043feh		;6918
EXPANDE_TEXTO_5F:		; expande (HL) en EC02 y cierra con 0x5F (para 0x6675); la pagina 9 la mapea el llamador
	ld de,0ec02h		;691b
	call EXPANDE_TEXTO		;691e
	ld a,05fh		;6921   ; y el 0x5F para el pintador de buffers de 0x6675: son dos consumidores distintos
	ld (de),a			;6923
	ret			;6924
EXPANDE_TEXTO:		; C' = 10 (niveles de macro que quedan)
	exx			;6925
	ld c,00ah		;6926   ; C' son los niveles de macro que se permiten: diez
	exx			;6928
EXPANDE_BUCLE:		; un byte por vuelta: 0x5F fin; >= 0x60 macro (0x6943); si no lo copia; para en DE = 0xEE02
	ld a,(hl)			;6929
	cp 05fh		;692a   ; el 0x5F cierra el texto
	ret z			;692c
	inc hl			;692d
	cp 060h		;692e   ; de 0x60 en adelante no es una letra, es una macro: un trozo de texto que se repite
	call nc,EXPANDE_MACRO		;6930
	jr nc,EXPANDE_BUCLE		;6933
	ld (de),a			;6935
	inc de			;6936
	ld a,d			;6937   ; y el texto expandido no puede pasar de 0xEE02: ahi se corta
	cp 0eeh		;6938
	jr c,EXPANDE_BUCLE		;693a
	ret nz			;693c
	ld a,e			;693d
	cp 002h		;693e
	jr c,EXPANDE_BUCLE		;6940
	ret			;6942
EXPANDE_MACRO:		; si quedan niveles: HL = p09 0xA6DE[A-0x60] y se expande recursivamente (0x6929); C'++ al volver
	call EXPANDE_NIVEL		;6943   ; la macro se expande llamando al mismo bucle: los textos pueden llevar macros dentro de macros
	jr z,EXPANDE_MACRO_TOPE		;6946
	push hl			;6948
	push de			;6949
	sub 060h		;694a
	ld l,a			;694c
	ld h,000h		;694d
	add hl,hl			;694f   ; por dos, que la tabla de macros de p09 son punteros
	ld de,0a6deh		;6950
	add hl,de			;6953
	ld e,(hl)			;6954
	inc hl			;6955
	ld d,(hl)			;6956
	ex de,hl			;6957
	pop de			;6958
	call EXPANDE_BUCLE		;6959
	pop hl			;695c
	exx			;695d
	inc c			;695e   ; al volver se devuelve el nivel gastado
	exx			;695f
	or a			;6960
	ret			;6961
EXPANDE_MACRO_TOPE:		; sin niveles: A = 0 y carry (el byte se copia como 0)
	xor a			;6962   ; sin niveles que gastar la macro se copia como un cero, o sea como nada
	scf			;6963
	ret			;6964
EXPANDE_NIVEL:		; Z si C' = 0; si no C'--
	exx			;6965
	ld b,a			;6966
	ld a,c			;6967   ; C' a cero es "ya no se puede bajar mas"
	or a			;6968   ; el `or a` es lo que pone Z cuando ya no quedan niveles
	ld a,b			;6969
	exx			;696a
	ret z			;696b
	exx			;696c
	dec c			;696d
	exx			;696e
	ret			;696f
RANKING:		; E251 = 0: E252 = 0x10, (E27E) = 0x1E0 (contador de 16 bits), oculta los sprites (0x3B00 = 0xD0), panel de 1 jugador (0x6A9F), borra E400/EC00 (0x6CDE), los vuelca (0x6CB6, 0x6CD1), tiles (0x6D25), puntos de la posicion (0x6D43) y la ficha (0x69C5) por coche; E251++; E251 > 0 -> 0x6AB9
	ld a,(0e251h)		;6970   ; el ranking es la pantalla de resultados de despues de la carrera
	and a			;6973
	jp nz,RANKING_PASOS		;6974
	ld a,010h		;6977
	ld (0e252h),a		;6979
	ld hl,001e0h		;697c   ; 0x1E0 es la cuenta larga que la deja puesta un rato aunque nadie toque nada
	ld (0e27eh),hl		;697f
	ld hl,03b00h		;6982   ; el 0xD0 en el primer atributo apaga todos los sprites de golpe
	ld a,0d0h		;6985   ; y = 0xD0 en el primer atributo: ningun sprite visible
	call 0004dh		;6987   ; BIOS WRTVRM - Writes data in VRAM
	call PANEL_RANKING_1J		;698a
	call BORRA_E400_EC00		;698d
	call VUELCA_E400_RANKING		;6990
	ld a,(0e1c2h)		;6993   ; con dos jugadores hay dos fichas, una en cada buffer
	bit 5,a		;6996
	call nz,VUELCA_EC00_RANKING		;6998
	call CARGA_TILES_RANKING		;699b
	ld iy,0e2c0h		;699e
	call PUNTOS_POR_POSICION		;69a2
	ld hl,0e400h		;69a5
	ld (0ea70h),hl		;69a8   ; EA70 dice en que buffer se esta pintando: E400 el jugador 1 y EC00 el 2
	call PINTA_FICHA_RANKING		;69ab
	ld hl,0e251h		;69ae
	inc (hl)			;69b1
	ld a,(0e1c2h)		;69b2
	bit 5,a		;69b5
	ret z			;69b7
	ld iy,0e380h		;69b8
	call PUNTOS_POR_POSICION		;69bc
	ld hl,0ec00h		;69bf
	ld (0ea70h),hl		;69c2
PINTA_FICHA_RANKING:		; total (0x6BFC); buffer (EA70) de tile 5 (0x6B81) con una ventana de 22x15 de tile 0 en +0x21 (p00 0x4B6D); puntos por categoria (0x6B8F); textos (0x6C1D); tiempo (iy+4D..4F) -> EA57 -> p00 0x5339 y, si termino, 0x52D5 en +0x166; posicion (+0xEB), puntos (+0x10B) o "RETIRE" (0x6A90); total (0x6A7A)
	call SUMA_TOTAL_PUNTOS		;69c5   ; la ficha del jugador: tiempo, posicion, puntos y total
	ld hl,(0ea70h)		;69c8
	call RELLENA_BUFFER_TILE_5		;69cb   ; el fondo de la ficha es el tile 5...
	ld hl,(0ea70h)		;69ce
	ld a,021h		;69d1
	call 040d0h		;69d3
	ld bc,00f16h		;69d6   ; ...y por dentro una ventana de 22 x 15 casillas en blanco
	xor a			;69d9
	ex af,af'			;69da
	call 04b6dh		;69db   ; rectangulo de 22 columnas x 15 filas de tile 0 (A' = 0)
	call PINTA_PUNTOS_CATEGORIAS		;69de
	call PINTA_TEXTOS_RANKING		;69e1
	ld hl,0ea57h		;69e4
	ld a,(iy+04dh)		;69e7   ; el tiempo del coche son tres bytes, (iy+4D..4F)
	ld (hl),a			;69ea
	inc hl			;69eb
	ld a,(iy+04eh)		;69ec
	ld (hl),a			;69ef
	inc hl			;69f0
	ld a,(iy+04fh)		;69f1
	ld (hl),a			;69f4
	call 05339h		;69f5   ; p00 0x5339: los 3 bytes del tiempo EA57..EA59 a digitos en EA50..
	ld hl,(0ea70h)		;69f8
	ld de,00166h		;69fb
	add hl,de			;69fe
	bit 1,(iy+001h)		;69ff   ; y solo se pinta si el coche llego a meta: el bit 1 de sus banderas
	call nz,052d5h		;6a03   ; p00 0x52D5: escribe el tiempo en (EA70)+0x166 (fila 11, col 6)
	ld hl,(0ea70h)		;6a06
	bit 1,(iy+001h)		;6a09
	jp z,PINTA_RETIRE		;6a0d   ; el que no termino no tiene tiempo ni puesto: le sale RETIRE
	ld de,000ebh		;6a10
	add hl,de			;6a13
	push hl			;6a14
	ld a,(0e1c2h)		;6a15   ; con dos jugadores y el mismo tiempo (E30D..F = E3CD..F): intercambia las posiciones E331/E3F1 segun E2D6/E396
	bit 5,a		;6a18
	jr z,RANKING_POSICION		;6a1a
	ld hl,0e3cdh		;6a1c
	ld a,(0e30dh)		;6a1f
	cp (hl)			;6a22
	jr nz,RANKING_POSICION		;6a23
	inc hl			;6a25
	ld a,(0e30eh)		;6a26
	cp (hl)			;6a29
	jr nz,RANKING_POSICION		;6a2a
	inc hl			;6a2c
	ld a,(0e30fh)		;6a2d
	cp (hl)			;6a30
	jr nz,RANKING_POSICION		;6a31
	ld a,(0e2d6h)		;6a33   ; y entonces manda otra cosa, E2D6 contra E396
	ld hl,0e396h		;6a36
	cp (hl)			;6a39
	ld a,(0e331h)		;6a3a
	ld hl,0e3f1h		;6a3d
	jr c,RANKING_EMPATE_B		;6a40
	cp (hl)			;6a42
	jr nc,RANKING_POSICION		;6a43
	jr RANKING_INTERCAMBIA_POSICIONES		;6a45
RANKING_EMPATE_B:		; la otra rama del desempate
	cp (hl)			;6a47
	jr c,RANKING_POSICION		;6a48
RANKING_INTERCAMBIA_POSICIONES:		; E331 <-> E3F1
	ld e,a			;6a4a   ; si el desempate sale al reves, los dos puestos se cambian
	ld a,(hl)			;6a4b
	ld (0e331h),a		;6a4c
	ld (hl),e			;6a4f
RANKING_POSICION:		; (iy+71) -> BCD -> 2 digitos en +0xEB si E240 = 0
	ld l,(iy+071h)		;6a50   ; (iy+71) = posicion final -> BCD -> 2 digitos en +0xEB (fila 7, col 11) si E240 = 0
	ld h,000h		;6a53
	call 04b28h		;6a55
	pop hl			;6a58
	ld b,010h		;6a59
	ld a,(0e240h)		;6a5b   ; con E240 encendido -la tercera opcion de jugadores- el puesto no se pinta
	and a			;6a5e
	call z,PINTA_BCD_4_DIGITOS		;6a5f
	ld hl,(0ea70h)		;6a62
	ld de,0010bh		;6a65
	add hl,de			;6a68
	push hl			;6a69
	ld hl,(0ea72h)		;6a6a   ; (EA72) -> los puntos ganados -> 4 digitos en +0x10B (fila 8, col 11)
	ld a,(hl)			;6a6d
	inc hl			;6a6e
	ld h,(hl)			;6a6f
	ld l,a			;6a70
	call 04b28h		;6a71
	pop hl			;6a74
	ld b,010h		;6a75   ; B = 0x10 es la fuente de los digitos del ranking
	call PINTA_BCD_4_DIGITOS		;6a77
PINTA_TOTAL_RANKING:		; (iy-2B) -> BCD -> 4 digitos en (EA70)+0x1CB (fila 14, col 11)
	ld hl,(0ea70h)		;6a7a   ; el total del campeonato vive en (iy-0x2B), justo por delante del bloque del coche
	ld de,001cbh		;6a7d
	add hl,de			;6a80
	push hl			;6a81
	ld l,(iy-02bh)		;6a82
	ld h,000h		;6a85
	call 04b28h		;6a87
	pop hl			;6a8a
	ld b,010h		;6a8b
	jp PINTA_BCD_4_DIGITOS		;6a8d
PINTA_RETIRE:		; no termino: los 12 tiles de 0x6ECC ("RETIRE EMPTY") en (EA70)+0x103 (fila 8, col 3)
	ld de,00103h		;6a90   ; los doce tiles de 0x6ECC son "RETIRE EMPTY" ya hechos, sin pasar por el expansor de textos
	add hl,de			;6a93
	ld de,06ecch		;6a94
	ld bc,0000ch		;6a97
	ex de,hl			;6a9a
	ldir		;6a9b
	jr PINTA_TOTAL_RANKING		;6a9d
PANEL_RANKING_1J:		; con dos jugadores nada; si no: colores de los tiles 252-255 (VRAM 0x7E0) a cero, CARGA_TILES_PANEL (p00 0x4C12), E300 = 0 y 0x7599
	ld a,(0e1c2h)		;6a9f   ; con dos jugadores el panel es otro y no se toca aqui
	bit 5,a		;6aa2
	ret nz			;6aa4
	ld hl,007e0h		;6aa5   ; los colores de los cuatro ultimos tiles a cero antes de cargar el panel
	ld bc,00020h		;6aa8
	xor a			;6aab
	call 00056h		;6aac   ; BIOS FILVRM - Fills VRAM with value
	call 04c12h		;6aaf
	xor a			;6ab2
	ld (0e300h),a		;6ab3
	jp PINTA_PANEL_HUD		;6ab6
RANKING_PASOS:		; E251 = 1: vuelca (0x6AF6) y p02 0x8406 con C = 7 hasta E252 = 0x14; 2: cuenta (E27E) hasta 0x1DF/0x1C8 o boton -> 0x6B02; 3: 0x8C fotogramas o boton -> E251 = 4, sonido 0x80; 4: bit 6 de E1C2 -> sonido 0x46 y E250 = 2, si no E1F3 = 0
	dec a			;6ab9   ; el paso 1 es el volcado, con la cortinilla de p02
	jr nz,RANKING_PASO_2		;6aba
	call VUELCA_RANKING		;6abc
	ld c,007h		;6abf
	call 08406h		;6ac1   ; p02 0x8406 (1/2/3 puestas) con C = 7
	ld a,(0e252h)		;6ac4
	cp 014h		;6ac7   ; hasta que E252 no llega a 0x14 no se pasa de paso
	ret nz			;6ac9
	ld hl,0e251h		;6aca
	inc (hl)			;6acd
	ret			;6ace
RANKING_PASO_2:		; (E27E) 16 bits --; a cero -> 0x6B02; DE = 0x1DF si nadie termino (0x6D31), 0x1C8 si no; mientras (E27E) >= DE sigue volcando; luego el boton (bit 4 de E1C8) -> 0x6B02
	dec a			;6acf   ; el paso 2 es la espera larga, con su contador de 16 bits
	jr nz,RANKING_PASO_3		;6ad0
	ld hl,(0e27eh)		;6ad2
	dec hl			;6ad5
	ld (0e27eh),hl		;6ad6
	ld a,h			;6ad9
	or l			;6ada
	jp z,RANKING_PASO_3_ENTRA		;6adb   ; a cero se pasa solo, sin tocar nada
	call ALGUIEN_TERMINO		;6ade
	ld de,001dfh		;6ae1   ; si nadie llego a meta la espera es mas larga: no hay nada que leer
	jr z,RANKING_COMPARA		;6ae4
	ld de,001c8h		;6ae6
RANKING_COMPARA:		; (E27E) - DE
	or a			;6ae9
	sbc hl,de		;6aea
	jr nc,VUELCA_RANKING		;6aec
	ld a,(0e1c8h)		;6aee   ; y el boton se la salta
	and 010h		;6af1
	jp nz,RANKING_PASO_3_ENTRA		;6af3
VUELCA_RANKING:		; E400 -> VRAM 0x3801 (0x6CB6) y, con dos jugadores, EC00 -> 0x3800 (0x6CD1)
	call VUELCA_E400_RANKING		;6af6
	ld a,(0e1c2h)		;6af9   ; con un jugador solo hay un buffer que volcar
	bit 5,a		;6afc
	ret z			;6afe
	jp VUELCA_EC00_RANKING		;6aff
RANKING_PASO_3_ENTRA:		; E27E = 0x8C, E251++, sonido 0x81
	ld a,08ch		;6b02   ; 0x8C fotogramas para el paso siguiente, y el sonido 0x81 para abrirlo
	ld (0e27eh),a		;6b04
	ld hl,0e251h		;6b07
	inc (hl)			;6b0a
	ld a,081h		;6b0b
	jp 04174h		;6b0d
RANKING_PASO_3:		; boton (bit 4 de E1C8) o E27E-- a cero -> E251++ y sonido 0x80
	dec a			;6b10
	jr nz,RANKING_PASO_4		;6b11
	ld a,(0e1c8h)		;6b13   ; el boton adelanta el paso 3
	and 010h		;6b16
	jp nz,RANKING_PASO_4_ENTRA		;6b18
	ld hl,0e27eh		;6b1b
	dec (hl)			;6b1e
	ret nz			;6b1f
RANKING_PASO_4_ENTRA:		; E251++ y sonido 0x80
	ld hl,0e251h		;6b20
	inc (hl)			;6b23
	ld a,080h		;6b24   ; el sonido 0x80 cierra la pantalla
	jp 04174h		;6b26
RANKING_PASO_4:		; bit 6 de E1C2: sonido 0x46 y E250 = 2; si no E1F3 = 0
	ld a,(0e1c2h)		;6b29   ; el bit 6 de E1C2 es "hay jugador 1": sin el, esto es la demo y no se vuelve al menu
	and 040h		;6b2c
	jr nz,RANKING_FIN		;6b2e
	xor a			;6b30
	ld (0e1f3h),a		;6b31
	ret			;6b34
RANKING_FIN:		; sonido 0x46 y A_ESTADO_2
	ld a,046h		;6b35
	call 04174h		;6b37   ; el sonido 0x46 y de vuelta al estado 2
	jp A_ESTADO_2		;6b3a
L_6B3D:
	xor a			;6b3d
	ld (0e29dh),a		;6b3e   ; el GP elegido y el maximo vuelven a cero: se empieza campeonato nuevo
	ld (0e35dh),a		;6b41
	ld a,010h		;6b44
	jp PON_ESTADO		;6b46

; ----------------------------------------------------------------------
; Entrada 14 del despachador de carrera (p00 0x5B19): decide si tras
; la carrera se pasa a E250 = 0x10 (NC) o al ranking (C). Solo en la
; carrera 20 (el ultimo GP), con un coche que termino primero y con los
; puntos (byte bajo de E295/E355) >= 0xB4. Hipotesis: el final del campeonato.
; ----------------------------------------------------------------------
FIN_DE_CAMPEONATO:		; C si E25C < 20; si el coche 1 termino (bit 1 de E2C1) y E331 < 2 -> puntos (0x6B6B); si no mira el coche 2 (E381, E3F1); NC -> p00 pone E250 = 0x10
	ld a,(0e25ch)		;6b49
	cp 014h		;6b4c   ; solo la carrera 20 -el ultimo GP- puede cerrar el campeonato
	ret c			;6b4e
	ld a,(0e2c1h)		;6b4f   ; el bit 1 de las banderas del coche es "termino"
	bit 1,a		;6b52
	jr z,FIN_CAMPEONATO_COCHE_2		;6b54
	ld a,(0e331h)		;6b56
	cp 002h		;6b59   ; y ademas hay que haber quedado primero o segundo
	jr c,PUNTOS_0xB4		;6b5b
FIN_CAMPEONATO_COCHE_2:		; coche 2 terminado -> C; posicion E3F1 < 2 -> 0x6B6B, si no C
	ld a,(0e381h)		;6b5d   ; si el coche 1 no vale, se prueba con el 2
	bit 1,a		;6b60
	scf			;6b62
	ret nz			;6b63
	ld a,(0e3f1h)		;6b64
	cp 002h		;6b67
	ccf			;6b69
	ret c			;6b6a
PUNTOS_0xB4:		; D = 0xB4 y 0x6B71 (salta el `ld d,0xBD` de 0x6B6F, que no usa nadie)
	ld d,0b4h		;6b6b   ; 0xB4 es el ultimo umbral de la escalera de puntos, el mismo que abre el GP 16
	jr COMPARA_PUNTOS_D		;6b6d
L_6B6F:
	ld d,0bdh		;6b6f   ; este `ld d,0xBD` no lo llama nadie: se entra siempre por 0x6B6B, que se lo salta con el `jr`
COMPARA_PUNTOS_D:		; NC si el byte bajo de E295 >= D; si no, con dos jugadores, NC si E355 >= D; si no C
	ld a,(0e295h)		;6b71   ; basta con que uno de los dos jugadores llegue al umbral
	cp d			;6b74
	ret nc			;6b75
	ld a,(0e1c2h)		;6b76
	bit 5,a		;6b79
	ret z			;6b7b
	ld a,(0e355h)		;6b7c
	cp d			;6b7f
	ret			;6b80
RELLENA_BUFFER_TILE_5:		; 24 filas x 32 de tile 5 desde HL (fondo del ranking)
	ld c,018h		;6b81   ; el fondo del ranking es el tile 5, la pantalla entera
	ld a,005h		;6b83
RELLENA_FILA_5:		; una fila
	ld b,020h		;6b85
RELLENA_FILA_5_BUCLE:		; un tile
	ld (hl),a			;6b87   ; 32 tiles por fila
	inc hl			;6b88
	djnz RELLENA_FILA_5_BUCLE		;6b89
	dec c			;6b8b
	jr nz,RELLENA_FILA_5		;6b8c
	ret			;6b8e
PINTA_PUNTOS_CATEGORIAS:		; los 5 bytes (iy-3F,-40,-3D,-3C,-3E: STOCK, RALLY, F3, F3000, ENDURANCE) a BCD y 2 digitos cada uno en (EA70)+0x20B (fila 16, col 11) y filas siguientes; y la suma de los 16 GP (iy-3B..-2C) en la fila 21 (F1)
	ld de,0ea50h		;6b8f   ; los cinco bytes son las cinco categorias, y estan desordenados a proposito: (iy-3F) es STOCK, (iy-40) RALLY, (iy-3D) F3, (iy-3C) F3000 y (iy-3E) ENDURANCE, que es el orden en que las ensena el menu
	ld a,(iy-03fh)		;6b92
	ld (de),a			;6b95
	inc de			;6b96
	ld a,(iy-040h)		;6b97
	ld (de),a			;6b9a
	inc de			;6b9b
	ld a,(iy-03dh)		;6b9c
	ld (de),a			;6b9f
	inc de			;6ba0
	ld a,(iy-03ch)		;6ba1
	ld (de),a			;6ba4
	inc de			;6ba5
	ld a,(iy-03eh)		;6ba6
	ld (de),a			;6ba9
	ld de,0ea50h		;6baa   ; se copian antes a EA50 para poder recorrerlos de corrido
	ld hl,(0ea70h)		;6bad
	ld bc,0020bh		;6bb0
	add hl,bc			;6bb3   ; 0x20B es la fila 16, columna 11 del buffer
	ld b,005h		;6bb4
PINTA_PUNTOS_CATEGORIA:		; una categoria por vuelta (EA50.. guarda los 5 valores)
	push bc			;6bb6
	push de			;6bb7
	push hl			;6bb8
	push hl			;6bb9   ; se guarda dos veces porque el destino hace falta al pintar y al bajar de fila
	ld a,(de)			;6bba
	ld l,a			;6bbb
	ld h,000h		;6bbc
	call 04b28h		;6bbe
	pop hl			;6bc1
	ld b,010h		;6bc2
	call PINTA_BCD_4_DIGITOS		;6bc4   ; cuatro digitos por categoria
	pop hl			;6bc7
	ld bc,00020h		;6bc8   ; y de una categoria a la siguiente se baja una fila entera
	add hl,bc			;6bcb
	pop de			;6bcc
	inc de			;6bcd
	pop bc			;6bce
	djnz PINTA_PUNTOS_CATEGORIA		;6bcf
	push hl			;6bd1
	push iy		;6bd2
	pop hl			;6bd4
	ld de,0ffc5h		;6bd5   ; 0xFFC5 es -0x3B: los 16 bytes de los GP de F1
	add hl,de			;6bd8
	ex de,hl			;6bd9
	ld b,010h		;6bda
	ld hl,0ea78h		;6bdc
	ld (hl),000h		;6bdf
SUMA_PUNTOS_GP:		; EA78 += (DE), 16 bytes
	ld a,(de)			;6be1   ; la fila de F1 no es un byte: es la suma de los dieciseis GP
	add a,(hl)			;6be2
	ld (hl),a			;6be3
	inc de			;6be4   ; un byte por vuelta, dieciseis GP
	djnz SUMA_PUNTOS_GP		;6be5
	ld l,(hl)			;6be7
	ld h,000h		;6be8
	call 04b28h		;6bea
	pop hl			;6bed
	ld b,010h		;6bee
	jp PINTA_BCD_4_DIGITOS		;6bf0
TOTAL_A_BCD:		; HL = (iy-2B,-2A) -> BCD (p00 0x4B28)
	ld l,(iy-02bh)		;6bf3   ; el total del campeonato son 16 bits
	ld h,(iy-02ah)		;6bf6
	jp 04b28h		;6bf9
SUMA_TOTAL_PUNTOS:		; (iy-2B,-2A) = suma de los 21 bytes desde iy-0x40 (la mejor puntuacion de cada carrera)
	push iy		;6bfc
	exx			;6bfe
	pop hl			;6bff
	ld de,0ffc0h		;6c00   ; -0x40 es donde empieza la tabla de las 21 carreras
	add hl,de			;6c03
	ld b,015h		;6c04
	exx			;6c06
	ld hl,00000h		;6c07
	exx			;6c0a
SUMA_TOTAL_BUCLE:		; un byte por vuelta
	ld a,(hl)			;6c0b   ; se suman los 21 bytes: la mejor puntuacion de cada carrera
	exx			;6c0c
	ld e,a			;6c0d
	ld d,000h		;6c0e
	add hl,de			;6c10
	exx			;6c11
	inc hl			;6c12
	djnz SUMA_TOTAL_BUCLE		;6c13
	exx			;6c15
	ld (iy-02bh),l		;6c16   ; y el total se guarda en el bloque del coche, dos bytes
	ld (iy-02ah),h		;6c19
	ret			;6c1c
PINTA_TEXTOS_RANKING:		; 9 textos de 0x6D8E (10 si termino: + "POINT"), el numero de jugador (0x6C80), categoria y GP (0x6C8E), "TIME" si termino, "RESULT" si E240 != 1, "F1" y "TOTAL"
	exx			;6c1d   ; nueve textos fijos, y uno mas -"POINT"- solo si el coche llego a meta
	ld hl,06d8eh		;6c1e
	ld b,009h		;6c21
	bit 1,(iy+001h)		;6c23
	jr z,PINTA_TEXTOS_LISTA		;6c27
	inc b			;6c29
PINTA_TEXTOS_LISTA:		; entrada
	call PINTA_TEXTOS_TILES		;6c2a   ; nueve o diez textos de golpe, y los que dependen de algo se pintan aparte
	call PINTA_NUMERO_JUGADOR		;6c2d
	call PINTA_CATEGORIA_RANKING		;6c30
	exx			;6c33
	ld b,001h		;6c34   ; "TIME" tampoco se pinta si no hay tiempo que ensenar
	ld hl,06e03h		;6c36   ; el texto "TIME" solo sale si hay tiempo
	bit 1,(iy+001h)		;6c39
	call PINTA_TEXTO_SI_NZ		;6c3d
	exx			;6c40
	ld b,001h		;6c41
	ld hl,06dfah		;6c43
	ld a,(0e240h)		;6c46   ; y "RESULT" se calla con E240 = 1
	dec a			;6c49
	call PINTA_TEXTO_SI_NZ		;6c4a
	exx			;6c4d
	ld b,001h		;6c4e
	ld hl,06dedh		;6c50
	call PINTA_TEXTOS_TILES		;6c53
	exx			;6c56
	ld b,001h		;6c57
	ld hl,06df2h		;6c59
PINTA_TEXTOS_TILES:		; B' textos desde (HL'): [desplazamiento en el buffer (palabra), n, n tiles]
	ld a,(hl)			;6c5c   ; cada texto trae su sitio en el buffer (una palabra), cuantos tiles son y los tiles
	inc hl			;6c5d
	exx			;6c5e
	ld e,a			;6c5f
	exx			;6c60
	ld a,(hl)			;6c61
	inc hl			;6c62
	exx			;6c63
	ld d,a			;6c64
PINTA_TEXTO_TILES_EN:		; HL = (EA70) + DE; n = (HL'); copia n tiles
	ld hl,(0ea70h)		;6c65   ; el sitio es relativo al buffer que toque, que puede ser el de E400 o el de EC00
	add hl,de			;6c68
	exx			;6c69
	ld a,(hl)			;6c6a
	inc hl			;6c6b
	exx			;6c6c
	ld b,a			;6c6d
PINTA_TEXTO_TILES_BUCLE:		; un tile por vuelta
	exx			;6c6e   ; los tiles se copian tal cual: ya son numeros de tile, no letras
	ld a,(hl)			;6c6f
	inc hl			;6c70
	exx			;6c71
	ld (hl),a			;6c72   ; el tile va tal cual al buffer
	inc hl			;6c73
	djnz PINTA_TEXTO_TILES_BUCLE		;6c74
	exx			;6c76
	djnz PINTA_TEXTOS_TILES		;6c77
	exx			;6c79
	ret			;6c7a
PINTA_TEXTO_SI_NZ:		; pinta el texto solo si NZ
	jp nz,PINTA_TEXTOS_TILES		;6c7b   ; el `jp nz` de aqui es lo que deja pintar un texto solo a veces sin duplicar el bucle
	exx			;6c7e
	ret			;6c7f
PINTA_NUMERO_JUGADOR:		; (EA70)+0x4E (fila 2, col 14) = tile 0x10 + (iy+9)
	ld hl,(0ea70h)		;6c80
	ld de,0004eh		;6c83   ; 0x4E es la fila 2, columna 14
	add hl,de			;6c86
	ld a,(iy+009h)		;6c87
	add a,010h		;6c8a   ; el tile 0x10 es el 0, asi que sumarle el numero de jugador da su digito
	ld (hl),a			;6c8c
	ret			;6c8d
PINTA_CATEGORIA_RANKING:		; el nombre de la categoria (0x6E0A[E25B]) en +0x83 (fila 4, col 3) y, si E25C >= 5, el del GP (0x6E16[E25C-5]) en +0xA3 (fila 5)
	exx			;6c8e
	ld hl,06e0ah		;6c8f
	ld a,(0e25bh)		;6c92
	call 04a44h		;6c95
	exx			;6c98
	ld de,00083h		;6c99   ; 0x83 es la fila 4, columna 3
	call PINTA_UN_TEXTO		;6c9c
	ld a,(0e25ch)		;6c9f
	sub 005h		;6ca2   ; solo las carreras 5 en adelante tienen nombre de GP que pintar
	ret c			;6ca4
	exx			;6ca5
	ld hl,06e16h		;6ca6
	call 04a44h		;6ca9
	exx			;6cac
	ld de,000a3h		;6cad
PINTA_UN_TEXTO:		; B' = 1 y 0x6C65
	exx			;6cb0   ; un solo texto, y por el mismo camino que los demas
	ld b,001h		;6cb1
	exx			;6cb3
	jr PINTA_TEXTO_TILES_EN		;6cb4
VUELCA_E400_RANKING:		; E400 -> VRAM 0x3801, 17 columnas x 24 filas (p00 0x522D); con dos jugadores 16 columnas en 0x3810
	ld de,0e400h		;6cb6
	ld hl,03801h		;6cb9
	exx			;6cbc
	ld a,(0e1c2h)		;6cbd   ; con dos jugadores cada ficha ocupa 16 columnas y con uno 17
	bit 5,a		;6cc0
	ld b,011h		;6cc2   ; diecisiete columnas con un jugador
	jr z,VUELCA_RANKING_VA		;6cc4
	ld b,010h		;6cc6
	exx			;6cc8
	ld hl,03810h		;6cc9
	exx			;6ccc
VUELCA_RANKING_VA:		; p00 0x522D: B' columnas x 24 filas
	exx			;6ccd
	jp 0522dh		;6cce
VUELCA_EC00_RANKING:		; EC00 -> VRAM 0x3800, 16 columnas x 24 filas (p00 0x522D)
	ld de,0ec00h		;6cd1
	ld hl,03800h		;6cd4
	exx			;6cd7
	ld b,010h		;6cd8   ; la del segundo jugador va pegada a la izquierda
	exx			;6cda
	jp 0522dh		;6cdb
BORRA_E400_EC00:		; los dos buffers de nombres a cero (0x300 cada uno)
	ld hl,0e400h		;6cde   ; 0x300 bytes son las 24 filas de un buffer
	ld bc,00300h		;6ce1
	call 04b87h		;6ce4
	ld hl,0ec00h		;6ce7
	ld bc,00300h		;6cea
	jp 04b87h		;6ced
PINTA_BCD_2_DIGITOS:		; E = 2 digitos BCD -> tiles B+digito en (HL), decena 0 en blanco
	ld c,000h		;6cf0   ; dos digitos: solo la pareja de E
	jr PINTA_BCD_DECENA		;6cf2
PINTA_BCD_4_DIGITOS:		; D,E = 4 digitos BCD -> tiles B+digito en (HL..HL+3), ceros a la izquierda en blanco (C)
	ld c,000h		;6cf4   ; C es el interruptor de los ceros de delante, igual que en el escritor de p00: mientras siga a cero, el `and c` deja el tile 0
	ld a,d			;6cf6
	rra			;6cf7
	rra			;6cf8
	rra			;6cf9
	rra			;6cfa
	and 00fh		;6cfb
	jr z,PINTA_BCD_MILLAR		;6cfd
	ld c,0ffh		;6cff
PINTA_BCD_MILLAR:		; el primer digito de D
	add a,b			;6d01   ; a cada digito se le suma B, que es la fuente
	and c			;6d02
	ld (hl),a			;6d03
	inc hl			;6d04
	ld a,d			;6d05
	and 00fh		;6d06
	jr z,PINTA_BCD_CENTENA		;6d08
	ld c,0ffh		;6d0a
PINTA_BCD_CENTENA:		; el segundo digito de D
	add a,b			;6d0c
	and c			;6d0d
	ld (hl),a			;6d0e
	inc hl			;6d0f
PINTA_BCD_DECENA:		; E: decena (en blanco si cero y nada antes) y unidad
	ld a,e			;6d10   ; la decena solo se pinta si hay algo antes o si ella misma no es cero
	rra			;6d11
	rra			;6d12
	rra			;6d13
	rra			;6d14
	and 00fh		;6d15
	jr z,PINTA_BCD_UNIDAD		;6d17
	ld c,0ffh		;6d19
PINTA_BCD_UNIDAD:		; la unidad siempre
	add a,b			;6d1b
	and c			;6d1c
	ld (hl),a			;6d1d
	inc hl			;6d1e
	ld a,e			;6d1f   ; la unidad se pinta siempre, aunque sea un cero suelto
	and 00fh		;6d20
	add a,b			;6d22
	ld (hl),a			;6d23
	ret			;6d24
CARGA_TILES_RANKING:		; lista p04 0x6E06 (CARGA_LISTA_TILES) y tiles 16..58 con 0x10 (p00 0x4476)
	ld hl,06e06h		;6d25
	call 04ccdh		;6d28
	ld a,010h		;6d2b   ; los tiles 16 a 58 con 0x10: el fondo del ranking
	call 04476h		;6d2d
	ret			;6d30
ALGUIEN_TERMINO:		; NZ si el coche 1 termino (bit 1 de E2C1) o, con dos jugadores, el 2 (E381)
	ld a,(0e2c1h)		;6d31   ; basta con que uno de los dos coches haya llegado
	bit 1,a		;6d34
	ret nz			;6d36
	ld a,(0e1c2h)		;6d37
	bit 5,a		;6d3a
	ret z			;6d3c
	ld a,(0e381h)		;6d3d
	bit 1,a		;6d40
	ret			;6d42
PUNTOS_POR_POSICION:		; HL = iy-0x40+E25C (la mejor de esta carrera); EA72 = EA74 (jugador 1) o EA76; si termino, E240 = 0 y posicion (iy+71) < 11: puntos = tabla 0x6ED8[E25B] + posicion; si mejora la guarda; (EA72) = puntos (palabra)
	push iy		;6d43
	pop hl			;6d45
	ld de,0ffc0h		;6d46   ; -0x40 otra vez: la tabla de las 21 carreras del bloque del coche
	add hl,de			;6d49
	ld a,(0e25ch)		;6d4a   ; y de esa tabla, el byte de la carrera que se acaba de correr
	call 040d0h		;6d4d
	ld a,(iy+009h)		;6d50
	ld bc,0ea74h		;6d53   ; cada jugador apunta sus puntos en su sitio, EA74 o EA76
	dec a			;6d56
	jr z,PUNTOS_GUARDA_EA72		;6d57
	ld bc,0ea76h		;6d59
PUNTOS_GUARDA_EA72:		; (EA72) = BC (EA74 o EA76)
	ld (0ea72h),bc		;6d5c
	ld de,06ed8h		;6d60   ; tabla de 6 punteros por categoria a los puntos por posicion
	ld a,(0e25bh)		;6d63
	push hl			;6d66
	call 04a3bh		;6d67
	pop hl			;6d6a
	bit 1,(iy+001h)		;6d6b   ; sin llegar a meta no hay puntos...
	jr z,PUNTOS_CERO		;6d6f
	ld a,(0e240h)		;6d71   ; ...ni con E240 encendido...
	and a			;6d74
	jr nz,PUNTOS_CERO		;6d75
	ld a,(iy+071h)		;6d77
	cp 00bh		;6d7a   ; ...ni por debajo del puesto 11
	jr nc,PUNTOS_CERO		;6d7c
	call 040d5h		;6d7e
	ld a,(de)			;6d81
	cp (hl)			;6d82   ; y solo se guarda si mejora lo que ya habia en esa carrera
	jr c,GUARDA_PUNTOS		;6d83
	ld (hl),a			;6d85
	jr GUARDA_PUNTOS		;6d86
PUNTOS_CERO:		; sin puntos
	xor a			;6d88   ; en cualquier otro caso, cero
GUARDA_PUNTOS:		; (EA74/EA76) = A, byte alto 0
	ld (bc),a			;6d89
	xor a			;6d8a
	inc bc			;6d8b   ; el byte alto siempre a cero: los puntos de una carrera caben en uno
	ld (bc),a			;6d8c
	ret			;6d8d

; ----------------------------------------------------------------------
; DATOS textos_ranking: 14 textos [desplazamiento en el buffer (palabra), n, n
;   tiles (ASCII-0x20)]: RANKING, PLAYER, BEST POINT, TOTAL POINT, STOCK,
;   RALLY, F3, F3000, ENDURANCE, POINT, F1, TOTAL, RESULT, TIME
;   0x6d8e..0x6e0a  (124 bytes)
DATA_textos_ranking:
	defb 025h,000h,007h,032h,021h,02eh,02bh,029h,02eh,027h	; 6d8e  %..2!.+).'
	defb 047h,000h,006h,030h,02ch,021h,039h,025h,032h	; 6d98  G..0,!9%2
	defb 0e2h,001h,00ah,022h,025h,033h,034h,000h,030h,02fh,029h,02eh,034h	; 6da1  ..."%34.0/).4
	defb 0a2h,001h,00bh,034h,02fh,034h,021h,02ch,000h,030h,02fh,029h,02eh,034h	; 6dae  ...4/4!,.0/).4
	defb 002h,002h,005h,033h,034h,02fh,023h,02bh	; 6dbc  ...34/#+
	defb 022h,002h,005h,032h,021h,02ch,02ch,039h	; 6dc4  "..2!,,9
	defb 042h,002h,002h,026h,013h	; 6dcc
	defb 062h,002h,005h,026h,013h,010h,010h,010h	; 6dd1  b..&....
	defb 082h,002h,009h,025h,02eh,024h,035h,032h,021h,02eh,023h,025h	; 6dd9  ...%.$52!.#%
	defb 002h,001h,005h,030h,02fh,029h,02eh,034h	; 6de5  ...0/).4
	defb 0a2h,002h,002h,026h,011h	; 6ded
	defb 0a5h,002h,005h,034h,02fh,034h,021h,02ch	; 6df2  ...4/4!,
	defb 0e2h,000h,006h,032h,025h,033h,035h,02ch,034h	; 6dfa  ...2%35,4
	defb 042h,001h,004h,034h,029h,02dh,025h	; 6e03

; ----------------------------------------------------------------------
; DATOS tabla_nombres_categoria: 6 punteros (E25B) al byte de cuenta de los
;   textos RALLY, STOCK, ENDURANCE, F3, F3000, F1 de arriba
;   0x6e0a..0x6e16  (12 bytes)
DATA_tabla_nombres_categoria:
	defw 06dc6h	; 6e0a
	defw 06dbeh	; 6e0c
	defw 06ddbh	; 6e0e
	defw 06dceh	; 6e10
	defw 06dd3h	; 6e12
	defw 06defh	; 6e14

; ----------------------------------------------------------------------
; DATOS tabla_nombres_gp_cuenta: 16 punteros (E25C-5) a los nombres de GP de
;   abajo, con su byte de cuenta
;   0x6e16..0x6e36  (32 bytes)
DATA_tabla_nombres_gp_cuenta:
	defw 06e36h	; 6e16  -> DATA_nombres_gp
	defw 06e3eh	; 6e18
	defw 06e4ah	; 6e1a
	defw 06e53h	; 6e1c
	defw 06e5bh	; 6e1e
	defw 06e63h	; 6e20
	defw 06e6bh	; 6e22
	defw 06e7ah	; 6e24
	defw 06e88h	; 6e26
	defw 06e91h	; 6e28
	defw 06e9ah	; 6e2a
	defw 06ea1h	; 6e2c
	defw 06eabh	; 6e2e
	defw 06eb2h	; 6e30
	defw 06ebah	; 6e32
	defw 06ec1h	; 6e34

; ----------------------------------------------------------------------
; DATOS nombres_gp: 16 nombres: [n, n tiles, 0xFF]: BRAZIL, SAN MARINO,
;   BELGIUM, MONACO, U.S.A., FRANCE, GREAT BRITAIN, WEST GERMANY, HUNGARY,
;   AUSTRIA, ITALY, PORTUGAL, SPAIN, MEXICO, JAPAN, AUSTRALIA (0x635A apunta
;   al segundo byte: flujo para PINTA_TILES)
;   0x6e36..0x6ecc  (150 bytes)
DATA_nombres_gp:
	defb 006h,022h,032h,021h,03ah,029h,02ch,0ffh	; 6e36  ."2!:),.
	defb 00ah,033h,021h,02eh,000h,02dh,021h,032h,029h,02eh,02fh,0ffh	; 6e3e  .3!..-!2)./.
	defb 007h,022h,025h,02ch,027h,029h,035h,02dh,0ffh	; 6e4a  ."%,')5-.
	defb 006h,02dh,02fh,02eh,021h,023h,02fh,0ffh	; 6e53  .-/.!#/.
	defb 006h,035h,01dh,033h,01dh,021h,01dh,0ffh	; 6e5b  .5.3.!..
	defb 006h,026h,032h,021h,02eh,023h,025h,0ffh	; 6e63  .&2!.#%.
	defb 00dh,027h,032h,025h,021h,034h,000h,022h,032h,029h,034h,021h,029h,02eh,0ffh	; 6e6b  .'2%!4."2)4!)..
	defb 00ch,037h,025h,033h,034h,000h,027h,025h,032h,02dh,021h,02eh,039h,0ffh	; 6e7a  .7%34.'%2-!.9.
	defb 007h,028h,035h,02eh,027h,021h,032h,039h,0ffh	; 6e88  .(5.'!29.
	defb 007h,021h,035h,033h,034h,032h,029h,021h,0ffh	; 6e91  .!5342)!.
	defb 005h,029h,034h,021h,02ch,039h,0ffh	; 6e9a
	defb 008h,030h,02fh,032h,034h,035h,027h,021h,02ch,0ffh	; 6ea1  .0/245'!,.
	defb 005h,033h,030h,021h,029h,02eh,0ffh	; 6eab
	defb 006h,02dh,025h,038h,029h,023h,02fh,0ffh	; 6eb2  .-%8)#/.
	defb 005h,02ah,021h,030h,021h,02eh,0ffh	; 6eba
	defb 009h,021h,035h,033h,034h,032h,021h,02ch,029h,021h,0ffh	; 6ec1  .!5342!,)!.

; ----------------------------------------------------------------------
; DATOS texto_retire: 12 tiles "RETIRE", 0x1E, "EMPTY" que 0x6A90 copia tal
;   cual
;   0x6ecc..0x6ed8  (12 bytes)
DATA_texto_retire:
	defb 032h,025h,034h,029h,032h,025h,01eh,025h,02dh,030h,034h,039h	; 6ecc  2%4)2%.%-049

; ----------------------------------------------------------------------
; DATOS tabla_puntos_categoria: 6 punteros (E25B) a la tabla de puntos por
;   posicion: 0x6EE3 (RALLY, STOCK, ENDURANCE) y 0x6EED (F3, F3000, F1); se
;   indexan con la posicion 1..10
;   0x6ed8..0x6ee4  (12 bytes)
DATA_tabla_puntos_categoria:
	defw 06ee3h	; 6ed8
	defw 06ee3h	; 6eda
	defw 06ee3h	; 6edc
	defw 06eedh	; 6ede
	defw 06eedh	; 6ee0
	defw 06eedh	; 6ee2

; ----------------------------------------------------------------------
; DATOS puntos_por_posicion: posicion 1..10 -> 9,8,7,6,5,4,3,2,1,0 (desde
;   0x6EE3+1) y 9,8,7,6,5,4,0,0,0,0 (desde 0x6EED+1)
;   0x6ee4..0x6ef8  (20 bytes)
DATA_puntos_por_posicion:
	defb 009h,008h,007h,006h,005h,004h,003h,002h,001h,000h	; 6ee4  ..........
	defb 009h,008h,007h,006h,005h,004h,000h,000h,000h,000h	; 6eee  ..........

; ======================================================================
; CODIGO 0x6ef8..0x7091  (409 bytes)
; ======================================================================


SPRITES_CARRERA:		; E216 = 0; un jugador -> 0x6FB4; dos: HL = tabla de atributos (0x6FD6), semaforo (0x6FAC), coche 2 en su vista, coche 1 en la suya (bit 6 de ix+31 = bit 7 viejo), cada coche en la vista del otro por (ix+5A), los 5 objetos de cada jugador (0x6FE3) y oculta el resto (0x6F9D)
	xor a			;6ef8   ; E216 cuenta los sprites gastados en este fotograma
	ld (0e216h),a		;6ef9
	ld a,(0e1c2h)		;6efc
	bit 5,a		;6eff   ; con un jugador la cuenta es otra y mas corta
	jp z,SPRITES_1_JUGADOR		;6f01
	call TABLA_ATRIBUTOS		;6f04
	call SPRITES_SEMAFORO		;6f07
	exx			;6f0a
	ld de,000f8h		;6f0b   ; DE' es la vista y BC' el recorte: cada coche se pinta dentro de su mitad de pantalla
	ld bc,06ea8h		;6f0e
	exx			;6f11
	ld ix,0e380h		;6f12
	ld iy,0e380h		;6f16
	ld a,(ix+031h)		;6f1a   ; bit 6 de (ix+31) = bit 7 anterior (parpadeo)
	ld d,a			;6f1d
	and 080h		;6f1e
	rrca			;6f20
	or d			;6f21
	ld (ix+031h),a		;6f22
	call SPRITE_OBJETO		;6f25
	exx			;6f28
	ld de,08810h		;6f29   ; la vista del jugador 1 empieza en otro sitio (0x8810)
	ld bc,06ea8h		;6f2c
	exx			;6f2f
	ld ix,0e2c0h		;6f30
	ld iy,0e2c0h		;6f34
	ld a,(ix+031h)		;6f38
	ld d,a			;6f3b
	and 080h		;6f3c
	rrca			;6f3e
	or d			;6f3f
	ld (ix+031h),a		;6f40
	rrca			;6f43   ; el `rrca` deja el bit 0 en el acarreo, que es lo que mira el pintor
	call SPRITE_OBJETO		;6f44
	ld ix,0e380h		;6f47
	ld e,(ix+05ah)		;6f4b   ; x = (ix+5A): el coche 2 visto desde la vista del 1
	ld a,(ix+006h)		;6f4e
	sub (iy+04bh)		;6f51
	sub 008h		;6f54
	bit 6,(ix+031h)		;6f56   ; y solo se pinta si el parpadeo lo deja
	call z,SPRITE_OBJETO_XY		;6f5a
	exx			;6f5d
	ld de,000f8h		;6f5e
	ld bc,06ea8h		;6f61
	exx			;6f64
	ld ix,0e2c0h		;6f65
	ld iy,0e380h		;6f69
	ld e,(ix+05ah)		;6f6d   ; el coche 1 visto desde la vista del 2 (camara de E380)
	ld a,(ix+006h)		;6f70
	sub (iy+04bh)		;6f73
	sub 008h		;6f76
	bit 6,(ix+031h)		;6f78
	call z,SPRITE_OBJETO_XY		;6f7c
	ld iy,0e380h		;6f7f
	ld ix,0e928h		;6f83
	call SPRITES_5_OBJETOS		;6f87   ; los cinco objetos de cada jugador, cada uno en la vista de su dueno
	exx			;6f8a
	ld de,08810h		;6f8b
	ld bc,06ea8h		;6f8e
	exx			;6f91
	ld iy,0e2c0h		;6f92
	ld ix,0e800h		;6f96
	call SPRITES_5_OBJETOS		;6f9a
OCULTA_RESTO_SPRITES:		; y = 0xE0 en los atributos que quedan hasta EAF8
	ld d,0e0h		;6f9d   ; lo que no se ha usado se aparca: la Y a 0xE0 deja el sprite por debajo de la pantalla
OCULTA_SPRITE_BUCLE:		; un atributo (4 bytes) por vuelta
	ld a,l			;6f9f
	sub 080h		;6fa0   ; se recorre hasta EAF8, que son 30 atributos: los dos ultimos no se tocan
	cp 078h		;6fa2
	ret nc			;6fa4
	ld (hl),d			;6fa5
	inc l			;6fa6
	inc l			;6fa7
	inc l			;6fa8
	inc l			;6fa9
	jr OCULTA_SPRITE_BUCLE		;6faa
SPRITES_SEMAFORO:		; si E1D7 != 0 (luces de salida) los monta 0x7EFA
	ld a,(0e1d7h)		;6fac   ; las luces de salida se montan aparte, que no son de ningun coche
	or a			;6faf
	call nz,SPRITES_SEMAFORO_MONTA		;6fb0
	ret			;6fb3
SPRITES_1_JUGADOR:		; vista (0x10,0xF8) de 0x76 x 0xC0: el coche 1 (E2C0) y sus 5 objetos (E800); oculta el resto
	call TABLA_ATRIBUTOS		;6fb4
	call SPRITES_SEMAFORO		;6fb7
	exx			;6fba
	ld de,010f8h		;6fbb   ; con un jugador la vista es (0x10, 0xF8) y mide 0x76 x 0xC0
	ld bc,076c0h		;6fbe   ; 0x76 x 0xC0 es el recorte de la vista de un jugador
	exx			;6fc1
	ld ix,0e2c0h		;6fc2
	ld iy,0e2c0h		;6fc6
	call SPRITE_OBJETO		;6fca
	ld ix,0e800h		;6fcd
	call SPRITES_5_OBJETOS		;6fd1
	jr OCULTA_RESTO_SPRITES		;6fd4
TABLA_ATRIBUTOS:		; HL = EA80 si el bit 6 de E1C2 esta puesto, si no EA88
	ld hl,0ea80h		;6fd6
	ld a,(0e1c2h)		;6fd9   ; el bit 6 de E1C2 -hay jugador 1- decide en que mitad de la tabla se escriben los atributos
	and 040h		;6fdc
	ret nz			;6fde
	ld hl,0ea88h		;6fdf
	ret			;6fe2
SPRITES_5_OBJETOS:		; IX = 5 objetos de 0x38 bytes: los que tienen (ix+0) != 0 y (ix+0)&0x30 = 0 van a 0x6FFE
	ld b,005h		;6fe3   ; cinco objetos por jugador, de 0x38 bytes cada uno
SPRITES_OBJETO_BUCLE:		; un objeto por vuelta
	ld a,(ix+000h)		;6fe5
	or a			;6fe8   ; el tipo 0 es "ficha libre"...
	jr z,SPRITES_OBJETO_SIGUIENTE		;6fe9
	and 030h		;6feb   ; ...y los bits 4 y 5 encendidos son estados en los que el objeto no se pinta
	jr nz,SPRITES_OBJETO_SIGUIENTE		;6fed
	push bc			;6fef
	call SPRITE_OBJETO		;6ff0
	pop bc			;6ff3
SPRITES_OBJETO_SIGUIENTE:		; IX += 0x38
	ld de,00038h		;6ff4
	add ix,de		;6ff7
	djnz SPRITES_OBJETO_BUCLE		;6ff9
	ret			;6ffb
SPRITE_FUERA:		; fuera de la vista: exx y vuelve
	exx			;6ffc
	ret			;6ffd
SPRITE_OBJETO:		; E = (ix+4) x; A = (ix+6) - (iy+4B) - 8 (y relativa a la camara)
	ld e,(ix+004h)		;6ffe
	ld a,(ix+006h)		;7001
	sub (iy+04bh)		;7004   ; (iy+4B) es la camara: al eje que cuenta el desplazamiento hay que restarsela
	sub 008h		;7007
SPRITE_OBJETO_XY:		; bit 0 de (ix+31) = 0; fuera si y >= B' o x >= C'; suma D'E'; bit 0 = 1 (visible); si bit 7 no hay sprite; si no dos sprites (y, x, patron, color) y (y, x, patron+4, color 1); con el bit 6: sprite extra por (ix+2F) si E216 < 4
	res 0,(ix+031h)		;7009
	exx			;700d
	cp b			;700e   ; B' y C' son el alto y el ancho de la vista: lo que se salga no se pinta
	jr nc,SPRITE_FUERA		;700f
	add a,d			;7011   ; y D'E' es donde empieza la vista en la pantalla
	exx			;7012
	ld d,a			;7013
	ld a,e			;7014
	exx			;7015
	cp c			;7016
	jr nc,SPRITE_FUERA		;7017
	add a,e			;7019
	exx			;701a
	ld e,a			;701b
	ld a,(ix+031h)		;701c
	ld b,a			;701f
	and 07fh		;7020   ; el bit 0 de (ix+31) queda encendido: este objeto se ha pintado
	or 001h		;7022
	ld (ix+031h),a		;7024
	rl b		;7027   ; y el bit 7 dice que el objeto esta parpadeando: este fotograma no le toca
	ret c			;7029
	ld a,(0e1deh)		;702a   ; E1DE = 1: patron 0 en vez de (ix+33)
	cp 001h		;702d
	jr nz,SPRITE_PATRON		;702f
	xor a			;7031
	jr SPRITE_ESCRIBE_PAR		;7032
SPRITE_PATRON:		; A = (ix+33)
	ld a,(ix+033h)		;7034
SPRITE_ESCRIBE_PAR:		; los dos sprites del objeto
	ld c,(ix+00fh)		;7037   ; el color sale de (ix+0F)
	ld (hl),e			;703a   ; el atributo va en el orden del VDP: Y, X, patron y color
	inc l			;703b
	ld (hl),d			;703c
	inc l			;703d
	ld (hl),a			;703e
	inc l			;703f
	ld (hl),c			;7040
	inc l			;7041
	ld (hl),e			;7042
	inc l			;7043
	ld (hl),d			;7044
	inc l			;7045
	add a,004h		;7046   ; el segundo sprite del par lleva el patron cuatro mas alla y el color 1: es la sombra de dos tintas
	ld (hl),a			;7048
	inc l			;7049
	ld (hl),001h		;704a   ; el segundo sprite del par: patron+4, color 1
	inc l			;704c
	rl b		;704d
	ret nc			;704f
	res 6,(ix+031h)		;7050   ; bit 6 consumido: el sprite extra (ix+2F): 1 -> tabla 0x7091 por fotograma (ix+0E), 2 -> 0x70AF, mas -> 0x70BE
	ld a,(0e216h)		;7054   ; y no se pintan mas de cuatro sprites extra por fotograma
	cp 004h		;7057
	ret nc			;7059
	ld a,(ix+02fh)		;705a
	ld (ix+02fh),000h		;705d   ; el sprite extra se consume: solo dura un fotograma
	or a			;7061
	ret z			;7062
	sub 002h		;7063
	jr z,$+74		;7065
	jr nc,$+87		;7067
	ld a,(ix+00eh)		;7069
	cp 00bh		;706c
	ret nc			;706e
	push hl			;706f
	push de			;7070
	ld b,a			;7071   ; por tres: las entradas de la tabla son (dx, dy, patron)
	add a,a			;7072
	add a,b			;7073
	ld l,a			;7074
	ld h,000h		;7075
	ld de,07091h		;7077
	add hl,de			;707a
	pop de			;707b
	ld a,(hl)			;707c
	add a,e			;707d
	inc hl			;707e
	ld e,a			;707f
	ld a,(hl)			;7080
	add a,d			;7081
	inc hl			;7082
	ld d,a			;7083
	ld c,00fh		;7084
	ld b,(hl)			;7086
	pop hl			;7087
ESCRIBE_SPRITE:		; (HL) = y, x, patron B, color C
	ld (hl),e			;7088   ; los cuatro bytes del atributo, en el orden del VDP
	inc l			;7089
	ld (hl),d			;708a
	inc l			;708b
	ld (hl),b			;708c
	inc l			;708d
	ld (hl),c			;708e
	inc l			;708f
	ret			;7090

; ----------------------------------------------------------------------
; DATOS tabla_sprite_extra: 10 entradas (dx, dy, patron) por fotograma (ix+0E)
;   0..9 del sprite extra de tipo 1 (color 0x0F)
;   0x7091..0x70af  (30 bytes)
DATA_tabla_sprite_extra:
	defb 010h,008h,088h	; 7091
	defb 010h,008h,088h	; 7094
	defb 010h,000h,078h	; 7097
	defb 010h,0f8h,080h	; 709a
	defb 010h,0f8h,080h	; 709d
	defb 008h,0f8h,080h	; 70a0
	defb 008h,0f8h,080h	; 70a3
	defb 000h,0ffh,010h	; 70a6
	defb 0f8h,008h,088h	; 70a9
	defb 0f8h,008h,088h	; 70ac

; ======================================================================
; CODIGO 0x70af..0x7193  (228 bytes)
; ======================================================================


SPRITE_EXTRA_2:		; patron 0xDC, color 8; si el fotograma (ix+0E) = 2, x += 0x10
	ld bc,0dc08h		;70af
SPRITE_EXTRA_ESCRIBE:		; solo con (ix+0E) = 2: x += 0x10 y lo escribe (0x7088)
	ld a,(ix+00eh)		;70b2   ; este sprite extra solo sale en el fotograma 2 de la animacion
	cp 002h		;70b5
	ret nz			;70b7
	ld a,e			;70b8
	add a,010h		;70b9
	ld e,a			;70bb
	jr $-52		;70bc
SPRITE_EXTRA_3:		; patron 0xE0 o 0xE4 (parpadeo por E1C3), color 0x0F
	ld c,00fh		;70be
	ld b,0e0h		;70c0
	ld a,(0e1c3h)		;70c2   ; el bit 0 del contador de fotogramas: el dibujo cambia en cada uno, y eso es el parpadeo
	rrca			;70c5
	jr c,SPRITE_EXTRA_3_VA		;70c6
	ld b,0e4h		;70c8
SPRITE_EXTRA_3_VA:		; a 0x70B2
	jr SPRITE_EXTRA_ESCRIBE		;70ca
L_70CC:
	ld a,(ix+031h)		;70cc   ; el bit 0 se apaga: el objeto no se ha pintado
	jr z,L_70D3		;70cf
	ld e,0e1h		;70d1
L_70D3:
	and 0feh		;70d3
	ld (ix+031h),a		;70d5
	ret			;70d8
PINTA_OBJETOS_TILES:		; E1D5 = 0 y 0x70E6
	xor a			;70d9
	ld (0e1d5h),a		;70da   ; E1D5 a cero antes de tocar el buffer: es la marca de "no vuelques todavia"
	jr PINTA_OBJETOS_TILES_VA		;70dd
PINTA_OBJETOS_TILES_B:		; E1D5 = 0, p00 0x4760 y 0x70E6 (desde el bucle de carrera p00 0x5C96)
	xor a			;70df
	ld (0e1d5h),a		;70e0
	call 04760h		;70e3
PINTA_OBJETOS_TILES_VA:		; paginas 5/6 en 8000/A000; recorre la lista E928 (0x70EE); vuelve a 1/2/3
	ld a,005h		;70e6
	call 04447h		;70e8   ; MAPEA_A_EN_8000 con 5: la plantilla 0xAF57 es de la pagina 6
	ld hl,0e928h		;70eb
OBJETO_TILES:		; DE = destino (0 = fin), C = variante; B' = 21*c; 7 filas x 4 tiles desde p06 0xAF57
	push hl			;70ee   ; la lista de E928 son entradas de tres bytes: destino, destino y variante
	ld e,(hl)			;70ef
	inc hl			;70f0
	ld d,(hl)			;70f1
	inc hl			;70f2
	ld a,e			;70f3   ; un destino a cero cierra la lista
	or d			;70f4
	jr z,OBJETOS_TILES_FIN		;70f5
	ld c,(hl)			;70f7
	ld hl,0af57h		;70f8
	ld a,c			;70fb   ; la escalera de `add` multiplica la variante por 21 (4c + 16c + c): de una variante a la siguiente, los tiles van 21 mas alla
	add a,a			;70fc
	add a,a			;70fd
	ld b,a			;70fe
	add a,a			;70ff
	add a,a			;7100
	add a,b			;7101
	add a,c			;7102
	exx			;7103
	ld b,a			;7104
	exx			;7105
	ld b,007h		;7106   ; siete filas de alto
OBJETO_TILES_FILA:		; una fila de 4 tiles; luego DE += 0x1C con vuelta dentro del buffer de 1 KB (res 2,h / set 2,h)
	ld c,004h		;7108
OBJETO_TILES_TILE:		; tile 0 no se escribe; < 0x82 suma B'; el resto tal cual
	ld a,(hl)			;710a
	and a			;710b
	jr z,OBJETO_TILES_SIGUIENTE		;710c   ; el tile 0 de la plantilla es transparente: ahi no se escribe y se ve el fondo
	cp 082h		;710e   ; de 0x82 en adelante el tile va tal cual; por debajo se le suma el desplazamiento de la variante
	jr nc,OBJETO_TILES_ESCRIBE		;7110
	exx			;7112
	add a,b			;7113
	exx			;7114
OBJETO_TILES_ESCRIBE:		; (DE) = tile
	ld (de),a			;7115
OBJETO_TILES_SIGUIENTE:		; DE++, HL++
	inc de			;7116
	inc hl			;7117
	dec c			;7118
	jr nz,OBJETO_TILES_TILE		;7119
	ex de,hl			;711b
	push bc			;711c
	ld bc,0001ch		;711d   ; 0x1C es lo que falta hasta la fila de abajo, y el bit 2 de H es la vuelta dentro del kilobyte
	res 2,h		;7120
	add hl,bc			;7122
	set 2,h		;7123
	ex de,hl			;7125
	pop bc			;7126
	djnz OBJETO_TILES_FILA		;7127
	pop hl			;7129
	ld de,0001fh		;712a   ; 0x1F es lo que ocupa una entrada entera: tres bytes de cabecera mas los 28 del fondo guardado
	add hl,de			;712d
	jr OBJETO_TILES		;712e
OBJETOS_TILES_FIN:		; MAPEA_1_2_3
	pop hl			;7130
	jp 043feh		;7131
BORRA_OBJETOS_TILES:		; por cada entrada de E928: destino a 0, variante a 0 y devuelve las 7 filas x 4 tiles guardadas al buffer (0x714C)
	ld hl,0e928h		;7134   ; al borrar se devuelve el fondo que estaba guardado detras de la entrada
BORRA_OBJETO_TILES:		; una entrada por vuelta; palabra 0 = fin
	ld e,(hl)			;7137   ; la entrada se lee y se apaga a la vez
	ld (hl),000h		;7138   ; el destino se apaga sobre la marcha: la entrada queda libre
	inc hl			;713a
	ld d,(hl)			;713b
	ld (hl),000h		;713c
	inc hl			;713e
	ld a,e			;713f
	or d			;7140
	ret z			;7141
	ld (hl),000h		;7142
	inc hl			;7144
	ld a,007h		;7145   ; siete filas de fondo guardado
	call DEVUELVE_FONDO_OBJETO		;7147
	jr BORRA_OBJETO_TILES		;714a
DEVUELVE_FONDO_OBJETO:		; A filas: 4 ldi y DE += 0x1C con vuelta en el buffer
	ldi		;714c   ; cuatro `ldi` por fila, las mismas cuatro casillas que se pintaron
	ldi		;714e   ; cuatro casillas por fila, las mismas cuatro que se pintaron
	ldi		;7150
	ldi		;7152
	ex de,hl			;7154
	ld bc,0001ch		;7155
	res 2,h		;7158
	add hl,bc			;715a
	set 2,h		;715b
	ex de,hl			;715d
	dec a			;715e
	jr nz,DEVUELVE_FONDO_OBJETO		;715f
	ret			;7161
ENTRA_MENU_PASSWORD:		; E250 = 4: limpia sprites (p00 0x4460), filas 16-23 (0x7183), pinta el menu (0x718D), E250++ (5), E251 = 0 y 0x7175
	call 04460h		;7162   ; la pantalla de la clave: se limpia y se pinta entera de una vez
	call BORRA_FILAS_16_23		;7165
	call PINTA_MENU_PASSWORD		;7168
	ld hl,0e250h		;716b
	xor a			;716e
	inc (hl)			;716f
	ld hl,0e251h		;7170
	xor a			;7173
	ld (hl),a			;7174
BORRA_EA50:		; E252 = 0 y EA50..EA7E a cero
	xor a			;7175   ; 0x2F bytes desde EA50: el sitio donde se monta la clave
	ld hl,0e252h		;7176
	ld (hl),a			;7179
	ld hl,0ea50h		;717a
	ld bc,0002fh		;717d
	jp 04b87h		;7180
BORRA_FILAS_16_23:		; FILVRM 256 ceros en 0x3A00
	xor a			;7183
	ld hl,03a00h		;7184   ; 0x3A00 es la fila 16: se borran las ocho de abajo, que es donde va el menu
	ld bc,00100h		;7187
	jp 00056h		;718a   ; BIOS FILVRM - Fills VRAM with value
PINTA_MENU_PASSWORD:		; PINTA_TILES del flujo 0x7193
	ld de,07193h		;718d   ; el menu es un flujo de tiles con sus posiciones dentro: no hace falta pintarlo a mano
	jp 04811h		;7190

; ----------------------------------------------------------------------
; DATOS texto_menu_password: flujo de PINTA_TILES (ASCII - 0x20): en 0x3A28
;   GAME, 0x3A48 EXCHANGE, 0x3A68 PASSWORD, 0x3A88 INPUT PASSWORD, 0x3AA8 GAME
;   OVER, 0xFF
;   0x7193..0x71cd  (58 bytes)
DATA_texto_menu_password:
	defb 028h,03ah,027h,021h,02dh,025h,0feh	; 7193
	defb 048h,03ah,025h,038h,023h,028h,021h,02eh,027h,025h,0feh	; 719a  H:%8#(!.'%.
	defb 068h,03ah,030h,021h,033h,033h,037h,02fh,032h,024h,0feh	; 71a5  h:0!337/2$.
	defb 088h,03ah,029h,02eh,030h,035h,034h,000h,030h,021h,033h,033h,037h,02fh,032h,024h,0feh	; 71b0  .:).054.0!337/2$.
	defb 0a8h,03ah,027h,021h,02dh,025h,000h,02fh,036h,025h,032h,0ffh	; 71c1  .:'!-%./6%2.

; ======================================================================
; CODIGO 0x71cd..0x71e4  (23 bytes)
; ======================================================================


MENU_PASSWORD:		; E250 = 5: p00 0x477C si bit 6 de E1C2; vuelca 512 (0x662D); despacha por E251 (< 7) con la tabla 0x71E4
	ld a,(0e1c2h)		;71cd
	and 040h		;71d0   ; el bit 6 de E1C2 -hay jugador 1- decide si ademas se vuelcan los sprites
	call nz,0477ch		;71d2
	call VUELCA_512_NOMBRES_SIN		;71d5
	call NADA_62D3		;71d8
	ld a,(0e251h)		;71db
	cp 007h		;71de   ; siete opciones y ni una mas
	ret nc			;71e0
	call 040dah		;71e1   ; el indice es E251 (no E252): 0 cursor, 1 GAME, 2 EXCHANGE, 3 PASSWORD, 4 INPUT PASSWORD, 5 GAME OVER, 6 fin de GAME OVER

; ----------------------------------------------------------------------
; DATOS tabla_71E1: 7 palabras del despachador de 0x71E1 (`call 0x40DA`),
;   indice (E251)
;   0x71e4..0x71f2  (14 bytes)
DATA_tabla_71E1:
	defw 071f2h	; 71e4  -> CURSOR_MENU_PASSWORD
	defw 068a7h	; 71e6  -> A_ESTADO_19
	defw 07224h	; 71e8  -> EXCHANGE
	defw 072a8h	; 71ea  -> PASSWORD
	defw 07351h	; 71ec  -> INPUT_PASSWORD
	defw 07450h	; 71ee  -> GAME_OVER_MENU
	defw 07458h	; 71f0  -> GAME_OVER_MENU_FIN

; ======================================================================
; CODIGO 0x71f2..0x741e  (556 bytes)
; ======================================================================


CURSOR_MENU_PASSWORD:		; p00 0x477C; mueve EA72 (0x7241); sprite del cursor en EA80: y = EA72*8 + 0x88, x = 0x32, patron 0, color 7; con boton o espacio (E1C8 & 0x30): sonido 0x26 (si bit 6 de E1C2), E251 = EA72 + 1 y 0x7175
	call 0477ch		;71f2
	call MUEVE_CURSOR_EA72		;71f5   ; el cursor de esta pantalla se mueve en dos ejes y vive en EA72/EA73
	ld a,e			;71f8
	add a,a			;71f9   ; la fila por ocho mas 0x88: cada opcion esta ocho pixeles por debajo de la anterior
	add a,a			;71fa
	add a,a			;71fb
	add a,088h		;71fc
	ld e,a			;71fe
	ld d,032h		;71ff
	ld bc,00007h		;7201
	ld hl,0ea80h		;7204
	call ESCRIBE_SPRITE_EDBC		;7207
	ld a,(0e1c8h)		;720a
	and 030h		;720d   ; el bit 4 es el boton y el 5 el espacio: aqui valen los dos
	ret z			;720f
	ld a,(0e1c2h)		;7210
	and 040h		;7213   ; en la demo no suena
	ld a,026h		;7215
	call nz,04174h		;7217
	ld a,(0ea72h)		;721a   ; el paso es la opcion elegida mas uno, que el 0 es el propio cursor
	inc a			;721d
	ld (0e251h),a		;721e
	jp BORRA_EA50		;7221
EXCHANGE:		; intercambia los 0xC0 bytes de E280.. y E340.. (los datos de los dos jugadores), E2C9 = 1, E389 = 2, E25B = 0xFF y E250 = 4 (0x7418)
	ld hl,0e280h		;7224   ; EXCHANGE cambia los datos de los dos jugadores de sitio, 0xC0 bytes cada uno
	ld de,0e340h		;7227
	ld bc,000c0h		;722a
	call INTERCAMBIA_BLOQUES		;722d
	ld a,001h		;7230
	ld (0e2c9h),a		;7232   ; y les deja marcado quien es quien: 1 y 2
	inc a			;7235
	ld (0e389h),a		;7236
	ld a,0ffh		;7239   ; E25B a 0xFF: hay que volver a elegir categoria
	ld (0e25bh),a		;723b
	jp A_ESTADO_4_B		;723e
MUEVE_CURSOR_EA72:		; HL = EA72 (y), EA73 (x): flancos de E1C8: arriba/abajo E--, E++ (tope C = 4); izquierda/derecha D++, D-- (tope B = 0); si cambia, sonido 0x25
	ld hl,0ea72h		;7241
	ld bc,00004h		;7244   ; los topes: cuatro filas y una sola columna
	jr MUEVE_CURSOR_HL		;7247
MUEVE_CURSOR_HL:		; entrada con HL, B (tope x) y C (tope y)
	ld a,(0e1c8h)		;7249
	ld e,(hl)			;724c
	inc hl			;724d
	ld d,(hl)			;724e
	rrca			;724f   ; los cuatro flancos, uno por bit, en el orden arriba, abajo, izquierda, derecha
	jr nc,CURSOR_HL_ABAJO		;7250
	dec e			;7252
CURSOR_HL_ABAJO:		; bit 1
	rrca			;7253
	jr nc,CURSOR_HL_IZQ		;7254
	inc e			;7256
CURSOR_HL_IZQ:		; bit 2
	rrca			;7257
	jr nc,CURSOR_HL_DER		;7258
	inc d			;725a
CURSOR_HL_DER:		; bit 3
	rrca			;725b
	jr nc,CURSOR_HL_TOPES		;725c
	dec d			;725e
CURSOR_HL_TOPES:		; -1 -> 0; > tope -> tope
	ld a,d			;725f
	cp 0ffh		;7260   ; un 0xFF es que se ha pasado por abajo: se queda en 0
	jr nz,CURSOR_HL_TOPE_X		;7262
	xor a			;7264
	ld d,a			;7265
CURSOR_HL_TOPE_X:		; D <= B
	cp b			;7266   ; y por arriba el tope es B
	jr c,CURSOR_HL_Y_MENOS		;7267
	ld d,b			;7269
CURSOR_HL_Y_MENOS:		; E = -1 -> 0
	ld a,e			;726a
	cp 0ffh		;726b
	jr nz,CURSOR_HL_TOPE_Y		;726d
	xor a			;726f
	ld e,a			;7270
CURSOR_HL_TOPE_Y:		; E <= C
	cp c			;7271
	jr c,CURSOR_HL_GUARDA		;7272
	ld e,c			;7274
CURSOR_HL_GUARDA:		; escribe D y E; C = 1 si alguno cambio
	ld c,000h		;7275   ; C se enciende si alguno de los dos ejes ha cambiado, y solo entonces suena
	ld a,d			;7277
	cp (hl)			;7278
	jr z,CURSOR_HL_GUARDA_X		;7279
	ld c,001h		;727b
CURSOR_HL_GUARDA_X:		; (HL) = D
	ld (hl),d			;727d   ; primero la columna...
	dec hl			;727e
	ld a,e			;727f
	cp (hl)			;7280
	jr z,CURSOR_HL_GUARDA_Y		;7281
	ld c,001h		;7283
CURSOR_HL_GUARDA_Y:		; (HL-1) = E; sonido 0x25 si cambio
	ld (hl),e			;7285   ; ...y luego la fila, un byte por detras
	ld a,c			;7286
	or a			;7287
	ret z			;7288
	ld a,025h		;7289
	jp 04174h		;728b
ESCRIBE_SPRITE_EDBC:		; (HL) = E, D, B, C (y, x, patron, color)
	ld (hl),e			;728e   ; los cuatro bytes del atributo, con el patron en B y el color en C
	inc l			;728f
	ld (hl),d			;7290
	inc l			;7291
	ld (hl),b			;7292
	inc l			;7293
	ld (hl),c			;7294
	inc l			;7295
	ret			;7296
INTERCAMBIA_BLOQUES:		; intercambia C bytes (B+1 veces) entre (HL) y (DE); acaba en 0x7418 (E250 = 4)
	inc b			;7297   ; el `inc b` es para que el `djnz` de abajo cuente bien cuando B viene a cero
INTERCAMBIA_BYTE:		; un byte por vuelta
	ld a,(hl)			;7298   ; se cambian con A y A': dos bytes en el aire y ninguno perdido
	ex af,af'			;7299
	ld a,(de)			;729a
	ld (hl),a			;729b
	ex af,af'			;729c   ; el segundo byte se escribe con el que estaba esperando en A'
	ld (de),a			;729d
	inc hl			;729e
	inc de			;729f
	dec c			;72a0
	jr nz,INTERCAMBIA_BYTE		;72a1
	djnz INTERCAMBIA_BYTE		;72a3
	jp A_ESTADO_4_B		;72a5

; ----------------------------------------------------------------------
; LA CONTRASENA. El juego guarda la partida en un codigo de letras:
; 21 valores (los bytes de E280 a E294, o sea lo conseguido en cada
; carrera) recortados a un nibble cada uno, mas dos de control -uno
; la XOR de todos y otro la suma-, y delante un nibble al azar
; sacado del registro R. Los 24 simbolos se cifran con una tirada de
; nibbles que sale de la PROPIA ROM (0x5000 en adelante, la pagina 0,
; que esta siempre mapeada), empezando por el nibble al azar, y solo
; entonces se pasan a letras sumandoles 0x41.
; ----------------------------------------------------------------------
PASSWORD:		; E252 = 0: limpia, genera la contrasena (0x7317), la descifra... la cifra (0x72F4), a letras (0x72E6), y la pinta en 0x3A43 (fila 18, col 3) con p00 0x480D; E252++; luego espera boton o espacio: sonido 0x26 y E250 = 4
	ld a,(0e252h)		;72a8
	or a			;72ab   ; E252 = 0 es "todavia no se ha generado"
	jr nz,PASSWORD_ESPERA		;72ac
	call 04460h		;72ae
	call BORRA_FILAS_16_23		;72b1
	call GENERA_PASSWORD		;72b4
	ld hl,0ea52h		;72b7   ; primero se genera en claro y luego se cifra encima
	call CIFRA_PASSWORD		;72ba
	ld hl,0ea52h		;72bd
	call VALORES_A_LETRAS		;72c0
	ld de,0ea50h		;72c3
	ld bc,03a43h		;72c6   ; 0x3A43 es la fila 18, columna 3
	ld (0ea50h),bc		;72c9
	call 0480dh		;72cd
	ld hl,0e252h		;72d0
	inc (hl)			;72d3
	ret			;72d4
PASSWORD_ESPERA:		; boton o espacio (E1C8 & 0x30) -> sonido 0x26 y E250 = 4
	ld a,(0e1c8h)		;72d5   ; el boton o el espacio sacan de aqui
	and 030h		;72d8
	ret z			;72da
	ld a,026h		;72db
	call 04174h		;72dd
	ld a,004h		;72e0
	ld (0e250h),a		;72e2
	ret			;72e5
VALORES_A_LETRAS:		; cada byte de (HL) hasta 0xFF: += 0x41 ('A'..)
	ld a,(hl)			;72e6   ; sumar 0x41 convierte el valor en una letra a partir de la A
	cp 0ffh		;72e7
	ret z			;72e9
	call MAS_41		;72ea
	ld (hl),a			;72ed
	inc hl			;72ee
	jr VALORES_A_LETRAS		;72ef
MAS_41:		; A += 0x41
	add a,041h		;72f1
	ret			;72f3
CIFRA_PASSWORD:		; el primer byte es la clave E (0..15); cada byte siguiente ^= (p00 0x5000+E) & 0x0F, y & 0x1F (E avanza); hasta 0xFF
	ld a,(hl)			;72f4   ; el primer simbolo no es un dato: es la clave, y dice por que byte de la ROM empieza la tirada
	ld e,a			;72f5
	ld d,050h		;72f6   ; 0x5000 es codigo de la propia pagina 0: la tirada de cifrado son los bytes del cartucho
	inc hl			;72f8
CIFRA_BYTE:		; un simbolo por vuelta
	ld a,(hl)			;72f9
	cp 0ffh		;72fa
	ret z			;72fc
	ld a,(de)			;72fd   ; la tirada de cifrado avanza a la vez que el texto
	and 00fh		;72fe
	xor (hl)			;7300
	and 01fh		;7301   ; y el resultado se recorta a cinco bits, que es lo que cabe en una letra
	ld (hl),a			;7303
	inc de			;7304
	inc hl			;7305
	jr CIFRA_BYTE		;7306
ANADE_SIMBOLO:		; A = min(A, 15) -> (BC++); D ^= A, E += A (los dos de control)
	cp 00fh		;7308   ; ningun valor pasa de 15: lo que no quepa en un nibble se pierde
	jr c,ANADE_SIMBOLO_ESCRIBE		;730a
	ld a,00fh		;730c
ANADE_SIMBOLO_ESCRIBE:		; (BC) = A y control
	ld (bc),a			;730e
	inc bc			;730f
	push af			;7310
	xor d			;7311   ; los dos controles se llevan a la vez: D la XOR y E la suma
	ld d,a			;7312
	pop af			;7313
	add a,e			;7314
	ld e,a			;7315
	ret			;7316
GENERA_PASSWORD:		; E280..E294 a EA60 (0x7565); EA50/51 = 0x3830; en EA52..: el nibble aleatorio de R, los 21 valores, D (xor) y E (suma), 0xFF
	call E280_A_EA60		;7317
	ld de,00000h		;731a
	ld bc,03830h		;731d
	ld (0ea50h),bc		;7320
	ld bc,0ea52h		;7324
	ld a,r		;7327   ; el nibble al azar sale del registro R, el contador de refresco: es lo mas parecido a un dado que hay a mano
	rrca			;7329
	rrca			;732a
	and 00fh		;732b
	call ANADE_SIMBOLO		;732d
	ld ix,0ea60h		;7330
	ld h,015h		;7334   ; los 21 valores son las 21 carreras
GENERA_PASSWORD_BUCLE:		; un valor de EA60.. por vuelta (21)
	ld a,(ix+000h)		;7336
	inc ix		;7339
	call ANADE_SIMBOLO		;733b
	dec h			;733e
	jr nz,GENERA_PASSWORD_BUCLE		;733f
	ld a,d			;7341   ; y detras van los dos controles, un nibble cada uno
	and 00fh		;7342
	call ANADE_SIMBOLO		;7344
	ld a,e			;7347
	and 00fh		;7348
	call ANADE_SIMBOLO		;734a
	ld a,0ffh		;734d   ; el 0xFF cierra la contrasena
	ld (bc),a			;734f
	ret			;7350
INPUT_PASSWORD:		; E252 = 0: limpia, EA50..EA7E = 0xFF, (EA70) = EA52 (donde escribe), (EA50) = 0x3A43; 1: lee el teclado (0x7380); 2: comprueba (0x73CE); 3: espera E1C4 y E250 = 4 (0x7413)
	ld a,(0e252h)		;7351   ; escribir la contrasena tiene tres pasos: montar la pantalla, leer teclas y comprobar
	dec a			;7354
	jr z,INPUT_PASSWORD_TECLA		;7355
	dec a			;7357
	jr z,COMPRUEBA_PASSWORD		;7358
	jp p,ESPERA_E1C4		;735a
	call 04460h		;735d
	call BORRA_FILAS_16_23		;7360
	ld hl,0ea50h		;7363
	ld bc,0002fh		;7366
	ld a,0ffh		;7369   ; el hueco se rellena de 0xFF, que es lo que el pintador lee como final
	call 04b88h		;736b
	ld de,0ea52h		;736e
	ld (0ea70h),de		;7371   ; EA70 es por donde va escribiendo el jugador
	ld hl,03a43h		;7375
	ld (0ea50h),hl		;7378
	ld hl,0e252h		;737b
	inc (hl)			;737e
	ret			;737f
INPUT_PASSWORD_TECLA:		; pinta EA50 (0x480D) y lee una tecla de p03 0xB3A9 (C = ninguna): 8 borra (0x73B6), 0x0D acepta (0x73C9), '0'..'9' y 'A'..'Z' se guardan en (EA70)++ hasta EA6A
	ld de,0ea50h		;7380
	call 0480dh		;7383   ; la pantalla se repinta en cada vuelta: asi se ve lo que se escribe
LEE_TECLA_PASSWORD:		; p03 0xB3A9: carry = sin tecla
	call 0b3a9h		;7386   ; con acarreo no hay tecla nueva
	ret c			;7389
	cp 008h		;738a   ; el 8 es el borrado y el 0x0D el intro
	jr z,BORRA_TECLA		;738c
	cp 00dh		;738e
	jp z,PASO_SIGUIENTE_E252		;7390
	cp 030h		;7393   ; solo valen los digitos y las letras: se descartan los codigos de en medio
	jr c,LEE_TECLA_PASSWORD		;7395
	cp 05bh		;7397
	jr nc,LEE_TECLA_PASSWORD		;7399
	ld c,a			;739b
	cp 041h		;739c
	jr nc,GUARDA_TECLA		;739e
	cp 03ah		;73a0
	jr nc,LEE_TECLA_PASSWORD		;73a2
GUARDA_TECLA:		; (EA70) < EA6A: guarda y avanza
	ld de,(0ea70h)		;73a4
	ld a,e			;73a8
	cp 06ah		;73a9   ; y no se pasa de EA6A: veinticuatro letras y ni una mas
	jr nc,INPUT_PASSWORD_TECLA		;73ab
	ld a,c			;73ad
	ld (de),a			;73ae
	inc de			;73af
	ld (0ea70h),de		;73b0
	jr INPUT_PASSWORD_TECLA		;73b4
BORRA_TECLA:		; si (EA70) > EA52: retrocede y pone '?' (0x3F)
	ld de,(0ea70h)		;73b6
	ld a,e			;73ba
	cp 052h		;73bb   ; si no se ha escrito nada no hay nada que borrar
	jr z,INPUT_PASSWORD_TECLA		;73bd
	dec de			;73bf
	ld a,03fh		;73c0   ; al borrar se deja un interrogante, que es lo que hace de hueco
	ld (de),a			;73c2
	ld (0ea70h),de		;73c3
	jr INPUT_PASSWORD_TECLA		;73c7
PASO_SIGUIENTE_E252:		; E252++
	ld hl,0e252h		;73c9
	inc (hl)			;73cc
	ret			;73cd
COMPRUEBA_PASSWORD:		; borra filas 16-23; contrasena especial (0x7467) -> "CORRECT"; si no letras a valores (0x7522), descifra (0x72F4), verifica (0x7530): Z -> EA53.. a E280 y total (0x7571) y "CORRECT" (0x741E); NZ -> "WRONG PASSWORD" (0x7437); E1C4 = 0x3C y E252++
	call BORRA_FILAS_16_23		;73ce
	call PASSWORD_ESPECIAL		;73d1   ; antes de nada se prueba si es una de las contrasenas especiales
	jr z,PASSWORD_CORRECT		;73d4
	ld hl,0ea52h		;73d6
	call LETRAS_A_VALORES		;73d9
	ld hl,0ea52h		;73dc
	call CIFRA_PASSWORD		;73df
	ld hl,0ea52h		;73e2
	call VERIFICA_PASSWORD		;73e5   ; y si no, se descifra y se comprueban los dos controles
	jr nz,PASSWORD_WRONG		;73e8
	call EA53_A_E280		;73ea
PASSWORD_CORRECT:		; pinta 0x741E en 0x3A43, E1C4 = 0x3C, sonido 0x26, E252++
	ld de,0741eh		;73ed
	call 0480dh		;73f0
	ld a,03ch		;73f3   ; 0x3C fotogramas para leer el mensaje
	ld (0e1c4h),a		;73f5
	ld a,026h		;73f8
	call 04174h		;73fa
	jr PASO_SIGUIENTE_E252		;73fd
PASSWORD_WRONG:		; pinta 0x7437, E1C4 = 0x3C, E252++
	ld de,07437h		;73ff   ; y con la contrasena mala, el mismo tiempo pero con otro rotulo
	call 0480dh		;7402
	ld a,03ch		;7405
	ld (0e1c4h),a		;7407
	jr PASO_SIGUIENTE_E252		;740a
L_740C:
	ld a,03ch		;740c   ; este trozo no lo llama nadie: es el mismo par de instrucciones que ya hay en 0x7405
	ld (0e1c4h),a		;740e
	jr PASO_SIGUIENTE_E252		;7411
ESPERA_E1C4:		; E1C4--; a cero E250 = 4
	ld hl,0e1c4h		;7413
	dec (hl)			;7416   ; cuando se agota el aviso se vuelve al menu
	ret nz			;7417
A_ESTADO_4_B:		; E250 = 4
	ld a,004h		;7418
	ld (0e250h),a		;741a
	ret			;741d

; ----------------------------------------------------------------------
; DATOS texto_correct: flujo para 0x480D: en 0x3A43 "CORRECT" y 16 espacios,
;   0xFF
;   0x741e..0x7437  (25 bytes)
DATA_texto_correct:
	defb 043h,03ah,043h,04fh,052h,052h,045h,043h,054h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,0ffh	; 741e  C:CORRECT               .

; ----------------------------------------------------------------------
; DATOS texto_wrong: flujo para 0x480D: en 0x3A43 "WRONG PASSWORD" y 8
;   espacios, 0xFF
;   0x7437..0x7450  (25 bytes)
DATA_texto_wrong:
	defb 043h,03ah,057h,052h,04fh,04eh,047h,020h,050h,041h,053h,053h,057h,04fh,052h,044h,020h,020h,020h,020h,020h,020h,020h,020h,0ffh	; 7437  C:WRONG PASSWORD        .

; ======================================================================
; CODIGO 0x7450..0x7497  (71 bytes)
; ======================================================================


GAME_OVER_MENU:		; p02 0x869A y E251++ (-> 0x7458)
	call 0869ah		;7450
	ld hl,0e251h		;7453
	inc (hl)			;7456
	ret			;7457
GAME_OVER_MENU_FIN:		; sonido 0x33 (p02 0x884C), p00 0x5D16 y E1C0 = 1 (E1C1 = 0): vuelve al estado 1 del juego
	ld a,033h		;7458
	call 0884ch		;745a   ; la musica 0x33 vuelve a sonar y se rehace la presentacion
	call 05d16h		;745d
	ld hl,00001h		;7460
	ld (0e1c0h),hl		;7463
	ret			;7466

; ----------------------------------------------------------------------
; LAS SEIS CONTRASENAS ESPECIALES. Antes de descifrar nada se prueba
; lo escrito contra seis palabras sueltas, y cada una lleva su codigo
; pegado detras del 0xFF que la cierra:
; MAXPOINT         E1DF = 1: los umbrales de puntos dejan de mirarse
; y quedan abiertas todas las categorias y GP
; " UJM3EDC"       (empieza por un espacio, y las letras son dos
; columnas del teclado) enciende F006 y se va a
; p00 0x58A0: la grabacion de la demo
; MITAIYOENDDEMO   bit 7 de F0FE y estado 0x10: la secuencia final
; HYPEROFF         E1D6 = 1
; ESCON / ESCOFF   encienden y apagan E1FD, el permiso para cortar
; la repeticion con el mando
; ----------------------------------------------------------------------
PASSWORD_ESPECIAL:		; prueba las 6 contrasenas de la tabla 0x7497 (0x7474): Z si alguna coincide (y ya ejecuto su codigo)
	ld b,006h		;7467   ; seis contrasenas, probadas de la ultima a la primera
PASSWORD_ESPECIAL_BUCLE:		; una por vuelta (B = 6..1)
	push bc			;7469
	call COMPARA_PASSWORD_ESPECIAL		;746a
	pop bc			;746d
	ret z			;746e   ; la primera que cuadre corta la prueba
	djnz PASSWORD_ESPECIAL_BUCLE		;746f
	or 001h		;7471   ; y si no cuadra ninguna, NZ: sigue el camino normal
	ret			;7473
COMPARA_PASSWORD_ESPECIAL:		; DE = tabla 0x7497[B-1]; compara con EA52.. hasta el 0xFF; si coincide salta al codigo que sigue al 0xFF con retorno 0x7490 (xor a / ret: Z)
	ld de,07497h		;7474
	ld a,b			;7477
	dec a			;7478
	call 04a3bh		;7479   ; la tabla da el texto de la contrasena que toca probar
	ld hl,0ea52h		;747c
	dec hl			;747f   ; los dos punteros arrancan uno por detras, que el bucle empieza subiendolos
	dec de			;7480
COMPARA_PASSWORD_BUCLE:		; un caracter por vuelta
	inc de			;7481
	inc hl			;7482
	ld a,(de)			;7483
	cp (hl)			;7484   ; se compara letra a letra...
	ret nz			;7485
	inc a			;7486   ; ...y el 0xFF final es lo que dice que la palabra entera cuadro
	jr nz,COMPARA_PASSWORD_BUCLE		;7487
	inc de			;7489
	ex de,hl			;748a
	ld de,PASSWORD_ESPECIAL_OK		;748b   ; el codigo del truco esta pegado detras del texto, y se llega a el con un `jp (hl)` dejando el retorno puesto a mano
	push de			;748e
	jp (hl)			;748f
PASSWORD_ESPECIAL_OK:		; retorno comun de los codigos especiales: A = 0, Z
	xor a			;7490   ; todos los trucos vuelven por aqui, con Z puesto
	ret			;7491
L_7492:
	cp (hl)			;7492   ; estos cuatro bytes no los ejecuta nadie: son la cola del `jr` de 0x7487 vista desde otro sitio
	inc hl			;7493
	ret nz			;7494
	jr COMPARA_PASSWORD_BUCLE		;7495

; ----------------------------------------------------------------------
; DATOS tabla_passwords_especiales: 6 punteros a los textos: 0x74A3 MAXPOINT,
;   0x74BB UJM3EDC, 0x74E2 XMITAIYOENDDEMO, 0x74FB HYPEROFF, 0x750A ESCON,
;   0x7516 ESCOFF
;   0x7497..0x74a3  (12 bytes)
DATA_tabla_passwords_especiales:
	defw 074a3h	; 7497  -> DATA_password_maxpoint
	defw 074bbh	; 7499  -> DATA_password_ujm3edc
	defw 074e2h	; 749b  -> DATA_password_enddemo
	defw 074fbh	; 749d  -> DATA_password_hyperoff
	defw 0750ah	; 749f  -> DATA_password_escon
	defw 07516h	; 74a1  -> DATA_password_escoff

; ----------------------------------------------------------------------
; DATOS password_maxpoint: "MAXPOINT", 0xFF
;   0x74a3..0x74ac  (9 bytes)
DATA_password_maxpoint:
	defb 04dh,041h,058h,050h,04fh,049h,04eh,054h,0ffh	; 74a3  MAXPOINT.

; ======================================================================
; CODIGO 0x74ac..0x74bb  (15 bytes)
; ======================================================================


CODIGO_MAXPOINT:		; E1DF = 1 (0x6227 deja de comparar los puntos: todo desbloqueado)
	ld a,001h		;74ac   ; MAXPOINT no da puntos: apaga la comprobacion, que es mas barato
	ld (0e1dfh),a		;74ae
	ret			;74b1
PUNTOS_200:		; E295 = E355 = 0xC8 (desde p00 0x57F4)
	ld a,0c8h		;74b2   ; esto no es de las contrasenas: lo llama p00 0x57F4 y pone los puntos de los dos jugadores a 200
	ld (0e295h),a		;74b4
	ld (0e355h),a		;74b7
	ret			;74ba

; ----------------------------------------------------------------------
; DATOS password_ujm3edc: " UJM3EDC", 0xFF (dos columnas del teclado)
;   0x74bb..0x74c4  (9 bytes)
DATA_password_ujm3edc:
	defb 020h,055h,04ah,04dh,033h,045h,044h,043h,0ffh	; 74bb   UJM3EDC.

; ======================================================================
; CODIGO 0x74c4..0x74e2  (30 bytes)
; ======================================================================


CODIGO_UJM3EDC:		; si F0FE != 0 y E1DE != 2: F006 = 1, E25B = 0xFF, E29D = 0 y p00 0x58A0
	ld a,(0f0feh)		;74c4   ; UJM3EDC solo funciona si F0FE trae algo y no se esta reproduciendo
	or a			;74c7
	ret z			;74c8
	ld a,001h		;74c9
	ld c,a			;74cb
	ld a,(0e1deh)		;74cc
	cp 002h		;74cf
	ret z			;74d1
	ld a,c			;74d2
	ld (0f006h),a		;74d3
	ld a,0ffh		;74d6   ; y de paso deja el menu sin categoria elegida
	ld (0e25bh),a		;74d8
	xor a			;74db
	ld (0e29dh),a		;74dc
	jp 058a0h		;74df

; ----------------------------------------------------------------------
; DATOS password_enddemo: "MITAIYOENDDEMO" y 0xFF (0x74F0); el codigo del
;   truco sigue en 0x74F1
;   0x74e2..0x74f1  (15 bytes)
DATA_password_enddemo:
	defb 04dh,049h,054h,041h,049h,059h,04fh,045h,04eh,044h,044h,045h,04dh,04fh,0ffh	; 74e2  MITAIYOENDDEMO.

; ======================================================================
; CODIGO 0x74f1..0x74fb  (10 bytes)
; ======================================================================


CODIGO_ENDDEMO:		; bit 7 de F0FE y E250 = 0x10 (la secuencia final)
	ld hl,0f0feh		;74f1
	set 7,(hl)		;74f4   ; el bit 7 de F0FE es la marca de "ensename el final"
	ld a,010h		;74f6
	jp PON_ESTADO		;74f8

; ----------------------------------------------------------------------
; DATOS password_hyperoff: "HYPEROFF", 0xFF
;   0x74fb..0x7504  (9 bytes)
DATA_password_hyperoff:
	defb 048h,059h,050h,045h,052h,04fh,046h,046h,0ffh	; 74fb  HYPEROFF.

; ======================================================================
; CODIGO 0x7504..0x750a  (6 bytes)
; ======================================================================


CODIGO_HYPEROFF:		; E1D6 = 1
	ld a,001h		;7504   ; HYPEROFF enciende E1D6, que es lo que en boxes hace que los mecanicos se pongan a trabajar
	ld (0e1d6h),a		;7506
	ret			;7509

; ----------------------------------------------------------------------
; DATOS password_escon: "ESCON", 0xFF
;   0x750a..0x7510  (6 bytes)
DATA_password_escon:
	defb 045h,053h,043h,04fh,04eh,0ffh	; 750a

; ======================================================================
; CODIGO 0x7510..0x7516  (6 bytes)
; ======================================================================


CODIGO_ESCON:		; E1FD = 1
	ld a,001h		;7510   ; ESCON y ESCOFF son un interruptor: la misma variable a 1 y a 0
	ld (0e1fdh),a		;7512
	ret			;7515

; ----------------------------------------------------------------------
; DATOS password_escoff: "ESCOFF", 0xFF
;   0x7516..0x751d  (7 bytes)
DATA_password_escoff:
	defb 045h,053h,043h,04fh,046h,046h,0ffh	; 7516

; ======================================================================
; CODIGO 0x751d..0x761b  (254 bytes)
; ======================================================================


CODIGO_ESCOFF:		; E1FD = 0
	xor a			;751d
	ld (0e1fdh),a		;751e
	ret			;7521
LETRAS_A_VALORES:		; cada byte de (HL) hasta 0xFF: -= 0x41
	ld a,(hl)			;7522   ; restar 0x41 deshace lo que hizo 0x72E6
	cp 0ffh		;7523
	ret z			;7525
	call MENOS_41		;7526
	ld (hl),a			;7529
	inc hl			;752a
	jr LETRAS_A_VALORES		;752b
MENOS_41:		; A -= 0x41
	sub 041h		;752d
	ret			;752f
VERIFICA_PASSWORD:		; NZ si algun valor de EA55.. pasa de 9 (0x7558) o si el xor y la suma no cuadran con los dos ultimos; Z si bien
	push hl			;7530
	push bc			;7531
	call VALORES_HASTA_9		;7532   ; primero se mira que ningun valor pase de 9: los descifrados tienen que ser digitos
	pop bc			;7535
	pop hl			;7536
	jr nc,PASSWORD_MAL		;7537
	ld de,00000h		;7539
VERIFICA_SUMA:		; D ^= byte, E += byte hasta el 0xFF
	ld a,(hl)			;753c   ; se rehacen los dos controles sobre lo escrito...
	cp 0ffh		;753d
	jr z,VERIFICA_CONTROL		;753f
	ld a,d			;7541   ; la XOR y la suma se llevan en D y E a la vez
	xor (hl)			;7542
	ld d,a			;7543
	ld a,e			;7544
	add a,(hl)			;7545
	ld e,a			;7546
	inc hl			;7547
	jr VERIFICA_SUMA		;7548
VERIFICA_CONTROL:		; quita el ultimo del acumulado y compara
	dec hl			;754a   ; ...y luego se le quita el ultimo, que es el propio control y no cuenta
	ld a,d			;754b
	xor (hl)			;754c
	ld d,a			;754d
	ld a,e			;754e
	sub (hl)			;754f
	sub (hl)			;7550   ; la suma se resta DOS veces: una para deshacer el ultimo y otra para comparar con el
	or d			;7551
	and 00fh		;7552   ; y solo se miran los cuatro bits de abajo, que es lo que cabe en un simbolo
	ret			;7554
PASSWORD_MAL:		; A = 0xFF, NZ
	or 0ffh		;7555
	ret			;7557
VALORES_HASTA_9:		; 15 valores desde HL+3: carry si alguno > 9
	ld b,00fh		;7558   ; quince valores desde el cuarto: los tres primeros son la clave y los controles
	inc hl			;755a
	inc hl			;755b
VALORES_HASTA_9_BUCLE:		; uno por vuelta
	ld a,009h		;755c
	inc hl			;755e
	cp (hl)			;755f   ; el `ccf` da la vuelta al acarreo: se sale con carry en cuanto uno pasa de 9
	ccf			;7560
	ret nc			;7561
	djnz VALORES_HASTA_9_BUCLE		;7562
	ret			;7564
E280_A_EA60:		; los 21 bytes de E280 (mejor puntuacion por carrera) a EA60
	ld hl,0e280h		;7565   ; los 21 bytes son la mejor puntuacion de cada una de las 21 carreras
	ld de,0ea60h		;7568
	ld bc,00015h		;756b
	ldir		;756e
	ret			;7570
EA53_A_E280:		; los 21 valores descifrados a E280 y recalcula el total del coche 1 (0x6BFC)
	ld hl,0ea53h		;7571   ; y al aceptar la contrasena se copian de vuelta y se rehace el total
	ld de,0e280h		;7574
	ld bc,00015h		;7577
	ldir		;757a
	ld iy,0e2c0h		;757c
	jp SUMA_TOTAL_PUNTOS		;7580
PINTA_PANEL_CARRERA:		; 0x7599, 0x76F2, E202..E205 = 0 (los niveles mostrados de los indicadores)
	call PINTA_PANEL_HUD		;7583
	call INICIA_HUD_CARRERA		;7586
	ld hl,00000h		;7589   ; los cuatro indicadores empiezan a cero: la aguja sube desde abajo
	ld (0e202h),hl		;758c
	ld (0e203h),hl		;758f
	ld (0e204h),hl		;7592
	ld (0e205h),hl		;7595
	ret			;7598
PINTA_PANEL_HUD:		; pagina 9 en A000, 0x75A4, 1/2/3
	ld a,009h		;7599
	call 04457h		;759b   ; el dibujo del panel esta en la pagina 9
	call PINTA_PANEL_HUD_VA		;759e
	jp 043feh		;75a1
PINTA_PANEL_HUD_VA:		; borra E400 (0x400); dos jugadores: 16 columnas de p09 0xBAA5 en (x 0x80, y +0) y de 0xBAC0 en (x 8, y +0xA8); uno: 14 columnas de 0xB9DE en (x 0x90, y +0) y el nombre (0x75EB); VUELCA_NOMBRES_E400
	ld iy,0e2c0h		;75a4
	ld hl,0e400h		;75a8
	ld bc,00400h		;75ab   ; el buffer entero a cero, el kilobyte
	call 04b87h		;75ae
	ld a,(0e1c2h)		;75b1
	bit 5,a		;75b4   ; con dos jugadores hay dos paneles, uno arriba y otro abajo
	jr z,PINTA_PANEL_HUD_1J		;75b6
	ld de,08000h		;75b8
	call 04a9dh		;75bb
	ld de,0baa5h		;75be
	ld a,010h		;75c1
	call RLE_A_BUFFER		;75c3
	ld de,008a8h		;75c6   ; el segundo va 0xA8 pixeles mas abajo
	call 04a9dh		;75c9
	ld de,0bac0h		;75cc
	ld a,010h		;75cf
	call RLE_A_BUFFER		;75d1
	jp 044bch		;75d4
PINTA_PANEL_HUD_1J:		; el panel de un jugador: 14 columnas en la columna 18
	ld de,09000h		;75d7   ; con un jugador el panel es mas estrecho -catorce columnas- y va a la derecha
	call 04a9dh		;75da
	ld de,0b9deh		;75dd
	ld a,00eh		;75e0
	call RLE_A_BUFFER		;75e2
	call PINTA_NOMBRE_CARRERA		;75e5
	jp 044bch		;75e8
PINTA_NOMBRE_CARRERA:		; paginas 5/6; p06 0xBC6D[E25C] (11 columnas) en (x 0x98, y +8) del buffer
	ld a,005h		;75eb
	call 04447h		;75ed
	ld a,(0e25ch)		;75f0
	ld hl,0bc6dh		;75f3   ; la misma tabla que 0x61B5: 21 nombres (5 categorias y 16 GP)
	call 04a44h		;75f6
	ld de,09808h		;75f9
	ld iy,0e2c0h		;75fc
	push hl			;7600
	call 04a9dh		;7601
	pop de			;7604
	ld a,00bh		;7605   ; once columnas de ancho tiene el nombre
	call RLE_A_BUFFER		;7607
	jp 043feh		;760a
HUD_CARRERA:		; 0x77EC (mapa), 0x7652 (combustible) y la tarea E1C3 & 7 de la tabla 0x761B
	call AVANZA_MARCADOR_MAPA		;760d   ; el HUD no se repinta entero cada fotograma: se reparte en ocho tareas
	call CONSUMO_COMBUSTIBLE		;7610
	ld a,(0e1c3h)		;7613   ; los tres bits de abajo del contador de fotogramas dicen que tarea toca
	and 007h		;7616
	call 040dah		;7618

; ----------------------------------------------------------------------
; DATOS tabla_7618: 8 palabras del despachador de 0x7618 (`call 0x40DA`),
;   indice (E1C3) & 7: las tareas del HUD
;   0x761b..0x762b  (16 bytes)
DATA_tabla_7618:
	defw 0762bh	; 761b  -> HUD_TAREA_0
	defw 0762eh	; 761d  -> HUD_TAREA_1
	defw 07631h	; 761f  -> HUD_TAREA_2
	defw 07634h	; 7621  -> HUD_TAREA_3
	defw 07637h	; 7623  -> HUD_TAREA_4
	defw 0763ah	; 7625  -> HUD_TAREA_5
	defw 07640h	; 7627  -> HUD_TAREA_6
	defw 07643h	; 7629  -> HUD_TAREA_7

; ======================================================================
; CODIGO 0x762b..0x76aa  (127 bytes)
; ======================================================================


HUD_TAREA_0:		; 0x7B0F
	jp HUD_INDICADOR_E19A		;762b   ; cuatro de las ocho tareas son el mismo indicador: se repinta el doble de a menudo que los demas
HUD_TAREA_1:		; 0x7AD9 (velocidad)
	jp HUD_VELOCIDAD		;762e
HUD_TAREA_2:		; 0x7B0F
	jp HUD_INDICADOR_E19A		;7631
HUD_TAREA_3:		; 0x7AA2
	jp HUD_E329		;7634
HUD_TAREA_4:		; 0x7B0F
	jp HUD_INDICADOR_E19A		;7637
HUD_TAREA_5:		; 0x78FB (neumaticos) y 0x79B3 (posicion, vueltas, mapa)
	call HUD_NEUMATICOS		;763a   ; la tarea 5 hace dos cosas: los neumaticos y el marcador de posicion
	jp HUD_POSICION_VUELTAS		;763d
HUD_TAREA_6:		; 0x7B0F
	jp HUD_INDICADOR_E19A		;7640
HUD_TAREA_7:		; 0x7A45 (combustible)
	jp HUD_COMBUSTIBLE		;7643
RESTA_COMBUSTIBLE_18:		; (ix+50) -= 0x18, minimo 0 (desde p02 0x8E13)
	ld a,(ix+050h)		;7646   ; el frenazo de p02 se lleva 0x18 de golpe, y no baja de cero
	sub 018h		;7649
	jr nc,GUARDA_COMBUSTIBLE		;764b
	xor a			;764d
GUARDA_COMBUSTIBLE:		; (ix+50) = A
	ld (ix+050h),a		;764e
	ret			;7651
CONSUMO_COMBUSTIBLE:		; cada 256 fotogramas (E1C3 = 0), por coche (0x7669)
	ld a,(0e1c3h)		;7652
	and 0ffh		;7655   ; el `and 0xff` no recorta nada: lo unico que hace es poner Z si el contador vale cero, o sea una vez cada 256 fotogramas
	ret nz			;7657
	ld ix,0e2c0h		;7658
	call CONSUMO_COCHE		;765c
	ld a,(0e1c2h)		;765f
	bit 5,a		;7662
	ret z			;7664
	ld ix,0e380h		;7665
CONSUMO_COCHE:		; solo si (ix+5D) = 0; (ix+50) -= D (0x7699) + ((ix+59) >> 3 & 0x1F si (ix+12) < 0); si baja de 0x11 sonido 0x1D (p02 0x8674)
	ld a,(ix+05dh)		;7669   ; el coche parado o fuera de carrera no gasta
	cp 000h		;766c
	ret nz			;766e
	call CONSUMO_BASE		;766f
	ld a,(ix+012h)		;7672   ; con el acelerador negativo -frenando- solo se gasta lo basico
	neg		;7675
	or a			;7677
	ld a,000h		;7678
	jp p,CONSUMO_RESTA		;767a
	ld a,(ix+059h)		;767d   ; y acelerando se gasta ademas por revoluciones, cinco bits de ellas
	rrca			;7680
	rrca			;7681
	rrca			;7682
	and 01fh		;7683
CONSUMO_RESTA:		; B = D + A; (ix+50) -= B
	add a,d			;7685   ; el gasto base mas el de revoluciones
	ld b,a			;7686
	ld a,(ix+050h)		;7687
	sub b			;768a
	jr nc,CONSUMO_GUARDA		;768b
	xor a			;768d
CONSUMO_GUARDA:		; guarda y avisa si < 0x11
	ld (ix+050h),a		;768e
	cp 011h		;7691   ; por debajo de 0x11 salta el aviso de que queda poco
	ret nc			;7693
	ld a,01dh		;7694
	jp 08674h		;7696
CONSUMO_BASE:		; D = 0x30 si p02 0x8E8E devuelve NC; si no D = tabla 0x76AA[(ix+74)]
	call 08e8eh		;7699   ; en boxes -o mientras el cronometro no pase de 0x80- el gasto es plano, 0x30
	ld d,030h		;769c
	ret nc			;769e
	ld e,(ix+074h)		;769f   ; fuera de boxes el gasto base lo dice el motor elegido, (ix+74)
	ld d,000h		;76a2
	ld hl,076aah		;76a4
	add hl,de			;76a7
	ld d,(hl)			;76a8
	ret			;76a9

; ----------------------------------------------------------------------
; DATOS tabla_consumo: 36 palabras (byte bajo = consumo base por 256
;   fotogramas) indexadas por (ix+74): seis grupos de seis (hipotesis: por
;   categoria y motor)
;   0x76aa..0x76f2  (72 bytes)
DATA_tabla_consumo:
	defw 0000ah,00009h,0000bh,0000ch,0000fh,0000dh	; 76aa
	defw 0000ah,00009h,0000bh,0000ch,0000fh,0000dh	; 76b6
	defw 0000eh,0000ch,0000fh,00010h,00015h,00012h	; 76c2
	defw 0000eh,0000ch,0000fh,00010h,00015h,00012h	; 76ce
	defw 0000eh,0000ch,0000fh,00010h,00015h,00012h	; 76da
	defw 00010h,0000eh,00011h,00013h,00018h,00014h	; 76e6

; ======================================================================
; CODIGO 0x76f2..0x7719  (39 bytes)
; ======================================================================


INICIA_HUD_CARRERA:		; E1FC = p02 0x91CA (vueltas); (ix+6D) = tabla 0x7719[E25C] por coche
	call 091cah		;76f2   ; E1FC son las vueltas de la carrera, que las cuenta p02
	ld (0e1fch),a		;76f5
	ld ix,0e2c0h		;76f8
	ld a,(0e1c2h)		;76fc
	bit 5,a		;76ff   ; con dos jugadores hay que darle su paso a cada coche
	jr z,$+45		;7701
	call PASO_MAPA_COCHE		;7703
	ld ix,0e380h		;7706
PASO_MAPA_COCHE:		; (ix+6D) = 0x7719[E25C]
	ld hl,07719h		;770a   ; el paso del marcador del mapa cambia con el circuito: los hay largos y cortos
	ld a,(0e25ch)		;770d
	ld e,a			;7710
	ld d,000h		;7711
	add hl,de			;7713
	ld a,(hl)			;7714
	ld (ix+06dh),a		;7715
	ret			;7718

; ----------------------------------------------------------------------
; DATOS tabla_paso_mapa: 21 bytes por carrera (E25C): filas de pista por paso
;   del marcador del mapa (0xA6, 0xD0, 0xB8, 0xC3, 0xBE, 0xC6, 0xDD, 0xB3)
;   0x7719..0x772e  (21 bytes)
DATA_tabla_paso_mapa:
	defb 0a6h,0d0h,0a6h,0b8h,0a6h,0a6h,0c3h,0beh,0c6h,0ddh,0c3h,0d0h,0b8h,0b8h,0b8h,0d0h,0b8h,0b3h,0d0h,0b3h,0d0h	; 7719  .....................

; ======================================================================
; CODIGO 0x772e..0x7753  (37 bytes)
; ======================================================================


INICIA_MAPA_772E:		; sin referencia: E32C = 1; (E2BA) y (E241) de la tabla 0x7753[E25C]; (ix+6D) = 2
	ld a,001h		;772e   ; este trozo no lo llama nadie, pero es la pareja de 0x77A7: pone el marcador en su sitio de salida y le da el camino
	ld (0e32ch),a		;7730
	ld hl,07753h		;7733
	ld a,(0e25ch)		;7736
	add a,a			;7739   ; por cuatro: cada entrada son dos palabras
	add a,a			;773a
	ld e,a			;773b
	ld d,000h		;773c
	add hl,de			;773e
	ld e,(hl)			;773f
	inc hl			;7740
	ld d,(hl)			;7741
	inc hl			;7742
	ld a,(hl)			;7743
	inc hl			;7744
	ld h,(hl)			;7745
	ld l,a			;7746
	ld (0e2bah),de		;7747   ; E2BA es donde esta el marcador y E241 por donde va del camino
	ld (0e241h),hl		;774b
	ld (ix+06dh),002h		;774e
	ret			;7752

; ----------------------------------------------------------------------
; DATOS tabla_mapa_inicio: 21 entradas (E25C) de dos palabras: posicion
;   inicial del marcador (E2BA) y puntero al camino de deltas (E241) en
;   p05/p06
;   0x7753..0x77a7  (84 bytes)
DATA_tabla_mapa_inicio:
	defw 09d24h,0b22eh	; 7753
	defw 0c118h,0b27fh	; 7757
	defw 0b508h,0b2c0h	; 775b
	defw 0b708h,0b311h	; 775f
	defw 0cd1dh,0b358h	; 7763
	defw 0ad10h,0b3a9h	; 7767
	defw 0b529h,0b3fah	; 776b
	defw 0ad28h,0b43fh	; 776f
	defw 0a90ah,0b486h	; 7773
	defw 0d12dh,0b4c5h	; 7777
	defw 0ad29h,0b50ah	; 777b
	defw 0a42ch,0b547h	; 777f
	defw 0951dh,0b588h	; 7783
	defw 0c531h,0b5d1h	; 7787
	defw 0cd2ch,0b61ah	; 778b
	defw 0d525h,0b663h	; 778f
	defw 0c534h,0b6a4h	; 7793
	defw 0bd10h,0b6edh	; 7797
	defw 0d11eh,0b738h	; 779b
	defw 0ad29h,0b779h	; 779f
	defw 0a110h,0b7c4h	; 77a3

; ======================================================================
; CODIGO 0x77a7..0x77c2  (27 bytes)
; ======================================================================


REINICIA_MAPA_VUELTA:		; (ix+6C) = (ix+6E) = 0; un jugador: (E2BA) = tabla 0x77C2[E25C] (desde p00 FIN_DE_VUELTA)
	xor a			;77a7   ; al cerrar una vuelta el marcador vuelve a la salida
	ld (ix+06ch),a		;77a8
	ld (ix+06eh),a		;77ab
	ld a,(0e1c2h)		;77ae   ; con dos jugadores el marcador no se recoloca: cada uno lleva el suyo
	bit 5,a		;77b1
	ret nz			;77b3
	ld de,077c2h		;77b4
	ld a,(0e25ch)		;77b7
	call 04a3bh		;77ba   ; la tabla de 0x77C2 tiene la posicion de salida de los 21 circuitos
	ld (0e2bah),de		;77bd
	ret			;77c1

; ----------------------------------------------------------------------
; DATOS tabla_mapa_salida: 21 palabras (E25C): posicion (y, x) del marcador
;   del mapa en la salida
;   0x77c2..0x77ec  (42 bytes)
DATA_tabla_mapa_salida:
	defw 09d25h	; 77c2
	defw 0bf18h	; 77c4
	defw 0b208h	; 77c6
	defw 0b608h	; 77c8
	defw 0cc1dh	; 77ca
	defw 0ac10h	; 77cc
	defw 0b429h	; 77ce
	defw 0ae28h	; 77d0
	defw 0a70bh	; 77d2
	defw 0d02dh	; 77d4
	defw 0ae29h	; 77d6
	defw 0a52dh	; 77d8
	defw 09522h	; 77da
	defw 0c731h	; 77dc
	defw 0ce2ch	; 77de
	defw 0d625h	; 77e0
	defw 0c834h	; 77e2
	defw 0be10h	; 77e4
	defw 0d81bh	; 77e6
	defw 0ae29h	; 77e8
	defw 0a010h	; 77ea

; ======================================================================
; CODIGO 0x77ec..0x78f5  (265 bytes)
; ======================================================================


AVANZA_MARCADOR_MAPA:		; por coche: dos jugadores -> contador de 16 bits (ix+6E,6C) += 2*(ix+6D) si bit 0 de (ix+6F) (0x7804); uno -> 0x781E
	ld ix,0e2c0h		;77ec   ; el marcador del mapa avanza por su cuenta, con su propio contador
	ld a,(0e1c2h)		;77f0
	bit 5,a		;77f3
	jr z,AVANZA_MARCADOR_1J		;77f5
	call AVANZA_CONTADOR_2J		;77f7
	ld a,(0e1c2h)		;77fa
	bit 5,a		;77fd
	ret z			;77ff
	ld ix,0e380h		;7800
AVANZA_CONTADOR_2J:		; (ix+6C:6E) += 2*(ix+6D) cuando el bit 0 de (ix+6F) esta puesto
	ld a,(ix+06fh)		;7804   ; el bit 0 de (ix+6F) es "la pieza acaba de cambiar": solo entonces avanza
	and 001h		;7807
	ret z			;7809
	ld l,(ix+06dh)		;780a   ; el paso por dos, sumado a un contador de 16 bits: la parte alta es por que punto del camino va
	ld h,000h		;780d
	ld e,(ix+06eh)		;780f
	ld d,(ix+06ch)		;7812
	add hl,hl			;7815
	add hl,de			;7816
	ld (ix+06eh),l		;7817
	ld (ix+06ch),h		;781a
	ret			;781d
AVANZA_MARCADOR_1J:		; si toca un paso (0x7867): paginas 5/6; por cada paso (B): byte (E241)+(ix+6C): nibble BAJO -> (ix-6) = (E2BA) = y, nibble ALTO -> (ix-5) = (E2BB) = x (con signo, ver 0x784E): mueve el marcador del mapa por el camino; 1/2/3
	call TOCA_PASO_MAPA		;781e   ; el camino son deltas empaquetadas: cada byte lleva dos, una por nibble
	ret c			;7821
	ld a,005h		;7822   ; el camino vive en la pagina 5
	call 04447h		;7824
AVANZA_MARCADOR_PASO:		; un paso del camino por vuelta
	ld a,(ix+06ch)		;7827   ; (ix+6C) es el indice dentro del camino
	ld l,a			;782a
	ld h,000h		;782b
	ld de,(0e241h)		;782d
	add hl,de			;7831
	call DELTAS_DEL_BYTE		;7832
	ld a,(ix-006h)		;7835
	add a,d			;7838
	ld (ix-006h),a		;7839
	ld a,(ix-005h)		;783c
	add a,e			;783f
	ld (ix-005h),a		;7840
	inc (ix+06ch)		;7843   ; el indice sube por cada paso dado...
	djnz AVANZA_MARCADOR_PASO		;7846
	dec (ix+06ch)		;7848   ; ...y al salir se deshace el ultimo, que se dio de mas
	jp 043feh		;784b
DELTAS_DEL_BYTE:		; los rrca x4 intercambian los nibbles ANTES de los sra: D = nibble BAJO con signo (va a la y) y E = nibble ALTO con signo (va a la x)
	ld a,(hl)			;784e   ; las cuatro rotaciones no son una division: cambian los nibbles de sitio, y los `sra` de despues son los que extienden el signo
	rrca			;784f
	rrca			;7850
	rrca			;7851
	rrca			;7852
	sra a		;7853
	sra a		;7855
	sra a		;7857
	sra a		;7859
	ld d,a			;785b
	ld a,(hl)			;785c
	sra a		;785d   ; el nibble bajo se saca sin rotar antes: los mismos cuatro `sra` valen para los dos
	sra a		;785f
	sra a		;7861
	sra a		;7863
	ld e,a			;7865
	ret			;7866
TOCA_PASO_MAPA:		; (ix+6E) += bit 0 de (ix+6F); carry si no llega a (ix+6D); si no B = pasos enteros, (ix+6E) el resto, (ix+6C)++
	ld a,(ix+06fh)		;7867   ; el resto de la division se guarda: los pasos que sobran se llevan al fotograma siguiente
	and 001h		;786a
	add a,(ix+06eh)		;786c
	ld (ix+06eh),a		;786f
	sub (ix+06dh)		;7872
	ret c			;7875
	ld b,000h		;7876
	ld (ix+06eh),a		;7878
	inc (ix+06ch)		;787b
TOCA_PASO_CUENTA:		; cuenta cuantos (ix+6D) caben
	inc b			;787e   ; y con velocidad de sobra pueden caber varios pasos en un solo fotograma
	sub (ix+06dh)		;787f
	jr nc,TOCA_PASO_CUENTA		;7882
	or a			;7884
	ret			;7885
ENTRA_BOXES:		; (iy+63) = 0xA0 (tiempo de parada), (iy+5C) = 1 (desde p02 0x8C04)
	ld (iy+063h),0a0h		;7886   ; 0xA0 es lo que dura la parada si no se corta
	ld (iy+05ch),001h		;788a
	ret			;788e
EN_BOXES:		; mando del jugador (bit 0 de ix+9): boton -> C (sale); abajo -> (iy+63)-- (a cero: 0x78CB) y reposta (iy+50)++ hasta 0xFF; NC mientras sigue (desde p00 0x4FDA y p02 0x8D66)
	ld hl,0e1cbh		;788f
	bit 0,(ix+009h)		;7892   ; el bit 0 de (ix+9) dice de que mando es este coche
	jr z,BOXES_MANDO		;7896
	ld hl,0e1c8h		;7898
BOXES_MANDO:		; HL = flancos del mando del jugador
	bit 4,(hl)		;789b   ; el boton saca de boxes en cualquier momento
	jr nz,BOXES_SALE		;789d
	bit 1,(hl)		;789f   ; y abajo es lo que reposta: sin tocar nada, la parada no avanza
	call nz,BOXES_REPOSTA		;78a1
	ret c			;78a4
BOXES_REPOSTA:		; la parada: (iy+63)-- y combustible ++
	ld a,(iy+063h)		;78a5   ; mientras quede tiempo de parada se va gastando...
	or a			;78a8
	jr z,BOXES_COMBUSTIBLE		;78a9
	dec a			;78ab
	ld (iy+063h),a		;78ac
	call z,BOXES_NEUMATICOS		;78af   ; ...y al agotarse se cambian los neumaticos
BOXES_COMBUSTIBLE:		; (iy+50)++; lleno -> si (iy+63) < 0x64 o (iy+68) = 0 sigue, si no C
	ld a,(iy+050h)		;78b2
	add a,001h		;78b5   ; el `add a,001h` deja acarreo justo al llegar a 0x100: el deposito lleno
	jr c,BOXES_LLENO		;78b7
	ld (iy+050h),a		;78b9
	or a			;78bc
	ret			;78bd
BOXES_LLENO:		; NC si quedan neumaticos por cambiar
	ld a,(iy+063h)		;78be   ; con el deposito lleno se sale, salvo que aun quede parada por delante o neumaticos por cambiar
	cp 064h		;78c1
	ret nc			;78c3
	ld a,(iy+068h)		;78c4
	or a			;78c7
	ret nz			;78c8
BOXES_SALE:		; C
	scf			;78c9
	ret			;78ca
BOXES_NEUMATICOS:		; di; p02 0x871F y 0x86D0; ei; (iy+68) = 0; borra el indicador de neumaticos: 5 tiles 0 en 0x3818 (dos jugadores) o 0x3AE9 (0x78F5)
	di			;78cb   ; el cambio de neumaticos se hace con las interrupciones apagadas: toca el sonido y la RAM de p02
	call 0871fh		;78cc
	call 086d0h		;78cf
	ei			;78d2
	xor a			;78d3
	ld (iy+068h),a		;78d4   ; los cuatro neumaticos quedan sanos
	ld d,a			;78d7
	ld e,00fh		;78d8
	ld a,(0e1c2h)		;78da
	bit 5,a		;78dd
	jr z,$+56		;78df   ; con dos jugadores salta a 0x7917 con DE = 0x000F (repinta las 4 celdas)
	ld hl,03818h		;78e1   ; y el indicador se borra con cinco tiles a cero
	ld de,078f5h		;78e4
	call 04807h		;78e7
	ld de,078f5h		;78ea
	ld hl,03ae9h		;78ed
	ld c,0ffh		;78f0
	jp 04807h		;78f2

; ----------------------------------------------------------------------
; DATOS tiles_vacios: 5 tiles 0 y 0xFF (para 0x4807)
;   0x78f5..0x78fb  (6 bytes)
DATA_tiles_vacios:
	defb 000h,000h,000h,000h,000h,0ffh	; 78f5

; ======================================================================
; CODIGO 0x78fb..0x798f  (148 bytes)
; ======================================================================


HUD_NEUMATICOS:		; un jugador: (ix+68) bits 0, 3, 2, 1 -> celdas 0x3A5D, 0x3A7D, 0x3A9D, 0x3ABD (tile 0xF2 o 0 parpadeando por bit 4 de E1C3); dos: 0x793F
	ld a,(0e1c2h)		;78fb
	bit 5,a		;78fe   ; con dos jugadores el indicador es mas pequeno y se pinta de otra forma
	jr nz,HUD_NEUMATICOS_2J		;7900
	ld ix,0e2c0h		;7902
	call AVISO_NEUMATICOS		;7906
	ld e,(ix+068h)		;7909
	ld d,0f2h		;790c
	ld a,(0e1c3h)		;790e   ; el bit 4 del contador de fotogramas hace el parpadeo: 16 fotogramas con dibujo y 16 sin el
	and 010h		;7911
	jr z,HUD_NEUMATICOS_CELDAS		;7913
	ld d,000h		;7915
HUD_NEUMATICOS_CELDAS:		; (EA50) = 0; cada bit de E pinta D en su celda (0x7C2E)
	ld bc,00000h		;7917
	ld (0ea50h),bc		;791a
	bit 0,e		;791e   ; los cuatro bits son los cuatro neumaticos, y el orden en pantalla no es el de los bits: 0, 3, 2, 1
	ld hl,03a5dh		;7920   ; la primera celda es la del neumatico delantero izquierdo
	call nz,ESCRIBE_CELDA_HUD		;7923
	bit 3,e		;7926   ; y el orden de los bits no es el de la pantalla: 0, 3, 2, 1
	ld hl,03a7dh		;7928
	call nz,ESCRIBE_CELDA_HUD		;792b
	bit 2,e		;792e
	ld hl,03a9dh		;7930
	call nz,ESCRIBE_CELDA_HUD		;7933
	bit 1,e		;7936
	ld hl,03abdh		;7938
	ret z			;793b
	jp ESCRIBE_CELDA_HUD		;793c
HUD_NEUMATICOS_2J:		; por coche: aviso (0x7976) y 0x7950
	ld ix,0e2c0h		;793f
	call AVISO_NEUMATICOS		;7943
	call HUD_NEUMATICOS_COCHE		;7946
	ld ix,0e380h		;7949
	call AVISO_NEUMATICOS		;794d
HUD_NEUMATICOS_COCHE:		; (ix+6B)++ & 3 -> tabla 0x798F: si su mascara & (ix+68) != 0 pinta su flujo en 0x3818 (jugador 1) o 0x3AE9
	ld a,(ix+06bh)		;7950   ; con dos jugadores se ensena un neumatico por vuelta, rotando
	inc a			;7953
	ld (ix+06bh),a		;7954
	and 003h		;7957   ; cuatro entradas, una por neumatico
	ld de,0798fh		;7959
	call 04a3bh		;795c
	ld a,(de)			;795f
	and (ix+068h)		;7960   ; y solo se pinta si ese esta roto
	ret z			;7963
	inc de			;7964
	ld hl,03818h		;7965
	bit 0,(ix+009h)		;7968   ; cada jugador tiene su hueco en la pantalla
	jr nz,HUD_NEUMATICOS_PINTA		;796c
	ld hl,03ae9h		;796e
HUD_NEUMATICOS_PINTA:		; PINTA_TILES HL
	ld c,0ffh		;7971
	jp 04807h		;7973
AVISO_NEUMATICOS:		; (ix+4A)-- a cero: si no bit 3 de (ix+1) y (ix+68) != 0, sonido 0x1F (p02 0x8674)
	ld a,(ix+04ah)		;7976   ; (ix+4A) es la cuenta atras del aviso, y se pone a 6 cuando revienta un neumatico
	or a			;7979
	ret z			;797a
	dec a			;797b
	ld (ix+04ah),a		;797c
	ret nz			;797f
	bit 3,(ix+001h)		;7980   ; chocando no suena: ya hay bastante ruido
	ret nz			;7984
	ld a,(ix+068h)		;7985
	or a			;7988
	ret z			;7989
	ld a,01fh		;798a
	jp 08674h		;798c

; ----------------------------------------------------------------------
; DATOS tabla_neumaticos: 4 punteros a [mascara, flujo de tiles 0xFF]
;   0x798f..0x7997  (8 bytes)
DATA_tabla_neumaticos:
	defw 07997h	; 798f  -> DATA_flujos_neumaticos
	defw 0799eh	; 7991
	defw 079a5h	; 7993
	defw 079ach	; 7995

; ----------------------------------------------------------------------
; DATOS flujos_neumaticos: 4 flujos: mascara 1/2/4/8 y 5 tiles (0xED.. /
;   0xE8.. / 0xE4..) + 0xFF
;   0x7997..0x79b3  (28 bytes)
DATA_flujos_neumaticos:
	defb 001h,0edh,0eeh,0efh,0f0h,000h,0ffh	; 7997
	defb 002h,0edh,0eeh,0efh,0f1h,000h,0ffh	; 799e
	defb 004h,0e8h,0e9h,0eah,0ebh,0ech,0ffh	; 79a5
	defb 008h,0e4h,0e5h,0e6h,0e7h,000h,0ffh	; 79ac

; ======================================================================
; CODIGO 0x79b3..0x7b76  (451 bytes)
; ======================================================================


HUD_POSICION_VUELTAS:		; dos jugadores: marcador vertical (y = 0x88 - E32C/2) en EAFC y EAF8, vueltas E1FC-(ix-2) en 0x3833/0x3AA4; uno: vueltas (0x7CA6 si cambian), posicion E331 en 0x399B y el marcador del mapa (E2BA) en EAFC
	ld a,(0e1c2h)		;79b3
	and 020h		;79b6   ; el bit 5 de E1C2 vuelve a repartir: con dos jugadores el HUD es otro
	jr z,HUD_POSICION_1J		;79b8
	ld de,08048h		;79ba
	ld a,(0e32ch)		;79bd   ; E32C es lo que lleva recorrido el coche, y de ahi sale la altura del marcador
	ld hl,0eafch		;79c0   ; EAFC y EAF8 son los dos ultimos sprites: los marcadores del mapa
	call MARCADOR_VERTICAL		;79c3
	ld hl,0e2beh		;79c6
	ld de,0e2bch		;79c9
	exx			;79cc
	ld hl,03833h		;79cd
	exx			;79d0
	call HUD_VUELTAS_RESTANTES		;79d1   ; y las vueltas que faltan, en la misma tarea
	ld de,07848h		;79d4
	ld a,(0e3ech)		;79d7
	ld hl,0eaf8h		;79da
	call MARCADOR_VERTICAL		;79dd
	ld hl,0e37eh		;79e0
	ld de,0e37ch		;79e3
	exx			;79e6
	ld hl,03aa4h		;79e7
	exx			;79ea
HUD_VUELTAS_RESTANTES:		; C = E1FC - (ix-2); si cambia respecto a (ix-4): BCD y 2 digitos en HL' (0x7ACB)
	ld a,(0e1fch)		;79eb   ; las vueltas se pintan al reves: lo que se ensena es lo que FALTA
	sub (hl)			;79ee
	ld c,a			;79ef
	ex de,hl			;79f0
	ld a,(hl)			;79f1   ; y solo se repinta si el numero ha cambiado, que escribir en la VRAM cuesta
	ld (hl),c			;79f2
	cp c			;79f3
	ret z			;79f4
	ld l,c			;79f5
	ld h,000h		;79f6
	call 04b28h		;79f8
	exx			;79fb
	ld a,h			;79fc
	exx			;79fd
	ld h,a			;79fe
	exx			;79ff
	ld a,l			;7a00
	exx			;7a01
	ld l,a			;7a02
	jp HUD_DIGITOS_DE		;7a03
HUD_POSICION_1J:		; vueltas -> 0x7CA6 si cambian; E331 (posicion) -> BCD -> 0x399B (fila 12, col 27); sprite del mapa (E2BA) en EAFC
	ld a,(0e1fch)		;7a06   ; con un jugador las vueltas van en otro sitio y con otro tamano
	ld hl,0e2beh		;7a09
	sub (hl)			;7a0c
	ld e,a			;7a0d
	ld hl,0e2bch		;7a0e
	ld a,(hl)			;7a11
	ld (hl),e			;7a12
	cp e			;7a13
	call nz,PINTA_VUELTAS_GRANDE		;7a14
	ld a,(0e331h)		;7a17   ; E331 es el puesto, el mismo que suben los rivales que te adelantan en boxes
	ld l,a			;7a1a
	ld h,000h		;7a1b
	call 04b28h		;7a1d
	ld hl,0399bh		;7a20
	call HUD_DIGITOS_DE		;7a23
	ld de,(0e2bah)		;7a26   ; y el marcador del mapa es un sprite, no un tile
	ld hl,0eafch		;7a2a
	jr ESCRIBE_SPRITE_MAPA		;7a2d
MARCADOR_VERTICAL:		; y = 0x40 - A/2 + E
	srl a		;7a2f   ; la mitad del valor restada de 0x40: el marcador sube segun avanza el coche
	neg		;7a31
	add a,040h		;7a33
	add a,e			;7a35
	ld e,a			;7a36
ESCRIBE_SPRITE_MAPA:		; (HL) = y, x, patron 0xD4, color 0x0F
	ld c,00fh		;7a37   ; el patron 0xD4 con el color 0x0F: el punto del mapa
	ld b,0d4h		;7a39
	jr ESCRIBE_SPRITE_EDBC_B		;7a3b
ESCRIBE_SPRITE_EDBC_B:		; (HL) = E, D, B, C
	ld (hl),e			;7a3d   ; los cuatro bytes del atributo, uno detras de otro
	inc l			;7a3e
	ld (hl),d			;7a3f
	inc l			;7a40
	ld (hl),b			;7a41
	inc l			;7a42
	ld (hl),c			;7a43
	ret			;7a44
HUD_COMBUSTIBLE:		; nivel = (ix+50) >> 5 (0..7): dos jugadores en 0x3836/0x3AA7 con la tabla 0x7BA0; uno en 0x39F5 (fila 15, col 21) con 0x7BA9; E204/E205 = nivel pintado
	ld a,(0e1c2h)		;7a45
	and 020h		;7a48   ; los dos jugadores tienen su indicador de combustible, uno en cada mitad
	jr z,HUD_COMBUSTIBLE_1J		;7a4a
	ld a,001h		;7a4c   ; EA52 = 1: el indicador es del tipo de un tile por nivel
	ld (0ea52h),a		;7a4e
	ld de,03836h		;7a51
	ld (0ea50h),de		;7a54
	ld iy,0e204h		;7a58
	ld a,(0e310h)		;7a5c   ; E310 es el combustible del coche 1 y E3D0 el del 2
	call HUD_COMBUSTIBLE_NIVEL		;7a5f
	ld a,001h		;7a62
	ld (0ea52h),a		;7a64
	ld de,03aa7h		;7a67
	ld (0ea50h),de		;7a6a
	ld iy,0e205h		;7a6e
	ld a,(0e3d0h)		;7a72
HUD_COMBUSTIBLE_NIVEL:		; A >> 5 & 7 y 0x7C08
	ld hl,07ba0h		;7a75
	rrca			;7a78   ; cinco rotaciones y tres bits: el deposito se ensena en ocho escalones
	rrca			;7a79
	rrca			;7a7a
	rrca			;7a7b
	rrca			;7a7c
	and 007h		;7a7d
	jp ACTUALIZA_INDICADOR		;7a7f
HUD_COMBUSTIBLE_1J:		; tabla 0x7BA9, base 0x39F5
	ld iy,0e204h		;7a82
	ld a,001h		;7a86   ; con un jugador el indicador es el mismo tipo pero en otro sitio
	ld (0ea52h),a		;7a88
	ld de,039f5h		;7a8b
	ld (0ea50h),de		;7a8e
	ld hl,07ba9h		;7a92
	ld a,(0e310h)		;7a95
	rrca			;7a98
	rrca			;7a99
	rrca			;7a9a
	rrca			;7a9b
	rrca			;7a9c
	and 007h		;7a9d   ; lo mismo para un jugador, con otra tabla y otro sitio
	jp ACTUALIZA_INDICADOR		;7a9f
HUD_E329:		; (ix+69)+1: dos jugadores como digito en 0x3851/0x3AC2; uno como tile 0xF6+(ix+69) en 0x39BC (fila 13, col 28)
	ld a,(0e1c2h)		;7aa2   ; (ix+69) es la marcha, y se ensena sumandole uno: por dentro va de 0 a 3 y en pantalla de 1 a 4
	and 020h		;7aa5
	jr z,HUD_E329_1J		;7aa7
	ld hl,03851h		;7aa9
	ld de,(0e329h)		;7aac
	call HUD_DIGITO_MAS_1		;7ab0
	ld hl,03ac2h		;7ab3
	ld de,(0e3e9h)		;7ab6
	jr HUD_DIGITO_MAS_1		;7aba
HUD_E329_1J:		; tile 0xF6 + (ix+69) en 0x39BC
	ld hl,039bch		;7abc
	ld de,(0e329h)		;7abf
	inc e			;7ac3
	ld a,0f5h		;7ac4   ; con un jugador la marcha no es un digito: es uno de los cuatro tiles 0xF6 en adelante
	add a,e			;7ac6
	jp 0004dh		;7ac7   ; BIOS WRTVRM - Writes data in VRAM
HUD_DIGITO_MAS_1:		; E++ y 0x7ACB
	inc e			;7aca
HUD_DIGITOS_DE:		; (EA50) = DE (BCD); 1 byte (2 digitos) en HL (0x7BF9)
	ld d,000h		;7acb   ; DE se pasa por EA50 porque el escritor de digitos lee de memoria, no de registros
	ld (0ea50h),de		;7acd
	ld de,0ea50h		;7ad1
	ld b,001h		;7ad4
	jp PINTA_DIGITOS_HUD		;7ad6
HUD_VELOCIDAD:		; (ix+10,11) -> p00 0x4A61 -> x3 -> BCD: dos jugadores en 0x3810/0x3AE1, uno en 0x3977 (fila 11, col 23); 2 bytes desde EA51
	ld a,(0e1c2h)		;7ad9
	and 020h		;7adc   ; la velocidad tambien cambia de sitio con el numero de jugadores
	jr z,HUD_VELOCIDAD_1J		;7ade
	ld de,03810h		;7ae0
	ld hl,(0e2d0h)		;7ae3
	call HUD_VELOCIDAD_PINTA		;7ae6
	ld de,03ae1h		;7ae9
	ld hl,(0e390h)		;7aec
	jr HUD_VELOCIDAD_PINTA		;7aef
HUD_VELOCIDAD_1J:		; (E2D0) en 0x3977
	ld de,03977h		;7af1
	ld hl,(0e2d0h)		;7af4
HUD_VELOCIDAD_PINTA:		; HL = valor: 0x4A61, x3, BCD a EA50, pinta 2 bytes (0x7BF9)
	push de			;7af7
	call 04a61h		;7af8   ; la velocidad interna entre 32 y por tres: eso es lo que sale en el marcador
	ld d,h			;7afb
	ld e,l			;7afc
	add hl,hl			;7afd   ; por dos y una suma mas: eso es por tres
	add hl,de			;7afe
	call 04b28h		;7aff
	ld (0ea50h),de		;7b02
	ld de,0ea51h		;7b06
	pop hl			;7b09
	ld b,002h		;7b0a
	jp PINTA_DIGITOS_HUD		;7b0c
HUD_INDICADOR_E19A:		; dos jugadores: E19A y E19F como nivel 0..7 (0x7B7C) con la tabla 0x7B8E en 0x3856/0x3AC7; uno: E19A/8 con la tabla 0x7BB2 (3 bytes por nivel) en 0x3993 (fila 12, col 19) y los tiles 0xD4-0xD6 de 0x7B76 en 0x3933 parpadeando (bit 4 de E1C3)
	ld a,(0e1c2h)		;7b0f   ; este indicador se repinta cuatro veces de cada ocho: es el que mas se mueve
	and 020h		;7b12
	jr z,HUD_INDICADOR_1J		;7b14
	ld a,001h		;7b16
	ld (0ea52h),a		;7b18
	ld de,03856h		;7b1b
	ld (0ea50h),de		;7b1e
	ld hl,07b8eh		;7b22
	ld iy,0e202h		;7b25
	ld a,(0e19ah)		;7b29   ; E19A y E19F son las revoluciones filtradas de cada coche
	call NIVEL_0_7		;7b2c
	ld a,001h		;7b2f
	ld (0ea52h),a		;7b31
	ld de,03ac7h		;7b34
	ld (0ea50h),de		;7b37
	ld hl,07b8eh		;7b3b
	ld iy,0e203h		;7b3e
	ld a,(0e19fh)		;7b42
	jr $+55		;7b45
HUD_INDICADOR_1J:		; el indicador de un jugador
	ld iy,0e202h		;7b47
	xor a			;7b4b
	ld (0ea52h),a		;7b4c
	ld de,03993h		;7b4f
	ld (0ea50h),de		;7b52
	ld a,(0e19ah)		;7b56
	ld l,a			;7b59
	ld h,000h		;7b5a
	add hl,hl			;7b5c   ; por cuatro y luego por ocho: el valor por 32, para que el nivel salga en el byte alto
	add hl,hl			;7b5d
	call HL_POR_8		;7b5e
	ld a,h			;7b61
	ld hl,07bb2h		;7b62
	call ACTUALIZA_INDICADOR		;7b65
	ld de,07b76h		;7b68
	ld a,(0e1c3h)		;7b6b
	bit 4,a		;7b6e   ; el bit 4 del contador de fotogramas hace parpadear los tres tiles del aviso
	jp z,04830h		;7b70
	jp 04811h		;7b73

; ----------------------------------------------------------------------
; DATOS flujo_d4d6: flujo de PINTA_TILES: en 0x3933 los tiles 0xD4 0xD5 0xD6
;   (parpadean)
;   0x7b76..0x7b7c  (6 bytes)
DATA_flujo_d4d6:
	defb 033h,039h,0d4h,0d5h,0d6h,0ffh	; 7b76

; ======================================================================
; CODIGO 0x7b7c..0x7b8d  (17 bytes)
; ======================================================================


NIVEL_0_7:		; A = (A >> 3) & 0x1F; si pasa de 7, 7
	rrca			;7b7c   ; tres rotaciones y cinco bits, y lo que pase de 7 se queda en 7: el indicador solo tiene ocho escalones
	rrca			;7b7d
	rrca			;7b7e
	and 01fh		;7b7f
	ld d,a			;7b81
	and 007h		;7b82
	cp d			;7b84
	jp z,ACTUALIZA_INDICADOR		;7b85
	ld a,007h		;7b88
	jp ACTUALIZA_INDICADOR		;7b8a

; ----------------------------------------------------------------------
; DATOS tablas_indicadores: 4 tablas de 8 tiles por nivel, cada una precedida
;   de su tile de borrado (0): 0x7B8E (E19A dos jugadores: FC.. FE), 0x7B97
;   (FA.. FF, sin uso visto), 0x7BA0 (combustible dos jugadores: FB), 0x7BA9
;   (combustible un jugador: F4)
;   0x7b8d..0x7bb2  (37 bytes)
DATA_tablas_indicadores:
	defb 000h,0fch,0fch,0fch,0fch,0fch,0fch,0feh,0feh	; 7b8d  .........
	defb 000h,0fah,0fah,0fah,0fah,0ffh,0ffh,0ffh,0ffh	; 7b96  .........
	defb 000h,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh	; 7b9f  .........
	defb 000h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 7ba8  .........
	defb 000h	; 7bb1

; ----------------------------------------------------------------------
; DATOS tabla_indicador_1j: 17 entradas (tile, desplazamiento de VRAM) por
;   nivel del indicador E19A de un jugador (base 0x3993)
;   0x7bb2..0x7be5  (51 bytes)
DATA_tabla_indicador_1j:
	defb 0f8h,000h,000h	; 7bb2
	defb 0e4h,000h,000h	; 7bb5
	defb 0e0h,0e1h,0ffh	; 7bb8
	defb 0dch,0c2h,0ffh	; 7bbb
	defb 0ddh,0c3h,0ffh	; 7bbe
	defb 0ddh,0c4h,0ffh	; 7bc1
	defb 0ddh,0c5h,0ffh	; 7bc4
	defb 0ddh,0c6h,0ffh	; 7bc7
	defb 0ddh,0c7h,0ffh	; 7bca
	defb 0deh,0c8h,0ffh	; 7bcd
	defb 0deh,0c9h,0ffh	; 7bd0
	defb 000h,0e0h,0ffh	; 7bd3
	defb 000h,0e0h,0ffh	; 7bd6
	defb 000h,0e0h,0ffh	; 7bd9
	defb 000h,0e0h,0ffh	; 7bdc
	defb 000h,0e0h,0ffh	; 7bdf
	defb 000h,0e0h,0ffh	; 7be2

; ======================================================================
; CODIGO 0x7be5..0x7c49  (100 bytes)
; ======================================================================


HL_POR_8:		; HL *= 8
	add hl,hl			;7be5   ; por ocho, tres veces doblado
	add hl,hl			;7be6
	add hl,hl			;7be7
	ret			;7be8
L_7BE9:
	ld h,a			;7be9
	ld l,000h		;7bea
	call 04a6dh		;7bec   ; este trozo usa 0x4A6D, que es entrar por la mitad de la escalera de corrimientos de p00
	ld d,h			;7bef
	ld e,l			;7bf0
	add hl,hl			;7bf1
	add hl,hl			;7bf2
	add hl,de			;7bf3
	ld a,h			;7bf4
	ret nc			;7bf5
	ld a,0ffh		;7bf6   ; y si la cuenta se sale, se planta en 0xFF
	ret			;7bf8
PINTA_DIGITOS_HUD:		; dos jugadores -> p00 0x4A03 (tiles 0xD4+); uno -> D' = 0xF5 y p00 0x4A0D: B bytes BCD de (DE) en VRAM HL
	ld a,(0e1c2h)		;7bf9   ; con dos jugadores los digitos salen de los tiles 0xD4 y con uno de los 0xF5: no se pisan con los rotulos
	bit 5,a		;7bfc
	jp nz,04a03h		;7bfe
	exx			;7c01
	ld d,0f5h		;7c02
	exx			;7c04
	jp 04a0dh		;7c05
ACTUALIZA_INDICADOR:		; A = nivel nuevo, (IY) = nivel pintado, HL = tabla, (EA50) = base de VRAM, EA52 = tipo (0/2: 3 bytes por nivel, 1: un tile por nivel); un paso por llamada hacia el nivel nuevo
	cp (iy+000h)		;7c08   ; el indicador no salta al valor nuevo: se le acerca UN escalon por llamada, y de ahi que la aguja se mueva suave
	ret z			;7c0b
	jr nc,INDICADOR_SUBE		;7c0c
	ld a,(iy+000h)		;7c0e
	dec (iy+000h)		;7c11   ; bajando se borra la celda que se deja...
	jr INDICADOR_BAJA		;7c14
INDICADOR_SUBE:		; (IY)++ y pinta el tile del nivel
	ld a,(iy+000h)		;7c16   ; ...y subiendo se pinta la que se ocupa
	inc a			;7c19
	ld (iy+000h),a		;7c1a
	jr INDICADOR_PINTA_NIVEL		;7c1d
INDICADOR_PINTA_NIVEL:		; tile y celda (0x7C3E) y lo escribe (0x7C2E)
	call TILE_Y_CELDA		;7c1f
	jr ESCRIBE_CELDA_HUD		;7c22
INDICADOR_BAJA:		; celda del nivel nuevo con el tile de borrado (byte anterior a la tabla)
	push hl			;7c24   ; el tile de borrado es el byte que va JUSTO ANTES de la tabla de cada indicador
	call TILE_Y_CELDA		;7c25
	exx			;7c28
	pop hl			;7c29
	dec hl			;7c2a
	ld a,(hl)			;7c2b
	exx			;7c2c
	ld d,a			;7c2d
ESCRIBE_CELDA_HUD:		; VRAM (EA50) + HL = D
	ld bc,(0ea50h)		;7c2e   ; la celda se escribe directa al puerto del VDP, sin pasar por el BIOS
	add hl,bc			;7c32
	call 04673h		;7c33
	ld a,d			;7c36
	exx			;7c37
	out (c),a		;7c38
	exx			;7c3a
	ret			;7c3b
CUELGA:		; jr $: EA52 >= 3 no esta previsto
	jr CUELGA		;7c3c   ; un `jr $` de verdad: si EA52 trajera 3 o mas la maquina se queda aqui colgada, y por eso 0x7C42 lo comprueba antes
TILE_Y_CELDA:		; por EA52 (p00 0x4ACB con la tabla de 3 palabras 0x7C49): 0/2 -> 0x7C56 (tile, desplazamiento), 1 -> 0x7C4F (tile = tabla[nivel], desplazamiento = nivel)
	ex af,af'			;7c3e
	ld a,(0ea52h)		;7c3f   ; EA52 dice de que tipo es la tabla del indicador
	cp 003h		;7c42
	jr nc,CUELGA		;7c44
	call 04acbh		;7c46   ; p00 0x4ACB: salta a la palabra EA52 de las tres que siguen (0x7C56, 0x7C4F, 0x7C56) con A = nivel

; ----------------------------------------------------------------------
; DATOS tabla_7C46: 3 palabras del despachador de 0x7C46 (`call 0x4ACB`, la
;   variante con exx/ex af,af'), indice (EA52): 0x7C56, 0x7C4F, 0x7C56
;   0x7c49..0x7c4f  (6 bytes)
DATA_tabla_7C46:
	defw 07c56h	; 7c49  -> CELDA_3_BYTES
	defw 07c4fh	; 7c4b  -> CELDA_1_BYTE
	defw 07c56h	; 7c4d  -> CELDA_3_BYTES

; ======================================================================
; CODIGO 0x7c4f..0x7dd3  (388 bytes)
; ======================================================================


CELDA_1_BYTE:		; D = tabla[nivel], HL = nivel
	ld e,a			;7c4f   ; el tipo 1 es el sencillo: un tile por nivel y la celda es el propio nivel
	ld d,000h		;7c50
	add hl,de			;7c52
	ld h,(hl)			;7c53
	ex de,hl			;7c54
	ret			;7c55
CELDA_3_BYTES:		; D = tabla[3*nivel], HL = la palabra siguiente
	ld b,a			;7c56   ; y el tipo 0 lleva tres bytes por nivel: el tile y la celda entera
	add a,a			;7c57
	add a,b			;7c58
	ld e,a			;7c59
	ld d,000h		;7c5a   ; por tres, que las entradas de este tipo son (tile, celda baja, celda alta)
	add hl,de			;7c5c
	ld d,(hl)			;7c5d
	inc hl			;7c5e
	ld a,(hl)			;7c5f
	inc hl			;7c60
	ld h,(hl)			;7c61
	ld l,a			;7c62
	ret			;7c63
ESCALA_TILE_X2:		; los 8 bytes de (DE) a 16x16: cada bit doblado, cada fila dos veces, en EA60.. (4 tiles: izquierda arriba, derecha arriba, izquierda abajo, derecha abajo)
	ld hl,0ea60h		;7c64   ; duplicar un tile a 16x16 se hace bit a bit: cada bit del original se escribe dos veces y cada fila tambien
	ld b,008h		;7c67
ESCALA_FILA:		; una fila de origen por vuelta
	push bc			;7c69
	ld a,(de)			;7c6a   ; un byte de origen por vuelta: cada uno da dos filas de destino
	inc de			;7c6b
	push de			;7c6c
	ld de,00000h		;7c6d
	ld b,008h		;7c70
ESCALA_BIT:		; un bit por vuelta
	srl d		;7c72   ; los dos `srl d / rr e` son el hueco que se abre para meter el bit doblado
	rr e		;7c74
	srl d		;7c76
	rr e		;7c78
	rra			;7c7a
	ld c,000h		;7c7b
	rr c		;7c7d
	sra c		;7c7f
	push af			;7c81
	ld a,d			;7c82
	or c			;7c83
	ld d,a			;7c84
	pop af			;7c85
	djnz ESCALA_BIT		;7c86
	ld (hl),d			;7c88   ; cada fila del original se escribe dos veces: al doblar de alto tambien
	inc hl			;7c89
	ld (hl),d			;7c8a
	inc hl			;7c8b
	push hl			;7c8c
	inc hl			;7c8d   ; seis casillas mas alla esta el tile de la derecha, que lleva la otra mitad de la fila
	inc hl			;7c8e
	inc hl			;7c8f
	inc hl			;7c90
	inc hl			;7c91
	inc hl			;7c92
	ld (hl),e			;7c93
	inc hl			;7c94
	ld (hl),e			;7c95
	pop hl			;7c96
	pop de			;7c97
	pop bc			;7c98
	ld a,b			;7c99   ; a mitad de camino -la fila 4- se salta a los dos tiles de abajo
	cp 005h		;7c9a
	jr nz,ESCALA_SIGUIENTE		;7c9c
	ld a,008h		;7c9e
	call 040d0h		;7ca0
ESCALA_SIGUIENTE:		; a la mitad (fila 4) salta a los tiles de abajo
	djnz ESCALA_FILA		;7ca3
	ret			;7ca5
PINTA_VUELTAS_GRANDE:		; E = vueltas restantes: lee el patron del tile 0xF5+E del tercio 1 (VRAM 0x2FA8+E*8) en EA58, lo dobla (0x7C64) y lo escribe en los tiles 0xFC..0xFF del tercio 0 (VRAM 0x27E0)
	ld a,e			;7ca6   ; las vueltas grandes no son un tile normal: se lee el patron del digito pequeno, se dobla a 16x16 y se escribe encima de cuatro tiles
	ld hl,02fa8h		;7ca7
	add a,a			;7caa
	add a,a			;7cab
	add a,a			;7cac
	call 040d0h		;7cad
	ld de,0ea58h		;7cb0
	ld b,008h		;7cb3
LEE_PATRON_BUCLE:		; 8 bytes por RDVRM
	call 0004ah		;7cb5   ; BIOS RDVRM - Reads the content of VRAM | los ocho bytes del patron se leen de la VRAM uno a uno
	ld (de),a			;7cb8
	inc hl			;7cb9
	inc de			;7cba
	djnz LEE_PATRON_BUCLE		;7cbb
	ld de,0ea58h		;7cbd
	call ESCALA_TILE_X2		;7cc0
	ld hl,027e0h		;7cc3
	ld de,0ea60h		;7cc6
	ld bc,00020h		;7cc9   ; 0x20 bytes son los cuatro tiles doblados
	call 047cfh		;7ccc
	ret			;7ccf
ENTRA_ESCENA_META:		; E947 = 0; limpia (0x465B); p02 0x9263; tiles p04 0x6DEA; escena p00 0x578A; bandas (0x7DAB); imagen p08 0x9386 (8 columnas) en ECD5 (0x7D6C); p00 0x5BA2 (E250 = 27); (E27E) = 0xEEE8
	ld hl,00000h		;7cd0   ; la escena de meta: la bandera a cuadros bajando por la pantalla
	ld (0e947h),hl		;7cd3
	call 0465bh		;7cd6
	call 09263h		;7cd9
	ld hl,06deah		;7cdc
	call 04ccdh		;7cdf
	call 0578ah		;7ce2
	call PINTA_BANDAS_CUADROS		;7ce5   ; las dos bandas de cuadros se pintan una vez, y luego solo se desplazan
	ld de,09386h		;7ce8
	ld hl,0ecd5h		;7ceb
	ld a,008h		;7cee
	call RLE_DESDE_P08		;7cf0
	call 05ba2h		;7cf3
	ld hl,0eee8h		;7cf6   ; E27E es por donde va el desplazamiento dentro del buffer
	ld (0e27eh),hl		;7cf9
	ret			;7cfc
ESCENA_META:		; E251 = 0: desplaza (0x7D48, 0x7D7A), objetos desde (E27E) (p03 0xB4AE), los pinta (0x70D9), vuelca EC00 (p00 0x44C1), los borra (0x7134); en (E27E) = 0xEF28: E251++, E25D = 0x14; E251 != 0: vuelca y E25D-- (a 1: p02 0x869A; a 0: E250 = 0x0E)
	ld a,(0e251h)		;7cfd
	and a			;7d00
	jr nz,ESCENA_META_FIN		;7d01
	call ESCENA_META_PUNTERO		;7d03   ; cada fotograma la banda baja una fila
	call DESPLAZA_ESCENA		;7d06   ; primero se mueve la banda y luego se pintan los objetos encima
	ld hl,(0e27eh)		;7d09
	ld ix,0e2c0h		;7d0c
	ld de,0e928h		;7d10
	call 0b4aeh		;7d13
	call PINTA_OBJETOS_TILES		;7d16
	call 044c1h		;7d19   ; y se vuelca el buffer entero
	call BORRA_OBJETOS_TILES		;7d1c
	ld hl,(0e27eh)		;7d1f
	ld de,0ef28h		;7d22   ; en 0xEF28 se acaba el paseo y empieza la cuenta atras
	call 04a4fh		;7d25
	ret nz			;7d28
	ld hl,0e251h		;7d29
	inc (hl)			;7d2c
	ld a,014h		;7d2d
	ld (0e25dh),a		;7d2f
	ret			;7d32
ESCENA_META_FIN:		; vuelca y cuenta E25D
	call 044c1h		;7d33
	ld hl,0e25dh		;7d36
	dec (hl)			;7d39   ; el `push af` guarda el Z del `dec` para despues del aviso
	push af			;7d3a
	ld a,(hl)			;7d3b
	cp 001h		;7d3c   ; al llegar a 1 se avisa a p02, y al llegar a 0 se cambia de estado
	call z,0869ah		;7d3e
	pop af			;7d41
	ret nz			;7d42
	ld a,00eh		;7d43
	jp PON_ESTADO		;7d45
ESCENA_META_PUNTERO:		; (E27E) -= 0x40 con vuelta a 0xEFE8 por debajo de EC00; en 0xED68 descomprime p08 0x93C6 (7 columnas) en ECD6
	ld hl,(0e27eh)		;7d48
	ld de,0ffc0h		;7d4b   ; 0xFFC0 es -0x40, o sea dos filas de buffer
	add hl,de			;7d4e
	ld de,0ec00h		;7d4f
	call 04a4fh		;7d52
	jr nc,ESCENA_META_GUARDA		;7d55
	ld hl,0efe8h		;7d57   ; por debajo de EC00 se vuelve por arriba: el buffer es circular
ESCENA_META_GUARDA:		; (E27E) = HL
	ld (0e27eh),hl		;7d5a
	ld de,0ed68h		;7d5d
	call 04a4fh		;7d60   ; y al pasar por 0xED68 se descomprime otro trozo de dibujo
	ret nz			;7d63
	ld de,093c6h		;7d64
	ld hl,0ecd6h		;7d67
	ld a,007h		;7d6a
RLE_DESDE_P08:		; paginas 8/9; descomprime DE (A columnas) en HL (0x637A); 1/2/3
	push af			;7d6c
	ld a,008h		;7d6d
	call 04447h		;7d6f   ; el dibujo esta en la pagina 8
	pop af			;7d72
	call RLE_A_BUFFER		;7d73
	call 043feh		;7d76
	ret			;7d79
DESPLAZA_ESCENA:		; la banda de 18 columnas del buffer EC00 baja una fila: EEE0 -> EFE0, y 23 filas hacia abajo, EFE0 -> EC00
	ld hl,0eee0h		;7d7a   ; la banda que se desplaza es de 18 columnas: la mitad derecha de la pantalla
	ld de,0efe0h		;7d7d
	call COPIA_18		;7d80
	ld hl,0eec0h		;7d83
	ld de,0eee0h		;7d86
	exx			;7d89
	ld b,017h		;7d8a   ; veintitres filas de abajo arriba, para no pisarse
DESPLAZA_ESCENA_FILA:		; una fila por vuelta
	exx			;7d8c
	call COPIA_18		;7d8d   ; una fila copiada, y luego los dos punteros suben
	ld bc,0ffe0h		;7d90   ; 0xFFE0 es -0x20: una fila hacia arriba
	add hl,bc			;7d93
	ex de,hl			;7d94
	add hl,bc			;7d95
	ex de,hl			;7d96
	exx			;7d97
	djnz DESPLAZA_ESCENA_FILA		;7d98
	exx			;7d9a
	ld hl,0efe0h		;7d9b
	ld de,0ec00h		;7d9e
COPIA_18:		; ldir de 0x12 bytes (HL) -> (DE) sin mover HL ni DE
	push hl			;7da1
	push de			;7da2
	ld bc,00012h		;7da3   ; 0x12 bytes son las 18 columnas de la banda
	ldir		;7da6
	pop de			;7da8
	pop hl			;7da9
	ret			;7daa
PINTA_BANDAS_CUADROS:		; en EC12 y EC32 (filas 0 y 1, col 18) 12 filas alternas de 14 tiles 0x8B/0x8C alternados
	ld hl,0ec12h		;7dab
	ld a,08bh		;7dae   ; los dos tiles del cuadro, 0x8B y 0x8C, alternando
	call PINTA_BANDA		;7db0
	ld hl,0ec32h		;7db3
	ld a,08ch		;7db6
PINTA_BANDA:		; C = 12 filas (cada dos)
	ld c,00ch		;7db8
PINTA_BANDA_FILA:		; 14 tiles
	ld b,00eh		;7dba
PINTA_BANDA_TILE:		; tile y xor 7 (0x8B <-> 0x8C)
	ld (hl),a			;7dbc
	inc hl			;7dbd
	xor 007h		;7dbe   ; el `xor 7` cambia 0x8B por 0x8C y al reves: es lo que hace el damero
	djnz PINTA_BANDA_TILE		;7dc0
	ld de,00032h		;7dc2   ; 0x32 casillas hasta la fila siguiente, que se salta una: las bandas van cada dos filas
	add hl,de			;7dc5
	dec c			;7dc6
	jr nz,PINTA_BANDA_FILA		;7dc7
	ret			;7dc9
FASES_SALIDA:		; si E221 < 10 despacha por E221 (tabla 0x7DD3)
	ld a,(0e221h)		;7dca   ; la salida tiene diez fases, con E221 de indice
	cp 00ah		;7dcd
	ret nc			;7dcf
	call 040dah		;7dd0

; ----------------------------------------------------------------------
; DATOS tabla_7DD0: 10 palabras del despachador de 0x7DD0 (`call 0x40DA`),
;   indice (E221): las fases de la salida
;   0x7dd3..0x7de7  (20 bytes)
DATA_tabla_7DD0:
	defw 07de7h	; 7dd3  -> SALIDA_0
	defw 07e28h	; 7dd5  -> SALIDA_1
	defw 07e4ch	; 7dd7  -> SALIDA_2
	defw 07e50h	; 7dd9  -> SALIDA_3
	defw 07e54h	; 7ddb  -> SALIDA_4
	defw 07e89h	; 7ddd  -> SALIDA_5
	defw 07ea2h	; 7ddf  -> SALIDA_6
	defw 07ecbh	; 7de1  -> SALIDA_7
	defw 07ed9h	; 7de3  -> SALIDA_TODOS_EN_6
	defw 07ef2h	; 7de5  -> SALIDA_9

; ======================================================================
; CODIGO 0x7de7..0x7f18  (305 bytes)
; ======================================================================


SALIDA_0:		; E220..E22E = 0; F0F7 = 0x132; sonido 0x81; E326 = E3E6 = 0; E222 = 10 y E221++; panel por filas (p00 0x4C43) y pista (0x4BE3); espera p02 0x865C; sonido 0x80; p02 0x8704; E1D7 = 1
	ld hl,0e220h		;7de7   ; la salida empieza borrando quince bytes de estado
	ld bc,0000fh		;7dea
	call 04b87h		;7ded
	ld hl,00132h		;7df0
	ld (0f0f7h),hl		;7df3
	ld a,081h		;7df6   ; el sonido 0x81 abre la secuencia
	call 04174h		;7df8
	xor a			;7dfb
	ld (0e326h),a		;7dfc
	ld (0e3e6h),a		;7dff
	ld a,00ah		;7e02
	call FASE_SIGUIENTE		;7e04
	call 04c43h		;7e07   ; el panel se pinta por filas -de arriba abajo- y luego la pista
	call 04be3h		;7e0a
SALIDA_0_ESPERA:		; p02 0x865C hasta Z
	call 0865ch		;7e0d   ; aqui se espera de verdad, en un bucle: la salida no sigue hasta que p02 diga
	jr nz,SALIDA_0_ESPERA		;7e10
	ld a,080h		;7e12
	call 04174h		;7e14
	call 08704h		;7e17
	ld a,001h		;7e1a
	ld (0e1d7h),a		;7e1c   ; E1D7 = 1 enciende la primera luz del semaforo
	ret			;7e1f
FASE_SIGUIENTE:		; E222 = A y E221++
	ld (0e222h),a		;7e20
	ld hl,0e221h		;7e23
	inc (hl)			;7e26
	ret			;7e27
SALIDA_1:		; parpadeo de los coches (bit 7 de E2F1/E3B1 cada dos fotogramas, un jugador); 0x7E80; E222-- a cero -> sonido 0x29 y fase siguiente (0x7E6F)
	ld a,(0e1c2h)		;7e28
	and 020h		;7e2b
	ld d,a			;7e2d
	ld a,(0e1c3h)		;7e2e   ; el bit 1 del contador de fotogramas: los coches parpadean cada dos
	and 002h		;7e31   ; y el bit 1 hace el parpadeo de los coches en la parrilla
	or d			;7e33
	jr nz,SALIDA_1_CUENTA		;7e34
	ld hl,0e2f1h		;7e36
	set 7,(hl)		;7e39
	ld hl,0e3b1h		;7e3b
	set 7,(hl)		;7e3e
SALIDA_1_CUENTA:		; E198 = E197 = 0xFF y cuenta E222
	call E197_E198_FF		;7e40   ; los dos volumenes de motor a tope mientras dura la cuenta
	ld hl,0e222h		;7e43
	dec (hl)			;7e46
	ret nz			;7e47
	ld e,029h		;7e48   ; las tres primeras luces suenan igual (0x29) y la cuarta distinto (0x2A)
	jr SALIDA_LUZ_SIGUIENTE		;7e4a
SALIDA_2:		; sonido 0x29 al acabar
	ld e,029h		;7e4c
	jr SALIDA_LUZ		;7e4e
SALIDA_3:		; sonido 0x29 al acabar
	ld e,029h		;7e50
	jr SALIDA_LUZ		;7e52
SALIDA_4:		; sonido 0x2A al acabar
	ld e,02ah		;7e54
SALIDA_LUZ:		; 0x7E80; parpadeo; E222-- a cero -> 0x7E6F
	call E197_E198_FF		;7e56   ; la misma faena que la fase 1, pero sin mirar si hay uno o dos jugadores
	ld a,(0e1c3h)		;7e59
	and 002h		;7e5c
	jr nz,SALIDA_LUZ_CUENTA		;7e5e
	ld hl,0e2f1h		;7e60
	set 7,(hl)		;7e63
	ld hl,0e3b1h		;7e65
	set 7,(hl)		;7e68
SALIDA_LUZ_CUENTA:		; E222--
	ld hl,0e222h		;7e6a
	dec (hl)			;7e6d
	ret nz			;7e6e
SALIDA_LUZ_SIGUIENTE:		; E222 = 0x14, E221++, 0x7ED9, sonido E y E1D7++ (una luz mas)
	ld a,014h		;7e6f   ; cada luz dura 0x14 fotogramas
	call FASE_SIGUIENTE		;7e71
	call SALIDA_TODOS_EN_6		;7e74
	ld a,e			;7e77
	call 04174h		;7e78
	ld hl,0e1d7h		;7e7b   ; y E1D7 sube: una luz mas encendida
	inc (hl)			;7e7e
	ret			;7e7f
E197_E198_FF:		; E198 = E197 = 0xFF
	ld a,0ffh		;7e80   ; 0xFF en los dos volumenes: el motor a fondo
	ld (0e198h),a		;7e82
	ld (0e197h),a		;7e85
	ret			;7e88
SALIDA_5:		; E222-- a cero: si E240 = 0, E315 = E3D5 = 1 (0x7EC2); E1D7 = 0 (luces fuera); p00 0x595B; fase siguiente; 0x7ED9
	ld hl,0e222h		;7e89
	dec (hl)			;7e8c
	ret nz			;7e8d
	ld a,(0e240h)		;7e8e   ; con E240 encendido no se da la salida: es la tercera opcion de jugadores
	and a			;7e91
	call z,SALIDA_GO		;7e92
	xor a			;7e95
	ld (0e1d7h),a		;7e96   ; E1D7 a cero apaga el semaforo entero
	call 0595bh		;7e99
	call FASE_SIGUIENTE		;7e9c
	jp SALIDA_TODOS_EN_6		;7e9f
SALIDA_6:		; E219 = 0; p00 0x5CA1 (cronometro E210 a cero); E326 = E2A2 = E3E6 = E362 = 1; E222 = 10 y fase siguiente; 0x7F3C; 0x7ED9
	xor a			;7ea2
	ld (0e219h),a		;7ea3
	call 05ca1h		;7ea6   ; el cronometro se pone a cero justo al arrancar
	ld a,001h		;7ea9
	ld (0e326h),a		;7eab
	ld (0e2a2h),a		;7eae
	ld (0e3e6h),a		;7eb1
	ld (0e362h),a		;7eb4
	ld a,00ah		;7eb7   ; diez fotogramas mas y a la fase siguiente
	call FASE_SIGUIENTE		;7eb9
	call INICIA_RITMO		;7ebc
	jp SALIDA_TODOS_EN_6		;7ebf
SALIDA_GO:		; E315 = E3D5 = 1 ((ix+55) de los dos coches)
	ld a,001h		;7ec2   ; (ix+55) = 1 en los dos coches: es la orden de salir
	ld (0e315h),a		;7ec4
	ld (0e3d5h),a		;7ec7
	ret			;7eca
SALIDA_7:		; 0x7ED9; E222-- a cero: p02 0x87E2 y fase siguiente
	call SALIDA_TODOS_EN_6		;7ecb
	ld hl,0e222h		;7ece   ; 0x14 fotogramas para la ultima fase
	dec (hl)			;7ed1
	ret nz			;7ed2
	call 087e2h		;7ed3
	jp FASE_SIGUIENTE		;7ed6
SALIDA_TODOS_EN_6:		; si (ix+5D) = 6 en el coche 1 (E31D) y, con dos jugadores, en el 2 (E3DD): E221 = 9
	ld hl,0e1c2h		;7ed9   ; en cualquier fase, si los coches ya estan en el estado 6 -parados- se salta a la 9
	bit 5,(hl)		;7edc
	jr z,SALIDA_COCHE_1_EN_6		;7ede
	ld a,(0e3ddh)		;7ee0
	cp 006h		;7ee3
	ret nz			;7ee5
SALIDA_COCHE_1_EN_6:		; E31D = 6 -> E221 = 9
	ld a,(0e31dh)		;7ee6
	cp 006h		;7ee9   ; el estado 6 del coche es "parado": si los dos lo estan, la salida ya no pinta nada
	ret nz			;7eeb
	ld a,009h		;7eec
	ld (0e221h),a		;7eee
	ret			;7ef1
SALIDA_9:		; E221 = 0xFF y p02 0x869A
	ld a,0ffh		;7ef2   ; E221 = 0xFF es "la salida se acabo"; p00 0x5AC0 lo mira para cambiar de estado
	ld (0e221h),a		;7ef4
	jp 0869ah		;7ef7
SPRITES_SEMAFORO_MONTA:		; copia a (HL) los 16 bytes de 0x7F18 (4 sprites) y los 4 de 0x7F24 + E1D7*4 (la luz encendida); HL avanza 20
	ex de,hl			;7efa
	ld hl,07f18h		;7efb   ; los cuatro sprites del semaforo son fijos...
	ld bc,00010h		;7efe
	ldir		;7f01
	ld hl,07f24h		;7f03
	ld a,(0e1d7h)		;7f06
	add a,a			;7f09   ; ...y detras va el de la luz encendida, que cambia con E1D7
	add a,a			;7f0a
	call 040d0h		;7f0b
	ldi		;7f0e
	ldi		;7f10
	ldi		;7f12
	ldi		;7f14
	ex de,hl			;7f16
	ret			;7f17

; ----------------------------------------------------------------------
; DATOS sprites_semaforo: 4 atributos (y, x, patron, color):
;   (0x10,0x60,0xC4,4), (0x10,0x60,0xC8,5), (0x20,0x60,0xCC,4),
;   (0x20,0x60,0xD0,5)
;   0x7f18..0x7f28  (16 bytes)
DATA_sprites_semaforo:
	defb 010h,060h,0c4h,004h	; 7f18
	defb 010h,060h,0c8h,005h	; 7f1c
	defb 020h,060h,0cch,004h	; 7f20
	defb 020h,060h,0d0h,005h	; 7f24

; ----------------------------------------------------------------------
; DATOS sprites_luz: 5 atributos por E1D7 = 0..4 (la tabla empieza en 0x7F24
;   para E1D7 = 1): (0xE0,0x60,0xC0,0) oculto, (0x0E,0x60,0xC0,8),
;   (0x15,0x60,0xC0,0x0A), (0x1C,0x60,0xC0,0x0B), (0x23,0x60,0xC0,0x12)
;   0x7f28..0x7f3c  (20 bytes)
DATA_sprites_luz:
	defb 0e0h,060h,0c0h,000h	; 7f28
	defb 00eh,060h,0c0h,008h	; 7f2c
	defb 015h,060h,0c0h,00ah	; 7f30
	defb 01ch,060h,0c0h,00bh	; 7f34
	defb 023h,060h,0c0h,012h	; 7f38

; ======================================================================
; CODIGO 0x7f3c..0x7fff  (195 bytes)
; ======================================================================


INICIA_RITMO:		; E33E = E3FE = 0x40 ((ix+7E) de los dos coches); E20F = E208 = 0 (desde p00 0x59F3)
	ld a,040h		;7f3c   ; E33E y E3FE arrancan a 0x40: el ritmo de cada coche
	ld (0e33eh),a		;7f3e
	ld (0e3feh),a		;7f41
	xor a			;7f44
	ld (0e20fh),a		;7f45
	ld (0e208h),a		;7f48
	ret			;7f4b
RITMO_CADA_256:		; cada 256 fotogramas: si E331 (posicion) < 3 y E208 = 0, E208 = 4
	ld a,(0e1c3h)		;7f4c   ; una vez cada 256 fotogramas
	or a			;7f4f
	ret nz			;7f50
	ld a,(0e331h)		;7f51   ; solo si vas entre los tres primeros: al que va detras no hace falta apretarle
	cp 003h		;7f54
	ret nc			;7f56
	ld a,(0e208h)		;7f57
	or a			;7f5a
	ret nz			;7f5b
	ld a,004h		;7f5c   ; E208 = 4 es la orden de apretar el ritmo
	ld (0e208h),a		;7f5e
	ret			;7f61

; ----------------------------------------------------------------------
; Entrada de la carrera (E250 = 11, desde p00 0x5ABA): p02 0x800B y,
; por coche, (iy+7E) (1..99) sube o baja segun la posicion del coche
; (iy+40..42) comparada con p03 0xBDD5[E25B] (byte y palabra) y E20F,
; con multiplicaciones de p02 0x9B4F. Hipotesis: el ritmo de los rivales.
; ----------------------------------------------------------------------
RITMO_CARRERA:		; p02 0x800B; un jugador: 0x7F4C; E208 = 1 -> 0x7FDB; 0x7F85 por coche
	call 0800bh		;7f62
	ld a,(0e1c2h)		;7f65   ; con dos jugadores no hay ritmo que apretar: ya se aprietan ellos
	bit 5,a		;7f68   ; con un jugador ademas se mira el puesto cada 256 fotogramas
	call z,RITMO_CADA_256		;7f6a
	ld a,(0e208h)		;7f6d
	dec a			;7f70
	call z,E208_ALTERNA		;7f71
	ld iy,0e2c0h		;7f74
	call RITMO_COCHE		;7f78
	ld a,(0e1c2h)		;7f7b
	bit 5,a		;7f7e
	ret z			;7f80
	ld iy,0e380h		;7f81
RITMO_COCHE:		; E, DE = p03 0xBDD5 + E25B*3; HL = DE - (iy+7E)*E (0x9B4F); HL *= E20F; compara con (iy+40..42) >> 2: menor -> (iy+7E)-- (minimo 1); si no ++ (hasta 99); 0x7FDB
	ld a,(0e25bh)		;7f85   ; por tres: la tabla de p03 trae un byte y una palabra por categoria
	ld l,a			;7f88
	add a,a			;7f89
	add a,l			;7f8a
	ld l,a			;7f8b
	ld h,000h		;7f8c
	ld de,0bdd5h		;7f8e
	add hl,de			;7f91
	ld e,(hl)			;7f92
	inc hl			;7f93
	push hl			;7f94
	ld h,(iy+07eh)		;7f95
	call 09b4fh		;7f98   ; el ritmo del coche por el byte de la categoria, con la multiplicacion con signo de p02
	ld b,h			;7f9b
	ld c,l			;7f9c
	pop hl			;7f9d
	ld e,(hl)			;7f9e
	inc hl			;7f9f
	ld d,(hl)			;7fa0
	ex de,hl			;7fa1
	or a			;7fa2
	sbc hl,bc		;7fa3
	ld a,(0e20fh)		;7fa5   ; y el resultado por E20F, que es lo que aprieta o afloja a los rivales
	ld e,a			;7fa8
	call 09b4fh		;7fa9
	ld e,(iy+040h)		;7fac
	ld d,(iy+041h)		;7faf
	ld a,(iy+042h)		;7fb2
	rra			;7fb5   ; la posicion en la pista dividida por cuatro, los 24 bits corridos dos veces
	rr d		;7fb6
	rr e		;7fb8
	rra			;7fba
	rr d		;7fbb
	rr e		;7fbd
	or a			;7fbf
	sbc hl,de		;7fc0
	jr nc,RITMO_SUBE		;7fc2   ; si el coche va por delante de lo previsto, el ritmo baja...
	ld a,(iy+07eh)		;7fc4
	dec a			;7fc7
	jr z,E208_ALTERNA		;7fc8
	ld (iy+07eh),a		;7fca
	jr E208_ALTERNA		;7fcd
RITMO_SUBE:		; (iy+7E)++ salvo 0x63
	ld a,(iy+07eh)		;7fcf   ; ...y si va por detras, sube, con tope en 99
	inc a			;7fd2
	cp 064h		;7fd3
	ret z			;7fd5
	ld (iy+07eh),a		;7fd6
	jr E208_ALTERNA		;7fd9
E208_ALTERNA:		; si E208 < 2: E208 = (E208 ^ 1) + 3
	ld a,(0e208h)		;7fdb   ; el `xor 1` cambia el 0 por el 1 y el 1 por el 0, y el `add 3` los lleva a 3 y 4: es un interruptor de dos posiciones
	cp 002h		;7fde
	ret nc			;7fe0
	xor 001h		;7fe1
	add a,003h		;7fe3
	ld (0e208h),a		;7fe5
	ret			;7fe8
L_7FE9:
	ld a,(0e208h)		;7fe9   ; este trozo no tiene llamador conocido: contesta con acarreo si E208 vale 0 o 4
	or a			;7fec
	jr z,L_7FF4		;7fed
	cp 004h		;7fef
	scf			;7ff1
	ccf			;7ff2
	ret nz			;7ff3
L_7FF4:
	scf			;7ff4
	ret			;7ff5
E208_5:		; E208 = 5 (desde p03 0xB564)
	ld a,005h		;7ff6
	ld (0e208h),a		;7ff8
	ret			;7ffb
E208_POR_X:		; E208 = 0 si (ix+4) >= 0xD4, si no 1 (desde p02 0x9E40); la rutina sigue en p02 0x8000: el `sub 0xD4` cruza la frontera (0x7FFF = D6, p02 0x8000 = D4) y acaba en p02 0x800A
	defb 0ddh,07eh,004h		;7ffc   ; LA UNICA INSTRUCCION DEL CARTUCHO QUE CRUZA UNA FRONTERA DE PAGINA: el `sub` de 0x7FFF es de la pagina 1 y su operando (0xD4) es el primer byte de la 2, asi que la rutina sigue en p02 0x8001

; ----------------------------------------------------------------------
; DATOS sub_partido: el opcode `sub` (0xD6) de la rutina 0x7FFC: su operando
;   es el byte 0x8000 de la pagina 2 (0xD4), y la rutina sigue en p02 0x8001.
;   La unica instruccion del cartucho que cruza una frontera de pagina
;   0x7fff..0x8000  (1 bytes)
DATA_sub_partido:
	defb 0d6h	; 7fff
