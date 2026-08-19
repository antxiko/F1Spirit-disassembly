; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ======================================================================
; CODIGO 0xa000..0xa087  (135 bytes)
; ======================================================================


L_A000:
	ld (ix+000h),b		;a000
	push bc			;a003
	bit 7,b		;a004
	ld a,(iy-00dh)		;a006
	jr z,L_A01D		;a009
	ld a,(iy-00ch)		;a00b
	ld (ix+017h),a		;a00e
	call L_A592		;a011
	call 09fe9h		;a014
	pop bc			;a017
	jp nc,09fe3h		;a018
	jr L_A02A		;a01b
L_A01D:
	ld (ix+017h),a		;a01d
	call L_A592		;a020
	call 09fe9h		;a023
	pop bc			;a026
	jp c,09fe3h		;a027
L_A02A:
	ld e,(ix+019h)		;a02a
	ld d,(ix+01ah)		;a02d
	ld (ix+010h),e		;a030
	ld (ix+011h),d		;a033
L_A036:
	call L_A212		;a036
	ld a,(0e244h)		;a039
	dec a			;a03c
	ld a,001h		;a03d
	jr z,L_A043		;a03f
	ld a,019h		;a041
L_A043:
	ld (ix+020h),a		;a043
L_A046:
	call L_A0EA		;a046
	call L_A54F		;a049
	ld a,(0e1c2h)		;a04c
	bit 5,a		;a04f
	jr nz,L_A057		;a051
	set 7,(ix+031h)		;a053
L_A057:
	ld a,(ix+000h)		;a057
	and 00fh		;a05a
	push af			;a05c
	call 09fbfh		;a05d
	pop af			;a060
	dec a			;a061
	cp 00fh		;a062
	ret nc			;a064
	call 04abdh		;a065
	add a,(hl)			;a068
	cp c			;a069
	or e			;a06a
	cp c			;a06b
	ret c			;a06c
	cp c			;a06d
	ld (bc),a			;a06e
	cp d			;a06f
	inc l			;a070
	cp d			;a071
	ld d,e			;a072
	cp d			;a073
	sub (hl)			;a074
	cp d			;a075
	ld (hl),a			;a076
	cp c			;a077
	ld (hl),a			;a078
	cp c			;a079
	ld l,a			;a07a
	cp c			;a07b
	add a,(hl)			;a07c
	and b			;a07d
	add a,(hl)			;a07e
	and b			;a07f
	add a,(hl)			;a080
	and b			;a081
	add a,(hl)			;a082
	and b			;a083
	sbc a,b			;a084
	or l			;a085
	ret			;a086

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (2 bytes)
;   0xa087..0xa089  (2 bytes)
DATA_A087:
	defb 018h,0feh	; a087

; ======================================================================
; CODIGO 0xa089..0xa0be  (53 bytes)
; ======================================================================


L_A089:
	ld ix,0e800h		;a089
	ld b,005h		;a08d
	ld de,00038h		;a08f
L_A092:
	ld a,005h		;a092
	sub b			;a094
	ld hl,0a0beh		;a095
	call 040d0h		;a098
	ld a,(hl)			;a09b
	ld (ix+037h),a		;a09c
	add ix,de		;a09f
	djnz L_A092		;a0a1
	ld ix,0e928h		;a0a3
	ld b,005h		;a0a7
	ld de,00038h		;a0a9
L_A0AC:
	ld a,005h		;a0ac
	sub b			;a0ae
	ld hl,0a0c3h		;a0af
	call 040d0h		;a0b2
	ld a,(hl)			;a0b5
	ld (ix+037h),a		;a0b6
	add ix,de		;a0b9
	djnz L_A0AC		;a0bb
	ret			;a0bd

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (44 bytes)
;   0xa0be..0xa0ea  (44 bytes)
DATA_A0BE:
	defb 000h,001h,002h,003h,000h,004h,005h,006h,007h,001h,0ddh,0e5h,0ddh,021h,000h,0e8h	; a0be  .............!..
	defb 006h,005h,0cdh,0dfh,0a0h,0ddh,021h,028h,0e9h,006h,005h,0cdh,0dfh,0a0h,0ddh,0e1h	; a0ce  ......!(........
	defb 0c9h,0cdh,0eah,0a0h,011h,038h,000h,0ddh,019h,010h,0f6h,0c9h	; a0de  .....8......

; ======================================================================
; CODIGO 0xa0ea..0xa3a4  (698 bytes)
; ======================================================================


L_A0EA:
	call L_A0F4		;a0ea
	ld (ix+01bh),e		;a0ed
	ld (ix+01ch),d		;a0f0
	ret			;a0f3
L_A0F4:
	ld a,(0e25bh)		;a0f4
	ld hl,0a9fdh		;a0f7
	call 04a44h		;a0fa
	ld a,(ix+000h)		;a0fd
	and 00fh		;a100
	dec a			;a102
	add a,a			;a103
	add a,(iy+056h)		;a104
	add a,a			;a107
	ld e,a			;a108
	ld d,000h		;a109
	add hl,de			;a10b
	ld e,(hl)			;a10c
	inc hl			;a10d
	ld d,(hl)			;a10e
	ret			;a10f
L_A110:
	ld a,(0e1c2h)		;a110
	bit 5,a		;a113
	jr z,L_A143		;a115
	ld iy,0e380h		;a117
	call L_A44E		;a11b
	ld ix,0e928h		;a11e
	call L_A12D		;a122
	ld iy,0e2c0h		;a125
	ld ix,0e800h		;a129
L_A12D:
	call L_BA9F		;a12d
	call L_A22E		;a130
L_A133:
	ld a,(iy+055h)		;a133
	or a			;a136
	ret z			;a137
	call L_A150		;a138
	ret c			;a13b
	ld b,a			;a13c
	call 08193h		;a13d
	jp L_A036		;a140
L_A143:
	ld iy,0e2c0h		;a143
	ld (iy+05ah),0e8h		;a147
	call L_BA9F		;a14b
	jr L_A133		;a14e
L_A150:
	call 08059h		;a150
	ccf			;a153
	ret c			;a154
	call L_A163		;a155
	ret c			;a158
	call L_A18B		;a159
	jp c,09fe3h		;a15c
	ret			;a15f
L_A160:
	pop hl			;a160
L_A161:
	scf			;a161
	ret			;a162
L_A163:
	call L_A17C		;a163
	ret c			;a166
	ld hl,(0e919h)		;a167
	ld a,h			;a16a
	or l			;a16b
	ret z			;a16c
	ld a,(iy+009h)		;a16d
	dec a			;a170
	ld hl,0e91dh		;a171
	jr z,L_A177		;a174
	inc l			;a176
L_A177:
	ld a,(hl)			;a177
	cp 003h		;a178
	ccf			;a17a
	ret			;a17b
L_A17C:
	ld a,(0e25bh)		;a17c
	ld hl,0a3a4h		;a17f
	call 040d0h		;a182
	ld h,(hl)			;a185
	ld a,(iy+011h)		;a186
	cp h			;a189
	ret			;a18a
L_A18B:
	ld a,(0e1c2h)		;a18b
	bit 5,a		;a18e
	jr nz,L_A1DA		;a190
L_A192:
	push bc			;a192
	call L_A412		;a193
	pop bc			;a196
	jr nz,L_A160		;a197
L_A199:
	push hl			;a199
	pop ix		;a19a
	call L_A3AB		;a19c
	ld (ix+000h),c		;a19f
	ld (ix+036h),b		;a1a2
	call L_A0EA		;a1a5
	ld a,(iy-00dh)		;a1a8
	ld (ix+017h),a		;a1ab
	call L_A592		;a1ae
	call 09fe9h		;a1b1
	ld a,020h		;a1b4
	jr nc,L_A1C8		;a1b6
	ld a,(iy-00ch)		;a1b8
	ld (ix+017h),a		;a1bb
	call L_A592		;a1be
	call 09fe9h		;a1c1
	ccf			;a1c4
	ret c			;a1c5
	ld a,0a0h		;a1c6
L_A1C8:
	or c			;a1c8
	ld (ix+000h),a		;a1c9
	ld e,(ix+019h)		;a1cc
	ld d,(ix+01ah)		;a1cf
	ld (ix+010h),e		;a1d2
	ld (ix+011h),d		;a1d5
	or a			;a1d8
	ret			;a1d9
L_A1DA:
	ld de,00002h		;a1da
	ld hl,(0e919h)		;a1dd
	or a			;a1e0
	sbc hl,de		;a1e1
	jr nc,L_A192		;a1e3
	ld a,(iy+009h)		;a1e5
	dec a			;a1e8
	ld de,020a0h		;a1e9
	jr z,L_A1F1		;a1ec
	ld de,0a020h		;a1ee
L_A1F1:
	ld a,(0e91bh)		;a1f1
	dec a			;a1f4
	jr z,L_A1F8		;a1f5
	ld e,d			;a1f7
L_A1F8:
	push de			;a1f8
	push bc			;a1f9
	call L_A412		;a1fa
	pop bc			;a1fd
	pop de			;a1fe
	jp nz,L_A160		;a1ff
	push bc			;a202
	push de			;a203
	call L_A199		;a204
	pop de			;a207
	pop bc			;a208
	ret c			;a209
	and 0f0h		;a20a
	cp e			;a20c
	jp nz,L_A161		;a20d
	or a			;a210
	ret			;a211
L_A212:
	ld a,(iy+009h)		;a212
	ld (ix+009h),a		;a215
	bit 7,b		;a218
	jr nz,L_A225		;a21a
	ld (ix+004h),000h		;a21c
	res 2,(ix+030h)		;a220
	ret			;a224
L_A225:
	ld (ix+004h),0b7h		;a225
	set 2,(ix+030h)		;a229
	ret			;a22d
L_A22E:
	ld a,(0e30bh)		;a22e
	ld (0e3dbh),a		;a231
	ld a,(0e3cbh)		;a234
	ld (0e31bh),a		;a237
	ld (iy+05ah),0e8h		;a23a
	ld hl,(0e919h)		;a23e
	ld a,h			;a241
	or l			;a242
	call z,L_A29C		;a243
	exx			;a246
	ld de,00038h		;a247
	ld b,005h		;a24a
L_A24C:
	exx			;a24c
	call L_A257		;a24d
	exx			;a250
	add ix,de		;a251
	djnz L_A24C		;a253
	exx			;a255
	ret			;a256
L_A257:
	bit 4,(ix+000h)		;a257
	ret z			;a25b
	ld l,(ix+01dh)		;a25c
	ld h,(ix+01eh)		;a25f
	dec hl			;a262
	ld (ix+01dh),l		;a263
	ld (ix+01eh),h		;a266
	ld a,h			;a269
	or l			;a26a
	ret nz			;a26b
	ld a,(ix+000h)		;a26c
	and 0efh		;a26f
	push af			;a271
	ld (ix+000h),000h		;a272
	ld hl,0e91ch		;a276
	dec (hl)			;a279
	ld a,(ix+009h)		;a27a
	dec a			;a27d
	ld hl,0e91dh		;a27e
	jr z,L_A284		;a281
	inc l			;a283
L_A284:
	dec (hl)			;a284
	pop af			;a285
	call L_A4C2		;a286
	ret c			;a289
	set 5,a		;a28a
	exx			;a28c
	push bc			;a28d
	push de			;a28e
	push ix		;a28f
	exx			;a291
	call 09ff7h		;a292
	exx			;a295
	pop ix		;a296
	pop de			;a298
	pop bc			;a299
	exx			;a29a
	ret			;a29b
L_A29C:
	call L_A374		;a29c
	ld a,(0e918h)		;a29f
	cp 0b8h		;a2a2
	ret nc			;a2a4
	push ix		;a2a5
	exx			;a2a7
	ld de,00038h		;a2a8
	ld b,005h		;a2ab
L_A2AD:
	exx			;a2ad
	call L_A2BA		;a2ae
	exx			;a2b1
	add ix,de		;a2b2
	djnz L_A2AD		;a2b4
	exx			;a2b6
	pop ix		;a2b7
	ret			;a2b9
L_A2BA:
	ld a,(ix+000h)		;a2ba
	and a			;a2bd
	ret z			;a2be
	and 070h		;a2bf
	ret nz			;a2c1
	ld a,(ix+023h)		;a2c2
	and a			;a2c5
	ret nz			;a2c6
	ld a,(iy+009h)		;a2c7
	dec a			;a2ca
	jp z,L_A2F4		;a2cb
	call L_A34C		;a2ce
	ret nz			;a2d1
	ld (ix+024h),e		;a2d2
	ld (ix+025h),d		;a2d5
	push ix		;a2d8
	pop hl			;a2da
	push bc			;a2db
	ld bc,00036h		;a2dc
	ldir		;a2df
	pop bc			;a2e1
	ld hl,0e918h		;a2e2
	ld a,(0e91bh)		;a2e5
	dec a			;a2e8
	ld a,(ix+004h)		;a2e9
	jr z,L_A2F1		;a2ec
	add a,(hl)			;a2ee
	jr L_A318		;a2ef
L_A2F1:
	sub (hl)			;a2f1
	jr L_A318		;a2f2
L_A2F4:
	call L_A34C		;a2f4
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
	ld a,(ix+004h)		;a30f
	jr z,L_A317		;a312
	sub (hl)			;a314
	jr L_A318		;a315
L_A317:
	add a,(hl)			;a317
L_A318:
	jr c,L_A31E		;a318
	cp 0b8h		;a31a
	jr c,L_A334		;a31c
L_A31E:
	ld (ix+024h),000h		;a31e
	ld (ix+025h),000h		;a322
	ld hl,(0ea60h)		;a326
	ld e,l			;a329
	ld d,h			;a32a
	inc de			;a32b
	ld bc,00037h		;a32c
	ld (hl),000h		;a32f
	ldir		;a331
	ret			;a333
L_A334:
	push ix		;a334
	pop hl			;a336
	ld ix,(0ea60h)		;a337
	ld (ix+004h),a		;a33b
	ld (ix+023h),001h		;a33e
	ld (ix+024h),l		;a342
	ld (ix+025h),h		;a345
	push hl			;a348
	pop ix		;a349
	ret			;a34b
L_A34C:
	ld e,(ix+024h)		;a34c
	ld d,(ix+025h)		;a34f
	ld a,d			;a352
	or e			;a353
	ld a,001h		;a354
	jr nz,L_A36B		;a356
	ld a,(iy+009h)		;a358
	dec a			;a35b
	ld hl,0e800h		;a35c
	jr nz,L_A364		;a35f
	ld hl,0e928h		;a361
L_A364:
	call L_A440		;a364
	ret nz			;a367
	push hl			;a368
	pop de			;a369
	xor a			;a36a
L_A36B:
	ld (0ea60h),de		;a36b
	ld (0ea64h),a		;a36f
	xor a			;a372
	ret			;a373
L_A374:
	ld a,(iy+009h)		;a374
	dec a			;a377
	jr z,L_A38C		;a378
	ld hl,0e918h		;a37a
	ld a,(0e91bh)		;a37d
	dec a			;a380
	ld a,(iy+004h)		;a381
	jr z,L_A389		;a384
	add a,(hl)			;a386
	jr L_A39C		;a387
L_A389:
	sub (hl)			;a389
	jr L_A39C		;a38a
L_A38C:
	ld hl,0e918h		;a38c
	ld a,(0e91bh)		;a38f
	dec a			;a392
	ld a,(iy+004h)		;a393
	jr z,L_A39B		;a396
	sub (hl)			;a398
	jr L_A39C		;a399
L_A39B:
	add a,(hl)			;a39b
L_A39C:
	ret c			;a39c
	cp 0c8h		;a39d
	ret nc			;a39f
	ld (iy+05ah),a		;a3a0
	ret			;a3a3

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (7 bytes)
;   0xa3a4..0xa3ab  (7 bytes)
DATA_A3A4:
	defb 000h,000h,000h,000h,000h,000h,000h	; a3a4

; ======================================================================
; CODIGO 0xa3ab..0xa3b4  (9 bytes)
; ======================================================================


L_A3AB:
	push bc			;a3ab
	ld bc,00036h		;a3ac
	call 04b87h		;a3af
	pop bc			;a3b2
	ret			;a3b3

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (94 bytes)
;   0xa3b4..0xa412  (94 bytes)
DATA_A3B4:
	defb 016h,0ffh,0cdh,09dh,04ah,03ah,06ch,0e2h,057h,03ah,072h,0e2h,092h,05fh,006h,010h	; a3b4  ....J:l.W:r.._..
	defb 07eh,02dh,092h,0bbh,038h,00ah,07eh,02dh,092h,0bbh,038h,004h,010h,0f2h,037h,0c9h	; a3c4  ~-..8.~-..8...7.
	defb 03ah,07dh,0eah,047h,07dh,03ch,03dh,010h,0fdh,087h,087h,087h,057h,0b7h,0c9h,016h	; a3d4  :}.G}<=.....W...
	defb 000h,0cdh,09dh,04ah,03ah,06ch,0e2h,057h,03ah,072h,0e2h,092h,05fh,006h,010h,07eh	; a3e4  ...J:l.W:r.._..~
	defb 02ch,092h,0bbh,038h,00ah,07eh,02ch,092h,0bbh,038h,004h,010h,0f2h,037h,0c9h,03ah	; a3f4  ,..8.~,..8...7.:
	defb 07dh,0eah,047h,07dh,03dh,03ch,010h,0fdh,087h,087h,087h,057h,0b7h,0c9h	; a404  }.G}=<.....W..

; ======================================================================
; CODIGO 0xa412..0xa4b5  (163 bytes)
; ======================================================================


L_A412:
	ld a,(0e25bh)		;a412
	and a			;a415
	ld b,004h		;a416
	jr nz,L_A41C		;a418
	ld b,002h		;a41a
L_A41C:
	ld a,(0e91ch)		;a41c
	cp b			;a41f
	jr nc,L_A44B		;a420
	ld a,(0e91dh)		;a422
	bit 0,(iy+009h)		;a425
	jr nz,L_A42E		;a429
	ld a,(0e91eh)		;a42b
L_A42E:
	cp (iy-013h)		;a42e
	jr nc,L_A44B		;a431
L_A433:
	ld a,(iy+009h)		;a433
	cp 001h		;a436
	ld hl,0e800h		;a438
	jr z,L_A440		;a43b
	ld hl,0e928h		;a43d
L_A440:
	ld b,005h		;a440
	ld de,00038h		;a442
	xor a			;a445
L_A446:
	cp (hl)			;a446
	ret z			;a447
	add hl,de			;a448
	djnz L_A446		;a449
L_A44B:
	or 0ffh		;a44b
	ret			;a44d
L_A44E:
	ld de,(0e3c1h)		;a44e
	ld a,(0e3c0h)		;a452
	ld c,a			;a455
	ld hl,(0e301h)		;a456
	ld a,(0e300h)		;a459
	ld b,a			;a45c
	call L_A46D		;a45d
	ld a,002h		;a460
	jr nc,L_A469		;a462
	call L_A491		;a464
	ld a,001h		;a467
L_A469:
	ld (0e91bh),a		;a469
	ret			;a46c
L_A46D:
	push bc			;a46d
	push de			;a46e
	push hl			;a46f
	ld a,c			;a470
	and a			;a471
	jr nz,L_A475		;a472
	inc e			;a474
L_A475:
	neg		;a475
	ld c,a			;a477
	ld a,b			;a478
	and a			;a479
	jr nz,L_A47D		;a47a
	inc l			;a47c
L_A47D:
	neg		;a47d
	sub c			;a47f
	ld (0e918h),a		;a480
	ld a,l			;a483
	sbc a,e			;a484
	ld (0e919h),a		;a485
	ld a,h			;a488
	sbc a,d			;a489
	ld (0e91ah),a		;a48a
	pop hl			;a48d
	pop de			;a48e
	pop bc			;a48f
	ret			;a490
L_A491:
	push bc			;a491
	push de			;a492
	push hl			;a493
	ld a,b			;a494
	and a			;a495
	jr nz,L_A499		;a496
	inc l			;a498
L_A499:
	neg		;a499
	ld b,a			;a49b
	ld a,c			;a49c
	and a			;a49d
	jr nz,L_A4A1		;a49e
	inc e			;a4a0
L_A4A1:
	neg		;a4a1
	sub b			;a4a3
	ld (0e918h),a		;a4a4
	ld a,e			;a4a7
	sbc a,l			;a4a8
	ld (0e919h),a		;a4a9
	ld a,d			;a4ac
	sbc a,h			;a4ad
	ld (0e91ah),a		;a4ae
	pop hl			;a4b1
	pop de			;a4b2
	pop bc			;a4b3
	ret			;a4b4

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (13 bytes)
;   0xa4b5..0xa4c2  (13 bytes)
DATA_A4B5:
	defb 034h,07eh,0b9h,0c0h,0afh,077h,0e5h,023h,023h,023h,034h,0e1h,0c9h	; a4b5  4~...w.###4..

; ======================================================================
; CODIGO 0xa4c2..0xa561  (159 bytes)
; ======================================================================


L_A4C2:
	ld b,a			;a4c2
	ld a,(0e1c2h)		;a4c3
	bit 5,a		;a4c6
	ld a,b			;a4c8
	jr z,L_A4EB		;a4c9
	ld hl,(0e919h)		;a4cb
	ld a,h			;a4ce
	or l			;a4cf
	ld a,b			;a4d0
	ret nz			;a4d1
	ld a,(0e918h)		;a4d2
	cp 0b8h		;a4d5
	ld a,b			;a4d7
	ret nc			;a4d8
	ld a,(iy+009h)		;a4d9
	dec a			;a4dc
	jr z,L_A4F4		;a4dd
	ld a,(0e91bh)		;a4df
	dec a			;a4e2
	ld a,b			;a4e3
	jr z,L_A4ED		;a4e4
	bit 7,b		;a4e6
	jp z,L_A161		;a4e8
L_A4EB:
	or a			;a4eb
	ret			;a4ec
L_A4ED:
	bit 7,b		;a4ed
	jp nz,L_A161		;a4ef
	or a			;a4f2
	ret			;a4f3
L_A4F4:
	ld a,(0e91bh)		;a4f4
	dec a			;a4f7
	ld a,b			;a4f8
	jr z,L_A502		;a4f9
	bit 7,b		;a4fb
	jp nz,L_A161		;a4fd
	or a			;a500
	ret			;a501
L_A502:
	bit 7,b		;a502
	jp z,L_A161		;a504
	or a			;a507
	ret			;a508
L_A509:
	ld a,030h		;a509
	call 040d0h		;a50b
	jr L_A51C		;a50e
L_A510:
	ld a,030h		;a510
	call 040d0h		;a512
	jr L_A529		;a515
L_A517:
	ld a,05eh		;a517
	call 040d0h		;a519
L_A51C:
	ld a,(hl)			;a51c
	add a,008h		;a51d
	bit 6,a		;a51f
	ret nz			;a521
	ld (hl),a			;a522
	ret			;a523
L_A524:
	ld a,05eh		;a524
	call 040d0h		;a526
L_A529:
	ld a,(hl)			;a529
	sub 008h		;a52a
	bit 7,a		;a52c
	ret nz			;a52e
	ld (hl),a			;a52f
	ret			;a530
L_A531:
	ld c,a			;a531
	ld a,b			;a532
	rra			;a533
	and 00fh		;a534
	cp 00fh		;a536
	ret z			;a538
	sub 008h		;a539
	cp 002h		;a53b
	ret c			;a53d
	ld a,(ix+030h)		;a53e
	and 0c0h		;a541
	cp 080h		;a543
	ret nz			;a545
	ld a,c			;a546
	push iy		;a547
	pop hl			;a549
	dec a			;a54a
	jr nz,L_A524		;a54b
	jr L_A510		;a54d
L_A54F:
	push hl			;a54f
	ld hl,0e91ch		;a550
	inc (hl)			;a553
	ld a,(iy+009h)		;a554
	dec a			;a557
	ld hl,0e91dh		;a558
	jr z,L_A55E		;a55b
	inc l			;a55d
L_A55E:
	inc (hl)			;a55e
	pop hl			;a55f
	ret			;a560

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (49 bytes)
;   0xa561..0xa592  (49 bytes)
DATA_A561:
	defb 0fdh,07eh,066h,0a7h,028h,020h,0ddh,05eh,004h,0cdh,0b4h,0a3h,0ddh,072h,006h,0cdh	; a561  .~f.( .^.....r..
	defb 0ffh,0b8h,0c9h,0fdh,07eh,066h,0a7h,028h,00dh,0ddh,05eh,004h,0cdh,0e3h,0a3h,0ddh	; a571  ....~f.(..^.....
	defb 072h,006h,0cdh,00bh,0b9h,0c9h,0ddh,07eh,006h,0ddh,077h,015h,0ddh,036h,00eh,0ffh	; a581  r......~..w..6..
	defb 0c9h	; a591

; ======================================================================
; CODIGO 0xa592..0xa65e  (204 bytes)
; ======================================================================


L_A592:
	ld a,(ix+017h)		;a592
	and a			;a595
	jr z,L_A5A2		;a596
	set 4,(ix+001h)		;a598
	ld (ix+032h),a		;a59c
	jp L_A8C6		;a59f
L_A5A2:
	ld (ix+032h),a		;a5a2
	call L_A0F4		;a5a5
	ld (ix+019h),e		;a5a8
	ld (ix+01ah),d		;a5ab
	ret			;a5ae
L_A5AF:
	ld a,b			;a5af
	sub c			;a5b0
	ld b,a			;a5b1
	ld a,l			;a5b2
	sbc a,e			;a5b3
	ld l,a			;a5b4
	ld a,h			;a5b5
	sbc a,d			;a5b6
	ld h,a			;a5b7
	ret			;a5b8
L_A5B9:
	call L_A673		;a5b9
	ld a,(0e1c2h)		;a5bc
	bit 5,a		;a5bf
	call nz,L_A62F		;a5c1
	ld ix,0e2c0h		;a5c4
	ld iy,0e800h		;a5c8
	call L_A5DD		;a5cc
	ld a,(0e1c2h)		;a5cf
	bit 5,a		;a5d2
	ret z			;a5d4
	ld ix,0e380h		;a5d5
	ld iy,0e928h		;a5d9
L_A5DD:
	ld b,005h		;a5dd
	ld de,00038h		;a5df
L_A5E2:
	ld a,(iy+000h)		;a5e2
	and a			;a5e5
	jr z,L_A621		;a5e6
	ld a,(ix+004h)		;a5e8
	sub (iy+004h)		;a5eb
	ld (iy+029h),a		;a5ee
	set 7,(iy+030h)		;a5f1
	res 6,(iy+030h)		;a5f5
	jr c,L_A60F		;a5f9
	set 7,(iy+000h)		;a5fb
	set 2,(iy+030h)		;a5ff
	res 3,(iy+030h)		;a603
	push ix		;a607
	pop hl			;a609
	call L_A509		;a60a
	jr L_A621		;a60d
L_A60F:
	res 7,(iy+000h)		;a60f
	res 2,(iy+030h)		;a613
	res 3,(iy+030h)		;a617
	push ix		;a61b
	pop hl			;a61d
	call L_A517		;a61e
L_A621:
	add iy,de		;a621
	djnz L_A5E2		;a623
	ld a,(ix+071h)		;a625
	call L_A649		;a628
	ld (ix+071h),a		;a62b
	ret			;a62e
L_A62F:
	ld ix,0e2c0h		;a62f
	ld iy,0e380h		;a633
	ld a,(ix+071h)		;a637
	cp (iy+071h)		;a63a
	jr c,L_A644		;a63d
	res 7,(ix+029h)		;a63f
	ret			;a643
L_A644:
	set 7,(ix+029h)		;a644
	ret			;a648
L_A649:
	ex af,af'			;a649
	ld a,(0e240h)		;a64a
	or a			;a64d
	jr nz,L_A65C		;a64e
	ld a,(0e25ch)		;a650
	ld hl,0a65eh		;a653
	call 040d0h		;a656
	ex af,af'			;a659
	add a,(hl)			;a65a
	ret			;a65b
L_A65C:
	ex af,af'			;a65c
	ret			;a65d

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (21 bytes)
;   0xa65e..0xa673  (21 bytes)
DATA_A65E:
	defb 014h,032h,00fh,028h,028h,017h,019h,019h,019h,019h,019h,019h,01eh,01eh,01eh,01eh	; a65e  .2.((...........
	defb 01eh,01eh,01eh,01eh,01eh	; a66e

; ======================================================================
; CODIGO 0xa673..0xa7b9  (326 bytes)
; ======================================================================


L_A673:
	xor a			;a673
	ld (0ea7fh),a		;a674
	ld a,003h		;a677
	ld (0e331h),a		;a679
	ld a,004h		;a67c
	ld (0e3f1h),a		;a67e
	ld ix,0e2c0h		;a681
	ld iy,0e380h		;a685
	call L_A860		;a689
	ld b,006h		;a68c
	ld a,(0e25ch)		;a68e
	ld hl,0a7b9h		;a691
	call 04a44h		;a694
	ex de,hl			;a697
	ld ix,0e800h		;a698
L_A69C:
	ld a,(0e240h)		;a69c
	and a			;a69f
	jp nz,L_A785		;a6a0
	ld hl,0a7e3h		;a6a3
	ld a,(0e25ch)		;a6a6
	call 04a44h		;a6a9
	ld a,b			;a6ac
	ld iy,0e2c0h		;a6ad
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
	call 04a44h		;a6c9
	push ix		;a6cc
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
	call L_A433		;a6e2
	push hl			;a6e5
	pop ix		;a6e6
	call L_A3AB		;a6e8
	exx			;a6eb
	push hl			;a6ec
	ld hl,0ea7fh		;a6ed
	ld a,(hl)			;a6f0
	inc (hl)			;a6f1
	ld hl,0a85bh		;a6f2
	call 040d0h		;a6f5
	ld a,(hl)			;a6f8
	ld (ix+000h),a		;a6f9
	pop hl			;a6fc
	ld a,(iy+009h)		;a6fd
	ld (ix+009h),a		;a700
	set 2,(ix+001h)		;a703
	ld a,d			;a707
	add a,h			;a708
	ld (ix+006h),a		;a709
	ld a,e			;a70c
	add a,l			;a70d
	ld (ix+004h),a		;a70e
	exx			;a711
	call L_A046		;a712
	call 0996ah		;a715
	ld a,(ix+011h)		;a718
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
	call 04a44h		;a73d
	ld a,d			;a740
	add a,h			;a741
	ld (iy+006h),a		;a742
	ld a,e			;a745
	add a,l			;a746
	ld (iy+004h),a		;a747
	ld hl,0a831h		;a74a
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
	dec b			;a761
	jp nz,L_A69C		;a762
	ld a,(0e1c2h)		;a765
	bit 5,a		;a768
	ret z			;a76a
	call L_A44E		;a76b
	ld ix,0e800h		;a76e
	ld iy,0e2c0h		;a772
	call L_A29C		;a776
	ld iy,0e928h		;a779
	ld iy,0e380h		;a77d
	call L_A29C		;a781
	ret			;a784
L_A785:
	ld hl,0a7e3h		;a785
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
	ld a,(0ea7fh)		;a7a3
	inc a			;a7a6
	cp 003h		;a7a7
	jp z,L_A761		;a7a9
	ld (0ea7fh),a		;a7ac
	sub 003h		;a7af
	neg		;a7b1
	ld (iy+071h),a		;a7b3
	jp L_A73D		;a7b6

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (167 bytes)
;   0xa7b9..0xa860  (167 bytes)
DATA_A7B9:
	defb 058h,07ch,05ch,094h,05ch,07ch,064h,094h,064h,094h,064h,094h,064h,094h,064h,094h	; a7b9  X|\.\|d.d.d.d.d.
	defb 05ch,07ch,05ch,094h,064h,094h,064h,094h,064h,094h,064h,094h,064h,094h,064h,094h	; a7c9  \|\.d.d.d.d.d.d.
	defb 064h,094h,064h,094h,064h,094h,064h,094h,05ch,07ch,00bh,0a8h,017h,0a8h,00bh,0a8h	; a7d9  d.d.d.d.\|......
	defb 023h,0a8h,023h,0a8h,023h,0a8h,023h,0a8h,023h,0a8h,00bh,0a8h,017h,0a8h,023h,0a8h	; a7e9  #.#.#.#.#.....#.
	defb 023h,0a8h,023h,0a8h,023h,0a8h,023h,0a8h,023h,0a8h,023h,0a8h,023h,0a8h,023h,0a8h	; a7f9  #.#.#.#.#.#.#.#.
	defb 023h,0a8h,00bh,0a8h,000h,000h,008h,018h,020h,000h,028h,018h,040h,000h,048h,018h	; a809  #....... .(.@.H.
	defb 000h,000h,008h,0e8h,020h,000h,028h,0e8h,040h,000h,048h,0e8h,000h,000h,010h,0e8h	; a819  .... .(.@.H.....
	defb 020h,000h,030h,0e8h,040h,000h,050h,0e8h,040h,058h,058h,040h,040h,058h,058h,040h	; a829   .0.@.P.@XX@@XX@
	defb 058h,040h,058h,040h,058h,040h,058h,040h,040h,058h,058h,040h,058h,040h,058h,040h	; a839  X@X@X@X@@XX@X@X@
	defb 058h,040h,058h,040h,058h,040h,058h,040h,058h,040h,058h,040h,058h,040h,058h,040h	; a849  X@X@X@X@X@X@X@X@
	defb 040h,058h,002h,004h,005h,002h,001h	; a859

; ======================================================================
; CODIGO 0xa860..0xa94f  (239 bytes)
; ======================================================================


L_A860:
	ld a,(ix+071h)		;a860
	cp (iy+071h)		;a863
	ccf			;a866
	ld a,000h		;a867
	rla			;a869
	inc a			;a86a
	ld (0ea7ch),a		;a86b
	ld a,(ix+071h)		;a86e
	cp 007h		;a871
	jr c,L_A87A		;a873
	ld a,006h		;a875
	ld (ix+071h),a		;a877
L_A87A:
	ld a,(0e1c2h)		;a87a
	bit 5,a		;a87d
	ret z			;a87f
	ld a,(iy+071h)		;a880
	cp 007h		;a883
	jr c,L_A88C		;a885
	ld a,006h		;a887
	ld (iy+071h),a		;a889
L_A88C:
	ld a,(ix+071h)		;a88c
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
	call L_AAF9		;a8a1
	ld a,(0e1c3h)		;a8a4
	add a,(ix+037h)		;a8a7
	and 007h		;a8aa
	ret nz			;a8ac
	call L_A8B4		;a8ad
	call L_A915		;a8b0
	ret			;a8b3
L_A8B4:
	ld a,(ix+032h)		;a8b4
	and a			;a8b7
	jr z,L_A8FF		;a8b8
	cp 080h		;a8ba
	jr z,L_A8FF		;a8bc
	bit 7,a		;a8be
	ret z			;a8c0
	and 07fh		;a8c1
	ld (ix+032h),a		;a8c3
L_A8C6:
	set 4,(ix+001h)		;a8c6
	ld b,a			;a8ca
	ld a,(ix+01fh)		;a8cb
	and 00fh		;a8ce
	ld (ix+01fh),a		;a8d0
	ld a,b			;a8d3
	and 003h		;a8d4
	jr z,L_A908		;a8d6
	dec a			;a8d8
	ld hl,0a94fh		;a8d9
	call 04a44h		;a8dc
	ld a,(ix+000h)		;a8df
	and 00fh		;a8e2
	dec a			;a8e4
	add a,a			;a8e5
	ld e,a			;a8e6
	ld d,000h		;a8e7
	add hl,de			;a8e9
	ld e,(hl)			;a8ea
	inc hl			;a8eb
	ld d,(hl)			;a8ec
	ld l,(ix+01bh)		;a8ed
	ld h,(ix+01ch)		;a8f0
	ex de,hl			;a8f3
	add hl,de			;a8f4
	jr nc,L_A8F8		;a8f5
	ex de,hl			;a8f7
L_A8F8:
	ld (ix+019h),e		;a8f8
	ld (ix+01ah),d		;a8fb
	ret			;a8fe
L_A8FF:
	and 07fh		;a8ff
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
	ld d,(ix+01ah)		;a915
	ld e,(ix+019h)		;a918
	ld l,(ix+010h)		;a91b
	ld h,(ix+011h)		;a91e
	ld a,h			;a921
	or a			;a922
	sbc hl,de		;a923
	ld h,a			;a925
	ld a,000h		;a926
	jr z,L_A944		;a928
	ld a,0e8h		;a92a
	jr nc,L_A944		;a92c
	ld a,h			;a92e
	push af			;a92f
	ld hl,0a991h		;a930
	ld a,(0e25bh)		;a933
	call 04a44h		;a936
	pop af			;a939
	cp 010h		;a93a
	jr c,L_A940		;a93c
	ld a,00fh		;a93e
L_A940:
	call 040d0h		;a940
	ld a,(hl)			;a943
L_A944:
	ld (ix+012h),a		;a944
	ret			;a947
L_A948:
	ld e,(ix+01bh)		;a948
	ld d,(ix+01ch)		;a94b
	ret			;a94e

; ----------------------------------------------------------------------
; DATOS tabla_curvas_A94F: 3 punteros a las listas de abajo; los lee 0xA948,
;   que devuelve en DE la palabra (ix+1B,1C) del coche
;   0xa94f..0xa955  (6 bytes)
DATA_tabla_curvas_A94F:
	defw 0a955h	; a94f  -> DATA_curvas_A955
	defw 0a969h	; a951
	defw 0a97dh	; a953

; ----------------------------------------------------------------------
; DATOS curvas_A955: 3 listas de 10 palabras con signo, decrecientes y
;   estabilizadas al final: -412..-435, -1032..-1088 y -2064..-2048 (esta
;   ultima salta a -2048 en la octava). Por su forma son tablas de fisica de
;   la carrera; que magnitud, por identificar
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
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (360 bytes)
;   0xa991..0xaaf9  (360 bytes)
DATA_A991:
	defb 09dh,0a9h,0adh,0a9h,0bdh,0a9h,0cdh,0a9h,0ddh,0a9h,0edh,0a9h,050h,040h,030h,02ch	; a991  ............P@0,
	defb 018h,018h,018h,018h,010h,00dh,009h,004h,003h,002h,002h,001h,038h,02ch,021h,01eh	; a9a1  ............8,!.
	defb 010h,010h,010h,010h,00bh,009h,006h,002h,002h,001h,001h,000h,030h,026h,01ch,01ah	; a9b1  ............0&..
	defb 00eh,00eh,00eh,00eh,006h,004h,002h,001h,001h,001h,001h,000h,040h,033h,026h,023h	; a9c1  ............@3&#
	defb 013h,013h,013h,013h,00ch,00ah,007h,003h,002h,001h,001h,000h,053h,043h,033h,02fh	; a9d1  ............SC3/
	defb 018h,018h,018h,018h,010h,00dh,009h,004h,003h,002h,002h,001h,060h,04ch,039h,034h	; a9e1  ............`L94
	defb 01ch,01ch,01ch,01ch,013h,00fh,00ah,004h,003h,002h,002h,001h,009h,0aah,031h,0aah	; a9f1  ..............1.
	defb 059h,0aah,081h,0aah,0a9h,0aah,0d1h,0aah,000h,006h,033h,007h,080h,005h,099h,006h	; aa01  Y.........3.....
	defb 0c0h,005h,0e6h,006h,040h,005h,04ch,006h,060h,005h,073h,006h,0c0h,006h,019h,008h	; aa11  ....@.L.`.s.....
	defb 080h,005h,099h,006h,030h,007h,030h,007h,080h,005h,080h,005h,000h,005h,000h,006h	; aa21  ....0.0.........
	defb 0cch,008h,073h,00ah,0f4h,008h,0a3h,00ah,0a3h,008h,041h,00ah,05bh,008h,0ech,009h	; aa31  ..s.......A.[...
	defb 070h,008h,004h,00ah,08eh,008h,029h,00ah,066h,008h,0f9h,009h,080h,00bh,080h,00bh	; aa41  p.....).f.......
	defb 080h,009h,080h,009h,0ach,007h,01eh,009h,0d0h,00bh,020h,00dh,0b2h,00bh,000h,00dh	; aa51  .......... .....
	defb 0d0h,00bh,020h,00dh,040h,00bh,080h,00ch,078h,00bh,0c0h,00ch,0d4h,00bh,026h,00dh	; aa61  .. .@...x.....&.
	defb 0b2h,00bh,000h,00dh,000h,00eh,020h,00eh,000h,00dh,020h,00dh,0cch,00ah,000h,00ch	; aa71  ...... ... .....
	defb 031h,00ch,010h,00dh,051h,00bh,021h,00ch,0c1h,00bh,098h,00ch,0e3h,00ah,0aah,00bh	; aa81  1...Q.!.........
	defb 01ah,00bh,0e5h,00bh,080h,00dh,077h,00eh,051h,00bh,021h,00ch,060h,00eh,060h,00eh	; aa91  ......w.Q.!.`.`.
	defb 000h,00dh,000h,00dh,073h,00ah,031h,00bh,071h,00ch,0b0h,00dh,08eh,00bh,0b5h,00ch	; aaa1  ....s.1.q.......
	defb 000h,00ch,031h,00dh,01ch,00bh,038h,00ch,055h,00bh,077h,00ch,0c7h,00dh,027h,00fh	; aab1  ..1...8.U.w...'.
	defb 08eh,00bh,0b5h,00ch,000h,00fh,000h,00fh,080h,00dh,080h,00dh,0aah,00ah,0bah,00bh	; aac1  ................
	defb 000h,00dh,0f1h,00eh,08eh,00bh,048h,00dh,000h,00ch,0cch,00dh,01ch,00bh,0c7h,00ch	; aad1  ......H.........
	defb 055h,00bh,007h,00dh,0aah,00ch,090h,00eh,08eh,00bh,048h,00dh,0f0h,010h,0f0h,010h	; aae1  U.........H.....
	defb 030h,00fh,030h,00fh,0aah,00ah,043h,00ch	; aaf1  0.0...C.

; ======================================================================
; CODIGO 0xaaf9..0xac0d  (276 bytes)
; ======================================================================


L_AAF9:
	call L_B353		;aaf9
	ret nc			;aafc
	bit 6,a		;aafd
	jp nz,L_AB24		;aaff
	bit 4,(ix+001h)		;ab02
	jr nz,L_AB20		;ab06
L_AB08:
	and 07fh		;ab08
	ld b,a			;ab0a
L_AB0B:
	ld a,(ix+032h)		;ab0b
	cp b			;ab0e
	ret z			;ab0f
	ld a,b			;ab10
	or 080h		;ab11
	ld (ix+032h),a		;ab13
	ld a,(ix+017h)		;ab16
	and 080h		;ab19
	or b			;ab1b
	ld (ix+017h),a		;ab1c
	ret			;ab1f
L_AB20:
	and a			;ab20
	ret z			;ab21
	jr L_AB08		;ab22
L_AB24:
	and 03fh		;ab24
	jr z,L_AB34		;ab26
	dec a			;ab28
	jr nz,L_AB5B		;ab29
	res 4,(ix+001h)		;ab2b
	ld b,000h		;ab2f
	jp L_AB0B		;ab31
L_AB34:
	bit 1,(iy+001h)		;ab34
	ret z			;ab38
	ld a,(0e214h)		;ab39
	dec a			;ab3c
	ret nz			;ab3d
	bit 1,(ix+001h)		;ab3e
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
	set 4,(ix+017h)		;ab5d
	ret			;ab61
L_AB62:
	ret			;ab62
L_AB63:
	ld a,(0e1c2h)		;ab63
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
	ld a,(iy+000h)		;ab90
	or a			;ab93
	jr z,L_ABAF		;ab94
	push bc			;ab96
	call L_AD26		;ab97
	jr c,L_ABA0		;ab9a
	ld (iy+026h),000h		;ab9c
L_ABA0:
	call c,L_AEEF		;aba0
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
	call L_ABF8		;abb7
	ld a,(ix+004h)		;abba
	sub 008h		;abbd
	sub (iy+004h)		;abbf
	jr nc,L_ABD5		;abc2
	ld h,(iy+01ah)		;abc4
	ld l,(iy+019h)		;abc7
	sra h		;abca
	rr l		;abcc
	ld (iy+01ah),h		;abce
	ld (iy+019h),l		;abd1
	ret			;abd4
L_ABD5:
	ld a,(ix+006h)		;abd5
	sub 007h		;abd8
	ld a,(iy+006h)		;abda
	cp 00fh		;abdd
	ret nc			;abdf
	ld h,(iy+008h)		;abe0
	ld l,(iy+007h)		;abe3
	ld d,h			;abe6
	ld e,l			;abe7
	sra h		;abe8
	rr l		;abea
	sra h		;abec
	rr l		;abee
	add hl,de			;abf0
	ld (iy+008h),h		;abf1
	ld (iy+007h),l		;abf4
	ret			;abf7
L_ABF8:
	ld a,(iy+006h)		;abf8
	cp (ix+006h)		;abfb
	ld hl,00104h		;abfe
	jr nc,L_AC06		;ac01
	ld hl,00203h		;ac03
L_AC06:
	ld (ix+002h),h		;ac06
	ld (ix+034h),l		;ac09
	ret			;ac0c

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (37 bytes)
;   0xac0d..0xac32  (37 bytes)
DATA_AC0D:
	defb 0fdh,07eh,000h,04fh,0e6h,00fh,06fh,026h,000h,011h,022h,0ach,019h,079h,0e6h,0f0h	; ac0d  .~.O..o&.."..y..
	defb 0b6h,0fdh,077h,000h,0c9h,000h,003h,004h,005h,006h,007h,001h,002h,008h,009h,00ah	; ac1d  ..w.............
	defb 00bh,00ch,00dh,00eh,00fh	; ac2d

; ======================================================================
; CODIGO 0xac32..0xb137  (1285 bytes)
; ======================================================================


L_AC32:
	ld iy,0e380h		;ac32
	ld ix,0e2c0h		;ac36
	ld a,(ix+05dh)		;ac3a
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
	ld a,(0e214h)		;ac55
	and a			;ac58
	ret nz			;ac59
	ld hl,0ea71h		;ac5a
	ld a,(ix+004h)		;ac5d
	sub (iy+05ah)		;ac60
	ld d,(ix+029h)		;ac63
	ld (hl),a			;ac66
	ld (ix+029h),a		;ac67
	add a,00fh		;ac6a
	cp 01eh		;ac6c
	jp nc,L_ADA5		;ac6e
	ld a,(ix+006h)		;ac71
	sub (iy+006h)		;ac74
	add a,008h		;ac77
	cp 010h		;ac79
	push af			;ac7b
	ld a,d			;ac7c
	xor (ix+029h)		;ac7d
	rla			;ac80
	jp nc,L_ADA4		;ac81
	call L_AC89		;ac84
	pop af			;ac87
	ret			;ac88
L_AC89:
	ld a,(iy+071h)		;ac89
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
	call c,04b04h		;aca9
	ld de,00200h		;acac
	or a			;acaf
	sbc hl,de		;acb0
	jp c,L_ADA2		;acb2
	set 0,(iy+030h)		;acb5
	ld a,003h		;acb9
	call 04174h		;acbb
	or a			;acbe
	ret			;acbf
L_ACC0:
	ld ix,0e928h		;acc0
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
	ld a,(ix+000h)		;acdb
	and a			;acde
	push bc			;acdf
	call nz,L_ACF4		;ace0
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
	ld b,a			;acf4
	and 070h		;acf5
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
	ld a,(ix+004h)		;ad0d
	sub (iy+004h)		;ad10
	ld (0ea71h),a		;ad13
	add a,00fh		;ad16
	cp 01eh		;ad18
	ret nc			;ad1a
	ld a,(ix+006h)		;ad1b
	sub (iy+006h)		;ad1e
	add a,008h		;ad21
	cp 010h		;ad23
	ret			;ad25
L_AD26:
	ld a,(ix+004h)		;ad26
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
	xor (iy+029h)		;ad44
	rla			;ad47
	jr nc,L_ADA4		;ad48
	call L_AD4F		;ad4a
	pop af			;ad4d
	ret			;ad4e
L_AD4F:
	ld a,(iy+000h)		;ad4f
	and 00fh		;ad52
	cp 00fh		;ad54
	ret z			;ad56
	call L_ADAA		;ad57
	ld a,(ix+05dh)		;ad5a
	cp 006h		;ad5d
	ret z			;ad5f
	bit 0,(iy+030h)		;ad60
	ret nz			;ad64
	ld l,(ix+010h)		;ad65
	ld h,(ix+011h)		;ad68
	ld e,(iy+010h)		;ad6b
	ld d,(iy+011h)		;ad6e
	or a			;ad71
	sbc hl,de		;ad72
	call c,04b04h		;ad74
	ld de,00180h		;ad77
	or a			;ad7a
	sbc hl,de		;ad7b
	ret c			;ad7d
	ld de,00300h		;ad7e
	set 0,(iy+030h)		;ad81
	ld a,(0e1c2h)		;ad85
	bit 5,a		;ad88
	jr z,L_AD97		;ad8a
	ld a,006h		;ad8c
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
	res 0,(iy+030h)		;ada5
	ret			;ada9
L_ADAA:
	ld a,(0e214h)		;adaa
	and a			;adad
	ret nz			;adae
	bit 1,(iy+001h)		;adaf
	ret nz			;adb3
	bit 1,(ix+001h)		;adb4
	ret nz			;adb8
	bit 6,(iy+030h)		;adb9
	ret nz			;adbd
	bit 7,(iy+030h)		;adbe
	jr nz,L_AE03		;adc2
	ld a,(ix+071h)		;adc4
	dec a			;adc7
	jr z,L_AE03		;adc8
	ld a,(ix-002h)		;adca
	and a			;adcd
	jr z,L_AE03		;adce
	ld hl,0e1fch		;add0
	sub (hl)			;add3
	cp 002h		;add4
	jr c,L_AE03		;add6
	ld a,(ix+07eh)		;add8
	cp (ix+071h)		;addb
	jr z,L_AE03		;adde
	jp m,L_AE03		;ade0
	ld a,(ix+030h)		;ade3
	xor 002h		;ade6
	ld (ix+030h),a		;ade8
	bit 1,(ix+030h)		;adeb
	jr nz,L_AE03		;adef
L_ADF1:
	bit 7,(iy+000h)		;adf1
	jp z,L_AEC3		;adf5
	jr L_AE0E		;adf8
L_ADFA:
	bit 7,(iy+000h)		;adfa
	jp nz,L_AEC3		;adfe
	jr L_AE0E		;ae01
L_AE03:
	ld a,(ix+071h)		;ae03
	cp 001h		;ae06
	jr z,L_ADF1		;ae08
	cp 063h		;ae0a
	jr z,L_ADFA		;ae0c
L_AE0E:
	bit 7,(iy+029h)		;ae0e
	ld b,(ix+071h)		;ae12
	jr nz,L_AE6E		;ae15
	call L_AEE5		;ae17
	jr c,L_AE3F		;ae1a
	bit 7,(iy+030h)		;ae1c
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
	sub 064h		;ae31
	neg		;ae33
	inc b			;ae35
	cp b			;ae36
	jp z,L_AEC3		;ae37
	ld (ix+071h),b		;ae3a
	jr L_AE4E		;ae3d
L_AE3F:
	inc b			;ae3f
	ld a,b			;ae40
	cp 064h		;ae41
	jr nc,L_AEBF		;ae43
	ld (ix+071h),b		;ae45
	set 2,(ix+030h)		;ae48
	jr L_AE51		;ae4c
L_AE4E:
	call L_AECE		;ae4e
L_AE51:
	set 7,(iy+030h)		;ae51
	ld a,(ix+071h)		;ae55
	cp 063h		;ae58
	ret nz			;ae5a
	res 7,(iy+000h)		;ae5b
	ret			;ae5f
L_AE60:
	inc b			;ae60
	ld a,b			;ae61
	cp 064h		;ae62
	jr nc,L_AEC3		;ae64
	ld (ix+071h),b		;ae66
	call L_AEC8		;ae69
	jr L_AE51		;ae6c
L_AE6E:
	call L_AEE5		;ae6e
	jr c,L_AE91		;ae71
	bit 7,(iy+030h)		;ae73
	jr nz,L_AEAE		;ae77
	ld a,(ix+030h)		;ae79
	rra			;ae7c
	rra			;ae7d
	rra			;ae7e
	and 007h		;ae7f
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
	dec b			;ae91
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
	set 7,(iy+000h)		;aea9
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
	set 2,(ix+030h)		;aebf
L_AEC3:
	set 6,(iy+030h)		;aec3
	ret			;aec7
L_AEC8:
	push ix		;aec8
	pop hl			;aeca
	call L_A524		;aecb
L_AECE:
	push ix		;aece
	pop hl			;aed0
	jp L_A509		;aed1
L_AED4:
	push ix		;aed4
	pop hl			;aed6
	call L_A510		;aed7
L_AEDA:
	push ix		;aeda
	pop hl			;aedc
	jp L_A517		;aedd
L_AEE0:
	ld a,(ix+000h)		;aee0
	jr L_AEE8		;aee3
L_AEE5:
	ld a,(iy+000h)		;aee5
L_AEE8:
	and 00fh		;aee8
	sub 008h		;aeea
	cp 002h		;aeec
	ret			;aeee
L_AEEF:
	ld a,(ix+05dh)		;aeef
	cp 000h		;aef2
	ret nz			;aef4
	ld a,(iy+000h)		;aef5
	and 00fh		;aef8
	cp 00fh		;aefa
	ret z			;aefc
	ld a,(ix+004h)		;aefd
	add a,008h		;af00
	cp (iy+004h)		;af02
	call c,L_AF32		;af05
	ret c			;af08
	set 7,(ix+001h)		;af09
	set 7,(iy+001h)		;af0d
	ld a,(iy+026h)		;af11
	and a			;af14
	jp nz,L_B158		;af15
	ld a,017h		;af18
	call 0867bh		;af1a
	ld (ix+026h),001h		;af1d
	ld (iy+026h),002h		;af21
	call L_B24A		;af25
	add a,(ix+064h)		;af28
	ld (ix+064h),a		;af2b
	exx			;af2e
	jp L_B01D		;af2f
L_AF32:
	ld a,(iy+000h)		;af32
	and 00fh		;af35
	sub 008h		;af37
	cp 002h		;af39
	ccf			;af3b
	ret nc			;af3c
	ld a,(ix+008h)		;af3d
	sub 001h		;af40
	cp (iy+008h)		;af42
	ccf			;af45
	ret nc			;af46
	call L_B15C		;af47
	scf			;af4a
	ret			;af4b
L_AF4C:
	call L_B00C		;af4c
	ld a,(ix+004h)		;af4f
	cp (iy+004h)		;af52
	ld d,001h		;af55
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
	call L_AFAB		;af6d
	ld a,(ix+006h)		;af70
	cp (iy+006h)		;af73
	ld d,010h		;af76
	jr nc,L_AF7C		;af78
	ld d,0f0h		;af7a
L_AF7C:
	ld a,(ix+036h)		;af7c
	call L_AFC3		;af7f
	ld (ix+036h),c		;af82
	ld a,d			;af85
	neg		;af86
	ld d,a			;af88
	ld a,(iy+036h)		;af89
	call L_AFC3		;af8c
	ld (iy+036h),c		;af8f
	sra d		;af92
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
	bit 7,d		;afab
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
	or a			;afc3
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
	set 7,(ix+001h)		;afd1
	set 7,(iy+001h)		;afd5
	bit 0,(ix+05eh)		;afd9
	ret nz			;afdd
	ld a,(0e161h)		;afde
	cp 017h		;afe1
	jr z,L_AFEA		;afe3
	ld a,017h		;afe5
	call 04174h		;afe7
L_AFEA:
	set 0,(ix+05eh)		;afea
	set 0,(iy+05eh)		;afee
	ld (ix+026h),001h		;aff2
	ld (iy+026h),001h		;aff6
	call L_B24A		;affa
	add a,(ix+064h)		;affd
	ld (ix+064h),a		;b000
	add a,(iy+064h)		;b003
	ld (iy+064h),a		;b006
	exx			;b009
	jr L_B01D		;b00a
L_B00C:
	ld a,(iy+000h)		;b00c
	and 00fh		;b00f
	cp 00fh		;b011
	ret z			;b013
	ld a,(ix+000h)		;b014
	and 00fh		;b017
	cp 00fh		;b019
	ret z			;b01b
	exx			;b01c
L_B01D:
	ld c,(iy+007h)		;b01d
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
	call L_B265		;b03a
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
	call L_B2F6		;b05a
	jp L_B0E8		;b05d
L_B060:
	ld h,b			;b060
	ld l,c			;b061
	add hl,de			;b062
	sra h		;b063
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
	sra h		;b073
	rr l		;b075
	sra h		;b077
	rr l		;b079
	or a			;b07b
	adc hl,de		;b07c
	jp m,L_B084		;b07e
	ld hl,00000h		;b081
L_B084:
	push hl			;b084
	ld h,b			;b085
	ld l,c			;b086
	or a			;b087
	sbc hl,de		;b088
	push hl			;b08a
	ld a,h			;b08b
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
	jp m,L_B0A3		;b09d
	ld hl,00000h		;b0a0
L_B0A3:
	exx			;b0a3
	pop bc			;b0a4
	pop hl			;b0a5
	pop de			;b0a6
	ret			;b0a7
L_B0A8:
	ld h,b			;b0a8
	ld l,c			;b0a9
	add hl,de			;b0aa
	sra h		;b0ab
	rr l		;b0ad
	ex de,hl			;b0af
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
	sra h		;b0bb
	rr l		;b0bd
	sra h		;b0bf
	rr l		;b0c1
	sra h		;b0c3
	rr l		;b0c5
	add hl,de			;b0c7
	push hl			;b0c8
	ld h,b			;b0c9
	ld l,c			;b0ca
	or a			;b0cb
	sbc hl,de		;b0cc
	push hl			;b0ce
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
	add hl,de			;b0e2
	exx			;b0e3
	pop bc			;b0e4
	pop hl			;b0e5
	pop de			;b0e6
	ret			;b0e7
L_B0E8:
	push ix		;b0e8
	ld l,(ix+024h)		;b0ea
	ld h,(ix+025h)		;b0ed
	ld a,h			;b0f0
	or l			;b0f1
	jr z,L_B10F		;b0f2
	ld e,(ix+007h)		;b0f4
	ld d,(ix+008h)		;b0f7
	ld c,(ix+00ah)		;b0fa
	ld b,(ix+00bh)		;b0fd
	push hl			;b100
	pop ix		;b101
	ld (ix+007h),e		;b103
	ld (ix+008h),d		;b106
	ld (ix+00ah),c		;b109
	ld (ix+00bh),b		;b10c
L_B10F:
	ld l,(iy+024h)		;b10f
	ld h,(iy+025h)		;b112
	ld a,h			;b115
	or l			;b116
	jr z,L_B134		;b117
	ld e,(iy+007h)		;b119
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

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (33 bytes)
;   0xb137..0xb158  (33 bytes)
DATA_B137:
	defb 0ddh,05eh,00ah,0ddh,056h,00bh,07bh,0b2h,0c0h,0fdh,05eh,00ah,0fdh,056h,00bh,07bh	; b137  .^..V.{...^..V.{
	defb 0b2h,0c0h,03ah,070h,0eah,0cbh,07fh,03eh,008h,028h,002h,0edh,044h,0ddh,077h,00ch	; b147  ..:p...>.(..D.w.
	defb 0c9h	; b157

; ======================================================================
; CODIGO 0xb158..0xb4e7  (911 bytes)
; ======================================================================


L_B158:
	dec (iy+026h)		;b158
	ret nz			;b15b
L_B15C:
	push bc			;b15c
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
	ld a,021h		;b174
	call 08674h		;b176
	ld a,d			;b179
	or e			;b17a
	jr z,L_B183		;b17b
	push de			;b17d
	pop ix		;b17e
	call L_B559		;b180
L_B183:
	pop iy		;b183
	pop ix		;b185
	pop bc			;b187
	ret			;b188
L_B189:
	ld a,(0e1c2h)		;b189
	bit 5,a		;b18c
	ret nz			;b18e
	call L_B1D3		;b18f
	bit 7,(ix+029h)		;b192
	jr nz,L_B1BB		;b196
	call L_AEE0		;b198
	jr c,L_B1C1		;b19b
	ld b,(iy+071h)		;b19d
	ld a,(iy+030h)		;b1a0
	rra			;b1a3
	rra			;b1a4
	rra			;b1a5
	and 007h		;b1a6
	bit 2,(iy+030h)		;b1a8
	jr z,L_B1AF		;b1ac
	inc a			;b1ae
L_B1AF:
	dec b			;b1af
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
	res 2,(iy+030h)		;b1c1
	ld a,(iy+071h)		;b1c5
	dec a			;b1c8
	ret z			;b1c9
	ld (iy+071h),a		;b1ca
	ret			;b1cd
L_B1CE:
	res 2,(iy+030h)		;b1ce
	ret			;b1d2
L_B1D3:
	push ix		;b1d3
	set 3,(ix+030h)		;b1d5
	ld a,(iy+030h)		;b1d9
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
	cp 00fh		;b1f8
	jr z,L_B23F		;b1fa
	and 070h		;b1fc
	jr nz,L_B23F		;b1fe
	bit 3,(ix+030h)		;b200
	jr nz,L_B23F		;b204
	call L_AEE0		;b206
	jr c,L_B23F		;b209
	bit 6,(ix+030h)		;b20b
	jr nz,L_B23F		;b20f
	ld a,(iy+004h)		;b211
	cp (ix+004h)		;b214
	jr nc,L_B22D		;b217
	bit 7,(ix+030h)		;b219
	jr nz,L_B225		;b21d
	bit 2,(ix+030h)		;b21f
	jr nz,L_B23F		;b223
L_B225:
	push iy		;b225
	pop hl			;b227
	call L_A517		;b228
	jr L_B23F		;b22b
L_B22D:
	bit 7,(ix+030h)		;b22d
	jr nz,L_B239		;b231
	bit 2,(ix+030h)		;b233
	jr z,L_B23F		;b237
L_B239:
	push iy		;b239
	pop hl			;b23b
	call L_A509		;b23c
L_B23F:
	res 3,(ix+030h)		;b23f
	add ix,de		;b243
	djnz L_B1F2		;b245
	pop ix		;b247
	ret			;b249
L_B24A:
	exx			;b24a
	ld e,(ix+010h)		;b24b
	ld d,(ix+011h)		;b24e
	ld l,(iy+010h)		;b251
	ld h,(iy+011h)		;b254
	or a			;b257
	sbc hl,de		;b258
	call c,04b04h		;b25a
	ld a,h			;b25d
	srl a		;b25e
	srl a		;b260
	inc a			;b262
	exx			;b263
	ret			;b264
L_B265:
	ld a,(ix+000h)		;b265
	or a			;b268
	jr z,L_B291		;b269
	ld a,(iy+000h)		;b26b
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
	bit 7,b		;b282
	ld a,008h		;b284
	jr nz,L_B28A		;b286
	neg		;b288
L_B28A:
	add a,(ix+00ch)		;b28a
	ld (ix+00ch),a		;b28d
	ret			;b290
L_B291:
	ld h,(ix+004h)		;b291
	ld l,(ix+003h)		;b294
	or a			;b297
	sbc hl,de		;b298
	or a			;b29a
	sbc hl,de		;b29b
	call L_B2B9		;b29d
	ld (ix+004h),h		;b2a0
	ld (ix+003h),l		;b2a3
	ld h,(iy+004h)		;b2a6
	ld l,(iy+003h)		;b2a9
	or a			;b2ac
	sbc hl,bc		;b2ad
	or a			;b2af
	sbc hl,bc		;b2b0
	ld (iy+004h),h		;b2b2
	ld (iy+003h),l		;b2b5
	ret			;b2b8
L_B2B9:
	ld a,(iy+000h)		;b2b9
	and 00fh		;b2bc
	sub 008h		;b2be
	cp 002h		;b2c0
	ret nc			;b2c2
	or a			;b2c3
	sbc hl,de		;b2c4
	ret			;b2c6
L_B2C7:
	call L_B291		;b2c7
	ld b,(ix+011h)		;b2ca
	ld c,(ix+010h)		;b2cd
	ld d,(iy+011h)		;b2d0
	ld e,(iy+010h)		;b2d3
	ld h,b			;b2d6
	ld l,c			;b2d7
	add hl,de			;b2d8
	sra h		;b2d9
	rr l		;b2db
	ex de,hl			;b2dd
	add hl,de			;b2de
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
	ld h,(ix+006h)		;b2f6
	ld l,(ix+005h)		;b2f9
	or a			;b2fc
	sbc hl,de		;b2fd
	or a			;b2ff
	sbc hl,de		;b300
	call L_B2B9		;b302
	ld (ix+006h),h		;b305
	ld (ix+005h),l		;b308
	ld h,(iy+006h)		;b30b
	ld l,(iy+005h)		;b30e
	or a			;b311
	sbc hl,bc		;b312
	or a			;b314
	sbc hl,bc		;b315
	ld (iy+006h),h		;b317
	ld (iy+005h),l		;b31a
	ld a,(ix+000h)		;b31d
	or a			;b320
	ld hl,00810h		;b321
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
	bit 7,b		;b336
	ld a,l			;b338
	jr nz,L_B33D		;b339
	neg		;b33b
L_B33D:
	add a,(ix+00ch)		;b33d
	ld (ix+00ch),a		;b340
	ret			;b343
L_B344:
	push hl			;b344
	ld hl,0e1c2h		;b345
	bit 6,(hl)		;b348
	pop hl			;b34a
	jr nz,L_B365		;b34b
	jr L_B368		;b34d
L_B34F:
	ld e,080h		;b34f
	jr L_B362		;b351
L_B353:
	ld a,(0e1c3h)		;b353
	add a,(ix+009h)		;b356
	and 001h		;b359
	ret nz			;b35b
	ld a,(ix+004h)		;b35c
	sub 018h		;b35f
	ld e,a			;b361
L_B362:
	call 04adch		;b362
L_B365:
	xor a			;b365
	ld c,000h		;b366
L_B368:
	cp (hl)			;b368
	call nz,L_B387		;b369
	inc l			;b36c
	inc l			;b36d
	res 6,l		;b36e
	cp (hl)			;b370
	call nz,L_B387		;b371
	inc l			;b374
	inc l			;b375
	res 6,l		;b376
	cp (hl)			;b378
	call nz,L_B387		;b379
	inc l			;b37c
	inc l			;b37d
	res 6,l		;b37e
	cp (hl)			;b380
	call nz,L_B387		;b381
	ld a,c			;b384
	scf			;b385
	ret			;b386
L_B387:
	ld a,c			;b387
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
	ld b,a			;b394
	ld a,0c0h		;b395
	cp b			;b397
	ret z			;b398
	cp c			;b399
	ret z			;b39a
	ld a,0c6h		;b39b
	cp b			;b39d
	ret z			;b39e
	cp c			;b39f
	ret z			;b3a0
	ld a,0c7h		;b3a1
	cp b			;b3a3
	ret z			;b3a4
	cp c			;b3a5
	ret z			;b3a6
	ld a,c			;b3a7
	ret			;b3a8
L_B3A9:
	xor a			;b3a9
	ld d,a			;b3aa
	ld e,030h		;b3ab
	call L_B418		;b3ad
	ld a,001h		;b3b0
	call 00141h		;b3b2   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
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
	call 00141h		;b3c4   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;b3c7
	rla			;b3c8
	rla			;b3c9
	rla			;b3ca
	and 003h		;b3cb
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
	call L_B418		;b3dc
	ld a,004h		;b3df
	ld d,e			;b3e1
	ld e,04bh		;b3e2
	call L_B418		;b3e4
	ld a,005h		;b3e7
	ld d,e			;b3e9
	ld e,053h		;b3ea
	call L_B418		;b3ec
	ld a,007h		;b3ef
	call 00141h		;b3f1   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rla			;b3f4
	jr c,L_B3F9		;b3f5
	ld e,00dh		;b3f7
L_B3F9:
	rla			;b3f9
	rla			;b3fa
	jr c,L_B3FF		;b3fb
	ld e,008h		;b3fd
L_B3FF:
	ld a,008h		;b3ff
	call 00141h		;b401   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;b404
	jr c,L_B409		;b405
	ld e,020h		;b407
L_B409:
	ld a,(0e243h)		;b409
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
	call 00141h		;b418   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;b41b
	ld b,008h		;b41c
L_B41E:
	rra			;b41e
	ret c			;b41f
	inc e			;b420
	djnz L_B41E		;b421
	ld e,d			;b423
	ret			;b424
L_B425:
	ld ix,0e2c0h		;b425
	ld iy,0e380h		;b429
	ld a,(ix+006h)		;b42d
	ld (iy+006h),a		;b430
	ld a,(ix+004h)		;b433
	ld (iy+004h),a		;b436
	ld l,(ix+03fh)		;b439
	ld h,(ix+040h)		;b43c
	add hl,hl			;b43f
	add hl,hl			;b440
	ld (iy+03fh),l		;b441
	ld (iy+040h),h		;b444
	ld (iy+009h),002h		;b447
	ret			;b44b
L_B44C:
	call L_B425		;b44c
	ld iy,0e2c0h		;b44f
	ld a,(0e244h)		;b453
	cp 002h		;b456
	ret c			;b458
	ld de,0e928h		;b459
	ld ix,0e2c0h		;b45c
	jp L_B49E		;b460
L_B463:
	ld ix,0e3d8h		;b463
	ld b,003h		;b467
	exx			;b469
	ld de,0e947h		;b46a
	exx			;b46d
L_B46E:
	ld a,(ix+000h)		;b46e
	and a			;b471
	jr z,L_B496		;b472
	call L_B4D5		;b474
	jr c,L_B496		;b477
	ld iy,0e380h		;b479
	call 04a9dh		;b47d
	ld iy,0e2c0h		;b480
	ld a,l			;b484
	exx			;b485
	ld l,a			;b486
	ld (de),a			;b487
	inc de			;b488
	exx			;b489
	ld a,h			;b48a
	exx			;b48b
	ld h,a			;b48c
	ld (de),a			;b48d
	inc de			;b48e
	ld a,(ix+002h)		;b48f
	call L_B4B7		;b492
	exx			;b495
L_B496:
	ld de,00008h		;b496
	add ix,de		;b499
	djnz L_B46E		;b49b
	ret			;b49d
L_B49E:
	push de			;b49e
	ld de,04080h		;b49f
	ld iy,0e380h		;b4a2
	call 04a9dh		;b4a6
	ld iy,0e2c0h		;b4a9
	pop de			;b4ad
L_B4AE:
	ld a,l			;b4ae
	ld (de),a			;b4af
	inc de			;b4b0
	ld a,h			;b4b1
	ld (de),a			;b4b2
	inc de			;b4b3
	ld a,(ix+018h)		;b4b4
L_B4B7:
	sub 003h		;b4b7
	jr nc,L_B4B7		;b4b9
	add a,003h		;b4bb
	ld (de),a			;b4bd
	inc de			;b4be
	ld a,007h		;b4bf
L_B4C1:
	ldi		;b4c1
	ldi		;b4c3
	ldi		;b4c5
	ldi		;b4c7
	res 2,h		;b4c9
	ld bc,0001ch		;b4cb
	add hl,bc			;b4ce
	set 2,h		;b4cf
	dec a			;b4d1
	jr nz,L_B4C1		;b4d2
	ret			;b4d4
L_B4D5:
	ld a,(ix+001h)		;b4d5
	sub 054h		;b4d8
	cp 03fh		;b4da
	ccf			;b4dc
	ret c			;b4dd
	sub 00ch		;b4de
	add a,a			;b4e0
	add a,a			;b4e1
	ld e,a			;b4e2
	ld d,070h		;b4e3
	or a			;b4e5
	ret			;b4e6

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (114 bytes)
;   0xb4e7..0xb559  (114 bytes)
DATA_B4E7:
	defb 0ddh,0cbh,001h,0feh,0cdh,02eh,0b5h,03ah,0c3h,0e1h,0e6h,003h,03eh,00fh,028h,002h	; b4e7  .......:....>.(.
	defb 03eh,006h,0ddh,077h,00fh,03ah,0c3h,0e1h,0e6h,007h,0c0h,0ddh,07eh,027h,03ch,0ddh	; b4f7  >..w.:......~'<.
	defb 077h,027h,0feh,003h,0d2h,02dh,09eh,0e6h,001h,06fh,026h,000h,011h,02ch,0b5h,019h	; b507  w'...-...o&..,..
	defb 07eh,0ddh,077h,00eh,0ddh,077h,033h,0ddh,07eh,008h,0b7h,0c0h,0ddh,036h,00eh,0f8h	; b517  ~.w..w3.~....6..
	defb 0ddh,036h,033h,0f8h,0c9h,0e8h,0f0h,0ddh,066h,00bh,0ddh,06eh,00ah,054h,05dh,0cdh	; b527  .63.....f..n.T].
	defb 08ah,04ah,0ebh,0b7h,0edh,052h,0ddh,074h,00bh,0ddh,075h,00ah,0ddh,066h,008h,0ddh	; b537  .J...R.t..u..f..
	defb 06eh,007h,054h,05dh,0cdh,08ah,04ah,0ebh,0b7h,0edh,052h,0ddh,074h,008h,0ddh,075h	; b547  n.T]..J...R.t..u
	defb 007h,0c9h	; b557

; ======================================================================
; CODIGO 0xb559..0xb598  (63 bytes)
; ======================================================================


L_B559:
	ld a,(ix+000h)		;b559
	or a			;b55c
	ret z			;b55d
	and 00fh		;b55e
	sub 008h		;b560
	cp 002h		;b562
	call c,07ff6h		;b564
	ld a,(iy+05ah)		;b567
	cp 0e0h		;b56a
	jr nz,L_B574		;b56c
	bit 0,(ix+031h)		;b56e
	jr z,L_B590		;b572
L_B574:
	call L_B189		;b574
	ld (ix+000h),00fh		;b577
	ld (ix+00fh),006h		;b57b
	ld (ix+027h),000h		;b57f
	set 7,(ix+001h)		;b583
	ld (ix+00eh),0e8h		;b587
	ld (ix+033h),0e8h		;b58b
	ret			;b58f
L_B590:
	push ix		;b590
	call 09e2dh		;b592
	pop ix		;b595
	ret			;b597

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (30 bytes)
;   0xb598..0xb5b6  (30 bytes)
DATA_B598:
	defb 0ddh,072h,006h,0ddh,073h,004h,0fdh,07eh,009h,0ddh,077h,009h,0ddh,036h,008h,000h	; b598  .r..s..~..w..6..
	defb 0ddh,036h,007h,000h,0ddh,036h,00bh,000h,0ddh,036h,00ah,000h,018h,0c5h	; b5a8  .6...6...6....

; ======================================================================
; CODIGO 0xb5b6..0xb6ec  (310 bytes)
; ======================================================================


L_B5B6:
	ld a,(0e1c3h)		;b5b6
	xor (iy+009h)		;b5b9
	rrca			;b5bc
	ret nc			;b5bd
	bit 0,(iy+009h)		;b5be
	ld l,001h		;b5c2
	jr nz,L_B5C8		;b5c4
	ld l,081h		;b5c6
L_B5C8:
	ld h,0ebh		;b5c8
	ld b,020h		;b5ca
	xor a			;b5cc
L_B5CD:
	ld (hl),a			;b5cd
	inc l			;b5ce
	inc l			;b5cf
	djnz L_B5CD		;b5d0
	ret			;b5d2
L_B5D3:
	call L_B5E0		;b5d3
	ld a,(0e1c3h)		;b5d6
	xor (ix+009h)		;b5d9
	rrca			;b5dc
	ret nc			;b5dd
	jr L_B643		;b5de
L_B5E0:
	ld a,(ix+011h)		;b5e0
	cp 004h		;b5e3
	ld d,00ch		;b5e5
	jr c,L_B5F5		;b5e7
	cp 008h		;b5e9
	ld d,008h		;b5eb
	jr c,L_B5F5		;b5ed
	ld d,004h		;b5ef
	ld (ix+049h),001h		;b5f1
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
	call L_B63A		;b604
	ld a,(ix+034h)		;b607
	or a			;b60a
	jr z,L_B619		;b60b
	add a,(ix+015h)		;b60d
	ld (ix+015h),a		;b610
	ld (ix+02dh),001h		;b613
	scf			;b617
	ret			;b618
L_B619:
	ld a,(ix+02dh)		;b619
	or a			;b61c
	ret z			;b61d
	ld (ix+02dh),000h		;b61e
	ld a,(ix+015h)		;b622
	sub (ix+016h)		;b625
	ld b,a			;b628
	xor (ix+036h)		;b629
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
	ld a,(0e1c3h)		;b63a
	xor (ix+009h)		;b63d
	rrca			;b640
	jr c,L_B652		;b641
L_B643:
	bit 5,(ix+000h)		;b643
	ret nz			;b647
	call 04ad9h		;b648
	inc l			;b64b
	ld a,(ix+006h)		;b64c
	ld (hl),a			;b64f
	or a			;b650
	ret			;b651
L_B652:
	ld (ix+034h),000h		;b652
	ld a,(ix+004h)		;b656
	sub 044h		;b659
	ld e,a			;b65b
	call 04adch		;b65c
	call L_B68B		;b65f
	ccf			;b662
	ret nc			;b663
	push bc			;b664
	call L_B899		;b665
	pop bc			;b668
	and c			;b669
	jr nz,L_B66F		;b66a
	ld a,c			;b66c
	xor 005h		;b66d
L_B66F:
	ld b,a			;b66f
	ld a,(ix+011h)		;b670
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
	ld d,000h		;b68b
	inc l			;b68d
	ld c,000h		;b68e
	ld b,007h		;b690
L_B692:
	ld a,(hl)			;b692
	or a			;b693
	call nz,L_B6A6		;b694
	inc l			;b697
	res 6,l		;b698
	inc l			;b69a
	djnz L_B692		;b69b
	ld a,d			;b69d
	cp 003h		;b69e
	ccf			;b6a0
	ret c			;b6a1
	ld a,c			;b6a2
	cp 001h		;b6a3
	ret			;b6a5
L_B6A6:
	inc d			;b6a6
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
	ld a,(ix+00ch)		;b6b9
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
	cp 080h		;b6d1
	rr l		;b6d3
	add a,002h		;b6d5
	cp 005h		;b6d7
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
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (112 bytes)
;   0xb6ec..0xb75c  (112 bytes)
DATA_B6EC:
	defb 0c8h,0c8h,0c8h,0c8h,0c8h,0c8h,0c9h,0c9h,0c9h,0cah,0cah,0cah,0cch,0cch,0cdh,0cdh	; b6ec  ................
	defb 0ceh,0cfh,0d1h,0d2h,0d3h,0d3h,0d4h,0d5h,0d8h,0d9h,0dah,0dbh,0dch,0ddh,0e0h,0e2h	; b6fc  ................
	defb 0e3h,0e4h,0e5h,0e6h,0eah,0ebh,0edh,0eeh,0efh,0f1h,0f5h,0f6h,0f7h,0f9h,0fah,0fbh	; b70c  ................
	defb 000h,001h,002h,004h,005h,006h,00ah,00ch,00dh,00eh,010h,011h,015h,016h,017h,019h	; b71c  ................
	defb 01ah,01bh,01fh,020h,021h,022h,023h,024h,027h,028h,029h,02ah,02bh,02ch,02eh,02fh	; b72c  ... !"#$'()*+,./
	defb 030h,030h,031h,032h,033h,034h,034h,035h,035h,035h,036h,037h,037h,037h,037h,037h	; b73c  0012344555677777
	defb 037h,0cdh,004h,0b6h,0d8h,0ddh,07eh,017h,0e6h,003h,0cch,05ch,0b7h,0c3h,089h,0b7h	; b74c  7.....~....\....

; ======================================================================
; CODIGO 0xb75c..0xb82f  (211 bytes)
; ======================================================================


L_B75C:
	ld a,(ix+002h)		;b75c
	or a			;b75f
	ret nz			;b760
	ld a,(0e1c3h)		;b761
	and 01ch		;b764
	ret nz			;b766
	ld a,(ix+004h)		;b767
	add a,050h		;b76a
	sub (iy+004h)		;b76c
	cp 050h		;b76f
	ret nc			;b771
	ld a,(iy+006h)		;b772
	sub (ix+015h)		;b775
	sbc a,a			;b778
	add a,a			;b779
	add a,a			;b77a
	add a,a			;b77b
	add a,004h		;b77c
	add a,(ix+015h)		;b77e
	ld (ix+015h),a		;b781
	ret			;b784
L_B785:
	ld a,001h		;b785
	jr L_B78B		;b787
L_B789:
	ld a,000h		;b789
L_B78B:
	ld (0ea7fh),a		;b78b
	ld a,(ix+002h)		;b78e
	and 00fh		;b791
	dec a			;b793
	jr z,L_B79E		;b794
	jp p,L_B7B1		;b796
	ld hl,0b82fh		;b799
	jr L_B7C4		;b79c
L_B79E:
	ld hl,0b83fh		;b79e
	call L_B7C4		;b7a1
	ld a,(ix+017h)		;b7a4
	and 010h		;b7a7
	cp 010h		;b7a9
	ret nz			;b7ab
	ld (ix+002h),002h		;b7ac
	ret			;b7b0
L_B7B1:
	ld hl,0b837h		;b7b1
	call L_B7C4		;b7b4
	ld a,(ix+017h)		;b7b7
	and 010h		;b7ba
	cp 010h		;b7bc
	ret nz			;b7be
	ld (ix+002h),001h		;b7bf
	ret			;b7c3
L_B7C4:
	push hl			;b7c4
	ld a,0c8h		;b7c5
	add a,(ix+004h)		;b7c7
	ld e,a			;b7ca
	ld d,(ix+015h)		;b7cb
	call L_B89F		;b7ce
	ld e,a			;b7d1
	ld d,000h		;b7d2
	pop hl			;b7d4
	add hl,de			;b7d5
	ld a,(hl)			;b7d6
	ld d,a			;b7d7
	add a,(ix+015h)		;b7d8
	ld (ix+015h),a		;b7db
	bit 1,e		;b7de
	jr nz,L_B7E8		;b7e0
	sub (ix+034h)		;b7e2
	ld (ix+015h),a		;b7e5
L_B7E8:
	ld a,(0ea7fh)		;b7e8
	dec a			;b7eb
	jr nz,L_B7F4		;b7ec
	ld a,(ix+017h)		;b7ee
	and 003h		;b7f1
	ret nz			;b7f3
L_B7F4:
	ld a,(ix+034h)		;b7f4
	and a			;b7f7
	ret nz			;b7f8
	ld a,e			;b7f9
	cp 007h		;b7fa
	ret nz			;b7fc
	bit 7,(ix+036h)		;b7fd
	jr z,L_B816		;b801
	ld a,(ix+015h)		;b803
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
	ld d,001h		;b81c
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
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (24 bytes)
;   0xb82f..0xb847  (24 bytes)
DATA_B82F:
	defb 00ch,00ch,000h,006h,0f4h,00ch,0fah,000h,0f4h,00ch,000h,000h,0f4h,0f4h,0fah,0feh	; b82f  ................
	defb 00ch,00ch,000h,006h,0f4h,00ch,000h,002h	; b83f  ........

; ======================================================================
; CODIGO 0xb847..0xb86d  (38 bytes)
; ======================================================================


L_B847:
	ld hl,0b837h		;b847
	bit 7,(ix+036h)		;b84a
	jr z,L_B853		;b84e
	ld hl,0b83fh		;b850
L_B853:
	push hl			;b853
	ld a,0c8h		;b854
	add a,(ix+004h)		;b856
	ld e,a			;b859
	ld d,(ix+016h)		;b85a
	call L_B89F		;b85d
	ld e,a			;b860
	ld d,000h		;b861
	pop hl			;b863
	add hl,de			;b864
	ld a,(hl)			;b865
	add a,(ix+016h)		;b866
	ld (ix+016h),a		;b869
	ret			;b86c

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (44 bytes)
;   0xb86d..0xb899  (44 bytes)
DATA_B86D:
	defb 0ddh,07eh,017h,0e6h,03ch,0feh,030h,0d0h,0e6h,00ch,0feh,008h,028h,019h,0feh,004h	; b86d  .~..<.0.....(...
	defb 0c0h,018h,00fh,0ddh,07eh,017h,0e6h,03ch,0feh,030h,0d0h,0feh,004h,028h,008h,0feh	; b87d  ....~..<.0...(..
	defb 008h,0c0h,0ddh,036h,002h,001h,0c9h,0ddh,036h,002h,002h,0c9h	; b88d  ...6....6...

; ======================================================================
; CODIGO 0xb899..0xb8d4  (59 bytes)
; ======================================================================


L_B899:
	ld d,(ix+006h)		;b899
	ld e,(ix+004h)		;b89c
L_B89F:
	ld a,d			;b89f
	sub 018h		;b8a0
	ld d,a			;b8a2
	call 04a9dh		;b8a3
	ld a,(0e26ch)		;b8a6
	ld d,a			;b8a9
	ld a,(0e272h)		;b8aa
	sub d			;b8ad
	ld e,a			;b8ae
	ld a,l			;b8af
	and 0e0h		;b8b0
	ld b,a			;b8b2
	ld a,(hl)			;b8b3
	sub d			;b8b4
	cp e			;b8b5
	rl c		;b8b6
	ld a,l			;b8b8
	add a,003h		;b8b9
	and 01fh		;b8bb
	or b			;b8bd
	ld l,a			;b8be
	ld a,(hl)			;b8bf
	sub d			;b8c0
	cp e			;b8c1
	rl c		;b8c2
	ld a,l			;b8c4
	add a,003h		;b8c5
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

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (89 bytes)
;   0xb8d4..0xb92d  (89 bytes)
DATA_B8D4:
	defb 0ddh,056h,006h,0ddh,05eh,004h,07ah,0d6h,010h,057h,0cdh,09dh,04ah,03ah,06ch,0e2h	; b8d4  .V..^.z..W..J:l.
	defb 057h,03ah,072h,0e2h,092h,05fh,07eh,023h,092h,0bbh,0cbh,011h,07eh,023h,092h,0bbh	; b8e4  W:r.._~#....~#..
	defb 0cbh,011h,07eh,092h,0bbh,0cbh,011h,079h,0e6h,007h,0c9h,0cdh,017h,0b9h,01eh,0c8h	; b8f4  ..~....y........
	defb 0cdh,0b4h,0a3h,0ddh,072h,015h,0c9h,0cdh,017h,0b9h,01eh,0c8h,0cdh,0e3h,0a3h,0ddh	; b904  ....r...........
	defb 072h,015h,0c9h,01eh,0c8h,0ddh,0cbh,036h,07eh,020h,007h,0cdh,0e3h,0a3h,0ddh,072h	; b914  r......6~ .....r
	defb 016h,0c9h,0cdh,0b4h,0a3h,0ddh,072h,016h,0c9h	; b924  ......r..

; ======================================================================
; CODIGO 0xb92d..0xb96f  (66 bytes)
; ======================================================================


L_B92D:
	bit 1,(ix+030h)		;b92d
	jr nz,L_B951		;b931
	bit 7,(ix+000h)		;b933
	ld a,000h		;b937
	jp nz,L_B95A		;b939
	jr L_B94D		;b93c
L_B93E:
	bit 1,(ix+030h)		;b93e
	jr nz,L_B951		;b942
	bit 7,(ix+000h)		;b944
	ld a,0bfh		;b948
	jp z,L_B95A		;b94a
L_B94D:
	set 1,(ix+030h)		;b94d
L_B951:
	call L_B847		;b951
	call L_B960		;b954
	jp L_B6B7		;b957
L_B95A:
	ld (ix+004h),a		;b95a
	jp 09e2dh		;b95d
L_B960:
	call L_B604		;b960
	ret c			;b963
	ld a,(ix+017h)		;b964
	and 003h		;b967
	call z,L_B75C		;b969
	jp L_B785		;b96c

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (44 bytes)
;   0xb96f..0xb99b  (44 bytes)
DATA_B96F:
	defb 0cdh,086h,0b9h,0ddh,036h,00fh,00ch,0c9h,03eh,00ah,032h,009h,0e2h,0cdh,086h,0b9h	; b96f  ....6...>.2.....
	defb 0ddh,036h,00fh,004h,0c3h,0f4h,080h,03eh,001h,032h,07dh,0eah,0cdh,061h,0a5h,0cdh	; b97f  .6.....>.2}..a..
	defb 096h,0b9h,0ddh,036h,018h,000h,0c9h,0ddh,036h,002h,001h,0c9h	; b98f  ...6....6...

; ======================================================================
; CODIGO 0xb99b..0xb9b3  (24 bytes)
; ======================================================================


L_B99B:
	call L_B847		;b99b
	call L_B9A4		;b99e
	jp L_B6B7		;b9a1
L_B9A4:
	call L_B604		;b9a4
	ret c			;b9a7
	ld a,(ix+017h)		;b9a8
	and 003h		;b9ab
	call z,L_B75C		;b9ad
	jp L_B789		;b9b0

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (13 bytes)
;   0xb9b3..0xb9c0  (13 bytes)
DATA_B9B3:
	defb 03eh,004h,032h,07dh,0eah,0cdh,061h,0a5h,0ddh,036h,018h,001h,0c9h	; b9b3  >.2}..a..6...

; ======================================================================
; CODIGO 0xb9c0..0xb9d8  (24 bytes)
; ======================================================================


L_B9C0:
	call L_B847		;b9c0
	call L_B9C9		;b9c3
	jp L_B6B7		;b9c6
L_B9C9:
	call L_B604		;b9c9
	ret c			;b9cc
	ld a,(ix+017h)		;b9cd
	and 003h		;b9d0
	call z,L_B75C		;b9d2
	jp L_B789		;b9d5

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (13 bytes)
;   0xb9d8..0xb9e5  (13 bytes)
DATA_B9D8:
	defb 03eh,004h,032h,07dh,0eah,0cdh,061h,0a5h,0ddh,036h,018h,003h,0c9h	; b9d8  >.2}..a..6...

; ======================================================================
; CODIGO 0xb9e5..0xba02  (29 bytes)
; ======================================================================


L_B9E5:
	call L_B847		;b9e5
	call L_B9F0		;b9e8
	ld c,008h		;b9eb
	jp L_B6B9		;b9ed
L_B9F0:
	call L_B604		;b9f0
	ret c			;b9f3
	ld a,(ix+017h)		;b9f4
	and 003h		;b9f7
	jp z,L_B789		;b9f9
	ld hl,0b837h		;b9fc
	jp L_B7C4		;b9ff

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (13 bytes)
;   0xba02..0xba0f  (13 bytes)
DATA_BA02:
	defb 03eh,002h,032h,07dh,0eah,0cdh,061h,0a5h,0ddh,036h,018h,000h,0c9h	; ba02  >.2}..a..6...

; ======================================================================
; CODIGO 0xba0f..0xba2c  (29 bytes)
; ======================================================================


L_BA0F:
	call L_B847		;ba0f
	call L_BA18		;ba12
	jp L_B6B7		;ba15
L_BA18:
	call L_B604		;ba18
	ret c			;ba1b
	ld a,(ix+017h)		;ba1c
	and 00fh		;ba1f
	and 003h		;ba21
	jp z,L_B789		;ba23
	ld hl,0b83fh		;ba26
	jp L_B7C4		;ba29

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (13 bytes)
;   0xba2c..0xba39  (13 bytes)
DATA_BA2C:
	defb 03eh,005h,032h,07dh,0eah,0cdh,061h,0a5h,0ddh,036h,018h,002h,0c9h	; ba2c  >.2}..a..6...

; ======================================================================
; CODIGO 0xba39..0xba53  (26 bytes)
; ======================================================================


L_BA39:
	call L_B847		;ba39
	call L_BA44		;ba3c
	ld c,00ch		;ba3f
	jp L_B6B9		;ba41
L_BA44:
	call L_B604		;ba44
	ret c			;ba47
	ld a,(ix+017h)		;ba48
	and 003h		;ba4b
	call z,L_B75C		;ba4d
	jp L_B785		;ba50

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (43 bytes)
;   0xba53..0xba7e  (43 bytes)
DATA_BA53:
	defb 03eh,001h,032h,07dh,0eah,0cdh,074h,0a5h,0ddh,07eh,015h,0ddh,096h,006h,0c6h,008h	; ba53  >.2}..t..~......
	defb 0feh,010h,030h,009h,0ddh,036h,018h,002h,0ddh,036h,01fh,002h,0c9h,0ddh,07eh,000h	; ba63  ..0..6...6....~.
	defb 0e6h,0f0h,0f6h,001h,0ddh,077h,000h,0cdh,086h,0b9h,0c9h	; ba73  .....w.....

; ======================================================================
; CODIGO 0xba7e..0xba96  (24 bytes)
; ======================================================================


L_BA7E:
	call L_B847		;ba7e
	call L_BA87		;ba81
	jp L_B6B7		;ba84
L_BA87:
	call L_B604		;ba87
	ret c			;ba8a
	ld a,(ix+017h)		;ba8b
	and 003h		;ba8e
	call z,L_B75C		;ba90
	jp L_B789		;ba93

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (9 bytes)
;   0xba96..0xba9f  (9 bytes)
DATA_BA96:
	defb 03eh,001h,032h,07dh,0eah,0cdh,061h,0a5h,0c9h	; ba96  >.2}..a..

; ======================================================================
; CODIGO 0xba9f..0xbb0d  (110 bytes)
; ======================================================================


L_BA9F:
	ld a,(0e1c3h)		;ba9f
	xor (iy+009h)		;baa2
	rrca			;baa5
	ret c			;baa6
	ld e,0e8h		;baa7
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
	ld e,098h		;badc
	call 04af0h		;bade
	call L_B344		;bae1
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
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (72 bytes)
;   0xbba3..0xbbeb  (72 bytes)
DATA_BBA3:
	defb 098h,040h,000h,00fh,0a0h,040h,000h,00fh,098h,040h,000h,00fh,090h,008h,000h,00fh	; bba3  .@...@...@......
	defb 030h,048h,004h,008h,018h,030h,000h,00fh,018h,0c0h,000h,00fh,010h,010h,000h,00fh	; bbb3  0H...0..........
	defb 098h,040h,0a0h,040h,0a8h,040h,0b0h,040h,098h,040h,0a8h,040h,0b8h,040h,090h,008h	; bbc3  .@.@.@.@.@.@.@..
	defb 098h,008h,0a0h,008h,0a8h,008h,0b0h,008h,090h,088h,018h,030h,028h,030h,018h,0c0h	; bbd3  ...........0(0..
	defb 028h,0c0h,010h,010h,048h,010h,080h,010h	; bbe3  (...H...

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
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (63 bytes)
;   0xbdd5..0xbe14  (63 bytes)
DATA_BDD5:
	defb 058h,028h,05ch,04eh,088h,088h,0b5h,0dbh,0b6h,08eh,074h,0d1h,0b0h,051h,0b8h,062h	; bdd5  X(\N......t..Q.b
	defb 000h,0c0h,08fh,083h,0bah,093h,000h,0c0h,08dh,0c5h,0b7h,0adh,0dbh,0b6h,0c6h,083h	; bde5  ................
	defb 0bah,0d6h,02eh,0bah,0bdh,05eh,0bdh,0bdh,05eh,0bdh,0bdh,05eh,0bdh,0a2h,02eh,0bah	; bdf5  .....^..^..^....
	defb 0bdh,05eh,0bdh,097h,099h,0b1h,0a2h,02eh,0bah,0c3h,0a1h,0c2h,0a2h,02eh,0bah	; be05  .^.............

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
	add a,015h		;be5d
	djnz L_BE5D		;be5f
	ld l,a			;be61
	ld h,b			;be62
	add hl,hl			;be63
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
	call 0004dh		;be75   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;be78
	djnz L_BE75		;be79
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
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (374 bytes)
;   0xbe8a..0xc000  (374 bytes)
DATA_BE8A:
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
	defb 000h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bffa
