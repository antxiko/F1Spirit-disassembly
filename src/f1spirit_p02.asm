; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 02 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS operando_sub: el operando 0xD4 del `sub` que empieza en p01 0x7FFF (la
;   rutina p01 0x7FFC cruza la frontera y sigue aqui en 0x8001)
;   0x8000..0x8001  (1 bytes)

; ----------------------------------------------------------------------
; La pagina empieza con el final de p01 0x7FFC (`sub 0xD4` cruza la
; frontera): ld a,0 / jp p,0x8007 / inc a / ld (E208),a / ret.
; ----------------------------------------------------------------------
DATA_operando_sub:
	defb 0d4h	; 8000

; ======================================================================
; CODIGO 0x8001..0x8215  (532 bytes)
; ======================================================================


E208_POR_X_COLA:		; cola de p01 0x7FFC: E208 = 0 si (ix+4) >= 0xD4, si no 1
	ld a,000h		;8001
	jp p,E208_GUARDA_COLA		;8003
	inc a			;8006
E208_GUARDA_COLA:		; ld (E208),a de la cola de p01 0x7FFC
	ld (0e208h),a		;8007
	ret			;800a
E20F_CADA_64:		; cada 64 fotogramas E20F++ (tope 0xFF) (desde p01 0x7F62)
	ld a,(0e1c3h)		;800b
	and 03fh		;800e
	ret nz			;8010
	ld a,(0e20fh)		;8011
	inc a			;8014
	ret z			;8015
	ld (0e20fh),a		;8016
	ret			;8019
INICIA_RIVALES:		; pagina 15 en A000; 0x8025; 1/2/3
	ld a,00fh		;801a
	call 04457h		;801c
	call INICIA_RIVALES_VA		;801f
	jp 043feh		;8022
INICIA_RIVALES_VA:		; E2AD, E2B1, E36D, E2AC, E36C, E321, E3E1, E308, E3C8, E208 = 5; tramo (0x814E) del coche 1 y, con dos jugadores, del 2
	push iy		;8025
	ld a,005h		;8027
	ld (0e2adh),a		;8029
	ld (0e2b1h),a		;802c
	ld (0e36dh),a		;802f
	ld (0e2ach),a		;8032
	ld (0e36ch),a		;8035
	ld (0e321h),a		;8038
	ld (0e3e1h),a		;803b
	ld (0e308h),a		;803e
	ld (0e3c8h),a		;8041
	ld (0e208h),a		;8044
	ld iy,0e2c0h		;8047
	call TRAMO_POR_VUELTA		;804b
	ld a,(0e1c2h)		;804e
	bit 5,a		;8051
	call nz,TRAMO_POR_VUELTA		;8053
	pop iy		;8056
	ret			;8058
PASO_RIVALES:		; pagina 15 en A000; 0x8064; 1/2/3 (desde p03 0xA150)
	ld a,00fh		;8059
	call 04457h		;805b
	call PASO_RIVALES_VA		;805e
	jp 043feh		;8061
PASO_RIVALES_VA:		; 0x80DE; cada 8 fotogramas 0x8129; (iy+61)-- (0x819D): al pasar por 0 lee la entrada siguiente (0x80FA), 0x8084, sonido 0x2C si E1DA != 0; C = ha tocado
	call E208_6_7_A_3_4		;8064
	ld a,(0e1c3h)		;8067
	and 007h		;806a
	call z,TRAMO_RIVALES		;806c
	call CUENTA_RIVAL		;806f
	ret nc			;8072
	call RIVAL_SIGUIENTE		;8073
	call RIVAL_NUEVO		;8076
	ld a,(0e1dah)		;8079
	or a			;807c
	ld a,02ch		;807d
	call nz,04174h		;807f
	scf			;8082
	ret			;8083
RIVAL_NUEVO:		; E209-- (si > 0); a cero 0x80AF (C = nada); si (iy+7E)+7 < (iy+71): (iy-13) = (iy-0F) (+1 si < E91C) y (iy+56) = 0
	ld a,(0e209h)		;8084
	or a			;8087
	jr z,RIVAL_NUEVO_E209		;8088
	dec a			;808a
RIVAL_NUEVO_E209:		; E209 = A
	ld (0e209h),a		;808b
	or a			;808e
	call z,RIVAL_POR_E208		;808f
	ret c			;8092
	ld a,(iy+07eh)		;8093
	add a,007h		;8096
	cp (iy+071h)		;8098
	ret nc			;809b
	ld a,(iy-00fh)		;809c
	ld hl,0e91ch		;809f
	cp (hl)			;80a2
	jr nc,RIVAL_GUARDA_13		;80a3
	add a,001h		;80a5
RIVAL_GUARDA_13:		; (iy-13) = A, (iy+56) = 0
	ld (iy-013h),a		;80a7
	ld (iy+056h),000h		;80aa
	ret			;80ae
RIVAL_POR_E208:		; un jugador: E208 = 3 -> C = 8, E208 = 6, E209 = 10, carry; E208 = 4 -> C = 9, E208 = 7, E209 = 10, carry; si no NC
	ld a,(0e1c2h)		;80af
	bit 5,a		;80b2
	ret nz			;80b4
	ld a,(0e208h)		;80b5
	cp 003h		;80b8
	jr z,RIVAL_E208_3		;80ba
	cp 004h		;80bc
	jr z,RIVAL_E208_4		;80be
	or a			;80c0
	ret			;80c1
RIVAL_E208_3:		; E208 = 6, E209 = 10
	ld c,008h		;80c2
	ld a,006h		;80c4
	ld (0e208h),a		;80c6
	ld a,00ah		;80c9
	ld (0e209h),a		;80cb
	scf			;80ce
	ret			;80cf
RIVAL_E208_4:		; E208 = 7, E209 = 10
	ld c,009h		;80d0
	ld a,007h		;80d2
	ld (0e208h),a		;80d4
	ld a,00ah		;80d7
	ld (0e209h),a		;80d9
	scf			;80dc
	ret			;80dd
E208_6_7_A_3_4:		; si E209 = 0 y E208 es 6 o 7: E208 -= 3
	ld a,(0e209h)		;80de
	or a			;80e1
	ret nz			;80e2
	ld a,(0e208h)		;80e3
	sub 006h		;80e6
	cp 002h		;80e8
	ret nc			;80ea
	ld a,(0e208h)		;80eb
	sub 003h		;80ee
	ld (0e208h),a		;80f0
	ret			;80f3
L_80F4:
	ld a,002h		;80f4
	ld (0e208h),a		;80f6
	ret			;80f9
RIVAL_SIGUIENTE:		; (iy+48) = tipo D de la entrada (0x8105), (iy+61) = 8
	call ENTRADA_RIVAL		;80fa
	ld (iy+048h),d		;80fd
	ld (iy+061h),008h		;8100
	ret			;8104
ENTRADA_RIVAL:		; HL = p15 0xB9C3[(iy-18)] + 3*(iy-17): D = tipo, C, B; 0xFF -> (iy-17) = 0 y repite
	ld a,(iy-018h)		;8105
	ld hl,0b9c3h		;8108
	call 04a44h		;810b
	ld a,(iy-017h)		;810e
	ld e,a			;8111
	add a,a			;8112
	add a,e			;8113
	ld e,a			;8114
	ld d,000h		;8115
	add hl,de			;8117
	ld a,(hl)			;8118
	cp 0ffh		;8119
	jr z,ENTRADA_RIVAL_REINICIA		;811b
	ld d,a			;811d
	inc hl			;811e
	ld c,(hl)			;811f
	inc hl			;8120
	ld b,(hl)			;8121
	ret			;8122
ENTRADA_RIVAL_REINICIA:		; (iy-17) = 0
	ld (iy-017h),000h		;8123
	jr ENTRADA_RIVAL		;8127
TRAMO_RIVALES:		; cada 32 fotogramas: tramo (0x814E); (iy-14)-- a cero: entrada de 4 bytes (0x8162) -> (iy-13), (iy-0F), (iy-18), (iy-14), (iy+56); (iy-17) = 0
	ld a,(0e1c3h)		;8129
	and 01fh		;812c
	ret nz			;812e
	call TRAMO_POR_VUELTA		;812f
	ld a,(iy-014h)		;8132
	dec a			;8135
	ld (iy-014h),a		;8136
	ret nz			;8139
	call ENTRADA_TRAMO		;813a
	ld (iy-013h),c		;813d
	ld (iy-00fh),c		;8140
	ld (iy-018h),d		;8143
	ld (iy-014h),e		;8146
	ld (iy+056h),b		;8149
	jr ENTRADA_RIVAL_REINICIA		;814c
TRAMO_POR_VUELTA:		; (iy-16) = p15 0xB8BD[E25B][(iy-2) vueltas]
	ld a,(0e25bh)		;814e
	ld hl,0b8bdh		;8151
	call 04a44h		;8154
	ld e,(iy-002h)		;8157
	ld d,000h		;815a
	add hl,de			;815c
	ld a,(hl)			;815d
	ld (iy-016h),a		;815e
	ret			;8161
ENTRADA_TRAMO:		; HL = p15 0xB8C9[(iy-16)] + 3*(iy-15); (iy-15)++; D, E, C = byte&0x0F, B = bit 4; si el 4o byte es 0xFF, (iy-15) = 0
	ld a,(iy-015h)		;8162
	ld e,a			;8165
	inc a			;8166
	ld (iy-015h),a		;8167
	ld d,000h		;816a
	ld h,d			;816c
	ld l,e			;816d
	add hl,hl			;816e
	add hl,de			;816f
	push hl			;8170
	ld a,(iy-016h)		;8171
	ld de,0b8c9h		;8174
	call 04a3bh		;8177
	pop hl			;817a
	add hl,de			;817b
	ld d,(hl)			;817c
	inc hl			;817d
	ld e,(hl)			;817e
	inc hl			;817f
	ld a,(hl)			;8180
	ld b,a			;8181
	and 00fh		;8182
	ld c,a			;8184
	xor b			;8185
	rlca			;8186
	and 001h		;8187
	ld b,a			;8189
	inc hl			;818a
	ld a,(hl)			;818b
	inc a			;818c
	ret nz			;818d
	ld (iy-015h),000h		;818e
	ret			;8192
RIVAL_OTRA_VEZ:		; (iy-17)++ y (iy+61) = (iy+48) (desde p03 0xA13D)
	inc (iy-017h)		;8193
	ld a,(iy+048h)		;8196
	ld (iy+061h),a		;8199
	ret			;819c
CUENTA_RIVAL:		; (iy+61)--; C al pasar de 0
	ld a,(iy+061h)		;819d
	sub 001h		;81a0
	ld (iy+061h),a		;81a2
	ret			;81a5
FINAL_16:		; E251 = 0: E252 = 0, musica 0x40 (0x884C) y paso siguiente; 1: fundido (0x83BA) y paso; 2: E300 = 0, colores 0x8..0x52F a 0xFF (0x83FB), E400 lleno de 0xFE, colores del tile 254 (0x7F0) a 0xFF, vuelca, E25E = EA6D = E25D = E251 = 0 y p00 0x5BA2 (E250 = 17)
	ld a,(0e251h)		;81a6
	and a			;81a9
	jr z,FINAL_16_ARRANCA		;81aa
	dec a			;81ac
	jr z,FINAL_16_FUNDIDO		;81ad
	xor a			;81af
	ld (0e300h),a		;81b0
	call COLORES_A_FF		;81b3
	ld hl,0e400h		;81b6
	ld bc,002ffh		;81b9
	ld a,0feh		;81bc
	call 04b88h		;81be
	ld a,0ffh		;81c1
	ld hl,007f0h		;81c3
	ld bc,00008h		;81c6
	call 047e6h		;81c9
	ld iy,0e2c0h		;81cc
	call 044bch		;81d0
	xor a			;81d3
	ld (0e25eh),a		;81d4
	xor a			;81d7
	ld (0ea6dh),a		;81d8
	ld (0e25dh),a		;81db
	ld (0e251h),a		;81de
	jp 05ba2h		;81e1
FINAL_16_FUNDIDO:		; 0x83BA hasta acabar y paso siguiente
	call FUNDIDO_FF		;81e4
	ret nz			;81e7
	jp PASO_SIGUIENTE		;81e8
FINAL_16_ARRANCA:		; E252 = 0, musica 0x40, paso siguiente
	xor a			;81eb
	ld (0e252h),a		;81ec
	ld a,040h		;81ef
	call MUSICA_A		;81f1
	jp PASO_SIGUIENTE		;81f4
FINAL_17:		; pagina 9 en A000; p00 0x477C; vuelca E400 si E251 < 14; despacha por E251 (tabla 0x8215, 19 pasos) y vuelve a 1/2/3 (retorno 0x43FE empujado)
	ld a,009h		;81f7
	call 04457h		;81f9
	call 0477ch		;81fc
	ld iy,0e2c0h		;81ff
	ld a,(0e251h)		;8203
	cp 00eh		;8206
	call c,044bch		;8208
	ld hl,043feh		;820b
	push hl			;820e
	ld a,(0e251h)		;820f
	call 040dah		;8212

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (38 bytes)
;   0x8215..0x823b  (38 bytes)
DATA_8215:
	defb 03bh,082h,075h,082h,07ah,082h,082h,082h,090h,082h,09bh,082h,0aah,082h,0afh,082h	; 8215  ;.u.z...........
	defb 0cch,082h,0deh,082h,0e6h,082h,0f8h,082h,000h,083h,015h,083h,020h,083h,042h,083h	; 8225  ............ .B.
	defb 04fh,083h,05ah,083h,07fh,084h	; 8235

; ======================================================================
; CODIGO 0x823b..0x8431  (502 bytes)
; ======================================================================


FINAL_PASO_0:		; tiles p04 0x6DB5 y 0x6DBC, sprites p04 0x7502, limpia, 16x8 de tile 0xFF en E50C (p00 0x4B6C), texto (0x8370), vuelca, tiles 0x6DAE por filas, 0x8367, sprites (0x851D); E25D = 1 y paso siguiente
	ld hl,06db5h		;823b
	call 04ccdh		;823e
	ld hl,06dbch		;8241
	call 04ccdh		;8244
	ld hl,07502h		;8247
	call 04f11h		;824a
	call 04460h		;824d
	ld bc,01008h		;8250
	ld hl,0e50ch		;8253
	ld a,0ffh		;8256
	call 04b6ch		;8258
	call TEXTO_FINAL		;825b
	call 044bch		;825e
	ld de,00100h		;8261
	ld hl,06daeh		;8264
	call 04c93h		;8267
	call CARGA_6DB5_POR_FILAS		;826a
	call SPRITES_FINAL_4		;826d
	ld a,001h		;8270
	jp PASO_SIGUIENTE_CON_ESPERA		;8272
FINAL_PASO_1:		; espera 0x32 fotogramas (0x83E6)
	ld a,032h		;8275
	jp ESPERA_E25D		;8277
FINAL_PASO_2:		; sprites (0x8537) y espera 1
	call SPRITES_FINAL_MUEVE		;827a
	ld a,001h		;827d
	jp ESPERA_E25D		;827f
FINAL_PASO_3:		; imagen p09 0xB217 en E50C (0x82C4), p00 0x543C, espera 0xF0
	ld de,0b217h		;8282
	call FINAL_IMAGEN		;8285
	call 0543ch		;8288
	ld a,0f0h		;828b
	jp ESPERA_E25D		;828d
FINAL_PASO_4:		; sprites (0x8537), p00 0x545E, espera 1
	call SPRITES_FINAL_MUEVE		;8290
	call 0545eh		;8293
	ld a,001h		;8296
	jp ESPERA_E25D		;8298
FINAL_PASO_5:		; fundido y la imagen p09 0xB266 con la lista 0x6DD6 (0x8390); espera 0x64
	ld de,0b266h		;829b
	ld hl,06dd6h		;829e
	call FINAL_FUNDE_Y_PINTA		;82a1
	ret nz			;82a4
	ld a,064h		;82a5
	jp ESPERA_E25D		;82a7
FINAL_PASO_6:		; espera 0x8C
	ld a,08ch		;82aa
	jp ESPERA_E25D		;82ac
FINAL_PASO_7:		; parpadeo: (E1C3 & 0x15) != 0 -> imagen 0xB266 y espera 1; si no imagen 0xB2E3
	ld a,(0e1c3h)		;82af
	and 015h		;82b2
	jr z,FINAL_IMAGEN_B2E3		;82b4
	ld de,0b266h		;82b6
	call FINAL_IMAGEN		;82b9
	ld a,001h		;82bc
	jp ESPERA_E25D		;82be
FINAL_IMAGEN_B2E3:		; DE = p09 0xB2E3
	ld de,0b2e3h		;82c1
FINAL_IMAGEN:		; descomprime DE (16 columnas) en E50C (p01 0x637A)
	ld hl,0e50ch		;82c4
	ld a,010h		;82c7
	jp 0637ah		;82c9
FINAL_PASO_8:		; fundido y p09 0xB360 con la lista 0x6DC3; E821..E823 = 0 (0x85B0); espera 0xFA
	ld de,0b360h		;82cc
	ld hl,06dc3h		;82cf
	call FINAL_FUNDE_Y_PINTA		;82d2
	ret nz			;82d5
	call E821_E823_CERO		;82d6
	ld a,0fah		;82d9
	jp ESPERA_E25D		;82db
FINAL_PASO_9:		; sprites de la tabla p06 0x8639 (0x85BB) y espera 1
	call SPRITES_FINAL_TABLA		;82de
	ld a,001h		;82e1
	jp ESPERA_E25D		;82e3
FINAL_PASO_10:		; fundido y p09 0xB3BF con la lista 0x6DE3; limpia sprites; espera 0xB4
	ld de,0b3bfh		;82e6
	ld hl,06de3h		;82e9
	call FINAL_FUNDE_Y_PINTA		;82ec
	ret nz			;82ef
	call 04460h		;82f0
	ld a,0b4h		;82f3
	jp ESPERA_E25D		;82f5
FINAL_PASO_11:		; sprites (0x851D) y espera 1
	call SPRITES_FINAL_4		;82f8
	ld a,001h		;82fb
	jp ESPERA_E25D		;82fd
FINAL_PASO_12:		; fundido y p09 0xB217 con la lista 0x6DBC; sprites; p00 0x543C; espera 0xFA
	ld de,0b217h		;8300
	ld hl,06dbch		;8303
	call FINAL_FUNDE_Y_PINTA		;8306
	ret nz			;8309
	call SPRITES_FINAL_4		;830a
	call 0543ch		;830d
	ld a,0fah		;8310
	jp ESPERA_E25D		;8312
FINAL_PASO_13:		; sprites (0x8537), p00 0x545E, espera 0x14
	call SPRITES_FINAL_MUEVE		;8315
	call 0545eh		;8318
	ld a,014h		;831b
	jp ESPERA_E25D		;831d
FINAL_PASO_14:		; limpia sprites; fundido; nombres a cero, tiles 16..58 con 0xF0 (p00 0x4474), 1/2/3; los creditos 0x848A (p00 0x480D); espera 0x96
	call 04460h		;8320
	call FUNDIDO_FF		;8323
	ret nz			;8326
	xor a			;8327
	ld hl,03800h		;8328
	ld bc,00300h		;832b
	call 00056h		;832e   ; BIOS FILVRM - Fills VRAM with value
	call 04474h		;8331
	call 043feh		;8334
	ld de,0848ah		;8337
	call 0480dh		;833a
	ld a,096h		;833d
	jp PASO_SIGUIENTE_CON_ESPERA		;833f
FINAL_PASO_15:		; fundido con tiles 0xFE (0x83C1 con C = 0xFE, B = 0xFF) y paso
	ld bc,0fffeh		;8342
	ld hl,00000h		;8345
	call FUNDIDO_BANDA		;8348
	ret nz			;834b
	jp PASO_SIGUIENTE		;834c
FINAL_PASO_16:		; espera 0x64 y sonido 0x81
	ld a,064h		;834f
	call ESPERA_E25D		;8351
	ret nz			;8354
	ld a,081h		;8355
	jp 04174h		;8357
FINAL_PASO_17:		; fundido con tiles 0 (0x83C1) y paso
	ld hl,00000h		;835a
	ld bc,00000h		;835d
	call FUNDIDO_BANDA		;8360
	ret nz			;8363
	jp PASO_SIGUIENTE		;8364
CARGA_6DB5_POR_FILAS:		; lista p04 0x6DB5 por filas (p00 0x4C93) con espera 0x100
	ld hl,06db5h		;8367
	ld de,00100h		;836a
	jp 04c93h		;836d
TEXTO_FINAL:		; E62C.. 16x3 de tile 0xFE; pagina 9 en A000; texto p09 0xAFCF expandido (p01 0x691B) y pintado en E62C (3 filas x 16, fuente 0xE0; p01 0x666E)
	ld bc,01003h		;8370
	ld hl,0e62ch		;8373
	ld a,0feh		;8376
	call 04b6ch		;8378
	ld a,009h		;837b
	call 04457h		;837d
	ld hl,0afcfh		;8380
	call 0691bh		;8383
	ld hl,0e62ch		;8386
	ld bc,00310h		;8389
	call 0666eh		;838c
	ret			;838f
FINAL_FUNDE_Y_PINTA:		; limpia sprites; fundido (0x83BA) hasta acabar (NZ mientras); imagen DE en E50C; texto (0x8370); vuelca; lista HL por filas y 0x8367; Z
	push hl			;8390
	push de			;8391
	call 04460h		;8392
	pop de			;8395
	pop hl			;8396
	push hl			;8397
	push de			;8398
	call FUNDIDO_FF		;8399
	pop de			;839c
	pop hl			;839d
	ret nz			;839e
	push hl			;839f
	ld hl,0e50ch		;83a0
	ld a,010h		;83a3
	call 0637ah		;83a5
	call TEXTO_FINAL		;83a8
	call 044bch		;83ab
	pop hl			;83ae
	ld de,00100h		;83af
	call 04c93h		;83b2
	call CARGA_6DB5_POR_FILAS		;83b5
	xor a			;83b8
	ret			;83b9
FUNDIDO_FF:		; C = 0xFF (blanco sobre blanco) y 0x83BC
	ld c,0ffh		;83ba
FUNDIDO_FF_B0:		; B = 0 (256 tiles), HL = 0 (desde la tabla de colores) (E250 = 18 entra aqui desde p00 0x5B5A)
	ld b,000h		;83bc
	ld hl,00000h		;83be
FUNDIDO_BANDA:		; escribe C en el byte E252 (fila de 8 px) de la entrada de colores de B tiles (0 = 256) desde HL, en los 3 tercios; E252++; Z al llegar a 8 (las 8 filas hechas)
	ld a,(0e252h)		;83c1
	call 040d0h		;83c4
FUNDIDO_BANDA_TILE:		; un tile por vuelta (tres WRTVRM)
	ld a,c			;83c7
	call 0004dh		;83c8   ; BIOS WRTVRM - Writes data in VRAM
	push hl			;83cb
	ld de,00800h		;83cc
	add hl,de			;83cf
	call 0004dh		;83d0   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;83d3
	call 0004dh		;83d4   ; BIOS WRTVRM - Writes data in VRAM
	pop hl			;83d7
	ld de,00008h		;83d8
	add hl,de			;83db
	djnz FUNDIDO_BANDA_TILE		;83dc
	ld hl,0e252h		;83de
	inc (hl)			;83e1
	ld a,(hl)			;83e2
	cp 008h		;83e3
	ret			;83e5
ESPERA_E25D:		; E25D--; si no es 0 vuelve (NZ); si no E25D = A, E25E = 0 y paso siguiente
	ld hl,0e25dh		;83e6
	dec (hl)			;83e9
	ret nz			;83ea
PASO_SIGUIENTE_CON_ESPERA:		; E25D = A, E25E = 0, E251++, E252 = 0
	ld (0e25dh),a		;83eb
	xor a			;83ee
	ld (0e25eh),a		;83ef
PASO_SIGUIENTE:		; E251++, E252 = 0, Z
	ld hl,0e251h		;83f2
	inc (hl)			;83f5
	inc hl			;83f6
	ld (hl),000h		;83f7
	xor a			;83f9
	ret			;83fa
COLORES_A_FF:		; 0x520 bytes de 0xFF desde la tabla de colores 0x0008, 3 tercios
	ld a,0ffh		;83fb
	ld hl,00008h		;83fd
	ld bc,00520h		;8400
	jp 047e6h		;8403
FUNDIDO_RANKING:		; por E252 (0x10..0x28): bandas de la tabla 0x8431 (pares de filas x 8 px) con C = bits de tercio (0x844F); en 0x14 espera E25D (3C); (desde p01 0x6AC1, C = 7)
	ld a,(0e252h)		;8406
	cp 014h		;8409
	jr z,FUNDIDO_RANKING_ESPERA		;840b
	jr c,FUNDIDO_RANKING_BANDA		;840d
	cp 028h		;840f
	jr z,$+52		;8411
	ld b,a			;8413
	ld a,028h		;8414
	sub b			;8416
FUNDIDO_RANKING_BANDA:		; A = fila de la tabla 0x8431[E252 o 0x28-E252], B = la anterior
	ld hl,08431h		;8417
	call 040d0h		;841a
	ld a,(hl)			;841d
	dec hl			;841e
	ld b,(hl)			;841f
	call PINTA_BANDA_TERCIOS		;8420
FUNDIDO_RANKING_SIGUE:		; E252++
	ld hl,0e252h		;8423
	inc (hl)			;8426
	ret			;8427
FUNDIDO_RANKING_ESPERA:		; E25D-- a cero -> E25D = 0x3C y E252++
	ld hl,0e25dh		;8428
	dec (hl)			;842b
	ret nz			;842c
	ld (hl),03ch		;842d
	jr FUNDIDO_RANKING_SIGUE		;842f

; ----------------------------------------------------------------------
; DATOS tabla_bandas_ranking: 20 bytes: filas de colores (0x10, 0x40, 0x50,
;   0x70, 0xC0, 0x30, 0xA0, 0xB0, 0xE0, 0xF0, cada una dos veces) que el
;   fundido 0x8406 va escribiendo
;   0x8431..0x8445  (20 bytes)
DATA_tabla_bandas_ranking:
	defb 010h,010h	; 8431
	defb 040h,040h	; 8433
	defb 050h,050h	; 8435
	defb 070h,070h	; 8437
	defb 0c0h,0c0h	; 8439
	defb 030h,030h	; 843b
	defb 0a0h,0a0h	; 843d
	defb 0b0h,0b0h	; 843f
	defb 0e0h,0e0h	; 8441
	defb 0f0h,0f0h	; 8443

; ======================================================================
; CODIGO 0x8445..0x848a  (69 bytes)
; ======================================================================


ESPERA_E25D_E252:		; E25D-- a cero -> E252 = 0
	ld hl,0e25dh		;8445
	dec (hl)			;8448
	ret nz			;8449
	xor a			;844a
	ld (0e252h),a		;844b
	ret			;844e
PINTA_BANDA_TERCIOS:		; por cada bit 0/1/2 de C: la fila de colores HL (+0x80) del tercio 0/1/2 con A y B (0x846C)
	ld hl,00080h		;844f
	bit 0,c		;8452
	push af			;8454
	call nz,PINTA_BANDA_AB		;8455
	pop af			;8458
	push af			;8459
	ld hl,00880h		;845a
	bit 1,c		;845d
	call nz,PINTA_BANDA_AB		;845f
	pop af			;8462
	ld hl,01080h		;8463
	bit 2,c		;8466
	call nz,PINTA_BANDA_AB		;8468
	ret			;846b
PINTA_BANDA_AB:		; 0xAC tiles: byte A en L y B en L+1 (0x8473)
	push hl			;846c
	call PINTA_BANDA_AC		;846d
	ld a,b			;8470
	pop hl			;8471
	inc l			;8472
PINTA_BANDA_AC:		; B = 0xAC y el bucle
	push bc			;8473
	ld b,0ach		;8474
PINTA_BANDA_BUCLE:		; un WRTVRM cada 2 bytes, 0xAC veces
	call 0004dh		;8476   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;8479
	inc hl			;847a
	djnz PINTA_BANDA_BUCLE		;847b
	pop bc			;847d
	ret			;847e
FINAL_PASO_18:		; espera E25D y E250 = 0x1D
	ld hl,0e25dh		;847f
	dec (hl)			;8482
	ret nz			;8483
	ld a,01dh		;8484
	call 06049h		;8486
	ret			;8489

; ----------------------------------------------------------------------
; DATOS creditos: flujo para p00 0x480D (ASCII): STAFF; PROGRAM: T.ADACHI,
;   M.OZAWA, R.SAGISAKA; GRAPHIC: H.MAKITANI, T.SHIMIZU, B.KINOSHITA; SOUND:
;   K.UEHARA, M.SASAKI, M.FURUKAWA
;   0x848a..0x851d  (147 bytes)
DATA_creditos:
	defb 04eh,038h,053h,054h,041h,046h,046h,0feh	; 848a  N8STAFF.
	defb 084h,038h,050h,052h,04fh,047h,052h,041h,04dh,03eh,0feh	; 8492  .8PROGRAM>.
	defb 091h,038h,054h,03dh,041h,044h,041h,043h,048h,049h,0feh	; 849d  .8T=ADACHI.
	defb 0d1h,038h,04dh,03dh,04fh,05ah,041h,057h,041h,0feh	; 84a8  .8M=OZAWA.
	defb 011h,039h,052h,03dh,053h,041h,047h,049h,053h,041h,04bh,041h,0feh	; 84b2  .9R=SAGISAKA.
	defb 064h,039h,047h,052h,041h,050h,048h,049h,043h,03eh,0feh	; 84bf  d9GRAPHIC>.
	defb 071h,039h,048h,03dh,04dh,041h,04bh,049h,054h,041h,04eh,049h,0feh	; 84ca  q9H=MAKITANI.
	defb 0b1h,039h,054h,03dh,053h,048h,049h,04dh,049h,05ah,055h,0feh	; 84d7  .9T=SHIMIZU.
	defb 0f1h,039h,042h,03dh,04bh,049h,04eh,04fh,053h,048h,049h,054h,041h,0feh	; 84e3  .9B=KINOSHITA.
	defb 044h,03ah,053h,04fh,055h,04eh,044h,03eh,0feh	; 84f1  D:SOUND>.
	defb 051h,03ah,04bh,03dh,055h,045h,048h,041h,052h,041h,0feh	; 84fa  Q:K=UEHARA.
	defb 091h,03ah,04dh,03dh,053h,041h,053h,041h,04bh,049h,0feh	; 8505  .:M=SASAKI.
	defb 0d1h,03ah,04dh,03dh,046h,055h,052h,055h,04bh,041h,057h,041h,0ffh	; 8510  .:M=FURUKAWA.

; ======================================================================
; CODIGO 0x851d..0x8533  (22 bytes)
; ======================================================================


SPRITES_FINAL_4:		; 4 atributos (0x0E, 0x60, 0x0C, 0x0F) de 0x8533 en EA80..; EA81 = 0x82
	ld a,004h		;851d
	ld de,0ea80h		;851f
SPRITES_FINAL_BUCLE:		; uno por vuelta
	ld bc,00004h		;8522
	ld hl,08533h		;8525
	ldir		;8528
	dec a			;852a
	jr nz,SPRITES_FINAL_BUCLE		;852b
	ld a,082h		;852d
	ld (0ea81h),a		;852f
	ret			;8532

; ----------------------------------------------------------------------
; DATOS atributo_final: (y 0x0E, x 0x60, patron 0x0C, color 0x0F)
;   0x8533..0x8537  (4 bytes)
DATA_atributo_final:
	defb 00eh,060h,00ch,00fh	; 8533

; ======================================================================
; CODIGO 0x8537..0x8639  (258 bytes)
; ======================================================================


SPRITES_FINAL_MUEVE:		; D/E = 0xD8 (o 0x9E/0xA0 con E251 >= 4): dos grupos de 2 sprites (EA80 y EA88) que se mueven en x (+2/+1 cada 4 fotogramas) con el color 5/10 alternando; al pasar D, color 0 o vuelta a x = 0x60 (E803++)
	ld d,0d8h		;8537
	ld e,0d8h		;8539
	ld a,(0e251h)		;853b
	cp 004h		;853e
	jr c,SPRITES_FINAL_VA		;8540
	ld d,09eh		;8542
	ld e,0a0h		;8544
SPRITES_FINAL_VA:		; 0x854A
	call SPRITES_FINAL_GRUPOS		;8546
	ret			;8549
SPRITES_FINAL_GRUPOS:		; patrones 0x4B (IY = E811, IX = EA80, C = 2) y 0x5B (E812, EA88, C = 1)
	ld iy,0e811h		;854a
	ld ix,0ea80h		;854e
	ld b,002h		;8552
	ld c,002h		;8554
	ld a,04bh		;8556
	call SPRITE_FINAL		;8558
	ld d,e			;855b
	ld iy,0e812h		;855c
	ld ix,0ea88h		;8560
	ld c,001h		;8564
	ld b,002h		;8566
	ld a,05bh		;8568
SPRITE_FINAL:		; patron A, color 5/10 por bit 0 de E1C3, x += C cada 4 fotogramas; si x >= D -> 0x85A6
	ld (ix+000h),a		;856a
	ex af,af'			;856d
	push de			;856e
	ld a,(0e1c3h)		;856f
	ld d,005h		;8572
	bit 0,a		;8574
	jr z,SPRITE_FINAL_COLOR		;8576
	ld d,00ah		;8578
SPRITE_FINAL_COLOR:		; color D
	ld a,d			;857a
	pop de			;857b
	ld (ix+003h),a		;857c
	ld a,(0e1c3h)		;857f
	and 003h		;8582
	ld a,(ix+001h)		;8584
	jr nz,SPRITE_FINAL_X		;8587
	add a,c			;8589
	ld (ix+001h),a		;858a
SPRITE_FINAL_X:		; compara con D
	cp d			;858d
	call nc,SPRITE_FINAL_PASA		;858e
	push de			;8591
	ld de,00004h		;8592
	add ix,de		;8595
	pop de			;8597
	ex af,af'			;8598
	djnz SPRITE_FINAL		;8599
	ret			;859b
SPRITE_FINAL_REINICIA:		; x = 0x60 y E803++
	ld a,060h		;859c
	ld (ix+001h),a		;859e
	ld hl,0e803h		;85a1
	inc (hl)			;85a4
	ret			;85a5
SPRITE_FINAL_PASA:		; x >= 0xD8 -> 0x859C; si no color 0
	cp 0d8h		;85a6
	jp nc,SPRITE_FINAL_REINICIA		;85a8
	xor a			;85ab
	ld (ix+003h),a		;85ac
	ret			;85af
E821_E823_CERO:		; E821 = E822 = E823 = 0
	xor a			;85b0
	ld (0e821h),a		;85b1
	ld (0e822h),a		;85b4
	ld (0e823h),a		;85b7
	ret			;85ba
SPRITES_FINAL_TABLA:		; pagina 6 en A000; 0x85C6; 1/2/3
	ld a,006h		;85bb
	call 04457h		;85bd
	call SPRITES_FINAL_TABLA_VA		;85c0
	jp 043feh		;85c3
SPRITES_FINAL_TABLA_VA:		; cada 4 fotogramas: si E821 = 0, cada 32 fotogramas E822 = p00 0x5513 (azar) & 1; lee desde la tabla p06 0x8639[E822] + E823 atributos de 4 bytes (0xFF fin: limpia) hasta uno con bit 7 en el 4o byte
	ld a,(0e1c3h)		;85c6
	and 003h		;85c9
	ret nz			;85cb
	ld a,(0e821h)		;85cc
	and a			;85cf
	jr nz,SPRITES_TABLA_LEE		;85d0
	ld a,(0e1c3h)		;85d2
	and 01ah		;85d5
	ret nz			;85d7
	call 05513h		;85d8
	and 001h		;85db
	ld (0e822h),a		;85dd
SPRITES_TABLA_LEE:		; HL = p06 (0x8639[E822]) + E823
	ld a,(0e822h)		;85e0
	add a,a			;85e3
	ld hl,08639h		;85e4
	call 040d0h		;85e7
	ld e,(hl)			;85ea
	inc hl			;85eb
	ld d,(hl)			;85ec
	ex de,hl			;85ed
	ld ix,0ea80h		;85ee
	ld a,(0e823h)		;85f2
	call 040d0h		;85f5
SPRITES_TABLA_BUCLE:		; un atributo por vuelta: E821 = y; color = byte & 0x0F; bit 7 = para
	ld a,(0e823h)		;85f8
	add a,004h		;85fb
	ld (0e823h),a		;85fd
	ld c,000h		;8600
	ld a,(hl)			;8602
	cp 0ffh		;8603
	jr z,SPRITES_TABLA_FIN		;8605
	ld (ix+000h),a		;8607
	ld (0e821h),a		;860a
	inc hl			;860d
	ld a,(hl)			;860e
	ld (ix+001h),a		;860f
	inc hl			;8612
	ld a,(hl)			;8613
	ld (ix+002h),a		;8614
	inc hl			;8617
	ld a,(hl)			;8618
	add a,080h		;8619
	jr nc,SPRITES_TABLA_COLOR		;861b
	ld c,a			;861d
SPRITES_TABLA_COLOR:		; color
	and 00fh		;861e
	ld (ix+003h),a		;8620
	ld a,c			;8623
	and a			;8624
	ret nz			;8625
	inc hl			;8626
	ld de,00004h		;8627
	add ix,de		;862a
	jr SPRITES_TABLA_BUCLE		;862c
SPRITES_TABLA_FIN:		; E821 = E823 = 0 y limpia sprites
	xor a			;862e
	ld (0e821h),a		;862f
	ld (0e823h),a		;8632
	call 04460h		;8635
	ret			;8638

; ----------------------------------------------------------------------
; DATOS tabla_sprites_final: 2 punteros (E822) a listas de atributos en p06
;   (0xBC97, 0xBD2C)
;   0x8639..0x863d  (4 bytes)
DATA_tabla_sprites_final:
	defw 0bc97h	; 8639
	defw 0bd2ch	; 863b

; ======================================================================
; CODIGO 0x863d..0x8804  (455 bytes)
; ======================================================================


PAUSA_SONIDO_MOTOR:		; E1DB = E190, E190 = 0 y sonido 0x83 (desde p00 0x5B86)
	ld hl,0e190h		;863d
	ld a,(hl)			;8640
	ld (hl),000h		;8641
	ld (0e1dbh),a		;8643
	ld a,083h		;8646
	jp 04174h		;8648
REANUDA_SONIDO_MOTOR:		; sonido 0x82, espera la interrupcion, E190 = E1DB y la musica de la carrera (0x881D) (desde p00 0x5B7E)
	ld a,082h		;864b
	call 04174h		;864d
	call ESPERA_INTERRUPCION		;8650
	ld a,(0e1dbh)		;8653
	ld (0e190h),a		;8656
	jp MUSICA_CARRERA_B		;8659
CUENTA_ATRAS_ACABADA:		; Z si F0F7/F0F8 = 0
	ld a,(0f0f8h)		;865c
	or a			;865f
	ret nz			;8660
	ld a,(0f0f7h)		;8661
	or a			;8664
	ret			;8665
ESPERA_INTERRUPCION:		; bit 7 de E1C5 y espera a que la interrupcion lo quite
	push af			;8666
	di			;8667
	ld hl,0e1c5h		;8668
	set 7,(hl)		;866b
ESPERA_INTERRUPCION_BUCLE:		; ei y comprueba
	ei			;866d
	bit 7,(hl)		;866e
	jr nz,ESPERA_INTERRUPCION_BUCLE		;8670
	pop af			;8672
	ret			;8673
SONIDO_JUGADOR:		; ENCOLA_SONIDO A + (ix+9) - 1
	add a,(ix+009h)		;8674
	dec a			;8677
	jp 04174h		;8678
SONIDO_JUGADOR_B:		; idem
	add a,(ix+009h)		;867b
	dec a			;867e
	jp 04174h		;867f
MUSICA_META:		; di; canales del jugador fuera (0x8744); sonido 2; E217 = 0, E218 = 8; musica 0x3D; ei
	di			;8682
	call CANALES_JUGADOR_FUERA		;8683
	ld a,002h		;8686
	call 04174h		;8688
	ld hl,0e217h		;868b
	ld (hl),000h		;868e
	inc hl			;8690
	ld (hl),008h		;8691
	ld a,03dh		;8693
	call MUSICA_A		;8695
	ei			;8698
	ret			;8699
PARA_MUSICA:		; E20A = 0, E217 = E218 = 0, E190 = 0, sonidos 0x46 y 0x80 (desde p00 0x42AE y p01)
	xor a			;869a
	ld (0e20ah),a		;869b
	ld hl,0e217h		;869e
	ld (hl),a			;86a1
	inc hl			;86a2
	ld (hl),a			;86a3
	call E190_CERO		;86a4
	ld a,046h		;86a7
	call 04174h		;86a9
	ld a,080h		;86ac
	jp 04174h		;86ae
SONIDO_2C_JUGADOR:		; di; canales fuera; sonido 0x2C; ei
	di			;86b1
	call CANALES_JUGADOR_FUERA		;86b2
	ld a,02ch		;86b5
	call 04174h		;86b7
	ei			;86ba
	ret			;86bb
L_86BC:
	ld hl,0e217h		;86bc
	ld (hl),000h		;86bf
	inc hl			;86c1
	ld (hl),008h		;86c2
	ld a,02bh		;86c4
	call 04174h		;86c6
	ei			;86c9
	ret			;86ca
L_86CB:
	xor a			;86cb
	ld (0e190h),a		;86cc
	ret			;86cf
CANAL_MOTOR:		; si el coche esta parado ((iy+10,11) = 0) y E221 >= 7: E190 |= mascara del jugador (0x86FA); si se mueve y E190 & 0x44: E190 &= ~mascara
	ld a,(iy+010h)		;86d0
	or (iy+011h)		;86d3
	ld a,(0e190h)		;86d6
	ld e,a			;86d9
	jr nz,CANAL_MOTOR_QUITA		;86da
	ex af,af'			;86dc
	ld a,(0e221h)		;86dd
	cp 007h		;86e0
	ret c			;86e2
	ex af,af'			;86e3
	call MASCARA_JUGADOR		;86e4
	ld e,a			;86e7
	or d			;86e8
	ld (0e190h),a		;86e9
	ret			;86ec
CANAL_MOTOR_QUITA:		; mascara fuera
	and 044h		;86ed
	ret z			;86ef
	call MASCARA_JUGADOR		;86f0
	ld a,d			;86f3
	cpl			;86f4
	and e			;86f5
	ld (0e190h),a		;86f6
	ret			;86f9
MASCARA_JUGADOR:		; D = 4 (jugador 1) o 0x40 (jugador 2)
	bit 0,(iy+009h)		;86fa
	ld d,004h		;86fe
	ret nz			;8700
	ld d,040h		;8701
	ret			;8703
CANALES_INICIALES:		; E190 = 0x0B (un jugador) o 0xBB (dos) (desde p01 0x7E17)
	ld a,(0e1c2h)		;8704
	bit 5,a		;8707
	jr nz,CANALES_DOS		;8709
	ld a,00bh		;870b
	ld (0e190h),a		;870d
	ret			;8710
CANALES_DOS:		; E190 = 0xBB
	ld a,0bbh		;8711
	ld (0e190h),a		;8713
	ret			;8716
REVS_A_FRECUENCIA:		; p00 0x4A8A (desde 0x89EC)
	call 04a8ah		;8717
	ret			;871a
REVS_A_FRECUENCIA_B:		; p00 0x4A86
	call 04a86h		;871b
	ret			;871e
CANALES_BOXES:		; E190 = (E190 & 0xF0) | 0x0B (jugador 1) o (& 0x0F) | 0xB0 (jugador 2)
	ld hl,00bf0h		;871f
	ld de,0b00fh		;8722
	bit 0,(iy+009h)		;8725
	jr nz,CANALES_BOXES_APLICA		;8729
	ex de,hl			;872b
CANALES_BOXES_APLICA:		; E190 = (E190 & L) | H
	ld a,(0e190h)		;872c
	and l			;872f
	or h			;8730
	ld (0e190h),a		;8731
	ret			;8734
E190_CERO:		; E190 = 0
	xor a			;8735
	ld (0e190h),a		;8736
	ret			;8739
SONIDO_46_Y_CANALES:		; sonido 0x46 si un jugador y 0x8744
	ld a,(0e1c2h)		;873a
	bit 5,a		;873d
	ld a,046h		;873f
	call z,04174h		;8741
CANALES_JUGADOR_FUERA:		; E190 &= 0 (un jugador), 0x0F o 0xF0 segun el jugador (ix+9)
	ld a,(0e1c2h)		;8744
	bit 5,a		;8747
	jr nz,CANALES_MASCARA_2J		;8749
	ld a,000h		;874b
	jr CANALES_AND		;874d
CANALES_MASCARA_2J:		; 0x0F (jugador 2 fuera) o 0xF0
	bit 0,(iy+009h)		;874f
	ld a,00fh		;8753
	jr z,CANALES_AND		;8755
	ld a,0f0h		;8757
CANALES_AND:		; E190 &= A
	ld hl,0e190h		;8759
	and (hl)			;875c
	ld (hl),a			;875d
	ret			;875e
L_875F:
	xor a			;875f
	jr L_8764		;8760
E21A_UNO:		; E21A = 1, (E217) = 0 (desde p00 0x59B1)
	ld a,001h		;8762
L_8764:
	ld (0e21ah),a		;8764
	ld hl,00000h		;8767
	ld (0e217h),hl		;876a
	ret			;876d
SONIDO_CARRERA:		; F0FB pendiente (0x87D0), volumen del motor de cada coche (0x877D); si E21A: musica (0x880B)
	call SONIDO_F0FB		;876e
	call VOLUMEN_MOTORES		;8771
	ld a,(0e21ah)		;8774
	or a			;8777
	ret z			;8778
	call MUSICA_PENDIENTE		;8779
	ret			;877c
VOLUMEN_MOTORES:		; E197 = volumen del coche 1 (0x879A), E198 = del 2; (ix-1C) = 0
	ld ix,0e2c0h		;877d
	call VOLUMEN_MOTOR		;8781
	ld (0e197h),a		;8784
	ld (ix-01ch),000h		;8787
	ld ix,0e380h		;878b
	call VOLUMEN_MOTOR		;878f
	ld (0e198h),a		;8792
	ld (ix-01ch),000h		;8795
	ret			;8799
VOLUMEN_MOTOR:		; (ix-1C) != 0 -> objetivo 0xFF; si no 0x0A si (ix+12) en -16..15, si no 0xA0; (ix-1B) sube 15 o baja 2 hacia el objetivo; A = (ix-1B)
	ld a,(ix-01ch)		;879a
	and a			;879d
	jr z,VOLUMEN_OBJETIVO		;879e
	ld d,0ffh		;87a0
	ld (ix-01bh),0ffh		;87a2
	jr VOLUMEN_ACERCA		;87a6
VOLUMEN_OBJETIVO:		; por la aceleracion (ix+12)
	ld a,(ix+012h)		;87a8
	add a,010h		;87ab
	cp 020h		;87ad
	jr nc,VOLUMEN_A0		;87af
	ld d,00ah		;87b1
	jr VOLUMEN_ACERCA		;87b3
VOLUMEN_A0:		; D = 0xA0
	ld d,0a0h		;87b5
VOLUMEN_ACERCA:		; (ix-1B) hacia D
	ld a,(ix-01bh)		;87b7
	cp d			;87ba
	jr c,VOLUMEN_SUBE		;87bb
	sub 002h		;87bd
	jr nc,VOLUMEN_GUARDA_BAJA		;87bf
	xor a			;87c1
VOLUMEN_GUARDA_BAJA:		; (ix-1B) = A
	ld (ix-01bh),a		;87c2
	ret			;87c5
VOLUMEN_SUBE:		; += 15, tope 0xFF
	add a,00fh		;87c6
	jr nc,VOLUMEN_GUARDA_SUBE		;87c8
	ld a,0ffh		;87ca
VOLUMEN_GUARDA_SUBE:		; (ix-1B) = A
	ld (ix-01bh),a		;87cc
	ret			;87cf
SONIDO_F0FB:		; si F0FB != 0: ENCOLA_SONIDO F0FB y F0FB = 0
	ld a,(0f0fbh)		;87d0
	or a			;87d3
	ret z			;87d4
	call 04174h		;87d5
	xor a			;87d8
	ld (0f0fbh),a		;87d9
	ret			;87dc
L_87DD:
	ld a,046h		;87dd
	jp 04174h		;87df
MUSICA_CARRERA:		; sonido 0x80, espera la interrupcion, E217 = 1, E218 = 0, E20A = 1 y la musica de la categoria (tabla 0x8804) (desde p01 0x7ED3)
	ld a,080h		;87e2
	call 04174h		;87e4
	call ESPERA_INTERRUPCION		;87e7
	ld hl,0e217h		;87ea
	ld (hl),001h		;87ed
	inc hl			;87ef
	ld (hl),000h		;87f0
	ld a,001h		;87f2
	ld (0e20ah),a		;87f4
	ld a,(0e25bh)		;87f7
	ld hl,08804h		;87fa
	call 040d0h		;87fd
	ld a,(hl)			;8800
	jp 04174h		;8801

; ----------------------------------------------------------------------
; DATOS tabla_musica_carrera: 7 numeros de sonido por E25B: 0x41, 0x36, 0x43,
;   0x36, 0x37, 0x38, 0x36
;   0x8804..0x880b  (7 bytes)
DATA_tabla_musica_carrera:
	defb 041h,036h,043h,036h,037h,038h,036h	; 8804

; ======================================================================
; CODIGO 0x880b..0x883f  (52 bytes)
; ======================================================================


MUSICA_PENDIENTE:		; cada 8 fotogramas: si E217 = 0 y E218 > 0: E218-- y a cero la musica (0x881D)
	ld a,(0e1c3h)		;880b
	and 007h		;880e
	ret nz			;8810
	ld hl,0e217h		;8811
	ld a,(hl)			;8814
	or a			;8815
	ret nz			;8816
	inc hl			;8817
	ld a,(hl)			;8818
	or a			;8819
	ret z			;881a
	dec (hl)			;881b
	ret nz			;881c
MUSICA_CARRERA_B:		; como 0x87E2 con la tabla 0x883F (desde p00 0x50A3)
	ld a,080h		;881d
	call 04174h		;881f
	call ESPERA_INTERRUPCION		;8822
	ld hl,0e217h		;8825
	ld (hl),001h		;8828
	inc hl			;882a
	ld (hl),000h		;882b
	ld a,001h		;882d
	ld (0e20ah),a		;882f
	ld a,(0e25bh)		;8832
	ld hl,0883fh		;8835
	call 040d0h		;8838
	ld a,(hl)			;883b
	jp 04174h		;883c

; ----------------------------------------------------------------------
; DATOS tabla_musica_carrera_b: 7 numeros de sonido por E25B: 0x42, 0x39,
;   0x44, 0x39, 0x3A, 0x3B, 0x39
;   0x883f..0x8846  (7 bytes)
DATA_tabla_musica_carrera_b:
	defb 042h,039h,044h,039h,03ah,03bh,039h	; 883f

; ======================================================================
; CODIGO 0x8846..0x88d7  (145 bytes)
; ======================================================================


L_8846:
	call E20A_CERO		;8846
	jp 04174h		;8849
MUSICA_A:		; E20A = 0 y ENCOLA_SONIDO A (desde p00 0x424B, 0x5A88, 0x5D13)
	call E20A_CERO		;884c
	jp 04174h		;884f
E20A_CERO:		; E20A = 0
	push hl			;8852
	ld hl,0e20ah		;8853
	ld (hl),000h		;8856
	pop hl			;8858
	ret			;8859
L_885A:
	ld a,(0e1c2h)		;885a
	bit 5,a		;885d
	jr z,L_8873		;885f
	ld a,(0e31dh)		;8861
	cp 003h		;8864
	rl d		;8866
	ld a,(0e3ddh)		;8868
	cp 003h		;886b
	rl d		;886d
	ld a,d			;886f
	and 003h		;8870
	ret			;8872
L_8873:
	ld a,(0e31dh)		;8873
	cp 003h		;8876
	sbc a,a			;8878
	ret			;8879
INICIA_COCHES:		; coche 1: 0x88B8, jugador 1, patron 0, (ix+61) = 0x50, (ix+30) = 4; coche 2: jugador 2, patron 8; E199 = E19C = E19E = E1A1 = 0x0FFF
	ld ix,0e2c0h		;887a
	call INICIA_COCHE		;887e
	ld (ix+009h),001h		;8881
	ld (ix+033h),000h		;8885
	ld (ix+061h),050h		;8889
	ld (ix+030h),004h		;888d
	ld ix,0e380h		;8891
	call INICIA_COCHE		;8895
	ld (ix+009h),002h		;8898
	ld (ix+033h),008h		;889c
	ld (ix+061h),050h		;88a0
	ld (ix+030h),004h		;88a4
	ld hl,00fffh		;88a8
	ld (0e199h),hl		;88ab
	ld (0e19ch),hl		;88ae
	ld (0e19eh),hl		;88b1
	ld (0e1a1h),hl		;88b4
	ret			;88b7
INICIA_COCHE:		; 0x90 bytes desde ix-0x20 a cero; (ix-1E) = 0; combustible (ix+50) = 0xFF; (ix+49) = 0; 0x8943
	push ix		;88b8
	pop hl			;88ba
	ld de,0ffe0h		;88bb
	add hl,de			;88be
	ld bc,00090h		;88bf
	call 04b87h		;88c2
	push ix		;88c5
	pop de			;88c7
	ld (ix-01eh),000h		;88c8
	ld (ix+050h),0ffh		;88cc
	ld (ix+049h),000h		;88d0
	jp PARAMETROS_COCHE		;88d4

; ----------------------------------------------------------------------
; DATOS tabla_color_carroceria: un color de sprite por carroceria (18):
;   (ix+0F) en p02 0x898E; las 18 salen de los pasos 2 de la tabla de eleccion
;   p03 0xBC45
;   0x88d7..0x88e9  (18 bytes)
DATA_tabla_color_carroceria:
	defb 007h,00fh,00bh,008h,005h,00ah,007h,002h,008h,008h,002h,005h,005h,008h,007h,008h,005h,00ah	; 88d7  ..................

; ----------------------------------------------------------------------
; DATOS tabla_88e9: un byte por carroceria (18) -> (ix-21) en p02 0x89AA
;   0x88e9..0x88fb  (18 bytes)
DATA_tabla_88e9:
	defb 010h,00ah,006h,00ch,00ah,005h,008h,005h,003h,008h,005h,003h,008h,005h,003h,008h,005h,003h	; 88e9  ..................

; ----------------------------------------------------------------------
; DATOS tabla_motor: una palabra por motor (36) -> (ix-20,-1F) en p02 0x899B;
;   los 36 motores son los valores del paso 1 de p03 0xBC45, 6 por categoria,
;   y los de cada categoria comparten el byte alto (RALLY 09, STOCK 0A,
;   ENDURANCE 0D, F3 0D, F3000 0E, F1 0F)
;   0x88fb..0x8943  (72 bytes)
DATA_tabla_motor:
	defw 00db0h,00da0h,00dc0h,00dd0h,00df0h,00de0h	; 88fb
	defw 00ab0h,00aa0h,00ac0h,00ad0h,00af0h,00ae0h	; 8907
	defw 009b0h,009a0h,009c0h,009d0h,009f0h,009e0h	; 8913
	defw 00db8h,00da8h,00dc8h,00dd8h,00df8h,00df8h	; 891f
	defw 00eb0h,00ea0h,00ec0h,00ed0h,00ef0h,00ee0h	; 892b
	defw 00fb0h,00fa0h,00fc0h,00fd0h,00ff0h,00fe0h	; 8937

; ======================================================================
; CODIGO 0x8943..0x8b12  (463 bytes)
; ======================================================================


PARAMETROS_COCHE:		; (ix+15) = 0x3C, x = y = 0x80, (ix+5C) = 0x20, estado 0, angulo 0, fotograma 2, (ix+3E) = 3; los 5 bytes de ix-0x29: (ix+74) motor, (ix+18) carroceria, (ix+77), (ix+76), (ix+75) = byte & 0x7F (bit 7 -> (ix+70) = 1); color (ix+F) = 0x88D7[carroceria]; (ix-20,-1F) = 0x88FB[motor]; (ix-21) = 0x88E9[carroceria]; tope de revoluciones (ix+72) = 4*C+1 con el primer C cuyo 0x9C1F da 0
	ld (ix+015h),03ch		;8943
	ld (ix+004h),080h		;8947
	ld (ix+006h),080h		;894b
	ld (ix+05ch),020h		;894f
	ld (ix+05dh),000h		;8953
	ld (ix+00ch),000h		;8957
	ld (ix+00eh),002h		;895b
	ld (ix+03eh),003h		;895f
	push ix		;8963
	pop hl			;8965
	ld de,0ffd7h		;8966
	add hl,de			;8969
	ld a,(hl)			;896a
	inc hl			;896b
	ld (ix+074h),a		;896c
	ld a,(hl)			;896f
	inc hl			;8970
	ld (ix+018h),a		;8971
	ld a,(hl)			;8974
	inc hl			;8975
	ld (ix+077h),a		;8976
	ld a,(hl)			;8979
	inc hl			;897a
	ld (ix+076h),a		;897b
	ld b,(hl)			;897e
	inc hl			;897f
	ld a,b			;8980
	and 07fh		;8981
	ld (ix+075h),a		;8983
	bit 7,b		;8986
	jr z,PARAMETROS_TABLAS		;8988
	ld (ix+070h),001h		;898a
PARAMETROS_TABLAS:		; las tablas por carroceria y motor
	ld a,(ix+018h)		;898e
	ld hl,088d7h		;8991
	call 040d0h		;8994
	ld a,(hl)			;8997
	ld (ix+00fh),a		;8998
	ld a,(ix+074h)		;899b
	ld hl,088fbh		;899e
	call 04a44h		;89a1
	ld (ix-020h),l		;89a4
	ld (ix-01fh),h		;89a7
	ld a,(ix+018h)		;89aa
	ld hl,088e9h		;89ad
	call 040d0h		;89b0
	ld a,(hl)			;89b3
	ld (ix-021h),a		;89b4
	ld bc,02000h		;89b7
TOPE_REVS_BUCLE:		; prueba C = 1..0x20 en 0x9C1F (p09 0xB72E)
	inc c			;89ba
	push bc			;89bb
	ld a,c			;89bc
	add a,a			;89bd
	add a,a			;89be
	ld l,(ix+074h)		;89bf
	call PAR_MOTOR_INDICE		;89c2
	or a			;89c5
	pop bc			;89c6
	jr z,TOPE_REVS_GUARDA		;89c7
	djnz TOPE_REVS_BUCLE		;89c9
TOPE_REVS_GUARDA:		; (ix+72) = 4*C + 1
	ld a,c			;89cb
	add a,a			;89cc
	add a,a			;89cd
	inc a			;89ce
	ld (ix+072h),a		;89cf
	ret			;89d2
COCHE_SIGUE_OBJETO:		; (ix+4,6,7,8) copiados de/al objeto E800 (repeticion) y 0x8D21
	ld a,(ix+004h)		;89d3
	ld (0e804h),a		;89d6
	ld a,(0e806h)		;89d9
	ld (ix+006h),a		;89dc
	ld de,(0e807h)		;89df
	ld (ix+008h),d		;89e3
	ld (ix+007h),e		;89e6
	jp AVANCE_PISTA		;89e9
COCHE_JUGADOR:		; coche 1 (0x8A75); E199 = filtro de (ix+59) (0x8A56); E19C = frecuencia (0x8A4C, 0x8717); E19B = 1 si el terreno (ix+22) < 10; lo mismo para el coche 2 (E19E, E1A1, E1A0) si hay dos jugadores
	ld ix,0e2c0h		;89ec
	ld iy,0e2c0h		;89f0
	call COCHE_PASO		;89f4
	ld a,(ix+059h)		;89f7
	ld hl,(0e199h)		;89fa
	call FILTRA_REVS		;89fd
	ld (0e199h),hl		;8a00
	call REVS_MENOS_TOPE		;8a03
	call REVS_A_FRECUENCIA		;8a06
	ld (0e19ch),hl		;8a09
	ld a,(ix+022h)		;8a0c
	cp 00ah		;8a0f
	ld a,001h		;8a11
	jr c,COCHE_1_E19B		;8a13
	xor a			;8a15
COCHE_1_E19B:		; E19B = A
	ld (0e19bh),a		;8a16
	ld ix,0e380h		;8a19
	ld iy,0e380h		;8a1d
	ld hl,0e1c2h		;8a21
	bit 5,(hl)		;8a24
	call nz,COCHE_PASO		;8a26
	ld a,(ix+059h)		;8a29
	ld hl,(0e19eh)		;8a2c
	call FILTRA_REVS		;8a2f
	ld (0e19eh),hl		;8a32
	call REVS_MENOS_TOPE		;8a35
	call REVS_A_FRECUENCIA_B		;8a38
	ld (0e1a1h),hl		;8a3b
	ld a,(ix+022h)		;8a3e
	cp 00ah		;8a41
	ld a,001h		;8a43
	jr c,COCHE_2_E1A0		;8a45
	xor a			;8a47
COCHE_2_E1A0:		; E1A0 = A
	ld (0e1a0h),a		;8a48
	ret			;8a4b
REVS_MENOS_TOPE:		; HL = (ix+72)*256 - HL
	ld e,000h		;8a4c
	ld d,(ix+072h)		;8a4e
	or a			;8a51
	ex de,hl			;8a52
	sbc hl,de		;8a53
	ret			;8a55
FILTRA_REVS:		; A = min(A, 0x7F); HL = (3*HL + A*256) / 4 (filtro hacia A)
	cp 080h		;8a56
	jr c,FILTRA_REVS_VA		;8a58
	ld a,07fh		;8a5a
FILTRA_REVS_VA:		; el calculo
	ld b,a			;8a5c
	ld c,000h		;8a5d
	ld d,h			;8a5f
	ld e,l			;8a60
	sub a			;8a61
	add hl,hl			;8a62
	adc a,c			;8a63
	add hl,de			;8a64
	adc a,c			;8a65
	add hl,bc			;8a66
	adc a,c			;8a67
	rr a		;8a68
	rr h		;8a6a
	rr l		;8a6c
	rr a		;8a6e
	rr h		;8a70
	rr l		;8a72
	ret			;8a74
COCHE_PASO:		; estado (0x8B0C), p03 0xB5D3, 0x8CCC, p00 0x54D4, mando (0x8A8B); (ix+19) = (ix+22)
	call ESTADO_COCHE		;8a75
	call 0b5d3h		;8a78
	call TERRENO_P03		;8a7b
	call 054d4h		;8a7e
	call MANDO_COCHE		;8a81
	ld a,(ix+022h)		;8a84
	ld (ix+019h),a		;8a87
	ret			;8a8a
MANDO_COCHE:		; (ix+3A) = flancos de (ix+1) respecto a (ix+3B); 0x8AA2; bit 0 de (ix+1) = 0
	ld b,(ix+001h)		;8a8b
	ld a,b			;8a8e
	xor (ix+03bh)		;8a8f
	and b			;8a92
	ld c,a			;8a93
	ld (ix+03ah),a		;8a94
	ld (ix+03bh),b		;8a97
	call MANDO_SONIDOS		;8a9a
	res 0,(ix+001h)		;8a9d
	ret			;8aa1
MANDO_SONIDOS:		; canal del motor (0x86D0); terreno 8/9 -> sonido 0x1B si antes no (0x8AF9); estado < 3: bits 0/6/7 de (ix+1) (fuera de pista, derrape) -> FFE3++ y sonidos 0x15 (bit 0 nuevo), 0x0F (bit 6), 0x0C/0x0E (bit 7, cada 4)
	push bc			;8aa2
	call CANAL_MOTOR		;8aa3
	ld a,(ix+022h)		;8aa6
	sub 008h		;8aa9
	cp 002h		;8aab
	call c,SONIDO_TERRENO_1B		;8aad
	pop bc			;8ab0
	ld a,(ix+05dh)		;8ab1
	cp 003h		;8ab4
	ret nc			;8ab6
	ld a,0c1h		;8ab7
	and b			;8ab9
	jr z,FFE3_FF		;8aba
	set 0,(ix-01ch)		;8abc
	ld hl,0ffe3h		;8ac0
	inc (hl)			;8ac3
	bit 0,c		;8ac4
	jr nz,SONIDO_15		;8ac6
	bit 6,b		;8ac8
	jr nz,SONIDO_0F_CADA_4		;8aca
	bit 7,b		;8acc
	ret z			;8ace
	ld a,(0ffe3h)		;8acf
	and 003h		;8ad2
	ret nz			;8ad4
	ld a,(0e25bh)		;8ad5
	or a			;8ad8
	jr nz,SONIDO_0C		;8ad9
	ld a,(ix+022h)		;8adb
	cp 00ah		;8ade
	ld a,00eh		;8ae0
	jr nz,SONIDO_A		;8ae2
SONIDO_0C:		; 0x0C
	ld a,00ch		;8ae4
SONIDO_A:		; ENCOLA_SONIDO A
	jp 04174h		;8ae6
SONIDO_0F_CADA_4:		; bit 6: sonido 0x0F cada 4
	ld a,(0ffe3h)		;8ae9
	and 003h		;8aec
	ret nz			;8aee
	ld a,00fh		;8aef
	jp SONIDO_JUGADOR_B		;8af1
SONIDO_15:		; bit 0 nuevo: sonido 0x15 + jugador
	ld a,015h		;8af4
	jp SONIDO_JUGADOR_B		;8af6
SONIDO_TERRENO_1B:		; si el terreno anterior (ix+19) no era 8/9: sonido 0x1B + jugador
	ld a,(ix+019h)		;8af9
	sub 008h		;8afc
	cp 002h		;8afe
	ret c			;8b00
	ld a,01bh		;8b01
	jp SONIDO_JUGADOR		;8b03
FFE3_FF:		; FFE3 = 0xFF
	ld hl,0ffe3h		;8b06
	ld (hl),0ffh		;8b09
	ret			;8b0b
ESTADO_COCHE:		; despacha por (ix+5D) con la tabla 0x8B12: 0 normal 0x8C70, 1 entra en boxes 0x8C04, 2 en boxes 0x8D65, 3 meta 0x8C21, 4 choque 0x8D88, 5 tras el choque 0x8E0B, 6 parado 0x8E1E, 7 reaparece 0x8B26, 8 0x8B50, 9 0x8B6A
	ld a,(ix+05dh)		;8b0c
	call 040dah		;8b0f

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (20 bytes)
;   0x8b12..0x8b26  (20 bytes)
DATA_8B12:
	defb 070h,08ch,004h,08ch,065h,08dh,021h,08ch,088h,08dh,00bh,08eh,01eh,08eh,026h,08bh	; 8b12  p...e.!.......&.
	defb 050h,08bh,06ah,08bh	; 8b22

; ======================================================================
; CODIGO 0x8b26..0x8ece  (936 bytes)
; ======================================================================


COCHE_ESTADO_7:		; reinicia los parametros (0x8943), (ix+5C) = 0, sin sprite, estado 8, velocidad/vx/vy/aceleracion a cero, (ix+38) = 10
	call PARAMETROS_COCHE		;8b26
	ld (ix+05ch),000h		;8b29
	set 7,(ix+031h)		;8b2d
	ld (ix+05dh),008h		;8b31
	xor a			;8b35
	ld (ix+010h),a		;8b36
	ld (ix+011h),a		;8b39
	ld (ix+008h),a		;8b3c
	ld (ix+007h),a		;8b3f
	ld (ix+00bh),a		;8b42
	ld (ix+00ah),a		;8b45
	ld (ix+012h),a		;8b48
	ld (ix+038h),00ah		;8b4b
	ret			;8b4f
COCHE_ESTADO_8:		; 10 fotogramas sin sprite; luego (ix-1) = (ix+1) = 0, estado 9, (ix-3) = 0 y FOTOGRAMAS_COCHES (p00 0x4689)
	dec (ix+038h)		;8b50
	set 7,(ix+031h)		;8b53
	ret nz			;8b57
	xor a			;8b58
	ld (ix-001h),a		;8b59
	ld (ix+001h),a		;8b5c
	ld (ix+05dh),009h		;8b5f
	ld (ix-003h),000h		;8b63
	jp 04689h		;8b67
COCHE_ESTADO_9:		; (ix+38)-- (a cero: estado 6, 0x8E17); avanza 8 px (0x8BD2) hasta que el terreno bajo el coche (0x9550) sea 9..14; luego hasta que deje de serlo; si el tile es 0xB5 avanza otro; (ix-1) = 0, sin sprite, (ix+1) &= 2, estado 0, (ix-1E) = 1, marcha 0, canales de boxes; (ix+55) = 1 si E240 = 0
	dec (ix+038h)		;8b6a
	jp z,COCHE_ESTADO_9_FIN		;8b6d
	call AVANZA_8_PX		;8b70
	call TERRENO_BAJO_COCHE		;8b73
	sub 009h		;8b76
	cp 006h		;8b78
	jr c,COCHE_ESTADO_9		;8b7a
COCHE_ESTADO_9_BUSCA:		; avanza mientras el terreno no sea 9..14
	call AVANZA_8_PX		;8b7c
	dec (ix+038h)		;8b7f
	jp z,COCHE_ESTADO_9_FIN		;8b82
	call TERRENO_BAJO_COCHE		;8b85
	sub 009h		;8b88
	cp 006h		;8b8a
	jr nc,COCHE_ESTADO_9_BUSCA		;8b8c
	bit 7,(ix+038h)		;8b8e
	jr z,COCHE_ESTADO_9_COLOCA		;8b92
	call AVANZA_8_PX		;8b94
	call TERRENO_BAJO_COCHE		;8b97
	sub 009h		;8b9a
	cp 006h		;8b9c
	jr nc,COCHE_ESTADO_9_BUSCA		;8b9e
COCHE_ESTADO_9_COLOCA:		; reaparece en la pista
	call TERRENO_BAJO_COCHE		;8ba0
	ld a,(hl)			;8ba3
	cp 0b5h		;8ba4
	call z,AVANZA_8_PX		;8ba6
	xor a			;8ba9
	ld (ix-001h),a		;8baa
	set 7,(ix+031h)		;8bad
	ld a,(ix+001h)		;8bb1
	and 002h		;8bb4
	ld (ix+001h),a		;8bb6
	ld (ix+05dh),000h		;8bb9
	ld (ix-01eh),001h		;8bbd
	ld (ix+069h),000h		;8bc1
	call CANALES_BOXES		;8bc5
	ld a,(0e240h)		;8bc8
	or a			;8bcb
	ret nz			;8bcc
	ld (ix+055h),001h		;8bcd
	ret			;8bd1
AVANZA_8_PX:		; (ix+54) += 8 -> (ix+4B) (camara) y (ix+6) = (ix+54) + E1FE
	ld a,008h		;8bd2
	add a,(ix+054h)		;8bd4
	ld (ix+054h),a		;8bd7
	ld (ix+04bh),a		;8bda
	ld hl,0e1feh		;8bdd
	add a,(hl)			;8be0
	ld (ix+006h),a		;8be1
	ret			;8be4
REVS_POR_BOTON:		; (ix+59) = (ix+72) si el boton del jugador esta pulsado, si no 0; marcha 0
	bit 0,(ix+009h)		;8be5
	ld a,(0e1c9h)		;8be9
	jr nz,REVS_POR_BOTON_BIT		;8bec
	ld a,(0e1cch)		;8bee
REVS_POR_BOTON_BIT:		; bit 4
	bit 4,a		;8bf1
	ld a,000h		;8bf3
	jr z,REVS_GUARDA		;8bf5
	ld a,(ix+072h)		;8bf7
	sub 000h		;8bfa
REVS_GUARDA:		; (ix+59) = A, (ix+69) = 0
	ld (ix+059h),a		;8bfc
	ld (ix+069h),000h		;8bff
	ret			;8c03
COCHE_ESTADO_1:		; entra en boxes: p01 0x7886, marcha 0; un jugador: E250 = 0x0C y estado 0; dos: estado 2
	call 07886h		;8c04
	ld (ix+069h),000h		;8c07
	ld a,(0e1c2h)		;8c0b
	bit 5,a		;8c0e
	jr nz,COCHE_ESTADO_1_2J		;8c10
	ld a,00ch		;8c12
	ld (0e250h),a		;8c14
	ld (ix+05dh),000h		;8c17
	ret			;8c1b
COCHE_ESTADO_1_2J:		; estado 2
	ld (ix+05dh),002h		;8c1c
	ret			;8c20
COCHE_ESTADO_3:		; meta: angulo 0, aceleracion 0x10, 0x8CC1; (ix+43,44) -= p00 0x4A8A de si mismo (frena el avance); x (0x9D89); cuando x < 0x10: estado 6, avance y velocidad a cero, x = 0xE0, y = 0xFF
	ld (ix+00ch),000h		;8c21
	ld (ix+012h),010h		;8c25
	call FISICA_COCHE		;8c29
	ld l,(ix+043h)		;8c2c
	ld h,(ix+044h)		;8c2f
	ld e,l			;8c32
	ld d,h			;8c33
	call 04a8ah		;8c34
	ex de,hl			;8c37
	or a			;8c38
	sbc hl,de		;8c39
	ld (ix+043h),l		;8c3b
	ld (ix+044h),h		;8c3e
	call MUEVE_X		;8c41
	ld a,(ix+004h)		;8c44
	cp 010h		;8c47
	ret nc			;8c49
	ld (ix+05dh),006h		;8c4a
	xor a			;8c4e
	ld (ix+043h),a		;8c4f
	ld (ix+044h),a		;8c52
	ld (ix+010h),a		;8c55
	ld (ix+011h),a		;8c58
	ld (ix+004h),0e0h		;8c5b
	ld (ix+006h),0ffh		;8c5f
	ret			;8c63
L_8C64:
	ld (ix+013h),000h		;8c64
	ld (ix+012h),0e0h		;8c68
	call FISICA_COCHE		;8c6c
	ret			;8c6f
COCHE_ESTADO_0:		; normal: repeticion (E244 = 2) -> 0x89D3; si no: boxes/combustible (0x8E52), volante (0x92A0), marchas (0x8F66), acelerador (0x8FD4), neumaticos (0x8F11), mando en la salida (E221 < 7: 0x8D11), derrape (0x8CE0), fisica (0x8CC1), avance (0x8D21), posicion (0x8D5F); choque (bit 3 de ix+1): estado 4, (ix+38) = 0, objeto 0x0F en (x, y) (0x9FCC) y sonido 0x2C
	or a			;8c70
	scf			;8c71
	jp nc,COCHE_SIGUE_OBJETO		;8c72
	call BOXES_Y_COMBUSTIBLE		;8c75
	call VOLANTE		;8c78
	call MARCHAS		;8c7b
	call ACELERADOR		;8c7e
	bit 0,(ix+05eh)		;8c81
	jr z,COCHE_ESTADO_0_SIGUE		;8c85
	ld (ix+012h),000h		;8c87
COCHE_ESTADO_0_SIGUE:		; tras el acelerador
	call NEUMATICOS_EFECTO		;8c8b
	ld a,(0e221h)		;8c8e
	cp 007h		;8c91
	call c,MANDO_SALIDA		;8c93
	call DERRAPE		;8c96
	call FISICA_COCHE		;8c99
	call AVANCE_PISTA		;8c9c
	call POSICION_COCHE		;8c9f
COCHE_CHOCA:		; bit 3 de (ix+1): estado 4, explosion (0x9FCC con A = 0x0F) y sonido 0x2C (0x86B1)
	bit 3,(ix+001h)		;8ca2
	ret z			;8ca6
	ld (ix+05dh),004h		;8ca7
	ld (ix+038h),000h		;8cab
	ld e,(ix+004h)		;8caf
	ld d,(ix+006h)		;8cb2
	ld a,00fh		;8cb5
	push ix		;8cb7
	call CREA_OBJETO_EN		;8cb9
	pop ix		;8cbc
	jp SONIDO_2C_JUGADOR		;8cbe
FISICA_COCHE:		; 0x9408 y, si (ix+0) != 0 (hipotesis: un objeto), frenada por categoria (0x94B4)
	call FISICA_COCHE_JUGADOR		;8cc1
	ld a,(ix+000h)		;8cc4
	or a			;8cc7
	ret z			;8cc8
	jp FRENADA_CATEGORIA		;8cc9
TERRENO_P03:		; p03 0xB34F; si C, (ix-1A) = A
	call 0b34fh		;8ccc
	ret nc			;8ccf
	ld (ix-01ah),a		;8cd0
	ret			;8cd3
L_8CD4:
	bit 0,(ix+009h)		;8cd4
	ld hl,0e380h		;8cd8
	ret nz			;8cdb
	ld hl,0e2c0h		;8cdc
	ret			;8cdf
DERRAPE:		; bit 6 de (ix+1): angulo += (ix+39), bit 7; sale del derrape (bits 6/7 fuera) si el angulo vuelve a -0x20..0x20 y la velocidad o el volante lo permiten
	bit 6,(ix+001h)		;8ce0
	ret z			;8ce4
	ld a,(ix+039h)		;8ce5
	add a,(ix+00ch)		;8ce8
	ld (ix+00ch),a		;8ceb
	set 7,(ix+001h)		;8cee
	add a,020h		;8cf2
	cp 041h		;8cf4
	ret nc			;8cf6
	ld a,(ix+008h)		;8cf7
	add a,004h		;8cfa
	cp 009h		;8cfc
	jr c,DERRAPE_FIN		;8cfe
	ld b,(ix+039h)		;8d00
	ld a,(ix+013h)		;8d03
	xor b			;8d06
	ret p			;8d07
DERRAPE_FIN:		; bits 6 y 7 de (ix+1) fuera
	res 6,(ix+001h)		;8d08
	res 7,(ix+001h)		;8d0c
	ret			;8d10
MANDO_SALIDA:		; antes de la salida: revoluciones por el boton (0x8BE5), aceleracion 0, angulo 0, (ix-1C) = 0xFF
	call REVS_POR_BOTON		;8d11
	ld (ix+012h),000h		;8d14
	ld (ix+00ch),000h		;8d18
	ld (ix-01ch),0ffh		;8d1c
	ret			;8d20
AVANCE_PISTA:		; D = 0x80; 0x8D23
	ld d,080h		;8d21
AVANCE_PISTA_D:		; si (ix-1E) != 0: HL = p00 0x4A86(((ix+4) - D)/2); si no HL = 0; (ix+43,44) = max(0, min(0x1500, HL + vx (ix+7,8)))
	ld a,(ix-01eh)		;8d23
	or a			;8d26
	jr z,AVANCE_CERO		;8d27
	ld a,(ix+004h)		;8d29
	sub d			;8d2c
	rra			;8d2d
	ld h,a			;8d2e
	sbc a,a			;8d2f
	and 080h		;8d30
	ld l,a			;8d32
	call 04a86h		;8d33
	jr AVANCE_SUMA_VX		;8d36
L_8D38:
	ld hl,00000h		;8d38
AVANCE_SUMA_VX:		; HL += vx; negativo -> 0; > 0x1500 -> 0x1500
	ld e,(ix+007h)		;8d3b
	ld d,(ix+008h)		;8d3e
	ex de,hl			;8d41
	add hl,de			;8d42
	ex de,hl			;8d43
	ld hl,00000h		;8d44
	or a			;8d47
	sbc hl,de		;8d48
	jp p,AVANCE_TOPE		;8d4a
AVANCE_CERO:		; HL = 0
	ld hl,00000h		;8d4d
AVANCE_TOPE:		; tope 0x1500
	ld a,015h		;8d50
	cp h			;8d52
	jr nc,AVANCE_GUARDA		;8d53
	ld hl,01500h		;8d55
AVANCE_GUARDA:		; (ix+43,44) = HL
	ld (ix+043h),l		;8d58
	ld (ix+044h),h		;8d5b
	ret			;8d5e
POSICION_COCHE:		; x (0x9D89) y y (0x9AFE)
	call MUEVE_X		;8d5f
	jp AVANZA_Y		;8d62
COCHE_ESTADO_2:		; en boxes (p01 0x788F): al salir (C) estado 0 y 0x8CA2
	call 0788fh		;8d65
	ret nc			;8d68
	ld (ix+05dh),000h		;8d69
	jp COCHE_CHOCA		;8d6d
GUARDA_TIEMPO:		; (ix+4D..4F) = cronometro E210..E212; (ix+16) = x
	ld hl,0e210h		;8d70
	ld a,(hl)			;8d73
	ld (ix+04dh),a		;8d74
	inc hl			;8d77
	ld a,(hl)			;8d78
	ld (ix+04eh),a		;8d79
	inc hl			;8d7c
	ld a,(hl)			;8d7d
	ld (ix+04fh),a		;8d7e
	ld a,(ix+004h)		;8d81
	ld (ix+016h),a		;8d84
	ret			;8d87
COCHE_ESTADO_4:		; choque: bit 6 de (ix-1) = bit 7; fotograma (0x9A01); frena vx/vy (0x8DD1); (ix+38)++ hasta 0xFF; avance por D = 0x80 - (ix+38)/... (0x8D23); posicion; marchas; a los 0x5A fotogramas: p00 0x54DF, avance 0, estado 5, (ix+38) = 10
	ld a,(ix-001h)		;8d88
	ld c,a			;8d8b
	rr a		;8d8c
	and 040h		;8d8e
	or c			;8d90
	ld (ix-001h),a		;8d91
	call FOTOGRAMA_COCHE		;8d94
	call FRENA_VX_VY		;8d97
	ld a,(ix+038h)		;8d9a
	inc a			;8d9d
	jr z,CHOQUE_AVANCE		;8d9e
	ld (ix+038h),a		;8da0
CHOQUE_AVANCE:		; D = min(0x60, 0x60 - A) + 0x20
	neg		;8da3
	add a,060h		;8da5
	jr c,CHOQUE_AVANCE_D		;8da7
	ld a,060h		;8da9
CHOQUE_AVANCE_D:		; D = A + 0x20
	add a,020h		;8dab
	ld d,a			;8dad
	call AVANCE_PISTA_D		;8dae
	call MUEVE_X		;8db1
	call MARCHAS		;8db4
	ld a,(ix+038h)		;8db7
	cp 05ah		;8dba
	ret c			;8dbc
	call 054dfh		;8dbd
	ld (ix+043h),000h		;8dc0
	ld (ix+044h),000h		;8dc4
	ld (ix+05dh),005h		;8dc8
	ld (ix+038h),00ah		;8dcc
	ret			;8dd0
FRENA_VX_VY:		; vy -= vy/8 (p00 0x4A7E), vx -= vx/8; a cero si el byte alto se anula
	ld h,(ix+00bh)		;8dd1
	ld l,(ix+00ah)		;8dd4
	ld d,h			;8dd7
	ld e,l			;8dd8
	call 04a7eh		;8dd9
	ex de,hl			;8ddc
	or a			;8ddd
	sbc hl,de		;8dde
	ld a,h			;8de0
	or a			;8de1
	jr nz,FRENA_VX		;8de2
	ld hl,00000h		;8de4
FRENA_VX:		; la parte de vx
	ld (ix+00bh),h		;8de7
	ld (ix+00ah),l		;8dea
	ld h,(ix+008h)		;8ded
	ld l,(ix+007h)		;8df0
	add hl,de			;8df3
	ld d,h			;8df4
	ld e,l			;8df5
	call 04a7eh		;8df6
	ex de,hl			;8df9
	or a			;8dfa
	sbc hl,de		;8dfb
	ld a,h			;8dfd
	or a			;8dfe
	jr nz,FRENA_VX_GUARDA		;8dff
	ld hl,00000h		;8e01
FRENA_VX_GUARDA:		; (ix+7,8) = HL
	ld (ix+008h),h		;8e04
	ld (ix+007h),l		;8e07
	ret			;8e0a
COCHE_ESTADO_5:		; (ix+38)-- a cero: estado 7 y combustible -= 0x18 (p01 0x7646)
	dec (ix+038h)		;8e0b
	ret nz			;8e0e
	ld (ix+05dh),007h		;8e0f
	call 07646h		;8e13
	ret			;8e16
COCHE_ESTADO_9_FIN:		; estado 6 y guarda el tiempo (0x8D70)
	ld (ix+05dh),006h		;8e17
	jp GUARDA_TIEMPO		;8e1b
COCHE_ESTADO_6:		; parado: aceleracion 0 y sin sprite
	ld (ix+012h),000h		;8e1e
	set 7,(ix+031h)		;8e22
	ret			;8e26
L_8E27:
	ld a,(0e25bh)		;8e27
	or a			;8e2a
	ret z			;8e2b
	ld a,(ix+02bh)		;8e2c
	or a			;8e2f
	ret nz			;8e30
	ld a,(ix+022h)		;8e31
	cp 00bh		;8e34
	ret nz			;8e36
	ld a,(ix+011h)		;8e37
	ld (ix+02bh),a		;8e3a
	ret			;8e3d
L_8E3E:
	ld a,(ix+02bh)		;8e3e
	dec a			;8e41
	ld (ix+02bh),a		;8e42
	ret nz			;8e45
	ld a,(0e1c3h)		;8e46
	and 007h		;8e49
	add a,(ix+00ch)		;8e4b
	ld (ix+00ch),a		;8e4e
	ret			;8e51
BOXES_Y_COMBUSTIBLE:		; sin combustible y parado -> estado 6 (0x8EB5); (ix+5C) baja con las filas avanzadas (ix+4C); a cero y parado: si el cronometro pasa de 0x80 (0x8E8E) y la casilla de boxes esta bajo el coche (0x8E98; o E244 = 2 con un jugador) -> estado 1
	call SIN_COMBUSTIBLE		;8e52
	ld a,(ix+05ch)		;8e55
	or a			;8e58
	jr z,BOXES_PARADO		;8e59
	inc a			;8e5b
	ret z			;8e5c
	ld a,(ix+05ch)		;8e5d
	sub (ix+04ch)		;8e60
	ld (ix+05ch),a		;8e63
	ret nc			;8e66
	ld (ix+05ch),000h		;8e67
	ret			;8e6b
BOXES_PARADO:		; velocidad 0: comprueba boxes
	ld a,(ix+010h)		;8e6c
	or (ix+011h)		;8e6f
	ret nz			;8e72
	call CRONOMETRO_PASA_80		;8e73
	ret nc			;8e76
	ld a,(0e1c2h)		;8e77
	bit 5,a		;8e7a
	jr nz,BOXES_CASILLA		;8e7c
	ld a,(0e244h)		;8e7e
	cp 002h		;8e81
	jr z,A_ESTADO_1		;8e83
BOXES_CASILLA:		; 0x8E98: NC no
	call BAJO_BOXES		;8e85
	ret nc			;8e88
A_ESTADO_1:		; estado 1 (entra en boxes)
	ld (ix+05dh),001h		;8e89
	ret			;8e8d
CRONOMETRO_PASA_80:		; NC si (E211) >= 0x80
	ld hl,(0e211h)		;8e8e
	ld de,00080h		;8e91
	or a			;8e94
	sbc hl,de		;8e95
	ret			;8e97
BAJO_BOXES:		; casilla del buffer de nombres en (x-8, y-0x20) (p00 0x4A9D); C si alguno de los 5x2 tiles esta entre E276 y E276+E277 (p00 0x4B0C)
	ld a,(ix+004h)		;8e98
	sub 008h		;8e9b
	ld e,a			;8e9d
	ld a,(ix+006h)		;8e9e
	sub 020h		;8ea1
	ld d,a			;8ea3
	call 04a9dh		;8ea4
	ld a,(0e276h)		;8ea7
	ld d,a			;8eaa
	ld a,(0e277h)		;8eab
	ld e,a			;8eae
	ld bc,00502h		;8eaf
	jp 04b0ch		;8eb2
SIN_COMBUSTIBLE:		; vx = 0 y combustible 0: si esta en boxes -> estado 1; si no estado 6, guarda el tiempo y sonido 0x46 (0x873A)
	ld a,(ix+008h)		;8eb5
	or a			;8eb8
	ret nz			;8eb9
	ld a,(ix+050h)		;8eba
	or a			;8ebd
	ret nz			;8ebe
	call BAJO_BOXES		;8ebf
	jr c,A_ESTADO_1		;8ec2
	ld (ix+05dh),006h		;8ec4
	call GUARDA_TIEMPO		;8ec8
	jp SONIDO_46_Y_CANALES		;8ecb

; ----------------------------------------------------------------------
; DATOS tabla_8ECE: ocho bytes (04 01 04 01 02 04 02 01) entre dos rutinas sin
;   llamador; nadie los referencia en la ROM trazada
;   0x8ece..0x8ed6  (8 bytes)
DATA_tabla_8ECE:
	defb 004h,001h,004h,001h,002h,004h,002h,001h	; 8ece  ........

; ======================================================================
; CODIGO 0x8ed6..0x9081  (427 bytes)
; ======================================================================


L_8ED6:
	ld d,(ix+006h)		;8ed6
	ld e,(ix+004h)		;8ed9
	ld a,d			;8edc
	sub 020h		;8edd
	ld d,a			;8edf
	call 04a9dh		;8ee0
	ld a,l			;8ee3
	and 0e0h		;8ee4
	ld b,a			;8ee6
	ld a,(0e26ch)		;8ee7
	ld d,a			;8eea
	ld a,(0e272h)		;8eeb
	sub d			;8eee
	ld e,a			;8eef
	ld a,(hl)			;8ef0
	sub d			;8ef1
	cp e			;8ef2
	rl c		;8ef3
	ld a,l			;8ef5
	add a,004h		;8ef6
	and 01fh		;8ef8
	or b			;8efa
	ld l,a			;8efb
	ld a,(hl)			;8efc
	sub d			;8efd
	cp e			;8efe
	rl c		;8eff
	ld a,l			;8f01
	add a,004h		;8f02
	and 01fh		;8f04
	or b			;8f06
	ld l,a			;8f07
	ld a,(hl)			;8f08
	sub d			;8f09
	cp e			;8f0a
	rl c		;8f0b
	ld a,c			;8f0d
	and 007h		;8f0e
	ret			;8f10
NEUMATICOS_EFECTO:		; bits 1, 2, 3 de (ix+68) (0x8F29, 0x8F46, 0x8F56)
	call NEUMATICO_1		;8f11
	call NEUMATICO_2		;8f14
	jr NEUMATICO_3		;8f17
NEUMATICO_0:		; bit 0 de (ix+68): cada 4 fotogramas el volante (ix+13) = 0
	bit 0,(ix+068h)		;8f19
	ret z			;8f1d
	ld a,(0e1c3h)		;8f1e
	and 003h		;8f21
	ret nz			;8f23
	ld (ix+013h),000h		;8f24
	ret			;8f28
NEUMATICO_1:		; bit 1: a velocidad >= 0x400 y azar (p00 0x5513) >= 0xD0: angulo += azar&7 - 4
	bit 1,(ix+068h)		;8f29
	ret z			;8f2d
	ld a,(ix+011h)		;8f2e
	cp 004h		;8f31
	ret c			;8f33
	call 05513h		;8f34
	cp 0d0h		;8f37
	ret c			;8f39
	and 007h		;8f3a
	ret z			;8f3c
	sub 004h		;8f3d
	add a,(ix+00ch)		;8f3f
	ld (ix+00ch),a		;8f42
	ret			;8f45
NEUMATICO_2:		; bit 2: la aceleracion positiva a la mitad
	bit 2,(ix+068h)		;8f46
	ret z			;8f4a
	ld a,(ix+012h)		;8f4b
	or a			;8f4e
	ret m			;8f4f
	srl a		;8f50
	ld (ix+012h),a		;8f52
	ret			;8f55
NEUMATICO_3:		; bit 3: la aceleracion negativa a la mitad
	bit 3,(ix+068h)		;8f56
	ret z			;8f5a
	ld a,(ix+012h)		;8f5b
	or a			;8f5e
	ret p			;8f5f
	sra a		;8f60
	ld (ix+012h),a		;8f62
	ret			;8f65
MARCHAS:		; (ix+70) != 0: cambio automatico cada 0x1E fotogramas por revoluciones (< 0x20 baja, >= 0x38 sube); si no arriba (bit 0 del mando) sube (0x8F9A) y abajo (bit 1) baja (0x8FB9)
	ld a,(ix+070h)		;8f66
	or a			;8f69
	jr z,MARCHA_MANUAL		;8f6a
	dec a			;8f6c
	jr z,MARCHA_AUTOMATICA		;8f6d
	ld (ix+070h),a		;8f6f
	ret			;8f72
MARCHA_AUTOMATICA:		; (ix+70) = 0x1E y decide por (ix+59)
	ld a,01eh		;8f73
	ld (ix+070h),a		;8f75
	ld a,(ix+059h)		;8f78
	cp 020h		;8f7b
	jr c,BAJA_MARCHA		;8f7d
	cp 038h		;8f7f
	jr nc,SUBE_MARCHA		;8f81
	ret			;8f83
MARCHA_MANUAL:		; flancos del mando del jugador (ix+9)
	ld hl,0e1cbh		;8f84
	bit 0,(ix+009h)		;8f87
	jr z,MARCHA_MANUAL_BITS		;8f8b
	ld hl,0e1c8h		;8f8d
MARCHA_MANUAL_BITS:		; bit 0 sube, bit 1 baja
	bit 0,(hl)		;8f90
	call nz,SUBE_MARCHA		;8f92
	bit 1,(hl)		;8f95
	jr nz,BAJA_MARCHA		;8f97
	ret			;8f99
SUBE_MARCHA:		; (ix+69)++ (tope 3); E19A/E19F = (ix+72), E199/E19E = 0; sprite extra 2 si acelera (0x8FC5)
	ld a,(ix+069h)		;8f9a
	inc a			;8f9d
	cp 004h		;8f9e
	ret nc			;8fa0
	ld (ix+069h),a		;8fa1
	ld hl,0e19ah		;8fa4
	bit 0,(ix+009h)		;8fa7
	jr nz,SUBE_MARCHA_REVS		;8fab
	ld hl,0e19fh		;8fad
SUBE_MARCHA_REVS:		; el filtro de revoluciones al tope
	ld a,(ix+072h)		;8fb0
	ld (hl),a			;8fb3
	dec hl			;8fb4
	ld (hl),000h		;8fb5
	jr MARCHA_SPRITE		;8fb7
BAJA_MARCHA:		; bit 0 de (ix-1C); (ix+69)-- (minimo 0)
	set 0,(ix-01ch)		;8fb9
	ld a,(ix+069h)		;8fbd
	dec a			;8fc0
	ret m			;8fc1
	ld (ix+069h),a		;8fc2
MARCHA_SPRITE:		; si (ix+12) > 0: (ix+2F) = 2 y bit 6 de (ix+31) (el sprite extra del cambio)
	ld a,(ix+012h)		;8fc5
	neg		;8fc8
	ret p			;8fca
	ld (ix+02fh),002h		;8fcb
	set 6,(ix+031h)		;8fcf
	ret			;8fd3
ACELERADOR:		; un fotograma de cada dos (por jugador): revoluciones (0x9CA8); boton 2 (bit 5) -> freno (0x902E); sin combustible -> aceleracion -5 (0x9012); boton 1 (bit 4) -> 0x9017; si no (ix-0A) = 0 y aceleracion = tabla 0x90B1[revs >> 4] (retencion)
	ld a,(0e1c3h)		;8fd4
	xor (ix+009h)		;8fd7
	rrca			;8fda
	ret c			;8fdb
	call ACELERACION_MOTOR		;8fdc
	ld hl,0e1cch		;8fdf
	bit 0,(ix+009h)		;8fe2
	jr z,ACELERADOR_BOTONES		;8fe6
	ld hl,0e1c9h		;8fe8
ACELERADOR_BOTONES:		; bits 5 y 4 del mando
	bit 5,(hl)		;8feb
	jr nz,FRENA		;8fed
	ld a,(ix+050h)		;8fef
	or a			;8ff2
	jr z,SIN_COMBUSTIBLE_ACEL		;8ff3
	bit 4,(hl)		;8ff5
	jr nz,ACELERA		;8ff7
	ld (ix-00ah),000h		;8ff9
	ld a,(ix+059h)		;8ffd
	rrca			;9000
	rrca			;9001
	rrca			;9002
	rrca			;9003
	and 00fh		;9004
	ld e,a			;9006
	ld d,000h		;9007
	ld hl,090b1h		;9009
	add hl,de			;900c
	ld a,(hl)			;900d
	ld (ix+012h),a		;900e
	ret			;9011
SIN_COMBUSTIBLE_ACEL:		; aceleracion = -5
	ld (ix+012h),0fbh		;9012
	ret			;9016
ACELERA:		; (ix-0A) = 0; revoluciones >= 0x55 y azar: sprite extra 3 (humo)
	ld (ix-00ah),000h		;9017
	ld a,(ix+059h)		;901b
	cp 055h		;901e
	ret c			;9020
	ld a,r		;9021
	rrca			;9023
	ret c			;9024
	ld (ix+02fh),003h		;9025
	set 6,(ix+031h)		;9029
	ret			;902d
FRENA:		; (ix-0A) != 0: tabla 0x905A; cada 4 fotogramas sonido 0x13 si vx >= 4; la primera vez (ix-09) = 4, (ix-0B) = 1 y sonido 0x11
	ld a,(ix-00ah)		;902e
	or a			;9031
	jr z,FRENA_EMPIEZA		;9032
	call FRENA_TABLA		;9034
	dec (ix-009h)		;9037
	ret nz			;903a
	ld (ix-009h),004h		;903b
	ld d,013h		;903f
FRENA_SONIDO:		; sonido D + jugador si vx (ix+8) >= 4
	ld a,(ix+008h)		;9041
	cp 004h		;9044
	ret c			;9046
	ld a,d			;9047
	jp SONIDO_JUGADOR		;9048
FRENA_EMPIEZA:		; (ix-09) = 4, (ix-0B) = 1, tabla, sonido 0x11
	ld (ix-009h),004h		;904b
	ld (ix-00bh),001h		;904f
	call FRENA_TABLA		;9053
	ld d,011h		;9056
	jr FRENA_SONIDO		;9058
FRENA_TABLA:		; aceleracion = tabla 0x9081[(ix+77)*8 + (ix-0A)*2]; (ix-0B)-- a cero: recarga con el 2o byte y (ix-0A)++ (hasta 3)
	ld c,a			;905a
	ld a,(ix+077h)		;905b
	add a,a			;905e
	add a,a			;905f
	add a,c			;9060
	add a,a			;9061
	ld l,a			;9062
	ld h,000h		;9063
	ld de,09081h		;9065
	add hl,de			;9068
	ld a,(hl)			;9069
	ld (ix+012h),a		;906a
	dec (ix-00bh)		;906d
	ret nz			;9070
	inc hl			;9071
	ld a,(hl)			;9072
	ld (ix-00bh),a		;9073
	ld a,(ix-00ah)		;9076
	cp 003h		;9079
	ret nc			;907b
	inc a			;907c
	ld (ix-00ah),a		;907d
	ret			;9080

; ----------------------------------------------------------------------
; DATOS tabla_frenada: 3 grupos de 4 parejas (aceleracion, duracion) por
;   (ix+77): 0x90, 0xC0, 0xE0, 0xE0 / 0xA0.. con duracion 8
;   0x9081..0x90b1  (48 bytes)
DATA_tabla_frenada:
	defw 00890h,008c0h,008e0h,008e0h	; 9081
	defw 008a0h,008a0h,008a0h,008a0h	; 9089
	defw 008a0h,008c0h,008d0h,008e0h	; 9091
	defw 00890h,008c0h,008e0h,008e0h	; 9099
	defw 008a0h,008a0h,008a0h,008a0h	; 90a1
	defw 008a0h,008c0h,008d0h,008e0h	; 90a9

; ----------------------------------------------------------------------
; DATOS tabla_retencion: 16 aceleraciones por revoluciones >> 4 sin acelerar:
;   FD FB F9 F8 EB EB D0 B0 88 88..
;   0x90b1..0x90c1  (16 bytes)
DATA_tabla_retencion:
	defb 0fdh,0fbh,0f9h,0f8h,0ebh,0ebh,0d0h,0b0h,088h,088h,088h,088h,088h,088h,088h,088h	; 90b1  ................

; ======================================================================
; CODIGO 0x90c1..0x9111  (80 bytes)
; ======================================================================


L_90C1:
	push ix		;90c1
	pop hl			;90c3
	ld l,0c0h		;90c4
	ld a,(hl)			;90c6
	inc a			;90c7
	cp 01eh		;90c8
	jr c,L_90CD		;90ca
	xor a			;90cc
L_90CD:
	ld (hl),a			;90cd
	add a,a			;90ce
	add a,l			;90cf
	ld l,a			;90d0
	ld e,(ix+010h)		;90d1
	ld d,(ix+011h)		;90d4
	ld c,(hl)			;90d7
	ld (hl),e			;90d8
	inc l			;90d9
	ld b,(hl)			;90da
	ld (hl),d			;90db
	ex de,hl			;90dc
	or a			;90dd
	sbc hl,bc		;90de
	ld (ix+007h),l		;90e0
	ld (ix+008h),h		;90e3
	ret			;90e6
META_Y_VUELTAS:		; coche 1: 0x9103 y 0x9207; con dos jugadores el coche 2
	ld ix,0e2c0h		;90e7
	ld iy,0e2c0h		;90eb
	call TILE_ESPECIAL		;90ef
	call REPETICION		;90f2
	ld a,(0e1c2h)		;90f5
	bit 5,a		;90f8
	ret z			;90fa
	ld ix,0e380h		;90fb
	ld iy,0e380h		;90ff
TILE_ESPECIAL:		; (ix-1A) con bit 6 y < 9: despacha (tabla 0x9111)
	ld a,(ix-01ah)		;9103
	bit 6,a		;9106
	ret z			;9108
	and 03fh		;9109
	cp 009h		;910b
	ret nc			;910d
	call 040dah		;910e

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (18 bytes)
;   0x9111..0x9123  (18 bytes)
DATA_9111:
	defb 023h,091h,006h,092h,006h,092h,006h,092h,006h,092h,006h,092h,0e1h,091h,0f7h,091h	; 9111  #...............
	defb 006h,092h	; 9121

; ======================================================================
; CODIGO 0x9123..0x91db  (184 bytes)
; ======================================================================


LINEA_DE_META:		; si no termino (bit 1 de ix+1): ultima vuelta (0x91CC) -> estado 3, bit 1, (bit 7 de ix+3C si no venia de 4), E214++ (el primero: posicion (0x9161)), guarda el tiempo (0x8D70), musica de meta (0x8682); un jugador con bit 7 de (ix+3C) -> E250 = 0x1A; si no vuelta nueva (0x9180)
	bit 1,(ix+001h)		;9123
	ret nz			;9127
	ld e,000h		;9128
	call VUELTAS_COMPARA		;912a
	jr nz,VUELTA_NUEVA		;912d
	ld a,(ix+05dh)		;912f
	ld (ix+05dh),003h		;9132
	set 1,(ix+001h)		;9136
	cp 004h		;913a
	jr z,META_LLEGADA		;913c
	set 7,(ix+03ch)		;913e
META_LLEGADA:		; E214++ y lo demas
	ld hl,0e214h		;9142
	inc (hl)			;9145
	ld a,(hl)			;9146
	dec a			;9147
	call z,META_PRIMERO		;9148
	call GUARDA_TIEMPO		;914b
	call MUSICA_META		;914e
	ld a,(0e1c2h)		;9151
	bit 5,a		;9154
	ret nz			;9156
	bit 7,(ix+03ch)		;9157
	ret z			;915b
	ld a,01ah		;915c
	jp 06049h		;915e
META_PRIMERO:		; con dos jugadores (ix+71) = (ix+7E); E331/E3F1 (por jugador) = (ix+71) + 1
	ld a,(0e1c2h)		;9161
	bit 5,a		;9164
	jr z,META_POSICION_JUGADOR		;9166
	ld a,(ix+07eh)		;9168
	ld (ix+071h),a		;916b
META_POSICION_JUGADOR:		; HL = E331 (jugador 1) o E3F1
	bit 0,(ix+009h)		;916e
	ld hl,0e331h		;9172
	jr z,META_POSICION_ESCRIBE		;9175
	ld hl,0e3f1h		;9177
META_POSICION_ESCRIBE:		; (HL) = (ix+71) + 1
	ld a,(ix+071h)		;917a
	inc a			;917d
	ld (hl),a			;917e
	ret			;917f
VUELTA_NUEVA:		; si (ix-2) cambio respecto a (ix-8): (ix-8) = (ix-2), (ix-7) = 0x40; tiempo de vuelta = cronometro E210.. - (ix-12..-10) (p00 0x52BB, 0x5339) -> 6 digitos a ix+0x78.. y p00 0x48B7
	ld a,(ix-002h)		;9180
	cp (ix-008h)		;9183
	ret z			;9186
	ld (ix-008h),a		;9187
	ld a,040h		;918a
	ld (ix-007h),a		;918c
	ld c,(ix-012h)		;918f
	ld e,(ix-011h)		;9192
	ld d,(ix-010h)		;9195
	ld hl,0e210h		;9198
	ld b,(hl)			;919b
	inc hl			;919c
	ld a,(hl)			;919d
	inc hl			;919e
	ld h,(hl)			;919f
	ld l,a			;91a0
	ld (ix-012h),b		;91a1
	ld (ix-011h),l		;91a4
	ld (ix-010h),h		;91a7
	call 052bbh		;91aa
	call 05339h		;91ad
	push ix		;91b0
	pop hl			;91b2
	ld de,00078h		;91b3
	add hl,de			;91b6
	ex de,hl			;91b7
	ld hl,0ea51h		;91b8
	ldi		;91bb
	ldi		;91bd
	ldi		;91bf
	ldi		;91c1
	ldi		;91c3
	ldi		;91c5
	jp 048b7h		;91c7
VUELTAS_CARRERA:		; A = tabla 0x91DB[E25B] (vueltas) comparado con (ix-2) (desde p01 0x76F2; devuelve A = vueltas)
	ld e,000h		;91ca
VUELTAS_COMPARA:		; cp (ix-2)
	ld hl,091dbh		;91cc
	ld a,(0e25bh)		;91cf
	ld d,000h		;91d2
	ld e,a			;91d4
	add hl,de			;91d5
	ld a,(hl)			;91d6
	cp (ix-002h)		;91d7
	ret			;91da

; ----------------------------------------------------------------------
; DATOS tabla_vueltas: vueltas por categoria E25B: 3, 4, 3, 4, 3, 4
;   0x91db..0x91e1  (6 bytes)
DATA_tabla_vueltas:
	defb 003h,004h,003h,004h,003h,004h	; 91db

; ======================================================================
; CODIGO 0x91e1..0x927e  (157 bytes)
; ======================================================================


TILE_6_REPETICION:		; si E244 != 0: E244 = 0 y, si era 2, 0x91EC
	ld hl,0e244h		;91e1
	ld a,(hl)			;91e4
	and a			;91e5
	ret z			;91e6
	ld (hl),000h		;91e7
	cp 002h		;91e9
	ret nz			;91eb
REINICIA_PISTA_REPETICION:		; E315 = 1, p00 0x44F3 y CARGA_TILES_CIRCUITO (p00 0x4BCE)
	ld a,001h		;91ec
	ld (0e315h),a		;91ee
	call 044f3h		;91f1
	jp 04bceh		;91f4
TILE_7_PIDE_REPETICION:		; un jugador y E244 = 0: E244 = 1
	ld a,(0e1c2h)		;91f7
	bit 5,a		;91fa
	ret nz			;91fc
	ld hl,0e244h		;91fd
	ld a,(hl)			;9200
	and a			;9201
	ret nz			;9202
	ld a,001h		;9203
	ld (hl),a			;9205
NADA_9206:		; ret (entradas 1-5 y 8 de la tabla)
	ret			;9206
REPETICION:		; en estado 0, con el boton 2 (bit 5 de E1C9) y E244 = 1 y terreno 15: angulo 0, volante 0, (ix+1) &= 0x3F, E1D5 = 0, E244 = 2, pista (0x9263) y 0x923A
	ld a,(ix+05dh)		;9207
	cp 000h		;920a
	ret nz			;920c
	ld hl,0e1c9h		;920d
	bit 5,(hl)		;9210
	ret z			;9212
	ld a,(0e244h)		;9213
	dec a			;9216
	ret nz			;9217
	ld a,(ix+022h)		;9218
	cp 00fh		;921b
	ret nz			;921d
	ld (ix+00ch),000h		;921e
	ld (ix+013h),000h		;9222
	ld a,(ix+001h)		;9226
	and 03fh		;9229
	ld (ix+001h),a		;922b
	xor a			;922e
	ld (0e1d5h),a		;922f
	ld a,002h		;9232
	ld (0e244h),a		;9234
	call CARGA_PISTA_REPETICION		;9237
OBJETOS_A_UN_LADO:		; los 5 objetos E800..: x = 0xC8 o 0xF8 por el bit 7 de (ix+29); E315 = 0
	push ix		;923a
	ld ix,0e800h		;923c
	ld de,00038h		;9240
	ld b,005h		;9243
OBJETOS_LADO_BUCLE:		; un objeto por vuelta
	ld a,(ix+000h)		;9245
	or a			;9248
	jr z,OBJETO_LADO_SIGUIENTE		;9249
	bit 7,(ix+029h)		;924b
	ld a,0c8h		;924f
	jr nz,OBJETO_LADO_X		;9251
	ld a,0f8h		;9253
OBJETO_LADO_X:		; (ix+4) = A
	ld (ix+004h),a		;9255
OBJETO_LADO_SIGUIENTE:		; IX += 0x38
	add ix,de		;9258
	djnz OBJETOS_LADO_BUCLE		;925a
	pop ix		;925c
	xor a			;925e
	ld (0e315h),a		;925f
	ret			;9262
CARGA_PISTA_REPETICION:		; p00 0x44F3; lista 0x927E[E25B] (p04) y p04 0x6D00 (CARGA_LISTA_TILES); escena p00 0x5778; p00 0x49E0
	call 044f3h		;9263
	ld hl,0927eh		;9266
	ld a,(0e25bh)		;9269
	call 04a44h		;926c
	call 04ccdh		;926f
	ld hl,06d00h		;9272
	call 04ccdh		;9275
	call 05778h		;9278
	jp 049e0h		;927b

; ----------------------------------------------------------------------
; DATOS tabla_927E: 6 punteros a listas del cargador de tiles; por (E25B)
;   desde p02 0x9266
;   0x927e..0x928a  (12 bytes)
DATA_tabla_927E:
	defw 07029h	; 927e
	defw 07010h	; 9280
	defw 07042h	; 9282
	defw 0705bh	; 9284
	defw 07074h	; 9286
	defw 0708dh	; 9288

; ======================================================================
; CODIGO 0x928a..0x9344  (186 bytes)
; ======================================================================


FIN_DE_CARRERA_P00:		; para la musica (0x869A), guarda el tiempo de los dos coches (0x8D70) y E250 = 0x0E (desde p00 0x5AFF)
	call PARA_MUSICA		;928a
	ld ix,0e2c0h		;928d
	call GUARDA_TIEMPO		;9291
	ld ix,0e380h		;9294
	call GUARDA_TIEMPO		;9298
	ld a,00eh		;929b
	jp 06049h		;929d

; ----------------------------------------------------------------------
; El volante: (ix+13) = giro por fotograma desde la tabla 0x9344 por
; neumaticos (ix+76), velocidad (ix+11 & 0x0C) y la rampa (ix+58) que
; crece 2 por fotograma con izquierda/derecha (tope 16) y baja sola.
; ----------------------------------------------------------------------
VOLANTE:		; repeticion -> 0x93DD; rampa (0x9335) si hay direccion; izquierda/derecha (bits 2/3): (ix+13) = +-tabla; nada: 0x931C; y el aviso de los ultimos (0x92F9: (ix+7E) < 2, F1, cada 64 fotogramas, rampa < 2, y < 0x10 -> bit 7 de ix+1)
	ld a,(0e244h)		;92a0
	cp 002h		;92a3
	jp z,VOLANTE_REPETICION		;92a5
	ld c,(ix+058h)		;92a8
	ld hl,0e1cbh		;92ab
	bit 0,(ix+009h)		;92ae
	jr z,VOLANTE_MANDO		;92b2
	ld hl,0e1c8h		;92b4
VOLANTE_MANDO:		; el mando del jugador
	ld a,(hl)			;92b7
	inc hl			;92b8
	and 00fh		;92b9
	call nz,VOLANTE_RAMPA		;92bb
	ld a,(hl)			;92be
	and 00ch		;92bf
	rrca			;92c1
	rrca			;92c2
	ld c,a			;92c3
	jr z,VOLANTE_CENTRA		;92c4
	ld de,09344h		;92c6
	ld a,(ix+076h)		;92c9
	add a,a			;92cc
	add a,a			;92cd
	add a,a			;92ce
	ld l,a			;92cf
	ld h,000h		;92d0
	add hl,hl			;92d2
	add hl,de			;92d3
	ld a,(ix+011h)		;92d4
	and 00ch		;92d7
	ld e,a			;92d9
	ld d,000h		;92da
	add hl,de			;92dc
	ld a,(ix+058h)		;92dd
	dec a			;92e0
	jr z,VOLANTE_TABLA		;92e1
	ld (ix+058h),a		;92e3
	and 00ch		;92e6
	rrca			;92e8
	rrca			;92e9
VOLANTE_TABLA:		; A = tabla; negativo con izquierda (bit 1 de C)
	ld e,a			;92ea
	add hl,de			;92eb
	ld a,(hl)			;92ec
	bit 1,c		;92ed
	jr z,VOLANTE_GUARDA		;92ef
	neg		;92f1
VOLANTE_GUARDA:		; (ix+13) = A; neumatico 0 (0x8F19)
	ld (ix+013h),a		;92f3
	call NEUMATICO_0		;92f6
	ld a,(ix+07eh)		;92f9
	cp 002h		;92fc
	ret nc			;92fe
	ld a,(0e25bh)		;92ff
	cp 005h		;9302
	ret nz			;9304
	ld a,(0e1c3h)		;9305
	and 03fh		;9308
	ret nz			;930a
	ld a,(ix+058h)		;930b
	cp 002h		;930e
	ret nc			;9310
	ld a,(ix+006h)		;9311
	cp 010h		;9314
	ret nc			;9316
	set 7,(ix+001h)		;9317
	ret			;931b
VOLANTE_CENTRA:		; sin direccion: si el angulo no es 0, (ix+13) = -+ tabla 0x93D4[(ix+76)] hacia el centro
	ld a,(ix+00ch)		;931c
	or a			;931f
	jr z,VOLANTE_GUARDA_B		;9320
	ld hl,093d4h		;9322
	ld e,(ix+076h)		;9325
	ld d,000h		;9328
	add hl,de			;932a
	ld a,(hl)			;932b
	jp m,VOLANTE_GUARDA_B		;932c
	neg		;932f
VOLANTE_GUARDA_B:		; (ix+13) = A
	ld (ix+013h),a		;9331
	ret			;9334
VOLANTE_RAMPA:		; (ix+58) += 2 (tope 0x10)
	ld a,(ix+058h)		;9335
	add a,002h		;9338
	cp 010h		;933a
	jr c,VOLANTE_RAMPA_GUARDA		;933c
	ld a,010h		;933e
VOLANTE_RAMPA_GUARDA:		; (ix+58) = A
	ld (ix+058h),a		;9340
	ret			;9343

; ----------------------------------------------------------------------
; DATOS tabla_volante: 9 bloques de 16 bytes por (ix+76): 4 velocidades x 4
;   pasos de rampa (grados de giro por fotograma)
;   0x9344..0x93d4  (144 bytes)
DATA_tabla_volante:
	defb 025h,024h,00eh,008h,025h,024h,00eh,008h,020h,01fh,00eh,008h,020h,01fh,00eh,008h	; 9344  %$..%$.. ... ...
	defb 025h,024h,00eh,00ch,025h,024h,00eh,00ch,020h,01fh,00eh,00ch,020h,01fh,00eh,00ch	; 9354  %$..%$.. ... ...
	defb 020h,024h,00eh,014h,020h,024h,00eh,014h,020h,01fh,00eh,014h,020h,01fh,00eh,014h	; 9364   $.. $.. ... ...
	defb 012h,017h,017h,008h,013h,017h,016h,008h,010h,013h,015h,008h,00eh,010h,012h,008h	; 9374  ................
	defb 012h,01ah,023h,00ah,012h,01ah,020h,00ah,011h,016h,017h,00ah,00eh,013h,015h,00ch	; 9384  ..#... .........
	defb 012h,01ah,023h,014h,012h,017h,020h,014h,011h,016h,017h,014h,00eh,013h,015h,014h	; 9394  ..#... .........
	defb 012h,01ah,017h,008h,012h,01ah,017h,008h,00eh,00fh,012h,008h,00eh,00fh,012h,008h	; 93a4  ................
	defb 012h,01ah,017h,008h,012h,01ah,017h,008h,00eh,00fh,012h,008h,00eh,00fh,012h,008h	; 93b4  ................
	defb 012h,01ah,017h,008h,012h,01ah,017h,008h,00eh,00fh,012h,008h,00eh,00fh,012h,008h	; 93c4  ................

; ----------------------------------------------------------------------
; DATOS tabla_volante_centra: 9 bytes por (ix+76): giro hacia el centro al
;   soltar
;   0x93d4..0x93dd  (9 bytes)
DATA_tabla_volante_centra:
	defb 004h,004h,004h,008h,004h,002h,006h,006h,006h	; 93d4  .........

; ======================================================================
; CODIGO 0x93dd..0x94c3  (230 bytes)
; ======================================================================


VOLANTE_REPETICION:		; (ix+1) &= 0x3F, volante 0, angulo 0
	ld a,(ix+001h)		;93dd
	and 03fh		;93e0
	ld (ix+001h),a		;93e2
	ld (ix+013h),000h		;93e5
	ld (ix+00ch),000h		;93e9
	ret			;93ed
L_93EE:
	ld a,(0e1c9h)		;93ee
	bit 2,a		;93f1
	jr nz,L_93FE		;93f3
	bit 3,a		;93f5
	jr nz,L_9403		;93f7
	ld (ix+00ch),000h		;93f9
	ret			;93fd
L_93FE:
	ld (ix+00ch),006h		;93fe
	ret			;9402
L_9403:
	ld (ix+00ch),0fah		;9403
	ret			;9407
FISICA_COCHE_JUGADOR:		; terreno (0x9510); terreno 14 -> sin sprite (0x9465); RALLY (E25B = 0): charcos (0x943B); angulo (0x96DB); velocidad (0x9744); fotograma (0x9A01)
	call TERRENO_Y_DERRAPE		;9408
	ld a,(ix+022h)		;940b
	cp 00eh		;940e
	call z,SIN_SPRITE		;9410
	ld a,(0e25bh)		;9413
	or a			;9416
	call z,EFECTO_TERRENO		;9417
	call ANGULO_COCHE		;941a
	call VELOCIDAD_COCHE		;941d
	jp FOTOGRAMA_COCHE		;9420
FISICA_OBJETO:		; terreno 14 -> sin sprite; RALLY: 0x943B; angulo (0x96BE); velocidad (0x9776); fotograma (0x9962)
	ld a,(ix+022h)		;9423
	cp 00eh		;9426
	call z,SIN_SPRITE		;9428
	ld a,(0e25bh)		;942b
	or a			;942e
	call z,EFECTO_TERRENO		;942f
	call ANGULO_OBJETO		;9432
	call VELOCIDAD_OBJETO		;9435
	jp FOTOGRAMA_OBJETO		;9438
EFECTO_TERRENO:		; 0x9441 y 0x9473
	call EFECTO_TERRENO_ARRANCA		;943b
	jp EFECTO_TERRENO_PASO		;943e
EFECTO_TERRENO_ARRANCA:		; sin choque y sin efecto: terreno 11/12 -> (ix+2B) = 10, (ix+2C) = 0x81; terreno 8/9 -> (ix+2C) = 1, (ix+2B) = 3
	bit 3,(ix+001h)		;9441
	ret nz			;9445
	ld a,(ix+02ch)		;9446
	or a			;9449
	jr nz,EFECTO_8X		;944a
	ld a,(ix+022h)		;944c
	cp 00bh		;944f
	jr z,EFECTO_81		;9451
	cp 00ch		;9453
	jr z,EFECTO_81		;9455
	sub 008h		;9457
	cp 002h		;9459
	ret nc			;945b
	ld (ix+02ch),001h		;945c
	ld (ix+02bh),003h		;9460
	ret			;9464
SIN_SPRITE:		; bit 7 de (ix+31)
	set 7,(ix+031h)		;9465
	ret			;9469
EFECTO_81:		; (ix+2B) = 10, (ix+2C) = 0x81
	ld (ix+02bh),00ah		;946a
	ld (ix+02ch),081h		;946e
	ret			;9472
EFECTO_TERRENO_PASO:		; (ix+2C) = 1: sprite extra 1 (salpicadura, hipotesis) y bit 6; (ix+2B)-- a cero: (ix+2C) = 0
	ld a,(ix+02ch)		;9473
	or a			;9476
	ret z			;9477
	cp 001h		;9478
	jr nz,EFECTO_CUENTA		;947a
	ld (ix+02fh),001h		;947c
	set 6,(ix+031h)		;9480
EFECTO_CUENTA:		; (ix+2B)--
	dec (ix+02bh)		;9484
	ret nz			;9487
	ld (ix+02ch),000h		;9488
	ret			;948c
EFECTO_8X:		; 0x81: a los 10 pasa a 0x82 con 10 y sonido 0x19 si es el coche; 0x82: a cero
	bit 7,a		;948d
	ret z			;948f
	and 07fh		;9490
	dec a			;9492
	jr nz,EFECTO_82_CUENTA		;9493
	dec (ix+02bh)		;9495
	ret nz			;9498
	ld (ix+02ch),082h		;9499
	ld (ix+02bh),00ah		;949d
	ld a,(ix+000h)		;94a1
	or a			;94a4
	ret nz			;94a5
	ld a,019h		;94a6
	jp SONIDO_JUGADOR		;94a8
EFECTO_82_CUENTA:		; (ix+2B)-- a cero: (ix+2C) = 0
	dec (ix+02bh)		;94ab
	ret nz			;94ae
	ld (ix+02ch),000h		;94af
	ret			;94b3
FRENADA_CATEGORIA:		; si (ix+13) != 0 y E25B - 1 < 6: despacha (tabla 0x94C3): velocidad -= v/256 (0x94CF), v/512 (0x94E2), v/1024 (0x94F8) o nada (0x950F)
	ld a,(ix+013h)		;94b4
	or a			;94b7
	ret z			;94b8
	ld a,(0e25bh)		;94b9
	dec a			;94bc
	cp 006h		;94bd
	ret nc			;94bf
	call 040dah		;94c0

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (12 bytes)
;   0x94c3..0x94cf  (12 bytes)
DATA_94C3:
	defb 0cfh,094h,0e2h,094h,0f8h,094h,0f8h,094h,00fh,095h,0f8h,094h	; 94c3  ............

; ======================================================================
; CODIGO 0x94cf..0x986b  (924 bytes)
; ======================================================================


FRENADA_1_256:		; (ix+10,11) -= H
	ld l,(ix+010h)		;94cf
	ld h,(ix+011h)		;94d2
	ld e,h			;94d5
	ld d,000h		;94d6
	sbc hl,de		;94d8
	ret m			;94da
	ld (ix+010h),l		;94db
	ld (ix+011h),h		;94de
	ret			;94e1
FRENADA_1_512:		; (ix+10,11) -= H/2
	ld l,(ix+010h)		;94e2
	ld h,(ix+011h)		;94e5
	ld a,h			;94e8
	srl a		;94e9
	ld e,a			;94eb
	ld d,000h		;94ec
	sbc hl,de		;94ee
	ret m			;94f0
	ld (ix+010h),l		;94f1
	ld (ix+011h),h		;94f4
	ret			;94f7
FRENADA_1_1024:		; (ix+10,11) -= H/4
	ld l,(ix+010h)		;94f8
	ld h,(ix+011h)		;94fb
	ld a,h			;94fe
	srl a		;94ff
	srl a		;9501
	ld e,a			;9503
	ld d,000h		;9504
	sbc hl,de		;9506
	ret m			;9508
	ld (ix+010h),l		;9509
	ld (ix+011h),h		;950c
NADA_950F:		; ret
	ret			;950f
TERRENO_Y_DERRAPE:		; bit 0 de (ix+1) = 0; sin choque: (ix+22) = terreno bajo el coche (0x9550); < 3 -> borde (0x9563); si no (ix+28) = 0 y, con terreno < 9, velocidad -= v/32
	res 0,(ix+001h)		;9510
	bit 3,(ix+001h)		;9514
	ret nz			;9518
	call TERRENO_BAJO_COCHE		;9519
	ld (ix+022h),a		;951c
	cp 003h		;951f
	jr c,BORDE		;9521
	call SIN_REPETIR_BORDE		;9523
	ld a,(ix+022h)		;9526
	cp 009h		;9529
	ret nc			;952b
	ld l,(ix+010h)		;952c
	ld h,(ix+011h)		;952f
	ld d,h			;9532
	ld e,l			;9533
	add hl,hl			;9534
	add hl,hl			;9535
	add hl,hl			;9536
	ld l,h			;9537
	ld h,000h		;9538
	ex de,hl			;953a
	sbc hl,de		;953b
	ret m			;953d
	ld (ix+010h),l		;953e
	ld (ix+011h),h		;9541
	ld a,(0e1c3h)		;9544
	and 003h		;9547
	ret nz			;9549
	ld a,(ix+000h)		;954a
	or a			;954d
	ret nz			;954e
	ret			;954f
TERRENO_BAJO_COCHE:		; tile del buffer de nombres en (x, y-4) (p00 0x4A9D) -> clase 0..15 (0x9641); HL = la casilla
	ld a,(ix+006h)		;9550
	sub 004h		;9553
	ld d,a			;9555
	ld e,(ix+004h)		;9556
	call 04a9dh		;9559
	push hl			;955c
	ld a,(hl)			;955d
	call CLASE_DE_TILE		;955e
	pop hl			;9561
	ret			;9562
BORDE:		; terreno 1 -> rebote con vx (0x95B7); 2 -> con -vx (0x95AA); 0: si vy < 6 y no se repite ((ix+28)): mira la casilla de abajo, la de la izquierda y la derecha para elegir el lado; si no 0x9628 (choque)
	dec a			;9563
	jr z,REBOTE_DERECHA		;9564
	dec a			;9566
	jr z,REBOTE_IZQUIERDA		;9567
	ld a,(ix+028h)		;9569
	or a			;956c
	jp nz,CHOQUE		;956d
	inc a			;9570
	ld (ix+028h),a		;9571
	ld a,(ix+00bh)		;9574
	add a,006h		;9577
	cp 00ch		;9579
	jp nc,CHOQUE		;957b
	push hl			;957e
	ld de,00020h		;957f
	res 2,h		;9582
	add hl,de			;9584
	set 2,h		;9585
	ld a,(hl)			;9587
	call CLASE_DE_TILE		;9588
	or a			;958b
	pop hl			;958c
	jr z,REBOTE_GIRA		;958d
	dec a			;958f
	jr z,REBOTE_DERECHA		;9590
	dec a			;9592
	jr z,REBOTE_IZQUIERDA		;9593
	push hl			;9595
	dec hl			;9596
	ld a,(hl)			;9597
	call CLASE_DE_TILE		;9598
	or a			;959b
	pop hl			;959c
	jr nz,REBOTE_IZQUIERDA		;959d
	inc hl			;959f
	ld a,(hl)			;95a0
	call CLASE_DE_TILE		;95a1
	or a			;95a4
	jr nz,REBOTE_DERECHA		;95a5
	jp CHOQUE		;95a7
REBOTE_IZQUIERDA:		; HL = -vx
	ld a,(ix+008h)		;95aa
	cpl			;95ad
	ld h,a			;95ae
	ld a,(ix+007h)		;95af
	cpl			;95b2
	ld l,a			;95b3
	inc hl			;95b4
	jr REBOTE		;95b5
REBOTE_DERECHA:		; HL = vx
	ld h,(ix+008h)		;95b7
	ld l,(ix+007h)		;95ba
REBOTE:		; vy += HL/2; 0x95D0
	push hl			;95bd
	sra h		;95be
	rr l		;95c0
	ld d,(ix+00bh)		;95c2
	ld e,(ix+00ah)		;95c5
	add hl,de			;95c8
	ld (ix+00bh),h		;95c9
	ld (ix+00ah),l		;95cc
	pop hl			;95cf
REBOTE_GIRA:		; bit 0 de (ix+1); angulo += 8 (o -8 si vy < 0); vy = -vy/2; bits 7 y 0; avanza dos veces (0x9AFE); para el coche: (ix+64) += |H|/2 (desgaste); en RALLY, |H| >= 3 -> choque (0x9628)
	set 0,(ix+001h)		;95d0
	bit 7,(ix+00bh)		;95d4
	ld a,008h		;95d8
	jr z,REBOTE_ANGULO		;95da
	neg		;95dc
REBOTE_ANGULO:		; angulo += A
	add a,(ix+00ch)		;95de
	ld (ix+00ch),a		;95e1
	ld e,(ix+00ah)		;95e4
	ld d,(ix+00bh)		;95e7
	ld hl,00000h		;95ea
	or a			;95ed
	sbc hl,de		;95ee
	sra h		;95f0
	rr l		;95f2
	ld (ix+00ah),l		;95f4
	ld (ix+00bh),h		;95f7
	set 7,(ix+001h)		;95fa
	set 0,(ix+001h)		;95fe
	push hl			;9602
	call AVANZA_Y		;9603
	call AVANZA_Y		;9606
	pop hl			;9609
	ld a,(ix+000h)		;960a
	or a			;960d
	ret nz			;960e
	ld a,h			;960f
	or a			;9610
	jp p,REBOTE_DESGASTE		;9611
	neg		;9614
REBOTE_DESGASTE:		; (ix+64) += H/2
	ld h,a			;9616
	srl a		;9617
	add a,(ix+064h)		;9619
	ld (ix+064h),a		;961c
	ld a,(0e25bh)		;961f
	or a			;9622
	ret nz			;9623
	ld a,h			;9624
	cp 003h		;9625
	ret c			;9627
CHOQUE:		; bit 3 de (ix+1); objeto -> p03 0xB559; coche: (ix+2C) = 0, (ix+2B) = 1
	set 3,(ix+001h)		;9628
	ld a,(ix+000h)		;962c
	or a			;962f
	jp nz,0b559h		;9630
	ld (ix+02ch),000h		;9633
	ld (ix+02bh),001h		;9637
	ret			;963b
SIN_REPETIR_BORDE:		; (ix+28) = 0
	ld (ix+028h),000h		;963c
	ret			;9640
CLASE_DE_TILE:		; A = tile -> clase 0..15 por los 15 umbrales E264..E272 (arbol de comparaciones): clase par si < umbral, impar si >= (E264: 0/1, E265: 2.., E26B: 8.., E26F: 12..)
	ld h,0e2h		;9641
	ld l,06bh		;9643
	cp (hl)			;9645
	jr nc,CLASE_8_15		;9646
	ld l,067h		;9648
	cp (hl)			;964a
	jr nc,CLASE_4_7		;964b
	ld l,065h		;964d
	cp (hl)			;964f
	jr nc,CLASE_2_3		;9650
	ld l,064h		;9652
	cp (hl)			;9654
	jr nc,CLASE_1		;9655
	ld a,000h		;9657
	ret			;9659
CLASE_2_3:		; E266
	ld l,066h		;965a
	cp (hl)			;965c
	jr nc,CLASE_3		;965d
	ld a,002h		;965f
	ret			;9661
CLASE_4_7:		; E268/E269
	ld l,069h		;9662
	cp (hl)			;9664
	jr nc,CLASE_6_7		;9665
	ld l,068h		;9667
	cp (hl)			;9669
	jr nc,CLASE_5		;966a
	ld a,004h		;966c
	ret			;966e
CLASE_6_7:		; E26A
	ld l,06ah		;966f
	cp (hl)			;9671
	jr nc,CLASE_7		;9672
	ld a,006h		;9674
	ret			;9676
CLASE_8_15:		; E26F
	ld l,06fh		;9677
	cp (hl)			;9679
	jr nc,CLASE_12_15		;967a
	ld l,06dh		;967c
	cp (hl)			;967e
	jr nc,CLASE_10_11		;967f
	ld l,06ch		;9681
	cp (hl)			;9683
	jr nc,CLASE_9		;9684
	ld a,008h		;9686
	ret			;9688
CLASE_10_11:		; E26E
	ld l,06eh		;9689
	cp (hl)			;968b
	jr nc,CLASE_11		;968c
	ld a,00ah		;968e
	ret			;9690
CLASE_12_15:		; E271/E270
	ld l,071h		;9691
	cp (hl)			;9693
	jr nc,CLASE_14_15		;9694
	ld l,070h		;9696
	cp (hl)			;9698
	jr nc,CLASE_13		;9699
	ld a,00ch		;969b
	ret			;969d
CLASE_14_15:		; E272
	ld l,072h		;969e
	cp (hl)			;96a0
	jr nc,CLASE_15		;96a1
	ld a,00eh		;96a3
	ret			;96a5
CLASE_1:		; A = 1
	ld a,001h		;96a6
	ret			;96a8
CLASE_3:		; A = 3
	ld a,003h		;96a9
	ret			;96ab
CLASE_5:		; A = 5
	ld a,005h		;96ac
	ret			;96ae
CLASE_7:		; A = 7
	ld a,007h		;96af
	ret			;96b1
CLASE_9:		; A = 9
	ld a,009h		;96b2
	ret			;96b4
CLASE_11:		; A = 11
	ld a,00bh		;96b5
	ret			;96b7
CLASE_13:		; A = 13
	ld a,00dh		;96b8
	ret			;96ba
CLASE_15:		; A = 15
	ld a,00fh		;96bb
	ret			;96bd
ANGULO_OBJETO:		; angulo += (ix+13); si sale de -0x20..0x20 se queda en +-0x20
	ld a,(ix+013h)		;96be
	add a,(ix+00ch)		;96c1
	ld (ix+00ch),a		;96c4
	add a,020h		;96c7
	cp 041h		;96c9
	ret c			;96cb
	ld a,(ix+00ch)		;96cc
	or a			;96cf
	ld a,020h		;96d0
	jp p,ANGULO_OBJETO_TOPE		;96d2
	ld a,0e0h		;96d5
ANGULO_OBJETO_TOPE:		; (ix+C) = +-0x20
	ld (ix+00ch),a		;96d7
	ret			;96da
ANGULO_COCHE:		; (ix+C,D) += (ix+13)/8 (fraccion en ix+D); fuera de -0x20..0x20 y sin derrape: tope +-0x20 y, si venia con bit 7 (exceso de velocidad), fuera de RALLY, (ix+53) >= 10 y girando al mismo lado: (ix+39) = angulo y bit 6 (derrape)
	ld a,(ix+02ch)		;96db
	or (ix+010h)		;96de
	or (ix+011h)		;96e1
	ld h,(ix+00ch)		;96e4
	ld l,(ix+00dh)		;96e7
	ld d,(ix+013h)		;96ea
	ld e,000h		;96ed
	sra d		;96ef
	rr e		;96f1
	sra d		;96f3
	rr e		;96f5
	sra d		;96f7
	rr e		;96f9
	add hl,de			;96fb
	ld a,h			;96fc
	add a,020h		;96fd
	cp 041h		;96ff
	ld (ix+00ch),h		;9701
	ld (ix+00dh),l		;9704
	ld a,h			;9707
	add a,020h		;9708
	cp 041h		;970a
	ret c			;970c
	bit 6,(ix+001h)		;970d
	ret nz			;9711
	ld a,(ix+00ch)		;9712
	or a			;9715
	ld a,020h		;9716
	jp p,ANGULO_COCHE_TOPE		;9718
	ld a,0e0h		;971b
ANGULO_COCHE_TOPE:		; (ix+C) = +-0x20
	ld (ix+00ch),a		;971d
	bit 7,(ix+001h)		;9720
	ret z			;9724
	ld a,(0e25bh)		;9725
	or a			;9728
	ret z			;9729
	ld a,(ix+053h)		;972a
	cp 00ah		;972d
	ret c			;972f
	ld a,(ix+013h)		;9730
	or a			;9733
	ret z			;9734
	xor (ix+00ch)		;9735
	ret m			;9738
	ld a,(ix+00ch)		;9739
	ld (ix+039h),a		;973c
	set 6,(ix+001h)		;973f
	ret			;9743
VELOCIDAD_COCHE:		; tope por el angulo (0x980D: C si se paso); acelera (0x97AB); vy = sin(angulo) * v, vx = cos(angulo) * v (0x9B12)
	call EXCESO_COCHE		;9744
	ret c			;9747
	call ACELERA_COCHE		;9748
	ld a,(ix+00ch)		;974b
	call SENO		;974e
	ld e,(ix+010h)		;9751
	ld d,(ix+011h)		;9754
	call PRODUCTO_8_8		;9757
	ld (ix+00bh),h		;975a
	ld (ix+00ah),l		;975d
	ld a,(ix+00ch)		;9760
	call COSENO		;9763
	ld e,(ix+010h)		;9766
	ld d,(ix+011h)		;9769
	call PRODUCTO_8_8		;976c
	ld (ix+008h),h		;976f
	ld (ix+007h),l		;9772
	ret			;9775
VELOCIDAD_OBJETO:		; exceso del coche guia (0x97FF); acelera (0x97DC); vy, vx como arriba
	bit 7,(ix+001h)		;9776
	call nz,EXCESO_OBJETO		;977a
	call ACELERA_OBJETO		;977d
	ld a,(ix+00ch)		;9780
	call SENO		;9783
	ld e,(ix+010h)		;9786
	ld d,(ix+011h)		;9789
	call PRODUCTO_8_8		;978c
	ld (ix+00bh),h		;978f
	ld (ix+00ah),l		;9792
	ld a,(ix+00ch)		;9795
	call COSENO		;9798
	ld e,(ix+010h)		;979b
	ld d,(ix+011h)		;979e
	call PRODUCTO_8_8		;97a1
	ld (ix+008h),h		;97a4
	ld (ix+007h),l		;97a7
	ret			;97aa
ACELERA_COCHE:		; v += (ix+12) con signo (minimo 0); tope (ix-20,-1F) (menos 0x100 con el neumatico bit 2); p00 0x4A4F
	ld a,(ix+012h)		;97ab
	ld l,a			;97ae
	rla			;97af
	sbc a,a			;97b0
	ld h,a			;97b1
	ld e,(ix+010h)		;97b2
	ld d,(ix+011h)		;97b5
	add hl,de			;97b8
	ex de,hl			;97b9
	ld a,d			;97ba
	or a			;97bb
	jp p,ACELERA_TOPE		;97bc
	ld de,00000h		;97bf
ACELERA_TOPE:		; HL = velocidad maxima del motor
	ld h,(ix-01fh)		;97c2
	ld l,(ix-020h)		;97c5
	bit 2,(ix+068h)		;97c8
	jr z,ACELERA_COMPARA		;97cc
	dec h			;97ce
ACELERA_COMPARA:		; p00 0x4A4F: HL - DE
	call 04a4fh		;97cf
	jr nc,ACELERA_GUARDA		;97d2
	ex de,hl			;97d4
ACELERA_GUARDA:		; (ix+10,11) = DE
	ld (ix+010h),e		;97d5
	ld (ix+011h),d		;97d8
	ret			;97db
ACELERA_OBJETO:		; v += (ix+12) con signo, sin pasar de 0 ni de 0xFFFF
	ld a,(ix+012h)		;97dc
	ld l,a			;97df
	rla			;97e0
	sbc a,a			;97e1
	ld h,a			;97e2
	or a			;97e3
	ld e,(ix+010h)		;97e4
	ld d,(ix+011h)		;97e7
	jp m,ACELERA_OBJETO_NEG		;97ea
	add hl,de			;97ed
	ret c			;97ee
	ld (ix+010h),l		;97ef
	ld (ix+011h),h		;97f2
	ret			;97f5
ACELERA_OBJETO_NEG:		; resta
	add hl,de			;97f6
	ret nc			;97f7
	ld (ix+010h),l		;97f8
	ld (ix+011h),h		;97fb
	ret			;97fe
EXCESO_OBJETO:		; si el coche guia (IY) tiene el bit 7: 0x9814 y bit 7 del objeto
	bit 7,(iy+001h)		;97ff
	jr z,EXCESO_CORRIGE		;9803
	call EXCESO_CORRIGE		;9805
	set 7,(ix+001h)		;9808
	ret			;980c
EXCESO_COCHE:		; bit 7 de (ix+1) -> 0x9814; si no 0x9893
	bit 7,(ix+001h)		;980d
	jp z,EXCESO_ENTRA		;9811
EXCESO_CORRIGE:		; 0x98CF; desvio entre vy real y la que toca (|H - (ix+B)|, tope 8) -> C; (ix+53)++; tope = tabla 0x988B[C] (RALLY: 0x986B[terreno] -> 0x988B) comparado con v alta: si la pasa -> bit 7 fuera, v = -vx (invierte?), (ix+53) = 0, C
	call ARRASTRE		;9814
	ld hl,(0ea50h)		;9817
	ld e,(ix+010h)		;981a
	ld d,(ix+011h)		;981d
	call PRODUCTO_8_8		;9820
	ld a,h			;9823
	sub (ix+00bh)		;9824
	jp p,EXCESO_TOPE_8		;9827
	neg		;982a
EXCESO_TOPE_8:		; C = min(desvio, 8)
	cp 008h		;982c
	jr c,EXCESO_TABLA		;982e
	ld a,008h		;9830
EXCESO_TABLA:		; la tabla por categoria
	ld c,a			;9832
	ld b,000h		;9833
	inc (ix+053h)		;9835
	ld a,(0e25bh)		;9838
	or a			;983b
	ld hl,0988bh		;983c
	jr nz,EXCESO_COMPARA		;983f
	ld hl,0986bh		;9841
	ld a,(ix+022h)		;9844
	call 04a44h		;9847
EXCESO_COMPARA:		; tabla[C] < v alta -> corrige
	add hl,bc			;984a
	ld a,(hl)			;984b
	cp (ix+011h)		;984c
	ret c			;984f
	res 7,(ix+001h)		;9850
	ld a,(ix+008h)		;9854
	cpl			;9857
	ld h,a			;9858
	ld a,(ix+007h)		;9859
	cpl			;985c
	ld l,a			;985d
	inc hl			;985e
	ld (ix+011h),h		;985f
	ld (ix+010h),l		;9862
	ld (ix+053h),000h		;9865
	scf			;9869
	ret			;986a

; ----------------------------------------------------------------------
; DATOS tabla_exceso_rally: 16 punteros (terreno) a 0x988B
;   0x986b..0x988b  (32 bytes)
DATA_tabla_exceso_rally:
	defw 0988bh,0988bh,0988bh,0988bh,0988bh,0988bh,0988bh,0988bh	; 986b
	defw 0988bh,0988bh,0988bh,0988bh,0988bh,0988bh,0988bh,0988bh	; 987b

; ----------------------------------------------------------------------
; DATOS tabla_exceso: 8 topes de velocidad (byte alto) por desvio 0..7: FF 9 8
;   7 6 5 4 3 (el desvio 8 lee el byte siguiente)
;   0x988b..0x9893  (8 bytes)
DATA_tabla_exceso:
	defb 0ffh,009h,008h,007h,006h,005h,004h,003h	; 988b  ........

; ======================================================================
; CODIGO 0x9893..0x993e  (171 bytes)
; ======================================================================


EXCESO_ENTRA:		; RALLY: v alta < 15: umbral = 0x994E[v alta] * |volante| * 8 + (aceleracion & 0x70) >> 4; si pasa de 0x993E[terreno] -> bit 7 (derrape por exceso) y 0x98CF
	ld a,(0e25bh)		;9893
	or a			;9896
	ret nz			;9897
	ld a,(ix+011h)		;9898
	cp 00fh		;989b
	ret nc			;989d
	ld hl,0994eh		;989e
	call 040d0h		;98a1
	ld h,(hl)			;98a4
	ld a,(ix+013h)		;98a5
	or a			;98a8
	jp p,EXCESO_PRODUCTO		;98a9
	neg		;98ac
EXCESO_PRODUCTO:		; HL = cuadrado * |volante|
	ld e,a			;98ae
	call MULTIPLICA_H_E		;98af
	add hl,hl			;98b2
	add hl,hl			;98b3
	add hl,hl			;98b4
	ld a,(ix+012h)		;98b5
	and 070h		;98b8
	rrca			;98ba
	rrca			;98bb
	rrca			;98bc
	rrca			;98bd
	add a,h			;98be
	ld l,(ix+022h)		;98bf
	ld h,000h		;98c2
	ld de,0993eh		;98c4
	add hl,de			;98c7
	cp (hl)			;98c8
	ccf			;98c9
	ret nc			;98ca
	set 7,(ix+001h)		;98cb
ARRASTRE:		; B = min(aceleracion, 0x10); vy -= (sin * B * 2 + vy)/8, vx idem con cos; v -= v/8 (p00 0x4A7E); C
	ld a,(ix+012h)		;98cf
	cp 080h		;98d2
	jr c,ARRASTRE_TOPE		;98d4
	ld a,010h		;98d6
ARRASTRE_TOPE:		; B = min(A, 0x10)
	cp 010h		;98d8
	jr nc,ARRASTRE_VA		;98da
	ld a,010h		;98dc
ARRASTRE_VA:		; el calculo
	ld b,a			;98de
	ld a,(ix+00ch)		;98df
	call SENO		;98e2
	ld (0ea50h),hl		;98e5
	ld e,b			;98e8
	ld d,000h		;98e9
	call PRODUCTO_8_8		;98eb
	add hl,hl			;98ee
	ld d,(ix+00bh)		;98ef
	ld e,(ix+00ah)		;98f2
	add hl,de			;98f5
	ld d,h			;98f6
	ld e,l			;98f7
	call 04a7eh		;98f8
	ex de,hl			;98fb
	or a			;98fc
	sbc hl,de		;98fd
	ld (ix+00bh),h		;98ff
	ld (ix+00ah),l		;9902
	ld a,(ix+00ch)		;9905
	call COSENO		;9908
	ld e,b			;990b
	ld d,000h		;990c
	call PRODUCTO_8_8		;990e
	add hl,hl			;9911
	ld d,(ix+008h)		;9912
	ld e,(ix+007h)		;9915
	add hl,de			;9918
	ld d,h			;9919
	ld e,l			;991a
	call 04a7eh		;991b
	ex de,hl			;991e
	or a			;991f
	sbc hl,de		;9920
	ld (ix+008h),h		;9922
	ld (ix+007h),l		;9925
	ld l,(ix+010h)		;9928
	ld h,(ix+011h)		;992b
	ld d,h			;992e
	ld e,l			;992f
	call 04a7eh		;9930
	ex de,hl			;9933
	sbc hl,de		;9934
	ld (ix+010h),l		;9936
	ld (ix+011h),h		;9939
	scf			;993c
	ret			;993d

; ----------------------------------------------------------------------
; DATOS tabla_exceso_terreno: 16 umbrales por terreno (0x37, salvo 0x50 en el
;   10)
;   0x993e..0x994e  (16 bytes)
DATA_tabla_exceso_terreno:
	defb 037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,050h,037h,037h,037h,037h,037h	; 993e  7777777777P77777

; ----------------------------------------------------------------------
; DATOS tabla_cuadrados: 16 cuadrados 1, 4, 9, 16.. 0xFF (y 4 x 0xFF)
;   0x994e..0x9962  (20 bytes)
DATA_tabla_cuadrados:
	defb 001h,004h,009h,010h,019h,024h,031h,040h,051h,064h,079h,090h,0a9h,0c4h,0e1h,0ffh,0ffh,0ffh,0ffh,0ffh	; 994e  .....$1@Qdy.........

; ======================================================================
; CODIGO 0x9962..0x99e1  (127 bytes)
; ======================================================================


FOTOGRAMA_OBJETO:		; un fotograma de cada dos por jugador; 0x996A
	ld a,(0e1c3h)		;9962
	xor (ix+009h)		;9965
	rrca			;9968
	ret c			;9969
FOTOGRAMA_OBJETO_VA:		; efecto 0x8X -> tablas 0x99E1/0x99F1 (0x99BE); si no fotograma = 0x9AA3[angulo] (+5 cada 2 fotogramas en F3/F3000/F1: ruedas); (ix+33) = patron EB40[(ix+18)&3] + fotograma*8 (o el fotograma si >= 0x80)
	ld a,(ix+02ch)		;996a
	bit 7,a		;996d
	jr nz,FOTOGRAMA_EFECTO		;996f
	ld a,(ix+00ch)		;9971
	add a,008h		;9974
	rrca			;9976
	rrca			;9977
	rrca			;9978
	rrca			;9979
	and 00fh		;997a
	neg		;997c
	add a,010h		;997e
	and 00fh		;9980
	ld de,09aa3h		;9982
	ld l,a			;9985
	ld h,000h		;9986
	add hl,de			;9988
	ld a,(0e25bh)		;9989
	cp 003h		;998c
	ld a,000h		;998e
	jr c,FOTOGRAMA_SUMA		;9990
	ld a,(0e1c3h)		;9992
	and 002h		;9995
	ld a,000h		;9997
	jr nz,FOTOGRAMA_SUMA		;9999
	ld a,005h		;999b
FOTOGRAMA_SUMA:		; + tabla
	add a,(hl)			;999d
FOTOGRAMA_GUARDA:		; si cambia: (ix+E) = A y el patron (ix+33) desde EB40+0x40+(ix+18)&3
	cp (ix+00eh)		;999e
	ret z			;99a1
	ld (ix+00eh),a		;99a2
	ld a,(ix+018h)		;99a5
	and 003h		;99a8
	add a,040h		;99aa
	ld l,a			;99ac
	ld h,0ebh		;99ad
	ld a,(ix+00eh)		;99af
	cp 080h		;99b2
	jr nc,PATRON_GUARDA		;99b4
	add a,a			;99b6
	add a,a			;99b7
	add a,a			;99b8
	add a,(hl)			;99b9
PATRON_GUARDA:		; (ix+33) = A
	ld (ix+033h),a		;99ba
	ret			;99bd
FOTOGRAMA_EFECTO:		; tabla 0x99E1 (0x81) o 0x99F1 (0x82) por angulo
	and 07fh		;99be
	dec a			;99c0
	ld de,099e1h		;99c1
	jr z,FOTOGRAMA_EFECTO_ANGULO		;99c4
	ld de,099f1h		;99c6
FOTOGRAMA_EFECTO_ANGULO:		; indice = (-(angulo+8) >> 4) & 0x0F
	ld a,(ix+00ch)		;99c9
	add a,008h		;99cc
	rrca			;99ce
	rrca			;99cf
	rrca			;99d0
	rrca			;99d1
	and 00fh		;99d2
	neg		;99d4
	add a,010h		;99d6
	and 00fh		;99d8
	ld l,a			;99da
	ld h,000h		;99db
	add hl,de			;99dd
	ld a,(hl)			;99de
	jr FOTOGRAMA_GUARDA		;99df

; ----------------------------------------------------------------------
; DATOS tablas_fotograma_efecto: 2 x 16 fotogramas por angulo para los efectos
;   0x81 y 0x82 de los objetos
;   0x99e1..0x9a01  (32 bytes)
DATA_tablas_fotograma_efecto:
	defb 006h,006h,006h,007h,007h,007h,007h,0ffh,0ffh,0ffh,005h,005h,005h,005h,006h,006h	; 99e1  ................
	defb 009h,009h,009h,00ah,00ah,00ah,00ah,0ffh,0ffh,0ffh,008h,008h,008h,008h,009h,009h	; 99f1  ................

; ======================================================================
; CODIGO 0x9a01..0x9a83  (130 bytes)
; ======================================================================


FOTOGRAMA_COCHE:		; choque (bit 3) -> explosion (0x9AB3); efecto 0x8X -> 0x9A83/0x9A93; si no 0x9AA3[angulo] + 5 cada 2 fotogramas si se mueve (no RALLY/STOCK/ENDURANCE, no carroceria 0x13) salvo bit 6 de la tabla; (ix+E) = A si cambia
	bit 3,(ix+001h)		;9a01
	jp nz,EXPLOSION		;9a05
	ld a,(ix+02ch)		;9a08
	bit 7,a		;9a0b
	jr nz,FOTOGRAMA_COCHE_EFECTO		;9a0d
	ld a,(ix+00ch)		;9a0f
	add a,008h		;9a12
	rrca			;9a14
	rrca			;9a15
	rrca			;9a16
	rrca			;9a17
	and 00fh		;9a18
	neg		;9a1a
	add a,010h		;9a1c
	and 00fh		;9a1e
	ld de,09aa3h		;9a20
	ld l,a			;9a23
	ld h,000h		;9a24
	add hl,de			;9a26
	ld a,(ix+010h)		;9a27
	or (ix+011h)		;9a2a
	ld a,000h		;9a2d
	jr z,FOTOGRAMA_COCHE_FIJO		;9a2f
	ld a,(0e25bh)		;9a31
	cp 003h		;9a34
	ld a,000h		;9a36
	jr c,FOTOGRAMA_COCHE_FIJO		;9a38
	ld a,(ix+018h)		;9a3a
	cp 013h		;9a3d
	ld a,000h		;9a3f
	jr z,FOTOGRAMA_COCHE_FIJO		;9a41
	ld a,(0e1c3h)		;9a43
	and 002h		;9a46
	ld a,000h		;9a48
	jr nz,FOTOGRAMA_COCHE_FIJO		;9a4a
	ld a,005h		;9a4c
FOTOGRAMA_COCHE_FIJO:		; bit 6 de la tabla: sin animar
	bit 6,(hl)		;9a4e
	jr nz,FOTOGRAMA_COCHE_TABLA		;9a50
	add a,(hl)			;9a52
	jr FOTOGRAMA_COCHE_GUARDA		;9a53
FOTOGRAMA_COCHE_TABLA:		; A = tabla
	ld a,(hl)			;9a55
FOTOGRAMA_COCHE_GUARDA:		; (ix+E) = A si cambia
	cp (ix+00eh)		;9a56
	ret z			;9a59
	ld (ix+00eh),a		;9a5a
	ret			;9a5d
FOTOGRAMA_COCHE_EFECTO:		; tablas 0x9A83/0x9A93
	and 07fh		;9a5e
	dec a			;9a60
	ld de,09a83h		;9a61
	jr z,FOTOGRAMA_COCHE_EFECTO_ANGULO		;9a64
	ld de,09a93h		;9a66
FOTOGRAMA_COCHE_EFECTO_ANGULO:		; por angulo
	ld a,(ix+00ch)		;9a69
	add a,008h		;9a6c
	rrca			;9a6e
	rrca			;9a6f
	rrca			;9a70
	rrca			;9a71
	and 00fh		;9a72
	neg		;9a74
	add a,010h		;9a76
	and 00fh		;9a78
	ld l,a			;9a7a
	ld h,000h		;9a7b
	add hl,de			;9a7d
	ld a,(hl)			;9a7e
	ld (ix+00eh),a		;9a7f
	ret			;9a82

; ----------------------------------------------------------------------
; DATOS tablas_fotograma_coche_efecto: 2 x 16 fotogramas por angulo (efectos
;   0x81/0x82 del coche)
;   0x9a83..0x9aa3  (32 bytes)
DATA_tablas_fotograma_coche_efecto:
	defb 006h,006h,006h,007h,007h,007h,007h,0ffh,0ffh,0ffh,007h,007h,005h,005h,006h,006h	; 9a83  ................
	defb 009h,009h,009h,00ah,00ah,00ah,00ah,0ffh,0ffh,0ffh,00ah,00ah,008h,008h,009h,009h	; 9a93  ................

; ----------------------------------------------------------------------
; DATOS tabla_fotograma_angulo: 16 fotogramas por angulo (indice (-(angulo+8)
;   >> 4) & 0x0F): 2 3 4 4 40 40 41 41 42 42 43 44 44 0 0 1 (bit 6 = fijo)
;   0x9aa3..0x9ab3  (16 bytes)
DATA_tabla_fotograma_angulo:
	defb 002h,003h,004h,004h,040h,040h,041h,041h,042h,042h,043h,044h,044h,000h,000h,001h	; 9aa3  ....@@AABBCDD...

; ======================================================================
; CODIGO 0x9ab3..0x9ad1  (30 bytes)
; ======================================================================


EXPLOSION:		; cada 5 fotogramas (ix+2C)++ hasta 10: fotograma = 0x9AD1[(ix+2C)]
	dec (ix+02bh)		;9ab3
	ret nz			;9ab6
	ld (ix+02bh),005h		;9ab7
	ld a,(ix+02ch)		;9abb
	cp 00ah		;9abe
	jr nc,$+35		;9ac0
	inc a			;9ac2
	ld (ix+02ch),a		;9ac3
	ld e,a			;9ac6
	ld d,000h		;9ac7
	ld hl,09ad1h		;9ac9
	add hl,de			;9acc
	ld a,(hl)			;9acd
	jp FOTOGRAMA_COCHE_GUARDA		;9ace

; ----------------------------------------------------------------------
; DATOS tabla_explosion: 18 fotogramas 0x80..0x85 (0x82..0x85 repetidos)
;   0x9ad1..0x9ae3  (18 bytes)
DATA_tabla_explosion:
	defb 080h,081h,082h,083h,084h,085h,082h,083h,084h,085h,082h,083h,084h,085h,082h,083h,084h,085h	; 9ad1  ..................

; ======================================================================
; CODIGO 0x9ae3..0x9b97  (180 bytes)
; ======================================================================


OBJETO_QUITA_SI_TIPO:		; si (ix+0) != 0 -> 0x9E2D
	ld a,(ix+000h)		;9ae3
	or a			;9ae6
	jp nz,QUITA_OBJETO		;9ae7
	ret			;9aea
L_9AEB:
	ld d,(ix+004h)		;9aeb
	ld e,(ix+003h)		;9aee
	ld h,(ix+008h)		;9af1
	ld l,(ix+007h)		;9af4
	add hl,de			;9af7
	ld (ix+004h),h		;9af8
	ld (ix+003h),l		;9afb
AVANZA_Y:		; (ix+5,6) += vy (ix+A,B)
	ld h,(ix+006h)		;9afe
	ld l,(ix+005h)		;9b01
	ld d,(ix+00bh)		;9b04
	ld e,(ix+00ah)		;9b07
	add hl,de			;9b0a
	ld (ix+006h),h		;9b0b
	ld (ix+005h),l		;9b0e
	ret			;9b11
PRODUCTO_8_8:		; HL (seno/coseno con signo, -0x100..0xFF) * DE (velocidad) / 256 con signo: 0xFFxx = -1 -> -DE; 0x00xx = 1 -> DE; si no (L*16 * DE) / 2 por 0x9B4F y p00 0x4A8A
	ld a,l			;9b12
	inc a			;9b13
	jr nz,PRODUCTO_FRACCION		;9b14
	ld a,h			;9b16
	or a			;9b17
	jp p,PRODUCTO_UNO		;9b18
	ld hl,00000h		;9b1b
	sbc hl,de		;9b1e
	ret			;9b20
PRODUCTO_UNO:		; HL = DE
	ex de,hl			;9b21
	ret			;9b22
PRODUCTO_FRACCION:		; el producto por 0x9B4F
	ld a,h			;9b23
	ex de,hl			;9b24
	add hl,hl			;9b25
	add hl,hl			;9b26
	add hl,hl			;9b27
	add hl,hl			;9b28
	or a			;9b29
	jp p,PRODUCTO_POSITIVO		;9b2a
	call MULTIPLICA_H_E		;9b2d
	srl h		;9b30
	rr l		;9b32
	ex de,hl			;9b34
	xor a			;9b35
	ld h,a			;9b36
	ld l,a			;9b37
	sbc hl,de		;9b38
	jp 04a8ah		;9b3a
PRODUCTO_POSITIVO:		; sin signo
	call MULTIPLICA_H_E		;9b3d
	srl h		;9b40
	rr l		;9b42
	jp 04a8ah		;9b44
L_9B47:
	call MULT_BIT_3		;9b47
	add hl,hl			;9b4a
	add hl,hl			;9b4b
	add hl,hl			;9b4c
	add hl,hl			;9b4d
	ret			;9b4e
MULTIPLICA_H_E:		; HL = H * E (8 x 8 bits, sin signo)
	ld d,000h		;9b4f
	ld l,d			;9b51
	add hl,hl			;9b52
	jr nc,MULT_BIT_6		;9b53
	add hl,de			;9b55
MULT_BIT_6:		; bit 6
	add hl,hl			;9b56
	jr nc,MULT_BIT_5		;9b57
	add hl,de			;9b59
MULT_BIT_5:		; bit 5
	add hl,hl			;9b5a
	jr nc,MULT_BIT_4		;9b5b
	add hl,de			;9b5d
MULT_BIT_4:		; bit 4
	add hl,hl			;9b5e
	jr nc,MULT_BIT_3		;9b5f
	add hl,de			;9b61
MULT_BIT_3:		; bit 3
	add hl,hl			;9b62
	jr nc,MULT_BIT_2		;9b63
	add hl,de			;9b65
MULT_BIT_2:		; bit 2
	add hl,hl			;9b66
	jr nc,MULT_BIT_1		;9b67
	add hl,de			;9b69
MULT_BIT_1:		; bit 1
	add hl,hl			;9b6a
	jr nc,MULT_BIT_0		;9b6b
	add hl,de			;9b6d
MULT_BIT_0:		; bit 0
	add hl,hl			;9b6e
	jr nc,MULT_FIN		;9b6f
	add hl,de			;9b71
MULT_FIN:		; ret
	ret			;9b72
SENO:		; A = angulo - 0x40 y coseno: HL = sen(angulo) (0x9B75 con A - 0x40)
	sub 040h		;9b73
COSENO:		; A -= 0x40: HL = tabla 0x9B97[A] (0..0x80: 0..0xFF..0), negativo -> H = 0xFF y -A
	sub 040h		;9b75
	jp p,SENO_POSITIVO		;9b77
	cp 080h		;9b7a
	jr z,SENO_POSITIVO		;9b7c
	neg		;9b7e
	call TABLA_SENO		;9b80
	ld h,0ffh		;9b83
	ld l,a			;9b85
	ret			;9b86
SENO_POSITIVO:		; H = 0, L = tabla[A]
	call TABLA_SENO		;9b87
	ld h,000h		;9b8a
	ld l,a			;9b8c
	ret			;9b8d
TABLA_SENO:		; A = 0x9B97[A]
	ld hl,09b97h		;9b8e
	ld e,a			;9b91
	ld d,000h		;9b92
	add hl,de			;9b94
	ld a,(hl)			;9b95
	ret			;9b96

; ----------------------------------------------------------------------
; DATOS tabla_seno: 129 bytes: medio seno 0 -> 0xFF -> 0 (angulo en 1/256 de
;   vuelta, 0x80 = media vuelta)
;   0x9b97..0x9c18  (129 bytes)
DATA_tabla_seno:
	defb 000h,006h,00ch,012h,019h,01fh,025h,02bh,031h,038h,03eh,044h,04ah,050h,056h,05ch	; 9b97  ......%+18>DJPV\
	defb 061h,067h,06dh,073h,078h,07eh,083h,088h,08eh,093h,098h,09dh,0a2h,0a7h,0abh,0b0h	; 9ba7  agmsx~..........
	defb 0b5h,0b9h,0bdh,0c1h,0c5h,0c9h,0cdh,0d1h,0d4h,0d8h,0dbh,0deh,0e1h,0e4h,0e7h,0eah	; 9bb7  ................
	defb 0ech,0eeh,0f1h,0f3h,0f4h,0f6h,0f8h,0f9h,0fbh,0fch,0fdh,0feh,0feh,0ffh,0ffh,0ffh	; 9bc7  ................
	defb 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0fdh,0fch,0fbh,0f9h,0f8h,0f6h,0f4h,0f3h,0f1h,0eeh	; 9bd7  ................
	defb 0ech,0eah,0e7h,0e4h,0e1h,0deh,0dbh,0d8h,0d4h,0d1h,0cdh,0c9h,0c5h,0c1h,0bdh,0b9h	; 9be7  ................
	defb 0b5h,0b0h,0abh,0a7h,0a2h,09dh,098h,093h,08eh,088h,083h,07eh,078h,073h,06dh,067h	; 9bf7  ...........~xsmg
	defb 061h,05ch,056h,050h,04ah,044h,03eh,038h,031h,02bh,025h,01fh,019h,012h,00ch,006h	; 9c07  a\VPJD>81+%.....
	defb 000h	; 9c17

; ======================================================================
; CODIGO 0x9c18..0x9c84  (108 bytes)
; ======================================================================


PAR_MOTOR:		; revoluciones (0x9C45); A = (revs & 0xF8) / 8 (>= 16 -> 0xFF); HL = p09 0xB72E + (ix+74)*16 + A; pagina 9 en A000, lee, 1/2/3
	call REVOLUCIONES		;9c18
	ld a,h			;9c1b
	ld l,(ix+074h)		;9c1c
PAR_MOTOR_INDICE:		; HL = L*16 (tambien entra 0x89BA con L = motor)
	ld h,000h		;9c1f
	add hl,hl			;9c21
	add hl,hl			;9c22
	add hl,hl			;9c23
	add hl,hl			;9c24
	and 0f8h		;9c25
	rrca			;9c27
	rrca			;9c28
	rrca			;9c29
	cp 010h		;9c2a
	jr nc,PAR_FF		;9c2c
	ld de,0b72eh		;9c2e
	add hl,de			;9c31
	ld e,a			;9c32
	ld d,000h		;9c33
	add hl,de			;9c35
	ld a,009h		;9c36
	call 04457h		;9c38
	ld a,(hl)			;9c3b
	push af			;9c3c
	call 043feh		;9c3d
	pop af			;9c40
	ret			;9c41
PAR_FF:		; A = 0xFF
	ld a,0ffh		;9c42
	ret			;9c44
REVOLUCIONES:		; marcha 0: si la velocidad da < 0x14, (ix+59) = 0x1B (ralenti); si no 0x9C59
	ld a,(ix+069h)		;9c45
	or a			;9c48
	jr nz,REVOLUCIONES_MARCHA		;9c49
	call REVOLUCIONES_MARCHA		;9c4b
	ld a,h			;9c4e
	cp 014h		;9c4f
	ret nc			;9c51
	ld hl,01b58h		;9c52
	ld (ix+059h),h		;9c55
	ret			;9c58
REVOLUCIONES_MARCHA:		; (ix+59) = H de 0x9C69 con L = caja (ix+75), A = marcha, BC = velocidad
	ld l,(ix+075h)		;9c59
	ld c,(ix+010h)		;9c5c
	ld b,(ix+011h)		;9c5f
	call RELACION_POR_VELOCIDAD		;9c62
	ld (ix+059h),h		;9c65
	ret			;9c68
RELACION_POR_VELOCIDAD:		; (EA50) = caja*4 + marcha; E = 0x9C84[eso]; HL = velocidad*16 * E (0x9B4F: H*E con H = byte alto de v*16)
	ld h,000h		;9c69
	ld d,h			;9c6b
	ld e,l			;9c6c
	add hl,hl			;9c6d
	add hl,hl			;9c6e
	ld e,a			;9c6f
	ld d,000h		;9c70
	add hl,de			;9c72
	ld (0ea50h),hl		;9c73
	ld de,09c84h		;9c76
	add hl,de			;9c79
	ld e,(hl)			;9c7a
	ld h,b			;9c7b
	ld l,c			;9c7c
	add hl,hl			;9c7d
	add hl,hl			;9c7e
	add hl,hl			;9c7f
	add hl,hl			;9c80
	jp MULTIPLICA_H_E		;9c81

; ----------------------------------------------------------------------
; DATOS tabla_relaciones: 9 cajas (ix+75) x 4 marchas: factor de revoluciones
;   por velocidad
;   0x9c84..0x9ca8  (36 bytes)
DATA_tabla_relaciones:
	defb 0ffh,0b6h,079h,05bh	; 9c84
	defb 0fch,0b1h,073h,05bh	; 9c88
	defb 0f0h,09bh,06fh,05bh	; 9c8c
	defb 0ffh,091h,060h,040h	; 9c90
	defb 0fch,091h,060h,040h	; 9c94
	defb 0f0h,088h,058h,040h	; 9c98
	defb 0ffh,0a0h,06ah,046h	; 9c9c
	defb 0ffh,0a0h,06ah,046h	; 9ca0
	defb 0ffh,096h,061h,046h	; 9ca4

; ======================================================================
; CODIGO 0x9ca8..0x9ce2  (58 bytes)
; ======================================================================


ACELERACION_MOTOR:		; (ix+5F) != 0: cuenta atras y aceleracion 0; si no par (0x9C18): 0xFF -> 0 (0x9CC5); si no (ix+12) = par * relacion (0x9CCF)
	ld a,(ix+05fh)		;9ca8
	or a			;9cab
	jr z,ACELERACION_PAR		;9cac
	dec a			;9cae
	ld (ix+05fh),a		;9caf
	ld (ix+012h),000h		;9cb2
	ret			;9cb6
ACELERACION_PAR:		; par y relacion
	call PAR_MOTOR		;9cb7
	cp 0ffh		;9cba
	jr z,ACELERACION_E0		;9cbc
	call PAR_POR_RELACION		;9cbe
	ld (ix+012h),a		;9cc1
	ret			;9cc4
L_9CC5:
	ld (ix+012h),000h		;9cc5
	ret			;9cc9
ACELERACION_E0:		; (ix+12) = 0xE0 (sin referencia en p02)
	ld (ix+012h),0e0h		;9cca
	ret			;9cce
PAR_POR_RELACION:		; H = 0x9CE2[(EA50)]; A = (A * H) >> 8, tope 0x7F
	ld hl,(0ea50h)		;9ccf
	ld bc,09ce2h		;9cd2
	add hl,bc			;9cd5
	ld h,(hl)			;9cd6
	ld e,a			;9cd7
	call MULTIPLICA_H_E		;9cd8
	ld a,h			;9cdb
	cp 080h		;9cdc
	ret c			;9cde
	ld a,07fh		;9cdf
	ret			;9ce1

; ----------------------------------------------------------------------
; DATOS tabla_relaciones_b: 9 cajas x 4 marchas: factor de aceleracion (copia
;   de 0x9C84)
;   0x9ce2..0x9d06  (36 bytes)
DATA_tabla_relaciones_b:
	defb 0ffh,0b6h,079h,05bh	; 9ce2
	defb 0fch,0b1h,073h,05bh	; 9ce6
	defb 0f0h,09bh,06fh,05bh	; 9cea
	defb 0ffh,091h,060h,040h	; 9cee
	defb 0fch,091h,060h,040h	; 9cf2
	defb 0f0h,088h,058h,040h	; 9cf6
	defb 0ffh,0a0h,06ah,046h	; 9cfa
	defb 0ffh,0a0h,06ah,046h	; 9cfe
	defb 0ffh,096h,061h,046h	; 9d02

; ======================================================================
; CODIGO 0x9d06..0x9f53  (589 bytes)
; ======================================================================


OBJETOS:		; los 5 de E800 con IY = E2C0 (0x9D28) y p03 0xB5B6; con dos jugadores los de E928 con E380
	ld ix,0e800h		;9d06
	ld iy,0e2c0h		;9d0a
	call OBJETOS_5		;9d0e
	call 0b5b6h		;9d11
	ld a,(0e1c2h)		;9d14
	bit 5,a		;9d17
	ret z			;9d19
	ld ix,0e928h		;9d1a
	ld iy,0e380h		;9d1e
	call OBJETOS_5		;9d22
	jp 0b5b6h		;9d25
OBJETOS_5:		; B = 5
	ld b,005h		;9d28
OBJETO_PASO:		; tipo 0 o bit 4 o (ix+23) -> nada; tipo < 11 -> fisica (0x9D5C); rutina del tipo (0x9F47); mueve (0x9D70); x >= 0xB8 -> fuera (0x9E31)
	ld a,(ix+000h)		;9d2a
	ld c,a			;9d2d
	and a			;9d2e
	jr z,OBJETO_SIGUIENTE		;9d2f
	and 010h		;9d31
	or (ix+023h)		;9d33
	jr nz,OBJETO_SIGUIENTE		;9d36
	push bc			;9d38
	push ix		;9d39
	ld a,c			;9d3b
	and 00fh		;9d3c
	cp 00bh		;9d3e
	call c,FISICA_OBJETO_PASO		;9d40
	call RUTINA_DEL_TIPO		;9d43
	call MUEVE_OBJETO		;9d46
	pop ix		;9d49
	ld a,(ix+004h)		;9d4b
	cp 0b8h		;9d4e
	call nc,QUITA_OBJETO_FUERA		;9d50
	pop bc			;9d53
OBJETO_SIGUIENTE:		; IX += 0x38
	ld de,00038h		;9d54
	add ix,de		;9d57
	djnz OBJETO_PASO		;9d59
	ret			;9d5b
FISICA_OBJETO_PASO:		; carrera parada ((iy+66) = 0) -> velocidades a cero (0x9DA4); si no: terreno (0x9510) salvo bit 5, 0x9423 y p03 0xA8A1
	ld a,(iy+066h)		;9d5c
	or a			;9d5f
	jp z,OBJETO_PARADO		;9d60
	bit 5,(ix+000h)		;9d63
	call z,TERRENO_Y_DERRAPE		;9d67
	call FISICA_OBJETO		;9d6a
	jp 0a8a1h		;9d6d
MUEVE_OBJETO:		; y += vy; bit 5 -> espera (0x9DB2); si no x (0x9D89)
	ld h,(ix+006h)		;9d70
	ld l,(ix+005h)		;9d73
	ld d,(ix+00bh)		;9d76
	ld e,(ix+00ah)		;9d79
	add hl,de			;9d7c
	ld (ix+006h),h		;9d7d
	ld (ix+005h),l		;9d80
	bit 5,(ix+000h)		;9d83
	jr nz,OBJETO_ESPERA		;9d87
MUEVE_X:		; x (ix+3,4) += vx + avance de la pista del coche guia (iy+43,44)
	ld h,(ix+004h)		;9d89
	ld l,(ix+003h)		;9d8c
	ld d,(ix+008h)		;9d8f
	ld e,(ix+007h)		;9d92
	add hl,de			;9d95
	ld e,(iy+043h)		;9d96
	ld d,(iy+044h)		;9d99
	add hl,de			;9d9c
	ld (ix+004h),h		;9d9d
	ld (ix+003h),l		;9da0
	ret			;9da3
OBJETO_PARADO:		; vx = vy = 0
	xor a			;9da4
	ld (ix+00bh),a		;9da5
	ld (ix+00ah),a		;9da8
	ld (ix+008h),a		;9dab
	ld (ix+007h),a		;9dae
	ret			;9db1
OBJETO_ESPERA:		; (ix+20)-- a cero: bit 5 fuera; p03 0xA17C y 0xA4C2 (C -> fuera, 0x9E2D); bit 2 de (ix+1) fuera; velocidad; con el bit 7 guarda (ix+19..1C)
	dec (ix+020h)		;9db2
	ret nz			;9db5
	res 5,(ix+000h)		;9db6
	call 0a17ch		;9dba
	jp c,QUITA_OBJETO		;9dbd
	ld a,(ix+000h)		;9dc0
	call 0a4c2h		;9dc3
	jp c,QUITA_OBJETO		;9dc6
	res 2,(ix+001h)		;9dc9
	ld e,(ix+010h)		;9dcd
	ld d,(ix+011h)		;9dd0
	ld (ix+010h),e		;9dd3
	ld (ix+011h),d		;9dd6
	bit 7,(ix+000h)		;9dd9
	ret z			;9ddd
	ld (ix+01bh),e		;9dde
	ld (ix+01ch),d		;9de1
	ld (ix+019h),e		;9de4
	ld (ix+01ah),d		;9de7
	ret			;9dea
L_9DEB:
	ld h,b			;9deb
	ld l,c			;9dec
	or a			;9ded
	bit 7,(ix+000h)		;9dee
	jr nz,L_9E13		;9df2
	sbc hl,de		;9df4
	jr c,L_9E08		;9df6
	ld a,h			;9df8
	cp 002h		;9df9
	jr c,L_9E08		;9dfb
	cp 006h		;9dfd
	ret c			;9dff
	ex de,hl			;9e00
	add hl,bc			;9e01
	sra h		;9e02
	rr l		;9e04
	ex de,hl			;9e06
	ret			;9e07
L_9E08:
	ld hl,0fe00h		;9e08
	add hl,bc			;9e0b
	jr c,L_9E11		;9e0c
	ld hl,00010h		;9e0e
L_9E11:
	ex de,hl			;9e11
	ret			;9e12
L_9E13:
	sbc hl,de		;9e13
	jr nc,L_9E27		;9e15
	ld a,h			;9e17
	cp 0ffh		;9e18
	jr nc,L_9E27		;9e1a
	cp 0fch		;9e1c
	ret nc			;9e1e
	ex de,hl			;9e1f
	add hl,bc			;9e20
	sra h		;9e21
	rr l		;9e23
	ex de,hl			;9e25
	ret			;9e26
L_9E27:
	ld hl,00100h		;9e27
	add hl,bc			;9e2a
	ex de,hl			;9e2b
	ret			;9e2c
QUITA_OBJETO:		; 0x9E35 (desde 0x9AE3, 0x9DB2)
	jr QUITA_OBJETO_VA		;9e2d
QUITA_OBJETO_B:		; idem (entrada de la tabla de jr)
	jr QUITA_OBJETO_VA		;9e2f
QUITA_OBJETO_FUERA:		; idem (x >= 0xB8)
	jr QUITA_OBJETO_VA		;9e31
QUITA_OBJETO_D:		; idem
	jr QUITA_OBJETO_VA		;9e33
QUITA_OBJETO_VA:		; tipo 8/9 -> p01 0x7FFC (E208); E91C-- y el contador del jugador (E91D/E91E); B = tipo*2; tipo = 0; EA67 = (x >= 0xE0); p03 0xA531; x = 0xE0; con dos jugadores: la pareja (ix+24,25) se libera (y cambia de jugador si (ix+23) = 0); luego si queda sitio (E919/E918) mete un objeto nuevo del mismo tipo (0x9F00)
	ld a,(ix+000h)		;9e35
	or a			;9e38
	ret z			;9e39
	and 00fh		;9e3a
	sub 008h		;9e3c
	cp 002h		;9e3e
	call c,07ffch		;9e40
	ld hl,0e91ch		;9e43
	dec (hl)			;9e46
	ld a,(ix+009h)		;9e47
	dec a			;9e4a
	ld hl,0e91dh		;9e4b
	jr z,QUITA_CUENTA		;9e4e
	inc l			;9e50
QUITA_CUENTA:		; (HL)-- (E91D o E91E)
	dec (hl)			;9e51
	ld a,(ix+000h)		;9e52
	add a,a			;9e55
	ld b,a			;9e56
	ld (ix+000h),000h		;9e57
	ld a,(ix+004h)		;9e5b
	cp 0e0h		;9e5e
	ld a,000h		;9e60
	jr c,QUITA_EA67		;9e62
	inc a			;9e64
QUITA_EA67:		; EA67 = A
	ld (0ea67h),a		;9e65
	call 0a531h		;9e68
	ld (ix+004h),0e0h		;9e6b
	ld hl,0e1c2h		;9e6f
	bit 5,(hl)		;9e72
	ret z			;9e74
	ld e,(ix+024h)		;9e75
	ld d,(ix+025h)		;9e78
	ld a,d			;9e7b
	or e			;9e7c
	jr z,QUITA_NUEVO		;9e7d
	ld a,(ix+023h)		;9e7f
	ld (ix+024h),000h		;9e82
	ld (ix+025h),000h		;9e86
	push ix		;9e8a
	push de			;9e8c
	pop ix		;9e8d
	ld (ix+023h),000h		;9e8f
	ld (ix+024h),000h		;9e93
	ld (ix+025h),000h		;9e97
	and a			;9e9b
	jr nz,QUITA_PAREJA_FIN		;9e9c
	ld a,(ix+009h)		;9e9e
	xor 003h		;9ea1
	ld (ix+009h),a		;9ea3
	ld hl,0e91ch		;9ea6
	inc (hl)			;9ea9
	ld a,(ix+009h)		;9eaa
	dec a			;9ead
	ld hl,0e91dh		;9eae
	jr z,QUITA_PAREJA_CUENTA		;9eb1
	inc l			;9eb3
QUITA_PAREJA_CUENTA:		; (HL)++
	inc (hl)			;9eb4
QUITA_PAREJA_FIN:		; pop ix
	pop ix		;9eb5
QUITA_NUEVO:		; EA68 = B; si E919 = 0 y E918 < 0xB8 ret; si (E919-1) < 2 ret; por jugador y EA67 decide si entra uno nuevo
	ld a,b			;9eb7
	ld (0ea68h),a		;9eb8
	ld hl,(0e919h)		;9ebb
	ld a,h			;9ebe
	or l			;9ebf
	jr nz,QUITA_NUEVO_E919		;9ec0
	ld a,(0e918h)		;9ec2
	cp 0b8h		;9ec5
	ret c			;9ec7
	jr QUITA_NUEVO_JUGADOR_1		;9ec8
QUITA_NUEVO_E919:		; E919 - 1 - 2
	dec hl			;9eca
	ld de,00002h		;9ecb
	or a			;9ece
	sbc hl,de		;9ecf
	ret nc			;9ed1
QUITA_NUEVO_JUGADOR_1:		; jugador 1: E91B = 1 -> lista E928 si EA67 = 1; si no E800
	ld a,(ix+009h)		;9ed2
	dec a			;9ed5
	jr nz,QUITA_NUEVO_JUGADOR_2		;9ed6
	ld a,(0e91bh)		;9ed8
	dec a			;9edb
	ld a,(0ea67h)		;9edc
	ld hl,0e928h		;9edf
	jr nz,QUITA_NUEVO_J1_B		;9ee2
	cp 001h		;9ee4
	ret nz			;9ee6
	jr NUEVO_OBJETO		;9ee7
QUITA_NUEVO_J1_B:		; EA67 = 0
	and a			;9ee9
	ret nz			;9eea
	jr NUEVO_OBJETO		;9eeb
QUITA_NUEVO_JUGADOR_2:		; jugador 2: idem cruzado
	ld a,(0e91bh)		;9eed
	dec a			;9ef0
	ld a,(0ea67h)		;9ef1
	ld hl,0e800h		;9ef4
	jr z,QUITA_NUEVO_J2_B		;9ef7
	cp 001h		;9ef9
	ret nz			;9efb
	jr NUEVO_OBJETO		;9efc
QUITA_NUEVO_J2_B:		; EA67 = 0
	and a			;9efe
	ret nz			;9eff
NUEVO_OBJETO:		; 0x9F08 con IX guardado
	push ix		;9f00
	call NUEVO_OBJETO_VA		;9f02
	pop ix		;9f05
	ret			;9f07
NUEVO_OBJETO_VA:		; EA68 = (EA68 >> 1) con el carry; busca sitio (p03 0xA440: NZ no hay); tipo = EA68 | 0x10; (ix+1D,1E) = (E918 - 0xB0) / 4 + 1; E91C++ y el contador del jugador
	rra			;9f08
	ld a,(0ea68h)		;9f09
	rra			;9f0c
	ld (0ea68h),a		;9f0d
	call 0a440h		;9f10
	ret nz			;9f13
	push hl			;9f14
	pop ix		;9f15
	ld a,(0ea68h)		;9f17
	or 010h		;9f1a
	ld (ix+000h),a		;9f1c
	ld hl,(0e918h)		;9f1f
	ld de,000b0h		;9f22
	or a			;9f25
	sbc hl,de		;9f26
	srl h		;9f28
	rr l		;9f2a
	srl h		;9f2c
	rr l		;9f2e
	inc hl			;9f30
	ld (ix+01dh),l		;9f31
	ld (ix+01eh),h		;9f34
	ld hl,0e91ch		;9f37
	inc (hl)			;9f3a
	ld a,(ix+009h)		;9f3b
	dec a			;9f3e
	ld hl,0e91dh		;9f3f
	jr z,NUEVO_OBJETO_CUENTA		;9f42
	inc l			;9f44
NUEVO_OBJETO_CUENTA:		; (HL)++
	inc (hl)			;9f45
	ret			;9f46
RUTINA_DEL_TIPO:		; despacha por tipo - 1 (< 15) con la tabla 0x9F53
	ld a,(ix+000h)		;9f47
	and 00fh		;9f4a
	dec a			;9f4c
	cp 00fh		;9f4d
	ret nc			;9f4f
	call 040dah		;9f50

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (30 bytes)
;   0x9f53..0x9f71  (30 bytes)
DATA_9F53:
	defb 051h,0b9h,09bh,0b9h,0c0h,0b9h,0e5h,0b9h,00fh,0bah,039h,0bah,07eh,0bah,03eh,0b9h	; 9f53  Q.........9.~.>.
	defb 02dh,0b9h,051h,0b9h,071h,09fh,071h,09fh,071h,09fh,071h,09fh,0e7h,0b4h	; 9f63  -.Q.q.q.q.q...

; ======================================================================
; CODIGO 0x9f71..0x9f8f  (30 bytes)
; ======================================================================


NADA_9F71:		; ret (tipos 11..14)
	ret			;9f71
L_9F72:
	jr L_9F72		;9f72
COLORES_CATEGORIA:		; copia los 8 bytes de 0x9F8F[min(E25B,5)] a E1F4..E1FB (desde p00 0x5A07)
	ld a,(0e25bh)		;9f74
	cp 005h		;9f77
	jr c,COLORES_CATEGORIA_INDICE		;9f79
	ld a,005h		;9f7b
COLORES_CATEGORIA_INDICE:		; A*8
	add a,a			;9f7d
	add a,a			;9f7e
	add a,a			;9f7f
	ld hl,09f8fh		;9f80
	call 040d0h		;9f83
	ld de,0e1f4h		;9f86
	ld bc,00008h		;9f89
	ldir		;9f8c
	ret			;9f8e

; ----------------------------------------------------------------------
; DATOS tabla_colores_categoria: 6 x 8 bytes por categoria -> E1F4..E1FB
;   (colores de los objetos por tipo, 0x9FBF los lee desde E1F3+A)
;   0x9f8f..0x9fbf  (48 bytes)
DATA_tabla_colores_categoria:
	defb 006h,002h,00ah,008h,00eh,00dh,002h,006h	; 9f8f  ........
	defb 006h,003h,00bh,009h,00fh,00dh,007h,006h	; 9f97  ........
	defb 006h,003h,00bh,009h,00fh,00dh,003h,006h	; 9f9f  ........
	defb 006h,003h,00bh,009h,00fh,00dh,007h,006h	; 9fa7  ........
	defb 006h,003h,00bh,009h,00fh,00dh,003h,006h	; 9faf  ........
	defb 006h,003h,00bh,009h,00fh,00dh,003h,006h	; 9fb7  ........

; ======================================================================
; CODIGO 0x9fbf..0xa000  (65 bytes)
; ======================================================================


COLOR_OBJETO:		; (ix+F) = E1F3[A] (A se conserva)
	ld b,a			;9fbf
	ld hl,0e1f3h		;9fc0
	call 040d0h		;9fc3
	ld a,(hl)			;9fc6
	ld (ix+00fh),a		;9fc7
	ld a,b			;9fca
	ret			;9fcb
CREA_OBJETO_EN:		; A = tipo, DE = (x, y): sitio libre (p03 0xA433; NZ no), IX = el sitio, p03 0xA3AB, (ix+0) = tipo y sigue en 0x9FCC+0x68+.. (jr $+104 -> p03 0xA049)
	push de			;9fcc
	push af			;9fcd
	call 0a433h		;9fce
	pop bc			;9fd1
	pop de			;9fd2
	ret nz			;9fd3
	push de			;9fd4
	push hl			;9fd5
	pop ix		;9fd6
	push bc			;9fd8
	call 0a3abh		;9fd9
	pop bc			;9fdc
	pop de			;9fdd
	ld (ix+000h),b		;9fde
	jr $+104		;9fe1
OBJETO_LIBRE:		; (ix+0) = 0 y C (desde p03 0xA15C)
	ld (ix+000h),000h		;9fe3
	scf			;9fe7
	ret			;9fe8
MISMA_POSICION_INICIAL:		; Z si (iy+10,11) = (ix+19,1A) (desde p03 0xA1B1)
	ld a,(iy+011h)		;9fe9
	cp (ix+01ah)		;9fec
	ret nz			;9fef
	ld a,(iy+010h)		;9ff0
	cp (ix+019h)		;9ff3
	ret			;9ff6
OBJETO_DESDE_A292:		; push af; p03 0xA412 (busca sitio); pop bc; ret nz; IX = HL y sigue en p03 0xA000 (cruza la frontera; desde p03 0xA292)
	push af			;9ff7
	call 0a412h		;9ff8
	pop bc			;9ffb
	ret nz			;9ffc
	push hl			;9ffd
	pop ix		;9ffe
