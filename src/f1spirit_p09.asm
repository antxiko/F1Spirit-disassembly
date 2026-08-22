; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 09 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS objetos_pista_08: objetos de la pista de la carrera 8 (F1 ROUND 4): 53
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57)
;   0xa000..0xa07e  (126 bytes)
DATA_objetos_pista_08:
	defb 096h	; a000
	defb 002h,0b9h,0d6h	; a001
	defb 002h,0c2h,006h	; a004
	defb 003h,0c1h,016h	; a007
	defb 003h,004h,026h	; a00a
	defb 003h,004h,036h	; a00d
	defb 003h,088h,046h	; a010
	defb 003h,0bah,076h	; a013
	defb 003h,0c2h,096h	; a016
	defb 003h,0c1h,0a5h	; a019
	defb 003h,004h,0a6h	; a01c
	defb 003h,088h,0b5h	; a01f
	defb 003h,004h,0b6h	; a022
	defb 003h,0b9h,0e6h	; a025
	defb 003h,0c1h,0f5h	; a028
	defb 003h,002h,0f6h	; a02b
	defb 003h,088h,005h	; a02e
	defb 004h,002h,006h	; a031
	defb 004h,0bah,066h	; a034
	defb 004h,0c1h,026h	; a037
	defb 005h,001h,036h	; a03a
	defb 005h,001h,046h	; a03d
	defb 005h,084h,056h	; a040
	defb 005h,0b7h,076h	; a043
	defb 005h,0c1h,085h	; a046
	defb 005h,004h,086h	; a049
	defb 005h,088h,095h	; a04c
	defb 005h,004h,096h	; a04f
	defb 005h,0b9h,0c6h	; a052
	defb 005h,0c1h,0d5h	; a055
	defb 005h,003h,0d6h	; a058
	defb 005h,084h,0e5h	; a05b
	defb 005h,003h,0e6h	; a05e
	defb 005h,0b5h,016h	; a061
	defb 006h,0c1h,025h	; a064
	defb 006h,006h,026h	; a067
	defb 006h,088h,035h	; a06a
	defb 006h,006h,036h	; a06d
	defb 006h,0bah,066h	; a070
	defb 006h,0c2h,0a6h	; a073
	defb 006h,0c2h,0c6h	; a076
	defb 006h,0c1h,040h	; a079
	defb 007h,0c7h	; a07c

; ----------------------------------------------------------------------
; DATOS objetos_pista_09: objetos de la pista de la carrera 9 (F1 ROUND 5): 50
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57)
;   0xa07e..0xa115  (151 bytes)
DATA_objetos_pista_09:
	defb 032h	; a07e
	defb 013h,000h,0c0h	; a07f
	defb 023h,000h,0c0h	; a082
	defb 0d6h,001h,002h	; a085
	defb 0e6h,001h,002h	; a088
	defb 0f6h,001h,088h	; a08b
	defb 006h,002h,0b8h	; a08e
	defb 056h,002h,0c2h	; a091
	defb 086h,002h,0c1h	; a094
	defb 096h,002h,003h	; a097
	defb 0a6h,002h,003h	; a09a
	defb 0b6h,002h,084h	; a09d
	defb 0c6h,002h,0b5h	; a0a0
	defb 0f6h,002h,0c1h	; a0a3
	defb 006h,003h,004h	; a0a6
	defb 015h,003h,004h	; a0a9
	defb 016h,003h,088h	; a0ac
	defb 026h,003h,0b9h	; a0af
	defb 066h,003h,0c1h	; a0b2
	defb 086h,003h,003h	; a0b5
	defb 095h,003h,003h	; a0b8
	defb 096h,003h,084h	; a0bb
	defb 0a6h,003h,0b5h	; a0be
	defb 006h,004h,0c2h	; a0c1
	defb 036h,004h,0c1h	; a0c4
	defb 056h,004h,003h	; a0c7
	defb 066h,004h,003h	; a0ca
	defb 076h,004h,084h	; a0cd
	defb 086h,004h,0b6h	; a0d0
	defb 0b6h,004h,0c1h	; a0d3
	defb 006h,005h,003h	; a0d6
	defb 015h,005h,003h	; a0d9
	defb 016h,005h,084h	; a0dc
	defb 026h,005h,0b6h	; a0df
	defb 066h,005h,0c2h	; a0e2
	defb 096h,005h,0c1h	; a0e5
	defb 0b6h,005h,006h	; a0e8
	defb 0c5h,005h,006h	; a0eb
	defb 0c6h,005h,088h	; a0ee
	defb 0d6h,005h,0b9h	; a0f1
	defb 016h,006h,0c2h	; a0f4
	defb 056h,006h,0c2h	; a0f7
	defb 086h,006h,0c2h	; a0fa
	defb 0c6h,006h,0c1h	; a0fd
	defb 016h,007h,004h	; a100
	defb 026h,007h,004h	; a103
	defb 036h,007h,088h	; a106
	defb 046h,007h,0b9h	; a109
	defb 0a6h,007h,0c1h	; a10c
	defb 010h,008h,0c7h	; a10f
	defb 070h,008h,0c6h	; a112

; ----------------------------------------------------------------------
; DATOS objetos_pista_10: objetos de la pista de la carrera 10 (F1 ROUND 6):
;   30 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa115..0xa170  (91 bytes)
DATA_objetos_pista_10:
	defb 01eh	; a115
	defb 012h,000h,0c0h	; a116
	defb 022h,000h,0c0h	; a119
	defb 0c0h,000h,0c7h	; a11c
	defb 000h,001h,0c6h	; a11f
	defb 076h,001h,006h	; a122
	defb 085h,001h,006h	; a125
	defb 086h,001h,088h	; a128
	defb 096h,001h,0b9h	; a12b
	defb 0b6h,001h,0c2h	; a12e
	defb 0e6h,001h,0c2h	; a131
	defb 006h,002h,0c1h	; a134
	defb 0e6h,004h,003h	; a137
	defb 0f5h,004h,003h	; a13a
	defb 0f6h,004h,084h	; a13d
	defb 006h,005h,0b6h	; a140
	defb 046h,005h,0c2h	; a143
	defb 086h,005h,0c1h	; a146
	defb 096h,005h,004h	; a149
	defb 0a5h,005h,004h	; a14c
	defb 0a6h,005h,088h	; a14f
	defb 0c6h,005h,0bbh	; a152
	defb 0e6h,005h,0c2h	; a155
	defb 005h,006h,0c1h	; a158
	defb 006h,006h,006h	; a15b
	defb 015h,006h,006h	; a15e
	defb 016h,006h,088h	; a161
	defb 026h,006h,0bah	; a164
	defb 066h,006h,0c2h	; a167
	defb 0b6h,006h,0c2h	; a16a
	defb 0d6h,006h,0c1h	; a16d

; ----------------------------------------------------------------------
; DATOS objetos_pista_11: objetos de la pista de la carrera 11 (F1 ROUND 7):
;   36 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa170..0xa1dd  (109 bytes)
DATA_objetos_pista_11:
	defb 024h	; a170
	defb 012h,000h,0c0h	; a171
	defb 022h,000h,0c0h	; a174
	defb 0a0h,000h,0c7h	; a177
	defb 0c0h,000h,0c6h	; a17a
	defb 0e6h,000h,004h	; a17d
	defb 0f5h,000h,004h	; a180
	defb 0f6h,000h,088h	; a183
	defb 006h,001h,0b8h	; a186
	defb 046h,001h,0c1h	; a189
	defb 0e6h,002h,003h	; a18c
	defb 0f5h,002h,003h	; a18f
	defb 0f6h,002h,084h	; a192
	defb 006h,003h,0b6h	; a195
	defb 056h,003h,0c2h	; a198
	defb 086h,003h,0c1h	; a19b
	defb 036h,004h,003h	; a19e
	defb 046h,004h,003h	; a1a1
	defb 056h,004h,084h	; a1a4
	defb 066h,004h,0b6h	; a1a7
	defb 0a6h,004h,0c2h	; a1aa
	defb 0d6h,004h,0c1h	; a1ad
	defb 036h,005h,004h	; a1b0
	defb 045h,005h,004h	; a1b3
	defb 046h,005h,088h	; a1b6
	defb 056h,005h,0b9h	; a1b9
	defb 0a6h,005h,0c1h	; a1bc
	defb 0a6h,006h,001h	; a1bf
	defb 0b6h,006h,001h	; a1c2
	defb 0c6h,006h,084h	; a1c5
	defb 0d6h,006h,0b7h	; a1c8
	defb 0f5h,006h,0c1h	; a1cb
	defb 0f6h,006h,004h	; a1ce
	defb 005h,007h,004h	; a1d1
	defb 006h,007h,088h	; a1d4
	defb 016h,007h,0b9h	; a1d7
	defb 056h,007h,0c1h	; a1da

; ----------------------------------------------------------------------
; DATOS objetos_pista_12: objetos de la pista de la carrera 12 (F1 ROUND 8):
;   48 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa1dd..0xa26e  (145 bytes)
DATA_objetos_pista_12:
	defb 030h	; a1dd
	defb 012h,000h,0c0h	; a1de
	defb 022h,000h,0c0h	; a1e1
	defb 086h,000h,004h	; a1e4
	defb 095h,000h,004h	; a1e7
	defb 096h,000h,088h	; a1ea
	defb 0a6h,000h,0b9h	; a1ed
	defb 0e6h,000h,0c1h	; a1f0
	defb 080h,001h,0c7h	; a1f3
	defb 0c0h,001h,0c6h	; a1f6
	defb 0e6h,003h,004h	; a1f9
	defb 0f5h,003h,004h	; a1fc
	defb 0f6h,003h,088h	; a1ff
	defb 006h,004h,0b9h	; a202
	defb 076h,004h,0c1h	; a205
	defb 086h,004h,004h	; a208
	defb 096h,004h,004h	; a20b
	defb 0a6h,004h,088h	; a20e
	defb 0b6h,004h,0bah	; a211
	defb 0d6h,004h,0c2h	; a214
	defb 0f5h,004h,0c1h	; a217
	defb 0f6h,004h,004h	; a21a
	defb 005h,005h,004h	; a21d
	defb 006h,005h,088h	; a220
	defb 016h,005h,0b9h	; a223
	defb 056h,005h,0c1h	; a226
	defb 086h,005h,004h	; a229
	defb 096h,005h,004h	; a22c
	defb 0a6h,005h,088h	; a22f
	defb 0b6h,005h,0bah	; a232
	defb 0e6h,005h,0c2h	; a235
	defb 006h,006h,0c1h	; a238
	defb 096h,006h,004h	; a23b
	defb 0a6h,006h,004h	; a23e
	defb 0b6h,006h,088h	; a241
	defb 0c6h,006h,0b9h	; a244
	defb 0f6h,006h,0c1h	; a247
	defb 026h,007h,006h	; a24a
	defb 036h,007h,006h	; a24d
	defb 046h,007h,088h	; a250
	defb 056h,007h,0bbh	; a253
	defb 096h,007h,0c2h	; a256
	defb 0d6h,007h,0c2h	; a259
	defb 016h,008h,0c1h	; a25c
	defb 036h,008h,004h	; a25f
	defb 046h,008h,004h	; a262
	defb 056h,008h,088h	; a265
	defb 066h,008h,0b9h	; a268
	defb 0c6h,008h,0c1h	; a26b

; ----------------------------------------------------------------------
; DATOS objetos_pista_13: objetos de la pista de la carrera 13 (F1 ROUND 9):
;   52 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa26e..0xa30b  (157 bytes)
DATA_objetos_pista_13:
	defb 034h	; a26e
	defb 012h,000h,0c0h	; a26f
	defb 022h,000h,0c0h	; a272
	defb 0c6h,001h,003h	; a275
	defb 0d6h,001h,003h	; a278
	defb 0e6h,001h,084h	; a27b
	defb 006h,002h,0b6h	; a27e
	defb 046h,002h,0c2h	; a281
	defb 086h,002h,0c1h	; a284
	defb 0a6h,002h,006h	; a287
	defb 0b5h,002h,006h	; a28a
	defb 0b6h,002h,088h	; a28d
	defb 0c6h,002h,0bah	; a290
	defb 026h,003h,0c2h	; a293
	defb 066h,003h,0c2h	; a296
	defb 0a6h,003h,0c1h	; a299
	defb 0e6h,003h,006h	; a29c
	defb 0f6h,003h,006h	; a29f
	defb 006h,004h,088h	; a2a2
	defb 016h,004h,0bah	; a2a5
	defb 046h,004h,0c2h	; a2a8
	defb 0a6h,004h,0c2h	; a2ab
	defb 0e6h,004h,0c1h	; a2ae
	defb 026h,005h,002h	; a2b1
	defb 035h,005h,002h	; a2b4
	defb 036h,005h,088h	; a2b7
	defb 046h,005h,0bbh	; a2ba
	defb 066h,005h,0c1h	; a2bd
	defb 086h,005h,003h	; a2c0
	defb 095h,005h,003h	; a2c3
	defb 096h,005h,084h	; a2c6
	defb 0a6h,005h,0b6h	; a2c9
	defb 0e6h,005h,0c2h	; a2cc
	defb 026h,006h,0c1h	; a2cf
	defb 056h,006h,003h	; a2d2
	defb 066h,006h,003h	; a2d5
	defb 076h,006h,084h	; a2d8
	defb 086h,006h,0b5h	; a2db
	defb 0b6h,006h,0c1h	; a2de
	defb 0e6h,006h,004h	; a2e1
	defb 0f6h,006h,004h	; a2e4
	defb 006h,007h,088h	; a2e7
	defb 016h,007h,0b9h	; a2ea
	defb 036h,007h,0c1h	; a2ed
	defb 046h,007h,006h	; a2f0
	defb 055h,007h,006h	; a2f3
	defb 056h,007h,088h	; a2f6
	defb 066h,007h,0bah	; a2f9
	defb 086h,007h,0c2h	; a2fc
	defb 0b6h,007h,0c2h	; a2ff
	defb 0e6h,007h,0c1h	; a302
	defb 080h,008h,0c7h	; a305
	defb 0c0h,008h,0c6h	; a308

; ----------------------------------------------------------------------
; DATOS objetos_pista_14: objetos de la pista de la carrera 14 (F1 ROUND 10):
;   35 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa30b..0xa375  (106 bytes)
DATA_objetos_pista_14:
	defb 023h	; a30b
	defb 012h,000h,0c0h	; a30c
	defb 022h,000h,0c0h	; a30f
	defb 026h,002h,004h	; a312
	defb 036h,002h,004h	; a315
	defb 046h,002h,088h	; a318
	defb 056h,002h,0bah	; a31b
	defb 096h,002h,0c2h	; a31e
	defb 0c5h,002h,0c1h	; a321
	defb 0c6h,002h,006h	; a324
	defb 0d5h,002h,006h	; a327
	defb 0d6h,002h,088h	; a32a
	defb 0f6h,002h,0bbh	; a32d
	defb 046h,003h,0c2h	; a330
	defb 086h,003h,0c2h	; a333
	defb 0c6h,003h,0c1h	; a336
	defb 0d6h,004h,003h	; a339
	defb 0e6h,004h,003h	; a33c
	defb 0f6h,004h,084h	; a33f
	defb 006h,005h,0b6h	; a342
	defb 066h,005h,0c2h	; a345
	defb 0a6h,005h,0c1h	; a348
	defb 0d6h,005h,004h	; a34b
	defb 0e6h,005h,004h	; a34e
	defb 0f6h,005h,088h	; a351
	defb 006h,006h,0bah	; a354
	defb 056h,006h,0c2h	; a357
	defb 096h,006h,0c1h	; a35a
	defb 0d6h,006h,003h	; a35d
	defb 0e6h,006h,003h	; a360
	defb 0f6h,006h,084h	; a363
	defb 006h,007h,0b6h	; a366
	defb 056h,007h,0c2h	; a369
	defb 0a6h,007h,0c1h	; a36c
	defb 050h,008h,0c7h	; a36f
	defb 090h,008h,0c6h	; a372

; ----------------------------------------------------------------------
; DATOS objetos_pista_15: objetos de la pista de la carrera 15 (F1 ROUND 11):
;   43 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa375..0xa3f7  (130 bytes)
DATA_objetos_pista_15:
	defb 02bh	; a375
	defb 012h,000h,0c0h	; a376
	defb 022h,000h,0c0h	; a379
	defb 0d6h,001h,001h	; a37c
	defb 0e6h,001h,001h	; a37f
	defb 0f6h,001h,084h	; a382
	defb 006h,002h,0b7h	; a385
	defb 025h,002h,0c1h	; a388
	defb 026h,002h,001h	; a38b
	defb 035h,002h,001h	; a38e
	defb 036h,002h,084h	; a391
	defb 046h,002h,0b7h	; a394
	defb 076h,002h,0c1h	; a397
	defb 086h,002h,003h	; a39a
	defb 095h,002h,003h	; a39d
	defb 096h,002h,084h	; a3a0
	defb 0a6h,002h,0b6h	; a3a3
	defb 0e6h,002h,0c2h	; a3a6
	defb 006h,003h,0c1h	; a3a9
	defb 036h,003h,004h	; a3ac
	defb 045h,003h,004h	; a3af
	defb 056h,003h,088h	; a3b2
	defb 066h,003h,0bah	; a3b5
	defb 0a6h,003h,0c2h	; a3b8
	defb 0e6h,003h,0c1h	; a3bb
	defb 0f6h,003h,004h	; a3be
	defb 005h,004h,004h	; a3c1
	defb 006h,004h,088h	; a3c4
	defb 026h,004h,0b9h	; a3c7
	defb 076h,004h,0c1h	; a3ca
	defb 0d6h,004h,003h	; a3cd
	defb 0e6h,004h,003h	; a3d0
	defb 0f6h,004h,084h	; a3d3
	defb 006h,005h,0b6h	; a3d6
	defb 046h,005h,0c2h	; a3d9
	defb 096h,005h,0c1h	; a3dc
	defb 016h,006h,003h	; a3df
	defb 025h,006h,003h	; a3e2
	defb 026h,006h,084h	; a3e5
	defb 046h,006h,0b6h	; a3e8
	defb 096h,006h,0c2h	; a3eb
	defb 0f6h,006h,0c1h	; a3ee
	defb 080h,007h,0c7h	; a3f1
	defb 0c0h,007h,0c6h	; a3f4

; ----------------------------------------------------------------------
; DATOS objetos_pista_16: objetos de la pista de la carrera 16 (F1 ROUND 12):
;   51 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa3f7..0xa491  (154 bytes)
DATA_objetos_pista_16:
	defb 033h	; a3f7
	defb 012h,000h,0c0h	; a3f8
	defb 022h,000h,0c0h	; a3fb
	defb 0d6h,001h,004h	; a3fe
	defb 0e6h,001h,004h	; a401
	defb 0f6h,001h,088h	; a404
	defb 016h,002h,0b9h	; a407
	defb 066h,002h,0c1h	; a40a
	defb 086h,002h,003h	; a40d
	defb 096h,002h,003h	; a410
	defb 0a6h,002h,084h	; a413
	defb 0b6h,002h,0b6h	; a416
	defb 0f6h,002h,0c2h	; a419
	defb 026h,003h,0c1h	; a41c
	defb 036h,003h,003h	; a41f
	defb 046h,003h,003h	; a422
	defb 056h,003h,084h	; a425
	defb 066h,003h,0b6h	; a428
	defb 096h,003h,0c2h	; a42b
	defb 0b5h,003h,0c1h	; a42e
	defb 0b6h,003h,004h	; a431
	defb 0c5h,003h,004h	; a434
	defb 0c6h,003h,088h	; a437
	defb 0d6h,003h,0bbh	; a43a
	defb 016h,004h,0c2h	; a43d
	defb 066h,004h,0c1h	; a440
	defb 0a6h,004h,004h	; a443
	defb 0b6h,004h,004h	; a446
	defb 0c6h,004h,088h	; a449
	defb 0e6h,004h,0bah	; a44c
	defb 036h,005h,0c2h	; a44f
	defb 075h,005h,0c1h	; a452
	defb 076h,005h,003h	; a455
	defb 085h,005h,003h	; a458
	defb 086h,005h,084h	; a45b
	defb 0a6h,005h,0b6h	; a45e
	defb 0f6h,005h,0c2h	; a461
	defb 036h,006h,0c1h	; a464
	defb 056h,006h,004h	; a467
	defb 066h,006h,004h	; a46a
	defb 076h,006h,088h	; a46d
	defb 096h,006h,0b9h	; a470
	defb 0c6h,006h,0c1h	; a473
	defb 0e6h,006h,006h	; a476
	defb 0f5h,006h,006h	; a479
	defb 0f6h,006h,088h	; a47c
	defb 016h,007h,0bbh	; a47f
	defb 056h,007h,0c2h	; a482
	defb 096h,007h,0c2h	; a485
	defb 0d6h,007h,0c1h	; a488
	defb 070h,008h,0c7h	; a48b
	defb 0b0h,008h,0c6h	; a48e

; ----------------------------------------------------------------------
; DATOS objetos_pista_17: objetos de la pista de la carrera 17 (F1 ROUND 13):
;   57 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa491..0xa53d  (172 bytes)
DATA_objetos_pista_17:
	defb 039h	; a491
	defb 012h,000h,0c0h	; a492
	defb 022h,000h,0c0h	; a495
	defb 0d6h,001h,003h	; a498
	defb 0e6h,001h,003h	; a49b
	defb 0f6h,001h,084h	; a49e
	defb 006h,002h,0b5h	; a4a1
	defb 035h,002h,0c1h	; a4a4
	defb 036h,002h,004h	; a4a7
	defb 046h,002h,004h	; a4aa
	defb 056h,002h,088h	; a4ad
	defb 086h,002h,0b9h	; a4b0
	defb 0d6h,002h,0c1h	; a4b3
	defb 0f6h,002h,003h	; a4b6
	defb 006h,003h,003h	; a4b9
	defb 016h,003h,084h	; a4bc
	defb 036h,003h,0b5h	; a4bf
	defb 095h,003h,0c1h	; a4c2
	defb 096h,003h,004h	; a4c5
	defb 0a6h,003h,004h	; a4c8
	defb 0b6h,003h,088h	; a4cb
	defb 0c6h,003h,0bah	; a4ce
	defb 036h,004h,0c1h	; a4d1
	defb 056h,004h,003h	; a4d4
	defb 066h,004h,003h	; a4d7
	defb 076h,004h,084h	; a4da
	defb 096h,004h,0b7h	; a4dd
	defb 0d6h,004h,0c2h	; a4e0
	defb 006h,005h,0c1h	; a4e3
	defb 036h,005h,003h	; a4e6
	defb 045h,005h,003h	; a4e9
	defb 046h,005h,084h	; a4ec
	defb 066h,005h,0b6h	; a4ef
	defb 0a6h,005h,0c1h	; a4f2
	defb 0c6h,005h,003h	; a4f5
	defb 0d5h,005h,003h	; a4f8
	defb 0d6h,005h,084h	; a4fb
	defb 0e6h,005h,0b5h	; a4fe
	defb 026h,006h,0c2h	; a501
	defb 066h,006h,0c1h	; a504
	defb 076h,006h,004h	; a507
	defb 086h,006h,004h	; a50a
	defb 096h,006h,088h	; a50d
	defb 0a6h,006h,0b9h	; a510
	defb 0e5h,006h,0c1h	; a513
	defb 0e6h,006h,004h	; a516
	defb 0f5h,006h,004h	; a519
	defb 0f6h,006h,088h	; a51c
	defb 016h,007h,0b9h	; a51f
	defb 056h,007h,0c1h	; a522
	defb 0f0h,007h,0c7h	; a525
	defb 030h,008h,0c6h	; a528
	defb 036h,008h,004h	; a52b
	defb 046h,008h,004h	; a52e
	defb 056h,008h,088h	; a531
	defb 076h,008h,0bah	; a534
	defb 0b6h,008h,0c2h	; a537
	defb 0d6h,008h,0c1h	; a53a

; ----------------------------------------------------------------------
; DATOS objetos_pista_18: objetos de la pista de la carrera 18 (F1 ROUND 14):
;   42 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa53d..0xa5bc  (127 bytes)
DATA_objetos_pista_18:
	defb 02ah	; a53d
	defb 012h,000h,0c0h	; a53e
	defb 022h,000h,0c0h	; a541
	defb 0c0h,000h,0c7h	; a544
	defb 000h,001h,0c6h	; a547
	defb 006h,003h,004h	; a54a
	defb 016h,003h,004h	; a54d
	defb 026h,003h,088h	; a550
	defb 036h,003h,0bah	; a553
	defb 076h,003h,0c2h	; a556
	defb 0a6h,003h,0c1h	; a559
	defb 0e6h,003h,003h	; a55c
	defb 0f5h,003h,003h	; a55f
	defb 0f6h,003h,084h	; a562
	defb 016h,004h,0b7h	; a565
	defb 066h,004h,0c2h	; a568
	defb 095h,004h,0c1h	; a56b
	defb 096h,004h,003h	; a56e
	defb 0a5h,004h,003h	; a571
	defb 0a6h,004h,084h	; a574
	defb 0b6h,004h,0b5h	; a577
	defb 0e6h,004h,0c2h	; a57a
	defb 0f6h,004h,005h	; a57d
	defb 006h,005h,005h	; a580
	defb 026h,005h,0c2h	; a583
	defb 046h,005h,0c2h	; a586
	defb 076h,005h,0c1h	; a589
	defb 086h,005h,084h	; a58c
	defb 096h,005h,0b4h	; a58f
	defb 0a6h,005h,003h	; a592
	defb 0b6h,005h,003h	; a595
	defb 0c6h,005h,0c2h	; a598
	defb 0d6h,005h,0c1h	; a59b
	defb 006h,006h,004h	; a59e
	defb 016h,006h,004h	; a5a1
	defb 026h,006h,088h	; a5a4
	defb 036h,006h,0b9h	; a5a7
	defb 096h,006h,0c1h	; a5aa
	defb 026h,007h,004h	; a5ad
	defb 036h,007h,004h	; a5b0
	defb 046h,007h,088h	; a5b3
	defb 066h,007h,0b9h	; a5b6
	defb 0b6h,007h,0c1h	; a5b9

; ----------------------------------------------------------------------
; DATOS objetos_pista_19: objetos de la pista de la carrera 19 (F1 ROUND 15):
;   49 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa5bc..0xa650  (148 bytes)
DATA_objetos_pista_19:
	defb 031h	; a5bc
	defb 012h,000h,0c0h	; a5bd
	defb 022h,000h,0c0h	; a5c0
	defb 0e6h,001h,004h	; a5c3
	defb 0f5h,001h,004h	; a5c6
	defb 0f6h,001h,088h	; a5c9
	defb 006h,002h,0b9h	; a5cc
	defb 036h,002h,0c1h	; a5cf
	defb 056h,002h,004h	; a5d2
	defb 0a6h,002h,004h	; a5d5
	defb 0b6h,002h,004h	; a5d8
	defb 0c6h,002h,088h	; a5db
	defb 0d6h,002h,0bbh	; a5de
	defb 005h,003h,004h	; a5e1
	defb 006h,003h,0c2h	; a5e4
	defb 016h,003h,004h	; a5e7
	defb 026h,003h,0c2h	; a5ea
	defb 036h,003h,003h	; a5ed
	defb 046h,003h,003h	; a5f0
	defb 066h,003h,0c2h	; a5f3
	defb 096h,003h,004h	; a5f6
	defb 0a6h,003h,004h	; a5f9
	defb 0c6h,003h,0c2h	; a5fc
	defb 016h,004h,0c1h	; a5ff
	defb 066h,004h,004h	; a602
	defb 075h,004h,004h	; a605
	defb 076h,004h,088h	; a608
	defb 096h,004h,0bah	; a60b
	defb 0d6h,004h,0c2h	; a60e
	defb 016h,005h,0c1h	; a611
	defb 026h,005h,004h	; a614
	defb 036h,005h,004h	; a617
	defb 046h,005h,088h	; a61a
	defb 056h,005h,0b8h	; a61d
	defb 096h,005h,0c2h	; a620
	defb 0e6h,005h,0c1h	; a623
	defb 0e6h,006h,003h	; a626
	defb 0f6h,006h,003h	; a629
	defb 006h,007h,088h	; a62c
	defb 016h,007h,0b8h	; a62f
	defb 055h,007h,0c1h	; a632
	defb 056h,007h,006h	; a635
	defb 066h,007h,006h	; a638
	defb 076h,007h,088h	; a63b
	defb 086h,007h,0bbh	; a63e
	defb 0a6h,007h,0c2h	; a641
	defb 0c6h,007h,0c2h	; a644
	defb 0e6h,007h,0c1h	; a647
	defb 0a0h,008h,0c7h	; a64a
	defb 0e0h,008h,0c6h	; a64d

; ----------------------------------------------------------------------
; DATOS objetos_pista_20: objetos de la pista de la carrera 20 (F1 ROUND 16):
;   47 registros de 3 bytes (palabra = posicion en la pista en los 12 bits
;   altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los
;   recorre 0x5E6C por (ix+0x57)
;   0xa650..0xa6de  (142 bytes)
DATA_objetos_pista_20:
	defb 02fh	; a650
	defb 010h,000h,0c6h	; a651
	defb 016h,000h,0c0h	; a654
	defb 026h,000h,0c0h	; a657
	defb 056h,000h,003h	; a65a
	defb 066h,000h,003h	; a65d
	defb 076h,000h,084h	; a660
	defb 086h,000h,0b6h	; a663
	defb 0b6h,000h,0c2h	; a666
	defb 0e6h,000h,0c1h	; a669
	defb 016h,001h,003h	; a66c
	defb 026h,001h,003h	; a66f
	defb 036h,001h,084h	; a672
	defb 046h,001h,0b6h	; a675
	defb 0b0h,001h,0c2h	; a678
	defb 0e5h,001h,0c1h	; a67b
	defb 0e6h,001h,003h	; a67e
	defb 0e7h,001h,084h	; a681
	defb 0f5h,001h,003h	; a684
	defb 0f6h,001h,0b5h	; a687
	defb 026h,002h,0c2h	; a68a
	defb 086h,002h,0c1h	; a68d
	defb 096h,002h,003h	; a690
	defb 0a6h,002h,003h	; a693
	defb 0b6h,002h,084h	; a696
	defb 0c6h,002h,0b5h	; a699
	defb 0f6h,002h,0c1h	; a69c
	defb 005h,003h,004h	; a69f
	defb 006h,003h,088h	; a6a2
	defb 015h,003h,004h	; a6a5
	defb 016h,003h,0b8h	; a6a8
	defb 046h,003h,0c1h	; a6ab
	defb 006h,004h,004h	; a6ae
	defb 016h,004h,004h	; a6b1
	defb 026h,004h,088h	; a6b4
	defb 036h,004h,0b8h	; a6b7
	defb 076h,004h,0c1h	; a6ba
	defb 0c6h,005h,003h	; a6bd
	defb 0d6h,005h,003h	; a6c0
	defb 0e6h,005h,084h	; a6c3
	defb 0f6h,005h,0b5h	; a6c6
	defb 030h,006h,0c2h	; a6c9
	defb 046h,006h,003h	; a6cc
	defb 056h,006h,003h	; a6cf
	defb 066h,006h,0c2h	; a6d2
	defb 0d6h,006h,0c2h	; a6d5
	defb 0f6h,006h,0c1h	; a6d8
	defb 080h,007h,0c7h	; a6db

; ----------------------------------------------------------------------
; DATOS tabla_textos: 148 punteros a los textos de abajo: la entrada n es la
;   MACRO 0x60+n que COPIA_TEXTO (p01 0x6943) expande dentro de otros textos;
;   p01 0x6950
;   0xa6de..0xa806  (296 bytes)
DATA_tabla_textos:
	defw 0a806h	; a6de  -> DATA_textos	--> "VALVE\n"
	defw 0a80dh	; a6e0	--> "TURBO\n"
	defw 0a814h	; a6e2	--> "SUPER"
	defw 0a81ah	; a6e4	--> "26"
	defw 0a81dh	; a6e6	--> "16VALVE\n"
	defw 0a821h	; a6e8	--> "SOHC\n"
	defw 0a824h	; a6ea	--> "DOHC\n"
	defw 0a827h	; a6ec	--> "V12 "
	defw 0a82bh	; a6ee	--> "V8  "
	defw 0a82fh	; a6f0	--> "PS\n"
	defw 0a833h	; a6f2	--> "KG"
	defw 0a836h	; a6f4	--> "4R  "
	defw 0a83ah	; a6f6	--> "DOHC-\nTURBO\n"
	defw 0a842h	; a6f8	--> "   540KG"
	defw 0a845h	; a6fa	--> "FRONT\n    DISK\nTYPE-"
	defw 0a850h	; a6fc	--> "REAR\n    "
	defw 0a858h	; a6fe	--> "DISK\n"
	defw 0a85eh	; a700	--> "DOHC\n16VALVE\n"
	defw 0a861h	; a702	--> "TWIN"
	defw 0a866h	; a704	--> "V8  3000\n"
	defw 0a86bh	; a706	--> "50"
	defw 0a86eh	; a708	--> "80"
	defw 0a871h	; a70a	--> "29"
	defw 0a874h	; a70c	--> "   560PS\n"
	defw 0a87ah	; a70e	--> "000"
	defw 0a87dh	; a710	--> "TYPE-"
	defw 0a880h	; a712	--> "SUPER-\nCHARGER\n\n"
	defw 0a883h	; a714	--> "=21"
	defw 0a887h	; a716	--> "\n\n"
	defw 0a88ah	; a718	--> "\n\n\n"
	defw 0a88dh	; a71a	--> "4- "
	defw 0a891h	; a71c	--> "V6  "
	defw 0a895h	; a71e	--> "TYPE"
	defw 0a89ah	; a720	--> "10"
	defw 0a89dh	; a722	--> "59"
	defw 0a8a0h	; a724	--> "DOHC\n\n"
	defw 0a8a3h	; a726	--> "4R  1998\n"
	defw 0a8aah	; a728	--> "   "
	defw 0a8adh	; a72a	--> "FRAME"
	defw 0a8b3h	; a72c	--> "00"
	defw 0a8b6h	; a72e	--> "OHC\n"
	defw 0a8bbh	; a730	--> "   540"
	defw 0a8c0h	; a732	--> "12"
	defw 0a8c3h	; a734	--> "15"
	defw 0a8c6h	; a736	--> "AUTO\nMATIC\n"
	defw 0a8d2h	; a738	--> "  "
	defw 0a8d5h	; a73a	--> "TUBE\n"
	defw 0a8dbh	; a73c	--> "SHOCK\n"
	defw 0a8e2h	; a73e	--> "TYPE\n\n"
	defw 0a8e5h	; a740	--> "-\nSETTING\n"
	defw 0a8f0h	; a742	--> "CARBON\nFIBER\n"
	defw 0a8feh	; a744	--> "4SPEED\n"
	defw 0a906h	; a746	--> "MANUAL\n\n"
	defw 0a90eh	; a748	--> "1- "
	defw 0a912h	; a74a	--> "2- "
	defw 0a916h	; a74c	--> "3- "
	defw 0a91ah	; a74e	--> "SUPER-\nCHARGER\n"
	defw 0a926h	; a750	--> "MA"
	defw 0a929h	; a752	--> "ER\n\n"
	defw 0a92dh	; a754	--> "    "
	defw 0a930h	; a756	--> "      "
	defw 0a933h	; a758	--> "        "
	defw 0a936h	; a75a	--> "         "
	defw 0a939h	; a75c	--> "          "
	defw 0a93ch	; a75e	--> "             "
	defw 0a93fh	; a760	--> "SUB "
	defw 0a944h	; a762	--> "---"
	defw 0a948h	; a764	--> "F1 GRAMPLIX"
	defw 0a948h	; a766	--> "F1 GRAMPLIX"
	defw 0a948h	; a768	--> "F1 GRAMPLIX"
	defw 0a948h	; a76a	--> "F1 GRAMPLIX"
	defw 0a948h	; a76c	--> "F1 GRAMPLIX"
	defw 0a948h	; a76e	--> "F1 GRAMPLIX"
	defw 0a948h	; a770	--> "F1 GRAMPLIX"
	defw 0a948h	; a772	--> "F1 GRAMPLIX"
	defw 0a954h	; a774	--> "STOCK"
	defw 0a95ah	; a776	--> "ENDURANCE"
	defw 0a964h	; a778	--> "RALLY"
	defw 0a96ah	; a77a	--> "F3"
	defw 0a96dh	; a77c	--> "F3000"
	defw 0a973h	; a77e	--> "QUALIFY"
	defw 0a97bh	; a780	--> "LUCK"
	defw 0a980h	; a782	--> "CHANCE "
	defw 0a988h	; a784	--> "BOY "
	defw 0a98dh	; a786	--> "GOD "
	defw 0a992h	; a788	--> "RACE "
	defw 0a998h	; a78a	--> "SPEED "
	defw 0a99fh	; a78c	--> "FIGHT"
	defw 0a9a5h	; a78e	--> "HAVE "
	defw 0a9abh	; a790	--> "MIND "
	defw 0a9b1h	; a792	--> "MY "
	defw 0a9b5h	; a794	--> "YOU"
	defw 0a9b9h	; a796	--> "THE "
	defw 0a9beh	; a798	--> "OH "
	defw 0a9c2h	; a79a	--> "TRY "
	defw 0a9c7h	; a79c	--> "GOT "
	defw 0a9cch	; a79e	--> "BUT "
	defw 0a9d1h	; a7a0	--> "MAY "
	defw 0a9d6h	; a7a2	--> "HARD"
	defw 0a9dbh	; a7a4	--> "GO "
	defw 0a9dfh	; a7a6	--> "DRIV"
	defw 0a9e4h	; a7a8	--> "ARE "
	defw 0a9e9h	; a7aa	--> "NEVER "
	defw 0a9f0h	; a7ac	--> "WIN "
	defw 0a9f5h	; a7ae	--> "NEXT "
	defw 0a9fbh	; a7b0	--> "AGAIN "
	defw 0aa02h	; a7b2	--> "TO "
	defw 0aa06h	; a7b4	--> "GREAT"
	defw 0aa0ch	; a7b6	--> "BEST "
	defw 0aa12h	; a7b8	--> "NICE "
	defw 0aa18h	; a7ba	--> "GAME "
	defw 0aa1eh	; a7bc	--> "COMMAND"
	defw 0aa26h	; a7be	--> "MUSIC "
	defw 0aa2dh	; a7c0	--> "MODE "
	defw 0aa33h	; a7c2	--> "PLAY"
	defw 0aa38h	; a7c4	--> "BATTLE"
	defw 0aa3fh	; a7c6	--> "F1"
	defw 0aa42h	; a7c8	--> "CAR"
	defw 0aa46h	; a7ca	--> "SELECT"
	defw 0aa4dh	; a7cc	--> "PERSONAL"
	defw 0aa56h	; a7ce	--> "DESIGN"
	defw 0aa5dh	; a7d0	--> "ORIGINAL"
	defw 0aa66h	; a7d2	--> "ENGINE"
	defw 0aa6dh	; a7d4	--> "BODY"
	defw 0aa72h	; a7d6	--> "BRAKE"
	defw 0aa78h	; a7d8	--> "SUSPENSION"
	defw 0aa83h	; a7da	--> "MISSION"
	defw 0aa8bh	; a7dc	--> " POINT"
	defw 0aa92h	; a7de	--> "OK"
	defw 0aa95h	; a7e0	--> "NO"
	defw 0aa98h	; a7e2	--> "CONGRATULATIONS"
	defw 0aaa8h	; a7e4	--> "      1P\n"
	defw 0aaadh	; a7e6	--> "      2P\n\n"
	defw 0aab2h	; a7e8	--> "V6  1500\nDOHC\nSUPER-\nCHARGER\nLOW-\nCOMPRESS\n"
	defw 0aac0h	; a7ea	--> "V6  1490\nDOHC\nSUPER-\nCHARGER\nWIDE-\nTORUQUE\n"
	defw 0aad0h	; a7ec	--> "V8  1200\nDOHC-\nTURBO\n\nEASY-\nCONTROL\n"
	defw 0aae6h	; a7ee	--> "V6  1500\nDOHC-\nTURBO\n\n2BAND-\nTORUQUE\n"
	defw 0aaf6h	; a7f0	--> "V8  1500\nTURBO\nSUPER-\nCHARGER\nHIGH-\nCOMPRESS\n"
	defw 0ab14h	; a7f2	--> "V6  1400\nDOHC\nSUPER-\nCHARGER\nPEEKY-\nPOWER\n"
	defw 0aab7h	; a7f4	--> "DOHC\nSUPER-\nCHARGER\nLOW-\nCOMPRESS\n"
	defw 0aac6h	; a7f6	--> "DOHC\nSUPER-\nCHARGER\nWIDE-\nTORUQUE\n"
	defw 0aad5h	; a7f8	--> "DOHC-\nTURBO\n\nEASY-\nCONTROL\n"
	defw 0aaebh	; a7fa	--> "DOHC-\nTURBO\n\n2BAND-\nTORUQUE\n"
	defw 0aafbh	; a7fc	--> "TURBO\nSUPER-\nCHARGER\nHIGH-\nCOMPRESS\n"
	defw 0ab19h	; a7fe	--> "DOHC\nSUPER-\nCHARGER\nPEEKY-\nPOWER\n"
	defw 0ab37h	; a800	--> "COMPRESS\n"
	defw 0ab41h	; a802	--> "TORUQUE\n"
	defw 0ab4ah	; a804	--> "KONAMI"

; ----------------------------------------------------------------------
; DATOS textos: 236 textos terminados en 0x5F (ASCII en 0x20-0x5E, macros
;   0x60-0xFF de la tabla 0xA6DE, tiles y posiciones por debajo de 0x20):
;   fichas de los coches, menus, RESULT, THE MEMORIAL OF FORMULA-1...
;   0xa806..0xb024  (2078 bytes)
DATA_textos:
	defb 056h,041h,04ch,056h,045h,001h,05fh,054h,055h,052h,042h,04fh,001h,05fh,053h,055h	; a806  VALVE._TURBO._SU
	defb 050h,045h,052h,05fh,032h,036h,05fh,031h,036h,060h,05fh,053h,088h,05fh,044h,088h	; a816  PER_26_16`_S._D.
	defb 05fh,056h,08ah,020h,05fh,056h,038h,08dh,05fh,050h,053h,001h,05fh,04bh,047h,05fh	; a826  _V. _V8._PS._KG_
	defb 034h,052h,08dh,05fh,044h,04fh,048h,043h,040h,001h,061h,05fh,089h,06ah,05fh,046h	; a836  4R._DOHC@.a_.j_F
	defb 052h,04fh,04eh,054h,001h,085h,020h,070h,079h,05fh,052h,045h,041h,052h,001h,085h	; a846  RONT.. py_REAR..
	defb 020h,05fh,044h,049h,053h,04bh,001h,05fh,066h,064h,05fh,054h,057h,049h,04eh,05fh	; a856   _DISK._fd_TWIN_
	defb 068h,033h,078h,001h,05fh,035h,030h,05fh,038h,030h,05fh,032h,039h,05fh,085h,035h	; a866  h3x._50_80_29_.5
	defb 036h,030h,069h,05fh,030h,087h,05fh,080h,040h,05fh,098h,001h,05fh,03dh,032h,031h	; a876  60i_0._.@_.._=21
	defb 05fh,001h,001h,05fh,07ch,001h,05fh,034h,040h,020h,05fh,056h,036h,08dh,05fh,054h	; a886  _.._|._4@ _V6._T
	defb 059h,050h,045h,05fh,031h,030h,05fh,035h,039h,05fh,066h,001h,05fh,06bh,031h,039h	; a896  YPE_10_59_f._k19
	defb 039h,038h,001h,05fh,08dh,020h,05fh,046h,052h,041h,04dh,045h,05fh,030h,030h,05fh	; a8a6  98._. _FRAME_00_
	defb 04fh,048h,043h,001h,05fh,085h,035h,034h,030h,05fh,031h,032h,05fh,031h,035h,05fh	; a8b6  OHC._.540_12_15_
	defb 041h,055h,054h,04fh,001h,04dh,041h,054h,049h,043h,001h,05fh,020h,020h,05fh,054h	; a8c6  AUTO.MATIC._  _T
	defb 055h,042h,045h,001h,05fh,053h,048h,04fh,043h,04bh,001h,05fh,080h,07ch,05fh,040h	; a8d6  UBE._SHOCK._.|_@
	defb 001h,053h,045h,054h,054h,049h,04eh,047h,001h,05fh,043h,041h,052h,042h,04fh,04eh	; a8e6  .SETTING._CARBON
	defb 001h,046h,049h,042h,045h,052h,001h,05fh,034h,053h,050h,045h,045h,044h,001h,05fh	; a8f6  .FIBER._4SPEED._
	defb 04dh,041h,04eh,055h,041h,04ch,07ch,05fh,031h,040h,020h,05fh,032h,040h,020h,05fh	; a906  MANUAL|_1@ _2@ _
	defb 033h,040h,020h,05fh,062h,040h,001h,043h,048h,041h,052h,047h,045h,052h,001h,05fh	; a916  3@ _b@.CHARGER._
	defb 04dh,041h,05fh,045h,052h,07ch,05fh,085h,020h,05fh,09bh,08dh,05fh,09ch,08dh,05fh	; a926  MA_ER|_. _.._.._
	defb 09dh,020h,05fh,09eh,020h,05fh,09fh,085h,05fh,053h,055h,042h,020h,05fh,040h,040h	; a936  . _. _.._SUB _@@
	defb 040h,05fh,046h,031h,020h,047h,052h,041h,04dh,050h,04ch,049h,058h,05fh,053h,054h	; a946  @_F1 GRAMPLIX_ST
	defb 04fh,043h,04bh,05fh,045h,04eh,044h,055h,052h,041h,04eh,043h,045h,05fh,052h,041h	; a956  OCK_ENDURANCE_RA
	defb 04ch,04ch,059h,05fh,046h,033h,05fh,046h,033h,030h,030h,030h,05fh,051h,055h,041h	; a966  LLY_F3_F3000_QUA
	defb 04ch,049h,046h,059h,05fh,04ch,055h,043h,04bh,05fh,043h,048h,041h,04eh,043h,045h	; a976  LIFY_LUCK_CHANCE
	defb 020h,05fh,042h,04fh,059h,020h,05fh,047h,04fh,044h,020h,05fh,052h,041h,043h,045h	; a986   _BOY _GOD _RACE
	defb 020h,05fh,053h,050h,045h,045h,044h,020h,05fh,046h,049h,047h,048h,054h,05fh,048h	; a996   _SPEED _FIGHT_H
	defb 041h,056h,045h,020h,05fh,04dh,049h,04eh,044h,020h,05fh,04dh,059h,020h,05fh,059h	; a9a6  AVE _MIND _MY _Y
	defb 04fh,055h,05fh,054h,048h,045h,020h,05fh,04fh,048h,020h,05fh,054h,052h,059h,020h	; a9b6  OU_THE _OH _TRY
	defb 05fh,047h,04fh,054h,020h,05fh,042h,055h,054h,020h,05fh,04dh,041h,059h,020h,05fh	; a9c6  _GOT _BUT _MAY _
	defb 048h,041h,052h,044h,05fh,047h,04fh,020h,05fh,044h,052h,049h,056h,05fh,041h,052h	; a9d6  HARD_GO _DRIV_AR
	defb 045h,020h,05fh,04eh,045h,056h,045h,052h,020h,05fh,057h,049h,04eh,020h,05fh,04eh	; a9e6  E _NEVER _WIN _N
	defb 045h,058h,054h,020h,05fh,041h,047h,041h,049h,04eh,020h,05fh,054h,04fh,020h,05fh	; a9f6  EXT _AGAIN _TO _
	defb 047h,052h,045h,041h,054h,05fh,042h,045h,053h,054h,020h,05fh,04eh,049h,043h,045h	; aa06  GREAT_BEST _NICE
	defb 020h,05fh,047h,041h,04dh,045h,020h,05fh,043h,04fh,04dh,04dh,041h,04eh,044h,05fh	; aa16   _GAME _COMMAND_
	defb 04dh,055h,053h,049h,043h,020h,05fh,04dh,04fh,044h,045h,020h,05fh,050h,04ch,041h	; aa26  MUSIC _MODE _PLA
	defb 059h,05fh,042h,041h,054h,054h,04ch,045h,05fh,046h,031h,05fh,043h,041h,052h,05fh	; aa36  Y_BATTLE_F1_CAR_
	defb 053h,045h,04ch,045h,043h,054h,05fh,050h,045h,052h,053h,04fh,04eh,041h,04ch,05fh	; aa46  SELECT_PERSONAL_
	defb 044h,045h,053h,049h,047h,04eh,05fh,04fh,052h,049h,047h,049h,04eh,041h,04ch,05fh	; aa56  DESIGN_ORIGINAL_
	defb 045h,04eh,047h,049h,04eh,045h,05fh,042h,04fh,044h,059h,05fh,042h,052h,041h,04bh	; aa66  ENGINE_BODY_BRAK
	defb 045h,05fh,053h,055h,053h,050h,045h,04eh,053h,049h,04fh,04eh,05fh,04dh,049h,053h	; aa76  E_SUSPENSION_MIS
	defb 053h,049h,04fh,04eh,05fh,020h,050h,04fh,049h,04eh,054h,05fh,04fh,04bh,05fh,04eh	; aa86  SION_ POINT_OK_N
	defb 04fh,05fh,043h,04fh,04eh,047h,052h,041h,054h,055h,04ch,041h,054h,049h,04fh,04eh	; aa96  O_CONGRATULATION
	defb 053h,05fh,09ch,031h,050h,001h,05fh,09ch,032h,050h,07ch,05fh,07fh,031h,035h,087h	; aaa6  S_.1P._.2P|_.15.
	defb 001h,066h,098h,04ch,04fh,057h,040h,001h,0f1h,05fh,07fh,031h,034h,039h,030h,001h	; aab6  .f.LOW@.._.1490.
	defb 066h,098h,057h,049h,044h,045h,040h,001h,0f2h,05fh,068h,031h,032h,087h,001h,06ch	; aac6  f.WIDE@.._h12..l
	defb 001h,045h,041h,053h,059h,040h,001h,043h,04fh,04eh,054h,052h,04fh,04ch,001h,05fh	; aad6  .EASY@.CONTROL._
	defb 07fh,031h,035h,087h,001h,06ch,001h,032h,042h,041h,04eh,044h,040h,001h,0f2h,05fh	; aae6  .15..l.2BAND@.._
	defb 068h,031h,035h,087h,001h,054h,055h,052h,042h,04fh,001h,062h,040h,001h,043h,048h	; aaf6  h15..TURBO.b@.CH
	defb 041h,052h,047h,045h,052h,001h,048h,049h,047h,048h,040h,001h,0f1h,05fh,07fh,031h	; ab06  ARGER.HIGH@.._.1
	defb 034h,087h,001h,044h,04fh,048h,043h,001h,062h,040h,001h,043h,048h,041h,052h,047h	; ab16  4..DOHC.b@.CHARG
	defb 045h,052h,001h,050h,045h,045h,04bh,059h,040h,001h,050h,04fh,057h,045h,052h,001h	; ab26  ER.PEEKY@.POWER.
	defb 05fh,043h,04fh,04dh,050h,052h,045h,053h,053h,001h,05fh,054h,04fh,052h,055h,051h	; ab36  _COMPRESS._TORUQ
	defb 055h,045h,001h,05fh,04bh,04fh,04eh,041h,04dh,049h,05fh	; ab46  UE._KONAMI_

; ----------------------------------------------------------------------
; ab51 = "(20)(10)GAME (2)(21)(10)COMMAND"
; ab59 = "(19)(10)TRY AGAIN "
; ab5e = "(19)(10)1PLAYER (2)(21)(10)2PLAYER (2)(23)(10)BATTLE MODE "
; ab74 = "(18)(2)STOCK RACE (2)(19)(2)RALLY(2)(20)(2)F3    RACE "
; ab87 = "(21)(2)F3000 RACE (2)(22)(2)ENDURANCE RACE "
; ab93 = "(18)(18)F1 RACE SELECT(2)(19)(19)ROUND 1-(2)(22)(22)ROUND"
; abad = "\n(3)CAR SELECT(2)(3)(8)1 READY MADE(2)(5)(8)2 ORIGINAL DESIGN"
; abca = "\n(3)READY MADE SELECT"
; abd9 = "\n(3)ORIGINAL CAR DESIGN MODE (2)(5)(8)ENGINE SELECT"
; abe9 = "(5)(8)BODY SELECT"
; abef = "(5)(8)BRAKE SELECT"
; abf5 = "(5)(8)SUSPENSION SELECT"
; abfb = "(5)(8)MISSION SELECT"
; ac01 = "(3)(5)PLAYER"
; ac07 = "(3)(26)OK(2)(5)(26)NO"
; ac0f = "BEST POINT\n      1P\n      2P\n\nTOTAL POINT      1P\n      2P\n\n"
; ac20 = "(2)(4)1 MUSIC MODE(2)(9)(4)2 SCC BALANCE(2)(16)(4)3 SELECT MAIN" (*)
; ac4f = "(4)(8)OIKOSHI" (*)
; ac59 = "(4)(8)SPIN" (*)
; ac60 = "(4)(8)BRAKE" (*)
; ac64 = "(4)(8)ABNORMAL" (*)
; ac6f = "(4)(8)TEKI OUT" (*)
; ac7a = "V8  3000\nDOHC\nAUTO\nMATIC\n\n   865PS\n   850KG"
; ac8b = "V12 5993\nSOHC\n24VALVE\n\n\n   780PS\n   700KG"
; ac9e = "V6  2960\nDOHC\nTWIN\nTURBO\n\n   900PS\n   756KG"
; acb5 = "V6  2000\nDOHC-\nTURBO\nAUTO\nMATIC\n   560PS\n  1020KG"
; acc2 = "V6  2996\nDOHC\nSUPER-\nCHARGER\n\n   480PS\n   985KG"
; acd3 = "V8  5000\nSOHC\nTURBO\nSUPER-\nCHARGER\n   580PS\n  1000KG"
; ace3 = "V8  2900\nDOHC-\nTURBO\nAUTO\nMATIC\n   595PS\n  1500KG"
; acf3 = "V12 2800\nDOHC\n\n\n\n   560PS\n  1200KG"
; ad01 = "V8  3000\nDOHC\n16VALVE\nTURBO\n\n   680PS\n  1015KG"
; ad11 = "V6  1500\nDOHC-\nTURBO\nAUTO\nMATIC\n  1300PS\n   540KG"
; ad1e = "V8  1400\nDOHC-\nTURBO\n16VALVE\n\n  1060PS\n   540KG"
; ad2f = "V6  1500\nDOHC-\nTURBO\n\n\n  1200PS\n   540KG"
; ad3c = "V8  3000\nDOHC\n16VALVE\nAUTO\nMATIC\n   450PS\n   540KG"
; ad45 = "V8  3000\nDOHC\n16VALVE\n\n\n   465PS\n   540KG"
; ad4f = "V8  3000\nDOHC\n\n\n\n   480PS\n   540KG"
; ad58 = "4R  1998\nDOHC\n16VALVE\nAUTO\nMATIC\n   180PS\n   460KG"
; ad65 = "4R  1998\nDOHC\n16VALVE\n\n\n   165PS\n   450KG"
; ad72 = "4R  2000\nDOHC\n16VALVE\n\n\n   170PS\n   455KG"
; ad83 = "V6  1500\nDOHC\nSUPER-\nCHARGER\nLOW-\nCOMPRESS\n   580PS\n"
; ad8a = "V6  1490\nDOHC\nSUPER-\nCHARGER\nWIDE-\nTORUQUE\n   600PS\n"
; ad90 = "V8  1200\nDOHC-\nTURBO\n\nEASY-\nCONTROL\n   700PS\n"
; ad96 = "V6  1500\nDOHC-\nTURBO\n\n2BAND-\nTORUQUE\n   680PS\n"
; ad9d = "V8  1500\nTURBO\nSUPER-\nCHARGER\nHIGH-\nCOMPRESS\n   800PS\n"
; ada3 = "V6  1400\nDOHC\nSUPER-\nCHARGER\nPEEKY-\nPOWER\n   720PS\n"
; adaa = "V6  2000\nDOHC\nSUPER-\nCHARGER\nLOW-\nCOMPRESS\n   780PS\n"
; adb4 = "V6  2000\nDOHC\nSUPER-\nCHARGER\nLOW-\nCOMPRESS\n   175PS\n"
; adbf = "V6  1800\nDOHC\nSUPER-\nCHARGER\nWIDE-\nTORUQUE\n   165PS\n"
; adcb = "V6  2800\nDOHC\nSUPER-\nCHARGER\nWIDE-\nTORUQUE\n   870PS\n"
; add7 = "V8  2000\nDOHC-\nTURBO\n\nEASY-\nCONTROL\n   175PS\n"
; ade2 = "V8  3200\nDOHC-\nTURBO\n\nEASY-\nCONTROL\n   900PS\n"
; aded = "V6  2000\nDOHC-\nTURBO\n\n2BAND-\nTORUQUE\n   180PS\n"
; adf7 = "V6  3000\nDOHC-\nTURBO\n\n2BAND-\nTORUQUE\n   880PS\n"
; ae01 = "V8  2000\nTURBO\nSUPER-\nCHARGER\nHIGH-\nCOMPRESS\n   190PS\n"
; ae0d = "V8  3200\nTURBO\nSUPER-\nCHARGER\nHIGH-\nCOMPRESS\n   990PS\n"
; ae19 = "V6  2000\nDOHC\nSUPER-\nCHARGER\nPEEKY-\nPOWER\n   185PS\n"
; ae25 = "V6  2400\nDOHC\nSUPER-\nCHARGER\nPEEKY-\nPOWER\n   920PS\n"
; ae31 = "V6  1500\nDOHC\nSUPER-\nCHARGER\nLOW-\nCOMPRESS\n   400PS\n"
; ae37 = "V6  1490\nDOHC\nSUPER-\nCHARGER\nWIDE-\nTORUQUE\n   450PS\n"
; ae3d = "V8  1200\nDOHC-\nTURBO\n\nEASY-\nCONTROL\n   470PS\n"
; ae44 = "V6  1500\nDOHC-\nTURBO\n\n2BAND-\nTORUQUE\n   480PS\n"
; ae4b = "V8  1500\nTURBO\nSUPER-\nCHARGER\nHIGH-\nCOMPRESS\n   498PS\n"
; ae52 = "V6  1400\nDOHC\nSUPER-\nCHARGER\nPEEKY-\nPOWER\n   487PS\n"
; ae59 = "V6  1500\nDOHC\nSUPER-\nCHARGER\nLOW-\nCOMPRESS\n  1180PS\n"
; ae60 = "V6  1490\nDOHC\nSUPER-\nCHARGER\nWIDE-\nTORUQUE\n  1100PS\n"
; ae67 = "V8  1200\nDOHC-\nTURBO\n\nEASY-\nCONTROL\n  1200PS\n"
; ae6d = "V6  1500\nDOHC-\nTURBO\n\n2BAND-\nTORUQUE\n  1500PS\n"
; ae74 = "V8  1500\nTURBO\nSUPER-\nCHARGER\nHIGH-\nCOMPRESS\n  1300PS\n"
; ae7b = "V6  1400\nDOHC\nSUPER-\nCHARGER\nPEEKY-\nPOWER\n  1030PS\n"
; ae83 = "STRONG-\nBODY\n\nCARBON\nFIBER\nFRAME"
; ae94 = "BALANCED-SETTING\n\nCARBON\nFIBER\nFRAME"
; aea9 = "LIGHT-\nWEIGHT\n\nCARBON\nFIBER\nFRAME"
; aebb = "4SPEED\nAUTO\nMATIC\n\nNEW TYPE\n\n"
; aec4 = "4SPEED\nMANUAL\n\n1- 13=26\n2- 18=26\n3- 24=25\n4- 27=21"
; aede = "4SPEED\nMANUAL\nHI-GEARD\n1- 14=29\n2- 22=29\n3- 23=24\n4- 26=21"
; af06 = "MONOTUBE\nOILSHOCK\nTYPE\n\nHARD-\nSETTING\n"
; af16 = "TWINTUBE\nADJUSTAB\nLE TYPE\n\nMEDIUM-\nSETTING\n"
; af2d = "TWINTUBE\nGASSHOCK\nTYPE\n\nSOFT-\nSETTING\n"
; af3a = "FRONT\n    DISK\nTYPE-A\nREAR\n    DISK\nTYPE-A"
; af42 = "FRONT\n    DISK\nTYPE-B\nREAR\n    DRUM"
; af4b = "FRONT\n    DISK\nTYPE-B\nREAR\n    DISK\nTYPE-B"
; af53 = "          ---STAFF---" (*)
; af5c = "             F1 GRAMPLIX    F1 GRAMPLIX" (*)
; af61 = "         F1 GRAMPLIXF1 GRAMPLIX         ULTRAMAN ADACHI" (*)
; af74 = "         SUB F1 GRAMPLIX      MASAF1 GRAMPLIX-MAI- OZAWA" (*)
; af87 = "        GRAPHIC F1 GRAMPLIX    F1 GRAMPLIX        F1 GRAMPLIX MAKITANI" (*)
; af9e = "          SOUND F1 GRAMPLIX        KAZUF1 GRAMPLIXUEHARA" (*)
; afb3 = "             END" (*)
; afb8 = "             END" (*)
; afbd = "             END" (*)
; afc2 = "             END" (*)
; afc7 = "             END" (*)
; afcc = "CONGRATULATIONS  " (*)
; afcf = "THE(30)MEMORIAL(30)OF\n(30)FORMULA-1"
; afea = "(11)(8)LUCKY" (*)
; afef = "(11)(8)UNLUCKY" (*)
; aff6 = "(16)(10):KONAMI 1987"
; b000 = "(20)(9)PUSH SPACE KEY"
; b011 = "(20)(10)  PLAY START   "
; b01e = "(15)(15)FIN" (*)
; (*) = no references
; ----------------------------------------------------------------------
	defb 014h,00ah,0ceh,002h,015h,00ah,0cfh,05fh,013h,00ah,0beh,0c9h,05fh,013h,00ah,031h	; ab51  ......._...._..1
	defb 0d2h,045h,052h,020h,002h,015h,00ah,032h,0d2h,045h,052h,020h,002h,017h,00ah,0d3h	; ab61  .ER ...2.ER ....
	defb 020h,0d1h,05fh,012h,002h,0abh,020h,0b5h,002h,013h,002h,0adh,002h,014h,002h,0aeh	; ab71   ._... .........
	defb 020h,020h,020h,020h,0b5h,05fh,015h,002h,0afh,020h,0b5h,002h,016h,002h,0ach,020h	; ab81      ._... .....
	defb 0b5h,05fh,012h,012h,0d4h,020h,0b5h,0d6h,002h,013h,013h,052h,04fh,055h,04eh,044h	; ab91  ._... .....ROUND
	defb 020h,031h,040h,002h,016h,016h,052h,04fh,055h,04eh,044h,05fh,001h,003h,0d5h,020h	; aba1   1@...ROUND_...
	defb 0d6h,002h,003h,008h,031h,020h,052h,045h,041h,044h,059h,020h,04dh,041h,044h,045h	; abb1  ....1 READY MADE
	defb 002h,005h,008h,032h,020h,0d9h,020h,0d8h,05fh,001h,003h,052h,045h,041h,044h,059h	; abc1  ...2 . ._..READY
	defb 020h,04dh,041h,044h,045h,020h,0d6h,05fh,001h,003h,0d9h,020h,0d5h,020h,0d8h,020h	; abd1   MADE ._... . .
	defb 0d1h,002h,005h,008h,0dah,020h,0d6h,05fh,005h,008h,0dbh,020h,0d6h,05fh,005h,008h	; abe1  ..... ._... ._..
	defb 0dch,020h,0d6h,05fh,005h,008h,0ddh,020h,0d6h,05fh,005h,008h,0deh,020h,0d6h,05fh	; abf1  . ._... ._... ._
	defb 003h,005h,0d2h,045h,052h,05fh,003h,01ah,0e0h,002h,005h,01ah,0e1h,05fh,042h,045h	; ac01  ...ER_......._BE
	defb 053h,054h,0dfh,001h,0e3h,0e4h,054h,04fh,054h,041h,04ch,0dfh,0e3h,0e4h,05fh,002h	; ac11  ST....TOTAL..._.
	defb 004h,031h,020h,04dh,055h,053h,049h,043h,020h,04dh,04fh,044h,045h,002h,009h,004h	; ac21  .1 MUSIC MODE...
	defb 032h,020h,053h,043h,043h,020h,042h,041h,04ch,041h,04eh,043h,045h,002h,010h,004h	; ac31  2 SCC BALANCE...
	defb 033h,020h,053h,045h,04ch,045h,043h,054h,020h,04dh,041h,049h,04eh,05fh,004h,008h	; ac41  3 SELECT MAIN_..
	defb 04fh,049h,04bh,04fh,053h,048h,049h,05fh,004h,008h,053h,050h,049h,04eh,05fh,004h	; ac51  OIKOSHI_..SPIN_.
	defb 008h,0dch,05fh,004h,008h,041h,042h,04eh,04fh,052h,04dh,041h,04ch,05fh,004h,008h	; ac61  .._..ABNORMAL_..
	defb 054h,045h,04bh,049h,020h,04fh,055h,054h,05fh,068h,033h,078h,001h,066h,08ch,001h	; ac71  TEKI OUT_h3x.f..
	defb 085h,038h,036h,035h,069h,085h,038h,074h,06ah,05fh,067h,082h,039h,033h,001h,065h	; ac81  .865i.8tj_g.93.e
	defb 032h,034h,060h,07ch,085h,037h,075h,069h,085h,037h,087h,06ah,05fh,07fh,076h,036h	; ac91  24`|.7ui.7.j_.v6
	defb 030h,001h,066h,054h,057h,049h,04eh,001h,061h,001h,085h,039h,087h,069h,085h,037h	; aca1  0.fTWIN.a..9.i.7
	defb 035h,036h,06ah,05fh,07fh,032h,078h,001h,06ch,08ch,077h,08dh,081h,032h,030h,06ah	; acb1  56j_.2x.l.w..20j
	defb 05fh,07fh,076h,039h,036h,001h,066h,07ah,085h,034h,075h,069h,085h,039h,038h,035h	; acc1  _.v96.fz.4ui.985
	defb 06ah,05fh,068h,035h,078h,001h,065h,061h,098h,085h,035h,075h,069h,08dh,081h,087h	; acd1  j_h5x.ea..5ui...
	defb 06ah,05fh,068h,032h,039h,087h,001h,06ch,08ch,085h,082h,035h,069h,08dh,08bh,087h	; ace1  j_h29..l...5i...
	defb 06ah,05fh,067h,032h,038h,030h,030h,001h,083h,07ch,077h,08dh,08ah,087h,06ah,05fh	; acf1  j_g2800..|w...j_
	defb 068h,033h,078h,001h,071h,061h,001h,085h,036h,075h,069h,08dh,081h,08bh,06ah,05fh	; ad01  h3x.qa..6ui...j_
	defb 07fh,08bh,087h,001h,06ch,08ch,08dh,031h,033h,087h,069h,06dh,05fh,068h,031h,034h	; ad11  ....l..13.im_h14
	defb 087h,001h,06ch,064h,001h,020h,020h,031h,030h,036h,030h,069h,06dh,05fh,07fh,031h	; ad21  ..ld.  1060im_.1
	defb 035h,087h,001h,06ch,07ch,08dh,08ah,087h,069h,06dh,05fh,073h,071h,08ch,085h,034h	; ad31  5..l|...im_sq..4
	defb 074h,069h,06dh,05fh,073h,071h,07ch,085h,034h,036h,035h,069h,06dh,05fh,073h,066h	; ad41  tim_sq|.465im_sf
	defb 07dh,085h,034h,075h,069h,06dh,05fh,084h,071h,08ch,085h,031h,075h,069h,085h,034h	; ad51  }.4uim_.q..1ui.4
	defb 036h,030h,06ah,05fh,084h,071h,07ch,085h,031h,036h,035h,069h,085h,034h,074h,06ah	; ad61  60j_.q|.165i.4tj
	defb 05fh,06bh,032h,078h,001h,071h,07ch,085h,031h,037h,030h,069h,085h,034h,035h,035h	; ad71  _k2x.q|.170i.455
	defb 06ah,05fh,0e5h,085h,035h,038h,030h,069h,05fh,0e6h,085h,036h,087h,069h,05fh,0e7h	; ad81  j_..580i_..6.i_.
	defb 085h,037h,087h,069h,05fh,0e8h,085h,036h,038h,030h,069h,05fh,0e9h,085h,038h,087h	; ad91  .7.i_..680i_..8.
	defb 069h,05fh,0eah,085h,037h,032h,030h,069h,05fh,07fh,032h,078h,001h,0ebh,085h,037h	; ada1  i_..720i_.2x...7
	defb 075h,069h,05fh,07fh,032h,078h,001h,0ebh,085h,031h,037h,035h,069h,05fh,07fh,031h	; adb1  ui_.2x...175i_.1
	defb 038h,087h,001h,0ech,085h,031h,036h,035h,069h,05fh,07fh,032h,038h,087h,001h,0ech	; adc1  8....165i_.28...
	defb 085h,038h,037h,030h,069h,05fh,068h,032h,078h,001h,0edh,085h,031h,037h,035h,069h	; add1  .870i_h2x...175i
	defb 05fh,068h,033h,032h,087h,001h,0edh,085h,039h,087h,069h,05fh,07fh,032h,078h,001h	; ade1  _h32....9.i_.2x.
	defb 0eeh,085h,031h,075h,069h,05fh,07fh,033h,078h,001h,0eeh,085h,038h,075h,069h,05fh	; adf1  ..1ui_.3x...8ui_
	defb 068h,032h,030h,087h,001h,0efh,085h,031h,039h,030h,069h,05fh,068h,033h,032h,087h	; ae01  h20....190i_h32.
	defb 001h,0efh,085h,039h,039h,030h,069h,05fh,07fh,032h,030h,087h,001h,0f0h,085h,031h	; ae11  ...990i_.20....1
	defb 038h,035h,069h,05fh,07fh,032h,034h,087h,001h,0f0h,085h,039h,032h,030h,069h,05fh	; ae21  85i_.24....920i_
	defb 0e5h,085h,034h,087h,069h,05fh,0e6h,085h,034h,074h,069h,05fh,0e7h,085h,034h,037h	; ae31  ..4.i_..4ti_..47
	defb 030h,069h,05fh,0e8h,085h,034h,038h,030h,069h,05fh,0e9h,085h,034h,039h,038h,069h	; ae41  0i_..480i_..498i
	defb 05fh,0eah,085h,034h,038h,037h,069h,05fh,0e5h,08dh,031h,031h,075h,069h,05fh,0e6h	; ae51  _..487i_..11ui_.
	defb 08dh,031h,031h,087h,069h,05fh,0e7h,08dh,08ah,087h,069h,05fh,0e8h,08dh,031h,035h	; ae61  .11.i_....i_..15
	defb 087h,069h,05fh,0e9h,08dh,031h,033h,087h,069h,05fh,0eah,08dh,031h,030h,033h,030h	; ae71  .i_..13.i_..1030
	defb 069h,05fh,053h,054h,052h,04fh,04eh,047h,040h,001h,042h,04fh,044h,059h,001h,001h	; ae81  i_STRONG@.BODY..
	defb 092h,086h,05fh,042h,041h,04ch,041h,04eh,043h,045h,044h,040h,053h,045h,054h,054h	; ae91  .._BALANCED@SETT
	defb 049h,04eh,047h,001h,001h,092h,086h,05fh,04ch,049h,047h,048h,054h,040h,001h,057h	; aea1  ING...._LIGHT@.W
	defb 045h,049h,047h,048h,054h,001h,001h,092h,086h,05fh,093h,08ch,001h,04eh,045h,057h	; aeb1  EIGHT...._...NEW
	defb 020h,090h,05fh,093h,094h,095h,031h,033h,03dh,063h,001h,096h,031h,038h,03dh,063h	; aec1   ._...13=c..18=c
	defb 001h,097h,032h,034h,03dh,032h,035h,001h,07eh,032h,037h,07bh,05fh,093h,04dh,041h	; aed1  ..24=25.~27{_.MA
	defb 04eh,055h,041h,04ch,001h,048h,049h,040h,047h,045h,041h,052h,044h,001h,095h,031h	; aee1  NUAL.HI@GEARD..1
	defb 034h,03dh,076h,001h,096h,032h,032h,03dh,076h,001h,097h,032h,033h,03dh,032h,034h	; aef1  4=v..22=v..23=24
	defb 001h,07eh,063h,07bh,05fh,04dh,04fh,04eh,04fh,08eh,04fh,049h,04ch,08fh,090h,048h	; af01  .~c{_MONO.OIL..H
	defb 041h,052h,044h,091h,05fh,072h,08eh,041h,044h,04ah,055h,053h,054h,041h,042h,001h	; af11  ARD._r.ADJUSTAB.
	defb 04ch,045h,020h,090h,04dh,045h,044h,049h,055h,04dh,091h,05fh,072h,08eh,047h,041h	; af21  LE .MEDIUM._r.GA
	defb 053h,08fh,090h,053h,04fh,046h,054h,091h,05fh,06eh,041h,001h,06fh,070h,079h,041h	; af31  S..SOFT._nA.opyA
	defb 05fh,06eh,042h,001h,06fh,044h,052h,055h,04dh,05fh,06eh,042h,001h,06fh,070h,079h	; af41  _nB.oDRUM_nB.opy
	defb 042h,05fh,09fh,0a2h,053h,054h,041h,046h,046h,0a2h,05fh,0a0h,0a4h,09bh,0a9h,05fh	; af51  B_..STAFF._...._
	defb 09eh,0a5h,0a7h,09eh,055h,04ch,054h,052h,041h,099h,04eh,020h,041h,044h,041h,043h	; af61  ....ULTRA.N ADAC
	defb 048h,049h,05fh,09eh,0a1h,0a7h,09ch,099h,053h,041h,0a3h,040h,099h,049h,040h,020h	; af71  HI_.....SA.@.I@
	defb 04fh,05ah,041h,057h,041h,05fh,09dh,047h,052h,041h,050h,048h,049h,043h,020h,0a6h	; af81  OZAWA_.GRAPHIC .
	defb 09bh,0a9h,09dh,0a8h,020h,099h,04bh,049h,054h,041h,04eh,049h,05fh,09fh,053h,04fh	; af91  .... .KITANI_.SO
	defb 055h,04eh,044h,020h,0a4h,09dh,04bh,041h,05ah,055h,0a3h,055h,045h,048h,041h,052h	; afa1  UND ..KAZU.UEHAR
	defb 041h,05fh,0a0h,045h,04eh,044h,05fh,0a0h,045h,04eh,044h,05fh,0a0h,045h,04eh,044h	; afb1  A_.END_.END_.END
	defb 05fh,0a0h,045h,04eh,044h,05fh,0a0h,045h,04eh,044h,05fh,0e2h,08dh,05fh,054h,048h	; afc1  _.END_.END_.._TH
	defb 045h,01eh,04dh,045h,04dh,04fh,052h,049h,041h,04ch,01eh,04fh,046h,001h,01eh,046h	; afd1  E.MEMORIAL.OF..F
	defb 04fh,052h,04dh,055h,04ch,041h,040h,031h,05fh,00bh,008h,0b1h,059h,05fh,00bh,008h	; afe1  ORMULA@1_...Y_..
	defb 055h,04eh,0b1h,059h,05fh,010h,00ah,03ah,0f3h,020h,031h,039h,038h,037h,05fh,014h	; aff1  UN.Y_..:. 1987_.
	defb 009h,050h,055h,053h,048h,020h,053h,050h,041h,043h,045h,020h,04bh,045h,059h,05fh	; b001  .PUSH SPACE KEY_
	defb 014h,00ah,020h,020h,0d2h,020h,053h,054h,041h,052h,054h,085h,05fh,00fh,00fh,046h	; b011  ..  . START._..F
	defb 049h,04eh,05fh	; b021

; ----------------------------------------------------------------------
; DATOS ficha_rle_b024: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb024..0xb039  (21 bytes)
DATA_ficha_rle_b024:
	defb 0f0h,059h,0e8h,040h,0e8h,071h,0e8h,069h,009h,023h,02fh,02ch,02fh,032h,048h,049h	; b024  .Y.@.q.i.#/,/2HI
	defb 049h,000h,0efh,04ah,000h	; b034

; ----------------------------------------------------------------------
; DATOS ficha_rle_b039: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb039..0xb04e  (21 bytes)
DATA_ficha_rle_b039:
	defb 0f0h,092h,0e8h,079h,0e8h,0aah,0e8h,0a2h,009h,023h,02fh,02ch,02fh,032h,081h,082h	; b039  ...y.....#/,/2..
	defb 082h,000h,0efh,083h,000h	; b049

; ----------------------------------------------------------------------
; DATOS ficha_rle_b04e: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb04e..0xb063  (21 bytes)
DATA_ficha_rle_b04e:
	defb 0f0h,0cbh,0e8h,0b2h,0e8h,0e3h,0e8h,0dbh,009h,023h,02fh,02ch,02fh,032h,0bah,0bbh	; b04e  .........#/,/2..
	defb 0bbh,000h,0efh,0bch,000h	; b05e

; ----------------------------------------------------------------------
; DATOS ficha_rle_b063: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb063..0xb082  (31 bytes)
DATA_ficha_rle_b063:
	defb 0e3h,059h,002h,000h,000h,0ebh,05ch,0e8h,040h,0e8h,06dh,0e3h,067h,002h,000h,000h	; b063  .Y....\.@.m.g...
	defb 0e3h,06ah,009h,023h,02fh,02ch,02fh,032h,048h,049h,049h,000h,0efh,04ah,000h	; b073  .j.#/,/2HII..J.

; ----------------------------------------------------------------------
; DATOS ficha_rle_b082: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb082..0xb0a1  (31 bytes)
DATA_ficha_rle_b082:
	defb 0e3h,08eh,002h,000h,000h,0ebh,091h,0e8h,075h,0e8h,0a2h,0e3h,09ch,002h,000h,000h	; b082  ........u.......
	defb 0e3h,09fh,009h,023h,02fh,02ch,02fh,032h,07dh,07eh,07eh,000h,0efh,07fh,000h	; b092  ...#/,/2}~~....

; ----------------------------------------------------------------------
; DATOS ficha_rle_b0a1: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb0a1..0xb0c0  (31 bytes)
DATA_ficha_rle_b0a1:
	defb 0e3h,0c3h,002h,000h,000h,0ebh,0c6h,0e8h,0aah,0e8h,0d7h,0e3h,0d1h,002h,000h,000h	; b0a1  ................
	defb 0e3h,0d4h,009h,023h,02fh,02ch,02fh,032h,0b2h,0b3h,0b3h,000h,0efh,0b4h,000h	; b0b1  ...#/,/2.......

; ----------------------------------------------------------------------
; DATOS ficha_rle_b0c0: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb0c0..0xb0d8  (24 bytes)
DATA_ficha_rle_b0c0:
	defb 0f0h,07eh,0e8h,096h,0e8h,08eh,088h,000h,00ah,023h,02fh,02ch,02fh,032h,06fh,070h	; b0c0  .~.......#/,/2op
	defb 070h,000h,000h,0edh,071h,001h,000h,000h	; b0d0  p...q...

; ----------------------------------------------------------------------
; DATOS ficha_rle_b0d8: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb0d8..0xb0f0  (24 bytes)
DATA_ficha_rle_b0d8:
	defb 0f0h,0adh,0e8h,0c5h,0e8h,0bdh,088h,000h,00ah,023h,02fh,02ch,02fh,032h,09eh,09fh	; b0d8  .........#/,/2..
	defb 09fh,000h,000h,0edh,0a0h,001h,000h,000h	; b0e8  ........

; ----------------------------------------------------------------------
; DATOS ficha_rle_b0f0: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb0f0..0xb108  (24 bytes)
DATA_ficha_rle_b0f0:
	defb 0f0h,04fh,0e8h,067h,0e8h,05fh,088h,000h,00ah,023h,02fh,02ch,02fh,032h,040h,041h	; b0f0  .O.g._...#/,/2@A
	defb 041h,000h,000h,0edh,042h,001h,000h,000h	; b100  A...B...

; ----------------------------------------------------------------------
; DATOS ficha_rle_b108: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb108..0xb11e  (22 bytes)
DATA_ficha_rle_b108:
	defb 0f0h,051h,0e8h,069h,0e8h,061h,008h,023h,02fh,02ch,02fh,032h,040h,041h,041h,088h	; b108  .Q.i.a.#/,/2@AA.
	defb 000h,0efh,042h,001h,000h,000h	; b118

; ----------------------------------------------------------------------
; DATOS ficha_rle_b11e: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb11e..0xb139  (27 bytes)
DATA_ficha_rle_b11e:
	defb 0efh,085h,001h,073h,0e7h,09ch,001h,073h,0e8h,094h,008h,023h,02fh,02ch,02fh,032h	; b11e  ...s...s...#/,/2
	defb 071h,072h,072h,086h,000h,0f0h,074h,002h,084h,000h,000h	; b12e  qrr...t....

; ----------------------------------------------------------------------
; DATOS ficha_rle_b139: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb139..0xb151  (24 bytes)
DATA_ficha_rle_b139:
	defb 0efh,0b6h,001h,0a3h,0e7h,0cdh,001h,0a3h,0e8h,0c5h,008h,023h,02fh,02ch,02fh,032h	; b139  ...........#/,/2
	defb 0a4h,0a5h,0a5h,088h,000h,0f0h,0a6h,000h	; b149  ........

; ----------------------------------------------------------------------
; DATOS ficha_rle_b151: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb151..0xb177  (38 bytes)
DATA_ficha_rle_b151:
	defb 001h,000h,0e7h,055h,001h,000h,0e7h,05ch,001h,000h,0e7h,06ah,001h,000h,0e7h,063h	; b151  ...U...\...j...c
	defb 008h,023h,02fh,02ch,02fh,032h,040h,041h,041h,083h,000h,0e5h,042h,001h,000h,0e7h	; b161  .#/,/2@AA...B...
	defb 047h,001h,000h,0e7h,04eh,000h	; b171

; ----------------------------------------------------------------------
; DATOS ficha_rle_b177: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb177..0xb196  (31 bytes)
DATA_ficha_rle_b177:
	defb 0efh,087h,001h,086h,0e7h,09eh,001h,086h,0e8h,096h,008h,023h,02fh,02ch,02fh,032h	; b177  ...........#/,/2
	defb 071h,072h,072h,083h,000h,004h,073h,074h,000h,000h,0f0h,075h,001h,085h,000h	; b187  qrr...st...u...

; ----------------------------------------------------------------------
; DATOS ficha_rle_b196: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb196..0xb1b4  (30 bytes)
DATA_ficha_rle_b196:
	defb 0eeh,0beh,002h,0bch,0bdh,0e6h,0d4h,002h,0bch,0bdh,0e8h,0cch,00ah,023h,02fh,02ch	; b196  .............#/,
	defb 02fh,032h,0a5h,0a6h,0a6h,000h,000h,0e5h,0a7h,001h,000h,0f0h,0ach,000h	; b1a6  /2............

; ----------------------------------------------------------------------
; DATOS ficha_rle_b1b4: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb1b4..0xb1d3  (31 bytes)
DATA_ficha_rle_b1b4:
	defb 0eeh,057h,002h,055h,056h,0e6h,06dh,002h,055h,056h,0e8h,065h,008h,023h,02fh,02ch	; b1b4  .W.UV.m.UV.e.#/,
	defb 02fh,032h,040h,041h,041h,083h,000h,0e3h,042h,002h,000h,000h,0f0h,045h,000h	; b1c4  /2@AA...B....E.

; ----------------------------------------------------------------------
; DATOS ficha_rle_b1d3: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb1d3..0xb1f8  (37 bytes)
DATA_ficha_rle_b1d3:
	defb 0eeh,088h,002h,086h,087h,0e6h,09eh,002h,086h,087h,0e8h,096h,008h,023h,02fh,02ch	; b1d3  .............#/,
	defb 02fh,032h,073h,074h,074h,083h,000h,0e3h,075h,002h,000h,000h,0e6h,078h,001h,074h	; b1e3  /2stt...u....x.t
	defb 0e5h,07eh,0e4h,082h,000h	; b1f3

; ----------------------------------------------------------------------
; DATOS ficha_rle_b1f8: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   0/2
;   0xb1f8..0xb217  (31 bytes)
DATA_ficha_rle_b1f8:
	defb 0efh,0bah,001h,0b9h,0e7h,0d1h,001h,0b9h,0e8h,0c9h,008h,023h,02fh,02ch,02fh,032h	; b1f8  ...........#/,/2
	defb 0a4h,0a5h,0a5h,083h,000h,004h,0a6h,0a7h,000h,000h,0f0h,0a8h,001h,0b8h,000h	; b208  ...............

; ----------------------------------------------------------------------
; DATOS ficha_rle_b217: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 16 filas, 128 bytes al descomprimir; lo apunta sin
;   llamador visto
;   0xb217..0xb266  (79 bytes)
DATA_ficha_rle_b217:
	defb 08ah,001h,006h,012h,016h,013h,002h,018h,01ah,089h,001h,002h,025h,014h,084h,002h	; b217  ............%...
	defb 001h,003h,089h,001h,007h,026h,015h,017h,019h,004h,002h,002h,088h,001h,008h,027h	; b227  .....&.........'
	defb 020h,005h,01eh,028h,006h,002h,002h,088h,001h,001h,029h,0e5h,007h,002h,002h,002h	; b237   ..(......).....
	defb 088h,001h,008h,02ah,01bh,00ch,00dh,002h,002h,00eh,00fh,088h,001h,004h,02bh,01ch	; b247  ...*..........+.
	defb 002h,002h,0e3h,00eh,001h,02ch,089h,001h,003h,01dh,011h,01fh,0e4h,021h,000h	; b257  .....,.......!.

; ----------------------------------------------------------------------
; DATOS ficha_rle_b266: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 16 filas, 128 bytes al descomprimir; lo apunta sin
;   llamador visto
;   0xb266..0xb2e3  (125 bytes)
DATA_ficha_rle_b266:
	defb 01eh,051h,051h,053h,052h,052h,05bh,050h,050h,060h,094h,06ch,050h,051h,051h,050h	; b266  .QQSRR[PP`.lPQQP
	defb 050h,051h,051h,054h,052h,052h,05fh,050h,050h,064h,095h,06dh,065h,051h,051h,084h	; b276  PQQTRR_PPd.meQQ.
	defb 050h,006h,05ch,05dh,055h,057h,051h,06fh,0e3h,073h,00dh,06eh,050h,050h,051h,051h	; b286  P.\]UWQo.s.nPPQQ
	defb 050h,050h,051h,05ch,05ah,059h,05eh,070h,0e3h,076h,003h,071h,050h,050h,084h,051h	; b296  PPQ\ZY^p.v.qPP.Q
	defb 006h,050h,050h,058h,056h,08dh,08eh,0e3h,079h,00ah,050h,051h,051h,050h,050h,051h	; b2a6  .PPXV...y.PQQPPQ
	defb 051h,050h,093h,08ch,0e3h,08fh,0e4h,07ch,002h,051h,051h,084h,050h,016h,061h,062h	; b2b6  QP.....|.QQ.P.ab
	defb 066h,085h,067h,08bh,081h,092h,072h,084h,083h,080h,051h,051h,050h,050h,063h,068h	; b2c6  f.g...r...QQPPch
	defb 069h,068h,06ah,082h,0e3h,086h,005h,06bh,089h,08ah,051h,051h,000h	; b2d6  ihj....k..QQ.

; ----------------------------------------------------------------------
; DATOS ficha_rle_b2e3: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 16 filas, 128 bytes al descomprimir; lo apunta sin
;   llamador visto
;   0xb2e3..0xb360  (125 bytes)
DATA_ficha_rle_b2e3:
	defb 01eh,096h,096h,098h,097h,097h,0a0h,050h,050h,0a5h,0d9h,0b1h,050h,096h,096h,050h	; b2e3  .......PP...P..P
	defb 050h,096h,096h,099h,097h,097h,0a4h,050h,050h,0a9h,0dah,0b2h,0aah,096h,096h,084h	; b2f3  P......PP.......
	defb 050h,006h,0a1h,0a2h,09ah,09ch,096h,0b4h,0e3h,0b8h,00dh,0b3h,050h,050h,096h,096h	; b303  P...........PP..
	defb 050h,050h,096h,0a1h,09fh,09eh,0a3h,0b5h,0e3h,0bbh,003h,0b6h,050h,050h,084h,096h	; b313  PP..........PP..
	defb 006h,050h,050h,09dh,09bh,0d2h,0d3h,0e3h,0beh,00ah,050h,096h,096h,050h,050h,096h	; b323  .PP.......P..PP.
	defb 096h,050h,0d8h,0d1h,0e3h,0d4h,0e4h,0c1h,002h,096h,096h,084h,050h,016h,0a6h,0a7h	; b333  .P..........P...
	defb 0abh,0cah,0ach,0d0h,0c6h,0d7h,0b7h,0c9h,0c8h,0c5h,096h,096h,050h,050h,0a8h,0adh	; b343  ............PP..
	defb 0aeh,0adh,0afh,0c7h,0e3h,0cbh,005h,0b0h,0ceh,0cfh,096h,096h,000h	; b353  .............

; ----------------------------------------------------------------------
; DATOS ficha_rle_b360: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 16 filas, 128 bytes al descomprimir; lo apunta sin
;   llamador visto
;   0xb360..0xb3bf  (95 bytes)
DATA_ficha_rle_b360:
	defb 087h,039h,013h,02dh,051h,051h,030h,040h,036h,051h,051h,033h,03ah,03ah,03fh,03fh	; b360  .9.-QQ0@6QQ3::??
	defb 03bh,03fh,03fh,02eh,051h,031h,083h,03fh,00dh,037h,051h,034h,052h,052h,03ch,03ch	; b370  ;??.Q1.?.7Q4RR<<
	defb 052h,03ch,03dh,02fh,051h,032h,083h,03eh,003h,038h,051h,035h,089h,051h,005h,042h	; b380  R<=/Q2.>.8Q5.Q.B
	defb 051h,047h,051h,04dh,08ah,051h,006h,043h,051h,048h,051h,051h,04eh,088h,051h,001h	; b390  QGQM.Q.CQHQQN.Q.
	defb 044h,083h,051h,004h,049h,051h,051h,04fh,08bh,051h,001h,04ah,087h,051h,004h,046h	; b3a0  D.Q.IQQO.Q.J.Q.F
	defb 051h,051h,045h,083h,051h,002h,04bh,04ch,083h,051h,003h,050h,051h,051h,000h	; b3b0  QQE.Q.KL.Q.PQQ.

; ----------------------------------------------------------------------
; DATOS ficha_rle_b3bf: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 16 filas, 128 bytes al descomprimir; lo apunta sin
;   llamador visto
;   0xb3bf..0xb42a  (107 bytes)
DATA_ficha_rle_b3bf:
	defb 086h,096h,004h,097h,0adh,0aeh,098h,089h,096h,009h,099h,09ah,096h,09bh,0afh,0b0h	; b3bf  ................
	defb 09ch,0ach,0c4h,086h,096h,00bh,09dh,0b1h,0b2h,09eh,0c9h,0b3h,0c5h,0d0h,0b4h,0b5h	; b3cf  ................
	defb 09fh,085h,096h,00bh,0a0h,0b6h,0b7h,0c6h,0cah,0d6h,0d7h,0d1h,0b8h,0b9h,0a1h,085h	; b3df  ................
	defb 096h,00ah,0a2h,0bah,0bbh,0d9h,0cch,0cbh,0a3h,0a4h,0c8h,0d3h,086h,096h,00bh,0d8h	; b3ef  ................
	defb 0dah,0bch,0abh,0c1h,0ceh,0a5h,0d2h,0d4h,0d5h,0a6h,084h,096h,00ch,0a7h,0c0h,0c7h	; b3ff  ................
	defb 0bdh,0dbh,0cfh,0c2h,0a8h,0c0h,0c7h,0bdh,0dbh,084h,096h,00ch,0a9h,0dch,0c3h,0beh	; b40f  ................
	defb 0bfh,0cdh,0ddh,0aah,0dch,0c3h,0beh,0bfh,083h,096h,000h	; b41f  ...........

; ----------------------------------------------------------------------
; DATOS ficha_rle_b42a: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   1
;   0xb42a..0xb45c  (50 bytes)
DATA_ficha_rle_b42a:
	defb 003h,000h,040h,041h,084h,077h,001h,078h,0e3h,042h,004h,07bh,045h,045h,07ch,0e4h	; b42a  ..@A.w.x.B.{EE|.
	defb 046h,005h,07bh,045h,045h,07ch,046h,0e3h,04ah,084h,079h,002h,07ah,000h,0e5h,04dh	; b43a  F.{EE|F.J.y.z..M
	defb 083h,000h,0e7h,052h,002h,000h,000h,0e5h,059h,003h,04eh,000h,000h,0e5h,05eh,001h	; b44a  ...R....Y.N...^.
	defb 000h,000h	; b45a

; ----------------------------------------------------------------------
; DATOS ficha_rle_b45c: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   1
;   0xb45c..0xb486  (42 bytes)
DATA_ficha_rle_b45c:
	defb 003h,000h,040h,041h,083h,077h,002h,078h,000h,0e3h,042h,005h,07bh,045h,07ch,046h	; b45c  ..@A.w.x..B.{E|F
	defb 000h,0e3h,047h,005h,07bh,045h,07ch,046h,000h,0e3h,04ah,083h,079h,003h,07ah,000h	; b46c  ..G.{E|F..J.y.z.
	defb 000h,0e7h,07dh,001h,000h,0f0h,084h,0e7h,094h,000h	; b47c  ..}.......

; ----------------------------------------------------------------------
; DATOS ficha_rle_b486: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   1
;   0xb486..0xb4b3  (45 bytes)
DATA_ficha_rle_b486:
	defb 003h,000h,040h,041h,084h,077h,001h,078h,0e3h,042h,004h,07bh,045h,045h,07ch,0e4h	; b486  ..@A.w.x.B.{EE|.
	defb 046h,005h,07bh,045h,045h,07ch,046h,0e3h,04ah,084h,079h,002h,07ah,000h,0e5h,063h	; b496  F.{EE|F.J.y.z..c
	defb 002h,000h,000h,0eeh,068h,084h,000h,002h,076h,076h,084h,000h,000h	; b4a6  ....h...vv...

; ----------------------------------------------------------------------
; DATOS ficha_rle_b4b3: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   1
;   0xb4b3..0xb4e3  (48 bytes)
DATA_ficha_rle_b4b3:
	defb 003h,000h,040h,041h,083h,077h,002h,078h,000h,0e3h,042h,005h,07bh,045h,07ch,046h	; b4b3  ..@A.w.x..B.{E|F
	defb 000h,0e3h,047h,005h,07bh,045h,07ch,046h,000h,0e3h,04ah,083h,079h,003h,07ah,000h	; b4c3  ..G.{E|F..J.y.z.
	defb 000h,0e5h,063h,002h,000h,000h,0eeh,068h,084h,000h,002h,076h,076h,084h,000h,000h	; b4d3  ..c....h...vv...

; ----------------------------------------------------------------------
; DATOS ficha_rle_b4e3: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   1
;   0xb4e3..0xb50a  (39 bytes)
DATA_ficha_rle_b4e3:
	defb 003h,000h,040h,041h,084h,077h,001h,078h,0e3h,042h,004h,07bh,045h,045h,07ch,0e4h	; b4e3  ..@A.w.x.B.{EE|.
	defb 046h,005h,07bh,045h,045h,07ch,046h,0e3h,04ah,084h,079h,002h,07ah,000h,0e7h,07dh	; b4f3  F.{EE|F.J.y.z..}
	defb 001h,000h,0f0h,084h,0e7h,094h,000h	; b503

; ----------------------------------------------------------------------
; DATOS ficha_rle_b50a: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   1
;   0xb50a..0xb53f  (53 bytes)
DATA_ficha_rle_b50a:
	defb 003h,000h,040h,041h,083h,077h,002h,078h,000h,0e3h,042h,005h,07bh,045h,07ch,046h	; b50a  ..@A.w.x..B.{E|F
	defb 000h,0e3h,047h,005h,07bh,045h,07ch,046h,000h,0e3h,04ah,083h,079h,003h,07ah,000h	; b51a  ..G.{E|F..J.y.z.
	defb 000h,0e5h,04dh,083h,000h,0e7h,052h,002h,000h,000h,0e5h,059h,003h,04eh,000h,000h	; b52a  ..M...R....Y.N..
	defb 0e5h,05eh,001h,000h,000h	; b53a

; ----------------------------------------------------------------------
; DATOS ficha_rle_b53f: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   4
;   0xb53f..0xb570  (49 bytes)
DATA_ficha_rle_b53f:
	defb 088h,000h,004h,065h,040h,040h,066h,084h,000h,008h,041h,05bh,05ch,042h,048h,000h	; b53f  ...e@@f...A[\BH.
	defb 049h,04ah,0e3h,05dh,0e5h,04bh,0e3h,043h,0e4h,050h,001h,000h,0e3h,062h,0e3h,054h	; b54f  IJ.].K.C.P...b.T
	defb 006h,000h,000h,046h,060h,061h,047h,0e4h,057h,004h,067h,040h,040h,068h,084h,000h	; b55f  ...F`aG.W.g@@h..
	defb 000h	; b56f

; ----------------------------------------------------------------------
; DATOS ficha_rle_b570: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   4
;   0xb570..0xb5a6  (54 bytes)
DATA_ficha_rle_b570:
	defb 085h,000h,013h,07ch,000h,000h,065h,040h,040h,066h,07dh,07eh,000h,000h,041h,05bh	; b570  ...|..e@@f}~..A[
	defb 05ch,042h,07fh,080h,000h,000h,0e3h,05dh,0e4h,081h,001h,000h,0e3h,043h,0e3h,085h	; b580  \B.....].....C..
	defb 002h,000h,000h,0e3h,062h,0e5h,089h,004h,046h,060h,061h,047h,084h,000h,004h,067h	; b590  ....b...F`aG...g
	defb 040h,040h,068h,084h,000h,000h	; b5a0

; ----------------------------------------------------------------------
; DATOS ficha_rle_b5a6: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   4
;   0xb5a6..0xb5dc  (54 bytes)
DATA_ficha_rle_b5a6:
	defb 088h,000h,010h,065h,040h,040h,066h,000h,000h,069h,06ah,041h,05bh,05ch,042h,06bh	; b5a6  ...e@@f..ijA[\Bk
	defb 000h,06ch,06dh,0e3h,05dh,0e4h,06eh,001h,000h,0e3h,043h,005h,072h,000h,073h,074h	; b5b6  .lm.].n...C.r.st
	defb 000h,0e3h,062h,0e3h,075h,006h,000h,000h,046h,060h,061h,047h,0e4h,078h,004h,067h	; b5c6  ..b.u...F`aG.x.g
	defb 040h,040h,068h,084h,000h,000h	; b5d6

; ----------------------------------------------------------------------
; DATOS ficha_rle_b5dc: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   3
;   0xb5dc..0xb616  (58 bytes)
DATA_ficha_rle_b5dc:
	defb 008h,000h,000h,040h,000h,055h,056h,060h,05fh,0e5h,041h,002h,057h,061h,0e6h,046h	; b5dc  ...@.UV`_.A.Wa.F
	defb 002h,058h,062h,0e4h,04ch,00dh,000h,059h,05ah,064h,063h,000h,000h,040h,000h,059h	; b5ec  .Xb.L..YZdc..@.Y
	defb 05bh,064h,063h,0e4h,041h,004h,050h,05ch,066h,051h,0e4h,047h,004h,052h,05dh,067h	; b5fc  [dc.A.P\fQ.G.R]g
	defb 053h,0e3h,04dh,005h,000h,05eh,054h,054h,068h,000h	; b60c  S.M..^TTh.

; ----------------------------------------------------------------------
; DATOS ficha_rle_b616: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   3
;   0xb616..0xb656  (64 bytes)
DATA_ficha_rle_b616:
	defb 008h,000h,000h,040h,000h,055h,056h,060h,05fh,0e3h,069h,006h,044h,045h,057h,061h	; b616  ...@.UV`_.i.DEWa
	defb 046h,06ch,0e4h,048h,003h,058h,062h,04ch,0e3h,06dh,005h,000h,059h,05ah,064h,063h	; b626  Fl.H.XbL.m..YZdc
	defb 084h,000h,01ch,059h,05bh,064h,063h,072h,070h,075h,078h,050h,05ch,066h,051h,073h	; b636  ...Y[dcrpuxP\fQs
	defb 048h,076h,079h,052h,05dh,067h,053h,074h,071h,077h,000h,05eh,054h,054h,068h,000h	; b646  HvyR]gStqw.^TTh.

; ----------------------------------------------------------------------
; DATOS ficha_rle_b656: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   3
;   0xb656..0xb697  (65 bytes)
DATA_ficha_rle_b656:
	defb 008h,000h,000h,040h,000h,055h,056h,060h,05fh,0e3h,069h,006h,044h,045h,057h,061h	; b656  ...@.UV`_.i.DEWa
	defb 046h,06ch,0e4h,048h,003h,058h,062h,04ch,0e3h,06dh,00dh,000h,059h,05ah,064h,063h	; b666  Fl.H.XbL.m..YZdc
	defb 000h,000h,040h,000h,059h,05bh,064h,063h,0e3h,069h,006h,044h,050h,05ch,066h,051h	; b676  ..@.Y[dc.i.DP\fQ
	defb 06ch,0e3h,048h,004h,052h,05dh,067h,053h,0e3h,06dh,005h,000h,05eh,054h,054h,068h	; b686  l.H.R]gS.m..^TTh
	defb 000h	; b696

; ----------------------------------------------------------------------
; DATOS ficha_rle_b697: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   5
;   0xb697..0xb6b6  (31 bytes)
DATA_ficha_rle_b697:
	defb 085h,000h,002h,061h,062h,086h,000h,002h,063h,064h,087h,000h,003h,065h,000h,044h	; b697  ...ab...cd...e.D
	defb 0e3h,046h,0ech,048h,0e7h,055h,001h,054h,085h,05ch,001h,05bh,08ah,000h,000h	; b6a7  .F.H.U.T.\.[...

; ----------------------------------------------------------------------
; DATOS ficha_rle_b6b6: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   5
;   0xb6b6..0xb6dd  (39 bytes)
DATA_ficha_rle_b6b6:
	defb 086h,000h,002h,040h,041h,086h,000h,001h,042h,087h,000h,003h,043h,000h,044h,083h	; b6b6  ...@A...B...C.D.
	defb 046h,0e3h,048h,001h,053h,0e4h,04ch,004h,04dh,051h,05ah,05bh,0e7h,055h,001h,000h	; b6c6  F.H.S.L.MQZ[.U..
	defb 0e5h,05ch,001h,05bh,08ah,000h,000h	; b6d6

; ----------------------------------------------------------------------
; DATOS ficha_rle_b6dd: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta el paso
;   5
;   0xb6dd..0xb6f9  (28 bytes)
DATA_ficha_rle_b6dd:
	defb 086h,000h,002h,040h,041h,086h,000h,002h,042h,000h,086h,000h,002h,043h,000h,0f0h	; b6dd  ...@A...B....C..
	defb 044h,0e7h,055h,001h,054h,0e5h,05ch,001h,05bh,08ah,000h,000h	; b6ed  D.U.T.\.[...

; ----------------------------------------------------------------------
; DATOS ficha_rle_b6f9: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta sin
;   llamador visto
;   0xb6f9..0xb710  (23 bytes)
DATA_ficha_rle_b6f9:
	defb 090h,000h,0e3h,048h,002h,000h,000h,0ebh,04bh,0e8h,040h,0e8h,05ch,0e3h,056h,002h	; b6f9  ...H....K.@.\.V.
	defb 000h,000h,0e3h,059h,088h,000h,000h	; b709

; ----------------------------------------------------------------------
; DATOS ficha_rle_b710: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta sin
;   llamador visto
;   0xb710..0xb71f  (15 bytes)
DATA_ficha_rle_b710:
	defb 090h,000h,0efh,065h,001h,064h,0e7h,07ch,001h,064h,0e8h,074h,090h,000h,000h	; b710  ...e.d.|.d.t...

; ----------------------------------------------------------------------
; DATOS ficha_rle_b71f: dibujo de ficha comprimido (RLE_A_BUFFER de p01
;   0x637A, 8 columnas): 8 filas, 64 bytes al descomprimir; lo apunta sin
;   llamador visto
;   0xb71f..0xb72e  (15 bytes)
DATA_ficha_rle_b71f:
	defb 090h,000h,0efh,083h,001h,047h,0e7h,09ah,001h,047h,0e8h,092h,090h,000h,000h	; b71f  .....G...G.....

; ----------------------------------------------------------------------
; DATOS tabla_par_motor: una curva de par por motor (36 filas de 16 bytes):
;   p02 0x9C18 lee la columna (revoluciones & 0xF8) >> 3, y donde vale 0 esta
;   el tope de revoluciones que busca p02 0x89BA
;   0xb72e..0xb96e  (576 bytes)
DATA_tabla_par_motor:
	defb 018h,030h,054h,060h,06ch,078h,06ch,03ch,01eh,00ch,000h,0feh,0feh,0feh,0feh,0feh	; b72e  .0T`lxl<........
	defb 006h,009h,00fh,01eh,042h,048h,036h,015h,00fh,006h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b73e  ....BH6.........
	defb 009h,015h,021h,027h,036h,042h,03ch,024h,00fh,009h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b74e  ..!'6B<$........
	defb 006h,00fh,018h,024h,036h,045h,036h,015h,00fh,009h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b75e  ...$6E6.........
	defb 006h,009h,012h,02ah,03fh,03fh,036h,021h,00fh,009h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b76e  ...*??6!........
	defb 006h,009h,015h,024h,03ch,042h,036h,018h,00fh,009h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b77e  ...$<B6.........
	defb 010h,021h,03ah,043h,04bh,054h,04bh,02ah,015h,008h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b78e  .!:CKTK*........
	defb 008h,00ch,015h,02ah,05ch,064h,04bh,01dh,015h,008h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b79e  ...*\dK.........
	defb 00ch,01dh,02eh,036h,04bh,05ch,054h,032h,015h,00ch,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b7ae  ...6K\T2........
	defb 008h,015h,021h,032h,04bh,060h,04bh,01dh,00ch,00ch,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b7be  ..!2K`K.........
	defb 008h,00ch,019h,03ah,058h,058h,04bh,02eh,015h,00ch,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b7ce  ...:XXK.........
	defb 008h,00ch,01dh,032h,054h,05ch,04bh,021h,015h,00ch,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b7de  ...2T\K!........
	defb 020h,040h,070h,07fh,07fh,07fh,060h,050h,010h,000h,000h,000h,000h,000h,000h,000h	; b7ee   @p...`P........
	defb 00fh,017h,027h,04eh,0abh,0bbh,08ch,036h,027h,00fh,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b7fe  ..'N...6'.......
	defb 017h,036h,055h,065h,08ch,0abh,09ch,05dh,027h,017h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b80e  .6Ue...]'.......
	defb 00fh,027h,03eh,05dh,08ch,0b3h,08ch,036h,027h,017h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b81e  .'>]...6'.......
	defb 00fh,017h,02eh,06dh,0a3h,0a3h,08ch,055h,027h,017h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b82e  ...m...U'.......
	defb 00fh,017h,036h,05dh,09ch,0abh,08ch,03eh,027h,017h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b83e  ..6]...>'.......
	defb 01ch,039h,064h,073h,081h,090h,081h,048h,024h,00eh,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b84e  .9ds...H$.......
	defb 00eh,015h,024h,048h,09eh,0ach,081h,032h,024h,00eh,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b85e  ..$H...2$.......
	defb 015h,032h,04fh,05dh,081h,09eh,090h,056h,024h,015h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b86e  .2O]...V$.......
	defb 00eh,024h,039h,056h,081h,0a5h,081h,032h,024h,015h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b87e  .$9V...2$.......
	defb 00eh,015h,02bh,064h,097h,097h,081h,04fh,024h,015h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b88e  ..+d...O$.......
	defb 00eh,015h,032h,056h,090h,09eh,081h,039h,024h,015h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b89e  ..2V...9$.......
	defb 015h,02bh,04bh,056h,061h,06ch,061h,036h,01bh,00ah,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b8ae  .+KVala6........
	defb 00ah,010h,01bh,036h,076h,081h,061h,025h,01bh,00ah,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b8be  ...6v.a%........
	defb 010h,025h,03bh,046h,061h,076h,06ch,040h,01bh,010h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b8ce  .%;Favl@........
	defb 00ah,01bh,02bh,040h,061h,07ch,061h,025h,01bh,010h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b8de  ..+@a|a%........
	defb 00ah,010h,020h,04bh,071h,071h,061h,03bh,01bh,010h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b8ee  .. Kqqa;........
	defb 00ah,010h,025h,040h,06ch,076h,061h,02bh,01bh,010h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b8fe  ..%@lva+........
	defb 01ch,039h,064h,073h,081h,090h,081h,048h,024h,00eh,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b90e  .9ds...H$.......
	defb 00eh,015h,024h,048h,09eh,0ach,081h,032h,024h,00eh,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b91e  ..$H...2$.......
	defb 015h,032h,04fh,05dh,081h,09eh,090h,056h,024h,015h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b92e  .2O]...V$.......
	defb 00eh,024h,039h,056h,081h,0a5h,081h,032h,024h,015h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b93e  .$9V...2$.......
	defb 00eh,015h,02bh,064h,097h,097h,081h,04fh,024h,015h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b94e  ..+d...O$.......
	defb 00eh,015h,032h,056h,090h,09eh,081h,039h,024h,015h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b95e  ..2V...9$.......

; ----------------------------------------------------------------------
; DATOS tabla_par_sobrante: 7 filas mas con la misma forma que las de arriba y
;   repetidas de ellas; ningun motor las alcanza (el indice no pasa de 35)
;   0xb96e..0xb9de  (112 bytes)
DATA_tabla_par_sobrante:
	defb 015h,02bh,04bh,056h,061h,06ch,061h,036h,01bh,00ah,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b96e  .+KVala6........
	defb 00ah,010h,01bh,036h,076h,081h,061h,025h,01bh,00ah,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b97e  ...6v.a%........
	defb 010h,025h,03bh,046h,061h,076h,06ch,040h,01bh,010h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b98e  .%;Favl@........
	defb 00ah,01bh,02bh,040h,061h,07ch,061h,025h,01bh,010h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b99e  ..+@a|a%........
	defb 00ah,010h,020h,04bh,071h,071h,061h,03bh,01bh,010h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b9ae  .. Kqqa;........
	defb 00ah,010h,025h,040h,06ch,076h,061h,02bh,01bh,010h,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b9be  ..%@lva+........
	defb 015h,02bh,04bh,056h,061h,06ch,061h,036h,01bh,00ah,000h,0ffh,0ffh,0ffh,0ffh,0ffh	; b9ce  .+KVala6........

; ----------------------------------------------------------------------
; DATOS pantalla_B9DE: pantalla comprimida para RLE_A_RAM (p01 0x637A): 24
;   filas de 14 tiles; p01 0x75D7 (con 9): el HUD de un jugador, en la columna
;   18 del buffer E400
;   0xb9de..0xbaa5  (199 bytes)
DATA_pantalla_B9DE:
	defb 001h,0d4h,08bh,0d5h,003h,0d6h,000h,0d2h,08bh,000h,003h,0d3h,000h,0d2h,08bh,000h	; b9de  ................
	defb 003h,0d3h,000h,0d2h,08bh,000h,003h,0d3h,000h,0d2h,08bh,000h,003h,0d3h,000h,0d2h	; b9ee  ................
	defb 08bh,000h,003h,0d3h,000h,0d2h,08bh,000h,003h,0d3h,000h,0d7h,08bh,0d8h,003h,0d9h	; b9fe  ................
	defb 000h,0d2h,08bh,000h,003h,0d3h,000h,0d2h,083h,000h,084h,0d7h,0e4h,0d8h,003h,0d3h	; ba0e  ................
	defb 000h,0d2h,08ah,000h,006h,0dfh,0d3h,000h,0d2h,000h,000h,083h,0d7h,083h,000h,0e3h	; ba1e  ................
	defb 0e1h,005h,0d3h,000h,0d2h,000h,000h,0e4h,0ech,00ah,0d7h,0d7h,000h,000h,0d7h,0d3h	; ba2e  ................
	defb 000h,0d2h,000h,000h,0e4h,0e8h,083h,0d7h,006h,000h,0dbh,0d3h,000h,0d2h,0f0h,089h	; ba3e  ................
	defb 0d7h,007h,0f1h,0d3h,000h,0d2h,0f2h,0f3h,0d7h,088h,000h,003h,0d3h,000h,0d2h,08bh	; ba4e  ................
	defb 000h,003h,0d3h,000h,0d2h,0e8h,0d4h,008h,0dbh,0dbh,0dch,0d3h,000h,0d2h,000h,000h	; ba5e  ................
	defb 0e4h,0ddh,00ah,000h,0e1h,0f1h,0f1h,000h,0d3h,000h,0d2h,0fah,0fdh,0e5h,0e2h,009h	; ba6e  ................
	defb 000h,0f1h,0f1h,000h,0d3h,000h,0d2h,0fbh,0feh,0e6h,0e7h,009h,0f1h,0f1h,000h,0d3h	; ba7e  ................
	defb 000h,0d2h,0fch,0ffh,0edh,0e3h,0deh,008h,000h,0eeh,0f1h,0f1h,000h,0d3h,000h,0efh	; ba8e  ................
	defb 08bh,0f3h,001h,0f0h,08fh,000h,000h	; ba9e

; ----------------------------------------------------------------------
; DATOS pantalla_BAA5: pantalla comprimida para RLE_A_RAM (p01 0x637A): 3
;   filas de 16 tiles; p01 0x75B8 (con 9): el HUD de arriba con dos jugadores
;   0xbaa5..0xbac0  (27 bytes)
DATA_pantalla_BAA5:
	defb 084h,000h,003h,0f3h,0f4h,0deh,089h,000h,0e3h,0f8h,083h,000h,001h,0dfh,087h,000h	; baa5  ................
	defb 001h,0e0h,085h,000h,003h,0f2h,000h,0e1h,089h,000h,000h	; bab5  ...........

; ----------------------------------------------------------------------
; DATOS pantalla_BAC0: pantalla comprimida para RLE_A_RAM (p01 0x637A): 3
;   filas de 16 tiles; p01 0x75C6 (con 9): el HUD de abajo con dos jugadores
;   0xbac0..0xbad9  (25 bytes)
DATA_pantalla_BAC0:
	defb 0e3h,0f8h,083h,000h,001h,0dfh,087h,000h,001h,0e0h,085h,000h,003h,0f2h,000h,0e1h	; bac0  ................
	defb 08dh,000h,003h,0f3h,0f4h,0deh,089h,000h,000h	; bad0  .........

; ----------------------------------------------------------------------
; DATOS rle_pat_BAD9: patrones RLE: 10 tiles desde el 1 (lista 0x62a3)
;   0xbad9..0xbb2b  (82 bytes)
DATA_rle_pat_BAD9:
	defb 0d0h,007h,003h,003h,078h,0feh,0f3h,0e1h,0c7h,001h,070h,0fch,0c3h,0c0h,0efh,003h	; bad9  ....x.....p.....
	defb 000h,000h,001h,081h,0e1h,0f0h,0f8h,0fch,0feh,0f0h,0cch,086h,01fh,00fh,007h,082h	; bae9  ................
	defb 0c1h,0c0h,0e0h,007h,03fh,0fch,0f8h,0fch,0f7h,0e0h,0c0h,0c0h,01eh,07fh,0cfh,087h	; baf9  ....?...........
	defb 0e3h,080h,00eh,03fh,0c3h,003h,0f7h,0c0h,0ffh,000h,080h,081h,087h,00fh,01fh,03fh	; bb09  ...?...........?
	defb 07fh,00fh,033h,061h,0f8h,0f0h,0e0h,041h,083h,003h,007h,0e0h,0fch,03fh,01fh,03fh	; bb19  ..3a...A.....?.?
	defb 0efh,000h	; bb29

; ----------------------------------------------------------------------
; DATOS rle_pat_BB2B: patrones RLE: 1 tiles desde el 41 (tabla85[67])
;   0xbb2b..0xbb35  (10 bytes)
DATA_rle_pat_BB2B:
	defb 088h,06bh,0bch,0dbh,037h,05fh,0e8h,005h,0fdh,000h	; bb2b  .k..7_....

; ----------------------------------------------------------------------
; DATOS rle_pat_BB35: patrones RLE: 4 tiles desde el 60 (lista 0x62a3)
;   0xbb35..0xbb57  (34 bytes)
DATA_rle_pat_BB35:
	defb 0a0h,030h,052h,05ah,031h,080h,041h,094h,0c6h,02ah,01dh,077h,0dah,053h,066h,02dh	; bb35  .0RZ1.A..*.w.Sf-
	defb 01bh,00dh,0ach,0e3h,054h,082h,000h,041h,02ah,080h,0b8h,054h,0d9h,0b6h,0ebh,07dh	; bb45  ....T..A*..T...}
	defb 0edh,000h	; bb55

; ----------------------------------------------------------------------
; DATOS rle_pat_BB57: patrones RLE: 3 tiles desde el 64 (lista 0x62a3)
;   0xbb57..0xbb71  (26 bytes)
DATA_rle_pat_BB57:
	defb 098h,065h,069h,09bh,0a8h,050h,074h,0c0h,028h,0f8h,0d1h,03fh,053h,0bah,06ah,065h	; bb57  .ei..Pt.(..?S.je
	defb 02ch,0e6h,06eh,03fh,089h,06dh,0dbh,076h,0cch,000h	; bb67  ,.n?.m.v..

; ----------------------------------------------------------------------
; DATOS rle_pat_BB71: patrones RLE: 4 tiles desde el 70 (lista 0x62a3)
;   0xbb71..0xbb91  (32 bytes)
DATA_rle_pat_BB71:
	defb 081h,09fh,005h,03fh,085h,01fh,018h,0feh,01fh,060h,003h,09fh,08dh,01fh,0feh,067h	; bb71  ...?.....`.....g
	defb 09bh,0a3h,0b3h,0a3h,09bh,0e3h,04ch,0feh,08fh,030h,003h,0cfh,082h,08fh,07eh,000h	; bb81  ......L..0....~.

; ----------------------------------------------------------------------
; DATOS rle_pat_BB91: patrones RLE: 2 tiles desde el 74 (lista 0x62a3)
;   0xbb91..0xbba1  (16 bytes)
DATA_rle_pat_BB91:
	defb 004h,00fh,08ch,0f0h,0f8h,0fch,0feh,07fh,07fh,03fh,03eh,01fh,01bh,01fh,01eh,000h	; bb91  .........?>.....

; ----------------------------------------------------------------------
; DATOS rle_pat_BBA1: patrones RLE: 5 tiles desde el 78 (lista 0x62a3)
;   0xbba1..0xbbcb  (42 bytes)
DATA_rle_pat_BBA1:
	defb 08eh,0f8h,0feh,0f1h,0efh,00fh,003h,001h,000h,0f8h,0bch,006h,081h,041h,023h,003h	; bba1  .............A#.
	defb 01fh,097h,06fh,0f7h,0e3h,0c1h,0dfh,01fh,078h,0c1h,0e3h,027h,027h,04fh,01fh,01fh	; bbb1  ..o.....x..''O..
	defb 00fh,00fh,0f0h,0e0h,000h,0c0h,0e0h,0c0h,003h,000h	; bbc1  ..........

; ----------------------------------------------------------------------
; DATOS rle_pat_BBCB: patrones RLE: 3 tiles desde el 92 (tabla85[69])
;   0xbbcb..0xbbe5  (26 bytes)
DATA_rle_pat_BBCB:
	defb 08ah,0efh,004h,040h,002h,020h,0f7h,002h,020h,000h,040h,003h,002h,08bh,0f7h,020h	; bbcb  ...@. .. .@....
	defb 000h,000h,008h,000h,000h,040h,002h,000h,000h,000h	; bbdb  .....@....

; ----------------------------------------------------------------------
; DATOS rle_pat_BBE5: patrones RLE: 1 tiles desde el 95 (lista 0x62a3)
;   0xbbe5..0xbbec  (7 bytes)
DATA_rle_pat_BBE5:
	defb 003h,0ffh,081h,07fh,004h,03fh,000h	; bbe5

; ----------------------------------------------------------------------
; DATOS rle_pat_BBEC: patrones RLE: 3 tiles desde el 99 (tabla85[70])
;   0xbbec..0xbc06  (26 bytes)
DATA_rle_pat_BBEC:
	defb 082h,0ffh,0bfh,003h,0ffh,093h,018h,0fbh,0e3h,0ffh,0ffh,00eh,01fh,011h,0eeh,0f0h	; bbec  ................
	defb 0ffh,000h,000h,07ch,0fch,0fch,078h,081h,0c7h,000h	; bbfc  ...|..x...

; ----------------------------------------------------------------------
; DATOS rle_pat_BC06: patrones RLE: 6 tiles desde el 102 (tabla85[71])
;   0xbc06..0xbc33  (45 bytes)
DATA_rle_pat_BC06:
	defb 002h,0ffh,085h,0bdh,0ffh,001h,0feh,0f7h,003h,0ffh,084h,0f7h,0ffh,07fh,07fh,003h	; bc06  ................
	defb 0ffh,086h,0fdh,0ffh,0bfh,0ffh,001h,0feh,003h,0ffh,085h,0efh,0ffh,0ffh,07fh,07dh	; bc16  ...............}
	defb 005h,0ffh,081h,0efh,006h,0ffh,085h,0bfh,0ffh,0ffh,0fdh,0ffh,000h	; bc26  .............

; ----------------------------------------------------------------------
; DATOS rle_pat_BC33: patrones RLE: 7 tiles desde el 108 (lista 0x62a3)
;   0xbc33..0xbc67  (52 bytes)
DATA_rle_pat_BC33:
	defb 004h,0ffh,0a9h,07fh,03fh,047h,081h,0a0h,042h,030h,01dh,0ceh,0fch,0f2h,0c0h,0a0h	; bc33  ....?G..B0......
	defb 0c2h,0f0h,0fdh,03eh,01ch,032h,0c0h,080h,0c0h,080h,001h,002h,001h,040h,088h,0a0h	; bc43  ...>.2.......@..
	defb 0c2h,0e8h,0a0h,0feh,0a0h,0f2h,0c0h,0a0h,042h,030h,01dh,0ceh,007h,0ffh,084h,03eh	; bc53  ........B0.....>
	defb 01ch,032h,0c0h,000h	; bc63

; ----------------------------------------------------------------------
; DATOS rle_pat_BC67: patrones RLE: 3 tiles desde el 130 (lista 0x62a3)
;   0xbc67..0xbc81  (26 bytes)
DATA_rle_pat_BC67:
	defb 098h,0ffh,0fdh,0dfh,0ffh,0fdh,0ffh,08fh,003h,058h,0fch,0dfh,0ffh,0fbh,0ffh,0bfh	; bc67  .........X......
	defb 0ffh,005h,043h,00fh,0bfh,0fdh,0ffh,0f7h,0ffh,000h	; bc77  ..C.......

; ----------------------------------------------------------------------
; DATOS rle_pat_BC81: patrones RLE: 4 tiles desde el 136 (lista 0x62a3)
;   0xbc81..0xbc9e  (29 bytes)
DATA_rle_pat_BC81:
	defb 099h,001h,003h,084h,0f9h,0f9h,0fdh,0ffh,0ffh,080h,000h,00fh,0fdh,0f9h,0f9h,0fbh	; bc81  ................
	defb 0ffh,0bfh,060h,09fh,0b7h,0f3h,0f3h,0f7h,0ffh,0ffh,007h,07fh,000h	; bc91  ..`..........

; ----------------------------------------------------------------------
; DATOS rle_pat_BC9E: patrones RLE: 1 tiles desde el 159 (lista 0x6211)
;   0xbc9e..0xbca6  (8 bytes)
DATA_rle_pat_BC9E:
	defb 082h,08fh,002h,005h,000h,081h,081h,000h	; bc9e  ........

; ----------------------------------------------------------------------
; DATOS rle_pat_BCA6: patrones RLE: 3 tiles desde el 167 (lista 0x6211)
;   0xbca6..0xbcbd  (23 bytes)
DATA_rle_pat_BCA6:
	defb 002h,000h,091h,001h,0beh,080h,0a1h,0fbh,0bfh,000h,000h,06fh,07fh,010h,03dh,0f7h	; bca6  ...........o..=.
	defb 0ffh,07fh,0fbh,0dfh,005h,0ffh,000h	; bcb6

; ----------------------------------------------------------------------
; DATOS rle_pat_BCBD: patrones RLE: 2 tiles desde el 150 (lista 0x6211)
;   0xbcbd..0xbccf  (18 bytes)
DATA_rle_pat_BCBD:
	defb 090h,0bfh,09fh,047h,028h,0e7h,018h,018h,07eh,0ffh,0ffh,0fch,072h,082h,000h,01eh	; bcbd  ...G(...~...r...
	defb 0e1h,000h	; bccd

; ----------------------------------------------------------------------
; DATOS rle_pat_BCCF: patrones RLE: 1 tiles desde el 152 (lista 0x6211)
;   0xbccf..0xbcd4  (5 bytes)
DATA_rle_pat_BCCF:
	defb 081h,0e1h,007h,0ffh,000h	; bccf

; ----------------------------------------------------------------------
; DATOS rle_pat_BCD4: patrones RLE: 1 tiles desde el 141 (tabla85[72])
;   0xbcd4..0xbcd7  (3 bytes)
DATA_rle_pat_BCD4:
	defb 008h,0ffh,000h	; bcd4

; ----------------------------------------------------------------------
; DATOS rle_pat_BCD7: patrones RLE: 1 tiles desde el 140 (lista 0x6211)
;   0xbcd7..0xbce1  (10 bytes)
DATA_rle_pat_BCD7:
	defb 088h,001h,003h,001h,001h,000h,000h,001h,001h,000h	; bcd7  ..........

; ----------------------------------------------------------------------
; DATOS rle_pat_BCE1: patrones RLE: 3 tiles desde el 142 (lista 0x6211)
;   0xbce1..0xbcf6  (21 bytes)
DATA_rle_pat_BCE1:
	defb 091h,038h,006h,0f7h,03bh,098h,0c0h,007h,0ffh,0ceh,063h,011h,027h,018h,0feh,000h	; bce1  .8..;.....c.'...
	defb 07ch,0c1h,007h,0ffh,000h	; bcf1

; ----------------------------------------------------------------------
; DATOS rle_pat_BCF6: patrones RLE: 7 tiles desde el 184 (lista 0x6211)
;   0xbcf6..0xbd2e  (56 bytes)
DATA_rle_pat_BCF6:
	defb 002h,000h,081h,07eh,003h,03eh,082h,0c3h,0e3h,003h,000h,081h,0c3h,003h,0e7h,084h	; bcf6  ...~.>..........
	defb 0c3h,07eh,018h,0c3h,003h,0e7h,003h,0c3h,090h,07eh,03ch,03ch,081h,081h,0ffh,07fh	; bd06  .~.......~<<....
	defb 080h,0e3h,0f7h,0c3h,03ch,07eh,03ch,0c3h,0e3h,003h,0f7h,082h,0e3h,01ch,004h,0ffh	; bd16  ....<~<.........
	defb 086h,0dfh,0fdh,0ffh,0ffh,0bfh,0ffh,000h	; bd26  ........

; ----------------------------------------------------------------------
; DATOS rle_col_BD2E: colores RLE: 10 tiles desde el 1 (lista 0x62a3)
;   0xbd2e..0xbd78  (74 bytes)
DATA_rle_col_BD2E:
	defb 08dh,061h,0a1h,091h,091h,0a1h,096h,096h,061h,061h,091h,0a1h,096h,096h,003h,061h	; bd2e  .a......aa.....a
	defb 081h,0b1h,003h,091h,081h,081h,003h,061h,083h,0b6h,096h,096h,007h,061h,097h,096h	; bd3e  .......a.....a..
	defb 0b6h,0a9h,098h,086h,061h,061h,0a1h,091h,091h,0a1h,096h,096h,061h,061h,091h,0a1h	; bd4e  ....aa......aa..
	defb 096h,096h,061h,061h,011h,061h,003h,091h,081h,081h,003h,061h,083h,0b6h,096h,096h	; bd5e  ..aa.a.....a....
	defb 007h,061h,086h,096h,0b6h,0a9h,098h,086h,061h,000h	; bd6e  .a......a.

; ----------------------------------------------------------------------
; DATOS rle_col_BD78: colores RLE: 1 tiles desde el 41 (tabla85[67])
;   0xbd78..0xbd81  (9 bytes)
DATA_rle_col_BD78:
	defb 003h,0c1h,002h,0c9h,083h,091h,0c9h,091h,000h	; bd78  .........

; ----------------------------------------------------------------------
; DATOS rle_col_BD81: colores RLE: 4 tiles desde el 60 (lista 0x62a3)
;   0xbd81..0xbd9f  (30 bytes)
DATA_rle_col_BD81:
	defb 084h,0c1h,021h,0c1h,021h,003h,0c1h,002h,021h,002h,0c1h,086h,0c2h,021h,0c2h,0c1h	; bd81  ..!.!...!....!..
	defb 0c1h,021h,007h,0c1h,088h,021h,0c1h,021h,0c1h,021h,0c2h,0c1h,021h,000h	; bd91  .!...!.!.!..!.

; ----------------------------------------------------------------------
; DATOS rle_col_BD9F: colores RLE: 3 tiles desde el 64 (lista 0x62a3)
;   0xbd9f..0xbdb8  (25 bytes)
DATA_rle_col_BD9F:
	defb 085h,021h,0c1h,0c1h,021h,021h,003h,0c1h,002h,092h,089h,0c9h,021h,0c1h,021h,0c2h	; bd9f  .!..!!......!.!.
	defb 021h,092h,0c9h,0c9h,003h,0c2h,002h,0c1h,000h	; bdaf  !........

; ----------------------------------------------------------------------
; DATOS rle_col_BDB8: colores RLE: 4 tiles desde el 70 (lista 0x62a3)
;   0xbdb8..0xbdd4  (28 bytes)
DATA_rle_col_BDB8:
	defb 081h,0e5h,005h,0f4h,08ah,0e4h,0e1h,0f1h,041h,0e8h,0f1h,0f1h,041h,081h,0e1h,006h	; bdb8  ........A...A...
	defb 0f1h,002h,0e1h,083h,0f1h,081h,0e8h,004h,081h,081h,0e1h,000h	; bdc8  ............

; ----------------------------------------------------------------------
; DATOS rle_col_BDD4: colores RLE: 2 tiles desde el 74 (lista 0x62a3)
;   0xbdd4..0xbddb  (7 bytes)
DATA_rle_col_BDD4:
	defb 004h,0e9h,009h,091h,003h,0e1h,000h	; bdd4

; ----------------------------------------------------------------------
; DATOS rle_col_BDDB: colores RLE: 5 tiles desde el 78 (lista 0x62a3)
;   0xbddb..0xbdfe  (35 bytes)
DATA_rle_col_BDDB:
	defb 083h,091h,0a1h,096h,005h,061h,083h,091h,061h,061h,007h,091h,003h,096h,002h,061h	; bddb  .....a..aa.....a
	defb 082h,096h,091h,003h,096h,002h,091h,083h,098h,096h,096h,003h,061h,084h,081h,061h	; bdeb  ............a..a
	defb 061h,091h,000h	; bdfb

; ----------------------------------------------------------------------
; DATOS rle_col_BDFE: colores RLE: 3 tiles desde el 92 (tabla85[69])
;   0xbdfe..0xbe0e  (16 bytes)
DATA_rle_col_BDFE:
	defb 081h,098h,004h,0b9h,081h,098h,004h,0b9h,084h,089h,099h,0b9h,098h,00ah,0b9h,000h	; bdfe  ................

; ----------------------------------------------------------------------
; DATOS rle_col_BE0E: colores RLE: 1 tiles desde el 95 (lista 0x62a3)
;   0xbe0e..0xbe13  (5 bytes)
DATA_rle_col_BE0E:
	defb 007h,096h,081h,091h,000h	; be0e

; ----------------------------------------------------------------------
; DATOS rle_col_BE13: colores RLE: 3 tiles desde el 99 (tabla85[70])
;   0xbe13..0xbe26  (19 bytes)
DATA_rle_col_BE13:
	defb 005h,091h,081h,0b9h,004h,091h,083h,0b9h,0a9h,0a9h,003h,091h,003h,0b9h,081h,0a1h	; be13  ................
	defb 004h,091h,000h	; be23

; ----------------------------------------------------------------------
; DATOS rle_col_BE26: colores RLE: 6 tiles desde el 102 (tabla85[71])
;   0xbe26..0xbe31  (11 bytes)
DATA_rle_col_BE26:
	defb 004h,091h,081h,0b9h,010h,091h,081h,0b9h,01ah,091h,000h	; be26  ...........

; ----------------------------------------------------------------------
; DATOS rle_col_BE31: colores RLE: 7 tiles desde el 108 (lista 0x62a3)
;   0xbe31..0xbe47  (22 bytes)
DATA_rle_col_BE31:
	defb 008h,091h,003h,081h,010h,091h,003h,061h,004h,091h,086h,081h,098h,081h,098h,081h	; be31  .......a........
	defb 091h,003h,081h,00dh,091h,000h	; be41

; ----------------------------------------------------------------------
; DATOS rle_col_BE47: colores RLE: 3 tiles desde el 130 (lista 0x62a3)
;   0xbe47..0xbe52  (11 bytes)
DATA_rle_col_BE47:
	defb 003h,098h,007h,091h,006h,098h,004h,091h,004h,098h,000h	; be47  ...........

; ----------------------------------------------------------------------
; DATOS rle_col_BE52: colores RLE: 4 tiles desde el 136 (lista 0x62a3)
;   0xbe52..0xbe69  (23 bytes)
DATA_rle_col_BE52:
	defb 002h,0e1h,082h,091h,098h,004h,091h,081h,0e1h,003h,091h,081h,098h,004h,091h,084h	; be52  ................
	defb 0a9h,091h,091h,096h,00bh,091h,000h	; be62

; ----------------------------------------------------------------------
; DATOS rle_col_BE69: colores RLE: 1 tiles desde el 159 (lista 0x6211)
;   0xbe69..0xbe70  (7 bytes)
DATA_rle_col_BE69:
	defb 002h,091h,005h,0e1h,081h,091h,000h	; be69

; ----------------------------------------------------------------------
; DATOS rle_col_BE70: colores RLE: 3 tiles desde el 167 (lista 0x6211)
;   0xbe70..0xbe7b  (11 bytes)
DATA_rle_col_BE70:
	defb 003h,0b9h,081h,091h,006h,0e9h,002h,091h,00ch,0e9h,000h	; be70  ...........

; ----------------------------------------------------------------------
; DATOS rle_col_BE7B: colores RLE: 2 tiles desde el 150 (lista 0x6211)
;   0xbe7b..0xbe88  (13 bytes)
DATA_rle_col_BE7B:
	defb 004h,096h,084h,061h,041h,054h,054h,006h,096h,082h,061h,041h,000h	; be7b  ...aATT...aA.

; ----------------------------------------------------------------------
; DATOS rle_col_BE88: colores RLE: 1 tiles desde el 152 (lista 0x6211)
;   0xbe88..0xbe8b  (3 bytes)
DATA_rle_col_BE88:
	defb 008h,054h,000h	; be88

; ----------------------------------------------------------------------
; DATOS rle_col_BE8B: colores RLE: 1 tiles desde el 141 (tabla85[72])
;   0xbe8b..0xbe8e  (3 bytes)
DATA_rle_col_BE8B:
	defb 008h,054h,000h	; be8b

; ----------------------------------------------------------------------
; DATOS rle_col_BE8E: colores RLE: 1 tiles desde el 140 (lista 0x6211)
;   0xbe8e..0xbe91  (3 bytes)
DATA_rle_col_BE8E:
	defb 008h,054h,000h	; be8e

; ----------------------------------------------------------------------
; DATOS rle_col_BE91: colores RLE: 3 tiles desde el 142 (lista 0x6211)
;   0xbe91..0xbea3  (18 bytes)
DATA_rle_col_BE91:
	defb 002h,096h,081h,081h,003h,061h,088h,041h,044h,096h,086h,086h,061h,041h,041h,00ah	; be91  .....a.AD...aAA.
	defb 054h,000h	; bea1

; ----------------------------------------------------------------------
; DATOS rle_col_BEA3: colores RLE: 7 tiles desde el 184 (lista 0x6211)
;   0xbea3..0xbecf  (44 bytes)
DATA_rle_col_BEA3:
	defb 003h,0a9h,002h,0bah,083h,0a9h,098h,086h,005h,0a9h,082h,091h,081h,003h,061h,003h	; bea3  ..............a.
	defb 091h,095h,081h,061h,011h,019h,0a9h,0bah,0a9h,098h,086h,061h,061h,091h,081h,061h	; beb3  ...a.......aa..a
	defb 061h,091h,061h,061h,091h,091h,081h,003h,061h,00bh,091h,000h	; bec3  a.aa....a...

; ----------------------------------------------------------------------
; DATOS relleno_BECF: 305 bytes a 0xFF hasta el final de la pagina: espacio
;   libre, comprobado byte a byte
;   0xbecf..0xc000  (305 bytes)
DATA_relleno_BECF:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; becf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bedf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beef  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beff  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf0f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf1f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf2f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf3f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf4f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf5f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf6f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf7f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf8f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf9f  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfaf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfbf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfcf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfdf  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfef  ................
	defb 0ffh	; bfff
