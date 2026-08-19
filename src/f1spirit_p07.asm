; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 07 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS tabla_circuitos: 21 punteros (por la carrera (E25C)) a la secuencia de
;   cada circuito
;   0x6000..0x602a  (42 bytes)
DATA_tabla_circuitos:
	defw 0602ah	; 6000  -> DATA_circuito_00
	defw 06506h	; 6002  -> DATA_circuito_01
	defw 0616bh	; 6004  -> DATA_circuito_02
	defw 063edh	; 6006  -> DATA_circuito_03
	defw 062ach	; 6008  -> DATA_circuito_04
	defw 06607h	; 600a  -> DATA_circuito_05
	defw 06748h	; 600c  -> DATA_circuito_06
	defw 06859h	; 600e  -> DATA_circuito_07
	defw 06972h	; 6010  -> DATA_circuito_08
	defw 06a6bh	; 6012  -> DATA_circuito_09
	defw 06b7ch	; 6014  -> DATA_circuito_10
	defw 06c6dh	; 6016  -> DATA_circuito_11
	defw 06d6eh	; 6018  -> DATA_circuito_12
	defw 06e8fh	; 601a  -> DATA_circuito_13
	defw 06fb0h	; 601c  -> DATA_circuito_14
	defw 070d1h	; 601e  -> DATA_circuito_15
	defw 071d2h	; 6020  -> DATA_circuito_16
	defw 072f3h	; 6022  -> DATA_circuito_17
	defw 0741ch	; 6024  -> DATA_circuito_18
	defw 0751dh	; 6026  -> DATA_circuito_19
	defw 07646h	; 6028  -> DATA_circuito_20

; ----------------------------------------------------------------------
; DATOS circuito_00: secuencia del circuito de la carrera 0 (RALLY): 160 pares
;   (pieza, flags) y 0xFF; piezas hasta la 64, 160 con desplazamiento de
;   columna (bit 6)
;   0x602a..0x616b  (321 bytes)
DATA_circuito_00:
	defb 001h,040h	; 602a
	defb 000h,040h	; 602c
	defb 00fh,040h	; 602e
	defb 00eh,040h	; 6030
	defb 00ch,040h	; 6032
	defb 00bh,040h	; 6034
	defb 00dh,040h	; 6036
	defb 00fh,040h	; 6038
	defb 00eh,040h	; 603a
	defb 00ch,040h	; 603c
	defb 00bh,040h	; 603e
	defb 00ch,040h	; 6040
	defb 00bh,040h	; 6042
	defb 00ch,040h	; 6044
	defb 00bh,040h	; 6046
	defb 00dh,040h	; 6048
	defb 00fh,040h	; 604a
	defb 00eh,040h	; 604c
	defb 00dh,040h	; 604e
	defb 00ch,040h	; 6050
	defb 00bh,040h	; 6052
	defb 00fh,040h	; 6054
	defb 00eh,040h	; 6056
	defb 00fh,040h	; 6058
	defb 00eh,040h	; 605a
	defb 00dh,040h	; 605c
	defb 00ch,040h	; 605e
	defb 00bh,040h	; 6060
	defb 00ch,040h	; 6062
	defb 00bh,040h	; 6064
	defb 013h,040h	; 6066
	defb 012h,040h	; 6068
	defb 017h,040h	; 606a
	defb 015h,040h	; 606c
	defb 014h,040h	; 606e
	defb 037h,046h	; 6070
	defb 036h,040h	; 6072
	defb 035h,040h	; 6074
	defb 014h,040h	; 6076
	defb 03ah,040h	; 6078
	defb 039h,040h	; 607a
	defb 038h,040h	; 607c
	defb 017h,042h	; 607e
	defb 015h,040h	; 6080
	defb 028h,045h	; 6082
	defb 027h,040h	; 6084
	defb 026h,040h	; 6086
	defb 025h,040h	; 6088
	defb 015h,040h	; 608a
	defb 014h,040h	; 608c
	defb 028h,045h	; 608e
	defb 027h,040h	; 6090
	defb 026h,040h	; 6092
	defb 025h,040h	; 6094
	defb 017h,040h	; 6096
	defb 016h,040h	; 6098
	defb 015h,040h	; 609a
	defb 01ah,040h	; 609c
	defb 01dh,040h	; 609e
	defb 01ch,040h	; 60a0
	defb 040h,040h	; 60a2
	defb 03fh,040h	; 60a4
	defb 03eh,040h	; 60a6
	defb 01dh,042h	; 60a8
	defb 030h,045h	; 60aa
	defb 02fh,040h	; 60ac
	defb 02eh,040h	; 60ae
	defb 02dh,040h	; 60b0
	defb 01dh,040h	; 60b2
	defb 01bh,040h	; 60b4
	defb 017h,040h	; 60b6
	defb 02ch,040h	; 60b8
	defb 02bh,040h	; 60ba
	defb 02ah,040h	; 60bc
	defb 029h,040h	; 60be
	defb 037h,041h	; 60c0
	defb 036h,040h	; 60c2
	defb 035h,040h	; 60c4
	defb 015h,040h	; 60c6
	defb 016h,040h	; 60c8
	defb 024h,040h	; 60ca
	defb 023h,040h	; 60cc
	defb 022h,040h	; 60ce
	defb 021h,040h	; 60d0
	defb 015h,040h	; 60d2
	defb 028h,045h	; 60d4
	defb 027h,040h	; 60d6
	defb 026h,040h	; 60d8
	defb 025h,040h	; 60da
	defb 019h,040h	; 60dc
	defb 018h,040h	; 60de
	defb 02ch,040h	; 60e0
	defb 02bh,040h	; 60e2
	defb 02ah,040h	; 60e4
	defb 029h,040h	; 60e6
	defb 017h,043h	; 60e8
	defb 016h,040h	; 60ea
	defb 01ah,040h	; 60ec
	defb 01eh,040h	; 60ee
	defb 01ch,040h	; 60f0
	defb 03dh,046h	; 60f2
	defb 03ch,040h	; 60f4
	defb 03bh,040h	; 60f6
	defb 01dh,040h	; 60f8
	defb 01eh,040h	; 60fa
	defb 030h,045h	; 60fc
	defb 02fh,040h	; 60fe
	defb 02eh,040h	; 6100
	defb 02dh,040h	; 6102
	defb 01dh,040h	; 6104
	defb 040h,040h	; 6106
	defb 03fh,040h	; 6108
	defb 03eh,040h	; 610a
	defb 01dh,042h	; 610c
	defb 01ch,040h	; 610e
	defb 034h,040h	; 6110
	defb 033h,040h	; 6112
	defb 032h,040h	; 6114
	defb 031h,040h	; 6116
	defb 01eh,043h	; 6118
	defb 01bh,040h	; 611a
	defb 017h,040h	; 611c
	defb 016h,040h	; 611e
	defb 028h,045h	; 6120
	defb 027h,040h	; 6122
	defb 026h,040h	; 6124
	defb 025h,040h	; 6126
	defb 016h,040h	; 6128
	defb 017h,040h	; 612a
	defb 015h,040h	; 612c
	defb 014h,040h	; 612e
	defb 01ah,040h	; 6130
	defb 03dh,046h	; 6132
	defb 03ch,040h	; 6134
	defb 03bh,040h	; 6136
	defb 01dh,040h	; 6138
	defb 034h,040h	; 613a
	defb 033h,040h	; 613c
	defb 032h,040h	; 613e
	defb 031h,040h	; 6140
	defb 020h,043h	; 6142
	defb 01fh,040h	; 6144
	defb 01eh,040h	; 6146
	defb 03dh,046h	; 6148
	defb 03ch,040h	; 614a
	defb 03bh,040h	; 614c
	defb 01ch,040h	; 614e
	defb 011h,040h	; 6150
	defb 010h,040h	; 6152
	defb 00ah,040h	; 6154
	defb 009h,040h	; 6156
	defb 008h,040h	; 6158
	defb 007h,040h	; 615a
	defb 006h,040h	; 615c
	defb 003h,040h	; 615e
	defb 002h,040h	; 6160
	defb 005h,040h	; 6162
	defb 004h,040h	; 6164
	defb 003h,040h	; 6166
	defb 002h,040h	; 6168
	defb 0ffh	; 616a

; ----------------------------------------------------------------------
; DATOS circuito_02: secuencia del circuito de la carrera 2 (ENDURANCE): 160
;   pares (pieza, flags) y 0xFF; piezas hasta la 81, 160 con desplazamiento de
;   columna (bit 6)
;   0x616b..0x62ac  (321 bytes)
DATA_circuito_02:
	defb 003h,040h	; 616b
	defb 002h,040h	; 616d
	defb 001h,040h	; 616f
	defb 000h,040h	; 6171
	defb 013h,040h	; 6173
	defb 013h,040h	; 6175
	defb 013h,040h	; 6177
	defb 015h,040h	; 6179
	defb 018h,040h	; 617b
	defb 018h,040h	; 617d
	defb 01ah,040h	; 617f
	defb 019h,040h	; 6181
	defb 018h,040h	; 6183
	defb 017h,040h	; 6185
	defb 016h,040h	; 6187
	defb 018h,040h	; 6189
	defb 01ah,040h	; 618b
	defb 019h,040h	; 618d
	defb 016h,040h	; 618f
	defb 017h,040h	; 6191
	defb 016h,040h	; 6193
	defb 018h,040h	; 6195
	defb 017h,040h	; 6197
	defb 016h,040h	; 6199
	defb 014h,040h	; 619b
	defb 011h,040h	; 619d
	defb 010h,040h	; 619f
	defb 011h,040h	; 61a1
	defb 010h,040h	; 61a3
	defb 013h,040h	; 61a5
	defb 013h,040h	; 61a7
	defb 013h,040h	; 61a9
	defb 021h,040h	; 61ab
	defb 020h,040h	; 61ad
	defb 01fh,040h	; 61af
	defb 025h,040h	; 61b1
	defb 024h,040h	; 61b3
	defb 026h,040h	; 61b5
	defb 034h,040h	; 61b7
	defb 049h,045h	; 61b9
	defb 048h,040h	; 61bb
	defb 047h,040h	; 61bd
	defb 046h,040h	; 61bf
	defb 035h,040h	; 61c1
	defb 027h,040h	; 61c3
	defb 034h,040h	; 61c5
	defb 04dh,040h	; 61c7
	defb 04ch,040h	; 61c9
	defb 04bh,040h	; 61cb
	defb 04ah,040h	; 61cd
	defb 051h,043h	; 61cf
	defb 050h,040h	; 61d1
	defb 045h,043h	; 61d3
	defb 04fh,045h	; 61d5
	defb 04eh,040h	; 61d7
	defb 04fh,045h	; 61d9
	defb 04eh,040h	; 61db
	defb 049h,045h	; 61dd
	defb 048h,040h	; 61df
	defb 047h,040h	; 61e1
	defb 046h,040h	; 61e3
	defb 035h,040h	; 61e5
	defb 023h,040h	; 61e7
	defb 022h,040h	; 61e9
	defb 029h,040h	; 61eb
	defb 02bh,040h	; 61ed
	defb 02ah,040h	; 61ef
	defb 028h,040h	; 61f1
	defb 034h,040h	; 61f3
	defb 04dh,040h	; 61f5
	defb 04ch,040h	; 61f7
	defb 050h,040h	; 61f9
	defb 045h,043h	; 61fb
	defb 04fh,045h	; 61fd
	defb 04eh,040h	; 61ff
	defb 04fh,045h	; 6201
	defb 047h,040h	; 6203
	defb 046h,040h	; 6205
	defb 035h,040h	; 6207
	defb 026h,040h	; 6209
	defb 029h,040h	; 620b
	defb 030h,040h	; 620d
	defb 02fh,040h	; 620f
	defb 02eh,040h	; 6211
	defb 032h,040h	; 6213
	defb 02dh,040h	; 6215
	defb 02ch,040h	; 6217
	defb 033h,040h	; 6219
	defb 032h,040h	; 621b
	defb 032h,040h	; 621d
	defb 028h,040h	; 621f
	defb 027h,040h	; 6221
	defb 01eh,040h	; 6223
	defb 01dh,040h	; 6225
	defb 01ch,040h	; 6227
	defb 036h,040h	; 6229
	defb 03bh,045h	; 622b
	defb 03ah,040h	; 622d
	defb 040h,040h	; 622f
	defb 041h,045h	; 6231
	defb 039h,040h	; 6233
	defb 038h,040h	; 6235
	defb 044h,040h	; 6237
	defb 03fh,040h	; 6239
	defb 03eh,040h	; 623b
	defb 042h,040h	; 623d
	defb 044h,043h	; 623f
	defb 041h,045h	; 6241
	defb 040h,040h	; 6243
	defb 041h,045h	; 6245
	defb 039h,040h	; 6247
	defb 038h,040h	; 6249
	defb 037h,040h	; 624b
	defb 015h,040h	; 624d
	defb 018h,040h	; 624f
	defb 01ah,040h	; 6251
	defb 019h,040h	; 6253
	defb 014h,040h	; 6255
	defb 036h,040h	; 6257
	defb 03fh,040h	; 6259
	defb 03eh,040h	; 625b
	defb 03dh,040h	; 625d
	defb 03ch,040h	; 625f
	defb 037h,043h	; 6261
	defb 011h,040h	; 6263
	defb 010h,040h	; 6265
	defb 011h,040h	; 6267
	defb 036h,040h	; 6269
	defb 03bh,045h	; 626b
	defb 03ah,040h	; 626d
	defb 039h,040h	; 626f
	defb 038h,040h	; 6271
	defb 041h,045h	; 6273
	defb 040h,040h	; 6275
	defb 044h,040h	; 6277
	defb 03fh,040h	; 6279
	defb 03eh,040h	; 627b
	defb 042h,040h	; 627d
	defb 044h,043h	; 627f
	defb 041h,045h	; 6281
	defb 040h,040h	; 6283
	defb 041h,045h	; 6285
	defb 039h,040h	; 6287
	defb 038h,040h	; 6289
	defb 037h,040h	; 628b
	defb 00eh,040h	; 628d
	defb 00ch,040h	; 628f
	defb 00eh,040h	; 6291
	defb 00eh,040h	; 6293
	defb 00ch,040h	; 6295
	defb 00ch,040h	; 6297
	defb 00bh,040h	; 6299
	defb 00ah,040h	; 629b
	defb 009h,040h	; 629d
	defb 008h,040h	; 629f
	defb 004h,040h	; 62a1
	defb 007h,040h	; 62a3
	defb 006h,040h	; 62a5
	defb 005h,040h	; 62a7
	defb 004h,040h	; 62a9
	defb 0ffh	; 62ab

; ----------------------------------------------------------------------
; DATOS circuito_04: secuencia del circuito de la carrera 4 (F3000): 160 pares
;   (pieza, flags) y 0xFF; piezas hasta la 87, 160 con desplazamiento de
;   columna (bit 6)
;   0x62ac..0x63ed  (321 bytes)
DATA_circuito_04:
	defb 001h,040h	; 62ac
	defb 000h,040h	; 62ae
	defb 003h,040h	; 62b0
	defb 002h,040h	; 62b2
	defb 003h,040h	; 62b4
	defb 002h,040h	; 62b6
	defb 005h,040h	; 62b8
	defb 004h,040h	; 62ba
	defb 006h,040h	; 62bc
	defb 007h,040h	; 62be
	defb 006h,040h	; 62c0
	defb 005h,040h	; 62c2
	defb 004h,040h	; 62c4
	defb 00bh,040h	; 62c6
	defb 00ah,040h	; 62c8
	defb 00dh,040h	; 62ca
	defb 00ch,040h	; 62cc
	defb 00dh,040h	; 62ce
	defb 00ch,040h	; 62d0
	defb 012h,040h	; 62d2
	defb 013h,040h	; 62d4
	defb 012h,040h	; 62d6
	defb 011h,040h	; 62d8
	defb 010h,040h	; 62da
	defb 011h,040h	; 62dc
	defb 010h,040h	; 62de
	defb 015h,040h	; 62e0
	defb 014h,040h	; 62e2
	defb 011h,040h	; 62e4
	defb 010h,040h	; 62e6
	defb 015h,040h	; 62e8
	defb 014h,040h	; 62ea
	defb 04ah,047h	; 62ec
	defb 049h,040h	; 62ee
	defb 048h,040h	; 62f0
	defb 047h,040h	; 62f2
	defb 039h,045h	; 62f4
	defb 052h,041h	; 62f6
	defb 03ch,041h	; 62f8
	defb 051h,040h	; 62fa
	defb 050h,040h	; 62fc
	defb 028h,040h	; 62fe
	defb 02bh,041h	; 6300
	defb 03fh,040h	; 6302
	defb 057h,047h	; 6304
	defb 040h,046h	; 6306
	defb 029h,047h	; 6308
	defb 028h,040h	; 630a
	defb 02fh,047h	; 630c
	defb 044h,041h	; 630e
	defb 043h,040h	; 6310
	defb 03ah,040h	; 6312
	defb 03bh,043h	; 6314
	defb 035h,042h	; 6316
	defb 041h,045h	; 6318
	defb 040h,040h	; 631a
	defb 02eh,041h	; 631c
	defb 027h,046h	; 631e
	defb 026h,040h	; 6320
	defb 011h,040h	; 6322
	defb 010h,040h	; 6324
	defb 015h,040h	; 6326
	defb 014h,040h	; 6328
	defb 012h,040h	; 632a
	defb 013h,040h	; 632c
	defb 012h,040h	; 632e
	defb 00dh,040h	; 6330
	defb 00ch,040h	; 6332
	defb 00fh,040h	; 6334
	defb 00eh,040h	; 6336
	defb 00dh,040h	; 6338
	defb 00ch,040h	; 633a
	defb 011h,040h	; 633c
	defb 010h,040h	; 633e
	defb 015h,040h	; 6340
	defb 014h,040h	; 6342
	defb 011h,040h	; 6344
	defb 010h,040h	; 6346
	defb 015h,040h	; 6348
	defb 014h,040h	; 634a
	defb 039h,047h	; 634c
	defb 038h,040h	; 634e
	defb 035h,044h	; 6350
	defb 041h,045h	; 6352
	defb 040h,040h	; 6354
	defb 029h,047h	; 6356
	defb 031h,047h	; 6358
	defb 03fh,042h	; 635a
	defb 057h,047h	; 635c
	defb 042h,040h	; 635e
	defb 03eh,041h	; 6360
	defb 037h,047h	; 6362
	defb 03ch,041h	; 6364
	defb 051h,040h	; 6366
	defb 050h,040h	; 6368
	defb 031h,047h	; 636a
	defb 02ah,042h	; 636c
	defb 029h,044h	; 636e
	defb 031h,047h	; 6370
	defb 030h,040h	; 6372
	defb 055h,040h	; 6374
	defb 054h,040h	; 6376
	defb 03dh,041h	; 6378
	defb 036h,047h	; 637a
	defb 035h,044h	; 637c
	defb 041h,045h	; 637e
	defb 042h,042h	; 6380
	defb 057h,040h	; 6382
	defb 042h,040h	; 6384
	defb 057h,040h	; 6386
	defb 040h,046h	; 6388
	defb 029h,047h	; 638a
	defb 031h,047h	; 638c
	defb 03fh,042h	; 638e
	defb 03eh,040h	; 6390
	defb 03bh,041h	; 6392
	defb 035h,042h	; 6394
	defb 041h,045h	; 6396
	defb 042h,042h	; 6398
	defb 057h,040h	; 639a
	defb 03eh,041h	; 639c
	defb 037h,047h	; 639e
	defb 03ch,041h	; 63a0
	defb 051h,040h	; 63a2
	defb 050h,040h	; 63a4
	defb 031h,047h	; 63a6
	defb 03fh,042h	; 63a8
	defb 03eh,040h	; 63aa
	defb 037h,047h	; 63ac
	defb 03ch,041h	; 63ae
	defb 03dh,043h	; 63b0
	defb 046h,041h	; 63b2
	defb 045h,040h	; 63b4
	defb 031h,044h	; 63b6
	defb 04fh,040h	; 63b8
	defb 026h,040h	; 63ba
	defb 025h,040h	; 63bc
	defb 024h,040h	; 63be
	defb 023h,040h	; 63c0
	defb 022h,040h	; 63c2
	defb 023h,040h	; 63c4
	defb 022h,040h	; 63c6
	defb 021h,040h	; 63c8
	defb 020h,040h	; 63ca
	defb 01fh,040h	; 63cc
	defb 01eh,040h	; 63ce
	defb 01bh,040h	; 63d0
	defb 01ah,040h	; 63d2
	defb 01dh,040h	; 63d4
	defb 01ch,040h	; 63d6
	defb 01bh,040h	; 63d8
	defb 01ah,040h	; 63da
	defb 019h,040h	; 63dc
	defb 018h,040h	; 63de
	defb 017h,040h	; 63e0
	defb 016h,040h	; 63e2
	defb 009h,040h	; 63e4
	defb 008h,040h	; 63e6
	defb 003h,040h	; 63e8
	defb 002h,040h	; 63ea
	defb 0ffh	; 63ec

; ----------------------------------------------------------------------
; DATOS circuito_03: secuencia del circuito de la carrera 3 (F3): 140 pares
;   (pieza, flags) y 0xFF; piezas hasta la 87, 140 con desplazamiento de
;   columna (bit 6)
;   0x63ed..0x6506  (281 bytes)
DATA_circuito_03:
	defb 001h,040h	; 63ed
	defb 000h,040h	; 63ef
	defb 003h,040h	; 63f1
	defb 002h,040h	; 63f3
	defb 003h,040h	; 63f5
	defb 002h,040h	; 63f7
	defb 005h,040h	; 63f9
	defb 004h,040h	; 63fb
	defb 006h,040h	; 63fd
	defb 007h,040h	; 63ff
	defb 006h,040h	; 6401
	defb 005h,040h	; 6403
	defb 004h,040h	; 6405
	defb 00bh,040h	; 6407
	defb 00ah,040h	; 6409
	defb 00dh,040h	; 640b
	defb 00ch,040h	; 640d
	defb 00dh,040h	; 640f
	defb 00ch,040h	; 6411
	defb 012h,040h	; 6413
	defb 013h,040h	; 6415
	defb 012h,040h	; 6417
	defb 013h,040h	; 6419
	defb 012h,040h	; 641b
	defb 011h,040h	; 641d
	defb 010h,040h	; 641f
	defb 011h,040h	; 6421
	defb 010h,040h	; 6423
	defb 015h,040h	; 6425
	defb 014h,040h	; 6427
	defb 011h,040h	; 6429
	defb 010h,040h	; 642b
	defb 02dh,041h	; 642d
	defb 02ch,040h	; 642f
	defb 029h,044h	; 6431
	defb 028h,040h	; 6433
	defb 02fh,047h	; 6435
	defb 02eh,040h	; 6437
	defb 027h,046h	; 6439
	defb 026h,040h	; 643b
	defb 011h,040h	; 643d
	defb 010h,040h	; 643f
	defb 015h,040h	; 6441
	defb 014h,040h	; 6443
	defb 015h,040h	; 6445
	defb 014h,040h	; 6447
	defb 013h,040h	; 6449
	defb 012h,040h	; 644b
	defb 013h,040h	; 644d
	defb 039h,047h	; 644f
	defb 038h,040h	; 6451
	defb 035h,044h	; 6453
	defb 041h,045h	; 6455
	defb 040h,040h	; 6457
	defb 029h,047h	; 6459
	defb 031h,047h	; 645b
	defb 030h,040h	; 645d
	defb 055h,040h	; 645f
	defb 054h,040h	; 6461
	defb 03dh,041h	; 6463
	defb 036h,047h	; 6465
	defb 035h,044h	; 6467
	defb 041h,045h	; 6469
	defb 042h,042h	; 646b
	defb 042h,040h	; 646d
	defb 057h,040h	; 646f
	defb 042h,040h	; 6471
	defb 057h,040h	; 6473
	defb 040h,046h	; 6475
	defb 029h,047h	; 6477
	defb 028h,040h	; 6479
	defb 02fh,047h	; 647b
	defb 02eh,040h	; 647d
	defb 02bh,047h	; 647f
	defb 03fh,040h	; 6481
	defb 057h,047h	; 6483
	defb 042h,040h	; 6485
	defb 057h,040h	; 6487
	defb 042h,040h	; 6489
	defb 057h,040h	; 648b
	defb 042h,040h	; 648d
	defb 03eh,041h	; 648f
	defb 037h,047h	; 6491
	defb 03ch,041h	; 6493
	defb 051h,040h	; 6495
	defb 050h,040h	; 6497
	defb 031h,047h	; 6499
	defb 030h,040h	; 649b
	defb 028h,046h	; 649d
	defb 02bh,041h	; 649f
	defb 03fh,040h	; 64a1
	defb 03eh,040h	; 64a3
	defb 037h,047h	; 64a5
	defb 03ch,041h	; 64a7
	defb 034h,043h	; 64a9
	defb 033h,040h	; 64ab
	defb 032h,040h	; 64ad
	defb 00dh,040h	; 64af
	defb 00ch,040h	; 64b1
	defb 00fh,040h	; 64b3
	defb 00eh,040h	; 64b5
	defb 013h,040h	; 64b7
	defb 012h,040h	; 64b9
	defb 02dh,041h	; 64bb
	defb 02ch,040h	; 64bd
	defb 029h,044h	; 64bf
	defb 028h,040h	; 64c1
	defb 02fh,047h	; 64c3
	defb 02eh,040h	; 64c5
	defb 027h,046h	; 64c7
	defb 026h,040h	; 64c9
	defb 013h,040h	; 64cb
	defb 025h,040h	; 64cd
	defb 024h,040h	; 64cf
	defb 023h,040h	; 64d1
	defb 022h,040h	; 64d3
	defb 023h,040h	; 64d5
	defb 022h,040h	; 64d7
	defb 021h,040h	; 64d9
	defb 020h,040h	; 64db
	defb 01fh,040h	; 64dd
	defb 01eh,040h	; 64df
	defb 01dh,040h	; 64e1
	defb 01ch,040h	; 64e3
	defb 01bh,040h	; 64e5
	defb 01ah,040h	; 64e7
	defb 01dh,040h	; 64e9
	defb 01ch,040h	; 64eb
	defb 01bh,040h	; 64ed
	defb 01ah,040h	; 64ef
	defb 019h,040h	; 64f1
	defb 018h,040h	; 64f3
	defb 017h,040h	; 64f5
	defb 016h,040h	; 64f7
	defb 013h,040h	; 64f9
	defb 012h,040h	; 64fb
	defb 009h,040h	; 64fd
	defb 008h,040h	; 64ff
	defb 005h,040h	; 6501
	defb 004h,040h	; 6503
	defb 0ffh	; 6505

; ----------------------------------------------------------------------
; DATOS circuito_01: secuencia del circuito de la carrera 1 (STOCK): 128 pares
;   (pieza, flags) y 0xFF; piezas hasta la 52, 128 con desplazamiento de
;   columna (bit 6)
;   0x6506..0x6607  (257 bytes)
DATA_circuito_01:
	defb 001h,040h	; 6506
	defb 000h,040h	; 6508
	defb 007h,040h	; 650a
	defb 006h,040h	; 650c
	defb 003h,040h	; 650e
	defb 002h,040h	; 6510
	defb 007h,040h	; 6512
	defb 006h,040h	; 6514
	defb 005h,040h	; 6516
	defb 004h,040h	; 6518
	defb 005h,040h	; 651a
	defb 004h,040h	; 651c
	defb 007h,040h	; 651e
	defb 010h,040h	; 6520
	defb 013h,040h	; 6522
	defb 012h,040h	; 6524
	defb 014h,040h	; 6526
	defb 014h,040h	; 6528
	defb 012h,040h	; 652a
	defb 013h,040h	; 652c
	defb 015h,040h	; 652e
	defb 013h,040h	; 6530
	defb 012h,040h	; 6532
	defb 014h,040h	; 6534
	defb 014h,040h	; 6536
	defb 011h,040h	; 6538
	defb 005h,040h	; 653a
	defb 004h,040h	; 653c
	defb 003h,040h	; 653e
	defb 002h,040h	; 6540
	defb 007h,040h	; 6542
	defb 006h,040h	; 6544
	defb 00dh,040h	; 6546
	defb 026h,041h	; 6548
	defb 025h,040h	; 654a
	defb 022h,041h	; 654c
	defb 021h,040h	; 654e
	defb 023h,041h	; 6550
	defb 024h,043h	; 6552
	defb 020h,041h	; 6554
	defb 01fh,040h	; 6556
	defb 01eh,040h	; 6558
	defb 018h,046h	; 655a
	defb 01dh,046h	; 655c
	defb 01ch,040h	; 655e
	defb 017h,047h	; 6560
	defb 016h,040h	; 6562
	defb 00ch,040h	; 6564
	defb 00dh,040h	; 6566
	defb 026h,041h	; 6568
	defb 025h,040h	; 656a
	defb 022h,041h	; 656c
	defb 031h,040h	; 656e
	defb 01fh,042h	; 6570
	defb 01eh,040h	; 6572
	defb 018h,046h	; 6574
	defb 01dh,046h	; 6576
	defb 019h,047h	; 6578
	defb 034h,042h	; 657a
	defb 022h,041h	; 657c
	defb 031h,040h	; 657e
	defb 01fh,042h	; 6580
	defb 01eh,040h	; 6582
	defb 018h,046h	; 6584
	defb 017h,040h	; 6586
	defb 016h,040h	; 6588
	defb 00ch,040h	; 658a
	defb 007h,040h	; 658c
	defb 010h,040h	; 658e
	defb 013h,040h	; 6590
	defb 015h,040h	; 6592
	defb 011h,040h	; 6594
	defb 00dh,040h	; 6596
	defb 026h,041h	; 6598
	defb 025h,040h	; 659a
	defb 022h,041h	; 659c
	defb 021h,040h	; 659e
	defb 023h,041h	; 65a0
	defb 024h,043h	; 65a2
	defb 020h,041h	; 65a4
	defb 01fh,040h	; 65a6
	defb 01eh,040h	; 65a8
	defb 018h,046h	; 65aa
	defb 01bh,047h	; 65ac
	defb 02fh,047h	; 65ae
	defb 02eh,040h	; 65b0
	defb 01ah,046h	; 65b2
	defb 01ch,047h	; 65b4
	defb 017h,047h	; 65b6
	defb 016h,040h	; 65b8
	defb 00ch,040h	; 65ba
	defb 007h,040h	; 65bc
	defb 006h,040h	; 65be
	defb 005h,040h	; 65c0
	defb 004h,040h	; 65c2
	defb 00dh,040h	; 65c4
	defb 026h,041h	; 65c6
	defb 02dh,040h	; 65c8
	defb 023h,041h	; 65ca
	defb 02ch,047h	; 65cc
	defb 02bh,040h	; 65ce
	defb 01dh,047h	; 65d0
	defb 02ah,041h	; 65d2
	defb 016h,047h	; 65d4
	defb 00ch,040h	; 65d6
	defb 00dh,040h	; 65d8
	defb 029h,047h	; 65da
	defb 028h,040h	; 65dc
	defb 027h,040h	; 65de
	defb 01bh,046h	; 65e0
	defb 02fh,047h	; 65e2
	defb 018h,047h	; 65e4
	defb 017h,040h	; 65e6
	defb 016h,040h	; 65e8
	defb 00ch,040h	; 65ea
	defb 006h,040h	; 65ec
	defb 00fh,040h	; 65ee
	defb 00eh,040h	; 65f0
	defb 00fh,040h	; 65f2
	defb 00eh,040h	; 65f4
	defb 00bh,040h	; 65f6
	defb 00ah,040h	; 65f8
	defb 009h,040h	; 65fa
	defb 00ah,040h	; 65fc
	defb 009h,040h	; 65fe
	defb 00ah,040h	; 6600
	defb 009h,040h	; 6602
	defb 008h,040h	; 6604
	defb 0ffh	; 6606

; ----------------------------------------------------------------------
; DATOS circuito_05: secuencia del circuito de la carrera 5 (F1 ROUND 1): 160
;   pares (pieza, flags) y 0xFF; piezas hasta la 87, 160 con desplazamiento de
;   columna (bit 6)
;   0x6607..0x6748  (321 bytes)
DATA_circuito_05:
	defb 001h,040h	; 6607
	defb 000h,040h	; 6609
	defb 005h,040h	; 660b
	defb 003h,040h	; 660d
	defb 002h,040h	; 660f
	defb 003h,040h	; 6611
	defb 002h,040h	; 6613
	defb 005h,040h	; 6615
	defb 004h,040h	; 6617
	defb 007h,040h	; 6619
	defb 007h,040h	; 661b
	defb 007h,040h	; 661d
	defb 00bh,040h	; 661f
	defb 00ah,040h	; 6621
	defb 00fh,040h	; 6623
	defb 00eh,040h	; 6625
	defb 00dh,040h	; 6627
	defb 00ch,040h	; 6629
	defb 013h,040h	; 662b
	defb 012h,040h	; 662d
	defb 011h,040h	; 662f
	defb 010h,040h	; 6631
	defb 015h,040h	; 6633
	defb 014h,040h	; 6635
	defb 011h,040h	; 6637
	defb 010h,040h	; 6639
	defb 015h,040h	; 663b
	defb 014h,040h	; 663d
	defb 039h,047h	; 663f
	defb 038h,040h	; 6641
	defb 035h,044h	; 6643
	defb 041h,045h	; 6645
	defb 040h,040h	; 6647
	defb 029h,047h	; 6649
	defb 028h,040h	; 664b
	defb 02fh,047h	; 664d
	defb 02eh,040h	; 664f
	defb 02bh,047h	; 6651
	defb 03fh,040h	; 6653
	defb 057h,047h	; 6655
	defb 042h,040h	; 6657
	defb 057h,040h	; 6659
	defb 042h,040h	; 665b
	defb 057h,040h	; 665d
	defb 040h,046h	; 665f
	defb 029h,047h	; 6661
	defb 031h,047h	; 6663
	defb 030h,040h	; 6665
	defb 055h,040h	; 6667
	defb 054h,040h	; 6669
	defb 03dh,041h	; 666b
	defb 036h,047h	; 666d
	defb 035h,044h	; 666f
	defb 041h,045h	; 6671
	defb 042h,042h	; 6673
	defb 057h,040h	; 6675
	defb 042h,040h	; 6677
	defb 057h,040h	; 6679
	defb 042h,040h	; 667b
	defb 03eh,041h	; 667d
	defb 037h,047h	; 667f
	defb 036h,040h	; 6681
	defb 03ah,042h	; 6683
	defb 03bh,043h	; 6685
	defb 035h,042h	; 6687
	defb 041h,045h	; 6689
	defb 040h,040h	; 668b
	defb 029h,047h	; 668d
	defb 028h,040h	; 668f
	defb 02fh,047h	; 6691
	defb 044h,041h	; 6693
	defb 043h,040h	; 6695
	defb 03ah,040h	; 6697
	defb 033h,042h	; 6699
	defb 032h,040h	; 669b
	defb 011h,040h	; 669d
	defb 010h,040h	; 669f
	defb 015h,040h	; 66a1
	defb 014h,040h	; 66a3
	defb 013h,040h	; 66a5
	defb 012h,040h	; 66a7
	defb 00dh,040h	; 66a9
	defb 00ch,040h	; 66ab
	defb 013h,040h	; 66ad
	defb 012h,040h	; 66af
	defb 013h,040h	; 66b1
	defb 00dh,040h	; 66b3
	defb 00ch,040h	; 66b5
	defb 015h,040h	; 66b7
	defb 014h,040h	; 66b9
	defb 011h,040h	; 66bb
	defb 010h,040h	; 66bd
	defb 011h,040h	; 66bf
	defb 010h,040h	; 66c1
	defb 015h,040h	; 66c3
	defb 014h,040h	; 66c5
	defb 039h,047h	; 66c7
	defb 038h,040h	; 66c9
	defb 035h,044h	; 66cb
	defb 034h,040h	; 66cd
	defb 03bh,041h	; 66cf
	defb 03ah,040h	; 66d1
	defb 03bh,043h	; 66d3
	defb 035h,042h	; 66d5
	defb 041h,045h	; 66d7
	defb 057h,042h	; 66d9
	defb 042h,040h	; 66db
	defb 040h,046h	; 66dd
	defb 029h,047h	; 66df
	defb 031h,047h	; 66e1
	defb 030h,040h	; 66e3
	defb 055h,040h	; 66e5
	defb 054h,040h	; 66e7
	defb 03dh,041h	; 66e9
	defb 036h,047h	; 66eb
	defb 035h,044h	; 66ed
	defb 041h,045h	; 66ef
	defb 042h,042h	; 66f1
	defb 040h,046h	; 66f3
	defb 029h,047h	; 66f5
	defb 028h,040h	; 66f7
	defb 02fh,047h	; 66f9
	defb 044h,041h	; 66fb
	defb 043h,040h	; 66fd
	defb 03ah,040h	; 66ff
	defb 03bh,043h	; 6701
	defb 035h,042h	; 6703
	defb 041h,045h	; 6705
	defb 057h,042h	; 6707
	defb 042h,040h	; 6709
	defb 057h,040h	; 670b
	defb 03eh,041h	; 670d
	defb 037h,047h	; 670f
	defb 03ch,041h	; 6711
	defb 051h,040h	; 6713
	defb 050h,040h	; 6715
	defb 031h,047h	; 6717
	defb 04fh,040h	; 6719
	defb 026h,040h	; 671b
	defb 024h,040h	; 671d
	defb 025h,040h	; 671f
	defb 024h,040h	; 6721
	defb 023h,040h	; 6723
	defb 022h,040h	; 6725
	defb 021h,040h	; 6727
	defb 020h,040h	; 6729
	defb 01fh,040h	; 672b
	defb 01eh,040h	; 672d
	defb 01dh,040h	; 672f
	defb 01ch,040h	; 6731
	defb 01bh,040h	; 6733
	defb 01ah,040h	; 6735
	defb 019h,040h	; 6737
	defb 018h,040h	; 6739
	defb 017h,040h	; 673b
	defb 016h,040h	; 673d
	defb 009h,040h	; 673f
	defb 008h,040h	; 6741
	defb 005h,040h	; 6743
	defb 004h,040h	; 6745
	defb 0ffh	; 6747

; ----------------------------------------------------------------------
; DATOS circuito_06: secuencia del circuito de la carrera 6 (F1 ROUND 2): 136
;   pares (pieza, flags) y 0xFF; piezas hasta la 93, 136 con desplazamiento de
;   columna (bit 6)
;   0x6748..0x6859  (273 bytes)
DATA_circuito_06:
	defb 001h,040h	; 6748
	defb 000h,040h	; 674a
	defb 005h,040h	; 674c
	defb 004h,040h	; 674e
	defb 003h,040h	; 6750
	defb 002h,040h	; 6752
	defb 005h,040h	; 6754
	defb 004h,040h	; 6756
	defb 003h,040h	; 6758
	defb 002h,040h	; 675a
	defb 00bh,040h	; 675c
	defb 00ah,040h	; 675e
	defb 013h,040h	; 6760
	defb 012h,040h	; 6762
	defb 00dh,040h	; 6764
	defb 00ch,040h	; 6766
	defb 013h,040h	; 6768
	defb 012h,040h	; 676a
	defb 011h,040h	; 676c
	defb 010h,040h	; 676e
	defb 015h,040h	; 6770
	defb 014h,040h	; 6772
	defb 011h,040h	; 6774
	defb 010h,040h	; 6776
	defb 013h,040h	; 6778
	defb 012h,040h	; 677a
	defb 00fh,040h	; 677c
	defb 00eh,040h	; 677e
	defb 039h,047h	; 6780
	defb 038h,040h	; 6782
	defb 035h,044h	; 6784
	defb 034h,040h	; 6786
	defb 03bh,041h	; 6788
	defb 03ah,040h	; 678a
	defb 037h,041h	; 678c
	defb 036h,040h	; 678e
	defb 05bh,040h	; 6790
	defb 057h,042h	; 6792
	defb 042h,040h	; 6794
	defb 05ah,046h	; 6796
	defb 028h,040h	; 6798
	defb 02fh,047h	; 679a
	defb 02eh,040h	; 679c
	defb 05ch,040h	; 679e
	defb 036h,046h	; 67a0
	defb 03ah,042h	; 67a2
	defb 037h,041h	; 67a4
	defb 036h,040h	; 67a6
	defb 05bh,040h	; 67a8
	defb 042h,042h	; 67aa
	defb 057h,040h	; 67ac
	defb 042h,040h	; 67ae
	defb 040h,046h	; 67b0
	defb 029h,047h	; 67b2
	defb 031h,047h	; 67b4
	defb 030h,040h	; 67b6
	defb 028h,046h	; 67b8
	defb 05ch,042h	; 67ba
	defb 036h,046h	; 67bc
	defb 03ah,042h	; 67be
	defb 03bh,043h	; 67c0
	defb 035h,042h	; 67c2
	defb 041h,045h	; 67c4
	defb 057h,042h	; 67c6
	defb 042h,040h	; 67c8
	defb 03eh,041h	; 67ca
	defb 037h,047h	; 67cc
	defb 03ch,041h	; 67ce
	defb 03dh,043h	; 67d0
	defb 036h,047h	; 67d2
	defb 05dh,040h	; 67d4
	defb 028h,040h	; 67d6
	defb 02fh,047h	; 67d8
	defb 029h,046h	; 67da
	defb 028h,040h	; 67dc
	defb 027h,040h	; 67de
	defb 026h,040h	; 67e0
	defb 012h,040h	; 67e2
	defb 00fh,040h	; 67e4
	defb 00eh,040h	; 67e6
	defb 04ah,047h	; 67e8
	defb 049h,040h	; 67ea
	defb 048h,040h	; 67ec
	defb 047h,040h	; 67ee
	defb 039h,045h	; 67f0
	defb 038h,040h	; 67f2
	defb 05bh,040h	; 67f4
	defb 042h,042h	; 67f6
	defb 057h,040h	; 67f8
	defb 042h,040h	; 67fa
	defb 05ah,046h	; 67fc
	defb 031h,047h	; 67fe
	defb 030h,040h	; 6800
	defb 028h,046h	; 6802
	defb 059h,042h	; 6804
	defb 058h,040h	; 6806
	defb 03ch,047h	; 6808
	defb 03dh,043h	; 680a
	defb 036h,047h	; 680c
	defb 05bh,040h	; 680e
	defb 057h,042h	; 6810
	defb 042h,040h	; 6812
	defb 042h,040h	; 6814
	defb 057h,040h	; 6816
	defb 057h,040h	; 6818
	defb 042h,040h	; 681a
	defb 042h,040h	; 681c
	defb 057h,040h	; 681e
	defb 05ah,046h	; 6820
	defb 028h,040h	; 6822
	defb 02fh,047h	; 6824
	defb 044h,041h	; 6826
	defb 043h,040h	; 6828
	defb 03ah,040h	; 682a
	defb 033h,042h	; 682c
	defb 032h,040h	; 682e
	defb 025h,040h	; 6830
	defb 024h,040h	; 6832
	defb 023h,040h	; 6834
	defb 022h,040h	; 6836
	defb 021h,040h	; 6838
	defb 020h,040h	; 683a
	defb 01fh,040h	; 683c
	defb 01eh,040h	; 683e
	defb 01dh,040h	; 6840
	defb 01ch,040h	; 6842
	defb 01bh,040h	; 6844
	defb 01ah,040h	; 6846
	defb 019h,040h	; 6848
	defb 018h,040h	; 684a
	defb 017h,040h	; 684c
	defb 016h,040h	; 684e
	defb 009h,040h	; 6850
	defb 008h,040h	; 6852
	defb 005h,040h	; 6854
	defb 004h,040h	; 6856
	defb 0ffh	; 6858

; ----------------------------------------------------------------------
; DATOS circuito_07: secuencia del circuito de la carrera 7 (F1 ROUND 3): 140
;   pares (pieza, flags) y 0xFF; piezas hasta la 99, 140 con desplazamiento de
;   columna (bit 6)
;   0x6859..0x6972  (281 bytes)
DATA_circuito_07:
	defb 001h,040h	; 6859
	defb 000h,040h	; 685b
	defb 003h,040h	; 685d
	defb 002h,040h	; 685f
	defb 004h,040h	; 6861
	defb 00bh,040h	; 6863
	defb 00ah,040h	; 6865
	defb 039h,047h	; 6867
	defb 038h,040h	; 6869
	defb 03ah,042h	; 686b
	defb 03bh,043h	; 686d
	defb 05dh,046h	; 686f
	defb 028h,040h	; 6871
	defb 02fh,047h	; 6873
	defb 02eh,040h	; 6875
	defb 027h,046h	; 6877
	defb 026h,040h	; 6879
	defb 025h,040h	; 687b
	defb 024h,040h	; 687d
	defb 023h,040h	; 687f
	defb 022h,040h	; 6881
	defb 021h,040h	; 6883
	defb 020h,040h	; 6885
	defb 01fh,040h	; 6887
	defb 01eh,040h	; 6889
	defb 01dh,040h	; 688b
	defb 01ch,040h	; 688d
	defb 01bh,040h	; 688f
	defb 01ah,040h	; 6891
	defb 019h,040h	; 6893
	defb 018h,040h	; 6895
	defb 017h,040h	; 6897
	defb 016h,040h	; 6899
	defb 013h,040h	; 689b
	defb 009h,040h	; 689d
	defb 008h,040h	; 689f
	defb 003h,040h	; 68a1
	defb 002h,040h	; 68a3
	defb 005h,040h	; 68a5
	defb 004h,040h	; 68a7
	defb 003h,040h	; 68a9
	defb 002h,040h	; 68ab
	defb 007h,040h	; 68ad
	defb 006h,040h	; 68af
	defb 00bh,040h	; 68b1
	defb 00ah,040h	; 68b3
	defb 013h,040h	; 68b5
	defb 012h,040h	; 68b7
	defb 00dh,040h	; 68b9
	defb 00ch,040h	; 68bb
	defb 013h,040h	; 68bd
	defb 012h,040h	; 68bf
	defb 013h,040h	; 68c1
	defb 015h,040h	; 68c3
	defb 014h,040h	; 68c5
	defb 00fh,040h	; 68c7
	defb 00eh,040h	; 68c9
	defb 015h,040h	; 68cb
	defb 014h,040h	; 68cd
	defb 015h,040h	; 68cf
	defb 014h,040h	; 68d1
	defb 011h,040h	; 68d3
	defb 010h,040h	; 68d5
	defb 011h,040h	; 68d7
	defb 010h,040h	; 68d9
	defb 011h,040h	; 68db
	defb 010h,040h	; 68dd
	defb 015h,040h	; 68df
	defb 014h,040h	; 68e1
	defb 02dh,041h	; 68e3
	defb 02ch,040h	; 68e5
	defb 02eh,046h	; 68e7
	defb 05ch,040h	; 68e9
	defb 03ch,047h	; 68eb
	defb 041h,040h	; 68ed
	defb 040h,040h	; 68ef
	defb 029h,047h	; 68f1
	defb 028h,040h	; 68f3
	defb 059h,042h	; 68f5
	defb 057h,047h	; 68f7
	defb 03eh,041h	; 68f9
	defb 037h,047h	; 68fb
	defb 03ch,041h	; 68fd
	defb 03dh,043h	; 68ff
	defb 063h,042h	; 6901
	defb 062h,040h	; 6903
	defb 061h,040h	; 6905
	defb 030h,046h	; 6907
	defb 028h,046h	; 6909
	defb 059h,042h	; 690b
	defb 042h,047h	; 690d
	defb 057h,040h	; 690f
	defb 042h,040h	; 6911
	defb 040h,046h	; 6913
	defb 029h,047h	; 6915
	defb 031h,047h	; 6917
	defb 030h,040h	; 6919
	defb 055h,040h	; 691b
	defb 054h,040h	; 691d
	defb 03dh,041h	; 691f
	defb 036h,047h	; 6921
	defb 035h,044h	; 6923
	defb 041h,045h	; 6925
	defb 040h,040h	; 6927
	defb 029h,047h	; 6929
	defb 031h,047h	; 692b
	defb 030h,040h	; 692d
	defb 028h,046h	; 692f
	defb 05ch,042h	; 6931
	defb 03ch,047h	; 6933
	defb 03dh,043h	; 6935
	defb 046h,041h	; 6937
	defb 045h,040h	; 6939
	defb 031h,044h	; 693b
	defb 03fh,042h	; 693d
	defb 057h,047h	; 693f
	defb 042h,040h	; 6941
	defb 057h,040h	; 6943
	defb 040h,046h	; 6945
	defb 029h,047h	; 6947
	defb 031h,047h	; 6949
	defb 030h,040h	; 694b
	defb 028h,046h	; 694d
	defb 027h,040h	; 694f
	defb 026h,040h	; 6951
	defb 012h,040h	; 6953
	defb 013h,040h	; 6955
	defb 012h,040h	; 6957
	defb 04eh,042h	; 6959
	defb 04dh,040h	; 695b
	defb 04ch,040h	; 695d
	defb 04bh,040h	; 695f
	defb 04ah,040h	; 6961
	defb 049h,040h	; 6963
	defb 048h,040h	; 6965
	defb 047h,040h	; 6967
	defb 00fh,046h	; 6969
	defb 00eh,040h	; 696b
	defb 009h,040h	; 696d
	defb 008h,040h	; 696f
	defb 0ffh	; 6971

; ----------------------------------------------------------------------
; DATOS circuito_08: secuencia del circuito de la carrera 8 (F1 ROUND 4): 124
;   pares (pieza, flags) y 0xFF; piezas hasta la 68, 124 con desplazamiento de
;   columna (bit 6)
;   0x6972..0x6a6b  (249 bytes)
DATA_circuito_08:
	defb 003h,040h	; 6972
	defb 002h,040h	; 6974
	defb 001h,040h	; 6976
	defb 000h,040h	; 6978
	defb 013h,040h	; 697a
	defb 013h,040h	; 697c
	defb 011h,040h	; 697e
	defb 012h,040h	; 6980
	defb 012h,040h	; 6982
	defb 036h,040h	; 6984
	defb 03bh,045h	; 6986
	defb 03ah,040h	; 6988
	defb 040h,040h	; 698a
	defb 037h,040h	; 698c
	defb 012h,040h	; 698e
	defb 012h,040h	; 6990
	defb 031h,040h	; 6992
	defb 012h,040h	; 6994
	defb 031h,040h	; 6996
	defb 015h,040h	; 6998
	defb 01bh,040h	; 699a
	defb 01bh,040h	; 699c
	defb 01bh,040h	; 699e
	defb 016h,040h	; 69a0
	defb 016h,040h	; 69a2
	defb 01bh,040h	; 69a4
	defb 016h,040h	; 69a6
	defb 01bh,040h	; 69a8
	defb 01bh,040h	; 69aa
	defb 016h,040h	; 69ac
	defb 016h,040h	; 69ae
	defb 014h,040h	; 69b0
	defb 031h,040h	; 69b2
	defb 012h,040h	; 69b4
	defb 011h,040h	; 69b6
	defb 011h,040h	; 69b8
	defb 011h,040h	; 69ba
	defb 012h,040h	; 69bc
	defb 011h,040h	; 69be
	defb 011h,040h	; 69c0
	defb 012h,040h	; 69c2
	defb 036h,040h	; 69c4
	defb 03bh,045h	; 69c6
	defb 03ah,040h	; 69c8
	defb 040h,040h	; 69ca
	defb 044h,040h	; 69cc
	defb 03fh,040h	; 69ce
	defb 03eh,040h	; 69d0
	defb 042h,040h	; 69d2
	defb 037h,043h	; 69d4
	defb 031h,040h	; 69d6
	defb 031h,040h	; 69d8
	defb 036h,040h	; 69da
	defb 041h,045h	; 69dc
	defb 040h,040h	; 69de
	defb 044h,040h	; 69e0
	defb 043h,040h	; 69e2
	defb 042h,040h	; 69e4
	defb 037h,043h	; 69e6
	defb 036h,040h	; 69e8
	defb 041h,045h	; 69ea
	defb 039h,040h	; 69ec
	defb 038h,040h	; 69ee
	defb 037h,040h	; 69f0
	defb 036h,040h	; 69f2
	defb 03bh,045h	; 69f4
	defb 03ah,040h	; 69f6
	defb 040h,040h	; 69f8
	defb 041h,045h	; 69fa
	defb 039h,040h	; 69fc
	defb 038h,040h	; 69fe
	defb 037h,040h	; 6a00
	defb 031h,040h	; 6a02
	defb 012h,040h	; 6a04
	defb 015h,040h	; 6a06
	defb 016h,040h	; 6a08
	defb 01bh,040h	; 6a0a
	defb 016h,040h	; 6a0c
	defb 016h,040h	; 6a0e
	defb 01bh,040h	; 6a10
	defb 016h,040h	; 6a12
	defb 01bh,040h	; 6a14
	defb 016h,040h	; 6a16
	defb 014h,040h	; 6a18
	defb 012h,040h	; 6a1a
	defb 036h,040h	; 6a1c
	defb 043h,040h	; 6a1e
	defb 042h,040h	; 6a20
	defb 037h,043h	; 6a22
	defb 036h,040h	; 6a24
	defb 041h,045h	; 6a26
	defb 039h,040h	; 6a28
	defb 038h,040h	; 6a2a
	defb 037h,040h	; 6a2c
	defb 036h,040h	; 6a2e
	defb 03fh,040h	; 6a30
	defb 03eh,040h	; 6a32
	defb 042h,040h	; 6a34
	defb 037h,043h	; 6a36
	defb 036h,040h	; 6a38
	defb 041h,045h	; 6a3a
	defb 040h,040h	; 6a3c
	defb 044h,040h	; 6a3e
	defb 03fh,040h	; 6a40
	defb 03eh,040h	; 6a42
	defb 042h,040h	; 6a44
	defb 044h,043h	; 6a46
	defb 041h,045h	; 6a48
	defb 040h,040h	; 6a4a
	defb 037h,040h	; 6a4c
	defb 00fh,040h	; 6a4e
	defb 00fh,040h	; 6a50
	defb 00dh,040h	; 6a52
	defb 00bh,040h	; 6a54
	defb 00ah,040h	; 6a56
	defb 009h,040h	; 6a58
	defb 008h,040h	; 6a5a
	defb 004h,040h	; 6a5c
	defb 007h,040h	; 6a5e
	defb 006h,040h	; 6a60
	defb 007h,040h	; 6a62
	defb 006h,040h	; 6a64
	defb 005h,040h	; 6a66
	defb 004h,040h	; 6a68
	defb 0ffh	; 6a6a

; ----------------------------------------------------------------------
; DATOS circuito_09: secuencia del circuito de la carrera 9 (F1 ROUND 5): 136
;   pares (pieza, flags) y 0xFF; piezas hasta la 55, 136 con desplazamiento de
;   columna (bit 6)
;   0x6a6b..0x6b7c  (273 bytes)
DATA_circuito_09:
	defb 001h,040h	; 6a6b
	defb 000h,040h	; 6a6d
	defb 007h,040h	; 6a6f
	defb 006h,040h	; 6a71
	defb 003h,040h	; 6a73
	defb 002h,040h	; 6a75
	defb 003h,040h	; 6a77
	defb 002h,040h	; 6a79
	defb 007h,040h	; 6a7b
	defb 006h,040h	; 6a7d
	defb 005h,040h	; 6a7f
	defb 004h,040h	; 6a81
	defb 010h,040h	; 6a83
	defb 013h,040h	; 6a85
	defb 012h,040h	; 6a87
	defb 014h,040h	; 6a89
	defb 014h,040h	; 6a8b
	defb 012h,040h	; 6a8d
	defb 013h,040h	; 6a8f
	defb 015h,040h	; 6a91
	defb 013h,040h	; 6a93
	defb 012h,040h	; 6a95
	defb 014h,040h	; 6a97
	defb 014h,040h	; 6a99
	defb 014h,040h	; 6a9b
	defb 014h,040h	; 6a9d
	defb 011h,040h	; 6a9f
	defb 003h,040h	; 6aa1
	defb 002h,040h	; 6aa3
	defb 007h,040h	; 6aa5
	defb 006h,040h	; 6aa7
	defb 00dh,040h	; 6aa9
	defb 029h,047h	; 6aab
	defb 028h,040h	; 6aad
	defb 027h,040h	; 6aaf
	defb 01dh,045h	; 6ab1
	defb 019h,047h	; 6ab3
	defb 034h,042h	; 6ab5
	defb 022h,041h	; 6ab7
	defb 031h,040h	; 6ab9
	defb 01fh,042h	; 6abb
	defb 036h,040h	; 6abd
	defb 030h,040h	; 6abf
	defb 030h,040h	; 6ac1
	defb 035h,040h	; 6ac3
	defb 022h,041h	; 6ac5
	defb 031h,040h	; 6ac7
	defb 01fh,042h	; 6ac9
	defb 036h,040h	; 6acb
	defb 030h,040h	; 6acd
	defb 037h,040h	; 6acf
	defb 02eh,047h	; 6ad1
	defb 02fh,045h	; 6ad3
	defb 018h,047h	; 6ad5
	defb 017h,040h	; 6ad7
	defb 016h,040h	; 6ad9
	defb 00ch,040h	; 6adb
	defb 00dh,040h	; 6add
	defb 026h,041h	; 6adf
	defb 025h,040h	; 6ae1
	defb 022h,041h	; 6ae3
	defb 031h,040h	; 6ae5
	defb 01fh,042h	; 6ae7
	defb 01eh,040h	; 6ae9
	defb 018h,046h	; 6aeb
	defb 01dh,046h	; 6aed
	defb 01ch,040h	; 6aef
	defb 017h,047h	; 6af1
	defb 016h,040h	; 6af3
	defb 00ch,040h	; 6af5
	defb 00dh,040h	; 6af7
	defb 026h,041h	; 6af9
	defb 025h,040h	; 6afb
	defb 024h,042h	; 6afd
	defb 023h,040h	; 6aff
	defb 033h,041h	; 6b01
	defb 032h,040h	; 6b03
	defb 00ch,040h	; 6b05
	defb 010h,040h	; 6b07
	defb 015h,040h	; 6b09
	defb 011h,040h	; 6b0b
	defb 00dh,040h	; 6b0d
	defb 026h,041h	; 6b0f
	defb 02dh,040h	; 6b11
	defb 023h,041h	; 6b13
	defb 02ch,047h	; 6b15
	defb 02bh,040h	; 6b17
	defb 01dh,047h	; 6b19
	defb 02ah,041h	; 6b1b
	defb 016h,047h	; 6b1d
	defb 00ch,040h	; 6b1f
	defb 00dh,040h	; 6b21
	defb 029h,047h	; 6b23
	defb 028h,040h	; 6b25
	defb 027h,040h	; 6b27
	defb 01dh,045h	; 6b29
	defb 019h,047h	; 6b2b
	defb 034h,042h	; 6b2d
	defb 024h,042h	; 6b2f
	defb 023h,040h	; 6b31
	defb 036h,041h	; 6b33
	defb 037h,040h	; 6b35
	defb 02eh,047h	; 6b37
	defb 02fh,045h	; 6b39
	defb 034h,041h	; 6b3b
	defb 024h,042h	; 6b3d
	defb 020h,041h	; 6b3f
	defb 01fh,040h	; 6b41
	defb 033h,040h	; 6b43
	defb 032h,040h	; 6b45
	defb 00ch,040h	; 6b47
	defb 007h,040h	; 6b49
	defb 006h,040h	; 6b4b
	defb 010h,040h	; 6b4d
	defb 015h,040h	; 6b4f
	defb 011h,040h	; 6b51
	defb 00dh,040h	; 6b53
	defb 029h,047h	; 6b55
	defb 028h,040h	; 6b57
	defb 027h,040h	; 6b59
	defb 01dh,045h	; 6b5b
	defb 01ch,040h	; 6b5d
	defb 017h,047h	; 6b5f
	defb 016h,040h	; 6b61
	defb 00ch,040h	; 6b63
	defb 006h,040h	; 6b65
	defb 00fh,040h	; 6b67
	defb 00eh,040h	; 6b69
	defb 00bh,040h	; 6b6b
	defb 00ah,040h	; 6b6d
	defb 009h,040h	; 6b6f
	defb 00ah,040h	; 6b71
	defb 009h,040h	; 6b73
	defb 00ah,040h	; 6b75
	defb 009h,040h	; 6b77
	defb 008h,040h	; 6b79
	defb 0ffh	; 6b7b

; ----------------------------------------------------------------------
; DATOS circuito_10: secuencia del circuito de la carrera 10 (F1 ROUND 6): 120
;   pares (pieza, flags) y 0xFF; piezas hasta la 102, 120 con desplazamiento
;   de columna (bit 6)
;   0x6b7c..0x6c6d  (241 bytes)
DATA_circuito_10:
	defb 001h,040h	; 6b7c
	defb 066h,040h	; 6b7e
	defb 00bh,040h	; 6b80
	defb 00ah,040h	; 6b82
	defb 025h,040h	; 6b84
	defb 024h,040h	; 6b86
	defb 023h,040h	; 6b88
	defb 022h,040h	; 6b8a
	defb 021h,040h	; 6b8c
	defb 020h,040h	; 6b8e
	defb 01fh,040h	; 6b90
	defb 01eh,040h	; 6b92
	defb 01dh,040h	; 6b94
	defb 01ch,040h	; 6b96
	defb 01bh,040h	; 6b98
	defb 01ah,040h	; 6b9a
	defb 019h,040h	; 6b9c
	defb 018h,040h	; 6b9e
	defb 017h,040h	; 6ba0
	defb 016h,040h	; 6ba2
	defb 013h,040h	; 6ba4
	defb 00fh,040h	; 6ba6
	defb 00eh,040h	; 6ba8
	defb 012h,040h	; 6baa
	defb 02dh,041h	; 6bac
	defb 02ch,040h	; 6bae
	defb 02eh,046h	; 6bb0
	defb 05ch,040h	; 6bb2
	defb 03ch,047h	; 6bb4
	defb 041h,040h	; 6bb6
	defb 040h,040h	; 6bb8
	defb 02eh,041h	; 6bba
	defb 027h,046h	; 6bbc
	defb 026h,040h	; 6bbe
	defb 009h,040h	; 6bc0
	defb 008h,040h	; 6bc2
	defb 003h,040h	; 6bc4
	defb 002h,040h	; 6bc6
	defb 00bh,040h	; 6bc8
	defb 00ah,040h	; 6bca
	defb 00dh,040h	; 6bcc
	defb 00ch,040h	; 6bce
	defb 013h,040h	; 6bd0
	defb 012h,040h	; 6bd2
	defb 015h,040h	; 6bd4
	defb 014h,040h	; 6bd6
	defb 00fh,040h	; 6bd8
	defb 00fh,040h	; 6bda
	defb 015h,040h	; 6bdc
	defb 014h,040h	; 6bde
	defb 011h,040h	; 6be0
	defb 010h,040h	; 6be2
	defb 00fh,040h	; 6be4
	defb 00eh,040h	; 6be6
	defb 011h,040h	; 6be8
	defb 010h,040h	; 6bea
	defb 011h,040h	; 6bec
	defb 010h,040h	; 6bee
	defb 00fh,040h	; 6bf0
	defb 00fh,040h	; 6bf2
	defb 015h,040h	; 6bf4
	defb 014h,040h	; 6bf6
	defb 011h,040h	; 6bf8
	defb 010h,040h	; 6bfa
	defb 00fh,040h	; 6bfc
	defb 00fh,040h	; 6bfe
	defb 011h,040h	; 6c00
	defb 010h,040h	; 6c02
	defb 015h,040h	; 6c04
	defb 014h,040h	; 6c06
	defb 011h,040h	; 6c08
	defb 010h,040h	; 6c0a
	defb 015h,040h	; 6c0c
	defb 014h,040h	; 6c0e
	defb 011h,040h	; 6c10
	defb 010h,040h	; 6c12
	defb 011h,040h	; 6c14
	defb 010h,040h	; 6c16
	defb 015h,040h	; 6c18
	defb 014h,040h	; 6c1a
	defb 039h,047h	; 6c1c
	defb 038h,040h	; 6c1e
	defb 03ah,042h	; 6c20
	defb 03bh,043h	; 6c22
	defb 05dh,046h	; 6c24
	defb 028h,040h	; 6c26
	defb 02fh,047h	; 6c28
	defb 02eh,040h	; 6c2a
	defb 02bh,047h	; 6c2c
	defb 03fh,040h	; 6c2e
	defb 057h,047h	; 6c30
	defb 05ah,046h	; 6c32
	defb 028h,040h	; 6c34
	defb 02fh,047h	; 6c36
	defb 044h,041h	; 6c38
	defb 043h,040h	; 6c3a
	defb 03ah,040h	; 6c3c
	defb 03bh,043h	; 6c3e
	defb 05dh,046h	; 6c40
	defb 028h,040h	; 6c42
	defb 02fh,047h	; 6c44
	defb 060h,047h	; 6c46
	defb 05fh,040h	; 6c48
	defb 05eh,040h	; 6c4a
	defb 03bh,042h	; 6c4c
	defb 035h,042h	; 6c4e
	defb 041h,045h	; 6c50
	defb 040h,040h	; 6c52
	defb 02eh,041h	; 6c54
	defb 027h,046h	; 6c56
	defb 026h,040h	; 6c58
	defb 00fh,040h	; 6c5a
	defb 00fh,040h	; 6c5c
	defb 00eh,040h	; 6c5e
	defb 012h,040h	; 6c60
	defb 009h,040h	; 6c62
	defb 008h,040h	; 6c64
	defb 006h,040h	; 6c66
	defb 003h,040h	; 6c68
	defb 002h,040h	; 6c6a
	defb 0ffh	; 6c6c

; ----------------------------------------------------------------------
; DATOS circuito_11: secuencia del circuito de la carrera 11 (F1 ROUND 7): 128
;   pares (pieza, flags) y 0xFF; piezas hasta la 101, 128 con desplazamiento
;   de columna (bit 6)
;   0x6c6d..0x6d6e  (257 bytes)
DATA_circuito_11:
	defb 065h,040h	; 6c6d
	defb 064h,040h	; 6c6f
	defb 023h,040h	; 6c71
	defb 022h,040h	; 6c73
	defb 023h,040h	; 6c75
	defb 022h,040h	; 6c77
	defb 021h,040h	; 6c79
	defb 020h,040h	; 6c7b
	defb 01fh,040h	; 6c7d
	defb 01eh,040h	; 6c7f
	defb 01bh,040h	; 6c81
	defb 01ah,040h	; 6c83
	defb 019h,040h	; 6c85
	defb 018h,040h	; 6c87
	defb 017h,040h	; 6c89
	defb 016h,040h	; 6c8b
	defb 02dh,041h	; 6c8d
	defb 02ch,040h	; 6c8f
	defb 02eh,046h	; 6c91
	defb 027h,046h	; 6c93
	defb 026h,040h	; 6c95
	defb 009h,040h	; 6c97
	defb 008h,040h	; 6c99
	defb 005h,040h	; 6c9b
	defb 00bh,040h	; 6c9d
	defb 00ah,040h	; 6c9f
	defb 015h,040h	; 6ca1
	defb 014h,040h	; 6ca3
	defb 00fh,040h	; 6ca5
	defb 00fh,040h	; 6ca7
	defb 011h,040h	; 6ca9
	defb 010h,040h	; 6cab
	defb 015h,040h	; 6cad
	defb 014h,040h	; 6caf
	defb 00fh,040h	; 6cb1
	defb 00fh,040h	; 6cb3
	defb 011h,040h	; 6cb5
	defb 010h,040h	; 6cb7
	defb 011h,040h	; 6cb9
	defb 010h,040h	; 6cbb
	defb 011h,040h	; 6cbd
	defb 010h,040h	; 6cbf
	defb 00fh,040h	; 6cc1
	defb 00fh,040h	; 6cc3
	defb 011h,040h	; 6cc5
	defb 010h,040h	; 6cc7
	defb 015h,040h	; 6cc9
	defb 014h,040h	; 6ccb
	defb 039h,047h	; 6ccd
	defb 052h,041h	; 6ccf
	defb 03ch,041h	; 6cd1
	defb 03dh,043h	; 6cd3
	defb 063h,042h	; 6cd5
	defb 062h,040h	; 6cd7
	defb 061h,040h	; 6cd9
	defb 030h,046h	; 6cdb
	defb 028h,046h	; 6cdd
	defb 059h,042h	; 6cdf
	defb 057h,047h	; 6ce1
	defb 057h,040h	; 6ce3
	defb 042h,040h	; 6ce5
	defb 042h,040h	; 6ce7
	defb 057h,040h	; 6ce9
	defb 057h,040h	; 6ceb
	defb 042h,040h	; 6ced
	defb 057h,040h	; 6cef
	defb 042h,040h	; 6cf1
	defb 042h,040h	; 6cf3
	defb 057h,040h	; 6cf5
	defb 042h,040h	; 6cf7
	defb 03eh,041h	; 6cf9
	defb 037h,047h	; 6cfb
	defb 03ch,041h	; 6cfd
	defb 051h,040h	; 6cff
	defb 050h,040h	; 6d01
	defb 031h,047h	; 6d03
	defb 030h,040h	; 6d05
	defb 028h,046h	; 6d07
	defb 059h,042h	; 6d09
	defb 057h,047h	; 6d0b
	defb 042h,040h	; 6d0d
	defb 042h,040h	; 6d0f
	defb 057h,040h	; 6d11
	defb 042h,040h	; 6d13
	defb 042h,040h	; 6d15
	defb 05ah,046h	; 6d17
	defb 031h,047h	; 6d19
	defb 030h,040h	; 6d1b
	defb 028h,046h	; 6d1d
	defb 027h,040h	; 6d1f
	defb 026h,040h	; 6d21
	defb 015h,040h	; 6d23
	defb 014h,040h	; 6d25
	defb 011h,040h	; 6d27
	defb 010h,040h	; 6d29
	defb 015h,040h	; 6d2b
	defb 014h,040h	; 6d2d
	defb 010h,040h	; 6d2f
	defb 011h,040h	; 6d31
	defb 013h,040h	; 6d33
	defb 012h,040h	; 6d35
	defb 00dh,040h	; 6d37
	defb 00ch,040h	; 6d39
	defb 012h,040h	; 6d3b
	defb 013h,040h	; 6d3d
	defb 00eh,040h	; 6d3f
	defb 013h,040h	; 6d41
	defb 012h,040h	; 6d43
	defb 04eh,042h	; 6d45
	defb 04dh,040h	; 6d47
	defb 04ch,040h	; 6d49
	defb 04bh,040h	; 6d4b
	defb 02dh,042h	; 6d4d
	defb 056h,046h	; 6d4f
	defb 030h,047h	; 6d51
	defb 031h,045h	; 6d53
	defb 04fh,040h	; 6d55
	defb 026h,040h	; 6d57
	defb 009h,040h	; 6d59
	defb 008h,040h	; 6d5b
	defb 003h,040h	; 6d5d
	defb 002h,040h	; 6d5f
	defb 005h,040h	; 6d61
	defb 004h,040h	; 6d63
	defb 003h,040h	; 6d65
	defb 002h,040h	; 6d67
	defb 00bh,040h	; 6d69
	defb 00ah,040h	; 6d6b
	defb 0ffh	; 6d6d

; ----------------------------------------------------------------------
; DATOS circuito_12: secuencia del circuito de la carrera 12 (F1 ROUND 8): 144
;   pares (pieza, flags) y 0xFF; piezas hasta la 96, 144 con desplazamiento de
;   columna (bit 6)
;   0x6d6e..0x6e8f  (289 bytes)
DATA_circuito_12:
	defb 001h,040h	; 6d6e
	defb 000h,040h	; 6d70
	defb 005h,040h	; 6d72
	defb 004h,040h	; 6d74
	defb 003h,040h	; 6d76
	defb 002h,040h	; 6d78
	defb 005h,040h	; 6d7a
	defb 004h,040h	; 6d7c
	defb 00bh,040h	; 6d7e
	defb 00ah,040h	; 6d80
	defb 02dh,041h	; 6d82
	defb 056h,046h	; 6d84
	defb 030h,047h	; 6d86
	defb 031h,045h	; 6d88
	defb 04fh,040h	; 6d8a
	defb 026h,040h	; 6d8c
	defb 023h,040h	; 6d8e
	defb 022h,040h	; 6d90
	defb 023h,040h	; 6d92
	defb 022h,040h	; 6d94
	defb 021h,040h	; 6d96
	defb 020h,040h	; 6d98
	defb 01fh,040h	; 6d9a
	defb 01eh,040h	; 6d9c
	defb 01dh,040h	; 6d9e
	defb 01ch,040h	; 6da0
	defb 01bh,040h	; 6da2
	defb 01ah,040h	; 6da4
	defb 019h,040h	; 6da6
	defb 018h,040h	; 6da8
	defb 017h,040h	; 6daa
	defb 016h,040h	; 6dac
	defb 015h,040h	; 6dae
	defb 014h,040h	; 6db0
	defb 00fh,040h	; 6db2
	defb 011h,040h	; 6db4
	defb 010h,040h	; 6db6
	defb 011h,040h	; 6db8
	defb 010h,040h	; 6dba
	defb 00fh,040h	; 6dbc
	defb 00fh,040h	; 6dbe
	defb 011h,040h	; 6dc0
	defb 010h,040h	; 6dc2
	defb 00fh,040h	; 6dc4
	defb 011h,040h	; 6dc6
	defb 010h,040h	; 6dc8
	defb 011h,040h	; 6dca
	defb 010h,040h	; 6dcc
	defb 015h,040h	; 6dce
	defb 014h,040h	; 6dd0
	defb 00fh,040h	; 6dd2
	defb 00fh,040h	; 6dd4
	defb 011h,040h	; 6dd6
	defb 010h,040h	; 6dd8
	defb 011h,040h	; 6dda
	defb 010h,040h	; 6ddc
	defb 00fh,040h	; 6dde
	defb 015h,040h	; 6de0
	defb 014h,040h	; 6de2
	defb 011h,040h	; 6de4
	defb 010h,040h	; 6de6
	defb 00fh,040h	; 6de8
	defb 011h,040h	; 6dea
	defb 010h,040h	; 6dec
	defb 02dh,041h	; 6dee
	defb 02ch,040h	; 6df0
	defb 029h,044h	; 6df2
	defb 028h,040h	; 6df4
	defb 02fh,047h	; 6df6
	defb 02eh,040h	; 6df8
	defb 02bh,047h	; 6dfa
	defb 03fh,040h	; 6dfc
	defb 042h,047h	; 6dfe
	defb 057h,040h	; 6e00
	defb 042h,040h	; 6e02
	defb 040h,046h	; 6e04
	defb 02eh,041h	; 6e06
	defb 05ch,040h	; 6e08
	defb 03ch,047h	; 6e0a
	defb 041h,040h	; 6e0c
	defb 05ah,040h	; 6e0e
	defb 031h,047h	; 6e10
	defb 030h,040h	; 6e12
	defb 028h,046h	; 6e14
	defb 027h,040h	; 6e16
	defb 026h,040h	; 6e18
	defb 00fh,040h	; 6e1a
	defb 011h,040h	; 6e1c
	defb 010h,040h	; 6e1e
	defb 00fh,040h	; 6e20
	defb 02dh,041h	; 6e22
	defb 056h,046h	; 6e24
	defb 030h,047h	; 6e26
	defb 055h,040h	; 6e28
	defb 054h,040h	; 6e2a
	defb 03dh,041h	; 6e2c
	defb 053h,040h	; 6e2e
	defb 032h,041h	; 6e30
	defb 009h,040h	; 6e32
	defb 008h,040h	; 6e34
	defb 005h,040h	; 6e36
	defb 003h,040h	; 6e38
	defb 002h,040h	; 6e3a
	defb 005h,040h	; 6e3c
	defb 004h,040h	; 6e3e
	defb 00bh,040h	; 6e40
	defb 00ah,040h	; 6e42
	defb 02dh,041h	; 6e44
	defb 02ch,040h	; 6e46
	defb 02eh,046h	; 6e48
	defb 02fh,045h	; 6e4a
	defb 029h,046h	; 6e4c
	defb 028h,040h	; 6e4e
	defb 059h,042h	; 6e50
	defb 057h,047h	; 6e52
	defb 042h,040h	; 6e54
	defb 040h,046h	; 6e56
	defb 029h,047h	; 6e58
	defb 028h,040h	; 6e5a
	defb 02fh,047h	; 6e5c
	defb 060h,047h	; 6e5e
	defb 05fh,040h	; 6e60
	defb 05eh,040h	; 6e62
	defb 03bh,042h	; 6e64
	defb 05bh,046h	; 6e66
	defb 05ah,040h	; 6e68
	defb 028h,040h	; 6e6a
	defb 02fh,047h	; 6e6c
	defb 02eh,040h	; 6e6e
	defb 02bh,047h	; 6e70
	defb 03fh,040h	; 6e72
	defb 042h,047h	; 6e74
	defb 057h,040h	; 6e76
	defb 042h,040h	; 6e78
	defb 040h,046h	; 6e7a
	defb 029h,047h	; 6e7c
	defb 031h,047h	; 6e7e
	defb 030h,040h	; 6e80
	defb 028h,046h	; 6e82
	defb 027h,040h	; 6e84
	defb 026h,040h	; 6e86
	defb 009h,040h	; 6e88
	defb 008h,040h	; 6e8a
	defb 005h,040h	; 6e8c
	defb 0ffh	; 6e8e

; ----------------------------------------------------------------------
; DATOS circuito_13: secuencia del circuito de la carrera 13 (F1 ROUND 9): 144
;   pares (pieza, flags) y 0xFF; piezas hasta la 111, 144 con desplazamiento
;   de columna (bit 6)
;   0x6e8f..0x6fb0  (289 bytes)
DATA_circuito_13:
	defb 065h,040h	; 6e8f
	defb 06fh,040h	; 6e91
	defb 003h,040h	; 6e93
	defb 002h,040h	; 6e95
	defb 005h,040h	; 6e97
	defb 004h,040h	; 6e99
	defb 007h,040h	; 6e9b
	defb 006h,040h	; 6e9d
	defb 007h,040h	; 6e9f
	defb 005h,040h	; 6ea1
	defb 004h,040h	; 6ea3
	defb 007h,040h	; 6ea5
	defb 006h,040h	; 6ea7
	defb 007h,040h	; 6ea9
	defb 005h,040h	; 6eab
	defb 004h,040h	; 6ead
	defb 00bh,040h	; 6eaf
	defb 00ah,040h	; 6eb1
	defb 015h,040h	; 6eb3
	defb 014h,040h	; 6eb5
	defb 00fh,040h	; 6eb7
	defb 00fh,040h	; 6eb9
	defb 011h,040h	; 6ebb
	defb 010h,040h	; 6ebd
	defb 011h,040h	; 6ebf
	defb 010h,040h	; 6ec1
	defb 00fh,040h	; 6ec3
	defb 00fh,040h	; 6ec5
	defb 015h,040h	; 6ec7
	defb 014h,040h	; 6ec9
	defb 00fh,040h	; 6ecb
	defb 00fh,040h	; 6ecd
	defb 039h,047h	; 6ecf
	defb 038h,040h	; 6ed1
	defb 03ah,042h	; 6ed3
	defb 03bh,043h	; 6ed5
	defb 05dh,046h	; 6ed7
	defb 028h,040h	; 6ed9
	defb 02fh,047h	; 6edb
	defb 02eh,040h	; 6edd
	defb 02bh,047h	; 6edf
	defb 03fh,040h	; 6ee1
	defb 042h,047h	; 6ee3
	defb 042h,040h	; 6ee5
	defb 042h,040h	; 6ee7
	defb 040h,046h	; 6ee9
	defb 029h,047h	; 6eeb
	defb 031h,047h	; 6eed
	defb 030h,040h	; 6eef
	defb 055h,040h	; 6ef1
	defb 054h,040h	; 6ef3
	defb 03dh,041h	; 6ef5
	defb 03ch,040h	; 6ef7
	defb 051h,040h	; 6ef9
	defb 050h,040h	; 6efb
	defb 031h,047h	; 6efd
	defb 03fh,042h	; 6eff
	defb 03eh,040h	; 6f01
	defb 03bh,041h	; 6f03
	defb 05bh,046h	; 6f05
	defb 042h,042h	; 6f07
	defb 042h,040h	; 6f09
	defb 042h,040h	; 6f0b
	defb 042h,040h	; 6f0d
	defb 042h,040h	; 6f0f
	defb 05ah,046h	; 6f11
	defb 031h,047h	; 6f13
	defb 03fh,042h	; 6f15
	defb 058h,040h	; 6f17
	defb 036h,046h	; 6f19
	defb 03ah,042h	; 6f1b
	defb 03bh,043h	; 6f1d
	defb 035h,042h	; 6f1f
	defb 041h,045h	; 6f21
	defb 05ah,040h	; 6f23
	defb 028h,040h	; 6f25
	defb 02fh,047h	; 6f27
	defb 02eh,040h	; 6f29
	defb 027h,046h	; 6f2b
	defb 026h,040h	; 6f2d
	defb 009h,040h	; 6f2f
	defb 008h,040h	; 6f31
	defb 00bh,040h	; 6f33
	defb 00ah,040h	; 6f35
	defb 04ah,047h	; 6f37
	defb 049h,040h	; 6f39
	defb 048h,040h	; 6f3b
	defb 047h,040h	; 6f3d
	defb 015h,046h	; 6f3f
	defb 014h,040h	; 6f41
	defb 039h,047h	; 6f43
	defb 038h,040h	; 6f45
	defb 03ah,042h	; 6f47
	defb 03bh,043h	; 6f49
	defb 05dh,046h	; 6f4b
	defb 028h,040h	; 6f4d
	defb 02fh,047h	; 6f4f
	defb 02eh,040h	; 6f51
	defb 027h,046h	; 6f53
	defb 026h,040h	; 6f55
	defb 009h,040h	; 6f57
	defb 008h,040h	; 6f59
	defb 00bh,040h	; 6f5b
	defb 00ah,040h	; 6f5d
	defb 039h,047h	; 6f5f
	defb 038h,040h	; 6f61
	defb 03ah,042h	; 6f63
	defb 033h,042h	; 6f65
	defb 032h,040h	; 6f67
	defb 009h,040h	; 6f69
	defb 008h,040h	; 6f6b
	defb 00bh,040h	; 6f6d
	defb 00ah,040h	; 6f6f
	defb 02dh,041h	; 6f71
	defb 02ch,040h	; 6f73
	defb 02eh,046h	; 6f75
	defb 059h,040h	; 6f77
	defb 042h,047h	; 6f79
	defb 040h,046h	; 6f7b
	defb 02eh,041h	; 6f7d
	defb 05ch,040h	; 6f7f
	defb 03ch,047h	; 6f81
	defb 03dh,043h	; 6f83
	defb 046h,041h	; 6f85
	defb 045h,040h	; 6f87
	defb 031h,044h	; 6f89
	defb 04fh,040h	; 6f8b
	defb 026h,040h	; 6f8d
	defb 025h,040h	; 6f8f
	defb 024h,040h	; 6f91
	defb 023h,040h	; 6f93
	defb 022h,040h	; 6f95
	defb 021h,040h	; 6f97
	defb 020h,040h	; 6f99
	defb 01fh,040h	; 6f9b
	defb 01eh,040h	; 6f9d
	defb 01dh,040h	; 6f9f
	defb 01ch,040h	; 6fa1
	defb 01bh,040h	; 6fa3
	defb 01ah,040h	; 6fa5
	defb 019h,040h	; 6fa7
	defb 018h,040h	; 6fa9
	defb 017h,040h	; 6fab
	defb 016h,040h	; 6fad
	defb 0ffh	; 6faf

; ----------------------------------------------------------------------
; DATOS circuito_14: secuencia del circuito de la carrera 14 (F1 ROUND 10):
;   144 pares (pieza, flags) y 0xFF; piezas hasta la 99, 144 con
;   desplazamiento de columna (bit 6)
;   0x6fb0..0x70d1  (289 bytes)
DATA_circuito_14:
	defb 001h,040h	; 6fb0
	defb 000h,040h	; 6fb2
	defb 003h,040h	; 6fb4
	defb 002h,040h	; 6fb6
	defb 005h,040h	; 6fb8
	defb 004h,040h	; 6fba
	defb 003h,040h	; 6fbc
	defb 002h,040h	; 6fbe
	defb 00bh,040h	; 6fc0
	defb 00ah,040h	; 6fc2
	defb 00dh,040h	; 6fc4
	defb 00ch,040h	; 6fc6
	defb 013h,040h	; 6fc8
	defb 012h,040h	; 6fca
	defb 00dh,040h	; 6fcc
	defb 00ch,040h	; 6fce
	defb 012h,040h	; 6fd0
	defb 015h,040h	; 6fd2
	defb 014h,040h	; 6fd4
	defb 00fh,040h	; 6fd6
	defb 011h,040h	; 6fd8
	defb 010h,040h	; 6fda
	defb 00fh,040h	; 6fdc
	defb 00fh,040h	; 6fde
	defb 011h,040h	; 6fe0
	defb 010h,040h	; 6fe2
	defb 00fh,040h	; 6fe4
	defb 00eh,040h	; 6fe6
	defb 015h,040h	; 6fe8
	defb 014h,040h	; 6fea
	defb 00fh,040h	; 6fec
	defb 00fh,040h	; 6fee
	defb 015h,040h	; 6ff0
	defb 014h,040h	; 6ff2
	defb 00fh,040h	; 6ff4
	defb 00fh,040h	; 6ff6
	defb 00fh,040h	; 6ff8
	defb 02dh,041h	; 6ffa
	defb 056h,046h	; 6ffc
	defb 030h,047h	; 6ffe
	defb 055h,040h	; 7000
	defb 054h,040h	; 7002
	defb 03dh,041h	; 7004
	defb 03ch,040h	; 7006
	defb 041h,040h	; 7008
	defb 057h,042h	; 700a
	defb 042h,040h	; 700c
	defb 040h,046h	; 700e
	defb 029h,047h	; 7010
	defb 031h,047h	; 7012
	defb 030h,040h	; 7014
	defb 028h,046h	; 7016
	defb 05ch,042h	; 7018
	defb 03ch,047h	; 701a
	defb 03dh,043h	; 701c
	defb 063h,042h	; 701e
	defb 062h,040h	; 7020
	defb 061h,040h	; 7022
	defb 030h,046h	; 7024
	defb 028h,046h	; 7026
	defb 027h,040h	; 7028
	defb 026h,040h	; 702a
	defb 015h,040h	; 702c
	defb 014h,040h	; 702e
	defb 00fh,040h	; 7030
	defb 00fh,040h	; 7032
	defb 011h,040h	; 7034
	defb 010h,040h	; 7036
	defb 011h,040h	; 7038
	defb 010h,040h	; 703a
	defb 00fh,040h	; 703c
	defb 00fh,040h	; 703e
	defb 011h,040h	; 7040
	defb 010h,040h	; 7042
	defb 015h,040h	; 7044
	defb 014h,040h	; 7046
	defb 015h,040h	; 7048
	defb 014h,040h	; 704a
	defb 00fh,040h	; 704c
	defb 00fh,040h	; 704e
	defb 039h,047h	; 7050
	defb 038h,040h	; 7052
	defb 035h,044h	; 7054
	defb 03dh,040h	; 7056
	defb 03ch,040h	; 7058
	defb 041h,040h	; 705a
	defb 040h,040h	; 705c
	defb 029h,047h	; 705e
	defb 031h,047h	; 7060
	defb 030h,040h	; 7062
	defb 028h,046h	; 7064
	defb 059h,042h	; 7066
	defb 057h,047h	; 7068
	defb 042h,040h	; 706a
	defb 057h,040h	; 706c
	defb 042h,040h	; 706e
	defb 040h,046h	; 7070
	defb 029h,047h	; 7072
	defb 031h,047h	; 7074
	defb 030h,040h	; 7076
	defb 055h,040h	; 7078
	defb 054h,040h	; 707a
	defb 03dh,041h	; 707c
	defb 036h,047h	; 707e
	defb 035h,044h	; 7080
	defb 041h,045h	; 7082
	defb 042h,042h	; 7084
	defb 042h,040h	; 7086
	defb 057h,040h	; 7088
	defb 057h,040h	; 708a
	defb 042h,040h	; 708c
	defb 042h,040h	; 708e
	defb 042h,040h	; 7090
	defb 03eh,041h	; 7092
	defb 037h,047h	; 7094
	defb 03ch,041h	; 7096
	defb 051h,040h	; 7098
	defb 050h,040h	; 709a
	defb 031h,047h	; 709c
	defb 030h,040h	; 709e
	defb 028h,046h	; 70a0
	defb 027h,040h	; 70a2
	defb 026h,040h	; 70a4
	defb 025h,040h	; 70a6
	defb 024h,040h	; 70a8
	defb 025h,040h	; 70aa
	defb 024h,040h	; 70ac
	defb 023h,040h	; 70ae
	defb 022h,040h	; 70b0
	defb 021h,040h	; 70b2
	defb 020h,040h	; 70b4
	defb 01fh,040h	; 70b6
	defb 01eh,040h	; 70b8
	defb 01dh,040h	; 70ba
	defb 01ch,040h	; 70bc
	defb 01bh,040h	; 70be
	defb 01ah,040h	; 70c0
	defb 019h,040h	; 70c2
	defb 018h,040h	; 70c4
	defb 017h,040h	; 70c6
	defb 016h,040h	; 70c8
	defb 009h,040h	; 70ca
	defb 008h,040h	; 70cc
	defb 005h,040h	; 70ce
	defb 0ffh	; 70d0

; ----------------------------------------------------------------------
; DATOS circuito_15: secuencia del circuito de la carrera 15 (F1 ROUND 11):
;   128 pares (pieza, flags) y 0xFF; piezas hasta la 111, 128 con
;   desplazamiento de columna (bit 6)
;   0x70d1..0x71d2  (257 bytes)
DATA_circuito_15:
	defb 065h,040h	; 70d1
	defb 06fh,040h	; 70d3
	defb 003h,040h	; 70d5
	defb 002h,040h	; 70d7
	defb 005h,040h	; 70d9
	defb 004h,040h	; 70db
	defb 005h,040h	; 70dd
	defb 004h,040h	; 70df
	defb 00bh,040h	; 70e1
	defb 00ah,040h	; 70e3
	defb 00dh,040h	; 70e5
	defb 00ch,040h	; 70e7
	defb 013h,040h	; 70e9
	defb 012h,040h	; 70eb
	defb 013h,040h	; 70ed
	defb 012h,040h	; 70ef
	defb 00fh,040h	; 70f1
	defb 00fh,040h	; 70f3
	defb 015h,040h	; 70f5
	defb 014h,040h	; 70f7
	defb 011h,040h	; 70f9
	defb 010h,040h	; 70fb
	defb 011h,040h	; 70fd
	defb 010h,040h	; 70ff
	defb 00fh,040h	; 7101
	defb 011h,040h	; 7103
	defb 010h,040h	; 7105
	defb 00fh,040h	; 7107
	defb 015h,040h	; 7109
	defb 014h,040h	; 710b
	defb 00fh,040h	; 710d
	defb 00fh,040h	; 710f
	defb 04eh,042h	; 7111
	defb 04dh,040h	; 7113
	defb 04ch,040h	; 7115
	defb 04bh,040h	; 7117
	defb 04eh,043h	; 7119
	defb 04dh,040h	; 711b
	defb 04ch,040h	; 711d
	defb 04bh,040h	; 711f
	defb 00fh,041h	; 7121
	defb 00fh,040h	; 7123
	defb 039h,047h	; 7125
	defb 052h,041h	; 7127
	defb 03ch,041h	; 7129
	defb 051h,040h	; 712b
	defb 050h,040h	; 712d
	defb 031h,047h	; 712f
	defb 04fh,040h	; 7131
	defb 026h,040h	; 7133
	defb 00fh,040h	; 7135
	defb 011h,040h	; 7137
	defb 010h,040h	; 7139
	defb 02dh,041h	; 713b
	defb 02ch,040h	; 713d
	defb 029h,044h	; 713f
	defb 031h,047h	; 7141
	defb 03fh,042h	; 7143
	defb 03eh,040h	; 7145
	defb 037h,047h	; 7147
	defb 03ch,041h	; 7149
	defb 03dh,043h	; 714b
	defb 036h,047h	; 714d
	defb 05bh,040h	; 714f
	defb 057h,042h	; 7151
	defb 042h,040h	; 7153
	defb 05ah,046h	; 7155
	defb 028h,040h	; 7157
	defb 02fh,047h	; 7159
	defb 02eh,040h	; 715b
	defb 02bh,047h	; 715d
	defb 03fh,040h	; 715f
	defb 057h,047h	; 7161
	defb 042h,040h	; 7163
	defb 042h,040h	; 7165
	defb 057h,040h	; 7167
	defb 057h,040h	; 7169
	defb 042h,040h	; 716b
	defb 042h,040h	; 716d
	defb 057h,040h	; 716f
	defb 03eh,041h	; 7171
	defb 037h,047h	; 7173
	defb 03ch,041h	; 7175
	defb 051h,040h	; 7177
	defb 050h,040h	; 7179
	defb 031h,047h	; 717b
	defb 030h,040h	; 717d
	defb 028h,046h	; 717f
	defb 027h,040h	; 7181
	defb 026h,040h	; 7183
	defb 00fh,040h	; 7185
	defb 00fh,040h	; 7187
	defb 00eh,040h	; 7189
	defb 011h,040h	; 718b
	defb 010h,040h	; 718d
	defb 00fh,040h	; 718f
	defb 011h,040h	; 7191
	defb 010h,040h	; 7193
	defb 00fh,040h	; 7195
	defb 00fh,040h	; 7197
	defb 039h,047h	; 7199
	defb 052h,041h	; 719b
	defb 03ch,041h	; 719d
	defb 03dh,043h	; 719f
	defb 036h,047h	; 71a1
	defb 05bh,040h	; 71a3
	defb 05ah,040h	; 71a5
	defb 031h,047h	; 71a7
	defb 030h,040h	; 71a9
	defb 028h,046h	; 71ab
	defb 027h,040h	; 71ad
	defb 026h,040h	; 71af
	defb 025h,040h	; 71b1
	defb 024h,040h	; 71b3
	defb 023h,040h	; 71b5
	defb 022h,040h	; 71b7
	defb 021h,040h	; 71b9
	defb 020h,040h	; 71bb
	defb 01fh,040h	; 71bd
	defb 01eh,040h	; 71bf
	defb 01dh,040h	; 71c1
	defb 01ch,040h	; 71c3
	defb 01bh,040h	; 71c5
	defb 01ah,040h	; 71c7
	defb 019h,040h	; 71c9
	defb 06eh,040h	; 71cb
	defb 017h,040h	; 71cd
	defb 016h,040h	; 71cf
	defb 0ffh	; 71d1

; ----------------------------------------------------------------------
; DATOS circuito_16: secuencia del circuito de la carrera 16 (F1 ROUND 12):
;   144 pares (pieza, flags) y 0xFF; piezas hasta la 111, 144 con
;   desplazamiento de columna (bit 6)
;   0x71d2..0x72f3  (289 bytes)
DATA_circuito_16:
	defb 065h,040h	; 71d2
	defb 06fh,040h	; 71d4
	defb 003h,040h	; 71d6
	defb 002h,040h	; 71d8
	defb 005h,040h	; 71da
	defb 004h,040h	; 71dc
	defb 003h,040h	; 71de
	defb 002h,040h	; 71e0
	defb 00bh,040h	; 71e2
	defb 00ah,040h	; 71e4
	defb 00dh,040h	; 71e6
	defb 00ch,040h	; 71e8
	defb 013h,040h	; 71ea
	defb 012h,040h	; 71ec
	defb 013h,040h	; 71ee
	defb 012h,040h	; 71f0
	defb 015h,040h	; 71f2
	defb 014h,040h	; 71f4
	defb 00fh,040h	; 71f6
	defb 011h,040h	; 71f8
	defb 010h,040h	; 71fa
	defb 00fh,040h	; 71fc
	defb 015h,040h	; 71fe
	defb 014h,040h	; 7200
	defb 011h,040h	; 7202
	defb 010h,040h	; 7204
	defb 00fh,040h	; 7206
	defb 00fh,040h	; 7208
	defb 011h,040h	; 720a
	defb 010h,040h	; 720c
	defb 015h,040h	; 720e
	defb 014h,040h	; 7210
	defb 02dh,041h	; 7212
	defb 02ch,040h	; 7214
	defb 029h,044h	; 7216
	defb 028h,040h	; 7218
	defb 02fh,047h	; 721a
	defb 02eh,040h	; 721c
	defb 027h,046h	; 721e
	defb 026h,040h	; 7220
	defb 00fh,040h	; 7222
	defb 00fh,040h	; 7224
	defb 00eh,040h	; 7226
	defb 039h,047h	; 7228
	defb 052h,041h	; 722a
	defb 03ch,041h	; 722c
	defb 051h,040h	; 722e
	defb 050h,040h	; 7230
	defb 031h,047h	; 7232
	defb 030h,040h	; 7234
	defb 028h,046h	; 7236
	defb 059h,042h	; 7238
	defb 057h,047h	; 723a
	defb 042h,040h	; 723c
	defb 058h,041h	; 723e
	defb 03ch,047h	; 7240
	defb 051h,040h	; 7242
	defb 050h,040h	; 7244
	defb 031h,047h	; 7246
	defb 03fh,042h	; 7248
	defb 042h,047h	; 724a
	defb 05ah,046h	; 724c
	defb 028h,040h	; 724e
	defb 02fh,047h	; 7250
	defb 060h,047h	; 7252
	defb 05fh,040h	; 7254
	defb 05eh,040h	; 7256
	defb 03bh,042h	; 7258
	defb 035h,042h	; 725a
	defb 034h,040h	; 725c
	defb 033h,040h	; 725e
	defb 032h,040h	; 7260
	defb 00fh,040h	; 7262
	defb 00eh,040h	; 7264
	defb 011h,040h	; 7266
	defb 010h,040h	; 7268
	defb 00fh,040h	; 726a
	defb 02dh,041h	; 726c
	defb 02ch,040h	; 726e
	defb 029h,044h	; 7270
	defb 031h,047h	; 7272
	defb 030h,040h	; 7274
	defb 055h,040h	; 7276
	defb 054h,040h	; 7278
	defb 03dh,041h	; 727a
	defb 036h,047h	; 727c
	defb 035h,044h	; 727e
	defb 041h,045h	; 7280
	defb 057h,042h	; 7282
	defb 042h,040h	; 7284
	defb 03eh,041h	; 7286
	defb 037h,047h	; 7288
	defb 03ch,041h	; 728a
	defb 03dh,043h	; 728c
	defb 036h,047h	; 728e
	defb 05dh,040h	; 7290
	defb 028h,040h	; 7292
	defb 02fh,047h	; 7294
	defb 02eh,040h	; 7296
	defb 027h,046h	; 7298
	defb 026h,040h	; 729a
	defb 00fh,040h	; 729c
	defb 00eh,040h	; 729e
	defb 00fh,040h	; 72a0
	defb 02dh,041h	; 72a2
	defb 02ch,040h	; 72a4
	defb 02eh,046h	; 72a6
	defb 02bh,047h	; 72a8
	defb 03fh,040h	; 72aa
	defb 042h,047h	; 72ac
	defb 057h,040h	; 72ae
	defb 042h,040h	; 72b0
	defb 042h,040h	; 72b2
	defb 05ah,046h	; 72b4
	defb 028h,040h	; 72b6
	defb 02fh,047h	; 72b8
	defb 044h,041h	; 72ba
	defb 043h,040h	; 72bc
	defb 03ah,040h	; 72be
	defb 03bh,043h	; 72c0
	defb 05bh,046h	; 72c2
	defb 05ah,040h	; 72c4
	defb 028h,040h	; 72c6
	defb 02fh,047h	; 72c8
	defb 02eh,040h	; 72ca
	defb 027h,046h	; 72cc
	defb 026h,040h	; 72ce
	defb 025h,040h	; 72d0
	defb 024h,040h	; 72d2
	defb 023h,040h	; 72d4
	defb 022h,040h	; 72d6
	defb 021h,040h	; 72d8
	defb 020h,040h	; 72da
	defb 01fh,040h	; 72dc
	defb 01eh,040h	; 72de
	defb 01dh,040h	; 72e0
	defb 01ch,040h	; 72e2
	defb 01bh,040h	; 72e4
	defb 01ah,040h	; 72e6
	defb 019h,040h	; 72e8
	defb 06eh,040h	; 72ea
	defb 017h,040h	; 72ec
	defb 016h,040h	; 72ee
	defb 013h,040h	; 72f0
	defb 0ffh	; 72f2

; ----------------------------------------------------------------------
; DATOS circuito_17: secuencia del circuito de la carrera 17 (F1 ROUND 13):
;   148 pares (pieza, flags) y 0xFF; piezas hasta la 99, 148 con
;   desplazamiento de columna (bit 6)
;   0x72f3..0x741c  (297 bytes)
DATA_circuito_17:
	defb 001h,040h	; 72f3
	defb 000h,040h	; 72f5
	defb 003h,040h	; 72f7
	defb 002h,040h	; 72f9
	defb 003h,040h	; 72fb
	defb 002h,040h	; 72fd
	defb 005h,040h	; 72ff
	defb 004h,040h	; 7301
	defb 003h,040h	; 7303
	defb 002h,040h	; 7305
	defb 005h,040h	; 7307
	defb 004h,040h	; 7309
	defb 00bh,040h	; 730b
	defb 00ah,040h	; 730d
	defb 00dh,040h	; 730f
	defb 00ch,040h	; 7311
	defb 013h,040h	; 7313
	defb 012h,040h	; 7315
	defb 013h,040h	; 7317
	defb 012h,040h	; 7319
	defb 015h,040h	; 731b
	defb 014h,040h	; 731d
	defb 00fh,040h	; 731f
	defb 011h,040h	; 7321
	defb 010h,040h	; 7323
	defb 00fh,040h	; 7325
	defb 011h,040h	; 7327
	defb 010h,040h	; 7329
	defb 00fh,040h	; 732b
	defb 015h,040h	; 732d
	defb 014h,040h	; 732f
	defb 00fh,040h	; 7331
	defb 039h,047h	; 7333
	defb 052h,041h	; 7335
	defb 03ch,041h	; 7337
	defb 041h,040h	; 7339
	defb 042h,042h	; 733b
	defb 057h,040h	; 733d
	defb 058h,041h	; 733f
	defb 036h,046h	; 7341
	defb 05dh,040h	; 7343
	defb 028h,040h	; 7345
	defb 02fh,047h	; 7347
	defb 02eh,040h	; 7349
	defb 02bh,047h	; 734b
	defb 03fh,040h	; 734d
	defb 057h,047h	; 734f
	defb 042h,040h	; 7351
	defb 057h,040h	; 7353
	defb 042h,040h	; 7355
	defb 057h,040h	; 7357
	defb 03eh,041h	; 7359
	defb 037h,047h	; 735b
	defb 036h,040h	; 735d
	defb 03ah,042h	; 735f
	defb 03bh,043h	; 7361
	defb 035h,042h	; 7363
	defb 041h,045h	; 7365
	defb 057h,042h	; 7367
	defb 042h,040h	; 7369
	defb 040h,046h	; 736b
	defb 02eh,041h	; 736d
	defb 02fh,045h	; 736f
	defb 029h,046h	; 7371
	defb 028h,040h	; 7373
	defb 059h,042h	; 7375
	defb 040h,045h	; 7377
	defb 02eh,041h	; 7379
	defb 059h,040h	; 737b
	defb 057h,047h	; 737d
	defb 042h,040h	; 737f
	defb 057h,040h	; 7381
	defb 042h,040h	; 7383
	defb 058h,041h	; 7385
	defb 03ch,047h	; 7387
	defb 03dh,043h	; 7389
	defb 063h,042h	; 738b
	defb 062h,040h	; 738d
	defb 061h,040h	; 738f
	defb 030h,046h	; 7391
	defb 028h,046h	; 7393
	defb 059h,042h	; 7395
	defb 057h,047h	; 7397
	defb 042h,040h	; 7399
	defb 057h,040h	; 739b
	defb 042h,040h	; 739d
	defb 03eh,041h	; 739f
	defb 037h,047h	; 73a1
	defb 03ch,041h	; 73a3
	defb 03dh,043h	; 73a5
	defb 036h,047h	; 73a7
	defb 05bh,040h	; 73a9
	defb 042h,042h	; 73ab
	defb 057h,040h	; 73ad
	defb 042h,040h	; 73af
	defb 03eh,041h	; 73b1
	defb 03bh,041h	; 73b3
	defb 05bh,046h	; 73b5
	defb 057h,042h	; 73b7
	defb 05ah,046h	; 73b9
	defb 031h,047h	; 73bb
	defb 030h,040h	; 73bd
	defb 028h,046h	; 73bf
	defb 059h,042h	; 73c1
	defb 058h,040h	; 73c3
	defb 036h,046h	; 73c5
	defb 05dh,040h	; 73c7
	defb 028h,040h	; 73c9
	defb 02fh,047h	; 73cb
	defb 02eh,040h	; 73cd
	defb 02bh,047h	; 73cf
	defb 03fh,040h	; 73d1
	defb 042h,047h	; 73d3
	defb 05ah,046h	; 73d5
	defb 028h,040h	; 73d7
	defb 02fh,047h	; 73d9
	defb 02eh,040h	; 73db
	defb 027h,046h	; 73dd
	defb 026h,040h	; 73df
	defb 025h,040h	; 73e1
	defb 024h,040h	; 73e3
	defb 023h,040h	; 73e5
	defb 022h,040h	; 73e7
	defb 021h,040h	; 73e9
	defb 020h,040h	; 73eb
	defb 01fh,040h	; 73ed
	defb 01eh,040h	; 73ef
	defb 01dh,040h	; 73f1
	defb 01ch,040h	; 73f3
	defb 01bh,040h	; 73f5
	defb 01ah,040h	; 73f7
	defb 019h,040h	; 73f9
	defb 018h,040h	; 73fb
	defb 017h,040h	; 73fd
	defb 016h,040h	; 73ff
	defb 02dh,041h	; 7401
	defb 056h,046h	; 7403
	defb 030h,047h	; 7405
	defb 055h,040h	; 7407
	defb 054h,040h	; 7409
	defb 03dh,041h	; 740b
	defb 053h,040h	; 740d
	defb 032h,041h	; 740f
	defb 00fh,040h	; 7411
	defb 00eh,040h	; 7413
	defb 012h,040h	; 7415
	defb 009h,040h	; 7417
	defb 008h,040h	; 7419
	defb 0ffh	; 741b

; ----------------------------------------------------------------------
; DATOS circuito_18: secuencia del circuito de la carrera 18 (F1 ROUND 14):
;   128 pares (pieza, flags) y 0xFF; piezas hasta la 99, 128 con
;   desplazamiento de columna (bit 6)
;   0x741c..0x751d  (257 bytes)
DATA_circuito_18:
	defb 001h,040h	; 741c
	defb 000h,040h	; 741e
	defb 00bh,040h	; 7420
	defb 00ah,040h	; 7422
	defb 023h,040h	; 7424
	defb 022h,040h	; 7426
	defb 023h,040h	; 7428
	defb 022h,040h	; 742a
	defb 021h,040h	; 742c
	defb 020h,040h	; 742e
	defb 01fh,040h	; 7430
	defb 01eh,040h	; 7432
	defb 01dh,040h	; 7434
	defb 01ch,040h	; 7436
	defb 01bh,040h	; 7438
	defb 01ah,040h	; 743a
	defb 019h,040h	; 743c
	defb 018h,040h	; 743e
	defb 017h,040h	; 7440
	defb 016h,040h	; 7442
	defb 009h,040h	; 7444
	defb 008h,040h	; 7446
	defb 003h,040h	; 7448
	defb 002h,040h	; 744a
	defb 003h,040h	; 744c
	defb 002h,040h	; 744e
	defb 005h,040h	; 7450
	defb 004h,040h	; 7452
	defb 005h,040h	; 7454
	defb 004h,040h	; 7456
	defb 00bh,040h	; 7458
	defb 00ah,040h	; 745a
	defb 00dh,040h	; 745c
	defb 00ch,040h	; 745e
	defb 00dh,040h	; 7460
	defb 00ch,040h	; 7462
	defb 013h,040h	; 7464
	defb 012h,040h	; 7466
	defb 00fh,040h	; 7468
	defb 011h,040h	; 746a
	defb 010h,040h	; 746c
	defb 015h,040h	; 746e
	defb 014h,040h	; 7470
	defb 011h,040h	; 7472
	defb 010h,040h	; 7474
	defb 011h,040h	; 7476
	defb 010h,040h	; 7478
	defb 00fh,040h	; 747a
	defb 015h,040h	; 747c
	defb 014h,040h	; 747e
	defb 00fh,040h	; 7480
	defb 02dh,041h	; 7482
	defb 056h,046h	; 7484
	defb 030h,047h	; 7486
	defb 055h,040h	; 7488
	defb 054h,040h	; 748a
	defb 03dh,041h	; 748c
	defb 053h,040h	; 748e
	defb 032h,041h	; 7490
	defb 00fh,040h	; 7492
	defb 011h,040h	; 7494
	defb 010h,040h	; 7496
	defb 015h,040h	; 7498
	defb 014h,040h	; 749a
	defb 00fh,040h	; 749c
	defb 039h,047h	; 749e
	defb 052h,041h	; 74a0
	defb 03ch,041h	; 74a2
	defb 03dh,043h	; 74a4
	defb 063h,042h	; 74a6
	defb 062h,040h	; 74a8
	defb 061h,040h	; 74aa
	defb 030h,046h	; 74ac
	defb 028h,046h	; 74ae
	defb 059h,042h	; 74b0
	defb 058h,040h	; 74b2
	defb 03ch,047h	; 74b4
	defb 051h,040h	; 74b6
	defb 050h,040h	; 74b8
	defb 031h,047h	; 74ba
	defb 030h,040h	; 74bc
	defb 055h,040h	; 74be
	defb 054h,040h	; 74c0
	defb 03dh,041h	; 74c2
	defb 046h,041h	; 74c4
	defb 045h,040h	; 74c6
	defb 031h,044h	; 74c8
	defb 030h,040h	; 74ca
	defb 028h,046h	; 74cc
	defb 05ch,042h	; 74ce
	defb 03ch,047h	; 74d0
	defb 041h,040h	; 74d2
	defb 040h,040h	; 74d4
	defb 02eh,041h	; 74d6
	defb 05ch,040h	; 74d8
	defb 036h,046h	; 74da
	defb 03ah,042h	; 74dc
	defb 03bh,043h	; 74de
	defb 035h,042h	; 74e0
	defb 041h,045h	; 74e2
	defb 040h,040h	; 74e4
	defb 029h,047h	; 74e6
	defb 031h,047h	; 74e8
	defb 030h,040h	; 74ea
	defb 028h,046h	; 74ec
	defb 027h,040h	; 74ee
	defb 026h,040h	; 74f0
	defb 015h,040h	; 74f2
	defb 014h,040h	; 74f4
	defb 00fh,040h	; 74f6
	defb 00fh,040h	; 74f8
	defb 011h,040h	; 74fa
	defb 010h,040h	; 74fc
	defb 011h,040h	; 74fe
	defb 010h,040h	; 7500
	defb 00fh,040h	; 7502
	defb 00fh,040h	; 7504
	defb 02dh,041h	; 7506
	defb 02ch,040h	; 7508
	defb 029h,044h	; 750a
	defb 031h,047h	; 750c
	defb 030h,040h	; 750e
	defb 028h,046h	; 7510
	defb 027h,040h	; 7512
	defb 026h,040h	; 7514
	defb 00eh,040h	; 7516
	defb 009h,040h	; 7518
	defb 008h,040h	; 751a
	defb 0ffh	; 751c

; ----------------------------------------------------------------------
; DATOS circuito_19: secuencia del circuito de la carrera 19 (F1 ROUND 15):
;   148 pares (pieza, flags) y 0xFF; piezas hasta la 110, 148 con
;   desplazamiento de columna (bit 6)
;   0x751d..0x7646  (297 bytes)
DATA_circuito_19:
	defb 001h,040h	; 751d
	defb 000h,040h	; 751f
	defb 003h,040h	; 7521
	defb 002h,040h	; 7523
	defb 003h,040h	; 7525
	defb 002h,040h	; 7527
	defb 005h,040h	; 7529
	defb 004h,040h	; 752b
	defb 005h,040h	; 752d
	defb 004h,040h	; 752f
	defb 00bh,040h	; 7531
	defb 00ah,040h	; 7533
	defb 00dh,040h	; 7535
	defb 00ch,040h	; 7537
	defb 013h,040h	; 7539
	defb 012h,040h	; 753b
	defb 00dh,040h	; 753d
	defb 00ch,040h	; 753f
	defb 013h,040h	; 7541
	defb 00fh,040h	; 7543
	defb 011h,040h	; 7545
	defb 010h,040h	; 7547
	defb 015h,040h	; 7549
	defb 014h,040h	; 754b
	defb 00fh,040h	; 754d
	defb 00fh,040h	; 754f
	defb 011h,040h	; 7551
	defb 010h,040h	; 7553
	defb 015h,040h	; 7555
	defb 014h,040h	; 7557
	defb 00fh,040h	; 7559
	defb 00fh,040h	; 755b
	defb 02dh,041h	; 755d
	defb 056h,046h	; 755f
	defb 030h,047h	; 7561
	defb 031h,045h	; 7563
	defb 03fh,042h	; 7565
	defb 057h,047h	; 7567
	defb 05ah,046h	; 7569
	defb 031h,047h	; 756b
	defb 03fh,042h	; 756d
	defb 03eh,040h	; 756f
	defb 03bh,041h	; 7571
	defb 05dh,046h	; 7573
	defb 028h,040h	; 7575
	defb 02fh,047h	; 7577
	defb 060h,047h	; 7579
	defb 05fh,040h	; 757b
	defb 05eh,040h	; 757d
	defb 03bh,042h	; 757f
	defb 05dh,046h	; 7581
	defb 028h,040h	; 7583
	defb 02fh,047h	; 7585
	defb 02eh,040h	; 7587
	defb 05ch,040h	; 7589
	defb 036h,046h	; 758b
	defb 03ah,042h	; 758d
	defb 03bh,043h	; 758f
	defb 035h,042h	; 7591
	defb 041h,045h	; 7593
	defb 040h,040h	; 7595
	defb 029h,047h	; 7597
	defb 031h,047h	; 7599
	defb 030h,040h	; 759b
	defb 028h,046h	; 759d
	defb 027h,040h	; 759f
	defb 026h,040h	; 75a1
	defb 00fh,040h	; 75a3
	defb 069h,040h	; 75a5
	defb 068h,040h	; 75a7
	defb 067h,040h	; 75a9
	defb 00fh,040h	; 75ab
	defb 02dh,041h	; 75ad
	defb 02ch,040h	; 75af
	defb 02eh,046h	; 75b1
	defb 02fh,045h	; 75b3
	defb 044h,041h	; 75b5
	defb 043h,040h	; 75b7
	defb 03ah,040h	; 75b9
	defb 03bh,043h	; 75bb
	defb 03ah,040h	; 75bd
	defb 037h,041h	; 75bf
	defb 036h,040h	; 75c1
	defb 05bh,040h	; 75c3
	defb 05ah,040h	; 75c5
	defb 028h,040h	; 75c7
	defb 02fh,047h	; 75c9
	defb 02eh,040h	; 75cb
	defb 02bh,047h	; 75cd
	defb 03fh,040h	; 75cf
	defb 03eh,040h	; 75d1
	defb 037h,047h	; 75d3
	defb 03ch,041h	; 75d5
	defb 034h,043h	; 75d7
	defb 033h,040h	; 75d9
	defb 032h,040h	; 75db
	defb 00fh,040h	; 75dd
	defb 015h,040h	; 75df
	defb 014h,040h	; 75e1
	defb 015h,040h	; 75e3
	defb 014h,040h	; 75e5
	defb 00fh,040h	; 75e7
	defb 00fh,040h	; 75e9
	defb 011h,040h	; 75eb
	defb 010h,040h	; 75ed
	defb 011h,040h	; 75ef
	defb 010h,040h	; 75f1
	defb 06dh,040h	; 75f3
	defb 06ch,040h	; 75f5
	defb 06bh,040h	; 75f7
	defb 06ah,040h	; 75f9
	defb 00fh,040h	; 75fb
	defb 039h,047h	; 75fd
	defb 038h,040h	; 75ff
	defb 035h,044h	; 7601
	defb 03dh,040h	; 7603
	defb 036h,047h	; 7605
	defb 035h,044h	; 7607
	defb 041h,045h	; 7609
	defb 057h,042h	; 760b
	defb 040h,046h	; 760d
	defb 02eh,041h	; 760f
	defb 05ch,040h	; 7611
	defb 063h,041h	; 7613
	defb 062h,040h	; 7615
	defb 061h,040h	; 7617
	defb 030h,046h	; 7619
	defb 028h,046h	; 761b
	defb 027h,040h	; 761d
	defb 026h,040h	; 761f
	defb 025h,040h	; 7621
	defb 024h,040h	; 7623
	defb 023h,040h	; 7625
	defb 022h,040h	; 7627
	defb 021h,040h	; 7629
	defb 020h,040h	; 762b
	defb 01fh,040h	; 762d
	defb 01eh,040h	; 762f
	defb 01dh,040h	; 7631
	defb 01ch,040h	; 7633
	defb 01bh,040h	; 7635
	defb 01ah,040h	; 7637
	defb 019h,040h	; 7639
	defb 06eh,040h	; 763b
	defb 017h,040h	; 763d
	defb 016h,040h	; 763f
	defb 009h,040h	; 7641
	defb 008h,040h	; 7643
	defb 0ffh	; 7645

; ----------------------------------------------------------------------
; DATOS circuito_20: secuencia del circuito de la carrera 20 (F1 ROUND 16):
;   128 pares (pieza, flags) y 0xFF; piezas hasta la 80, 128 con
;   desplazamiento de columna (bit 6)
;   0x7646..0x7747  (257 bytes)
DATA_circuito_20:
	defb 003h,040h	; 7646
	defb 002h,040h	; 7648
	defb 001h,040h	; 764a
	defb 000h,040h	; 764c
	defb 013h,040h	; 764e
	defb 011h,040h	; 7650
	defb 010h,040h	; 7652
	defb 011h,040h	; 7654
	defb 036h,040h	; 7656
	defb 043h,040h	; 7658
	defb 042h,040h	; 765a
	defb 044h,043h	; 765c
	defb 041h,045h	; 765e
	defb 039h,040h	; 7660
	defb 038h,040h	; 7662
	defb 037h,040h	; 7664
	defb 011h,040h	; 7666
	defb 010h,040h	; 7668
	defb 011h,040h	; 766a
	defb 010h,040h	; 766c
	defb 036h,040h	; 766e
	defb 03fh,040h	; 7670
	defb 03eh,040h	; 7672
	defb 042h,040h	; 7674
	defb 043h,043h	; 7676
	defb 03dh,040h	; 7678
	defb 03ch,040h	; 767a
	defb 041h,040h	; 767c
	defb 040h,040h	; 767e
	defb 041h,045h	; 7680
	defb 040h,040h	; 7682
	defb 044h,040h	; 7684
	defb 043h,040h	; 7686
	defb 042h,040h	; 7688
	defb 044h,043h	; 768a
	defb 03bh,045h	; 768c
	defb 03ah,040h	; 768e
	defb 040h,040h	; 7690
	defb 041h,045h	; 7692
	defb 039h,040h	; 7694
	defb 038h,040h	; 7696
	defb 037h,040h	; 7698
	defb 020h,040h	; 769a
	defb 01fh,040h	; 769c
	defb 034h,040h	; 769e
	defb 04dh,040h	; 76a0
	defb 04ch,040h	; 76a2
	defb 050h,040h	; 76a4
	defb 035h,043h	; 76a6
	defb 034h,040h	; 76a8
	defb 04fh,045h	; 76aa
	defb 047h,040h	; 76ac
	defb 046h,040h	; 76ae
	defb 035h,040h	; 76b0
	defb 027h,040h	; 76b2
	defb 027h,040h	; 76b4
	defb 022h,040h	; 76b6
	defb 01dh,040h	; 76b8
	defb 01ch,040h	; 76ba
	defb 013h,040h	; 76bc
	defb 011h,040h	; 76be
	defb 015h,040h	; 76c0
	defb 016h,040h	; 76c2
	defb 017h,040h	; 76c4
	defb 014h,040h	; 76c6
	defb 011h,040h	; 76c8
	defb 010h,040h	; 76ca
	defb 036h,040h	; 76cc
	defb 03bh,045h	; 76ce
	defb 03ah,040h	; 76d0
	defb 039h,040h	; 76d2
	defb 038h,040h	; 76d4
	defb 037h,040h	; 76d6
	defb 011h,040h	; 76d8
	defb 010h,040h	; 76da
	defb 011h,040h	; 76dc
	defb 010h,040h	; 76de
	defb 015h,040h	; 76e0
	defb 017h,040h	; 76e2
	defb 016h,040h	; 76e4
	defb 018h,040h	; 76e6
	defb 018h,040h	; 76e8
	defb 017h,040h	; 76ea
	defb 016h,040h	; 76ec
	defb 018h,040h	; 76ee
	defb 017h,040h	; 76f0
	defb 018h,040h	; 76f2
	defb 017h,040h	; 76f4
	defb 016h,040h	; 76f6
	defb 014h,040h	; 76f8
	defb 011h,040h	; 76fa
	defb 010h,040h	; 76fc
	defb 010h,040h	; 76fe
	defb 011h,040h	; 7700
	defb 010h,040h	; 7702
	defb 036h,040h	; 7704
	defb 03fh,040h	; 7706
	defb 03eh,040h	; 7708
	defb 042h,040h	; 770a
	defb 03bh,040h	; 770c
	defb 03ah,040h	; 770e
	defb 040h,040h	; 7710
	defb 044h,040h	; 7712
	defb 03fh,040h	; 7714
	defb 03eh,040h	; 7716
	defb 042h,040h	; 7718
	defb 043h,043h	; 771a
	defb 03dh,040h	; 771c
	defb 03ch,040h	; 771e
	defb 044h,043h	; 7720
	defb 041h,045h	; 7722
	defb 040h,040h	; 7724
	defb 037h,040h	; 7726
	defb 00eh,040h	; 7728
	defb 00eh,040h	; 772a
	defb 00ch,040h	; 772c
	defb 00ch,040h	; 772e
	defb 00bh,040h	; 7730
	defb 00ah,040h	; 7732
	defb 009h,040h	; 7734
	defb 008h,040h	; 7736
	defb 004h,040h	; 7738
	defb 007h,040h	; 773a
	defb 006h,040h	; 773c
	defb 007h,040h	; 773e
	defb 006h,040h	; 7740
	defb 005h,040h	; 7742
	defb 004h,040h	; 7744
	defb 0ffh	; 7746

; ----------------------------------------------------------------------
; DATOS rle_pat_7747: patrones RLE: 20 tiles desde el 21 (lista 0x6d00)
;   0x7747..0x77e1  (154 bytes)
DATA_rle_pat_7747:
	defb 008h,000h,083h,038h,070h,060h,003h,0f0h,002h,0e8h,085h,00fh,000h,007h,003h,001h	; 7747  ...8p`..........
	defb 003h,000h,0e0h,06dh,06bh,037h,01bh,00dh,004h,004h,000h,060h,0f0h,0f1h,067h,00eh	; 7757  ...mk7.....`..g.
	defb 03fh,0beh,0dfh,000h,000h,080h,0c0h,0e0h,060h,020h,080h,000h,060h,038h,038h,03ch	; 7767  ?.......` ..`88<
	defb 03ch,07dh,07dh,000h,00fh,00fh,008h,00ch,006h,003h,001h,000h,000h,0c0h,003h,0bah	; 7777  <}}.............
	defb 0c0h,0e0h,0e0h,040h,0e0h,0f0h,0b8h,09ch,0ceh,066h,022h,080h,000h,080h,0e0h,0f8h	; 7787  ...@.....f".....
	defb 038h,018h,010h,000h,003h,007h,007h,00eh,001h,000h,000h,018h,0f0h,070h,070h,038h	; 7797  8............pp8
	defb 03ch,00eh,006h,000h,000h,001h,003h,019h,03dh,038h,006h,068h,0e8h,0d0h,0beh,07fh	; 77a7  <.......=8.h....
	defb 01fh,080h,0c0h,005h,000h,0a3h,030h,090h,098h,00dh,00ch,00ch,006h,006h,002h,003h	; 77b7  ......0.........
	defb 000h,006h,09ch,0b8h,050h,060h,068h,0ech,0eeh,00dh,01eh,01ch,001h,003h,004h,007h	; 77c7  ....P`h.........
	defb 00fh,0deh,0b7h,031h,078h,03ch,01ch,00eh,003h,000h	; 77d7  ...1x<....

; ----------------------------------------------------------------------
; DATOS rle_pat_77E1: patrones RLE: 10 tiles desde el 41 (lista 0x6d00)
;   0x77e1..0x782b  (74 bytes)
DATA_rle_pat_77E1:
	defb 093h,03ch,07eh,07bh,0f9h,0f1h,0f5h,0f5h,0f1h,0f1h,07ah,03ch,000h,000h,0e0h,0e0h	; 77e1  .<~{......z<....
	defb 000h,000h,080h,080h,005h,000h,0b0h,07fh,03fh,09fh,08fh,087h,0a3h,031h,070h,0f4h	; 77f1  ........?....1p.
	defb 0f6h,0e6h,0ceh,01eh,0fch,0fch,070h,000h,040h,060h,070h,078h,07ch,07eh,07fh,080h	; 7801  ......p.@`px|~..
	defb 0c0h,0e0h,0f0h,0f8h,0fch,0feh,0ffh,07fh,07fh,03fh,01fh,00fh,007h,003h,001h,0ffh	; 7811  .........?......
	defb 07fh,03fh,01fh,00fh,007h,003h,001h,008h,0c0h,000h	; 7821  .?........

; ----------------------------------------------------------------------
; DATOS rle_pat_782B: patrones RLE: 2 tiles desde el 53 (lista 0x6d00)
;   0x782b..0x7839  (14 bytes)
DATA_rle_pat_782B:
	defb 006h,0ffh,002h,0fch,088h,0e0h,0f8h,0fch,0feh,0feh,0ffh,07fh,03fh,000h	; 782b  ............?.

; ----------------------------------------------------------------------
; DATOS rle_pat_7839: patrones RLE: 3 tiles desde el 58 (lista 0x6d00)
;   0x7839..0x7842  (9 bytes)
DATA_rle_pat_7839:
	defb 008h,007h,006h,0ffh,002h,007h,008h,0fch,000h	; 7839  .........

; ----------------------------------------------------------------------
; DATOS rle_pat_7842: patrones RLE: 6 tiles desde el 61 (lista 0x6d00)
;   0x7842..0x7858  (22 bytes)
DATA_rle_pat_7842:
	defb 018h,0ffh,008h,000h,090h,0ffh,07fh,03fh,01fh,00fh,007h,003h,001h,000h,080h,0c0h	; 7842  .......?........
	defb 0e0h,0f0h,0f8h,0fch,0feh,000h	; 7852

; ----------------------------------------------------------------------
; DATOS rle_col_7858: colores RLE: 20 tiles desde el 1 (lista 0x6d00)
;   0x7858..0x78aa  (82 bytes)
DATA_rle_col_7858:
	defb 010h,081h,00dh,061h,08bh,081h,091h,091h,081h,081h,061h,061h,081h,081h,086h,061h	; 7858  ...a......aa...a
	defb 003h,081h,005h,061h,004h,081h,004h,061h,003h,081h,007h,061h,083h,081h,0b6h,061h	; 7868  ...a...a...a...a
	defb 006h,081h,004h,061h,002h,041h,003h,081h,002h,061h,002h,041h,004h,081h,082h,061h	; 7878  ...a.A...a.A...a
	defb 091h,004h,081h,003h,061h,002h,081h,081h,041h,007h,081h,081h,091h,005h,081h,081h	; 7888  ....a...A.......
	defb 061h,008h,091h,007h,081h,004h,091h,00ah,081h,002h,091h,007h,081h,003h,061h,081h	; 7898  a.............a.
	defb 041h,000h	; 78a8

; ----------------------------------------------------------------------
; DATOS rle_col_78AA: colores RLE: 20 tiles desde el 21 (lista 0x6d00)
;   0x78aa..0x78fc  (82 bytes)
DATA_rle_col_78AA:
	defb 010h,021h,00dh,0c1h,08bh,021h,091h,091h,021h,021h,0c1h,0c1h,021h,021h,02ch,0c1h	; 78aa  .!...!..!!..!!,.
	defb 003h,021h,005h,0c1h,004h,021h,004h,0c1h,003h,021h,007h,0c1h,083h,021h,0bch,0c1h	; 78ba  .!...!...!...!..
	defb 006h,021h,004h,0c1h,002h,041h,003h,021h,002h,0c1h,002h,041h,004h,021h,082h,0c1h	; 78ca  .!...A.!...A.!..
	defb 091h,004h,021h,003h,0c1h,002h,021h,081h,041h,007h,021h,081h,091h,005h,021h,081h	; 78da  ..!...!.A.!...!.
	defb 0c1h,008h,091h,007h,021h,004h,091h,00ah,021h,002h,091h,007h,021h,003h,0c1h,081h	; 78ea  ....!...!...!...
	defb 041h,000h	; 78fa

; ----------------------------------------------------------------------
; DATOS rle_col_78FC: colores RLE: 10 tiles desde el 41 (lista 0x6d00)
;   0x78fc..0x7913  (23 bytes)
DATA_rle_col_78FC:
	defb 002h,041h,002h,051h,085h,071h,051h,051h,041h,051h,004h,041h,081h,051h,01ah,041h	; 78fc  .A.Q.qQQAQ.A.Q.A
	defb 011h,0e1h,00fh,0e4h,008h,0feh,000h	; 790c

; ----------------------------------------------------------------------
; DATOS rle_col_7913: colores RLE: 2 tiles desde el 53 (lista 0x6d00)
;   0x7913..0x7916  (3 bytes)
DATA_rle_col_7913:
	defb 010h,0feh,000h	; 7913

; ----------------------------------------------------------------------
; DATOS rle_col_7916: colores RLE: 3 tiles desde el 58 (lista 0x6d00)
;   0x7916..0x7919  (3 bytes)
DATA_rle_col_7916:
	defb 018h,0feh,000h	; 7916

; ----------------------------------------------------------------------
; DATOS rle_col_7919: colores RLE: 6 tiles desde el 61 (lista 0x6d00)
;   0x7919..0x7920  (7 bytes)
DATA_rle_col_7919:
	defb 008h,0feh,008h,0e9h,020h,095h,000h	; 7919

; ----------------------------------------------------------------------
; DATOS rle_pat_7920: patrones RLE: 66 tiles desde el 1 (lista 0x6dea)
;   0x7920..0x7b34  (532 bytes)
DATA_rle_pat_7920:
	defb 0ffh,0aah,055h,0aah,055h,0aah,055h,0aah,055h,033h,033h,0cch,0cch,033h,033h,0cch	; 7920  ..U.U.U.U33..33.
	defb 0cch,0aah,055h,0aah,058h,0b3h,063h,0cch,08ch,0aah,055h,0aah,015h,0e2h,039h,0c4h	; 7930  ..U.X.c...U...9.
	defb 0ceh,0abh,056h,0ach,058h,0b3h,063h,0cch,08ch,02ah,0c5h,0f0h,0cch,033h,033h,0cch	; 7940  ..V.X.c..*...33.
	defb 0cch,0aah,055h,00ah,0e5h,032h,039h,0cch,0c9h,0aah,055h,0aah,055h,0aah,055h,0a8h	; 7950  ..U..29...U.U.U.
	defb 051h,0abh,056h,0ach,058h,0b3h,063h,000h,015h,033h,033h,0cch,0cch,033h,0f3h,00ch	; 7960  Q.V.X.c..33..3..
	defb 043h,032h,025h,0cah,0d5h,04ah,015h,0aah,095h,0abh,051h,0ach,058h,0b0h,062h,00ah	; 7970  C2%..J....Q.X.b.
	defb 012h,04ah,055h,02ah,055h,02ah,055h,02ah,054h,0a8h,055h,0aah,041h,080h,070h,0f8h	; 7980  .JU*U*U*T.U.A.p.
	defb 0feh,073h,023h,09ch,048h,0a7h,052h,029h,054h,033h,032h,0cch,0c9h,032h,025h,0cah	; 7990  .s#.H.R)T32..2%.
	defb 0bch,015h,02ah,055h,0aah,055h,0aah,055h,0aah,055h,0a2h,057h,0a7h,057h,0a6h,057h	; 79a0  ..*U.U.U.U.W.W.W
	defb 0a8h,054h,02ah,055h,02ah,005h,060h,0f7h,0efh,06fh,03ch,000h,0a1h,01dh,03eh,0bah	; 79b0  .T*U*.`..o<...>.
	defb 0c2h,0c0h,02ah,055h,02ah,055h,02ah,015h,042h,074h,033h,008h,080h,049h,09ah,059h	; 79c0  ..*U*U*.Bt3..I.Y
	defb 0bah,039h,08fh,047h,0a3h,051h,0a9h,052h,0abh,051h,0e0h,0f0h,0fch,004h,0ffh,0ffh	; 79d0  .9.G.Q.R.Q......
	defb 0feh,067h,06fh,0e7h,080h,000h,005h,00ah,015h,09ah,0b9h,0f2h,005h,0aah,055h,0aah	; 79e0  .go...........U.
	defb 055h,0a9h,055h,0a9h,055h,0a8h,054h,0aah,054h,0fch,0fch,0ffh,0ffh,0feh,03ch,0c0h	; 79f0  U.U.U.T.T.....<.
	defb 0ebh,00ah,095h,08ah,015h,00ah,015h,02ah,015h,0a9h,055h,0a9h,055h,0a9h,055h,0a9h	; 7a00  .......*..U.U.U.
	defb 055h,08ah,0e9h,037h,0c4h,0b5h,095h,082h,081h,04ah,0d5h,02ah,0e5h,0eah,075h,0f2h	; 7a10  U..7.....J.*..u.
	defb 0f5h,0aah,055h,0eeh,055h,0aah,0ddh,0aah,055h,0a9h,055h,0edh,055h,0a9h,0d4h,0a9h	; 7a20  ..U.U...U.U.U...
	defb 053h,0c0h,0c4h,0ceh,0c5h,0cah,0cdh,0cah,095h,0fah,0f9h,07ch,07dh,0bch,03eh,09eh	; 7a30  S..........|}.>.
	defb 04eh,0aah,053h,0abh,053h,0abh,053h,0abh,053h,00ah,095h,08ah,095h,08ah,095h,00ah	; 7a40  N.S.S.S.S.......
	defb 015h,0afh,047h,0a1h,051h,0a0h,053h,0a0h,051h,02ah,055h,0aah,015h,02ah,015h,0ffh	; 7a50  ..G.Q.S.Q*U..*..
	defb 02ah,015h,0abh,053h,0abh,050h,0ach,052h,0a0h,050h,00ah,015h,08ah,095h,00ah,015h	; 7a60  *..S.P.R.P......
	defb 00ah,015h,0a8h,050h,0a8h,050h,0a8h,054h,0aah,055h,02ah,015h,02ah,015h,00ah,005h	; 7a70  ...P.P.T.U*.*...
	defb 02ah,005h,0aah,054h,0a8h,050h,0a8h,050h,0a9h,054h,00ah,005h,002h,009h,038h,06eh	; 7a80  *..T.P.P.T....8n
	defb 0dch,038h,0aah,055h,0aah,055h,00ah,001h,00ch,00bh,0aah,055h,0aah,055h,0aah,055h	; 7a90  .8.U.U.....U.U.U
	defb 02ah,095h,0a9h,054h,0abh,053h,0a7h,057h,0afh,04fh,0f0h,0c4h,00ch,064h,03ch,0c0h	; 7aa0  *..T.S.W.O...d<.
	defb 0f8h,0bfh,015h,000h,028h,015h,02ah,015h,02ah,015h,0c2h,039h,00ah,001h,0aah,055h	; 7ab0  ....(.*.*..9...U
	defb 0aah,055h,0aeh,04fh,0a7h,056h,0a2h,050h,0a8h,054h,03fh,03eh,098h,04eh,0c4h,0e0h	; 7ac0  .U.O.V.P.T?>.N..
	defb 0feh,07fh,02ah,015h,02ah,015h,02ah,015h,00ah,085h,0aah,040h,083h,04ch,0a0h,0d3h	; 7ad0  ..*.*.*....@.L..
	defb 053h,0a8h,054h,0a8h,010h,003h,0cch,0cch,033h,033h,0cch,01fh,001h,030h,0cch,0cch	; 7ae0  S.T.....33...0..
	defb 033h,033h,0cch,0c0h,0e2h,019h,0c0h,0cch,033h,033h,0cch,0aah,055h,02ah,015h,042h	; 7af0  33......33..U*.B
	defb 011h,00ch,0c3h,0aah,055h,0aah,055h,0aah,055h,02ah,015h,00ch,033h,080h,049h,0a1h	; 7b00  ....U.U.U*..3.I.
	defb 054h,0a9h,053h,0cch,03eh,000h,0c4h,0cah,0c5h,0cah,095h,084h,001h,038h,07dh,03ch	; 7b10  T.S.>........8}<
	defb 03eh,09eh,04eh,0cch,033h,078h,000h,0aah,055h,0aah,055h,0c2h,031h,0cch,000h,0aah	; 7b20  >.N.3x..U.U.1...
	defb 055h,0aah,055h,000h	; 7b30

; ----------------------------------------------------------------------
; DATOS rle_col_7B34: colores RLE: 66 tiles desde el 1 (lista 0x6dea)
;   0x7b34..0x7b3f  (11 bytes)
DATA_rle_col_7B34:
	defb 07fh,0f1h,07fh,0f1h,07fh,0f1h,07fh,0f1h,014h,0f1h,000h	; 7b34  ...........

; ----------------------------------------------------------------------
; DATOS rle_pat_7B3F: patrones RLE: 1 tiles desde el 247 (lista 0x6c36)
;   0x7b3f..0x7b42  (3 bytes)
DATA_rle_pat_7B3F:
	defb 008h,018h,000h	; 7b3f

; ----------------------------------------------------------------------
; DATOS rle_col_7B42: colores RLE: 1 tiles desde el 247 (lista 0x6c36)
;   0x7b42..0x7b45  (3 bytes)
DATA_rle_col_7B42:
	defb 008h,081h,000h	; 7b42

; ----------------------------------------------------------------------
; DATOS rle_pat_7B45: patrones RLE: 1 tiles desde el 255 (lista 0x6c36)
;   0x7b45..0x7b4f  (10 bytes)
DATA_rle_pat_7B45:
	defb 002h,000h,002h,018h,084h,000h,018h,018h,000h,000h	; 7b45  ..........

; ----------------------------------------------------------------------
; DATOS rle_col_7B4F: colores RLE: 1 tiles desde el 255 (lista 0x6c36)
;   0x7b4f..0x7b52  (3 bytes)
DATA_rle_col_7B4F:
	defb 008h,0f1h,000h	; 7b4f

; ----------------------------------------------------------------------
; DATOS rle_pat_7B52: patrones RLE: 2 tiles desde el 220 (lista 0x6c7c)
;   0x7b52..0x7b5b  (9 bytes)
DATA_rle_pat_7B52:
	defb 081h,0ffh,00ah,000h,081h,0ffh,004h,000h,000h	; 7b52  .........

; ----------------------------------------------------------------------
; DATOS rle_pat_7B5B: patrones RLE: 1 tiles desde el 223 (lista 0x6c7c)
;   0x7b5b..0x7b5e  (3 bytes)
DATA_rle_pat_7B5B:
	defb 008h,080h,000h	; 7b5b

; ----------------------------------------------------------------------
; DATOS rle_pat_7B5E: patrones RLE: 5 tiles desde el 239 (lista 0x6c7c)
;   0x7b5e..0x7b87  (41 bytes)
DATA_rle_pat_7B5E:
	defb 090h,003h,00ch,030h,020h,040h,040h,080h,080h,001h,002h,004h,018h,060h,040h,080h	; 7b5e  ...0 @@......`@.
	defb 080h,003h,000h,085h,00fh,030h,040h,040h,080h,004h,000h,08ch,003h,00ch,030h,0c0h	; 7b6e  .....0@@......0.
	defb 003h,00ch,008h,010h,010h,020h,040h,080h,000h	; 7b7e  ..... @..

; ----------------------------------------------------------------------
; DATOS rle_pat_7B87: patrones RLE: 1 tiles desde el 245 (lista 0x6c7c)
;   0x7b87..0x7b91  (10 bytes)
DATA_rle_pat_7B87:
	defb 088h,001h,002h,004h,008h,010h,020h,040h,080h,000h	; 7b87  ...... @..

; ----------------------------------------------------------------------
; DATOS rle_pat_7B91: patrones RLE: 1 tiles desde el 248 (lista 0x6c7c)
;   0x7b91..0x7b99  (8 bytes)
DATA_rle_pat_7B91:
	defb 084h,000h,018h,066h,081h,004h,000h,000h	; 7b91  ...f....

; ----------------------------------------------------------------------
; DATOS rle_pat_7B99: patrones RLE: 1 tiles desde el 247 (lista 0x6c7c)
;   0x7b99..0x7b9e  (5 bytes)
DATA_rle_pat_7B99:
	defb 004h,080h,004h,000h,000h	; 7b99

; ----------------------------------------------------------------------
; DATOS rle_pat_7B9E: patrones RLE: 3 tiles desde el 249 (lista 0x6c7c)
;   0x7b9e..0x7bb4  (22 bytes)
DATA_rle_pat_7B9E:
	defb 082h,003h,004h,004h,008h,084h,004h,003h,080h,080h,004h,040h,002h,080h,004h,081h	; 7b9e  ...........@....
	defb 002h,042h,082h,066h,018h,000h	; 7bae

; ----------------------------------------------------------------------
; DATOS rle_col_7BB4: colores RLE: 2 tiles desde el 220 (lista 0x6c7c)
;   0x7bb4..0x7bb7  (3 bytes)
DATA_rle_col_7BB4:
	defb 010h,090h,000h	; 7bb4

; ----------------------------------------------------------------------
; DATOS rle_col_7BB7: colores RLE: 1 tiles desde el 248 (lista 0x6c7c)
;   0x7bb7..0x7bba  (3 bytes)
DATA_rle_col_7BB7:
	defb 008h,090h,000h	; 7bb7

; ----------------------------------------------------------------------
; DATOS rle_col_7BBA: colores RLE: 3 tiles desde el 249 (lista 0x6c7c)
;   0x7bba..0x7bbd  (3 bytes)
DATA_rle_col_7BBA:
	defb 018h,090h,000h	; 7bba

; ----------------------------------------------------------------------
; DATOS rle_col_7BBD: colores RLE: 5 tiles desde el 239 (lista 0x6c7c)
;   0x7bbd..0x7bc0  (3 bytes)
DATA_rle_col_7BBD:
	defb 028h,090h,000h	; 7bbd

; ----------------------------------------------------------------------
; DATOS rle_pat_7BC0: patrones RLE: 8 tiles desde el 232 (lista 0x6bbd)
;   0x7bc0..0x7bfa  (58 bytes)
DATA_rle_pat_7BC0:
	defb 002h,000h,085h,063h,055h,049h,041h,041h,004h,000h,084h,05eh,048h,044h,05eh,004h	; 7bc0  ...cUIAA...^HD^.
	defb 000h,084h,0f5h,045h,025h,0f5h,004h,000h,089h,0e9h,02dh,02bh,0e9h,000h,000h,07ch	; 7bd0  ...E%.....-+...|
	defb 044h,07dh,003h,041h,004h,000h,084h,0deh,048h,044h,0deh,004h,000h,081h,0bah,003h	; 7be0  D}.A....HD......
	defb 092h,004h,000h,085h,0e9h,0adh,0abh,0e9h,000h,000h	; 7bf0  ..........

; ----------------------------------------------------------------------
; DATOS rle_pat_7BFA: patrones RLE: 3 tiles desde el 248 (lista 0x6c36)
;   0x7bfa..0x7c14  (26 bytes)
DATA_rle_pat_7BFA:
	defb 098h,000h,043h,044h,044h,047h,044h,074h,000h,000h,038h,0a5h,0a5h,0b8h,0a0h,0a1h	; 7bfa  ..CDDGDt..8.....
	defb 000h,000h,0e0h,000h,0c0h,020h,020h,0c0h,000h,000h	; 7c0a  .....  ...

; ----------------------------------------------------------------------
; DATOS rle_col_7C14: colores RLE: 8 tiles desde el 232 (lista 0x6bbd)
;   0x7c14..0x7c17  (3 bytes)
DATA_rle_col_7C14:
	defb 040h,091h,000h	; 7c14

; ----------------------------------------------------------------------
; DATOS rle_col_7C17: colores RLE: 3 tiles desde el 248 (lista 0x6c36)
;   0x7c17..0x7c1a  (3 bytes)
DATA_rle_col_7C17:
	defb 018h,091h,000h	; 7c17

; ----------------------------------------------------------------------
; DATOS rle_pat_7C1A: patrones RLE: 8 tiles desde el 210 (lista 0x6bbd)
;   0x7c1a..0x7c37  (29 bytes)
DATA_rle_pat_7C1A:
	defb 008h,010h,008h,002h,007h,000h,081h,01fh,007h,000h,081h,0ffh,007h,000h,081h,0feh	; 7c1a  ................
	defb 007h,010h,081h,00fh,007h,000h,081h,0ffh,007h,002h,081h,0fch,000h	; 7c2a  .............

; ----------------------------------------------------------------------
; DATOS rle_col_7C37: colores RLE: 8 tiles desde el 210 (lista 0x6bbd)
;   0x7c37..0x7c40  (9 bytes)
DATA_rle_col_7C37:
	defb 02fh,040h,009h,070h,007h,040h,081h,070h,000h	; 7c37  /@.p.@.p.

; ----------------------------------------------------------------------
; DATOS rle_pat_7C40: patrones RLE: 3 tiles desde el 253 (lista 0x6c6f)
;   0x7c40..0x7c5a  (26 bytes)
DATA_rle_pat_7C40:
	defb 098h,03fh,040h,047h,048h,080h,080h,087h,088h,050h,050h,057h,05ch,054h,044h,04fh	; 7c40  .?@GH....PPW\TDO
	defb 0d0h,096h,090h,096h,090h,096h,040h,07fh,000h,000h	; 7c50  ......@...

; ----------------------------------------------------------------------
; DATOS rle_pat_7C5A: patrones RLE: 3 tiles desde el 253 (lista 0x6c55)
;   0x7c5a..0x7c74  (26 bytes)
DATA_rle_pat_7C5A:
	defb 098h,03fh,022h,03eh,002h,072h,052h,072h,03ch,021h,022h,022h,023h,024h,024h,03ch	; 7c5a  .?">.rRr<!""#$$<
	defb 004h,07bh,04ah,04ah,07bh,002h,01fh,010h,01fh,000h	; 7c6a  .{JJ{.....

; ----------------------------------------------------------------------
; DATOS rle_pat_7C74: patrones RLE: 3 tiles desde el 253 (lista 0x6c62)
;   0x7c74..0x7c8e  (26 bytes)
DATA_rle_pat_7C74:
	defb 08eh,03fh,050h,053h,074h,043h,044h,048h,078h,04ch,04bh,048h,04fh,078h,04fh,003h	; 7c74  .?PStCDHxLKHOxO.
	defb 049h,002h,048h,081h,07fh,003h,040h,081h,07fh,000h	; 7c84  I.H...@...

; ----------------------------------------------------------------------
; DATOS rle_col_7C8E: colores RLE: 3 tiles desde el 253 (lista 0x6c55)
;   0x7c8e..0x7c91  (3 bytes)
DATA_rle_col_7C8E:
	defb 018h,060h,000h	; 7c8e

; ----------------------------------------------------------------------
; DATOS rle_pat_7C91: patrones RLE: 2 tiles desde el 210 (lista 0x6bbd)
;   0x7c91..0x7c96  (5 bytes)
DATA_rle_pat_7C91:
	defb 008h,010h,008h,002h,000h	; 7c91

; ----------------------------------------------------------------------
; DATOS rle_col_7C96: colores RLE: 2 tiles desde el 210 (lista 0x6bbd)
;   0x7c96..0x7c99  (3 bytes)
DATA_rle_col_7C96:
	defb 010h,040h,000h	; 7c96

; ----------------------------------------------------------------------
; DATOS rle_pat_7C99: patrones RLE: 43 tiles desde el 212 (lista 0x6bbd)
;   0x7c99..0x7d8b  (242 bytes)
DATA_rle_pat_7C99:
	defb 085h,000h,0feh,0eeh,0fch,0eeh,004h,000h,003h,0eeh,081h,0feh,004h,000h,084h,0e6h	; 7c99  ................
	defb 0feh,0feh,0ceh,007h,000h,081h,0ffh,004h,000h,085h,07bh,042h,07bh,00ah,07ah,003h	; 7ca9  ..........{B{.z.
	defb 000h,085h,0ddh,051h,0ddh,011h,01dh,003h,000h,085h,0dch,012h,0d2h,012h,0dch,006h	; 7cb9  ...Q............
	defb 000h,081h,0ffh,003h,001h,003h,000h,085h,00fh,03fh,0ffh,0f0h,0c0h,003h,000h,003h	; 7cc9  .........?......
	defb 07eh,005h,000h,003h,07eh,002h,000h,008h,001h,002h,003h,002h,00ch,002h,030h,002h	; 7cd9  ~...~.........0.
	defb 0c0h,086h,000h,0c0h,0c0h,0dbh,0e3h,0dbh,005h,000h,083h,06ch,0fch,06dh,003h,000h	; 7ce9  ...........l.m..
	defb 002h,018h,089h,05bh,09fh,01bh,000h,000h,003h,003h,00ch,00ch,004h,000h,085h,0a6h	; 7cf9  ...[............
	defb 042h,0a2h,000h,0ffh,003h,000h,085h,0f7h,094h,0f7h,000h,0ffh,003h,000h,085h,0bch	; 7d09  B...............
	defb 0a4h,0bch,000h,0ffh,047h,000h,081h,00fh,003h,008h,004h,001h,081h,0ffh,006h,000h	; 7d19  ....G...........
	defb 085h,0eah,08ah,0eah,08ah,08eh,003h,000h,085h,0e8h,088h,0e8h,088h,0eeh,003h,000h	; 7d29  ................
	defb 003h,07eh,004h,000h,081h,07eh,003h,0eeh,081h,0fch,003h,000h,081h,03ch,004h,01ch	; 7d39  .~...~.......<..
	defb 003h,000h,085h,0feh,00eh,0feh,0e0h,0feh,003h,000h,085h,0feh,00eh,03ch,00eh,0feh	; 7d49  .............<..
	defb 003h,000h,085h,01eh,02eh,04eh,0feh,00eh,003h,000h,085h,0feh,0e0h,0feh,00eh,0fch	; 7d59  .....N..........
	defb 003h,000h,085h,07eh,0e0h,0feh,0eeh,0feh,003h,000h,085h,0feh,01ch,038h,070h,0e0h	; 7d69  ...~.........8p.
	defb 003h,000h,085h,0feh,0eeh,07ch,0eeh,0feh,003h,000h,086h,0feh,0eeh,0feh,00eh,0fch	; 7d79  .....|..........
	defb 000h,000h	; 7d89

; ----------------------------------------------------------------------
; DATOS rle_col_7D8B: colores RLE: 43 tiles desde el 212 (lista 0x6bbd)
;   0x7d8b..0x7dc0  (53 bytes)
DATA_rle_col_7D8B:
	defb 018h,090h,008h,040h,018h,090h,008h,040h,008h,0a0h,004h,090h,081h,0a0h,003h,090h	; 7d8b  ...@...@........
	defb 008h,080h,008h,040h,008h,0a0h,018h,060h,008h,0a0h,003h,0e0h,005h,040h,003h,0e0h	; 7d9b  ...@...`.....@..
	defb 005h,040h,003h,0e0h,005h,040h,040h,000h,00dh,040h,013h,070h,003h,0e0h,003h,080h	; 7dab  .@...@@..@.p....
	defb 002h,0e0h,050h,0f0h,000h	; 7dbb

; ----------------------------------------------------------------------
; DATOS rle_pat_7DC0: patrones RLE: 32 tiles desde el 212 (lista 0x6bbd)
;   0x7dc0..0x7ea3  (227 bytes)
DATA_rle_pat_7DC0:
	defb 085h,0a2h,0b2h,0aah,0a6h,0a2h,003h,000h,085h,0f7h,084h,0f4h,084h,087h,003h,000h	; 7dc0  ................
	defb 085h,0bdh,0a5h,0adh,0a9h,0a5h,003h,000h,085h,0f3h,054h,057h,054h,054h,003h,000h	; 7dd0  ..........TWTT..
	defb 081h,03ah,004h,092h,003h,000h,085h,0f4h,096h,095h,094h,0f4h,003h,000h,085h,07fh	; 7de0  .:..............
	defb 040h,040h,0c0h,040h,003h,000h,081h,0ffh,007h,000h,081h,0f0h,004h,010h,082h,038h	; 7df0  @@.@...........8
	defb 010h,006h,000h,086h,001h,002h,004h,000h,000h,0feh,004h,010h,003h,000h,085h,0bfh	; 7e00  ................
	defb 0a1h,0afh,0a2h,0a3h,003h,000h,085h,07eh,040h,07eh,040h,07eh,003h,000h,08ch,07ch	; 7e10  .......~@~@~...|
	defb 040h,07ch,040h,040h,000h,008h,010h,020h,040h,000h,07eh,004h,000h,085h,0fdh,085h	; 7e20  @|@@... @.~.....
	defb 0f9h,085h,0fdh,003h,000h,085h,0f9h,00ah,07ah,013h,01ah,003h,000h,085h,0e4h,014h	; 7e30  ........z.......
	defb 017h,0f4h,014h,003h,000h,085h,05fh,090h,01fh,090h,05fh,004h,000h,084h,01eh,020h	; 7e40  ......_..._.... 
	defb 040h,080h,003h,000h,085h,0fdh,081h,0fdh,081h,0fdh,003h,000h,085h,085h,045h,025h	; 7e50  @.............E%
	defb 015h,00dh,003h,000h,085h,0fah,002h,03ah,00ah,0fah,003h,000h,085h,0c2h,0a2h,092h	; 7e60  .......:........
	defb 08ah,086h,003h,000h,085h,0f8h,080h,0f8h,080h,0f8h,003h,000h,084h,080h,060h,018h	; 7e70  ..............`.
	defb 007h,004h,000h,086h,07ch,044h,07ch,048h,044h,000h,007h,010h,081h,01fh,007h,002h	; 7e80  ....|D|HD.......
	defb 081h,0feh,004h,000h,081h,0ffh,005h,000h,081h,0ffh,003h,07eh,081h,0ffh,008h,000h	; 7e90  ...........~....
	defb 081h,0ffh,000h	; 7ea0

; ----------------------------------------------------------------------
; DATOS rle_col_7EA3: colores RLE: 32 tiles desde el 212 (lista 0x6bbd)
;   0x7ea3..0x7ec6  (35 bytes)
DATA_rle_col_7EA3:
	defb 048h,070h,008h,040h,018h,060h,008h,0a0h,004h,040h,081h,060h,003h,040h,020h,060h	; 7ea3  Hp.@.`...@.`.@ `
	defb 008h,040h,028h,060h,008h,040h,008h,0a0h,018h,040h,003h,080h,003h,0a8h,002h,080h	; 7eb3  .@(`.@...@......
	defb 008h,040h,000h	; 7ec3

; ----------------------------------------------------------------------
; DATOS rle_pat_7EC6: patrones RLE: 44 tiles desde el 212 (lista 0x6c36)
;   0x7ec6..0x7ffb  (309 bytes)
DATA_rle_pat_7EC6:
	defb 002h,000h,081h,07ch,003h,0eeh,081h,07ch,003h,000h,081h,03ch,003h,01ch,081h,03eh	; 7ec6  ...|...|...<...>
	defb 003h,000h,085h,0feh,00eh,0feh,0e0h,0feh,003h,000h,085h,0fch,00eh,07ch,00eh,0fch	; 7ed6  .............|..
	defb 003h,000h,085h,01eh,03eh,06eh,0feh,00eh,003h,000h,085h,0feh,0e0h,0fch,00eh,0fch	; 7ee6  ....>n..........
	defb 003h,000h,085h,07eh,0e0h,0fch,0eeh,07eh,003h,000h,085h,0feh,01ch,038h,070h,0e0h	; 7ef6  ...~...~.....8p.
	defb 003h,000h,085h,07ch,0eeh,07ch,0eeh,07ch,003h,000h,085h,07ch,0eeh,07eh,00eh,0fch	; 7f06  ...|.|.|...|.~..
	defb 003h,000h,081h,0ffh,004h,0dbh,003h,000h,085h,0feh,0e0h,0fch,0e0h,0feh,004h,000h	; 7f16  ................
	defb 084h,0feh,0e0h,0fch,0e0h,003h,000h,081h,0feh,004h,038h,003h,000h,085h,03eh,060h	; 7f26  ..........8...>`
	defb 06eh,066h,07eh,003h,000h,085h,07eh,060h,07eh,006h,07eh,003h,000h,085h,0fdh,085h	; 7f36  nf~...~`~.~.....
	defb 0f9h,085h,0fdh,003h,000h,085h,0f9h,00ah,07ah,013h,01ah,003h,000h,085h,0e4h,014h	; 7f46  ........z.......
	defb 017h,0f4h,014h,003h,000h,085h,05fh,090h,01fh,090h,05fh,003h,000h,085h,0fdh,081h	; 7f56  ......_..._.....
	defb 0fdh,081h,0fdh,003h,000h,085h,085h,045h,025h,015h,00dh,003h,000h,085h,0fah,002h	; 7f66  .......E%.......
	defb 03ah,00ah,0fah,003h,000h,085h,0c2h,0a2h,092h,08ah,086h,003h,000h,085h,0fch,080h	; 7f76  :...............
	defb 0fch,080h,0fch,003h,000h,081h,0feh,004h,010h,003h,000h,085h,0bfh,0a1h,0afh,0a2h	; 7f86  ................
	defb 0a3h,003h,000h,085h,07eh,040h,07eh,040h,07eh,003h,000h,085h,078h,040h,078h,040h	; 7f96  ....~@~@~...x@x@
	defb 040h,003h,000h,085h,07ch,044h,07ch,048h,044h,003h,000h,085h,00eh,010h,01eh,002h	; 7fa6  @...|D|HD.......
	defb 01ch,004h,000h,084h,080h,0a0h,0cdh,0aah,004h,000h,002h,028h,082h,0aeh,0cah,003h	; 7fb6  ...........(....
	defb 000h,081h,03eh,003h,020h,081h,03eh,003h,000h,002h,022h,084h,03eh,022h,022h,000h	; 7fc6  ..>. .>...".>"".
	defb 008h,018h,003h,000h,004h,0ffh,004h,000h,004h,00fh,004h,000h,004h,0feh,004h,000h	; 7fd6  ................
	defb 002h,0feh,006h,000h,002h,0feh,006h,000h,002h,0feh,006h,000h,002h,0feh,006h,000h	; 7fe6  ................
	defb 004h,0feh,081h,000h,000h	; 7ff6

; ----------------------------------------------------------------------
; DATOS rle_col_7FFB: colores RLE: 44 tiles desde el 212 (lista 0x6c36)
;   0x7ffb..0x8000  (5 bytes)
DATA_rle_col_7FFB:
	defb 07fh,0f1h,061h,0f1h,010h	; 7ffb
