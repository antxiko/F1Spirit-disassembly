; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 04 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS tabla_recursos_tiles: 85 recursos de tiles de 5 B (flags, patrones,
;   colores) que las listas piden con la orden 0x17 (CARGA_RECURSO_85,
;   0x4E9F), y el tile lo dice la orden
;   0x6000..0x61a9  (425 bytes)
DATA_tabla_recursos_tiles:
	defb 0e5h,0b3h,0b4h,0beh,0bbh	; 6000
	defb 0e5h,0bdh,0b4h,0c8h,0bbh	; 6005
	defb 0e5h,0b3h,0b4h,0d9h,0bbh	; 600a
	defb 0e5h,0bdh,0b4h,0e3h,0bbh	; 600f
	defb 0e5h,0bdh,0b4h,0f4h,0bbh	; 6014
	defb 081h,0abh,091h,09ah,09ch	; 6019
	defb 041h,00ch,092h,0cch,09ch	; 601e
	defb 021h,073h,092h,000h,09dh	; 6023
	defb 081h,06dh,091h,07ch,09ch	; 6028
	defb 041h,0ech,091h,07ch,09ch	; 602d
	defb 021h,035h,092h,07ch,09ch	; 6032
	defb 081h,06dh,091h,083h,09ch	; 6037
	defb 041h,0ech,091h,083h,09ch	; 603c
	defb 021h,035h,092h,083h,09ch	; 6041
	defb 0e1h,0e9h,093h,034h,09eh	; 6046
	defb 0e1h,0e2h,093h,029h,09eh	; 604b
	defb 081h,0b2h,092h,02bh,09dh	; 6050
	defb 041h,0dbh,092h,03ah,09dh	; 6055
	defb 021h,000h,093h,049h,09dh	; 605a
	defb 081h,0b2h,092h,05ah,09dh	; 605f
	defb 041h,0dbh,092h,069h,09dh	; 6064
	defb 021h,000h,093h,078h,09dh	; 6069
	defb 081h,029h,093h,089h,09dh	; 606e
	defb 041h,029h,093h,089h,09dh	; 6073
	defb 021h,029h,093h,089h,09dh	; 6078
	defb 0e1h,04ah,093h,0a3h,09dh	; 607d
	defb 0e1h,04ah,093h,0a3h,09dh	; 6082
	defb 0e1h,04ah,093h,0a3h,09dh	; 6087
	defb 091h,0b2h,092h,02bh,09dh	; 608c
	defb 051h,0dbh,092h,03ah,09dh	; 6091
	defb 031h,000h,093h,049h,09dh	; 6096
	defb 091h,0b2h,092h,05ah,09dh	; 609b
	defb 051h,0dbh,092h,069h,09dh	; 60a0
	defb 031h,000h,093h,078h,09dh	; 60a5
	defb 091h,029h,093h,089h,09dh	; 60aa
	defb 051h,029h,093h,089h,09dh	; 60af
	defb 031h,029h,093h,089h,09dh	; 60b4
	defb 0f1h,04ah,093h,0a3h,09dh	; 60b9
	defb 0f1h,04ah,093h,0a3h,09dh	; 60be
	defb 0f1h,04ah,093h,0a3h,09dh	; 60c3
	defb 0e1h,05ch,093h,0ach,09dh	; 60c8
	defb 0e1h,096h,093h,0dfh,09dh	; 60cd
	defb 0e1h,0c0h,093h,009h,09eh	; 60d2
	defb 0e1h,0ech,093h,03bh,09eh	; 60d7
	defb 0e1h,04ah,094h,069h,09eh	; 60dc
	defb 0f1h,04ah,094h,069h,09eh	; 60e1
	defb 0e1h,015h,09ah,0d0h,09fh	; 60e6
	defb 0e1h,05eh,094h,070h,09eh	; 60eb
	defb 0f1h,05eh,094h,070h,09eh	; 60f0
	defb 0e1h,065h,094h,077h,09eh	; 60f5
	defb 0e9h,065h,094h,077h,09eh	; 60fa
	defb 0e1h,02ah,09ah,0d8h,09fh	; 60ff
	defb 0e1h,02fh,09ah,0dbh,09fh	; 6104
	defb 0e1h,039h,09ah,0e0h,09fh	; 6109
	defb 0e1h,040h,09ah,0e5h,09fh	; 610e
	defb 0e1h,055h,09ah,0e8h,09fh	; 6113
	defb 0e1h,069h,09ch,05ch,0a1h	; 6118
	defb 0e1h,074h,09ch,05fh,0a1h	; 611d
	defb 0e1h,068h,094h,07ch,09eh	; 6122
	defb 0f1h,068h,094h,07ch,09eh	; 6127
	defb 0e9h,068h,094h,07ch,09eh	; 612c
	defb 0f9h,068h,094h,07ch,09eh	; 6131
	defb 0e1h,068h,094h,07fh,09eh	; 6136
	defb 0e9h,068h,094h,07fh,09eh	; 613b
	defb 081h,08ah,094h,082h,09eh	; 6140
	defb 041h,003h,095h,08dh,09eh	; 6145
	defb 021h,078h,095h,098h,09eh	; 614a
	defb 0e3h,02bh,0bbh,078h,0bdh	; 614f
	defb 0f3h,02bh,0bbh,078h,0bdh	; 6154
	defb 0e3h,0cbh,0bbh,0feh,0bdh	; 6159
	defb 0e3h,0ech,0bbh,013h,0beh	; 615e
	defb 0e3h,006h,0bch,026h,0beh	; 6163
	defb 0e3h,0d4h,0bch,08bh,0beh	; 6168
	defb 0e5h,0f4h,0afh,012h,0b5h	; 616d
	defb 0e5h,01ch,0b2h,048h,0b6h	; 6172
	defb 0e5h,02bh,0b2h,04bh,0b6h	; 6177
	defb 0e5h,016h,0b0h,02dh,0b5h	; 617c
	defb 0e5h,02fh,0b0h,034h,0b5h	; 6181
	defb 0e5h,09bh,0b3h,084h,0b6h	; 6186
	defb 0e5h,09eh,0b3h,096h,0b6h	; 618b
	defb 0e5h,09eh,0b3h,099h,0b6h	; 6190
	defb 0e5h,0a3h,0b3h,096h,0b6h	; 6195
	defb 0e5h,0a3h,0b3h,099h,0b6h	; 619a
	defb 0e3h,0efh,080h,07fh,082h	; 619f
	defb 0e3h,0feh,080h,07fh,082h	; 61a4

; ----------------------------------------------------------------------
; DATOS tabla_61A9: 42 punteros a listas del cargador de tiles; indexada por
;   la carrera (E25C) desde CARGA_TILES_CIRCUITO (p00 0x4BDA/0x4BF8); dos
;   juegos de 21: las entradas 21-41 entran por la mitad de las listas de las
;   0-20
;   0x61a9..0x61fd  (84 bytes)
DATA_tabla_61A9:
	defw 06211h	; 61a9  -> DATA_lista_6211
	defw 063e5h	; 61ab  -> DATA_lista_63E5
	defw 06370h	; 61ad  -> DATA_lista_6370
	defw 0639ah	; 61af  -> DATA_lista_639A
	defw 0639ah	; 61b1  -> DATA_lista_639A
	defw 070bbh	; 61b3  -> DATA_lista_70BB
	defw 07101h	; 61b5  -> DATA_lista_7101
	defw 0714ah	; 61b7  -> DATA_lista_714A
	defw 0718ah	; 61b9  -> DATA_lista_718A
	defw 071c0h	; 61bb  -> DATA_lista_71C0
	defw 07226h	; 61bd  -> DATA_lista_7226
	defw 07281h	; 61bf  -> DATA_lista_7281
	defw 072fch	; 61c1  -> DATA_lista_72FC
	defw 0733ch	; 61c3  -> DATA_lista_733C
	defw 0714ah	; 61c5  -> DATA_lista_714A
	defw 07101h	; 61c7  -> DATA_lista_7101
	defw 0733ch	; 61c9  -> DATA_lista_733C
	defw 07281h	; 61cb  -> DATA_lista_7281
	defw 070bbh	; 61cd  -> DATA_lista_70BB
	defw 07388h	; 61cf  -> DATA_lista_7388
	defw 07401h	; 61d1  -> DATA_lista_7401
	defw 062a3h	; 61d3  -> DATA_lista_62A3
	defw 063f9h	; 61d5  -> DATA_lista_63F9
	defw 06384h	; 61d7  -> DATA_lista_6384
	defw 063b7h	; 61d9  -> DATA_lista_63B7
	defw 063b7h	; 61db  -> DATA_lista_63B7
	defw 070cdh	; 61dd  -> DATA_lista_70CD
	defw 07113h	; 61df  -> DATA_lista_7113
	defw 07156h	; 61e1  -> DATA_lista_7156
	defw 0719eh	; 61e3  -> DATA_lista_719E
	defw 071d4h	; 61e5  -> DATA_lista_71D4
	defw 07238h	; 61e7  -> DATA_lista_7238
	defw 072aah	; 61e9  -> DATA_lista_72AA
	defw 0730bh	; 61eb  -> DATA_lista_730B
	defw 07354h	; 61ed  -> DATA_lista_7354
	defw 07156h	; 61ef  -> DATA_lista_7156
	defw 07113h	; 61f1  -> DATA_lista_7113
	defw 07354h	; 61f3  -> DATA_lista_7354
	defw 072aah	; 61f5  -> DATA_lista_72AA
	defw 070cdh	; 61f7  -> DATA_lista_70CD
	defw 073b8h	; 61f9  -> DATA_lista_73B8
	defw 07415h	; 61fb  -> DATA_lista_7415

; ----------------------------------------------------------------------
; DATOS lista_61FD: lista del cargador de tiles (0x4CCD): 2 registros de 6 B,
;   tiles 206-209; la usa p00 0x4BCE/0x4BE3
;   0x61fd..0x620a  (13 bytes)
DATA_lista_61FD:
	defb 0e1h,0ceh,034h,076h,034h,076h	; 61fd
	defb 0f1h,0d0h,034h,076h,034h,076h	; 6203
	defb 000h	; 6209

; ----------------------------------------------------------------------
; DATOS lista_620A: lista del cargador de tiles (0x4CCD): 1 registros de 6 B,
;   tiles 252-255; la usa p00 0x59D3, p01 0x634E
;   0x620a..0x6211  (7 bytes)
DATA_lista_620A:
	defb 081h,0fch,03ah,076h,037h,076h	; 620a
	defb 000h	; 6210

; ----------------------------------------------------------------------
; DATOS lista_6211: lista del cargador de tiles (0x4CCD): 38 registros de 6 B
;   y 36 ordenes, tiles 1-209; la usa tabla_61A9[0]; sigue en la lista de
;   0x62a3
;   0x6211..0x62a3  (146 bytes)
DATA_lista_6211:
	defb 010h,001h,04ah,053h,05ch,07ah,07eh,07eh,07eh,08ch,096h,09bh,0adh,0afh,0b2h,0b8h,0bfh	; 6211  ..JS\z~~~........
	defb 011h,025h,004h	; 6222
	defb 0e1h,0ceh,031h,076h,031h,076h	; 6225
	defb 0f1h,0d0h,031h,076h,031h,076h	; 622b
	defb 017h,037h,0cch	; 6231
	defb 017h,036h,0c9h	; 6234
	defb 017h,033h,0c7h	; 6237
	defb 017h,031h,0c6h	; 623a
	defb 017h,032h,0c5h	; 623d
	defb 017h,030h,0c2h	; 6240
	defb 017h,02fh,0bfh	; 6243
	defb 0e3h,0b8h,0f6h,0bch,0a3h,0beh	; 6246
	defb 017h,047h,0b2h	; 624c
	defb 0e3h,0b0h,0bdh,0bch,07bh,0beh	; 624f
	defb 017h,046h,0adh	; 6255
	defb 0ebh,0aah,0a6h,0bch,070h,0beh	; 6258
	defb 0e3h,0a7h,0a6h,0bch,070h,0beh	; 625e
	defb 017h,039h,0a5h	; 6264
	defb 017h,035h,0a4h	; 6267
	defb 017h,038h,0a2h	; 626a
	defb 017h,033h,0a0h	; 626d
	defb 0e3h,09fh,09eh,0bch,069h,0beh	; 6270
	defb 017h,045h,09bh	; 6276
	defb 017h,048h,09ah	; 6279
	defb 0ebh,099h,0cfh,0bch,088h,0beh	; 627c
	defb 0e3h,098h,0cfh,0bch,088h,0beh	; 6282
	defb 0ebh,096h,0bdh,0bch,07bh,0beh	; 6288
	defb 0ebh,091h,0e1h,0bch,091h,0beh	; 628e
	defb 0e3h,08eh,0e1h,0bch,091h,0beh	; 6294
	defb 017h,048h,08dh	; 629a
	defb 0e3h,08ch,0d7h,0bch,08eh,0beh	; 629d

; ----------------------------------------------------------------------
; DATOS lista_62A3: lista del cargador de tiles (0x4CCD): 25 registros de 6 B
;   y 18 ordenes, tiles 1-139; la usa tabla_61A9[21]
;   0x62a3..0x6370  (205 bytes)
DATA_lista_62A3:
	defb 0e3h,088h,081h,0bch,052h,0beh	; 62a3
	defb 0f3h,085h,067h,0bch,047h,0beh	; 62a9
	defb 0e3h,082h,067h,0bch,047h,0beh	; 62af
	defb 017h,03fh,07eh	; 62b5
	defb 017h,03eh,07ah	; 62b8
	defb 0f3h,073h,033h,0bch,031h,0beh	; 62bb
	defb 0e3h,06ch,033h,0bch,031h,0beh	; 62c1
	defb 017h,047h,066h	; 62c7
	defb 017h,046h,063h	; 62ca
	defb 0e1h,061h,057h,09bh,02ah,0a1h	; 62cd
	defb 0f3h,060h,0e5h,0bbh,00eh,0beh	; 62d3
	defb 0e3h,05fh,0e5h,0bbh,00eh,0beh	; 62d9
	defb 017h,045h,05ch	; 62df
	defb 0f3h,057h,0a1h,0bbh,0dbh,0bdh	; 62e2
	defb 0fbh,055h,091h,0bbh,0d4h,0bdh	; 62e8
	defb 0f3h,053h,091h,0bbh,0d4h,0bdh	; 62ee
	defb 0e3h,04eh,0a1h,0bbh,0dbh,0bdh	; 62f4
	defb 0ebh,04ch,091h,0bbh,0d4h,0bdh	; 62fa
	defb 0e3h,04ah,091h,0bbh,0d4h,0bdh	; 6300
	defb 0e3h,046h,071h,0bbh,0b8h,0bdh	; 6306
	defb 0f3h,043h,057h,0bbh,09fh,0bdh	; 630c
	defb 0e3h,040h,057h,0bbh,09fh,0bdh	; 6312
	defb 0e3h,03ch,035h,0bbh,081h,0bdh	; 6318
	defb 017h,021h,036h	; 631e
	defb 017h,020h,036h	; 6321
	defb 017h,01fh,036h	; 6324
	defb 017h,015h,030h	; 6327
	defb 017h,014h,030h	; 632a
	defb 017h,013h,030h	; 632d
	defb 017h,029h,02bh	; 6330
	defb 017h,044h,02ah	; 6333
	defb 017h,043h,029h	; 6336
	defb 021h,01dh,003h,09bh,0f1h,0a0h	; 6339
	defb 041h,01dh,0b7h,09ah,0bbh,0a0h	; 633f
	defb 081h,01dh,066h,09ah,08ah,0a0h	; 6345
	defb 017h,00eh,00eh	; 634b
	defb 021h,011h,064h,09bh,02fh,0a1h	; 634e
	defb 041h,011h,0bdh,09bh,03eh,0a1h	; 6354
	defb 081h,011h,011h,09ch,04fh,0a1h	; 635a
	defb 017h,00dh,00bh	; 6360
	defb 017h,00ch,00bh	; 6363
	defb 017h,00bh,00bh	; 6366
	defb 0e3h,001h,0d9h,0bah,02eh,0bdh	; 6369
	defb 000h	; 636f

; ----------------------------------------------------------------------
; DATOS lista_6370: lista del cargador de tiles (0x4CCD): 1 registros de 6 B y
;   7 ordenes, tiles 94-97; la usa tabla_61A9[2]; sigue en la lista de 0x6384
;   0x6370..0x6384  (20 bytes)
DATA_lista_6370:
	defb 010h,001h,068h,06ah,06ch,083h,087h,08bh,08fh,093h,093h,093h,0c4h,0c4h,0c4h,0c4h,0c4h	; 6370  ..hjl............
	defb 011h,037h,004h	; 6381

; ----------------------------------------------------------------------
; DATOS lista_6384: lista del cargador de tiles (0x4CCD): 1 registros de 6 B y
;   5 ordenes, tiles 94-97; la usa tabla_61A9[23]
;   0x6384..0x639a  (22 bytes)
DATA_lista_6384:
	defb 013h,015h,064h	; 6384
	defb 017h,00fh,062h	; 6387
	defb 0e1h,05eh,03fh,0b1h,003h,0b2h	; 638a
	defb 013h,085h,064h	; 6390
	defb 013h,0c5h,064h	; 6393
	defb 013h,0cfh,064h	; 6396
	defb 000h	; 6399

; ----------------------------------------------------------------------
; DATOS lista_639A: lista del cargador de tiles (0x4CCD): 1 registros de 6 B y
;   18 ordenes, tiles 59-61; la usa tabla_61A9[3]; sigue en la lista de 0x63b7
;   0x639a..0x63b7  (29 bytes)
DATA_lista_639A:
	defb 010h,001h,05dh,05dh,05dh,06bh,06bh,06bh,06bh,06bh,06bh,06bh,0b5h,0b5h,0b5h,0b5h,0c3h	; 639a  ..]]]kkkkkkk.....
	defb 011h,036h,007h	; 63ab
	defb 013h,095h,06ah	; 63ae
	defb 013h,026h,06ah	; 63b1
	defb 013h,016h,06ah	; 63b4

; ----------------------------------------------------------------------
; DATOS lista_63B7: lista del cargador de tiles (0x4CCD): 1 registros de 6 B y
;   13 ordenes, tiles 59-61; la usa tabla_61A9[24]
;   0x63b7..0x63e5  (46 bytes)
DATA_lista_63B7:
	defb 013h,0e5h,068h	; 63b7
	defb 017h,02bh,066h	; 63ba
	defb 017h,04ch,064h	; 63bd
	defb 017h,02ch,061h	; 63c0
	defb 013h,0a0h,068h	; 63c3
	defb 017h,04ah,050h	; 63c6
	defb 013h,07fh,068h	; 63c9
	defb 013h,0d7h,067h	; 63cc
	defb 0e5h,03bh,00dh,0b0h,024h,0b5h	; 63cf
	defb 013h,01eh,067h	; 63d5
	defb 017h,049h,029h	; 63d8
	defb 013h,0d4h,065h	; 63db
	defb 013h,07bh,065h	; 63de
	defb 013h,000h,065h	; 63e1
	defb 000h	; 63e4

; ----------------------------------------------------------------------
; DATOS lista_63E5: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   11 ordenes, sin registros propios; la usa tabla_61A9[1]; sigue en la lista
;   de 0x63f9
;   0x63e5..0x63f9  (20 bytes)
DATA_lista_63E5:
	defb 010h,001h,078h,078h,078h,084h,088h,08dh,08dh,08dh,08dh,08dh,0c5h,0c5h,0c5h,0c5h,0c5h	; 63e5  ..xxx............
	defb 011h,037h,005h	; 63f6

; ----------------------------------------------------------------------
; DATOS lista_63F9: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   9 ordenes, sin registros propios; la usa tabla_61A9[22]
;   0x63f9..0x6415  (28 bytes)
DATA_lista_63F9:
	defb 013h,0a8h,06ah	; 63f9
	defb 013h,021h,06bh	; 63fc
	defb 017h,00fh,042h	; 63ff
	defb 013h,04fh,06bh	; 6402
	defb 013h,059h,06bh	; 6405
	defb 013h,06ch,06bh	; 6408
	defb 013h,085h,06bh	; 640b
	defb 013h,0c5h,064h	; 640e
	defb 013h,098h,06bh	; 6411
	defb 000h	; 6414

; ----------------------------------------------------------------------
; DATOS lista_6415: lista del cargador de tiles (0x4CCD): 8 registros de 6 B y
;   21 ordenes, tiles 112-205; la usa sublista de 0x6370
;   0x6415..0x6485  (112 bytes)
DATA_lista_6415:
	defb 0e1h,0cdh,079h,09ch,064h,0a1h	; 6415
	defb 017h,037h,0cbh	; 641b
	defb 017h,036h,0c8h	; 641e
	defb 017h,033h,0c6h	; 6421
	defb 017h,031h,0c5h	; 6424
	defb 017h,032h,0c4h	; 6427
	defb 0f1h,0bfh,0b4h,0b1h,02bh,0b2h	; 642a
	defb 0e1h,0bah,0b4h,0b1h,02bh,0b2h	; 6430
	defb 0f1h,0aeh,071h,0b1h,026h,0b2h	; 6436
	defb 0e1h,0a2h,071h,0b1h,026h,0b2h	; 643c
	defb 017h,030h,09fh	; 6442
	defb 017h,02fh,09ch	; 6445
	defb 017h,039h,09ah	; 6448
	defb 017h,035h,099h	; 644b
	defb 017h,037h,097h	; 644e
	defb 017h,038h,095h	; 6451
	defb 017h,033h,093h	; 6454
	defb 017h,03dh,08fh	; 6457
	defb 017h,03ch,08bh	; 645a
	defb 017h,03bh,087h	; 645d
	defb 017h,03ah,083h	; 6460
	defb 017h,02dh,080h	; 6463
	defb 0e1h,07bh,057h,09bh,025h,0a1h	; 6466
	defb 017h,02ch,07dh	; 646c
	defb 0e1h,074h,00bh,094h,04ah,09eh	; 646f
	defb 0e1h,070h,061h,0b1h,023h,0b2h	; 6475
	defb 017h,02bh,06bh	; 647b
	defb 017h,026h,06ah	; 647e
	defb 017h,01ah,068h	; 6481
	defb 000h	; 6484

; ----------------------------------------------------------------------
; DATOS lista_6485: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   15 ordenes, tiles 47-58; la usa sublista de 0x6370
;   0x6485..0x64c5  (64 bytes)
DATA_lista_6485:
	defb 017h,02ah,05ah	; 6485
	defb 017h,029h,055h	; 6488
	defb 017h,022h,052h	; 648b
	defb 017h,023h,052h	; 648e
	defb 017h,024h,052h	; 6491
	defb 017h,016h,04eh	; 6494
	defb 017h,017h,04eh	; 6497
	defb 017h,018h,04eh	; 649a
	defb 017h,028h,047h	; 649d
	defb 017h,01eh,041h	; 64a0
	defb 017h,01dh,041h	; 64a3
	defb 017h,01ch,041h	; 64a6
	defb 017h,012h,03bh	; 64a9
	defb 017h,011h,03bh	; 64ac
	defb 017h,010h,03bh	; 64af
	defb 081h,02fh,066h,09ah,0efh,09fh	; 64b2
	defb 041h,02fh,0b7h,09ah,020h,0a0h	; 64b8
	defb 021h,02fh,003h,09bh,056h,0a0h	; 64be
	defb 000h	; 64c4

; ----------------------------------------------------------------------
; DATOS lista_64C5: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   3 ordenes, sin registros propios; la usa sublista de 0x63e5
;   0x64c5..0x64cf  (10 bytes)
DATA_lista_64C5:
	defb 017h,042h,013h	; 64c5
	defb 017h,041h,013h	; 64c8
	defb 017h,040h,013h	; 64cb
	defb 000h	; 64ce

; ----------------------------------------------------------------------
; DATOS lista_64CF: lista del cargador de tiles (0x4CCD): 5 registros de 6 B y
;   6 ordenes, tiles 4-46; la usa sublista de 0x6370
;   0x64cf..0x6500  (49 bytes)
DATA_lista_64CF:
	defb 0e1h,029h,014h,0b1h,0ech,0b1h	; 64cf
	defb 0e1h,023h,0e9h,0b0h,0d1h,0b1h	; 64d5
	defb 017h,007h,00ah	; 64db
	defb 017h,006h,00ah	; 64de
	defb 017h,005h,00ah	; 64e1
	defb 081h,004h,082h,091h,08ah,09ch	; 64e4
	defb 041h,004h,0f7h,091h,0bfh,09ch	; 64ea
	defb 021h,004h,04ah,092h,0f1h,09ch	; 64f0
	defb 017h,00ah,001h	; 64f6
	defb 017h,009h,001h	; 64f9
	defb 017h,008h,001h	; 64fc
	defb 000h	; 64ff

; ----------------------------------------------------------------------
; DATOS lista_6500: lista del cargador de tiles (0x4CCD): 3 registros de 6 B,
;   tiles 1-14; la usa sublista de 0x639a
;   0x6500..0x6513  (19 bytes)
DATA_lista_6500:
	defb 081h,001h,0efh,095h,0a3h,09eh	; 6500
	defb 041h,001h,053h,096h,0aeh,09eh	; 6506
	defb 021h,001h,0b6h,096h,0bbh,09eh	; 650c
	defb 000h	; 6512

; ----------------------------------------------------------------------
; DATOS lista_6513: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   1 ordenes, tiles 3-14; la usa sublista de 0x70bb
;   0x6513..0x6529  (22 bytes)
DATA_lista_6513:
	defb 081h,003h,011h,09ch,077h,0a2h	; 6513
	defb 041h,003h,0bdh,09bh,059h,0a2h	; 6519
	defb 021h,003h,064h,09bh,039h,0a2h	; 651f
	defb 017h,004h,001h	; 6525
	defb 000h	; 6528

; ----------------------------------------------------------------------
; DATOS lista_6529: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   1 ordenes, tiles 3-14; la usa sublista de 0x7101
;   0x6529..0x653f  (22 bytes)
DATA_lista_6529:
	defb 081h,003h,011h,09ch,06ah,0a2h	; 6529
	defb 041h,003h,0bdh,09bh,048h,0a2h	; 652f
	defb 021h,003h,064h,09bh,02ah,0a2h	; 6535
	defb 017h,003h,001h	; 653b
	defb 000h	; 653e

; ----------------------------------------------------------------------
; DATOS lista_653F: lista del cargador de tiles (0x4CCD): 3 registros de 6 B,
;   tiles 1-14; la usa sublista de 0x72fc
;   0x653f..0x6552  (19 bytes)
DATA_lista_653F:
	defb 081h,001h,0efh,095h,0ceh,0a2h	; 653f
	defb 041h,001h,053h,096h,0d9h,0a2h	; 6545
	defb 021h,001h,0b6h,096h,0e6h,0a2h	; 654b
	defb 000h	; 6551

; ----------------------------------------------------------------------
; DATOS lista_6552: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   1 ordenes, tiles 3-14; la usa sublista de 0x7226
;   0x6552..0x6568  (22 bytes)
DATA_lista_6552:
	defb 081h,003h,011h,09ch,04fh,0a1h	; 6552
	defb 041h,003h,0bdh,09bh,03eh,0a1h	; 6558
	defb 021h,003h,064h,09bh,02fh,0a1h	; 655e
	defb 017h,001h,001h	; 6564
	defb 000h	; 6567

; ----------------------------------------------------------------------
; DATOS lista_6568: lista del cargador de tiles (0x4CCD): 3 registros de 6 B,
;   tiles 1-14; la usa sublista de 0x7388
;   0x6568..0x657b  (19 bytes)
DATA_lista_6568:
	defb 081h,001h,0efh,095h,088h,0a1h	; 6568
	defb 041h,001h,053h,096h,093h,0a1h	; 656e
	defb 021h,001h,0b6h,096h,0a0h,0a1h	; 6574
	defb 000h	; 657a

; ----------------------------------------------------------------------
; DATOS lista_657B: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   3 ordenes, sin registros propios; la usa sublista de 0x639a
;   0x657b..0x6585  (10 bytes)
DATA_lista_657B:
	defb 017h,042h,00fh	; 657b
	defb 017h,041h,00fh	; 657e
	defb 017h,040h,00fh	; 6581
	defb 000h	; 6584

; ----------------------------------------------------------------------
; DATOS lista_6585: lista del cargador de tiles (0x4CCD): 3 registros de 6 B,
;   tiles 15-30; la usa sublista de 0x7101
;   0x6585..0x6598  (19 bytes)
DATA_lista_6585:
	defb 081h,00fh,08ah,094h,084h,0a2h	; 6585
	defb 041h,00fh,003h,095h,09eh,0a2h	; 658b
	defb 021h,00fh,078h,095h,0b6h,0a2h	; 6591
	defb 000h	; 6597

; ----------------------------------------------------------------------
; DATOS lista_6598: lista del cargador de tiles (0x4CCD): 3 registros de 6 B,
;   tiles 15-30; la usa sublista de 0x714a
;   0x6598..0x65ab  (19 bytes)
DATA_lista_6598:
	defb 081h,00fh,08ah,094h,091h,0a2h	; 6598
	defb 041h,00fh,003h,095h,0a9h,0a2h	; 659e
	defb 021h,00fh,078h,095h,0c1h,0a2h	; 65a4
	defb 000h	; 65aa

; ----------------------------------------------------------------------
; DATOS lista_65AB: lista del cargador de tiles (0x4CCD): 3 registros de 6 B,
;   tiles 15-30; la usa sublista de 0x7226
;   0x65ab..0x65be  (19 bytes)
DATA_lista_65AB:
	defb 081h,00fh,08ah,094h,067h,0a1h	; 65ab
	defb 041h,00fh,003h,095h,072h,0a1h	; 65b1
	defb 021h,00fh,078h,095h,07dh,0a1h	; 65b7
	defb 000h	; 65bd

; ----------------------------------------------------------------------
; DATOS lista_65BE: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   1 ordenes, tiles 17-30; la usa sublista de 0x733c
;   0x65be..0x65d4  (22 bytes)
DATA_lista_65BE:
	defb 081h,011h,0efh,095h,0a3h,09eh	; 65be
	defb 041h,011h,053h,096h,0aeh,09eh	; 65c4
	defb 021h,011h,0b6h,096h,0bbh,09eh	; 65ca
	defb 017h,004h,00fh	; 65d0
	defb 000h	; 65d3

; ----------------------------------------------------------------------
; DATOS lista_65D4: lista del cargador de tiles (0x4CCD): 6 registros de 6 B y
;   4 ordenes, tiles 31-34; la usa sublista de 0x639a
;   0x65d4..0x6605  (49 bytes)
DATA_lista_65D4:
	defb 017h,00eh,026h	; 65d4
	defb 017h,00dh,023h	; 65d7
	defb 017h,00ch,023h	; 65da
	defb 017h,00bh,023h	; 65dd
	defb 085h,021h,0d1h,0afh,00fh,0b5h	; 65e0
	defb 085h,01fh,0d1h,0afh,00ch,0b5h	; 65e6
	defb 045h,021h,0dfh,0afh,00fh,0b5h	; 65ec
	defb 045h,01fh,0dfh,0afh,00ch,0b5h	; 65f2
	defb 025h,021h,0e6h,0afh,00fh,0b5h	; 65f8
	defb 025h,01fh,0e6h,0afh,00ch,0b5h	; 65fe
	defb 000h	; 6604

; ----------------------------------------------------------------------
; DATOS lista_6605: lista del cargador de tiles (0x4CCD): 10 registros de 6 B,
;   tiles 31-40; la usa sublista de 0x70bb
;   0x6605..0x6642  (61 bytes)
DATA_lista_6605:
	defb 0e1h,026h,0e9h,093h,001h,0a2h	; 6605
	defb 081h,023h,06dh,091h,0ech,0a1h	; 660b
	defb 041h,023h,0ech,091h,0ech,0a1h	; 6611
	defb 021h,023h,035h,092h,0ech,0a1h	; 6617
	defb 085h,021h,0d1h,0afh,0e3h,0b6h	; 661d
	defb 085h,01fh,0d1h,0afh,0d7h,0b6h	; 6623
	defb 045h,021h,0dfh,0afh,0e3h,0b6h	; 6629
	defb 045h,01fh,0dfh,0afh,0d7h,0b6h	; 662f
	defb 025h,021h,0e6h,0afh,0e3h,0b6h	; 6635
	defb 025h,01fh,0e6h,0afh,0d7h,0b6h	; 663b
	defb 000h	; 6641

; ----------------------------------------------------------------------
; DATOS lista_6642: lista del cargador de tiles (0x4CCD): 6 registros de 6 B y
;   4 ordenes, tiles 31-34; la usa sublista de 0x7101
;   0x6642..0x6673  (49 bytes)
DATA_lista_6642:
	defb 017h,00eh,026h	; 6642
	defb 017h,00dh,023h	; 6645
	defb 017h,00ch,023h	; 6648
	defb 017h,00bh,023h	; 664b
	defb 085h,021h,0d1h,0afh,0ddh,0b6h	; 664e
	defb 085h,01fh,0d1h,0afh,0d1h,0b6h	; 6654
	defb 045h,021h,0dfh,0afh,0ddh,0b6h	; 665a
	defb 045h,01fh,0dfh,0afh,0d1h,0b6h	; 6660
	defb 025h,021h,0e6h,0afh,0ddh,0b6h	; 6666
	defb 025h,01fh,0e6h,0afh,0d1h,0b6h	; 666c
	defb 000h	; 6672

; ----------------------------------------------------------------------
; DATOS lista_6673: lista del cargador de tiles (0x4CCD): 10 registros de 6 B,
;   tiles 31-40; la usa sublista de 0x714a
;   0x6673..0x66b0  (61 bytes)
DATA_lista_6673:
	defb 0e1h,026h,0e9h,093h,008h,0a2h	; 6673
	defb 081h,023h,06dh,091h,0f3h,0a1h	; 6679
	defb 041h,023h,0ech,091h,0f3h,0a1h	; 667f
	defb 021h,023h,035h,092h,0f3h,0a1h	; 6685
	defb 085h,021h,0d1h,0afh,00fh,0b5h	; 668b
	defb 085h,01fh,0d1h,0afh,00ch,0b5h	; 6691
	defb 045h,021h,0dfh,0afh,00fh,0b5h	; 6697
	defb 045h,01fh,0dfh,0afh,00ch,0b5h	; 669d
	defb 025h,021h,0e6h,0afh,00fh,0b5h	; 66a3
	defb 025h,01fh,0e6h,0afh,00ch,0b5h	; 66a9
	defb 000h	; 66af

; ----------------------------------------------------------------------
; DATOS lista_66B0: lista del cargador de tiles (0x4CCD): 6 registros de 6 B y
;   4 ordenes, tiles 31-34; la usa sublista de 0x7226
;   0x66b0..0x66e1  (49 bytes)
DATA_lista_66B0:
	defb 017h,00eh,026h	; 66b0
	defb 017h,00dh,023h	; 66b3
	defb 017h,00ch,023h	; 66b6
	defb 017h,00bh,023h	; 66b9
	defb 085h,021h,0d1h,0afh,0e0h,0b6h	; 66bc
	defb 085h,01fh,0d1h,0afh,0d4h,0b6h	; 66c2
	defb 045h,021h,0dfh,0afh,0e0h,0b6h	; 66c8
	defb 045h,01fh,0dfh,0afh,0d4h,0b6h	; 66ce
	defb 025h,021h,0e6h,0afh,0e0h,0b6h	; 66d4
	defb 025h,01fh,0e6h,0afh,0d4h,0b6h	; 66da
	defb 000h	; 66e0

; ----------------------------------------------------------------------
; DATOS lista_66E1: lista del cargador de tiles (0x4CCD): 10 registros de 6 B,
;   tiles 31-40; la usa sublista de 0x72fc
;   0x66e1..0x671e  (61 bytes)
DATA_lista_66E1:
	defb 0e1h,026h,0e9h,093h,00fh,0a2h	; 66e1
	defb 081h,023h,06dh,091h,0fah,0a1h	; 66e7
	defb 041h,023h,0ech,091h,0fah,0a1h	; 66ed
	defb 021h,023h,035h,092h,0fah,0a1h	; 66f3
	defb 085h,021h,0d1h,0afh,00fh,0b5h	; 66f9
	defb 085h,01fh,0d1h,0afh,0dah,0b6h	; 66ff
	defb 045h,021h,0dfh,0afh,00fh,0b5h	; 6705
	defb 045h,01fh,0dfh,0afh,0dah,0b6h	; 670b
	defb 025h,021h,0e6h,0afh,00fh,0b5h	; 6711
	defb 025h,01fh,0e6h,0afh,0dah,0b6h	; 6717
	defb 000h	; 671d

; ----------------------------------------------------------------------
; DATOS lista_671E: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 44-58; la usa sublista de 0x639a
;   0x671e..0x6743  (37 bytes)
DATA_lista_671E:
	defb 085h,036h,06fh,0b0h,075h,0b5h	; 671e
	defb 045h,036h,0ceh,0b0h,0c9h,0b5h	; 6724
	defb 025h,036h,022h,0b1h,005h,0b6h	; 672a
	defb 085h,02ch,032h,0b0h,046h,0b5h	; 6730
	defb 045h,02ch,092h,0b0h,093h,0b5h	; 6736
	defb 025h,02ch,0f1h,0b0h,0e8h,0b5h	; 673c
	defb 000h	; 6742

; ----------------------------------------------------------------------
; DATOS lista_6743: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 44-58; la usa sublista de 0x70bb
;   0x6743..0x6768  (37 bytes)
DATA_lista_6743:
	defb 085h,036h,06fh,0b0h,053h,0b9h	; 6743
	defb 045h,036h,0ceh,0b0h,0cch,0b9h	; 6749
	defb 025h,036h,022h,0b1h,00ch,0bah	; 674f
	defb 085h,02ch,032h,0b0h,09ch,0b7h	; 6755
	defb 045h,02ch,092h,0b0h,06dh,0b8h	; 675b
	defb 025h,02ch,0f1h,0b0h,0fah,0b8h	; 6761
	defb 000h	; 6767

; ----------------------------------------------------------------------
; DATOS lista_6768: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 44-58; la usa sublista de 0x7101
;   0x6768..0x678d  (37 bytes)
DATA_lista_6768:
	defb 085h,036h,06fh,0b0h,017h,0b9h	; 6768
	defb 045h,036h,0ceh,0b0h,08eh,0b9h	; 676e
	defb 025h,036h,022h,0b1h,005h,0b6h	; 6774
	defb 085h,02ch,032h,0b0h,00fh,0b7h	; 677a
	defb 045h,02ch,092h,0b0h,0cbh,0b7h	; 6780
	defb 025h,02ch,0f1h,0b0h,0a3h,0b8h	; 6786
	defb 000h	; 678c

; ----------------------------------------------------------------------
; DATOS lista_678D: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 44-58; la usa sublista de 0x7226
;   0x678d..0x67b2  (37 bytes)
DATA_lista_678D:
	defb 085h,036h,06fh,0b0h,035h,0b9h	; 678d
	defb 045h,036h,0ceh,0b0h,0adh,0b9h	; 6793
	defb 025h,036h,022h,0b1h,005h,0b6h	; 6799
	defb 085h,02ch,032h,0b0h,03eh,0b7h	; 679f
	defb 045h,02ch,092h,0b0h,001h,0b8h	; 67a5
	defb 025h,02ch,0f1h,0b0h,0c0h,0b8h	; 67ab
	defb 000h	; 67b1

; ----------------------------------------------------------------------
; DATOS lista_67B2: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 44-58; la usa sublista de 0x72fc
;   0x67b2..0x67d7  (37 bytes)
DATA_lista_67B2:
	defb 085h,036h,06fh,0b0h,071h,0b9h	; 67b2
	defb 045h,036h,0ceh,0b0h,0ech,0b9h	; 67b8
	defb 025h,036h,022h,0b1h,02ah,0bah	; 67be
	defb 085h,02ch,032h,0b0h,06dh,0b7h	; 67c4
	defb 045h,02ch,092h,0b0h,037h,0b8h	; 67ca
	defb 025h,02ch,0f1h,0b0h,0ddh,0b8h	; 67d0
	defb 000h	; 67d6

; ----------------------------------------------------------------------
; DATOS lista_67D7: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   6 ordenes, sin registros propios; la usa sublista de 0x639a
;   0x67d7..0x67ea  (19 bytes)
DATA_lista_67D7:
	defb 017h,01eh,044h	; 67d7
	defb 017h,01dh,044h	; 67da
	defb 017h,01ch,044h	; 67dd
	defb 017h,010h,03eh	; 67e0
	defb 017h,011h,03eh	; 67e3
	defb 017h,012h,03eh	; 67e6
	defb 000h	; 67e9

; ----------------------------------------------------------------------
; DATOS lista_67EA: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 62-73; la usa sublista de 0x7101
;   0x67ea..0x680f  (37 bytes)
DATA_lista_67EA:
	defb 091h,044h,0b2h,092h,0f8h,0a2h	; 67ea
	defb 051h,044h,0dbh,092h,034h,0a3h	; 67f0
	defb 031h,044h,000h,093h,070h,0a3h	; 67f6
	defb 081h,03eh,0b2h,092h,0f8h,0a2h	; 67fc
	defb 041h,03eh,0dbh,092h,034h,0a3h	; 6802
	defb 021h,03eh,000h,093h,070h,0a3h	; 6808
	defb 000h	; 680e

; ----------------------------------------------------------------------
; DATOS lista_680F: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 62-73; la usa sublista de 0x714a
;   0x680f..0x6834  (37 bytes)
DATA_lista_680F:
	defb 091h,044h,0b2h,092h,025h,0a3h	; 680f
	defb 051h,044h,0dbh,092h,061h,0a3h	; 6815
	defb 031h,044h,000h,093h,0a3h,0a3h	; 681b
	defb 081h,03eh,0b2h,092h,025h,0a3h	; 6821
	defb 041h,03eh,0dbh,092h,061h,0a3h	; 6827
	defb 021h,03eh,000h,093h,0a3h,0a3h	; 682d
	defb 000h	; 6833

; ----------------------------------------------------------------------
; DATOS lista_6834: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 62-73; la usa sublista de 0x7388
;   0x6834..0x6859  (37 bytes)
DATA_lista_6834:
	defb 091h,044h,0b2h,092h,007h,0a3h	; 6834
	defb 051h,044h,0dbh,092h,043h,0a3h	; 683a
	defb 031h,044h,000h,093h,081h,0a3h	; 6840
	defb 081h,03eh,0b2h,092h,007h,0a3h	; 6846
	defb 041h,03eh,0dbh,092h,043h,0a3h	; 684c
	defb 021h,03eh,000h,093h,081h,0a3h	; 6852
	defb 000h	; 6858

; ----------------------------------------------------------------------
; DATOS lista_6859: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 62-73; la usa sublista de 0x7281
;   0x6859..0x687e  (37 bytes)
DATA_lista_6859:
	defb 091h,044h,0b2h,092h,016h,0a3h	; 6859
	defb 051h,044h,0dbh,092h,052h,0a3h	; 685f
	defb 031h,044h,000h,093h,092h,0a3h	; 6865
	defb 081h,03eh,0b2h,092h,016h,0a3h	; 686b
	defb 041h,03eh,0dbh,092h,052h,0a3h	; 6871
	defb 021h,03eh,000h,093h,092h,0a3h	; 6877
	defb 000h	; 687d

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (1 bytes)
;   0x687e..0x687f  (1 bytes)
DATA_687E:
	defb 000h	; 687e

; ----------------------------------------------------------------------
; DATOS lista_687F: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   2 ordenes, sin registros propios; la usa sublista de 0x639a
;   0x687f..0x6886  (7 bytes)
DATA_lista_687F:
	defb 017h,02ah,04ch	; 687f
	defb 017h,029h,049h	; 6882
	defb 000h	; 6885

; ----------------------------------------------------------------------
; DATOS lista_6886: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   4 ordenes, sin registros propios; la usa sublista de 0x7101
;   0x6886..0x6893  (13 bytes)
DATA_lista_6886:
	defb 017h,02ah,04ch	; 6886
	defb 017h,029h,049h	; 6889
	defb 017h,003h,04eh	; 688c
	defb 017h,002h,04dh	; 688f
	defb 000h	; 6892

; ----------------------------------------------------------------------
; DATOS lista_6893: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   4 ordenes, sin registros propios; la usa sublista de 0x7226
;   0x6893..0x68a0  (13 bytes)
DATA_lista_6893:
	defb 017h,02ah,04ch	; 6893
	defb 017h,029h,049h	; 6896
	defb 017h,001h,04eh	; 6899
	defb 017h,000h,04dh	; 689c
	defb 000h	; 689f

; ----------------------------------------------------------------------
; DATOS lista_68A0: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   8 ordenes, sin registros propios; la usa sublista de 0x639a
;   0x68a0..0x68b9  (25 bytes)
DATA_lista_68A0:
	defb 017h,02eh,05fh	; 68a0
	defb 017h,019h,05dh	; 68a3
	defb 017h,01ah,05dh	; 68a6
	defb 017h,01bh,05dh	; 68a9
	defb 017h,028h,053h	; 68ac
	defb 017h,016h,059h	; 68af
	defb 017h,017h,059h	; 68b2
	defb 017h,018h,059h	; 68b5
	defb 000h	; 68b8

; ----------------------------------------------------------------------
; DATOS lista_68B9: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   1 ordenes, tiles 86-96; la usa sublista de 0x7101
;   0x68b9..0x68cf  (22 bytes)
DATA_lista_68B9:
	defb 0e1h,05fh,015h,09ah,024h,0a2h	; 68b9
	defb 0e1h,05dh,04ah,093h,0afh,0a1h	; 68bf
	defb 017h,028h,053h	; 68c5
	defb 0e5h,056h,0cfh,0b4h,03eh,0bch	; 68c8
	defb 000h	; 68ce

; ----------------------------------------------------------------------
; DATOS lista_68CF: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   1 ordenes, tiles 86-96; la usa sublista de 0x7226
;   0x68cf..0x68e5  (22 bytes)
DATA_lista_68CF:
	defb 0e1h,05fh,015h,09ah,027h,0a2h	; 68cf
	defb 0e1h,05dh,04ah,093h,0b8h,0a1h	; 68d5
	defb 017h,028h,053h	; 68db
	defb 0e5h,056h,0cfh,0b4h,005h,0bch	; 68de
	defb 000h	; 68e4

; ----------------------------------------------------------------------
; DATOS lista_68E5: lista del cargador de tiles (0x4CCD): 10 registros de 6 B,
;   tiles 107-174; la usa sublista de 0x639a
;   0x68e5..0x6922  (61 bytes)
DATA_lista_68E5:
	defb 0e5h,0a7h,0e9h,0b1h,03fh,0b6h	; 68e5
	defb 0f5h,09fh,0e9h,0b1h,03fh,0b6h	; 68eb
	defb 0f5h,097h,0b6h,0b1h,03ah,0b6h	; 68f1
	defb 0e5h,08fh,0b6h,0b1h,03ah,0b6h	; 68f7
	defb 0f5h,087h,080h,0b1h,031h,0b6h	; 68fd
	defb 0e5h,07fh,080h,0b1h,031h,0b6h	; 6903
	defb 0f5h,077h,04ah,0b1h,028h,0b6h	; 6909
	defb 0e5h,06fh,04ah,0b1h,028h,0b6h	; 690f
	defb 0f5h,06dh,047h,0b1h,023h,0b6h	; 6915
	defb 0e5h,06bh,047h,0b1h,023h,0b6h	; 691b
	defb 000h	; 6921

; ----------------------------------------------------------------------
; DATOS lista_6922: lista del cargador de tiles (0x4CCD): 10 registros de 6 B,
;   tiles 107-174; la usa sublista de 0x7101
;   0x6922..0x695f  (61 bytes)
DATA_lista_6922:
	defb 0e5h,0a7h,0e9h,0b1h,03fh,0b6h	; 6922
	defb 0f5h,09fh,0e9h,0b1h,03fh,0b6h	; 6928
	defb 0f5h,097h,0b6h,0b1h,03ah,0b6h	; 692e
	defb 0e5h,08fh,0b6h,0b1h,03ah,0b6h	; 6934
	defb 0f5h,087h,080h,0b1h,086h,0bah	; 693a
	defb 0e5h,07fh,080h,0b1h,086h,0bah	; 6940
	defb 0f5h,077h,04ah,0b1h,048h,0bah	; 6946
	defb 0e5h,06fh,04ah,0b1h,048h,0bah	; 694c
	defb 0f5h,06dh,047h,0b1h,0cch,0b6h	; 6952
	defb 0e5h,06bh,047h,0b1h,0cch,0b6h	; 6958
	defb 000h	; 695e

; ----------------------------------------------------------------------
; DATOS lista_695F: lista del cargador de tiles (0x4CCD): 10 registros de 6 B,
;   tiles 107-174; la usa sublista de 0x7226
;   0x695f..0x699c  (61 bytes)
DATA_lista_695F:
	defb 0e5h,0a7h,0e9h,0b1h,0e8h,0bah	; 695f
	defb 0f5h,09fh,0e9h,0b1h,0e8h,0bah	; 6965
	defb 0f5h,097h,0b6h,0b1h,0c2h,0bah	; 696b
	defb 0e5h,08fh,0b6h,0b1h,0c2h,0bah	; 6971
	defb 0f5h,087h,080h,0b1h,08fh,0bah	; 6977
	defb 0e5h,07fh,080h,0b1h,08fh,0bah	; 697d
	defb 0f5h,077h,04ah,0b1h,051h,0bah	; 6983
	defb 0e5h,06fh,04ah,0b1h,051h,0bah	; 6989
	defb 0f5h,06dh,047h,0b1h,0b9h,0b6h	; 698f
	defb 0e5h,06bh,047h,0b1h,0b9h,0b6h	; 6995
	defb 000h	; 699b

; ----------------------------------------------------------------------
; DATOS lista_699C: lista del cargador de tiles (0x4CCD): 10 registros de 6 B,
;   tiles 107-174; la usa sublista de 0x72fc
;   0x699c..0x69d9  (61 bytes)
DATA_lista_699C:
	defb 0e5h,0a7h,0e9h,0b1h,00bh,0bbh	; 699c
	defb 0f5h,09fh,0e9h,0b1h,00bh,0bbh	; 69a2
	defb 0f5h,097h,0b6h,0b1h,0e3h,0bah	; 69a8
	defb 0e5h,08fh,0b6h,0b1h,0e3h,0bah	; 69ae
	defb 0f5h,087h,080h,0b1h,0b9h,0bah	; 69b4
	defb 0e5h,07fh,080h,0b1h,0b9h,0bah	; 69ba
	defb 0f5h,077h,04ah,0b1h,07dh,0bah	; 69c0
	defb 0e5h,06fh,04ah,0b1h,07dh,0bah	; 69c6
	defb 0f5h,06dh,047h,0b1h,0c7h,0b6h	; 69cc
	defb 0e5h,06bh,047h,0b1h,0c7h,0b6h	; 69d2
	defb 000h	; 69d8

; ----------------------------------------------------------------------
; DATOS lista_69D9: lista del cargador de tiles (0x4CCD): 10 registros de 6 B,
;   tiles 107-174; la usa sublista de 0x7388
;   0x69d9..0x6a16  (61 bytes)
DATA_lista_69D9:
	defb 0e5h,0a7h,0e9h,0b1h,03fh,0b6h	; 69d9
	defb 0f5h,09fh,0e9h,0b1h,03fh,0b6h	; 69df
	defb 0f5h,097h,0b6h,0b1h,03ah,0b6h	; 69e5
	defb 0e5h,08fh,0b6h,0b1h,03ah,0b6h	; 69eb
	defb 0f5h,087h,080h,0b1h,0b0h,0bah	; 69f1
	defb 0e5h,07fh,080h,0b1h,0b0h,0bah	; 69f7
	defb 0f5h,077h,04ah,0b1h,072h,0bah	; 69fd
	defb 0e5h,06fh,04ah,0b1h,072h,0bah	; 6a03
	defb 0f5h,06dh,047h,0b1h,0c2h,0b6h	; 6a09
	defb 0e5h,06bh,047h,0b1h,0c2h,0b6h	; 6a0f
	defb 000h	; 6a15

; ----------------------------------------------------------------------
; DATOS lista_6A16: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   5 ordenes, sin registros propios; la usa sublista de 0x639a
;   0x6a16..0x6a26  (16 bytes)
DATA_lista_6A16:
	defb 017h,035h,0b4h	; 6a16
	defb 017h,037h,0b2h	; 6a19
	defb 017h,034h,0b1h	; 6a1c
	defb 017h,033h,0afh	; 6a1f
	defb 017h,04dh,0b0h	; 6a22
	defb 000h	; 6a25

; ----------------------------------------------------------------------
; DATOS lista_6A26: lista del cargador de tiles (0x4CCD): 1 registros de 6 B y
;   3 ordenes, tiles 194-194; la usa sublista de 0x639a
;   0x6a26..0x6a36  (16 bytes)
DATA_lista_6A26:
	defb 017h,033h,0bfh	; 6a26
	defb 017h,049h,0c0h	; 6a29
	defb 0e5h,0c2h,02fh,0b0h,037h,0b5h	; 6a2c
	defb 017h,04bh,0b5h	; 6a32
	defb 000h	; 6a35

; ----------------------------------------------------------------------
; DATOS lista_6A36: lista del cargador de tiles (0x4CCD): 2 registros de 6 B y
;   2 ordenes, tiles 181-194; la usa sublista de 0x70bb
;   0x6a36..0x6a49  (19 bytes)
DATA_lista_6A36:
	defb 017h,033h,0bfh	; 6a36
	defb 017h,049h,0c0h	; 6a39
	defb 0e5h,0c2h,02fh,0b0h,037h,0b5h	; 6a3c
	defb 0e5h,0b5h,0e8h,0b2h,075h,0b6h	; 6a42
	defb 000h	; 6a48

; ----------------------------------------------------------------------
; DATOS lista_6A49: lista del cargador de tiles (0x4CCD): 2 registros de 6 B y
;   2 ordenes, tiles 181-194; la usa sublista de 0x72fc
;   0x6a49..0x6a5c  (19 bytes)
DATA_lista_6A49:
	defb 017h,033h,0bfh	; 6a49
	defb 017h,049h,0c0h	; 6a4c
	defb 0e5h,0c2h,02fh,0b0h,037h,0b5h	; 6a4f
	defb 0e5h,0b5h,04bh,0b3h,07bh,0b6h	; 6a55
	defb 000h	; 6a5b

; ----------------------------------------------------------------------
; DATOS lista_6A5C: lista del cargador de tiles (0x4CCD): 2 registros de 6 B y
;   2 ordenes, tiles 181-194; la usa sublista de 0x714a
;   0x6a5c..0x6a6f  (19 bytes)
DATA_lista_6A5C:
	defb 017h,033h,0bfh	; 6a5c
	defb 017h,049h,0c0h	; 6a5f
	defb 0e5h,0c2h,02fh,0b0h,037h,0b5h	; 6a62
	defb 0e5h,0b5h,089h,0b2h,06bh,0b6h	; 6a68
	defb 000h	; 6a6e

; ----------------------------------------------------------------------
; DATOS lista_6A6F: lista del cargador de tiles (0x4CCD): 2 registros de 6 B y
;   2 ordenes, tiles 181-194; la usa sublista de 0x7226
;   0x6a6f..0x6a82  (19 bytes)
DATA_lista_6A6F:
	defb 017h,033h,0bfh	; 6a6f
	defb 017h,049h,0c0h	; 6a72
	defb 0e5h,0c2h,02fh,0b0h,037h,0b5h	; 6a75
	defb 0e5h,0b5h,04bh,0b3h,081h,0b6h	; 6a7b
	defb 000h	; 6a81

; ----------------------------------------------------------------------
; DATOS lista_6A82: lista del cargador de tiles (0x4CCD): 2 registros de 6 B y
;   2 ordenes, tiles 181-194; la usa sublista de 0x7281
;   0x6a82..0x6a95  (19 bytes)
DATA_lista_6A82:
	defb 017h,033h,0bfh	; 6a82
	defb 017h,049h,0c0h	; 6a85
	defb 0e5h,0c2h,02fh,0b0h,037h,0b5h	; 6a88
	defb 0e5h,0b5h,089h,0b2h,05bh,0b6h	; 6a8e
	defb 000h	; 6a94

; ----------------------------------------------------------------------
; DATOS lista_6A95: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   6 ordenes, sin registros propios; la usa sublista de 0x639a
;   0x6a95..0x6aa8  (19 bytes)
DATA_lista_6A95:
	defb 017h,04dh,0cdh	; 6a95
	defb 017h,038h,0cbh	; 6a98
	defb 017h,036h,0c8h	; 6a9b
	defb 017h,037h,0c6h	; 6a9e
	defb 017h,034h,0c5h	; 6aa1
	defb 017h,033h,0c3h	; 6aa4
	defb 000h	; 6aa7

; ----------------------------------------------------------------------
; DATOS lista_6AA8: lista del cargador de tiles (0x4CCD): 13 registros de 6 B
;   y 14 ordenes, tiles 97-197; la usa sublista de 0x63e5
;   0x6aa8..0x6b21  (121 bytes)
DATA_lista_6AA8:
	defb 017h,037h,0cch	; 6aa8
	defb 017h,034h,0cbh	; 6aab
	defb 017h,033h,0c9h	; 6aae
	defb 017h,036h,0c6h	; 6ab1
	defb 0e1h,0c5h,04dh,099h,085h,09fh	; 6ab4
	defb 0f1h,0c3h,027h,09ah,0d3h,09fh	; 6aba
	defb 0e1h,0c1h,027h,09ah,0d3h,09fh	; 6ac0
	defb 0e1h,0bfh,010h,09ah,0cdh,09fh	; 6ac6
	defb 0f1h,0bdh,0feh,099h,0cah,09fh	; 6acc
	defb 0e1h,0bbh,0feh,099h,0cah,09fh	; 6ad2
	defb 0f1h,0b4h,0d4h,099h,0c3h,09fh	; 6ad8
	defb 0e1h,0adh,0d4h,099h,0c3h,09fh	; 6ade
	defb 0f1h,09fh,090h,099h,0b2h,09fh	; 6ae4
	defb 0e1h,091h,090h,099h,0b2h,09fh	; 6aea
	defb 017h,035h,090h	; 6af0
	defb 017h,034h,08fh	; 6af3
	defb 017h,033h,08dh	; 6af6
	defb 017h,03ch,089h	; 6af9
	defb 017h,03bh,088h	; 6afc
	defb 017h,03ah,084h	; 6aff
	defb 017h,02bh,07fh	; 6b02
	defb 017h,02dh,07dh	; 6b05
	defb 017h,02ch,07ah	; 6b08
	defb 017h,02eh,078h	; 6b0b
	defb 085h,061h,075h,0bch,002h,0beh	; 6b0e
	defb 045h,061h,0f7h,0bch,065h,0beh	; 6b14
	defb 025h,061h,077h,0bdh,0bch,0beh	; 6b1a
	defb 000h	; 6b20

; ----------------------------------------------------------------------
; DATOS lista_6B21: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   15 ordenes, sin registros propios; la usa sublista de 0x63e5
;   0x6b21..0x6b4f  (46 bytes)
DATA_lista_6B21:
	defb 017h,027h,05fh	; 6b21
	defb 017h,026h,05fh	; 6b24
	defb 017h,025h,05fh	; 6b27
	defb 017h,01bh,05dh	; 6b2a
	defb 017h,01ah,05dh	; 6b2d
	defb 017h,019h,05dh	; 6b30
	defb 017h,024h,059h	; 6b33
	defb 017h,023h,059h	; 6b36
	defb 017h,022h,059h	; 6b39
	defb 017h,028h,04fh	; 6b3c
	defb 017h,018h,055h	; 6b3f
	defb 017h,017h,055h	; 6b42
	defb 017h,016h,055h	; 6b45
	defb 017h,02ah,04bh	; 6b48
	defb 017h,029h,048h	; 6b4b
	defb 000h	; 6b4e

; ----------------------------------------------------------------------
; DATOS lista_6B4F: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   3 ordenes, sin registros propios; la usa sublista de 0x63e5
;   0x6b4f..0x6b59  (10 bytes)
DATA_lista_6B4F:
	defb 017h,01eh,03ch	; 6b4f
	defb 017h,01dh,03ch	; 6b52
	defb 017h,01ch,03ch	; 6b55
	defb 000h	; 6b58

; ----------------------------------------------------------------------
; DATOS lista_6B59: lista del cargador de tiles (0x4CCD): 3 registros de 6 B,
;   tiles 55-59; la usa sublista de 0x63e5
;   0x6b59..0x6b6c  (19 bytes)
DATA_lista_6B59:
	defb 0e1h,03ah,08bh,099h,0afh,09fh	; 6b59
	defb 081h,037h,050h,099h,088h,09fh	; 6b5f
	defb 041h,037h,067h,099h,097h,09fh	; 6b65
	defb 000h	; 6b6b

; ----------------------------------------------------------------------
; DATOS lista_6B6C: lista del cargador de tiles (0x4CCD): 1 registros de 6 B y
;   6 ordenes, tiles 55-57; la usa sublista de 0x63e5
;   0x6b6c..0x6b85  (25 bytes)
DATA_lista_6B6C:
	defb 021h,037h,074h,099h,0a2h,09fh	; 6b6c
	defb 017h,005h,02eh	; 6b72
	defb 017h,006h,02eh	; 6b75
	defb 017h,007h,02eh	; 6b78
	defb 017h,008h,02bh	; 6b7b
	defb 017h,009h,02bh	; 6b7e
	defb 017h,00ah,02bh	; 6b81
	defb 000h	; 6b84

; ----------------------------------------------------------------------
; DATOS lista_6B85: lista del cargador de tiles (0x4CCD): 3 registros de 6 B,
;   tiles 35-42; la usa sublista de 0x63e5
;   0x6b85..0x6b98  (19 bytes)
DATA_lista_6B85:
	defb 081h,023h,08ah,098h,0feh,09eh	; 6b85
	defb 041h,023h,0cbh,098h,02fh,09fh	; 6b8b
	defb 021h,023h,00bh,099h,058h,09fh	; 6b91
	defb 000h	; 6b97

; ----------------------------------------------------------------------
; DATOS lista_6B98: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 1-18; la usa sublista de 0x63e5
;   0x6b98..0x6bbd  (37 bytes)
DATA_lista_6B98:
	defb 081h,009h,0d3h,097h,0d3h,09eh	; 6b98
	defb 041h,009h,015h,098h,0e2h,09eh	; 6b9e
	defb 021h,009h,04eh,098h,0efh,09eh	; 6ba4
	defb 081h,001h,019h,097h,0cah,09eh	; 6baa
	defb 041h,001h,056h,097h,0cdh,09eh	; 6bb0
	defb 021h,001h,094h,097h,0d0h,09eh	; 6bb6
	defb 000h	; 6bbc

; ----------------------------------------------------------------------
; DATOS lista_6BBD: lista del cargador de tiles (0x4CCD): 20 registros de 6 B,
;   tiles 210-255; la usa p00 0x4C19/0x4C5E
;   0x6bbd..0x6c36  (121 bytes)
DATA_lista_6BBD:
	defb 0e3h,0d2h,091h,07ch,096h,07ch	; 6bbd
	defb 023h,0d4h,0c0h,07dh,0a3h,07eh	; 6bc3
	defb 043h,0d4h,099h,07ch,08bh,07dh	; 6bc9
	defb 043h,0ffh,045h,07bh,04fh,07bh	; 6bcf
	defb 083h,0d2h,01ah,07ch,037h,07ch	; 6bd5
	defb 083h,0dah,052h,07bh,0b4h,07bh	; 6bdb
	defb 08bh,0dch,052h,07bh,0b4h,07bh	; 6be1
	defb 083h,0deh,05bh,07bh,0b7h,07bh	; 6be7
	defb 093h,0dfh,05bh,07bh,0b7h,07bh	; 6bed
	defb 083h,0e0h,05eh,07bh,0bdh,07bh	; 6bf3
	defb 093h,0e5h,05eh,07bh,0bdh,07bh	; 6bf9
	defb 08bh,0eah,05eh,07bh,0bdh,07bh	; 6bff
	defb 09bh,0efh,05eh,07bh,0bdh,07bh	; 6c05
	defb 093h,0f4h,087h,07bh,0b7h,07bh	; 6c0b
	defb 083h,0f5h,087h,07bh,0b7h,07bh	; 6c11
	defb 083h,0f6h,091h,07bh,0b7h,07bh	; 6c17
	defb 083h,0f7h,099h,07bh,0b7h,07bh	; 6c1d
	defb 08bh,0f8h,091h,07bh,0b7h,07bh	; 6c23
	defb 083h,0f9h,09eh,07bh,0bah,07bh	; 6c29
	defb 043h,0e8h,0c0h,07bh,014h,07ch	; 6c2f
	defb 000h	; 6c35

; ----------------------------------------------------------------------
; DATOS lista_6C36: lista del cargador de tiles (0x4CCD): 5 registros de 6 B,
;   tiles 212-255; la usa p00 0x4C31/0x4C84
;   0x6c36..0x6c55  (31 bytes)
DATA_lista_6C36:
	defb 0e3h,0d4h,0c6h,07eh,0fbh,07fh	; 6c36
	defb 0e3h,0f8h,0fah,07bh,017h,07ch	; 6c3c
	defb 047h,0d4h,077h,0b7h,0b6h,0b8h	; 6c42
	defb 0e3h,0f7h,03fh,07bh,042h,07bh	; 6c48
	defb 043h,0ffh,045h,07bh,04fh,07bh	; 6c4e
	defb 000h	; 6c54

; ----------------------------------------------------------------------
; DATOS lista_6C55: lista del cargador de tiles (0x4CCD): 2 registros de 6 B,
;   tiles 250-255; la usa tabla_4C37[3]
;   0x6c55..0x6c62  (13 bytes)
DATA_lista_6C55:
	defb 023h,0fah,05ah,07ch,08eh,07ch	; 6c55
	defb 033h,0fdh,05ah,07ch,08eh,07ch	; 6c5b
	defb 000h	; 6c61

; ----------------------------------------------------------------------
; DATOS lista_6C62: lista del cargador de tiles (0x4CCD): 2 registros de 6 B,
;   tiles 250-255; la usa tabla_4C37[2]
;   0x6c62..0x6c6f  (13 bytes)
DATA_lista_6C62:
	defb 023h,0fah,074h,07ch,08eh,07ch	; 6c62
	defb 033h,0fdh,074h,07ch,08eh,07ch	; 6c68
	defb 000h	; 6c6e

; ----------------------------------------------------------------------
; DATOS lista_6C6F: lista del cargador de tiles (0x4CCD): 2 registros de 6 B,
;   tiles 250-255; la usa tabla_4C37[0]
;   0x6c6f..0x6c7c  (13 bytes)
DATA_lista_6C6F:
	defb 023h,0fah,040h,07ch,08eh,07ch	; 6c6f
	defb 033h,0fdh,040h,07ch,08eh,07ch	; 6c75
	defb 000h	; 6c7b

; ----------------------------------------------------------------------
; DATOS lista_6C7C: lista del cargador de tiles (0x4CCD): 14 registros de 6 B,
;   tiles 218-251; la usa p00 0x4C1F/0x4C67, p01 0x6348
;   0x6c7c..0x6cd1  (85 bytes)
DATA_lista_6C7C:
	defb 083h,0dah,052h,07bh,0b4h,07bh	; 6c7c
	defb 08bh,0dch,052h,07bh,0b4h,07bh	; 6c82
	defb 083h,0deh,05bh,07bh,0b7h,07bh	; 6c88
	defb 093h,0dfh,05bh,07bh,0b7h,07bh	; 6c8e
	defb 083h,0e0h,05eh,07bh,0bdh,07bh	; 6c94
	defb 093h,0e5h,05eh,07bh,0bdh,07bh	; 6c9a
	defb 08bh,0eah,05eh,07bh,0bdh,07bh	; 6ca0
	defb 09bh,0efh,05eh,07bh,0bdh,07bh	; 6ca6
	defb 093h,0f4h,087h,07bh,0b7h,07bh	; 6cac
	defb 083h,0f5h,087h,07bh,0b7h,07bh	; 6cb2
	defb 083h,0f6h,091h,07bh,0b7h,07bh	; 6cb8
	defb 083h,0f7h,099h,07bh,0b7h,07bh	; 6cbe
	defb 08bh,0f8h,091h,07bh,0b7h,07bh	; 6cc4
	defb 083h,0f9h,09eh,07bh,0bah,07bh	; 6cca
	defb 000h	; 6cd0

; ----------------------------------------------------------------------
; DATOS lista_6CD1: lista del cargador de tiles (0x4CCD): 7 registros de 6 B y
;   1 ordenes, tiles 1-254; la usa p01 0x6815
;   0x6cd1..0x6cff  (46 bytes)
DATA_lista_6CD1:
	defb 0e7h,001h,063h,0b4h,020h,0b6h	; 6cd1
	defb 0e7h,030h,0a3h,0b5h,0dbh,0b6h	; 6cd7
	defb 0e7h,033h,0b5h,0b5h,0e2h,0b6h	; 6cdd
	defb 0f7h,041h,0b5h,0b5h,0e2h,0b6h	; 6ce3
	defb 0e7h,050h,01bh,0b6h,0f9h,0b6h	; 6ce9
	defb 0efh,04fh,01bh,0b6h,0f9h,0b6h	; 6cef
	defb 017h,04dh,0ffh	; 6cf5
	defb 0e5h,0feh,02fh,0b0h,03dh,0b5h	; 6cf8
	defb 000h	; 6cfe

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (1 bytes)
;   0x6cff..0x6d00  (1 bytes)
DATA_6CFF:
	defb 000h	; 6cff

; ----------------------------------------------------------------------
; DATOS lista_6D00: lista del cargador de tiles (0x4CCD): 8 registros de 6 B y
;   1 ordenes, tiles 1-66; la usa p02 0x9272
;   0x6d00..0x6d34  (52 bytes)
DATA_lista_6D00:
	defb 0e3h,001h,047h,077h,058h,078h	; 6d00
	defb 0e3h,015h,047h,077h,0aah,078h	; 6d06
	defb 0e3h,029h,0e1h,077h,0fch,078h	; 6d0c
	defb 0e3h,033h,02bh,078h,013h,079h	; 6d12
	defb 0ebh,035h,02bh,078h,013h,079h	; 6d18
	defb 0e3h,037h,039h,078h,016h,079h	; 6d1e
	defb 0f3h,03ah,039h,078h,016h,079h	; 6d24
	defb 0e3h,03dh,042h,078h,019h,079h	; 6d2a
	defb 017h,034h,015h	; 6d30
	defb 000h	; 6d33

; ----------------------------------------------------------------------
; DATOS lista_6D34: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   12 ordenes, tiles 64-237; la usa p00 0x5CDB
;   0x6d34..0x6d6b  (55 bytes)
DATA_lista_6D34:
	defb 0e3h,0dfh,010h,082h,07fh,082h	; 6d34
	defb 0e3h,09fh,00dh,081h,07fh,082h	; 6d3a
	defb 017h,054h,09dh	; 6d40
	defb 017h,054h,09bh	; 6d43
	defb 017h,054h,099h	; 6d46
	defb 017h,053h,097h	; 6d49
	defb 017h,053h,095h	; 6d4c
	defb 017h,053h,093h	; 6d4f
	defb 017h,053h,091h	; 6d52
	defb 017h,053h,08fh	; 6d55
	defb 017h,053h,08dh	; 6d58
	defb 017h,053h,08bh	; 6d5b
	defb 017h,053h,089h	; 6d5e
	defb 017h,053h,087h	; 6d61
	defb 0e3h,040h,016h,080h,07fh,082h	; 6d64
	defb 000h	; 6d6a

; ----------------------------------------------------------------------
; DATOS lista_6D6B: lista del cargador de tiles (0x4CCD): 11 registros de 6 B,
;   tiles 0-138; la usa p01 0x6342
;   0x6d6b..0x6dae  (67 bytes)
DATA_lista_6D6B:
	defb 087h,001h,01dh,0a8h,059h,0ach	; 6d6b
	defb 087h,052h,04bh,0aah,0afh,0ach	; 6d71
	defb 097h,061h,04bh,0aah,0afh,0ach	; 6d77
	defb 087h,070h,0adh,0aah,0b2h,0ach	; 6d7d
	defb 08fh,071h,0adh,0aah,0b2h,0ach	; 6d83
	defb 047h,000h,0b3h,0aah,0b5h,0ach	; 6d89
	defb 047h,026h,0a5h,0abh,0d6h,0ach	; 6d8f
	defb 04fh,041h,0a5h,0abh,0d6h,0ach	; 6d95
	defb 047h,05ch,054h,0ach,0f1h,0ach	; 6d9b
	defb 057h,05eh,054h,0ach,0f1h,0ach	; 6da1
	defb 047h,060h,077h,0b7h,0b6h,0b8h	; 6da7
	defb 000h	; 6dad

; ----------------------------------------------------------------------
; DATOS lista_6DAE: lista del cargador de tiles (0x4CCD): 1 registros de 6 B,
;   tiles 255-255; la usa p02 0x8264
;   0x6dae..0x6db5  (7 bytes)
DATA_lista_6DAE:
	defb 0e7h,0ffh,0f6h,0ach,0f9h,0ach	; 6dae
	defb 000h	; 6db4

; ----------------------------------------------------------------------
; DATOS lista_6DB5: lista del cargador de tiles (0x4CCD): 1 registros de 6 B,
;   tiles 16-58; la usa p02 0x823B/0x8367
;   0x6db5..0x6dbc  (7 bytes)
DATA_lista_6DB5:
	defb 027h,010h,077h,0b7h,0afh,0b8h	; 6db5
	defb 000h	; 6dbb

; ----------------------------------------------------------------------
; DATOS lista_6DBC: lista del cargador de tiles (0x4CCD): 1 registros de 6 B,
;   tiles 1-44; la usa p02 0x8241
;   0x6dbc..0x6dc3  (7 bytes)
DATA_lista_6DBC:
	defb 047h,001h,0fch,0ach,09eh,0b2h	; 6dbc
	defb 000h	; 6dc2

; ----------------------------------------------------------------------
; DATOS lista_6DC3: lista del cargador de tiles (0x4CCD): 3 registros de 6 B,
;   tiles 45-82; la usa p02 0x82CF (por 0x8390 -> 0x4C93)
;   0x6dc3..0x6dd6  (19 bytes)
DATA_lista_6DC3:
	defb 057h,033h,00fh,0aeh,0d1h,0b2h	; 6dc3
	defb 047h,02dh,00fh,0aeh,0d1h,0b2h	; 6dc9
	defb 047h,039h,031h,0aeh,0e6h,0b2h	; 6dcf
	defb 000h	; 6dd5

; ----------------------------------------------------------------------
; DATOS lista_6DD6: lista del cargador de tiles (0x4CCD): 2 registros de 6 B,
;   tiles 80-218; la usa p02 0x829E (por 0x8390 -> 0x4C93)
;   0x6dd6..0x6de3  (13 bytes)
DATA_lista_6DD6:
	defb 047h,095h,0bdh,0aeh,096h,0b3h	; 6dd6
	defb 047h,050h,0bdh,0aeh,0edh,0b2h	; 6ddc
	defb 000h	; 6de2

; ----------------------------------------------------------------------
; DATOS lista_6DE3: lista del cargador de tiles (0x4CCD): 1 registros de 6 B,
;   tiles 150-221; la usa p02 0x82E9 (por 0x8390 -> 0x4C93)
;   0x6de3..0x6dea  (7 bytes)
DATA_lista_6DE3:
	defb 047h,096h,087h,0b0h,012h,0b4h	; 6de3
	defb 000h	; 6de9

; ----------------------------------------------------------------------
; DATOS lista_6DEA: lista del cargador de tiles (0x4CCD): 4 registros de 6 B y
;   1 ordenes, tiles 1-140; la usa p01 0x7CDC
;   0x6dea..0x6e06  (28 bytes)
DATA_lista_6DEA:
	defb 0e3h,001h,020h,079h,034h,07bh	; 6dea
	defb 017h,034h,089h	; 6df0
	defb 0e5h,08ah,02fh,0b0h,03ah,0b5h	; 6df3
	defb 0e5h,08bh,02fh,0b0h,03dh,0b5h	; 6df9
	defb 0e5h,08ch,02fh,0b0h,040h,0b5h	; 6dff
	defb 000h	; 6e05

; ----------------------------------------------------------------------
; DATOS lista_6E06: lista del cargador de tiles (0x4CCD): 1 registros de 6 B,
;   tiles 5-5; la usa p01 0x6D25
;   0x6e06..0x6e0d  (7 bytes)
DATA_lista_6E06:
	defb 0e1h,005h,03dh,076h,042h,076h	; 6e06
	defb 000h	; 6e0c

; ----------------------------------------------------------------------
; DATOS lista_6E0D: lista del cargador de tiles (0x4CCD): 1 registros de 6 B,
;   tiles 10-15; la usa p01 0x6781
;   0x6e0d..0x6e14  (7 bytes)
DATA_lista_6E0D:
	defb 0e3h,00ah,008h,086h,0e0h,086h	; 6e0d
	defb 000h	; 6e13

; ----------------------------------------------------------------------
; DATOS lista_6E14: lista del cargador de tiles (0x4CCD): 9 registros de 6 B,
;   tiles 64-234; la usa tabla_BD0F[5]
;   0x6e14..0x6e4b  (55 bytes)
DATA_lista_6E14:
	defb 043h,040h,025h,083h,024h,084h	; 6e14
	defb 043h,059h,0cah,083h,06ch,084h	; 6e1a
	defb 04bh,069h,0cah,083h,06ch,084h	; 6e20
	defb 043h,079h,025h,083h,073h,084h	; 6e26
	defb 043h,092h,0cah,083h,0bbh,084h	; 6e2c
	defb 04bh,0a2h,0cah,083h,0bbh,084h	; 6e32
	defb 043h,0b2h,025h,083h,0c2h,084h	; 6e38
	defb 043h,0cbh,0cah,083h,00ah,085h	; 6e3e
	defb 04bh,0dbh,0cah,083h,00ah,085h	; 6e44
	defb 000h	; 6e4a

; ----------------------------------------------------------------------
; DATOS lista_6E4B: lista del cargador de tiles (0x4CCD): 9 registros de 6 B,
;   tiles 64-222; la usa tabla_BD0F[4]
;   0x6e4b..0x6e82  (55 bytes)
DATA_lista_6E4B:
	defb 043h,040h,00fh,085h,027h,086h	; 6e4b
	defb 043h,059h,0b5h,085h,066h,086h	; 6e51
	defb 04bh,067h,0b5h,085h,066h,086h	; 6e57
	defb 043h,075h,00fh,085h,069h,086h	; 6e5d
	defb 043h,08eh,0b5h,085h,0a4h,086h	; 6e63
	defb 04bh,09ch,0b5h,085h,0a4h,086h	; 6e69
	defb 043h,0aah,00fh,085h,0a7h,086h	; 6e6f
	defb 043h,0c3h,0b5h,085h,0ddh,086h	; 6e75
	defb 04bh,0d1h,0b5h,085h,0ddh,086h	; 6e7b
	defb 000h	; 6e81

; ----------------------------------------------------------------------
; DATOS lista_6E82: lista del cargador de tiles (0x4CCD): 9 registros de 6 B,
;   tiles 64-204; la usa tabla_BD0F[3]
;   0x6e82..0x6eb9  (55 bytes)
DATA_lista_6E82:
	defb 043h,040h,0e3h,086h,0aah,087h	; 6e82
	defb 043h,04fh,040h,087h,0d9h,087h	; 6e88
	defb 04bh,05fh,040h,087h,0d9h,087h	; 6e8e
	defb 043h,06fh,0e3h,086h,0deh,087h	; 6e94
	defb 043h,07eh,040h,087h,012h,088h	; 6e9a
	defb 04bh,08eh,040h,087h,012h,088h	; 6ea0
	defb 043h,09eh,0e3h,086h,017h,088h	; 6ea6
	defb 043h,0adh,040h,087h,04bh,088h	; 6eac
	defb 04bh,0bdh,040h,087h,04bh,088h	; 6eb2
	defb 000h	; 6eb8

; ----------------------------------------------------------------------
; DATOS lista_6EB9: lista del cargador de tiles (0x4CCD): 9 registros de 6 B,
;   tiles 64-211; la usa tabla_BD0F[2]
;   0x6eb9..0x6ef0  (55 bytes)
DATA_lista_6EB9:
	defb 043h,040h,054h,088h,0ech,08ah	; 6eb9
	defb 043h,051h,0cdh,088h,035h,08bh	; 6ebf
	defb 04bh,061h,0cdh,088h,035h,08bh	; 6ec5
	defb 043h,071h,02eh,089h,03ah,08bh	; 6ecb
	defb 043h,085h,0b6h,089h,08bh,08bh	; 6ed1
	defb 04bh,094h,0b6h,089h,08bh,08bh	; 6ed7
	defb 043h,0a3h,012h,08ah,08eh,08bh	; 6edd
	defb 043h,0b6h,090h,08ah,0d9h,08bh	; 6ee3
	defb 04bh,0c5h,090h,08ah,0d9h,08bh	; 6ee9
	defb 000h	; 6eef

; ----------------------------------------------------------------------
; DATOS lista_6EF0: lista del cargador de tiles (0x4CCD): 12 registros de 6 B,
;   tiles 64-215; la usa tabla_BD0F[1]
;   0x6ef0..0x6f39  (73 bytes)
DATA_lista_6EF0:
	defb 043h,040h,0dch,08bh,087h,08eh	; 6ef0
	defb 043h,042h,0e7h,08bh,08ah,08eh	; 6ef6
	defb 043h,057h,06eh,08ch,0d7h,08eh	; 6efc
	defb 04bh,065h,06eh,08ch,0d7h,08eh	; 6f02
	defb 043h,073h,0dch,08bh,0dah,08eh	; 6f08
	defb 043h,075h,0c6h,08ch,0ddh,08eh	; 6f0e
	defb 043h,088h,046h,08dh,03dh,08fh	; 6f14
	defb 04bh,096h,046h,08dh,03dh,08fh	; 6f1a
	defb 043h,0a4h,0dch,08bh,040h,08fh	; 6f20
	defb 043h,0a6h,09eh,08dh,043h,08fh	; 6f26
	defb 043h,0bah,022h,08eh,0a6h,08fh	; 6f2c
	defb 04bh,0c9h,022h,08eh,0a6h,08fh	; 6f32
	defb 000h	; 6f38

; ----------------------------------------------------------------------
; DATOS lista_6F39: lista del cargador de tiles (0x4CCD): 9 registros de 6 B,
;   tiles 64-218; la usa tabla_BD0F[0]
;   0x6f39..0x6f70  (55 bytes)
DATA_lista_6F39:
	defb 043h,040h,0adh,08fh,062h,092h	; 6f39
	defb 043h,055h,033h,090h,0b4h,092h	; 6f3f
	defb 04bh,063h,033h,090h,0b4h,092h	; 6f45
	defb 043h,071h,085h,090h,0b7h,092h	; 6f4b
	defb 043h,087h,010h,091h,016h,093h	; 6f51
	defb 04bh,096h,010h,091h,016h,093h	; 6f57
	defb 043h,0a5h,06ch,091h,019h,093h	; 6f5d
	defb 043h,0beh,004h,092h,083h,093h	; 6f63
	defb 04bh,0cch,004h,092h,083h,093h	; 6f69
	defb 000h	; 6f6f

; ----------------------------------------------------------------------
; DATOS lista_6F70: lista del cargador de tiles (0x4CCD): 6 registros de 6 B,
;   tiles 64-154; la usa tabla_BD03[1]
;   0x6f70..0x6f95  (37 bytes)
DATA_lista_6F70:
	defb 043h,040h,0e8h,093h,05ah,096h	; 6f70
	defb 043h,077h,062h,095h,069h,096h	; 6f76
	defb 04bh,079h,062h,095h,069h,096h	; 6f7c
	defb 043h,07bh,074h,095h,06ch,096h	; 6f82
	defb 053h,07ch,074h,095h,06ch,096h	; 6f88
	defb 043h,07dh,07dh,095h,06fh,096h	; 6f8e
	defb 000h	; 6f94

; ----------------------------------------------------------------------
; DATOS lista_6F95: lista del cargador de tiles (0x4CCD): 9 registros de 6 B,
;   tiles 64-121; la usa tabla_BD03[3]
;   0x6f95..0x6fcc  (55 bytes)
DATA_lista_6F95:
	defb 043h,040h,097h,098h,0c7h,099h	; 6f95
	defb 043h,055h,027h,099h,0d4h,099h	; 6f9b
	defb 053h,05fh,027h,099h,0d4h,099h	; 6fa1
	defb 043h,069h,062h,099h,0d7h,099h	; 6fa7
	defb 043h,070h,099h,099h,0dah,099h	; 6fad
	defb 04bh,071h,099h,099h,0dah,099h	; 6fb3
	defb 043h,072h,0a3h,099h,0ddh,099h	; 6fb9
	defb 053h,075h,0a3h,099h,0ddh,099h	; 6fbf
	defb 043h,078h,0bch,099h,0e0h,099h	; 6fc5
	defb 000h	; 6fcb

; ----------------------------------------------------------------------
; DATOS lista_6FCC: lista del cargador de tiles (0x4CCD): 10 registros de 6 B,
;   tiles 64-142; la usa tabla_BD03[4]
;   0x6fcc..0x7009  (61 bytes)
DATA_lista_6FCC:
	defb 043h,040h,076h,096h,06bh,098h	; 6fcc
	defb 043h,048h,0b3h,096h,06eh,098h	; 6fd2
	defb 043h,05bh,039h,097h,075h,098h	; 6fd8
	defb 04bh,060h,039h,097h,075h,098h	; 6fde
	defb 043h,065h,05ah,097h,078h,098h	; 6fe4
	defb 053h,066h,05ah,097h,078h,098h	; 6fea
	defb 04bh,067h,05ah,097h,078h,098h	; 6ff0
	defb 05bh,068h,05ah,097h,078h,098h	; 6ff6
	defb 043h,069h,063h,097h,07bh,098h	; 6ffc
	defb 043h,07ch,0ebh,097h,086h,098h	; 7002
	defb 000h	; 7008

; ----------------------------------------------------------------------
; DATOS lista_7009: lista del cargador de tiles (0x4CCD): 1 registros de 6 B,
;   tiles 64-101; la usa tabla_BD03[5]
;   0x7009..0x7010  (7 bytes)
DATA_lista_7009:
	defb 043h,040h,0e3h,099h,0f6h,09ah	; 7009
	defb 000h	; 700f

; ----------------------------------------------------------------------
; DATOS lista_7010: lista del cargador de tiles (0x4CCD): 4 registros de 6 B,
;   tiles 67-136; la usa tabla_927E[1]
;   0x7010..0x7029  (25 bytes)
DATA_lista_7010:
	defb 0e1h,082h,02ch,0a8h,054h,0afh	; 7010
	defb 0e1h,06dh,0edh,0a4h,0e1h,0a8h	; 7016
	defb 0e1h,058h,0edh,0a4h,08ah,0a8h	; 701c
	defb 0e1h,043h,0edh,0a4h,03ah,0a9h	; 7022
	defb 000h	; 7028

; ----------------------------------------------------------------------
; DATOS lista_7029: lista del cargador de tiles (0x4CCD): 4 registros de 6 B,
;   tiles 67-136; la usa tabla_927E[0]
;   0x7029..0x7042  (25 bytes)
DATA_lista_7029:
	defb 0e1h,082h,03fh,0a8h,054h,0afh	; 7029
	defb 0e1h,06dh,083h,0a5h,05bh,0aah	; 702f
	defb 0e1h,058h,083h,0a5h,0f7h,0a9h	; 7035
	defb 0e1h,043h,083h,0a5h,093h,0a9h	; 703b
	defb 000h	; 7041

; ----------------------------------------------------------------------
; DATOS lista_7042: lista del cargador de tiles (0x4CCD): 4 registros de 6 B,
;   tiles 67-136; la usa tabla_927E[2]
;   0x7042..0x705b  (25 bytes)
DATA_lista_7042:
	defb 0e1h,082h,054h,0a8h,054h,0afh	; 7042
	defb 0e1h,06dh,013h,0a6h,07fh,0abh	; 7048
	defb 0e1h,058h,013h,0a6h,0bfh,0aah	; 704e
	defb 0e1h,043h,013h,0a6h,01fh,0abh	; 7054
	defb 000h	; 705a

; ----------------------------------------------------------------------
; DATOS lista_705B: lista del cargador de tiles (0x4CCD): 4 registros de 6 B,
;   tiles 67-136; la usa tabla_927E[3]
;   0x705b..0x7074  (25 bytes)
DATA_lista_705B:
	defb 0e1h,082h,063h,0a8h,054h,0afh	; 705b
	defb 0e1h,06dh,096h,0a6h,03dh,0ach	; 7061
	defb 0e1h,058h,096h,0a6h,0dfh,0abh	; 7067
	defb 0e1h,043h,096h,0a6h,09ah,0ach	; 706d
	defb 000h	; 7073

; ----------------------------------------------------------------------
; DATOS lista_7074: lista del cargador de tiles (0x4CCD): 4 registros de 6 B,
;   tiles 67-136; la usa tabla_927E[4]
;   0x7074..0x708d  (25 bytes)
DATA_lista_7074:
	defb 0e1h,082h,070h,0a8h,054h,0afh	; 7074
	defb 0e1h,06dh,01bh,0a7h,05dh,0adh	; 707a
	defb 0e1h,058h,01bh,0a7h,0c2h,0adh	; 7080
	defb 0e1h,043h,01bh,0a7h,0f8h,0ach	; 7086
	defb 000h	; 708c

; ----------------------------------------------------------------------
; DATOS lista_708D: lista del cargador de tiles (0x4CCD): 4 registros de 6 B,
;   tiles 67-136; la usa tabla_927E[5]
;   0x708d..0x70a6  (25 bytes)
DATA_lista_708D:
	defb 0e1h,082h,07dh,0a8h,054h,0afh	; 708d
	defb 0e1h,06dh,0a7h,0a7h,0efh,0aeh	; 7093
	defb 0e1h,058h,0a7h,0a7h,08ch,0aeh	; 7099
	defb 0e1h,043h,0a7h,0a7h,027h,0aeh	; 709f
	defb 000h	; 70a5

; ----------------------------------------------------------------------
; DATOS lista_70A6: lista del cargador de tiles (0x4CCD): 0 registros de 6 B y
;   2 ordenes, sin registros propios; la usa sublista de 0x70bb
;   0x70a6..0x70bb  (21 bytes)
DATA_lista_70A6:
	defb 010h,001h,05dh,05dh,05dh,06bh,06bh,06bh,06bh,06bh,06bh,06bh,0b5h,0b5h,0b5h,0b5h,0c3h	; 70a6  ..]]]kkkkkkk.....
	defb 011h,036h,007h	; 70b7
	defb 000h	; 70ba

; ----------------------------------------------------------------------
; DATOS lista_70BB: lista del cargador de tiles (0x4CCD): 4 registros de 6 B y
;   15 ordenes, tiles 59-194; la usa tabla_61A9[5]; sigue en la lista de
;   0x70cd
;   0x70bb..0x70cd  (18 bytes)
DATA_lista_70BB:
	defb 013h,0a6h,070h	; 70bb
	defb 013h,095h,06ah	; 70be
	defb 013h,036h,06ah	; 70c1
	defb 013h,016h,06ah	; 70c4
	defb 0e5h,0c2h,02fh,0b0h,043h,0b5h	; 70c7

; ----------------------------------------------------------------------
; DATOS lista_70CD: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   11 ordenes, tiles 59-106; la usa tabla_61A9[26]
;   0x70cd..0x7101  (52 bytes)
DATA_lista_70CD:
	defb 013h,0e5h,068h	; 70cd
	defb 0e5h,067h,0c0h,0b3h,074h,0bbh	; 70d0
	defb 017h,04ch,064h	; 70d6
	defb 017h,02ch,061h	; 70d9
	defb 013h,0a0h,068h	; 70dc
	defb 0e5h,050h,0d9h,0b2h,072h,0b6h	; 70df
	defb 013h,07fh,068h	; 70e5
	defb 013h,0d7h,067h	; 70e8
	defb 0e5h,03bh,00dh,0b0h,024h,0b5h	; 70eb
	defb 013h,043h,067h	; 70f1
	defb 017h,049h,029h	; 70f4
	defb 013h,005h,066h	; 70f7
	defb 013h,07bh,065h	; 70fa
	defb 013h,013h,065h	; 70fd
	defb 000h	; 7100

; ----------------------------------------------------------------------
; DATOS lista_7101: lista del cargador de tiles (0x4CCD): 5 registros de 6 B y
;   14 ordenes, tiles 59-180; la usa tabla_61A9[6]; sigue en la lista de
;   0x7113
;   0x7101..0x7113  (18 bytes)
DATA_lista_7101:
	defb 013h,0a6h,070h	; 7101
	defb 013h,095h,06ah	; 7104
	defb 013h,026h,06ah	; 7107
	defb 013h,016h,06ah	; 710a
	defb 0e5h,0b4h,0cch,0afh,009h,0b5h	; 710d

; ----------------------------------------------------------------------
; DATOS lista_7113: lista del cargador de tiles (0x4CCD): 4 registros de 6 B y
;   10 ordenes, tiles 59-106; la usa tabla_61A9[27]
;   0x7113..0x714a  (55 bytes)
DATA_lista_7113:
	defb 013h,022h,069h	; 7113
	defb 0e5h,067h,0c0h,0b3h,036h,0bbh	; 7116
	defb 0e5h,064h,016h,0b0h,001h,0b7h	; 711c
	defb 0e1h,061h,04ah,094h,016h,0a2h	; 7122
	defb 013h,0b9h,068h	; 7128
	defb 017h,04ah,050h	; 712b
	defb 013h,086h,068h	; 712e
	defb 013h,0eah,067h	; 7131
	defb 0e5h,03bh,00dh,0b0h,0e6h,0b6h	; 7134
	defb 013h,068h,067h	; 713a
	defb 017h,049h,029h	; 713d
	defb 013h,042h,066h	; 7140
	defb 013h,085h,065h	; 7143
	defb 013h,029h,065h	; 7146
	defb 000h	; 7149

; ----------------------------------------------------------------------
; DATOS lista_714A: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   15 ordenes, tiles 59-106; la usa tabla_61A9[7]; sigue en la lista de
;   0x7156
;   0x714a..0x7156  (12 bytes)
DATA_lista_714A:
	defb 013h,0a6h,070h	; 714a
	defb 013h,095h,06ah	; 714d
	defb 013h,05ch,06ah	; 7150
	defb 013h,016h,06ah	; 7153

; ----------------------------------------------------------------------
; DATOS lista_7156: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   11 ordenes, tiles 59-106; la usa tabla_61A9[28]
;   0x7156..0x718a  (52 bytes)
DATA_lista_7156:
	defb 013h,0e5h,068h	; 7156
	defb 0e5h,067h,0c0h,0b3h,074h,0bbh	; 7159
	defb 017h,04ch,064h	; 715f
	defb 017h,02ch,061h	; 7162
	defb 013h,0a0h,068h	; 7165
	defb 0e5h,050h,077h,0b2h,062h,0b6h	; 7168
	defb 013h,07fh,068h	; 716e
	defb 013h,00fh,068h	; 7171
	defb 0e5h,03bh,00dh,0b0h,024h,0b5h	; 7174
	defb 013h,01eh,067h	; 717a
	defb 017h,049h,029h	; 717d
	defb 013h,073h,066h	; 7180
	defb 013h,098h,065h	; 7183
	defb 013h,000h,065h	; 7186
	defb 000h	; 7189

; ----------------------------------------------------------------------
; DATOS lista_718A: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   7 ordenes, tiles 35-99; la usa tabla_61A9[8]; sigue en la lista de 0x719e
;   0x718a..0x719e  (20 bytes)
DATA_lista_718A:
	defb 010h,001h,068h,06ah,06ch,083h,087h,08bh,08fh,093h,093h,093h,0c4h,0c4h,0c4h,0c4h,0c4h	; 718a  ..hjl............
	defb 011h,037h,004h	; 719b

; ----------------------------------------------------------------------
; DATOS lista_719E: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   5 ordenes, tiles 35-99; la usa tabla_61A9[29]
;   0x719e..0x71c0  (34 bytes)
DATA_lista_719E:
	defb 013h,015h,064h	; 719e
	defb 0e1h,05eh,03fh,0b1h,003h,0b2h	; 71a1
	defb 0e1h,060h,03fh,0b1h,003h,0b2h	; 71a7
	defb 017h,00fh,062h	; 71ad
	defb 013h,085h,064h	; 71b0
	defb 013h,0c5h,064h	; 71b3
	defb 013h,0cfh,064h	; 71b6
	defb 0e5h,023h,0e2h,0b3h,096h,0bbh	; 71b9
	defb 000h	; 71bf

; ----------------------------------------------------------------------
; DATOS lista_71C0: lista del cargador de tiles (0x4CCD): 9 registros de 6 B y
;   11 ordenes, tiles 1-18; la usa tabla_61A9[9]; sigue en la lista de 0x71d4
;   0x71c0..0x71d4  (20 bytes)
DATA_lista_71C0:
	defb 010h,001h,078h,078h,078h,084h,088h,08dh,08dh,08dh,08dh,08dh,0c5h,0c5h,0c5h,0c5h,0c5h	; 71c0  ..xxx............
	defb 011h,037h,005h	; 71d1

; ----------------------------------------------------------------------
; DATOS lista_71D4: lista del cargador de tiles (0x4CCD): 9 registros de 6 B y
;   9 ordenes, tiles 1-18; la usa tabla_61A9[30]
;   0x71d4..0x7226  (82 bytes)
DATA_lista_71D4:
	defb 013h,0a8h,06ah	; 71d4
	defb 013h,021h,06bh	; 71d7
	defb 017h,00fh,042h	; 71da
	defb 013h,04fh,06bh	; 71dd
	defb 013h,059h,06bh	; 71e0
	defb 013h,06ch,06bh	; 71e3
	defb 013h,085h,06bh	; 71e6
	defb 013h,0c5h,064h	; 71e9
	defb 013h,098h,06bh	; 71ec
	defb 081h,009h,0d3h,097h,0c1h,0a1h	; 71ef
	defb 041h,009h,015h,098h,0d0h,0a1h	; 71f5
	defb 021h,009h,04eh,098h,0ddh,0a1h	; 71fb
	defb 085h,009h,011h,0b4h,0bbh,0bbh	; 7201
	defb 045h,009h,049h,0b4h,0bbh,0bbh	; 7207
	defb 025h,009h,07bh,0b4h,0bbh,0bbh	; 720d
	defb 021h,001h,094h,097h,0f5h,0a2h	; 7213
	defb 041h,001h,056h,097h,0f5h,0a2h	; 7219
	defb 081h,001h,019h,097h,0f5h,0a2h	; 721f
	defb 000h	; 7225

; ----------------------------------------------------------------------
; DATOS lista_7226: lista del cargador de tiles (0x4CCD): 6 registros de 6 B y
;   18 ordenes, tiles 59-180; la usa tabla_61A9[10]; sigue en la lista de
;   0x7238
;   0x7226..0x7238  (18 bytes)
DATA_lista_7226:
	defb 013h,0a6h,070h	; 7226
	defb 013h,095h,06ah	; 7229
	defb 013h,06fh,06ah	; 722c
	defb 013h,016h,06ah	; 722f
	defb 0e5h,0b4h,0cch,0afh,009h,0b5h	; 7232

; ----------------------------------------------------------------------
; DATOS lista_7238: lista del cargador de tiles (0x4CCD): 5 registros de 6 B y
;   14 ordenes, tiles 59-106; la usa tabla_61A9[31]
;   0x7238..0x7281  (73 bytes)
DATA_lista_7238:
	defb 013h,05fh,069h	; 7238
	defb 0e5h,067h,0c0h,0b3h,055h,0bbh	; 723b
	defb 0e5h,064h,016h,0b0h,008h,0b7h	; 7241
	defb 0e1h,061h,04ah,094h,01dh,0a2h	; 7247
	defb 013h,0cfh,068h	; 724d
	defb 0e5h,050h,03ah,0b3h,07eh,0b6h	; 7250
	defb 013h,093h,068h	; 7256
	defb 017h,021h,044h	; 7259
	defb 017h,020h,044h	; 725c
	defb 017h,01fh,044h	; 725f
	defb 017h,015h,03eh	; 7262
	defb 017h,014h,03eh	; 7265
	defb 017h,013h,03eh	; 7268
	defb 0e5h,03bh,00dh,0b0h,0efh,0b6h	; 726b
	defb 013h,08dh,067h	; 7271
	defb 017h,049h,029h	; 7274
	defb 013h,0b0h,066h	; 7277
	defb 013h,0abh,065h	; 727a
	defb 013h,052h,065h	; 727d
	defb 000h	; 7280

; ----------------------------------------------------------------------
; DATOS lista_7281: lista del cargador de tiles (0x4CCD): 11 registros de 6 B
;   y 14 ordenes, tiles 59-194; la usa tabla_61A9[11]; sigue en la lista de
;   0x72aa
;   0x7281..0x72aa  (41 bytes)
DATA_lista_7281:
	defb 010h,001h,053h,053h,053h,06bh,06bh,06bh,06bh,06bh,06bh,06bh,0b5h,0b5h,0b5h,0b5h,0c3h	; 7281  ..SSSkkkkkkk.....
	defb 011h,036h,007h	; 7292
	defb 013h,095h,06ah	; 7295
	defb 013h,082h,06ah	; 7298
	defb 013h,016h,06ah	; 729b
	defb 0e5h,0c2h,02fh,0b0h,043h,0b5h	; 729e
	defb 0e5h,0b4h,0cch,0afh,009h,0b5h	; 72a4

; ----------------------------------------------------------------------
; DATOS lista_72AA: lista del cargador de tiles (0x4CCD): 9 registros de 6 B y
;   9 ordenes, tiles 59-106; la usa tabla_61A9[32]
;   0x72aa..0x72fc  (82 bytes)
DATA_lista_72AA:
	defb 013h,0e5h,068h	; 72aa
	defb 0e5h,067h,0c0h,0b3h,014h,0bbh	; 72ad
	defb 017h,04ch,064h	; 72b3
	defb 0e5h,066h,0c0h,0b3h,014h,0bbh	; 72b6
	defb 0f5h,060h,0c0h,0b3h,014h,0bbh	; 72bc
	defb 0e5h,05fh,0c0h,0b3h,014h,0bbh	; 72c2
	defb 0e5h,05bh,0c0h,0b3h,014h,0bbh	; 72c8
	defb 0e5h,057h,0c0h,0b3h,014h,0bbh	; 72ce
	defb 0e5h,053h,0c0h,0b3h,014h,0bbh	; 72d4
	defb 0e5h,050h,077h,0b2h,052h,0b6h	; 72da
	defb 013h,07fh,068h	; 72e0
	defb 013h,059h,068h	; 72e3
	defb 0e5h,03bh,00dh,0b0h,024h,0b5h	; 72e6
	defb 013h,043h,067h	; 72ec
	defb 017h,049h,029h	; 72ef
	defb 013h,005h,066h	; 72f2
	defb 013h,07bh,065h	; 72f5
	defb 013h,013h,065h	; 72f8
	defb 000h	; 72fb

; ----------------------------------------------------------------------
; DATOS lista_72FC: lista del cargador de tiles (0x4CCD): 2 registros de 6 B y
;   17 ordenes, tiles 59-82; la usa tabla_61A9[12]; sigue en la lista de
;   0x730b
;   0x72fc..0x730b  (15 bytes)
DATA_lista_72FC:
	defb 013h,0a6h,070h	; 72fc
	defb 013h,095h,06ah	; 72ff
	defb 013h,049h,06ah	; 7302
	defb 013h,016h,06ah	; 7305
	defb 017h,04dh,0c2h	; 7308

; ----------------------------------------------------------------------
; DATOS lista_730B: lista del cargador de tiles (0x4CCD): 2 registros de 6 B y
;   12 ordenes, tiles 59-82; la usa tabla_61A9[33]
;   0x730b..0x733c  (49 bytes)
DATA_lista_730B:
	defb 013h,09ch,069h	; 730b
	defb 017h,02bh,066h	; 730e
	defb 017h,04ch,064h	; 7311
	defb 017h,02ch,061h	; 7314
	defb 013h,0a0h,068h	; 7317
	defb 0e5h,050h,03ah,0b3h,078h,0b6h	; 731a
	defb 013h,07fh,068h	; 7320
	defb 013h,00fh,068h	; 7323
	defb 0e5h,03bh,00dh,0b0h,0f8h,0b6h	; 7326
	defb 013h,0b2h,067h	; 732c
	defb 017h,049h,029h	; 732f
	defb 013h,0e1h,066h	; 7332
	defb 013h,098h,065h	; 7335
	defb 013h,03fh,065h	; 7338
	defb 000h	; 733b

; ----------------------------------------------------------------------
; DATOS lista_733C: lista del cargador de tiles (0x4CCD): 5 registros de 6 B y
;   15 ordenes, tiles 59-194; la usa tabla_61A9[13]; sigue en la lista de
;   0x7354
;   0x733c..0x7354  (24 bytes)
DATA_lista_733C:
	defb 013h,0a6h,070h	; 733c
	defb 013h,095h,06ah	; 733f
	defb 013h,049h,06ah	; 7342
	defb 013h,016h,06ah	; 7345
	defb 0e5h,0c2h,02fh,0b0h,043h,0b5h	; 7348
	defb 0e5h,0b4h,0cch,0afh,009h,0b5h	; 734e

; ----------------------------------------------------------------------
; DATOS lista_7354: lista del cargador de tiles (0x4CCD): 3 registros de 6 B y
;   11 ordenes, tiles 59-106; la usa tabla_61A9[34]
;   0x7354..0x7388  (52 bytes)
DATA_lista_7354:
	defb 013h,0e5h,068h	; 7354
	defb 0e5h,067h,0c0h,0b3h,014h,0bbh	; 7357
	defb 017h,04ch,064h	; 735d
	defb 017h,02ch,061h	; 7360
	defb 013h,0a0h,068h	; 7363
	defb 0e5h,050h,03ah,0b3h,078h,0b6h	; 7366
	defb 013h,07fh,068h	; 736c
	defb 013h,059h,068h	; 736f
	defb 0e5h,03bh,00dh,0b0h,024h,0b5h	; 7372
	defb 013h,043h,067h	; 7378
	defb 017h,049h,029h	; 737b
	defb 013h,005h,066h	; 737e
	defb 013h,0beh,065h	; 7381
	defb 013h,013h,065h	; 7384
	defb 000h	; 7387

; ----------------------------------------------------------------------
; DATOS lista_7388: lista del cargador de tiles (0x4CCD): 7 registros de 6 B y
;   26 ordenes, tiles 59-194; la usa tabla_61A9[19]; sigue en la lista de
;   0x73b8
;   0x7388..0x73b8  (48 bytes)
DATA_lista_7388:
	defb 013h,0a6h,070h	; 7388
	defb 013h,095h,06ah	; 738b
	defb 0f5h,0c2h,0b6h,0b3h,0b4h,0b6h	; 738e
	defb 0e5h,0c1h,0b6h,0b3h,0b4h,0b6h	; 7394
	defb 0e5h,0beh,0a8h,0b3h,09ch,0b6h	; 739a
	defb 017h,033h,0bch	; 73a0
	defb 017h,034h,0bdh	; 73a3
	defb 017h,04dh,0bbh	; 73a6
	defb 017h,052h,0bah	; 73a9
	defb 017h,051h,0b9h	; 73ac
	defb 017h,050h,0b8h	; 73af
	defb 017h,04fh,0b7h	; 73b2
	defb 017h,04eh,0b5h	; 73b5

; ----------------------------------------------------------------------
; DATOS lista_73B8: lista del cargador de tiles (0x4CCD): 4 registros de 6 B y
;   16 ordenes, tiles 59-106; la usa tabla_61A9[40]
;   0x73b8..0x7401  (73 bytes)
DATA_lista_73B8:
	defb 013h,016h,06ah	; 73b8
	defb 013h,0d9h,069h	; 73bb
	defb 0e5h,067h,0c0h,0b3h,055h,0bbh	; 73be
	defb 0e5h,064h,016h,0b0h,008h,0b7h	; 73c4
	defb 0e1h,061h,04ah,094h,01dh,0a2h	; 73ca
	defb 017h,052h,065h	; 73d0
	defb 017h,050h,064h	; 73d3
	defb 013h,0cfh,068h	; 73d6
	defb 017h,04fh,052h	; 73d9
	defb 017h,051h,051h	; 73dc
	defb 017h,034h,050h	; 73df
	defb 013h,093h,068h	; 73e2
	defb 013h,034h,068h	; 73e5
	defb 0e5h,03bh,00dh,0b0h,0efh,0b6h	; 73e8
	defb 013h,08dh,067h	; 73ee
	defb 017h,033h,029h	; 73f1
	defb 017h,04eh,02ah	; 73f4
	defb 013h,0b0h,066h	; 73f7
	defb 013h,0abh,065h	; 73fa
	defb 013h,068h,065h	; 73fd
	defb 000h	; 7400

; ----------------------------------------------------------------------
; DATOS lista_7401: lista del cargador de tiles (0x4CCD): 2 registros de 6 B y
;   7 ordenes, tiles 94-99; la usa tabla_61A9[20]; sigue en la lista de 0x7415
;   0x7401..0x7415  (20 bytes)
DATA_lista_7401:
	defb 010h,001h,068h,06ah,06ch,083h,087h,08bh,08fh,093h,093h,093h,0c4h,0c4h,0c4h,0c4h,0c4h	; 7401  ..hjl............
	defb 011h,037h,004h	; 7412

; ----------------------------------------------------------------------
; DATOS lista_7415: lista del cargador de tiles (0x4CCD): 2 registros de 6 B y
;   5 ordenes, tiles 94-99; la usa tabla_61A9[41]
;   0x7415..0x7431  (28 bytes)
DATA_lista_7415:
	defb 013h,015h,064h	; 7415
	defb 0e1h,05eh,03fh,0b1h,003h,0b2h	; 7418
	defb 0e1h,060h,03fh,0b1h,003h,0b2h	; 741e
	defb 017h,00fh,062h	; 7424
	defb 013h,085h,064h	; 7427
	defb 013h,0c5h,064h	; 742a
	defb 013h,0cfh,064h	; 742d
	defb 000h	; 7430

; ----------------------------------------------------------------------
; DATOS tabla_7431: 21 punteros al juego de fotogramas de cada tipo de coche
;   (ix+0x18), para FOTOGRAMA_COCHE (0x46C5)
;   0x7431..0x745b  (42 bytes)
DATA_tabla_7431:
	defw 08271h	; 7431
	defw 08271h	; 7433
	defw 08271h	; 7435
	defw 085f1h	; 7437
	defw 08731h	; 7439
	defw 08731h	; 743b
	defw 07eb1h	; 743d  -> DATA_fotogramas_7EB1
	defw 07eb1h	; 743f  -> DATA_fotogramas_7EB1
	defw 07ff1h	; 7441  -> DATA_fotogramas_7FF1
	defw 07af1h	; 7443  -> DATA_fotogramas_7AF1
	defw 07af1h	; 7445  -> DATA_fotogramas_7AF1
	defw 07af1h	; 7447  -> DATA_fotogramas_7AF1
	defw 07731h	; 7449  -> DATA_fotogramas_7731
	defw 07731h	; 744b  -> DATA_fotogramas_7731
	defw 07731h	; 744d  -> DATA_fotogramas_7731
	defw 07731h	; 744f  -> DATA_fotogramas_7731
	defw 07731h	; 7451  -> DATA_fotogramas_7731
	defw 07731h	; 7453  -> DATA_fotogramas_7731
	defw 00000h	; 7455
	defw 00000h	; 7457
	defw 00000h	; 7459

; ----------------------------------------------------------------------
; DATOS tabla_745B: 19 punteros al juego de fotogramas de cada tipo de coche
;   (ix+0x18), para FOTOGRAMA_COCHE_40 (0x4744)
;   0x745b..0x7481  (38 bytes)
DATA_tabla_745B:
	defw 08871h	; 745b
	defw 08871h	; 745d
	defw 08871h	; 745f
	defw 08871h	; 7461
	defw 08871h	; 7463
	defw 08871h	; 7465
	defw 08131h	; 7467
	defw 08131h	; 7469
	defw 08131h	; 746b
	defw 07d71h	; 746d  -> DATA_fotogramas_7D71
	defw 07d71h	; 746f  -> DATA_fotogramas_7D71
	defw 07d71h	; 7471  -> DATA_fotogramas_7D71
	defw 079b1h	; 7473  -> DATA_fotogramas_79B1
	defw 079b1h	; 7475  -> DATA_fotogramas_79B1
	defw 079b1h	; 7477  -> DATA_fotogramas_79B1
	defw 079b1h	; 7479  -> DATA_fotogramas_79B1
	defw 079b1h	; 747b  -> DATA_fotogramas_79B1
	defw 079b1h	; 747d  -> DATA_fotogramas_79B1
	defw 00000h	; 747f

; ----------------------------------------------------------------------
; DATOS tabla_listas_sprites: 18 punteros a listas del cargador de sprites, 3
;   por categoria (E25B); CARGA_SPRITES_CARRERA (0x4EDC) lee el primero de
;   cada tres
;   0x7481..0x74a5  (36 bytes)
DATA_tabla_listas_sprites:
	defw 074bah,074bah,074bah	; 7481  -> DATA_sprites_74BA DATA_sprites_74BA DATA_sprites_74BA
	defw 074c7h,074c7h,074c7h	; 7487  -> DATA_sprites_74C7 DATA_sprites_74C7 DATA_sprites_74C7
	defw 074c0h,074c0h,074c0h	; 748d  -> DATA_sprites_74C0 DATA_sprites_74C0 DATA_sprites_74C0
	defw 074ceh,074d3h,074d8h	; 7493  -> DATA_sprites_74CE DATA_sprites_74D3 DATA_sprites_74D8
	defw 074ddh,074e2h,074e7h	; 7499  -> DATA_sprites_74DD DATA_sprites_74E2 DATA_sprites_74E7
	defw 074ddh,074e2h,074e7h	; 749f  -> DATA_sprites_74DD DATA_sprites_74E2 DATA_sprites_74E7

; ----------------------------------------------------------------------
; DATOS sprites_74A5: lista del cargador de sprites (0x4F1A): 10 pares
;   (recurso, patron) y 0xFF; la usa p00 0x4ECA
;   0x74a5..0x74ba  (21 bytes)
DATA_sprites_74A5:
	defb 011h,0d4h	; 74a5
	defb 014h,0dch	; 74a7
	defb 012h,0e0h	; 74a9
	defb 013h,0e4h	; 74ab
	defb 000h,0e8h	; 74ad
	defb 015h,0c0h	; 74af
	defb 016h,0c4h	; 74b1
	defb 017h,0c8h	; 74b3
	defb 018h,0cch	; 74b5
	defb 019h,0d0h	; 74b7
	defb 0ffh	; 74b9

; ----------------------------------------------------------------------
; DATOS sprites_74BA: lista del cargador de sprites (0x4F1A): 2 pares
;   (recurso, patron) y 0xFF; la usa tabla_7481[0]
;   0x74ba..0x74bf  (5 bytes)
DATA_sprites_74BA:
	defb 00bh,078h	; 74ba
	defb 00ah,020h	; 74bc
	defb 0ffh	; 74be

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (1 bytes)
;   0x74bf..0x74c0  (1 bytes)
DATA_74BF:
	defb 0ffh	; 74bf

; ----------------------------------------------------------------------
; DATOS sprites_74C0: lista del cargador de sprites (0x4F1A): 3 pares
;   (recurso, patron) y 0xFF; la usa tabla_7481[6]
;   0x74c0..0x74c7  (7 bytes)
DATA_sprites_74C0:
	defb 007h,020h	; 74c0
	defb 008h,048h	; 74c2
	defb 009h,070h	; 74c4
	defb 0ffh	; 74c6

; ----------------------------------------------------------------------
; DATOS sprites_74C7: lista del cargador de sprites (0x4F1A): 3 pares
;   (recurso, patron) y 0xFF; la usa tabla_7481[3]
;   0x74c7..0x74ce  (7 bytes)
DATA_sprites_74C7:
	defb 00ch,020h	; 74c7
	defb 00dh,048h	; 74c9
	defb 00eh,070h	; 74cb
	defb 0ffh	; 74cd

; ----------------------------------------------------------------------
; DATOS sprites_74CE: lista del cargador de sprites (0x4F1A): 2 pares
;   (recurso, patron) y 0xFF; la usa tabla_7481[9]
;   0x74ce..0x74d3  (5 bytes)
DATA_sprites_74CE:
	defb 004h,020h	; 74ce
	defb 005h,070h	; 74d0
	defb 0ffh	; 74d2

; ----------------------------------------------------------------------
; DATOS sprites_74D3: lista del cargador de sprites (0x4F1A): 2 pares
;   (recurso, patron) y 0xFF; la usa tabla_7481[10]
;   0x74d3..0x74d8  (5 bytes)
DATA_sprites_74D3:
	defb 004h,020h	; 74d3
	defb 006h,070h	; 74d5
	defb 0ffh	; 74d7

; ----------------------------------------------------------------------
; DATOS sprites_74D8: lista del cargador de sprites (0x4F1A): 2 pares
;   (recurso, patron) y 0xFF; la usa tabla_7481[11]
;   0x74d8..0x74dd  (5 bytes)
DATA_sprites_74D8:
	defb 005h,020h	; 74d8
	defb 006h,070h	; 74da
	defb 0ffh	; 74dc

; ----------------------------------------------------------------------
; DATOS sprites_74DD: lista del cargador de sprites (0x4F1A): 2 pares
;   (recurso, patron) y 0xFF; la usa tabla_7481[12]
;   0x74dd..0x74e2  (5 bytes)
DATA_sprites_74DD:
	defb 001h,020h	; 74dd
	defb 002h,070h	; 74df
	defb 0ffh	; 74e1

; ----------------------------------------------------------------------
; DATOS sprites_74E2: lista del cargador de sprites (0x4F1A): 2 pares
;   (recurso, patron) y 0xFF; la usa tabla_7481[13]
;   0x74e2..0x74e7  (5 bytes)
DATA_sprites_74E2:
	defb 001h,020h	; 74e2
	defb 003h,070h	; 74e4
	defb 0ffh	; 74e6

; ----------------------------------------------------------------------
; DATOS sprites_74E7: lista del cargador de sprites (0x4F1A): 2 pares
;   (recurso, patron) y 0xFF; la usa tabla_7481[14]
;   0x74e7..0x74ec  (5 bytes)
DATA_sprites_74E7:
	defb 002h,020h	; 74e7
	defb 003h,070h	; 74e9
	defb 0ffh	; 74eb

; ----------------------------------------------------------------------
; DATOS sprites_74EC: lista del cargador de sprites (0x4F1A): 1 pares
;   (recurso, patron) y 0xFF; la usa p00 0x4F8B
;   0x74ec..0x74ef  (3 bytes)
DATA_sprites_74EC:
	defb 00fh,018h	; 74ec
	defb 0ffh	; 74ee

; ----------------------------------------------------------------------
; DATOS sprites_74EF: lista del cargador de sprites (0x4F1A): 1 pares
;   (recurso, patron) y 0xFF; la usa p01 0x6354
;   0x74ef..0x74f2  (3 bytes)
DATA_sprites_74EF:
	defb 010h,000h	; 74ef
	defb 0ffh	; 74f1

; ----------------------------------------------------------------------
; DATOS sprites_74F2: lista del cargador de sprites (0x4F1A): 1 pares
;   (recurso, patron) y 0xFF; la usa p00 0x5961
;   0x74f2..0x74f5  (3 bytes)
DATA_sprites_74F2:
	defb 01ah,0c0h	; 74f2
	defb 0ffh	; 74f4

; ----------------------------------------------------------------------
; DATOS sprites_74F5: lista del cargador de sprites (0x4F1A): 6 pares
;   (recurso, patron) y 0xFF; la usa ningun llamador en el codigo trazado (es
;   la unica lista que pide los recursos 27-32, los fotogramas sueltos)
;   0x74f5..0x7502  (13 bytes)
DATA_sprites_74F5:
	defb 01bh,000h	; 74f5
	defb 01ch,008h	; 74f7
	defb 01dh,010h	; 74f9
	defb 01eh,018h	; 74fb
	defb 01fh,020h	; 74fd
	defb 020h,028h	; 74ff
	defb 0ffh	; 7501

; ----------------------------------------------------------------------
; DATOS sprites_7502: lista del cargador de sprites (0x4F1A): 1 pares
;   (recurso, patron) y 0xFF; la usa p02 0x8247
;   0x7502..0x7505  (3 bytes)
DATA_sprites_7502:
	defb 021h,000h	; 7502
	defb 0ffh	; 7504

; ----------------------------------------------------------------------
; DATOS tabla_recursos_sprites: 34 recursos de sprites de 6 B (clase en EB40,
;   tipo 0 = RLE / 2 = copia / 1 y FF = nada, origen, longitud) para
;   CARGA_RECURSO_SPRITE (0x4F28)
;   0x7505..0x75d1  (204 bytes)
DATA_tabla_recursos_sprites:
	defb 008h,002h,0b1h,089h,0c0h,000h	; 7505
	defb 000h,002h,031h,077h,080h,002h	; 750b
	defb 001h,002h,031h,077h,080h,002h	; 7511
	defb 002h,002h,031h,077h,080h,002h	; 7517
	defb 000h,002h,0f1h,07ah,080h,002h	; 751d
	defb 001h,002h,0f1h,07ah,080h,002h	; 7523
	defb 002h,002h,0f1h,07ah,080h,002h	; 7529
	defb 000h,002h,0b1h,07eh,040h,001h	; 752f
	defb 001h,002h,0b1h,07eh,040h,001h	; 7535
	defb 002h,002h,0f1h,07fh,040h,001h	; 753b
	defb 000h,002h,071h,082h,080h,002h	; 7541
	defb 008h,002h,031h,085h,0c0h,000h	; 7547
	defb 000h,002h,0f1h,085h,040h,001h	; 754d
	defb 001h,002h,031h,087h,040h,001h	; 7553
	defb 002h,002h,031h,087h,040h,001h	; 7559
	defb 008h,000h,071h,08eh,000h,004h	; 755f
	defb 008h,000h,014h,091h,040h,000h	; 7565
	defb 008h,000h,038h,091h,020h,000h	; 756b
	defb 008h,002h,071h,08dh,020h,000h	; 7571
	defb 008h,002h,091h,08dh,020h,000h	; 7577
	defb 008h,002h,0b1h,08dh,020h,000h	; 757d
	defb 008h,002h,0d1h,08dh,020h,000h	; 7583
	defb 008h,002h,0f1h,08dh,020h,000h	; 7589
	defb 008h,002h,011h,08eh,020h,000h	; 758f
	defb 008h,002h,031h,08eh,020h,000h	; 7595
	defb 008h,002h,051h,08eh,020h,000h	; 759b
	defb 008h,000h,041h,091h,040h,000h	; 75a1
	defb 008h,002h,0f1h,082h,040h,000h	; 75a7
	defb 008h,002h,071h,086h,040h,000h	; 75ad
	defb 008h,002h,031h,07fh,040h,000h	; 75b3
	defb 008h,002h,071h,07bh,040h,000h	; 75b9
	defb 008h,002h,0b1h,077h,040h,000h	; 75bf
	defb 008h,002h,0b1h,077h,040h,000h	; 75c5
	defb 008h,000h,0c5h,076h,020h,000h	; 75cb

; ----------------------------------------------------------------------
; DATOS tiles_coche: 6 parejas de tiles (16 B) que TILES_COCHE (0x4701) copia
;   a los patrones 0x2670/0x2680 segun (ix-3) = 1..6
;   0x75d1..0x7631  (96 bytes)
DATA_tiles_coche:
	defb 0efh,0cfh,081h,000h,080h,0cch,0ech,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch	; 75d1  ................
	defb 0f7h,0f3h,081h,000h,001h,033h,037h,03fh,03fh,03fh,03fh,03fh,03fh,03fh,03fh,03fh	; 75e1  .....37?????????
	defb 0ffh,083h,087h,087h,083h,0b1h,0f8h,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch	; 75f1  ................
	defb 0ffh,0c1h,0e1h,0e1h,0c1h,08dh,01fh,03fh,03fh,03fh,03fh,03fh,03fh,03fh,03fh,03fh	; 7601  .......?????????
	defb 0ffh,083h,087h,087h,083h,0b1h,0f9h,0f1h,0e3h,0c7h,08fh,09fh,08fh,0c7h,0e3h,0f3h	; 7611  ................
	defb 0ffh,0c1h,0e1h,0e1h,0c1h,08dh,09fh,08fh,0c7h,0e3h,0f1h,0f9h,0f1h,0e3h,0c7h,0cfh	; 7621  ................

; ----------------------------------------------------------------------
; DATOS rle_pat_7631: patrones RLE: 2 tiles desde el 208 (lista 0x6211)
;   0x7631..0x7634  (3 bytes)
DATA_rle_pat_7631:
	defb 010h,09fh,000h	; 7631

; ----------------------------------------------------------------------
; DATOS rle_pat_7634: patrones RLE: 2 tiles desde el 208 (lista 0x61fd)
;   0x7634..0x7637  (3 bytes)
DATA_rle_pat_7634:
	defb 010h,0e6h,000h	; 7634

; ----------------------------------------------------------------------
; DATOS rle_col_7637: colores RLE: 4 tiles desde el 252 (lista 0x620a)
;   0x7637..0x763a  (3 bytes)
DATA_rle_col_7637:
	defb 020h,0f0h,000h	; 7637

; ----------------------------------------------------------------------
; DATOS rle_pat_763A: patrones RLE: 4 tiles desde el 252 (lista 0x620a)
;   0x763a..0x763d  (3 bytes)
DATA_rle_pat_763A:
	defb 020h,000h,000h	; 763a

; ----------------------------------------------------------------------
; DATOS rle_pat_763D: patrones RLE: 1 tiles desde el 5 (lista 0x6e06)
;   0x763d..0x7642  (5 bytes)
DATA_rle_pat_763D:
	defb 004h,0f0h,004h,00fh,000h	; 763d

; ----------------------------------------------------------------------
; DATOS rle_col_7642: colores RLE: 1 tiles desde el 5 (lista 0x6e06)
;   0x7642..0x7645  (3 bytes)
DATA_rle_col_7642:
	defb 008h,0f0h,000h	; 7642

; ----------------------------------------------------------------------
; DATOS patrones_7645: 16 patrones de tile de 8 bytes SIN comprimir (los demas
;   graficos del cartucho van en RLE): dibujan una figura de dos mitades
;   simetricas. Quien los carga, por identificar
;   0x7645..0x76c5  (128 bytes)
DATA_patrones_7645:
	defb 000h,007h,00dh,00bh,01bh,01fh,03fh,07fh	; 7645  ......?.
	defb 07fh,04fh,04fh,007h,007h,002h,000h,000h	; 764d  .OO.....
	defb 000h,0e0h,0f0h,0f0h,0f8h,0feh,0feh,0f8h	; 7655  ........
	defb 0f8h,0f8h,0f8h,0f8h,0c0h,0c0h,080h,000h	; 765d  ........
	defb 007h,008h,010h,010h,020h,020h,040h,080h	; 7665  ....  @.
	defb 080h,0b0h,0b0h,058h,018h,01dh,00fh,003h	; 766d  ...X....
	defb 0e0h,010h,008h,008h,006h,001h,001h,006h	; 7675  ........
	defb 004h,004h,004h,006h,026h,02ah,072h,0fch	; 767d  ....&*r.
	defb 000h,007h,00dh,00bh,01bh,07fh,07fh,01fh	; 7685  ........
	defb 01fh,01fh,01fh,01fh,003h,003h,001h,000h	; 768d  ........
	defb 000h,0e0h,0f0h,0f0h,0f8h,0f8h,0fch,0feh	; 7695  ........
	defb 0feh,0f2h,0f2h,0e0h,0e0h,040h,000h,000h	; 769d  .....@..
	defb 007h,008h,010h,010h,060h,080h,080h,060h	; 76a5  ....`..`
	defb 020h,020h,020h,060h,064h,054h,04eh,03fh	; 76ad     `dTN?
	defb 0e0h,010h,008h,008h,004h,004h,002h,001h	; 76b5  ........
	defb 001h,00dh,00dh,01ah,018h,0b8h,0f0h,0c0h	; 76bd  ........

; ----------------------------------------------------------------------
; DATOS rle_sprites_76C5: patrones de sprites RLE (0x4862): 10 sprites de
;   16x16; recurso 33 de la tabla 0x7505
;   0x76c5..0x7731  (108 bytes)
DATA_rle_sprites_76C5:
	defb 002h,000h,089h,001h,003h,007h,006h,00eh,00ch,01ch,018h,018h,003h,030h,002h,000h	; 76c5  .............0..
	defb 084h,060h,0e0h,0c0h,080h,021h,000h,00bh,0c0h,012h,000h,003h,0c0h,002h,060h,083h	; 76d5  .`...!........`.
	defb 070h,030h,030h,00dh,000h,083h,001h,003h,001h,00ch,000h,085h,080h,0c0h,0e0h,0c0h	; 76e5  p00.............
	defb 080h,00ch,000h,081h,001h,020h,000h,081h,001h,00eh,000h,081h,080h,00fh,000h,081h	; 76f5  ..... ..........
	defb 001h,010h,000h,081h,080h,00fh,000h,081h,003h,00dh,000h,002h,080h,083h,0e0h,080h	; 7705  ................
	defb 080h,00ch,000h,083h,001h,000h,001h,00dh,000h,083h,040h,000h,040h,00ch,000h,083h	; 7715  ..........@.@...
	defb 003h,007h,007h,00dh,000h,083h,0c0h,0e0h,0e0h,007h,000h,000h	; 7725  ............

; ----------------------------------------------------------------------
; DATOS fotogramas_7731: juego de 10 fotogramas de coche (64 B = 2 sprites de
;   16x16, media fila = 16 B); lo usan recurso_sprite[1], recurso_sprite[2],
;   recurso_sprite[3], tabla_7431[12], tabla_7431[13], tabla_7431[14],
;   tabla_7431[15], tabla_7431[16], tabla_7431[17]
;   0x7731..0x79b1  (640 bytes)
DATA_fotogramas_7731:
	defb 009h,018h,030h,06eh,005h,004h,040h,002h,006h,003h,001h,000h,000h,000h,000h,000h	; 7731  ..0n..@.........
	defb 000h,000h,000h,000h,040h,060h,070h,0b2h,050h,024h,08eh,01ch,038h,050h,000h,000h	; 7741  ....@`p.P$..8P..
	defb 002h,005h,00eh,010h,038h,05bh,03fh,065h,009h,00ch,006h,003h,000h,001h,001h,000h	; 7751  ....8[?e........
	defb 000h,000h,000h,000h,000h,080h,000h,004h,0a9h,0dah,070h,0e0h,080h,020h,0e0h,0c0h	; 7761  ..........p.. ..
	defb 003h,00ch,016h,003h,022h,002h,000h,002h,006h,003h,003h,000h,000h,000h,001h,000h	; 7771  ...."...........
	defb 000h,040h,000h,000h,080h,020h,070h,0b0h,078h,050h,022h,088h,03ch,078h,020h,000h	; 7781  .@... p.xP".<x .
	defb 000h,003h,009h,01ch,00ch,035h,003h,005h,009h,004h,004h,003h,001h,003h,002h,001h	; 7791  .....5..........
	defb 000h,000h,0c0h,080h,000h,0c0h,080h,000h,080h,0a4h,0d8h,076h,0c0h,080h,040h,080h	; 77a1  ...........v..@.
	defb 007h,011h,001h,002h,002h,000h,00ch,00eh,00fh,00fh,005h,001h,010h,007h,007h,000h	; 77b1  ................
	defb 0c0h,010h,000h,000h,080h,000h,0e0h,060h,060h,060h,040h,000h,010h,0c0h,0c0h,000h	; 77c1  .......```@.....
	defb 000h,006h,01eh,004h,001h,003h,003h,000h,000h,000h,002h,01eh,007h,018h,000h,000h	; 77d1  ................
	defb 000h,0c0h,0f8h,0f8h,040h,0c0h,010h,090h,090h,090h,0a0h,0f0h,0c8h,038h,038h,000h	; 77e1  ....@........88.
	defb 000h,002h,000h,000h,001h,004h,00eh,00dh,01eh,00ah,044h,011h,03ch,01eh,004h,000h	; 77f1  ..........D.<...
	defb 0c0h,030h,068h,0c0h,044h,040h,000h,040h,060h,0c0h,0c0h,000h,000h,000h,080h,000h	; 7801  .0h.D@.@`.......
	defb 000h,000h,003h,001h,000h,003h,001h,000h,001h,025h,01bh,06eh,003h,001h,002h,001h	; 7811  .........%.n....
	defb 000h,0c0h,090h,038h,030h,0ach,0c0h,0a0h,090h,020h,020h,0c0h,080h,0c0h,040h,080h	; 7821  ...80....  ...@.
	defb 000h,000h,000h,000h,002h,006h,00eh,04dh,00ah,024h,071h,038h,01ch,00ah,000h,000h	; 7831  .......M.$q8....
	defb 090h,018h,00ch,076h,0a0h,020h,002h,040h,060h,0c0h,080h,000h,000h,000h,000h,000h	; 7841  ...v. .@`.......
	defb 000h,000h,000h,000h,000h,001h,000h,020h,095h,05bh,00eh,007h,001h,004h,007h,003h	; 7851  ....... .[......
	defb 040h,0a0h,070h,008h,01ch,0dah,0fch,0a6h,090h,030h,060h,0c0h,000h,080h,080h,000h	; 7861  @.p......0`.....
	defb 008h,019h,030h,06eh,005h,004h,020h,002h,006h,003h,001h,000h,000h,000h,000h,000h	; 7871  ..0n.. .........
	defb 000h,000h,000h,000h,040h,060h,070h,0b0h,051h,024h,08eh,01ch,038h,010h,040h,000h	; 7881  ....@`p.Q$..8.@.
	defb 003h,006h,00eh,010h,038h,07bh,05fh,065h,009h,00ch,006h,003h,000h,001h,001h,000h	; 7891  ....8{_e........
	defb 000h,000h,000h,000h,000h,080h,000h,006h,0aeh,0dah,070h,0e0h,0c0h,0e0h,0a0h,0c0h	; 78a1  ..........p.....
	defb 003h,00ch,016h,003h,002h,022h,000h,002h,006h,003h,003h,000h,000h,000h,000h,000h	; 78b1  ....."..........
	defb 000h,000h,040h,000h,080h,020h,070h,0b0h,078h,050h,020h,08ah,03ch,078h,020h,080h	; 78c1  ..@.. p.xP .<x .
	defb 000h,003h,009h,01ch,03ch,015h,003h,005h,009h,004h,004h,003h,001h,003h,003h,001h	; 78d1  ....<...........
	defb 000h,0c0h,080h,080h,000h,0c0h,080h,000h,080h,0a4h,0deh,074h,0c0h,080h,0c0h,000h	; 78e1  ...........t....
	defb 007h,001h,011h,002h,002h,000h,00ch,00eh,00fh,00fh,005h,001h,000h,017h,007h,000h	; 78f1  ................
	defb 0c0h,000h,010h,000h,080h,000h,0e0h,060h,060h,060h,040h,000h,000h,0d0h,0c0h,000h	; 7901  .......```@.....
	defb 000h,01eh,00eh,004h,001h,003h,003h,000h,000h,000h,002h,01eh,01fh,008h,000h,000h	; 7911  ................
	defb 000h,0f0h,0e8h,0f8h,040h,0c0h,010h,090h,090h,090h,0a0h,0f0h,0f8h,028h,038h,000h	; 7921  ....@........(8.
	defb 000h,000h,002h,000h,001h,004h,00eh,00dh,01eh,00ah,004h,051h,03ch,01eh,004h,001h	; 7931  ...........Q<...
	defb 0c0h,030h,068h,0c0h,040h,044h,000h,040h,060h,0c0h,0c0h,000h,000h,000h,000h,000h	; 7941  .0h.@D.@`.......
	defb 000h,003h,001h,001h,000h,003h,001h,000h,001h,025h,07bh,02eh,003h,001h,003h,000h	; 7951  .........%{.....
	defb 000h,0c0h,090h,038h,03ch,0a8h,0c0h,0a0h,090h,020h,020h,0c0h,080h,0c0h,0c0h,080h	; 7961  ...8<....  .....
	defb 000h,000h,000h,000h,002h,006h,00eh,00dh,08ah,024h,071h,038h,01ch,008h,002h,000h	; 7971  .........$q8....
	defb 010h,098h,00ch,076h,0a0h,020h,004h,040h,060h,0c0h,080h,000h,000h,000h,000h,000h	; 7981  ...v. .@`.......
	defb 000h,000h,000h,000h,000h,001h,000h,060h,075h,05bh,00eh,007h,003h,007h,005h,003h	; 7991  .......`u[......
	defb 0c0h,060h,070h,008h,01ch,0deh,0fah,0a6h,090h,030h,060h,0c0h,000h,080h,080h,000h	; 79a1  .`p......0`.....

; ----------------------------------------------------------------------
; DATOS fotogramas_79B1: juego de 5 fotogramas de coche (64 B = 2 sprites de
;   16x16, media fila = 16 B); lo usan tabla_745B[12], tabla_745B[13],
;   tabla_745B[14], tabla_745B[15], tabla_745B[16], tabla_745B[17]
;   0x79b1..0x7af1  (320 bytes)
DATA_fotogramas_79B1:
	defb 000h,000h,000h,010h,003h,067h,062h,06fh,060h,067h,003h,010h,000h,000h,000h,000h	; 79b1  .....gbo`g......
	defb 000h,000h,000h,002h,0c0h,0c1h,019h,087h,051h,0c1h,0c0h,002h,000h,000h,000h,000h	; 79c1  ........Q.......
	defb 000h,000h,000h,028h,028h,018h,01ch,010h,01fh,018h,06ch,06bh,070h,000h,000h,000h	; 79d1  ...((.....lkp...
	defb 000h,000h,000h,004h,004h,00eh,066h,070h,0aeh,03eh,00ch,0cch,00ch,000h,000h,000h	; 79e1  ......fp.>......
	defb 000h,004h,00eh,01ch,039h,010h,020h,004h,006h,003h,001h,000h,000h,000h,000h,000h	; 79f1  ....9. .........
	defb 000h,080h,000h,000h,0c0h,0e0h,0f0h,0c0h,011h,088h,038h,00bh,006h,00ch,048h,000h	; 7a01  ..........8...H.
	defb 001h,002h,000h,003h,006h,02fh,04eh,05bh,079h,02ch,006h,003h,001h,000h,000h,000h	; 7a11  ...../N[y,......
	defb 000h,000h,080h,000h,000h,000h,000h,030h,0e2h,065h,0c6h,0f4h,039h,052h,0b4h,068h	; 7a21  .......0.e..9R.h
	defb 000h,007h,007h,010h,000h,004h,00dh,00dh,00fh,00ch,000h,002h,002h,001h,011h,007h	; 7a31  ................
	defb 000h,0c0h,0c0h,010h,000h,040h,060h,060h,060h,0e0h,000h,080h,000h,000h,010h,0c0h	; 7a41  .....@```.......
	defb 000h,000h,018h,007h,01fh,002h,000h,000h,000h,003h,00fh,001h,004h,01eh,006h,000h	; 7a51  ................
	defb 000h,000h,030h,0c8h,0f8h,0a0h,090h,090h,090h,010h,0f0h,040h,0e0h,0f0h,0c8h,038h	; 7a61  ..0........@...8
	defb 000h,001h,000h,000h,003h,007h,00eh,001h,088h,011h,01ch,0d0h,060h,030h,012h,000h	; 7a71  ............`0..
	defb 000h,020h,070h,038h,09ch,008h,084h,020h,060h,0c0h,080h,000h,000h,000h,000h,000h	; 7a81  . p8... `.......
	defb 000h,000h,001h,000h,000h,000h,000h,004h,047h,0a6h,063h,02fh,01ch,00ah,00dh,006h	; 7a91  ........G.c/....
	defb 080h,040h,000h,0c0h,060h,0f4h,072h,0dah,09eh,03ch,060h,0c0h,080h,000h,000h,000h	; 7aa1  .@..`.r..<`.....
	defb 000h,000h,000h,040h,003h,083h,098h,0e1h,08ah,083h,003h,040h,000h,000h,000h,000h	; 7ab1  ...@.......@....
	defb 000h,000h,000h,008h,0c0h,0e6h,046h,0f6h,006h,0e6h,0c0h,008h,000h,000h,000h,000h	; 7ac1  ......F.........
	defb 000h,000h,000h,020h,020h,070h,066h,00eh,075h,07ch,030h,033h,030h,000h,000h,000h	; 7ad1  ...  pf.u|030...
	defb 000h,000h,000h,014h,014h,018h,038h,008h,0f8h,018h,036h,0d6h,00eh,000h,000h,000h	; 7ae1  ......8...6.....

; ----------------------------------------------------------------------
; DATOS fotogramas_7AF1: juego de 10 fotogramas de coche (64 B = 2 sprites de
;   16x16, media fila = 16 B); lo usan recurso_sprite[4], recurso_sprite[5],
;   recurso_sprite[6], tabla_7431[10], tabla_7431[11], tabla_7431[9]
;   0x7af1..0x7d71  (640 bytes)
DATA_fotogramas_7AF1:
	defb 000h,004h,00ch,018h,037h,004h,004h,012h,002h,001h,000h,000h,000h,000h,000h,000h	; 7af1  ....7...........
	defb 000h,000h,080h,000h,000h,0c0h,060h,012h,070h,030h,046h,00ch,018h,050h,000h,000h	; 7b01  ......`.p0F..P..
	defb 000h,000h,000h,006h,008h,03bh,023h,025h,005h,002h,003h,001h,001h,001h,000h,000h	; 7b11  .....;#%........
	defb 000h,000h,000h,080h,080h,000h,080h,084h,089h,0ceh,038h,0f0h,0a0h,020h,0e0h,040h	; 7b21  ..........8.. .@
	defb 000h,003h,00eh,002h,003h,002h,012h,006h,002h,001h,000h,000h,000h,001h,000h,000h	; 7b31  ................
	defb 000h,000h,040h,000h,080h,0c0h,060h,060h,010h,070h,026h,0a0h,09ch,038h,060h,000h	; 7b41  ..@...``.p&..8`.
	defb 000h,000h,001h,00dh,01ch,015h,00dh,009h,005h,006h,006h,003h,003h,002h,001h,001h	; 7b51  ................
	defb 000h,000h,080h,040h,040h,000h,080h,080h,000h,084h,0d8h,05ah,060h,040h,080h,0c0h	; 7b61  ...@@......Z`@..
	defb 000h,007h,001h,009h,003h,002h,004h,004h,006h,001h,007h,003h,010h,007h,007h,000h	; 7b71  ................
	defb 000h,0c0h,000h,020h,080h,080h,040h,040h,040h,000h,040h,000h,010h,0c0h,0c0h,000h	; 7b81  ... ..@@@.@.....
	defb 000h,000h,006h,002h,00ch,005h,003h,003h,000h,000h,000h,01ch,007h,018h,000h,000h	; 7b91  ................
	defb 000h,000h,0e0h,090h,070h,040h,0a0h,0a0h,0a0h,0a0h,0a0h,0f0h,0c8h,038h,038h,000h	; 7ba1  ....p@.......88.
	defb 000h,000h,002h,000h,001h,003h,006h,006h,008h,00eh,064h,005h,039h,01ch,006h,000h	; 7bb1  ..........d.9...
	defb 000h,0c0h,070h,040h,0c0h,040h,048h,060h,040h,080h,000h,000h,000h,080h,000h,000h	; 7bc1  ..p@.@H`@.......
	defb 000h,000h,001h,002h,002h,000h,001h,001h,000h,021h,01bh,05ah,006h,002h,001h,003h	; 7bd1  .........!.Z....
	defb 000h,000h,080h,0b0h,038h,0a8h,0b0h,090h,0a0h,060h,060h,0c0h,0c0h,040h,080h,080h	; 7be1  ....8....``..@..
	defb 000h,000h,001h,000h,000h,003h,006h,048h,00eh,00ch,062h,030h,018h,00ah,000h,000h	; 7bf1  .......H..b0....
	defb 000h,020h,030h,018h,0ech,020h,020h,048h,040h,080h,000h,000h,000h,000h,000h,000h	; 7c01  . 0..  H@.......
	defb 000h,000h,000h,001h,001h,000h,001h,021h,091h,073h,01ch,00fh,005h,004h,007h,002h	; 7c11  .......!.s......
	defb 000h,000h,000h,060h,010h,0dch,0c4h,0a4h,0a0h,040h,0c0h,080h,080h,080h,000h,000h	; 7c21  ...`.....@......
	defb 000h,004h,00ch,018h,037h,004h,004h,00ah,002h,001h,000h,000h,000h,000h,000h,000h	; 7c31  ....7...........
	defb 000h,000h,000h,080h,000h,0c0h,060h,010h,071h,030h,046h,00ch,018h,010h,040h,000h	; 7c41  ......`.q0F...@.
	defb 000h,000h,001h,007h,008h,03bh,03bh,035h,005h,002h,003h,001h,001h,001h,000h,000h	; 7c51  .....;;5........
	defb 000h,000h,080h,000h,080h,000h,080h,086h,08eh,0ceh,038h,0f0h,0e0h,0e0h,0a0h,040h	; 7c61  ..........8....@
	defb 000h,003h,00eh,002h,003h,002h,00ah,006h,002h,001h,000h,000h,000h,000h,001h,000h	; 7c71  ................
	defb 000h,000h,000h,040h,080h,0c0h,060h,060h,010h,070h,020h,0a2h,09ch,038h,060h,000h	; 7c81  ...@..``.p ..8`.
	defb 000h,000h,001h,00dh,01ch,01dh,015h,009h,005h,006h,006h,003h,003h,003h,000h,001h	; 7c91  ................
	defb 000h,000h,0c0h,080h,040h,000h,080h,080h,000h,084h,0deh,05ch,060h,0c0h,080h,0c0h	; 7ca1  ....@......\`...
	defb 000h,007h,001h,001h,00bh,002h,004h,004h,006h,001h,007h,003h,000h,017h,007h,000h	; 7cb1  ................
	defb 000h,0c0h,000h,000h,0a0h,080h,040h,040h,040h,000h,040h,000h,000h,0d0h,0c0h,000h	; 7cc1  ......@@@.@.....
	defb 000h,000h,006h,00eh,004h,005h,003h,003h,000h,000h,000h,01ch,01fh,008h,000h,000h	; 7cd1  ................
	defb 000h,000h,0e0h,0f0h,050h,040h,0a0h,0a0h,0a0h,0a0h,0a0h,0f0h,0f8h,028h,038h,000h	; 7ce1  ....P@.......(8.
	defb 000h,000h,000h,002h,001h,003h,006h,006h,008h,00eh,004h,045h,039h,01ch,006h,000h	; 7cf1  ...........E9...
	defb 000h,0c0h,070h,040h,0c0h,040h,050h,060h,040h,080h,000h,000h,000h,000h,080h,000h	; 7d01  ..p@.@P`@.......
	defb 000h,000h,003h,001h,002h,000h,001h,001h,000h,021h,07bh,03ah,006h,003h,001h,003h	; 7d11  .........!{:....
	defb 000h,000h,080h,0b0h,038h,0b8h,0a8h,090h,0a0h,060h,060h,0c0h,0c0h,0c0h,000h,080h	; 7d21  ....8....``.....
	defb 000h,000h,000h,001h,000h,003h,006h,008h,08eh,00ch,062h,030h,018h,008h,002h,000h	; 7d31  ..........b0....
	defb 000h,020h,030h,018h,0ech,020h,020h,050h,040h,080h,000h,000h,000h,000h,000h,000h	; 7d41  . 0..  P@.......
	defb 000h,000h,001h,000h,001h,000h,001h,061h,071h,073h,01ch,00fh,007h,007h,005h,002h	; 7d51  .......aqs......
	defb 000h,000h,080h,0e0h,010h,0dch,0dch,0ach,0a0h,040h,0c0h,080h,080h,080h,000h,000h	; 7d61  .........@......

; ----------------------------------------------------------------------
; DATOS fotogramas_7D71: juego de 5 fotogramas de coche (64 B = 2 sprites de
;   16x16, media fila = 16 B); lo usan tabla_745B[10], tabla_745B[11],
;   tabla_745B[9]
;   0x7d71..0x7eb1  (320 bytes)
DATA_fotogramas_7D71:
	defb 000h,000h,000h,010h,000h,003h,064h,06fh,060h,003h,000h,010h,000h,000h,000h,000h	; 7d71  ......do`.......
	defb 000h,000h,000h,000h,004h,082h,032h,00eh,032h,082h,004h,000h,000h,000h,000h,000h	; 7d81  ......2.2.......
	defb 000h,000h,000h,028h,028h,038h,018h,010h,01fh,07ch,06fh,068h,070h,000h,000h,000h	; 7d91  ...((8...|ohp...
	defb 000h,000h,000h,000h,008h,018h,0cch,0e0h,0cch,078h,09ah,01ch,000h,000h,000h,000h	; 7da1  .........x......
	defb 000h,000h,00ch,01ch,019h,001h,024h,004h,002h,001h,000h,000h,000h,000h,000h,000h	; 7db1  ......$.........
	defb 000h,080h,000h,000h,080h,0c0h,0e0h,000h,022h,050h,036h,00ch,018h,050h,000h,000h	; 7dc1  ........"P6..P..
	defb 001h,002h,002h,003h,006h,03eh,04ah,05bh,03dh,016h,003h,001h,000h,000h,000h,000h	; 7dd1  .....>J[=.......
	defb 000h,000h,080h,000h,000h,000h,000h,0e0h,0d4h,08ah,0c8h,072h,0c4h,0a8h,070h,000h	; 7de1  ...........r..p.
	defb 000h,003h,003h,010h,001h,002h,007h,007h,004h,000h,002h,002h,001h,009h,007h,000h	; 7df1  ................
	defb 000h,080h,080h,010h,000h,000h,040h,040h,040h,000h,080h,080h,000h,020h,0c0h,000h	; 7e01  ......@@@.... ..
	defb 000h,000h,01ch,007h,01eh,000h,000h,000h,003h,003h,001h,000h,00eh,002h,000h,000h	; 7e11  ................
	defb 000h,000h,070h,0c8h,0f8h,0f8h,0a0h,0a0h,0a0h,0e0h,040h,040h,0f0h,090h,030h,000h	; 7e21  ..p.......@@..0.
	defb 000h,001h,000h,000h,001h,003h,007h,000h,044h,00ah,06ch,030h,018h,00ah,000h,000h	; 7e31  ........D.l0....
	defb 000h,000h,030h,038h,098h,000h,0a4h,020h,040h,080h,000h,000h,000h,000h,000h,000h	; 7e41  ..08... @.......
	defb 000h,000h,001h,000h,000h,000h,000h,007h,02bh,051h,013h,00eh,003h,005h,006h,000h	; 7e51  ........+Q......
	defb 080h,040h,040h,0c0h,060h,07ch,052h,0dah,0bch,060h,0c0h,080h,000h,000h,000h,000h	; 7e61  .@@.`|R..`......
	defb 000h,000h,000h,000h,020h,041h,04ch,070h,04ch,041h,020h,000h,000h,000h,000h,000h	; 7e71  .... ALpLA .....
	defb 000h,000h,000h,008h,000h,0c0h,026h,0f6h,006h,0c0h,000h,008h,000h,000h,000h,000h	; 7e81  ......&.........
	defb 000h,000h,000h,000h,010h,018h,033h,007h,033h,01eh,059h,038h,000h,000h,000h,000h	; 7e91  ......3.3.Y8....
	defb 000h,000h,000h,014h,014h,01ch,018h,008h,0f8h,03eh,0f6h,016h,00eh,000h,000h,000h	; 7ea1  .........>......

; ----------------------------------------------------------------------
; DATOS fotogramas_7EB1: juego de 5 fotogramas de coche (64 B = 2 sprites de
;   16x16, media fila = 16 B); lo usan recurso_sprite[7], recurso_sprite[8],
;   tabla_7431[6], tabla_7431[7]
;   0x7eb1..0x7ff1  (320 bytes)
DATA_fotogramas_7EB1:
	defb 006h,00bh,03fh,03dh,030h,070h,021h,013h,000h,000h,000h,001h,000h,000h,000h,000h	; 7eb1  ..?=0p!.........
	defb 000h,000h,080h,0c0h,0c0h,0e0h,0b8h,09ch,0f6h,0fbh,036h,08ch,0d8h,070h,020h,000h	; 7ec1  ..........6..p .
	defb 008h,010h,000h,042h,08fh,08dh,0deh,06ch,03fh,01fh,00fh,006h,003h,001h,001h,000h	; 7ed1  ...B...l?.......
	defb 000h,000h,000h,000h,020h,010h,040h,060h,008h,004h,0c8h,070h,020h,080h,0c0h,0c0h	; 7ee1  .... .@`...p ...
	defb 000h,00eh,00fh,02ch,038h,010h,011h,00bh,009h,000h,005h,002h,003h,001h,001h,000h	; 7ef1  ...,8...........
	defb 000h,080h,0c0h,0c0h,060h,060h,0e0h,020h,0b8h,0f8h,0ech,074h,0a6h,09ch,070h,0c0h	; 7f01  ....``. ...t..p.
	defb 003h,000h,030h,003h,047h,06eh,02eh,034h,016h,01fh,00ah,00dh,004h,006h,006h,003h	; 7f11  ..0.Gn.4........
	defb 000h,000h,000h,000h,080h,080h,010h,0d0h,040h,000h,010h,088h,058h,060h,080h,000h	; 7f21  ........@...X`..
	defb 001h,00bh,00fh,00eh,00ch,00ch,00fh,005h,005h,00fh,00fh,00bh,00bh,008h,00fh,000h	; 7f31  ................
	defb 080h,0d0h,0d0h,030h,010h,010h,0d0h,080h,080h,0d0h,0d0h,0b0h,0b0h,010h,0f0h,000h	; 7f41  ...0............
	defb 006h,000h,000h,001h,003h,002h,000h,00ah,00ah,000h,000h,004h,004h,007h,000h,000h	; 7f51  ................
	defb 070h,008h,008h,0c8h,0e8h,0e8h,028h,078h,078h,028h,028h,048h,04ch,0ech,00ch,000h	; 7f61  p.....(xx((HL...
	defb 000h,001h,003h,003h,006h,006h,007h,004h,01dh,01fh,037h,02eh,065h,039h,00eh,003h	; 7f71  ..........7.e9..
	defb 000h,070h,0f0h,034h,01ch,008h,088h,0d0h,090h,000h,0a0h,040h,0c0h,080h,080h,000h	; 7f81  .p.4.......@....
	defb 000h,000h,000h,000h,001h,001h,008h,00bh,002h,000h,008h,011h,01ah,006h,001h,000h	; 7f91  ................
	defb 0c0h,000h,00ch,0c0h,0e2h,076h,074h,02ch,068h,0f8h,050h,0b0h,020h,060h,060h,0c0h	; 7fa1  .....vt,h.P. ``.
	defb 000h,000h,001h,003h,003h,007h,01dh,039h,06fh,0dfh,06ch,031h,01bh,00eh,004h,000h	; 7fb1  .......9o.l1....
	defb 060h,0d0h,0fch,0bch,00ch,00eh,084h,0c8h,000h,000h,000h,080h,000h,000h,000h,000h	; 7fc1  `...............
	defb 000h,000h,000h,000h,004h,008h,002h,006h,010h,020h,013h,00eh,004h,001h,003h,003h	; 7fd1  ......... ......
	defb 010h,008h,000h,042h,0f1h,0b1h,07bh,036h,0fch,0f8h,0f0h,060h,0c0h,080h,080h,000h	; 7fe1  ...B..{6...`....

; ----------------------------------------------------------------------
; DATOS fotogramas_7FF1: juego de 5 fotogramas de coche (64 B = 2 sprites de
;   16x16, media fila = 16 B); lo usan recurso_sprite[9], tabla_7431[8]
;   0x7ff1..0x8000  (15 bytes)
DATA_fotogramas_7FF1:
	defb 006h,01bh,03fh,031h,020h,040h,031h,013h,009h,000h,000h,001h,000h,000h,000h	; 7ff1  ..?1 @1........
