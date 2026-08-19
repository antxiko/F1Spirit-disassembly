; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 14 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS pista_7F78: pista de la partitura (sonido 43 canal 0, sonido 44 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x8000..0x8072  (114 bytes)
DATA_pista_7F78:
	defb 0fbh,002h,0e8h,07fh,0e3h,004h,063h,040h,062h,090h,0e3h,001h,068h,000h,0e4h,018h	; 8000  ......c@b...h...
	defb 062h,0f4h,063h,071h,064h,00dh,0e4h,01fh,065h,0d9h,067h,000h,0fbh,002h,004h,080h	; 8010  b.cqd...e.g.....
	defb 0e3h,004h,043h,040h,042h,090h,0e3h,001h,048h,000h,0e4h,018h,042h,0f4h,043h,071h	; 8020  ..C@B...H...B.Cq
	defb 044h,00dh,0e4h,01fh,045h,0d9h,047h,000h,058h,000h,0e1h,005h,0e4h,01fh,005h,0e4h	; 8030  D...E.G.X.......
	defb 01dh,005h,0e4h,01eh,005h,005h,004h,004h,003h,003h,002h,002h,001h,001h,001h,000h	; 8040  ................
	defb 000h,0e1h,006h,0e4h,01fh,005h,0e4h,008h,006h,0e4h,01fh,007h,0e4h,014h,008h,0e4h	; 8050  ................
	defb 01fh,008h,0e4h,01eh,009h,0e4h,009h,005h,0e4h,018h,007h,0e4h,01fh,006h,005h,004h	; 8060  ................
	defb 003h,0ffh	; 8070

; ----------------------------------------------------------------------
; DATOS pista_8072: pista de la partitura (sonido 43 canal 3, sonido 44 canal
;   3); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x8072..0x821f  (429 bytes)
DATA_pista_8072:
	defb 0feh,002h,0f8h,028h,0f9h,07ah,080h,0ffh,0e2h,001h,0c4h,000h,0c5h,000h,000h,011h	; 8072  ...(.z..........
	defb 0c6h,000h,0c7h,000h,000h,011h,0c8h,000h,0c9h,000h,0fbh,004h,07ah,080h,0c9h,000h	; 8082  ............z...
	defb 0cfh,000h,0c4h,088h,0c5h,0bch,0c7h,042h,0c9h,02fh,0c3h,010h,0c3h,0e0h,0c4h,0e7h	; 8092  .......B./......
	defb 0c6h,035h,0c2h,0f0h,0c3h,0b7h,0c4h,0b4h,0c5h,0f4h,0c3h,020h,0c5h,001h,000h,000h	; 80a2  .5......... ....
	defb 0fbh,004h,094h,080h,0a4h,088h,0a5h,0bch,0a7h,042h,0a9h,02fh,0a3h,010h,0a3h,0e0h	; 80b2  .........B./....
	defb 0a4h,0e7h,0a6h,035h,0a2h,0f0h,0a3h,0b7h,0a4h,0b4h,0a5h,0f4h,0a3h,020h,0a5h,001h	; 80c2  ...5......... ..
	defb 000h,000h,0fbh,002h,0b6h,080h,084h,088h,085h,0bch,087h,042h,089h,02fh,083h,010h	; 80d2  ...........B./..
	defb 083h,0e0h,084h,0e7h,086h,035h,082h,0f0h,083h,0b7h,084h,0b4h,085h,0f4h,083h,020h	; 80e2  .....5......... 
	defb 085h,001h,000h,000h,0fbh,002h,0d8h,080h,064h,088h,065h,0bch,067h,042h,069h,02fh	; 80f2  ........d.e.gBi/
	defb 063h,010h,063h,0e0h,064h,0e7h,066h,035h,062h,0f0h,063h,0b7h,064h,0b4h,065h,0f4h	; 8102  c.c.d.f5b.c.d.e.
	defb 063h,020h,065h,001h,000h,000h,0fbh,002h,0fah,080h,054h,088h,055h,0bch,057h,042h	; 8112  c e.......T.U.WB
	defb 059h,02fh,053h,010h,053h,0e0h,054h,0e7h,056h,035h,052h,0f0h,053h,0b7h,054h,0b4h	; 8122  Y/S.S.T.V5R.S.T.
	defb 055h,0f4h,053h,020h,055h,001h,000h,000h,0fbh,002h,01ch,081h,044h,088h,045h,0bch	; 8132  U.S U.......D.E.
	defb 047h,042h,049h,02fh,043h,010h,043h,0e0h,044h,0e7h,046h,035h,042h,0f0h,043h,0b7h	; 8142  GBI/C.C.D.F5B.C.
	defb 044h,0b4h,045h,0f4h,043h,020h,045h,001h,000h,000h,0fbh,002h,03eh,081h,034h,088h	; 8152  D.E.C E.....>.4.
	defb 035h,0bch,037h,042h,039h,02fh,033h,010h,033h,0e0h,034h,0e7h,036h,035h,032h,0f0h	; 8162  5.7B9/3.3.4.652.
	defb 033h,0b7h,034h,0b4h,035h,0f4h,033h,020h,035h,001h,000h,000h,0fbh,002h,060h,081h	; 8172  3.4.5.3 5.....`.
	defb 002h,0e9h,013h,0ceh,025h,034h,032h,0b6h,043h,09eh,054h,0e9h,000h,000h,064h,000h	; 8182  ....%42.C.T...d.
	defb 075h,000h,086h,000h,099h,000h,09ah,000h,000h,000h,0a2h,0e9h,0a3h,0ceh,0a5h,034h	; 8192  u..............4
	defb 0a2h,0b6h,0a3h,09eh,0a4h,0e9h,000h,000h,0a4h,000h,0a5h,000h,0a6h,000h,0a9h,000h	; 81a2  ................
	defb 0aah,000h,000h,000h,072h,0e9h,073h,0ceh,075h,034h,072h,0b6h,073h,09eh,074h,0e9h	; 81b2  ....r.s.u4r.s.t.
	defb 000h,000h,074h,000h,075h,000h,076h,000h,079h,000h,07ah,000h,000h,000h,052h,0e9h	; 81c2  ..t.u.v.y.z...R.
	defb 053h,0ceh,055h,034h,052h,0b6h,053h,09eh,054h,0e9h,000h,000h,054h,000h,055h,000h	; 81d2  S.U4R.S.T...T.U.
	defb 056h,000h,059h,000h,05ah,000h,000h,000h,022h,0e9h,023h,0ceh,025h,034h,022h,0b6h	; 81e2  V.Y.Z...".#.%4".
	defb 023h,09eh,024h,0e9h,000h,000h,024h,000h,025h,000h,026h,000h,029h,000h,02ah,000h	; 81f2  #.$...$.%.&.).*.
	defb 000h,000h,002h,0e9h,003h,0ceh,005h,034h,002h,0b6h,003h,09eh,004h,0e9h,000h,000h	; 8202  .......4........
	defb 004h,000h,005h,000h,006h,000h,009h,000h,00ah,000h,000h,000h,0fah	; 8212  .............

; ----------------------------------------------------------------------
; DATOS pista_821F: pista de la partitura (sonido 43 canal 4, sonido 44 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x821f..0x822b  (12 bytes)
DATA_pista_821F:
	defb 0feh,002h,0f8h,014h,0e0h,001h,0eeh,004h,0f9h,07ah,080h,0ffh	; 821f  .........z..

; ----------------------------------------------------------------------
; DATOS pista_822B: pista de la partitura (sonido 45 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x822b..0x822c  (1 bytes)
DATA_pista_822B:
	defb 0ffh	; 822b

; ----------------------------------------------------------------------
; DATOS pista_822C: pista de la partitura (sonido 45 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x822c..0x822d  (1 bytes)
DATA_pista_822C:
	defb 0ffh	; 822c

; ----------------------------------------------------------------------
; DATOS pista_822D: pista de la partitura (sonido 45 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x822d..0x8235  (8 bytes)
DATA_pista_822D:
	defb 0feh,001h,0eah,00ah,0f9h,04bh,082h,0ffh	; 822d  .....K..

; ----------------------------------------------------------------------
; DATOS pista_8235: pista de la partitura (sonido 45 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8235..0x8241  (12 bytes)
DATA_pista_8235:
	defb 0feh,001h,0f8h,015h,0eeh,002h,0eah,00fh,0f9h,04bh,082h,0ffh	; 8235  .........K..

; ----------------------------------------------------------------------
; DATOS pista_8241: pista de la partitura (sonido 45 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8241..0x825b  (26 bytes)
DATA_pista_8241:
	defb 0feh,001h,0f8h,015h,0eah,00fh,0f9h,04bh,082h,0ffh,0e9h,001h,0d1h,0ebh,001h,088h	; 8241  .......K........
	defb 004h,074h,044h,074h,0ebh,001h,023h,0d0h,009h,0fah	; 8251  .tDt..#...

; ----------------------------------------------------------------------
; DATOS pista_825B: pista de la partitura (sonido 45 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x825b..0x825c  (1 bytes)
DATA_pista_825B:
	defb 0ffh	; 825b

; ----------------------------------------------------------------------
; DATOS pista_825C: pista de la partitura (sonido 45 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x825c..0x825d  (1 bytes)
DATA_pista_825C:
	defb 0ffh	; 825c

; ----------------------------------------------------------------------
; DATOS pista_825D: pista de la partitura (sonido 45 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x825d..0x8263  (6 bytes)
DATA_pista_825D:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 825d

; ----------------------------------------------------------------------
; DATOS pista_8263: pista de la partitura (sonido 51 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8263..0x8294  (49 bytes)
DATA_pista_8263:
	defb 0feh,004h,0e9h,006h,0c0h,011h,081h,080h,041h,010h,081h,080h,041h,080h,081h,080h	; 8263  ........A...A...
	defb 041h,010h,080h,080h,080h,041h,010h,0fbh,003h,069h,082h,081h,080h,041h,010h,081h	; 8273  A....A...i...A..
	defb 080h,041h,080h,0e9h,003h,043h,040h,040h,041h,041h,041h,081h,041h,041h,041h,011h	; 8283  .A...C@@AAA.AAA.
	defb 0ffh	; 8293

; ----------------------------------------------------------------------
; DATOS pista_8294: pista de la partitura (sonido 51 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8294..0x82ab  (23 bytes)
DATA_pista_8294:
	defb 0feh,001h,0e9h,006h,0c1h,0eeh,001h,0e9h,00ch,0eah,00bh,0ebh,007h,055h,0d1h,07bh	; 8294  .............U.{
	defb 0abh,0d0h,00bh,0e9h,00dh,00ah,0ffh	; 82a4

; ----------------------------------------------------------------------
; DATOS pista_82AB: pista de la partitura (sonido 51 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x82ab..0x8314  (105 bytes)
DATA_pista_82AB:
	defb 0feh,001h,0e9h,006h,0eah,00bh,0ebh,007h,033h,0f1h,052h,0f2h,00fh,0c2h,0d2h,070h	; 82ab  ........3.R....p
	defb 0d1h,000h,070h,0e9h,009h,04dh,0e9h,006h,040h,050h,070h,0e9h,009h,03bh,0e9h,006h	; 82bb  ..p..M..@Pp..;..
	defb 031h,0d2h,0a0h,0d1h,031h,0e9h,009h,00dh,0e9h,002h,0eah,009h,0ech,000h,010h,020h	; 82cb  1...1.......... 
	defb 030h,040h,050h,060h,070h,080h,090h,0a0h,0b0h,0d0h,000h,0e9h,009h,0eah,00ch,0ebh	; 82db  0@P`p...........
	defb 007h,033h,0f1h,051h,0f2h,00ah,009h,0e9h,006h,0ebh,009h,035h,0d2h,030h,050h,070h	; 82eb  .3.Q.......5.0Pp
	defb 0ech,0f3h,0f1h,034h,0d1h,000h,0e9h,001h,0eah,00ah,0b0h,0a0h,090h,0eah,008h,070h	; 82fb  ...4...........p
	defb 050h,0eah,006h,040h,020h,0eah,005h,000h,0ffh	; 830b  P..@ ....

; ----------------------------------------------------------------------
; DATOS pista_8314: pista de la partitura (sonido 51 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8314..0x8342  (46 bytes)
DATA_pista_8314:
	defb 0feh,001h,0f8h,026h,0e9h,006h,0eah,00fh,0ebh,009h,035h,0d5h,0c1h,002h,000h,0d4h	; 8314  ...&......5.....
	defb 002h,0d5h,0a2h,071h,0a0h,001h,000h,0d4h,002h,0d5h,0a2h,071h,0a0h,0fbh,006h,029h	; 8324  ...q.......q...)
	defb 083h,001h,000h,0d4h,002h,0d5h,030h,050h,070h,0e9h,008h,0d4h,001h,0ffh	; 8334  ......0Pp.....

; ----------------------------------------------------------------------
; DATOS pista_8342: pista de la partitura (sonido 51 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8342..0x8371  (47 bytes)
DATA_pista_8342:
	defb 0feh,001h,0f8h,022h,0e9h,006h,0eah,00fh,0ebh,009h,035h,0d4h,0c1h,002h,000h,0d3h	; 8342  ..."......5.....
	defb 002h,0d4h,0d4h,0a2h,071h,0a0h,001h,000h,0d3h,002h,0d4h,0a2h,071h,0a0h,0fbh,006h	; 8352  ....q.......q...
	defb 058h,083h,001h,000h,0d3h,002h,0d4h,030h,050h,070h,0e9h,008h,0d3h,001h,0ffh	; 8362  X......0Pp.....

; ----------------------------------------------------------------------
; DATOS pista_8371: pista de la partitura (sonido 51 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8371..0x8385  (20 bytes)
DATA_pista_8371:
	defb 0feh,001h,0f8h,00ah,0e9h,006h,0c1h,0e9h,00ch,0eah,00ch,0ebh,007h,095h,0d1h,00bh	; 8371  ................
	defb 03bh,05bh,04ah,0ffh	; 8381

; ----------------------------------------------------------------------
; DATOS pista_8385: pista de la partitura (sonido 51 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8385..0x83f0  (107 bytes)
DATA_pista_8385:
	defb 0feh,001h,0f8h,002h,0e9h,006h,0eah,00ch,0ebh,007h,033h,0f1h,052h,0f2h,00fh,0d2h	; 8385  ..........3.R...
	defb 070h,0d1h,000h,070h,0e9h,009h,04dh,0e9h,006h,040h,050h,070h,0e9h,009h,03bh,0e9h	; 8395  p..p..M..@Pp..;.
	defb 006h,031h,0d2h,0a0h,0d1h,031h,0e9h,009h,00dh,0e9h,002h,0ech,000h,010h,020h,030h	; 83a5  .1...1........ 0
	defb 040h,050h,060h,070h,080h,090h,0a0h,0b0h,0d0h,000h,0e9h,009h,0ebh,007h,033h,0f1h	; 83b5  @P`p..........3.
	defb 051h,0f2h,00ah,00bh,0e9h,006h,0ebh,009h,035h,0d1h,0eah,00dh,030h,050h,0eah,00eh	; 83c5  Q.......5...0P..
	defb 070h,0ech,0f3h,0f1h,034h,0d0h,000h,0e9h,001h,0eah,00bh,0d1h,0b0h,0a0h,090h,0eah	; 83d5  p...4...........
	defb 008h,070h,050h,0eah,006h,040h,020h,0eah,005h,000h,0ffh	; 83e5  .pP..@ ....

; ----------------------------------------------------------------------
; DATOS pista_83F0: pista de la partitura (sonido 51 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x83f0..0x8459  (105 bytes)
DATA_pista_83F0:
	defb 0feh,001h,0eeh,001h,0e9h,006h,0eah,00ah,0ebh,007h,033h,0f1h,052h,0f2h,00fh,0d2h	; 83f0  ..........3.R...
	defb 070h,0d1h,000h,070h,0e9h,009h,04dh,0e9h,006h,040h,050h,070h,0e9h,009h,03bh,0e9h	; 8400  p..p..M..@Pp..;.
	defb 006h,031h,0d2h,0a0h,0d1h,031h,0e9h,009h,00dh,0e9h,002h,0ech,000h,010h,020h,030h	; 8410  .1...1........ 0
	defb 040h,050h,060h,070h,080h,090h,0a0h,0b0h,0d0h,000h,0e9h,009h,0ebh,007h,033h,0f1h	; 8420  @P`p..........3.
	defb 051h,0f2h,00ah,00bh,0e9h,006h,0eah,00bh,0ebh,009h,035h,030h,050h,0eah,00ch,070h	; 8430  Q.........50P..p
	defb 0ech,0f3h,0f1h,034h,0d0h,000h,0e9h,001h,0eah,007h,0b0h,0a0h,090h,0eah,005h,070h	; 8440  ...4...........p
	defb 050h,0eah,004h,040h,020h,0eah,002h,000h,0ffh	; 8450  P..@ ....

; ----------------------------------------------------------------------
; DATOS pista_8459: pista de la partitura (sonido 52 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8459..0x84b9  (96 bytes)
DATA_pista_8459:
	defb 0feh,001h,0e9h,003h,0eah,009h,0d0h,0ebh,001h,031h,001h,001h,0eah,005h,0ebh,000h	; 8459  .........1......
	defb 000h,001h,0eah,009h,0ebh,001h,031h,051h,051h,0eah,005h,0ebh,000h,000h,051h,0eah	; 8469  ......1QQ.....Q.
	defb 009h,0ebh,001h,031h,0a1h,051h,001h,001h,0eah,005h,0ebh,000h,000h,001h,0eah,009h	; 8479  ...1.Q..........
	defb 0ebh,001h,031h,051h,051h,0eah,005h,0ebh,000h,000h,051h,0eah,009h,0ebh,001h,031h	; 8489  ..1QQ.....Q....1
	defb 0a1h,051h,001h,001h,0eah,005h,0ebh,000h,000h,001h,0eah,009h,0ebh,001h,031h,051h	; 8499  .Q............1Q
	defb 051h,0eah,005h,0ebh,000h,000h,051h,0eah,008h,0ebh,021h,031h,0e9h,006h,08bh,0ffh	; 84a9  Q.....Q...!1....

; ----------------------------------------------------------------------
; DATOS pista_84B9: pista de la partitura (sonido 52 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x84b9..0x851d  (100 bytes)
DATA_pista_84B9:
	defb 0feh,001h,0e9h,003h,0eah,007h,0d0h,0ebh,001h,031h,0eeh,001h,0c0h,001h,001h,0eah	; 84b9  .........1......
	defb 004h,0ebh,000h,000h,001h,0eah,007h,0ebh,001h,031h,051h,051h,0eah,004h,0ebh,000h	; 84c9  .........1QQ....
	defb 000h,051h,0eah,007h,0ebh,001h,031h,0a1h,051h,001h,001h,0eah,004h,0ebh,000h,000h	; 84d9  .Q....1.Q.......
	defb 001h,0eah,007h,0ebh,001h,031h,051h,051h,0eah,004h,0ebh,000h,000h,051h,0eah,007h	; 84e9  .....1QQ.....Q..
	defb 0ebh,001h,031h,0a1h,051h,001h,001h,0eah,004h,0ebh,000h,000h,001h,0eah,007h,0ebh	; 84f9  ..1.Q...........
	defb 001h,031h,051h,051h,0eah,004h,0ebh,000h,000h,050h,0eah,008h,0ebh,021h,031h,0efh	; 8509  .1QQ.....P...!1.
	defb 0e9h,006h,03bh,0ffh	; 8519

; ----------------------------------------------------------------------
; DATOS pista_851D: pista de la partitura (sonido 52 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x851d..0x8529  (12 bytes)
DATA_pista_851D:
	defb 0feh,001h,0e9h,00dh,0eah,00fh,0d4h,0ebh,001h,031h,00eh,0ffh	; 851d  .........1..

; ----------------------------------------------------------------------
; DATOS pista_8529: pista de la partitura (sonido 52 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8529..0x8554  (43 bytes)
DATA_pista_8529:
	defb 0feh,001h,0f8h,00ah,0e9h,003h,0eah,00fh,0d2h,0ebh,001h,041h,0f2h,00ah,0f1h,051h	; 8529  ...........A...Q
	defb 0f9h,03eh,085h,08bh,0ffh,005h,055h,0afh,0eah,008h,0ebh,000h,000h,0a3h,0f8h,015h	; 8539  .>....U.........
	defb 0eah,00fh,0ebh,001h,041h,0a5h,0d1h,035h,0e9h,006h,0fah	; 8549  ....A..5...

; ----------------------------------------------------------------------
; DATOS pista_8554: pista de la partitura (sonido 52 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8554..0x857a  (38 bytes)
DATA_pista_8554:
	defb 0feh,001h,0f8h,00ah,0e9h,003h,0eah,00eh,0d2h,0ebh,001h,041h,0f2h,00ah,0f1h,051h	; 8554  ...........A...Q
	defb 0eeh,001h,00bh,05fh,0eah,007h,0ebh,000h,000h,053h,0eah,00eh,0ebh,001h,041h,055h	; 8564  ..._.....S....AU
	defb 0a5h,0d1h,0e9h,006h,03bh,0ffh	; 8574

; ----------------------------------------------------------------------
; DATOS pista_857A: pista de la partitura (sonido 52 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x857a..0x8592  (24 bytes)
DATA_pista_857A:
	defb 0feh,001h,0f8h,00ah,0eeh,001h,0e9h,003h,0eah,00ah,0d2h,0ebh,001h,041h,0f2h,00ah	; 857a  .............A..
	defb 0f1h,051h,0c0h,0f9h,03eh,085h,08ah,0ffh	; 858a  .Q..>...

; ----------------------------------------------------------------------
; DATOS pista_8592: pista de la partitura (sonido 52 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x8592..0x85ad  (27 bytes)
DATA_pista_8592:
	defb 0feh,001h,0f8h,01dh,0e9h,003h,0eah,00ah,0d2h,0ebh,001h,041h,0f2h,00ah,0f1h,051h	; 8592  ...........A...Q
	defb 00bh,001h,001h,00fh,055h,0a5h,0d1h,0e9h,006h,03bh,0ffh	; 85a2  ....U....;.

; ----------------------------------------------------------------------
; DATOS pista_85AD: pista de la partitura (sonido 52 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x85ad..0x85c7  (26 bytes)
DATA_pista_85AD:
	defb 0feh,001h,0f8h,01dh,0e9h,003h,0eah,00ah,0d2h,0ebh,001h,041h,0f2h,00ah,0f1h,051h	; 85ad  ...........A...Q
	defb 05bh,051h,051h,05fh,005h,055h,0e9h,006h,0abh,0ffh	; 85bd  [QQ_.U....

; ----------------------------------------------------------------------
; DATOS pista_85C7: pista de la partitura (sonido 53 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x85c7..0x85fe  (55 bytes)
DATA_pista_85C7:
	defb 0feh,004h,0e9h,003h,0f9h,0efh,085h,001h,011h,0f9h,0efh,085h,041h,041h,0f9h,0efh	; 85c7  ............AA..
	defb 085h,001h,011h,081h,001h,081h,081h,041h,001h,001h,081h,080h,040h,040h,040h,041h	; 85d7  .......A....@@@A
	defb 041h,031h,031h,081h,011h,0fdh,0c7h,085h,081h,001h,081h,081h,041h,001h,001h,081h	; 85e7  A11.........A...
	defb 001h,081h,081h,001h,041h,001h,0fah	; 85f7

; ----------------------------------------------------------------------
; DATOS pista_85FE: pista de la partitura (sonido 53 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x85fe..0x866c  (110 bytes)
DATA_pista_85FE:
	defb 0feh,001h,0e9h,006h,0eah,00bh,0ebh,04ah,015h,0d4h,050h,0eah,00dh,050h,051h,0d3h	; 85fe  .......J..P..PQ.
	defb 030h,050h,0d4h,030h,050h,0c0h,050h,051h,0d3h,030h,050h,0d4h,0a0h,0d3h,000h,0d4h	; 860e  0P.0P.PQ.0P.....
	defb 050h,0eah,00bh,050h,0eah,00dh,050h,050h,0d3h,030h,050h,0d4h,030h,050h,0c0h,050h	; 861e  P..P..PP.0P.0P.P
	defb 051h,0e9h,004h,0d3h,050h,040h,030h,0e9h,006h,000h,0d4h,0a0h,050h,050h,051h,0d3h	; 862e  Q...P@0.....PPQ.
	defb 030h,050h,0d4h,030h,050h,0c0h,050h,051h,0d3h,030h,050h,0d4h,0a0h,0d3h,000h,0d4h	; 863e  0P.0P.PQ.0P.....
	defb 050h,0eah,00bh,050h,0eah,00dh,050h,050h,0d3h,030h,050h,0d4h,0a0h,0d3h,000h,080h	; 864e  P..P..PP.0P.....
	defb 0d4h,050h,050h,0d3h,070h,0d4h,050h,050h,0d3h,030h,050h,0fdh,0feh,085h	; 865e  .PP.p.PP.0P...

; ----------------------------------------------------------------------
; DATOS pista_866C: pista de la partitura (sonido 53 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x866c..0x86fc  (144 bytes)
DATA_pista_866C:
	defb 0feh,001h,0e9h,006h,0ebh,00ah,023h,0eah,00dh,0f8h,014h,0d5h,050h,0eah,00fh,050h	; 866c  ......#.....P..P
	defb 051h,0f8h,026h,0d4h,030h,050h,0f8h,014h,0d5h,030h,050h,0c0h,050h,051h,0f8h,026h	; 867c  Q.&.0P...0P.PQ.&
	defb 0d4h,030h,050h,0f8h,014h,0d5h,0a0h,0d4h,000h,0d5h,050h,0eah,00dh,050h,0eah,00fh	; 868c  .0P.......P..P..
	defb 050h,050h,0f8h,026h,0d4h,030h,050h,0f8h,014h,0d5h,030h,050h,0c0h,050h,051h,0e9h	; 869c  PP.&.0P...0P.PQ.
	defb 004h,0f8h,026h,0ebh,00ch,032h,0d4h,050h,040h,030h,0e9h,006h,000h,0d5h,0a0h,050h	; 86ac  ..&..2.P@0.....P
	defb 0f8h,014h,0ebh,00ah,023h,050h,051h,0f8h,026h,0d4h,030h,050h,0f8h,014h,0d5h,030h	; 86bc  ....#PQ.&.0P...0
	defb 050h,0c0h,050h,051h,0f8h,026h,0d4h,030h,050h,0d5h,0a0h,0d4h,000h,0f8h,014h,0d5h	; 86cc  P.PQ.&.0P.......
	defb 050h,0eah,00dh,050h,0eah,00fh,050h,050h,0f8h,026h,0d4h,030h,050h,0d5h,0a0h,0d4h	; 86dc  P..P..PP.&.0P...
	defb 000h,080h,0d5h,050h,050h,0d4h,070h,0d5h,050h,050h,0d4h,030h,050h,0fdh,06ch,086h	; 86ec  ...PP.p.PP.0P.l.

; ----------------------------------------------------------------------
; DATOS pista_86FC: pista de la partitura (sonido 53 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x86fc..0x875f  (99 bytes)
DATA_pista_86FC:
	defb 0feh,001h,0f8h,024h,0e9h,006h,0eah,007h,0ebh,01fh,0edh,0d0h,0c0h,050h,0c0h,050h	; 86fc  ...$.........P.P
	defb 050h,0c0h,0d1h,050h,0c0h,050h,0c0h,0d0h,050h,050h,0c0h,0d1h,050h,0c0h,050h,0fbh	; 870c  P..P.P..PP..P.P.
	defb 004h,008h,087h,0f8h,015h,0eah,00fh,0ebh,023h,035h,0d2h,0f9h,02eh,087h,034h,0fdh	; 871c  ........#5....4.
	defb 0fch,086h,079h,0a0h,090h,0a0h,0d1h,000h,0d2h,050h,030h,090h,050h,040h,038h,0c0h	; 872c  ..y......P0.P@8.
	defb 0d1h,030h,0c0h,054h,0c0h,040h,030h,0d2h,0b0h,0d1h,020h,030h,0d2h,0b0h,0d1h,020h	; 873c  .0.T.@0... 0... 
	defb 000h,0d2h,070h,0b0h,070h,0a0h,060h,070h,090h,0a0h,0b0h,0d1h,000h,050h,0d2h,0a0h	; 874c  ..p.p.`p.....P..
	defb 090h,050h,0fah	; 875c

; ----------------------------------------------------------------------
; DATOS pista_875F: pista de la partitura (sonido 53 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x875f..0x87a0  (65 bytes)
DATA_pista_875F:
	defb 0feh,001h,0f8h,021h,0e9h,006h,0eah,006h,0ebh,031h,012h,0d2h,0c0h,032h,031h,031h	; 875f  ...!.....1...211
	defb 031h,030h,031h,031h,030h,0c0h,032h,031h,031h,031h,030h,031h,031h,000h,0c0h,032h	; 876f  10110.2111011..2
	defb 031h,031h,031h,030h,031h,031h,030h,0c0h,032h,031h,031h,030h,031h,031h,032h,0f8h	; 877f  1110110.2110112.
	defb 015h,0eah,008h,0ebh,011h,010h,0d2h,0eeh,002h,071h,0f9h,02eh,087h,032h,0fdh,05fh	; 878f  .........q...2._
	defb 087h	; 879f

; ----------------------------------------------------------------------
; DATOS pista_87A0: pista de la partitura (sonido 53 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x87a0..0x87d5  (53 bytes)
DATA_pista_87A0:
	defb 0feh,001h,0e9h,006h,0eah,007h,0ebh,031h,012h,0d2h,0c0h,0a2h,0a1h,091h,0a1h,090h	; 87a0  .......1........
	defb 0a1h,0d1h,001h,0d2h,0a0h,0c0h,0a2h,0a1h,091h,0a1h,090h,0a1h,091h,070h,0c0h,0a2h	; 87b0  .............p..
	defb 0a1h,091h,0a1h,090h,0a1h,0d1h,001h,0d2h,0a0h,0c0h,0a2h,0a1h,091h,0a0h,0a1h,0a1h	; 87c0  ................
	defb 0d1h,002h,0fdh,0a0h,087h	; 87d0

; ----------------------------------------------------------------------
; DATOS pista_87D5: pista de la partitura (sonido 54 canal 0, sonido 57 canal
;   0); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x87d5..0x8891  (188 bytes)
DATA_pista_87D5:
	defb 0feh,004h,0e9h,004h,000h,030h,040h,040h,081h,081h,041h,081h,041h,041h,041h,081h	; 87d5  .....0@@..A.AAA.
	defb 0fbh,005h,0e3h,087h,001h,081h,041h,041h,041h,041h,0fch,004h,0e3h,087h,081h,001h	; 87e5  ......AAAA......
	defb 041h,001h,081h,081h,041h,001h,0fbh,007h,0f3h,087h,081h,001h,041h,001h,031h,031h	; 87f5  A...A.......A.11
	defb 041h,041h,0fch,002h,0f3h,087h,041h,001h,001h,041h,081h,081h,041h,081h,0fbh,003h	; 8805  AA....A..A..A...
	defb 00bh,088h,041h,001h,001h,041h,040h,0fch,008h,01bh,088h,081h,081h,041h,081h,001h	; 8815  ..A..A@......A..
	defb 081h,041h,001h,0fbh,003h,020h,088h,081h,081h,041h,081h,041h,041h,041h,041h,081h	; 8825  .A... ...A.AAAA.
	defb 081h,041h,081h,001h,081h,041h,001h,0fbh,002h,034h,088h,041h,0fbh,010h,040h,088h	; 8835  .A...A...4.A..@.
	defb 081h,081h,041h,081h,001h,081h,041h,001h,0fbh,003h,045h,088h,081h,081h,041h,081h	; 8845  ..A...A...E...A.
	defb 041h,041h,041h,041h,081h,081h,041h,081h,001h,081h,041h,001h,0fbh,002h,059h,088h	; 8855  AAAA..A...A...Y.
	defb 081h,081h,041h,081h,001h,081h,041h,001h,081h,081h,041h,081h,040h,0fbh,008h,071h	; 8865  ..A...A...A.@..q
	defb 088h,081h,081h,041h,081h,001h,081h,041h,001h,0fbh,003h,076h,088h,040h,040h,040h	; 8875  ...A...A...v.@@@
	defb 040h,030h,030h,040h,040h,041h,081h,041h,041h,0fdh,0e3h,087h	; 8885  @00@@A.AA...

; ----------------------------------------------------------------------
; DATOS pista_8891: pista de la partitura (sonido 54 canal 1, sonido 57 canal
;   1); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x8891..0x894c  (187 bytes)
DATA_pista_8891:
	defb 0feh,001h,0e9h,004h,0cfh,0eah,00bh,0e9h,004h,0ebh,001h,031h,0d2h,025h,0e9h,008h	; 8891  ...........1.%..
	defb 04ch,0e9h,004h,025h,045h,0e9h,008h,079h,0e9h,004h,025h,0e9h,008h,04ch,0e9h,004h	; 88a1  L..%E..y..%..L..
	defb 025h,045h,077h,02bh,0eeh,002h,0e9h,004h,0eah,00ah,0ebh,001h,010h,0d2h,0c3h,0e9h	; 88b1  %Ew+............
	defb 004h,0f9h,0f9h,08ah,07bh,0d2h,0eah,00bh,003h,013h,025h,0eah,00ah,0f9h,005h,08bh	; 88c1  ....{.....%.....
	defb 07bh,0eah,00bh,033h,023h,015h,0eah,00ah,0e9h,004h,0f9h,0f9h,08ah,07bh,0d2h,0eah	; 88d1  {..3#........{..
	defb 00bh,003h,013h,025h,0eah,00ah,0f9h,005h,08bh,07bh,0eah,00bh,033h,023h,011h,0eeh	; 88e1  ...%.....{..3#..
	defb 003h,0e9h,004h,0eah,00bh,0d2h,0c1h,071h,0eah,00ah,071h,0eah,005h,070h,0eah,004h	; 88f1  .......q..q..p..
	defb 070h,0fbh,004h,0f9h,088h,0eah,00bh,091h,09bh,091h,0eah,00ah,091h,0eah,005h,090h	; 8901  p...............
	defb 0eah,004h,090h,0fbh,004h,00bh,089h,0eah,00bh,0b1h,0b9h,0eeh,002h,0e9h,004h,0eah	; 8911  ................
	defb 009h,0ebh,001h,010h,0d1h,0c3h,0f9h,013h,08bh,0eeh,003h,0e9h,004h,0eah,009h,0ebh	; 8921  ................
	defb 001h,010h,0f9h,032h,08bh,001h,0efh,0ebh,011h,015h,0eah,00ah,0d2h,0bfh,08fh,0e9h	; 8931  ...2............
	defb 008h,0d1h,04bh,0ebh,001h,031h,0d3h,0b3h,0fdh,096h,088h	; 8941  ..K..1.....

; ----------------------------------------------------------------------
; DATOS pista_894C: pista de la partitura (sonido 54 canal 5, sonido 57 canal
;   5); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x894c..0x8a50  (260 bytes)
DATA_pista_894C:
	defb 0feh,004h,0f8h,005h,0e9h,004h,0c1h,025h,063h,073h,0feh,001h,0eah,00fh,0d5h,0f8h	; 894c  .......%cs......
	defb 028h,0ebh,063h,024h,0a5h,0e9h,008h,0d4h,00ch,0e9h,004h,0d5h,0a5h,0d4h,005h,03bh	; 895c  (.c$...........;
	defb 0ebh,05bh,055h,0d5h,071h,071h,081h,091h,0fbh,002h,058h,089h,0f8h,014h,0eah,00fh	; 896c  .[U.qq....X.....
	defb 0ebh,04fh,0f5h,0d4h,001h,001h,001h,0ebh,038h,015h,003h,0ebh,04fh,0f5h,001h,001h	; 897c  .O......8...O...
	defb 001h,001h,0fbh,008h,08dh,089h,001h,001h,001h,0ebh,038h,015h,003h,0ebh,04fh,0f5h	; 898c  ..........8...O.
	defb 001h,001h,001h,001h,001h,001h,001h,0d5h,0a1h,0a1h,0b1h,0b1h,0d4h,031h,031h,031h	; 899c  .............111
	defb 0ebh,038h,015h,033h,0ebh,04fh,0f5h,031h,031h,031h,031h,0fbh,008h,0b6h,089h,031h	; 89ac  .8.3.O.1111....1
	defb 031h,031h,0ebh,038h,015h,033h,0ebh,04fh,0f5h,031h,031h,031h,031h,031h,031h,031h	; 89bc  11.8.3.O.1111111
	defb 021h,021h,011h,011h,0fch,002h,078h,089h,0f8h,028h,0eah,00eh,0ebh,05fh,0f5h,0d5h	; 89cc  !!....x..(..._..
	defb 051h,051h,0c1h,051h,0c1h,051h,0c1h,051h,0c1h,0d4h,051h,0d5h,051h,051h,051h,0d4h	; 89dc  QQ.Q.Q.Q..Q.QQQ.
	defb 051h,0d5h,051h,061h,071h,071h,071h,0d4h,071h,0d5h,0c1h,071h,0c1h,071h,0c1h,071h	; 89ec  Q.Qaqqq.q..q.q.q
	defb 0d4h,0ebh,048h,015h,073h,0ebh,04fh,0f5h,051h,071h,001h,021h,0f8h,014h,0eah,00fh	; 89fc  ..H.s.O.Qq.!....
	defb 0f9h,02eh,08ah,021h,0fbh,008h,00fh,08ah,041h,0fbh,008h,014h,08ah,0f9h,02eh,08ah	; 8a0c  ...!....A.......
	defb 021h,0fbh,010h,01ch,08ah,041h,0fbh,01ch,021h,08ah,0ebh,048h,015h,0d5h,077h,0fdh	; 8a1c  !....A..!..H..w.
	defb 058h,089h,0ebh,05fh,0f5h,0d5h,091h,091h,0d4h,001h,0d5h,091h,0d4h,041h,0d5h,091h	; 8a2c  X.._.........A..
	defb 0d4h,001h,041h,0fbh,002h,031h,08ah,0d5h,0b1h,0fbh,010h,044h,08ah,0d4h,001h,0fbh	; 8a3c  ..A..1.....D....
	defb 010h,04ah,08ah,0fah	; 8a4c

; ----------------------------------------------------------------------
; DATOS pista_8A50: pista de la partitura (sonido 54 canal 6, sonido 57 canal
;   6); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x8a50..0x8b51  (257 bytes)
DATA_pista_8A50:
	defb 0feh,001h,0e9h,004h,0cfh,0f8h,01eh,0e9h,004h,0f2h,00ah,0f1h,051h,0eah,00eh,0ebh	; 8a50  ............Q...
	defb 051h,041h,0d2h,0a5h,0e9h,008h,0d1h,00ch,0e9h,004h,0d2h,0a5h,0d1h,005h,0e9h,008h	; 8a60  QA..............
	defb 039h,0e9h,004h,0d2h,0a5h,0e9h,008h,0d1h,00ch,0e9h,004h,0d2h,0a5h,0d1h,005h,037h	; 8a70  9..............7
	defb 0d2h,0abh,0f8h,013h,0e9h,004h,0eah,00dh,0ebh,021h,015h,0f2h,00ah,0f1h,041h,0d2h	; 8a80  .........!....A.
	defb 0f9h,0f9h,08ah,0e9h,008h,07ch,0f9h,005h,08bh,0e9h,008h,07ch,0fch,002h,082h,08ah	; 8a90  .....|.....|....
	defb 0f0h,0f8h,015h,0e9h,004h,0ebh,05fh,0f5h,0d2h,071h,0eah,00fh,071h,0eah,006h,070h	; 8aa0  ......_..q..q..p
	defb 0eah,005h,070h,0fbh,004h,0aah,08ah,0eah,00fh,091h,0ebh,043h,025h,09bh,0ebh,05fh	; 8ab0  ..p........C%.._
	defb 0f5h,091h,0eah,00fh,091h,0eah,006h,090h,0eah,005h,090h,0fbh,004h,0c2h,08ah,0eah	; 8ac0  ................
	defb 00fh,0b1h,0ebh,043h,025h,0bbh,0f8h,016h,0ebh,031h,015h,0f2h,00ah,0f1h,041h,0d1h	; 8ad0  ...C%....1....A.
	defb 0f9h,013h,08bh,0f9h,032h,08bh,021h,061h,091h,08fh,04fh,0e9h,008h,0bbh,0f8h,016h	; 8ae0  ....2.!a..O.....
	defb 0eah,00eh,0d2h,073h,0f0h,0fdh,055h,08ah,0ffh,041h,051h,071h,0d1h,005h,0d2h,0a5h	; 8af0  ...s..U..AQq....
	defb 095h,073h,053h,095h,0fah,0e9h,004h,031h,051h,071h,0d1h,005h,0d2h,0a5h,095h,073h	; 8b00  .sS....1Qq.....s
	defb 053h,095h,0fah,00fh,003h,0d2h,091h,0d1h,003h,045h,027h,0d2h,0b7h,077h,071h,091h	; 8b10  S........E'..wq.
	defb 0b1h,0d1h,021h,00fh,003h,0d2h,071h,0d1h,003h,045h,027h,0d2h,097h,0d1h,047h,0d2h	; 8b20  ..!...q..E'...G.
	defb 0b7h,0fah,0d1h,00fh,003h,0d2h,091h,0d1h,003h,045h,027h,0d2h,0b7h,077h,071h,091h	; 8b30  .........E'..wq.
	defb 0b1h,0d1h,021h,00fh,003h,0d2h,071h,0d1h,003h,045h,067h,027h,0d2h,097h,091h,0d1h	; 8b40  ..!...q..Eg'....
	defb 0fah	; 8b50

; ----------------------------------------------------------------------
; DATOS pista_8B51: pista de la partitura (sonido 54 canal 7, sonido 57 canal
;   7); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x8b51..0x8c3a  (233 bytes)
DATA_pista_8B51:
	defb 0feh,001h,0e9h,004h,0cfh,0e9h,004h,0f2h,00ah,0f1h,051h,0eah,00eh,0ebh,051h,041h	; 8b51  ..........Q...QA
	defb 0d2h,055h,0e9h,008h,07ch,0e9h,004h,055h,075h,0e9h,008h,0a9h,0e9h,004h,055h,0e9h	; 8b61  .U..|..Uu.....U.
	defb 008h,07ch,0e9h,004h,055h,075h,0a7h,05bh,0eeh,001h,0e9h,008h,0eah,008h,0ebh,001h	; 8b71  .|..Uu.[........
	defb 035h,0d2h,07eh,0e9h,004h,091h,0e9h,008h,049h,0e9h,004h,0eah,00ah,003h,013h,023h	; 8b81  5.~.....I......#
	defb 0eah,008h,0e9h,008h,0aeh,0e9h,004h,0d1h,001h,0e9h,008h,0d2h,039h,0e9h,004h,0eah	; 8b91  ............9...
	defb 00ah,033h,023h,013h,0fbh,002h,079h,08bh,0e9h,004h,0eah,00fh,0ebh,05fh,0f5h,0d2h	; 8ba1  .3#...y......_..
	defb 031h,0eah,00fh,031h,0eah,006h,030h,0eah,005h,030h,0fbh,004h,0b2h,08bh,0eah,00fh	; 8bb1  1..1..0..0......
	defb 051h,0ebh,043h,025h,05bh,0ebh,05fh,0f5h,051h,0eah,00fh,051h,0eah,006h,050h,0eah	; 8bc1  Q.C%[._.Q..Q..P.
	defb 005h,050h,0fbh,004h,0cah,08bh,0eah,00fh,071h,0ebh,043h,025h,07bh,0f8h,016h,0e9h	; 8bd1  .P......q.C%{...
	defb 004h,0eah,00eh,0ebh,031h,015h,0f2h,00ah,0f1h,041h,0d2h,09fh,093h,041h,093h,0d1h	; 8be1  ....1....A...A..
	defb 005h,0d2h,0b7h,077h,027h,041h,051h,071h,0b1h,07fh,073h,041h,073h,0d1h,005h,0d2h	; 8bf1  ...w'AQq..sAs...
	defb 097h,067h,0b7h,087h,0e9h,004h,0eah,00eh,0ebh,031h,015h,0d2h,09fh,093h,041h,093h	; 8c01  .g.......1....A.
	defb 0d1h,005h,0d2h,0b7h,077h,027h,041h,051h,071h,0b1h,07fh,073h,041h,073h,0d1h,005h	; 8c11  ....w'AQq..sAs..
	defb 027h,0d2h,097h,067h,061h,091h,0d1h,021h,041h,04fh,0d2h,0bfh,0e9h,008h,0d1h,08bh	; 8c21  '..ga..!AO......
	defb 0f8h,016h,0eah,00dh,0d2h,023h,0fdh,056h,08bh	; 8c31  .....#.V.

; ----------------------------------------------------------------------
; DATOS pista_8C3A: pista de la partitura (sonido 55 canal 0, sonido 58 canal
;   0); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x8c3a..0x8cb1  (119 bytes)
DATA_pista_8C3A:
	defb 0feh,004h,0e9h,003h,0f9h,084h,08ch,040h,040h,041h,041h,041h,041h,011h,081h,041h	; 8c3a  .......@@AAAA..A
	defb 0fch,002h,03eh,08ch,0f9h,084h,08ch,081h,041h,041h,081h,041h,011h,081h,041h,0fch	; 8c4a  ..>.....AA.A..A.
	defb 003h,04eh,08ch,041h,001h,081h,081h,001h,081h,081h,011h,041h,001h,081h,081h,001h	; 8c5a  .N.A.......A....
	defb 081h,081h,081h,041h,001h,081h,081h,001h,081h,081h,011h,041h,001h,081h,081h,041h	; 8c6a  ...A.......A...A
	defb 041h,041h,041h,0fbh,004h,05dh,08ch,0fdh,03eh,08ch,081h,001h,081h,081h,041h,001h	; 8c7a  AAA..]..>.....A.
	defb 081h,041h,081h,001h,081h,081h,041h,001h,081h,011h,0fbh,002h,084h,08ch,081h,001h	; 8c8a  .A....A.........
	defb 081h,081h,041h,081h,001h,081h,001h,081h,081h,001h,041h,001h,041h,041h,081h,001h	; 8c9a  ..A.......A.AA..
	defb 081h,081h,041h,081h,001h,081h,0fah	; 8caa

; ----------------------------------------------------------------------
; DATOS pista_8CB1: pista de la partitura (sonido 55 canal 1, sonido 58 canal
;   1); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x8cb1..0x8d78  (199 bytes)
DATA_pista_8CB1:
	defb 0feh,001h,0e9h,001h,0c0h,0e9h,006h,0d2h,0eah,00ch,0ebh,003h,040h,0c3h,022h,021h	; 8cb1  ............@."!
	defb 0c2h,022h,021h,0c2h,022h,0ebh,013h,033h,011h,0c0h,011h,0c0h,0d3h,0b2h,0a7h,0ebh	; 8cc1  ."!."..3........
	defb 018h,053h,0a0h,0a1h,0a1h,0a2h,0eah,009h,0ech,0eeh,001h,0d0h,040h,030h,020h,010h	; 8cd1  .S..........@0 .
	defb 000h,0d1h,0b0h,0a0h,090h,080h,070h,060h,050h,0eah,00ch,0ebh,003h,040h,0efh,0d2h	; 8ce1  ......p`P....@..
	defb 092h,0b0h,0fbh,002h,0beh,08ch,0eah,00ah,0ebh,003h,070h,0f9h,06ch,08dh,047h,040h	; 8cf1  ..........p.l.G@
	defb 040h,0c0h,040h,0c0h,042h,0f9h,06ch,08dh,027h,020h,020h,0c0h,020h,0c0h,022h,017h	; 8d01  @.@.B.l.'  . .".
	defb 010h,011h,014h,017h,010h,011h,014h,007h,000h,000h,0c0h,004h,027h,020h,020h,0c0h	; 8d11  ............'  .
	defb 020h,0c0h,022h,0ebh,003h,053h,0eah,00bh,0d1h,0c3h,042h,020h,0c1h,022h,000h,0c1h	; 8d21   ."..S....B ."..
	defb 002h,0d2h,0b0h,0c1h,0b2h,090h,0c1h,091h,071h,0eah,00ah,0eeh,001h,0c2h,0d3h,020h	; 8d31  ........q...... 
	defb 030h,050h,070h,0a0h,0d2h,020h,030h,050h,070h,0a0h,0d1h,020h,030h,070h,030h,020h	; 8d41  0Pp.. 0Pp.. 0p0 
	defb 0d2h,0a0h,0d1h,050h,020h,030h,000h,020h,0d2h,0a0h,0efh,0d1h,000h,0d2h,090h,0a0h	; 8d51  ...P 0. ........
	defb 070h,090h,050h,070h,0fbh,002h,027h,08dh,0fdh,0b9h,08ch,0d0h,027h,027h,027h,027h	; 8d61  p.Pp..'.....''''
	defb 0d1h,027h,020h,020h,0c0h,024h,0fah	; 8d71

; ----------------------------------------------------------------------
; DATOS pista_8D78: pista de la partitura (sonido 55 canal 5, sonido 58 canal
;   5); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x8d78..0x8ea5  (301 bytes)
DATA_pista_8D78:
	defb 0feh,001h,0f8h,014h,0e9h,006h,0eah,00fh,0ebh,01ah,033h,0f9h,074h,08eh,0a0h,0d3h	; 8d78  ..........3.t...
	defb 001h,001h,000h,0d4h,0a0h,0d3h,000h,070h,091h,070h,0d4h,0a0h,0d3h,000h,050h,070h	; 8d88  .......p.p....Pp
	defb 000h,021h,021h,020h,000h,021h,0d4h,070h,090h,0d3h,020h,0d4h,090h,0b0h,070h,090h	; 8d98  .!! .!.p.. ...p.
	defb 0fbh,002h,083h,08dh,0f9h,074h,08eh,0f9h,094h,08eh,0d4h,090h,0d3h,090h,070h,0d4h	; 8da8  .....t........p.
	defb 090h,0d3h,020h,040h,070h,090h,0d4h,070h,0d3h,070h,0d4h,060h,0d3h,060h,0d4h,050h	; 8db8  .. @p..p.p.`.`.P
	defb 0d3h,050h,0d4h,020h,030h,0f9h,074h,08eh,0f9h,094h,08eh,0d4h,070h,0d3h,070h,050h	; 8dc8  .P. 0.t.....p.pP
	defb 0d4h,070h,0d3h,000h,020h,050h,070h,0d4h,070h,0d3h,070h,0d4h,070h,070h,050h,070h	; 8dd8  .p.. Pp.p.p.ppPp
	defb 0d3h,020h,040h,0d4h,070h,091h,091h,090h,090h,090h,070h,091h,0d3h,070h,090h,0d4h	; 8de8  . @.p.....p..p..
	defb 090h,0d3h,020h,040h,0fbh,002h,0ebh,08dh,0d4h,0a0h,0d3h,001h,001h,000h,0d4h,0a0h	; 8df8  .. @............
	defb 0d3h,001h,001h,001h,000h,0d4h,0a0h,0d3h,000h,000h,021h,021h,020h,000h,021h,0d2h	; 8e08  ..........!! .!.
	defb 020h,000h,0d3h,020h,070h,090h,000h,020h,0ebh,00ah,050h,0d3h,070h,0d4h,070h,070h	; 8e18   .. p.. ..P.p.pp
	defb 070h,050h,070h,070h,070h,050h,070h,070h,070h,0a0h,070h,090h,070h,0d3h,020h,0d4h	; 8e28  pPpppPppp.p.p. .
	defb 070h,070h,070h,050h,070h,070h,070h,050h,070h,070h,070h,0d3h,010h,000h,0d4h,0ebh	; 8e38  pppPpppPppp.....
	defb 001h,036h,0a1h,0ebh,00ah,050h,030h,031h,031h,030h,030h,030h,030h,030h,030h,030h	; 8e48  .6...P0110000000
	defb 0a0h,030h,070h,030h,030h,051h,050h,050h,050h,050h,050h,0d3h,000h,0d4h,050h,090h	; 8e58  .0p00QPPPPP...P.
	defb 050h,050h,050h,050h,050h,0fbh,002h,020h,08eh,0fdh,080h,08dh,0d4h,020h,041h,041h	; 8e68  PPPPP.. ..... AA
	defb 040h,040h,040h,020h,041h,0d3h,020h,040h,0d4h,040h,090h,0b0h,020h,041h,041h,040h	; 8e78  @@@ A. @.@.. AA@
	defb 040h,040h,020h,041h,0d3h,020h,040h,0d4h,040h,090h,0b0h,0fah,050h,071h,071h,070h	; 8e88  @@ A. @.@...Pqqp
	defb 050h,071h,0d3h,050h,070h,0d4h,070h,0d3h,020h,040h,000h,020h,0fah	; 8e98  Pq.Pp.p. @. .

; ----------------------------------------------------------------------
; DATOS pista_8EA5: pista de la partitura (sonido 55 canal 6, sonido 58 canal
;   6); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x8ea5..0x8fa6  (257 bytes)
DATA_pista_8EA5:
	defb 0feh,001h,0e9h,006h,0f8h,021h,0eah,00bh,0ebh,029h,025h,0d1h,0c3h,012h,0d2h,0b1h	; 8ea5  .....!...)%.....
	defb 0c2h,0b2h,091h,0c2h,092h,081h,0c0h,081h,0c0h,062h,057h,050h,050h,0c0h,050h,0c0h	; 8eb5  .........bWPP.P.
	defb 052h,0eah,00ch,077h,0ebh,02ah,025h,070h,071h,070h,0f8h,023h,0eah,00fh,0d1h,022h	; 8ec5  R..w.*%pqp.#..."
	defb 040h,0fbh,002h,0a9h,08eh,0eeh,001h,0eah,00eh,0ebh,029h,035h,0f9h,088h,08fh,0f0h	; 8ed5  @.........)5....
	defb 0f8h,007h,0ebh,001h,08ah,0d4h,070h,0d3h,070h,0d4h,060h,0d3h,060h,0d4h,050h,0d3h	; 8ee5  ......p.p.`.`.P.
	defb 050h,0d4h,020h,030h,0ebh,029h,035h,0f9h,088h,08fh,0ebh,001h,08ah,0edh,003h,0f1h	; 8ef5  P. 0.)5.........
	defb 033h,0d3h,0b0h,0d2h,020h,070h,0b0h,0d1h,0c0h,022h,0f3h,013h,0d2h,091h,040h,07fh	; 8f05  3... p..."....@.
	defb 0c0h,0efh,0eah,00bh,0d3h,090h,0d2h,010h,040h,040h,0c0h,091h,0ebh,001h,0bbh,090h	; 8f15  ........@@......
	defb 0ebh,081h,0bbh,043h,001h,0d3h,070h,0d2h,008h,027h,0f0h,0eah,00ah,0ebh,01ah,033h	; 8f25  ...C..p..'.....3
	defb 0d3h,020h,021h,021h,0ebh,013h,052h,022h,0f0h,0f8h,015h,0eah,00dh,0ebh,001h,066h	; 8f35  . !!..R".......f
	defb 0d2h,0c3h,092h,070h,0c1h,072h,050h,0c1h,052h,040h,0c1h,042h,020h,0c1h,021h,001h	; 8f45  ...p.rP.R@.B .!.
	defb 0eeh,001h,0d3h,020h,030h,050h,070h,0a0h,0d2h,020h,030h,050h,070h,0a0h,0d1h,020h	; 8f55  ... 0Pp.. 0Pp.. 
	defb 030h,070h,030h,020h,0d2h,0a0h,0d1h,050h,020h,030h,000h,020h,0d2h,0a0h,0d1h,000h	; 8f65  0p0 ...P 0. ....
	defb 0d2h,090h,0efh,070h,030h,050h,020h,030h,000h,020h,0d3h,0a0h,0fbh,002h,045h,08fh	; 8f75  ...p0P 0. ....E.
	defb 0fdh,0a9h,08eh,0f8h,014h,0d2h,0c3h,043h,042h,062h,042h,0c0h,090h,080h,0c0h,040h	; 8f85  .......CBbB....@
	defb 0c0h,0d3h,0b0h,0d2h,042h,092h,081h,073h,021h,0d3h,0b0h,0d2h,0f1h,035h,02fh,0c0h	; 8f95  ....B..s!....5/.
	defb 0fah	; 8fa5

; ----------------------------------------------------------------------
; DATOS pista_8FA6: pista de la partitura (sonido 55 canal 7, sonido 58 canal
;   7); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x8fa6..0x9097  (241 bytes)
DATA_pista_8FA6:
	defb 0feh,001h,0e9h,006h,0eah,00ah,0ebh,029h,025h,0d2h,0c3h,092h,081h,0c2h,082h,061h	; 8fa6  .......)%......a
	defb 0c2h,062h,041h,0c0h,041h,0c0h,022h,027h,020h,020h,0c0h,020h,0c0h,022h,0eah,007h	; 8fb6  .bA.A."'  . ."..
	defb 0ebh,031h,010h,0eeh,001h,0d0h,040h,030h,020h,010h,000h,0d1h,0b0h,0a0h,090h,080h	; 8fc6  .1....@0 .......
	defb 070h,060h,050h,0ebh,031h,013h,0efh,0d1h,092h,080h,0fbh,002h,0aah,08fh,0efh,0eah	; 8fd6  p`P.1...........
	defb 007h,0ebh,027h,032h,097h,087h,067h,087h,077h,0ebh,01ah,033h,070h,071h,0ebh,027h	; 8fe6  ..'2..g.w..3pq.'
	defb 032h,074h,097h,0ebh,01ah,033h,090h,091h,091h,0ebh,001h,025h,092h,0d1h,0ebh,027h	; 8ff6  2t...3.....%...'
	defb 032h,097h,087h,067h,087h,0d2h,077h,0ebh,01ah,033h,070h,071h,0ebh,027h,032h,074h	; 9006  2..g..w..3pq.'2t
	defb 057h,0ebh,01ah,033h,050h,051h,051h,0ebh,027h,032h,052h,077h,072h,074h,077h,0edh	; 9016  W..3PQQ.'2Rwrtw.
	defb 003h,0f1h,033h,0eah,009h,0ebh,001h,08ah,0d2h,040h,090h,0d1h,010h,040h,0c0h,091h	; 9026  ..3......@...@..
	defb 0ebh,001h,0bbh,090h,0ebh,081h,0bbh,073h,041h,000h,048h,067h,0f0h,0ebh,01ah,033h	; 9036  .......sA.Hg...3
	defb 0d2h,090h,091h,091h,0ebh,027h,032h,092h,0f0h,0eah,00ah,0ebh,001h,066h,0eeh,001h	; 9046  .....'2......f..
	defb 0c3h,0d1h,002h,0d2h,0b0h,0c1h,0b2h,090h,0c1h,092h,070h,0c1h,072h,050h,0c1h,051h	; 9056  ..........p.rP.Q
	defb 041h,0d3h,020h,030h,050h,070h,0a0h,0d2h,020h,030h,050h,070h,0a0h,0d1h,020h,030h	; 9066  A. 0Pp.. 0Pp.. 0
	defb 070h,030h,020h,0d2h,0a0h,0d1h,050h,020h,030h,000h,020h,0d2h,0a0h,0d1h,000h,0d2h	; 9076  p0 ...P 0. .....
	defb 090h,0a0h,070h,090h,050h,070h,030h,050h,000h,0efh,0fbh,002h,054h,090h,0fdh,0aah	; 9086  ..p.Pp0P....T...
	defb 08fh	; 9096

; ----------------------------------------------------------------------
; DATOS pista_9097: pista de la partitura (sonido 56 canal 0, sonido 59 canal
;   0); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x9097..0x9122  (139 bytes)
DATA_pista_9097:
	defb 0feh,004h,0e9h,005h,000h,000h,000h,000h,041h,081h,081h,041h,000h,000h,041h,081h	; 9097  ........A..A..A.
	defb 081h,041h,081h,041h,081h,041h,081h,081h,081h,041h,081h,081h,041h,000h,000h,041h	; 90a7  .A.A.A...A..A..A
	defb 081h,081h,041h,081h,041h,081h,041h,081h,000h,000h,000h,000h,041h,081h,081h,041h	; 90b7  ..A.A.A.....A..A
	defb 000h,000h,041h,081h,081h,041h,081h,041h,081h,041h,081h,081h,081h,041h,081h,081h	; 90c7  ..A..A.A.A...A..
	defb 041h,000h,000h,041h,081h,081h,041h,081h,000h,000h,030h,030h,040h,040h,040h,040h	; 90d7  A..A..A...00@@@@
	defb 081h,081h,041h,081h,081h,081h,041h,081h,0fbh,007h,0e7h,090h,081h,081h,041h,081h	; 90e7  ..A...A.......A.
	defb 000h,000h,030h,030h,040h,040h,040h,040h,0fch,002h,0e7h,090h,081h,081h,041h,081h	; 90f7  ..00@@@@......A.
	defb 081h,081h,041h,081h,0fbh,00fh,003h,091h,040h,040h,000h,000h,030h,030h,040h,040h	; 9107  ..A.....@@..00@@
	defb 040h,040h,000h,000h,040h,040h,080h,080h,0fdh,097h,090h	; 9117  @@..@@.....

; ----------------------------------------------------------------------
; DATOS pista_9122: pista de la partitura (sonido 56 canal 1, sonido 59 canal
;   1); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x9122..0x9158  (54 bytes)
DATA_pista_9122:
	defb 0feh,001h,0efh,0e9h,005h,0eah,00ch,0ebh,011h,014h,0f2h,00ah,0f1h,052h,0d2h,04dh	; 9122  .............R.M
	defb 07fh,06fh,0e9h,00ah,058h,0e9h,005h,04dh,07fh,06fh,0e9h,00ah,098h,0eeh,002h,0e9h	; 9132  .o..X..M.o......
	defb 005h,0eah,00ah,0ebh,001h,010h,0c1h,0f9h,0f0h,092h,0fbh,002h,049h,091h,0c1h,0f9h	; 9142  ............I...
	defb 01dh,093h,0adh,0fdh,022h,091h	; 9152

; ----------------------------------------------------------------------
; DATOS pista_9158: pista de la partitura (sonido 56 canal 5, sonido 59 canal
;   5); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x9158..0x925a  (258 bytes)
DATA_pista_9158:
	defb 0feh,001h,0f8h,026h,0e9h,005h,0eah,00fh,0ebh,05fh,0f5h,0d4h,001h,001h,041h,001h	; 9158  ...&....._....A.
	defb 0a1h,091h,071h,001h,001h,001h,041h,001h,0a1h,091h,071h,001h,001h,001h,041h,001h	; 9168  ..q...A...q...A.
	defb 0a1h,091h,071h,001h,001h,000h,000h,041h,001h,0a1h,091h,0ebh,02fh,0f5h,070h,050h	; 9178  ..q....A..../.pP
	defb 040h,020h,0fbh,002h,060h,091h,0ebh,05fh,0f5h,0d4h,001h,001h,041h,001h,0a1h,091h	; 9188  @ ..`.._....A...
	defb 071h,0ebh,048h,015h,003h,0ebh,05fh,0f5h,001h,041h,001h,0a1h,091h,0ebh,048h,015h	; 9198  q.H..._..A....H.
	defb 073h,0ebh,05fh,0f5h,031h,031h,031h,031h,031h,0ebh,048h,015h,0a3h,053h,0ebh,05fh	; 91a8  s._.11111.H..S._
	defb 0f5h,051h,051h,051h,051h,0ebh,048h,015h,0d3h,005h,0fbh,004h,08eh,091h,0ebh,05fh	; 91b8  .QQQQ.H........_
	defb 0f5h,0d5h,051h,071h,071h,071h,071h,071h,071h,071h,0fbh,002h,0cah,091h,071h,091h	; 91c8  ..Qqqqqqqq....q.
	defb 091h,091h,091h,091h,091h,0ebh,048h,015h,093h,0ebh,05fh,0f5h,091h,0d4h,091h,0d5h	; 91d8  ......H..._.....
	defb 091h,0d4h,071h,0d5h,091h,0d4h,041h,0d5h,091h,051h,071h,071h,071h,071h,071h,071h	; 91e8  ..q...A..Qqqqqqq
	defb 071h,0fbh,002h,0f1h,091h,0d4h,041h,051h,051h,051h,051h,051h,051h,0ebh,048h,015h	; 91f8  q.....AQQQQQQ.H.
	defb 053h,0ebh,05fh,0f5h,051h,091h,0a1h,0d3h,001h,0d4h,0a1h,091h,051h,0d5h,051h,071h	; 9208  S._.Q.......Q.Qq
	defb 071h,071h,071h,071h,071h,071h,0fbh,002h,016h,092h,071h,091h,091h,091h,091h,091h	; 9218  qqqqqq....q.....
	defb 091h,0ebh,048h,015h,093h,0ebh,05fh,0f5h,091h,0d4h,091h,0d5h,091h,0d4h,071h,0d5h	; 9228  ..H..._.......q.
	defb 091h,0d4h,041h,0d5h,091h,051h,071h,071h,071h,071h,071h,071h,071h,071h,071h,071h	; 9238  ..A..Qqqqqqqqqqq
	defb 071h,0ebh,048h,015h,072h,072h,0ebh,05fh,0f5h,091h,0a1h,0fbh,010h,052h,092h,0fdh	; 9248  q.H.rr._.....R..
	defb 060h,091h	; 9258

; ----------------------------------------------------------------------
; DATOS pista_925A: pista de la partitura (sonido 56 canal 6, sonido 59 canal
;   6); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x925a..0x935b  (257 bytes)
DATA_pista_925A:
	defb 0feh,001h,0f8h,00ah,0e9h,001h,0eah,00fh,0ebh,001h,011h,0d1h,00dh,0eah,00dh,0d2h	; 925a  ................
	defb 0b0h,090h,070h,050h,040h,020h,0ebh,001h,065h,0e9h,005h,0eah,00ch,0d2h,000h,050h	; 926a  ..pP@ ..e......P
	defb 070h,0d1h,000h,0d2h,050h,070h,0d1h,000h,050h,0d2h,070h,0d1h,000h,050h,070h,0d0h	; 927a  p...Pp..P.p..Pp.
	defb 020h,0d1h,070h,050h,000h,070h,050h,000h,0d2h,070h,0d1h,050h,000h,0d2h,070h,050h	; 928a   .pP.pP..p.P..pP
	defb 0d1h,000h,0d2h,070h,050h,000h,070h,050h,000h,0d3h,070h,0d2h,050h,000h,0d3h,070h	; 929a  ...pP.pP..p.P..p
	defb 040h,0d2h,000h,0d3h,070h,050h,000h,070h,050h,000h,0d4h,070h,050h,070h,000h,0d3h	; 92aa  @...pP.pP..pPp..
	defb 050h,0d4h,070h,0d3h,000h,050h,070h,000h,050h,070h,0d2h,000h,0d3h,050h,070h,0d2h	; 92ba  P.p..Pp.Pp...Pp.
	defb 000h,070h,0fbh,002h,05ah,092h,0f8h,017h,0e9h,005h,0eah,00eh,0ebh,031h,015h,0f9h	; 92ca  .p..Z........1..
	defb 0f0h,092h,0fbh,002h,0d0h,092h,0f8h,00ah,0e9h,005h,0eah,00fh,0ebh,021h,015h,0f9h	; 92da  .............!..
	defb 01dh,093h,0afh,0fdh,05ah,092h,0d2h,071h,0d1h,001h,021h,045h,051h,045h,051h,073h	; 92ea  ....Z..q..!EQEQs
	defb 053h,041h,039h,051h,071h,0a3h,0d0h,003h,0d1h,0a3h,093h,071h,0d2h,071h,0d1h,001h	; 92fa  SA9Qq......q.q..
	defb 021h,045h,051h,045h,051h,073h,053h,041h,039h,051h,071h,0a3h,0d0h,003h,0d1h,0a3h	; 930a  !EQEQsSA9Qq.....
	defb 0d0h,005h,0fah,0d2h,075h,0d1h,025h,003h,0d2h,0b5h,095h,073h,095h,0d1h,047h,041h	; 931a  ....u.%....s..GA
	defb 072h,062h,021h,047h,0d2h,075h,0d1h,025h,003h,0d2h,0b5h,095h,073h,095h,0d1h,025h	; 932a  rb!G.u.%....s..%
	defb 073h,055h,035h,023h,0d2h,075h,0d1h,025h,003h,0d2h,0b5h,095h,073h,095h,0d1h,047h	; 933a  sU5#.u.%....s..G
	defb 041h,072h,062h,021h,047h,0d2h,075h,0d1h,025h,003h,0d2h,0b5h,095h,073h,0e9h,00ah	; 934a  Arb!G.u.%....s..
	defb 0fah	; 935a

; ----------------------------------------------------------------------
; DATOS pista_935B: pista de la partitura (sonido 56 canal 7, sonido 59 canal
;   7); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x935b..0x9411  (182 bytes)
DATA_pista_935B:
	defb 0feh,001h,0e9h,005h,0eah,00fh,0ebh,051h,015h,0f2h,00ah,0f1h,052h,0d2h,07dh,0afh	; 935b  .......Q....R.}.
	defb 09fh,0e9h,00ah,088h,0e9h,005h,07dh,0afh,09fh,0e9h,00ah,0d1h,028h,0e9h,005h,0eah	; 936b  ......}.....(...
	defb 00eh,0ebh,031h,015h,0d2h,041h,071h,0b1h,0d1h,005h,021h,005h,021h,043h,023h,001h	; 937b  ..1..Aq...!.!C#.
	defb 0d2h,0a9h,0d1h,001h,021h,033h,053h,033h,023h,001h,0d2h,041h,071h,0b1h,0d1h,005h	; 938b  ....!3S3#..Aq...
	defb 021h,005h,021h,043h,023h,001h,0d2h,0a9h,0d1h,001h,021h,033h,053h,033h,055h,0fbh	; 939b  !.!C#.....!3S3U.
	defb 002h,078h,093h,0e9h,005h,0eah,00eh,0ebh,021h,015h,0d2h,025h,009h,0d3h,0b5h,095h	; 93ab  .x......!..%....
	defb 073h,095h,0d2h,047h,041h,072h,062h,021h,047h,025h,009h,0d3h,0b5h,095h,073h,0e9h	; 93bb  s..GArb!G%....s.
	defb 00ah,09fh,0e9h,005h,0d2h,025h,009h,0d3h,0b5h,095h,073h,095h,0d2h,047h,041h,072h	; 93cb  .....%....s..GAr
	defb 062h,021h,047h,0d2h,025h,009h,0d3h,0b5h,095h,073h,0d4h,0a0h,0d3h,020h,050h,080h	; 93db  b!G.%....s... P.
	defb 020h,050h,080h,0a0h,050h,080h,0a0h,0d2h,020h,0d3h,080h,0a0h,0d2h,020h,050h,0d3h	; 93eb   P..P... .... P.
	defb 0a0h,0d2h,020h,050h,080h,020h,050h,080h,0a0h,050h,080h,0a0h,0d1h,020h,080h,0a0h	; 93fb  .. P. P..P... ..
	defb 0d1h,020h,050h,0fdh,05bh,093h	; 940b

; ----------------------------------------------------------------------
; DATOS pista_9411: pista de la partitura (sonido 65 canal 0, sonido 66 canal
;   0); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x9411..0x94bb  (170 bytes)
DATA_pista_9411:
	defb 0feh,004h,0e9h,004h,081h,001h,041h,001h,081h,081h,041h,011h,0fbh,003h,015h,094h	; 9411  ......A...A.....
	defb 081h,001h,041h,081h,001h,081h,041h,081h,081h,001h,041h,001h,081h,081h,041h,011h	; 9421  ..A...A...A...A.
	defb 0fbh,003h,029h,094h,081h,030h,030h,041h,080h,080h,030h,030h,040h,040h,080h,080h	; 9431  ..)..00A..00@@..
	defb 040h,040h,0fch,002h,015h,094h,081h,001h,041h,001h,081h,081h,041h,001h,081h,001h	; 9441  @@......A...A...
	defb 041h,081h,001h,081h,041h,011h,081h,081h,041h,001h,081h,081h,041h,001h,081h,001h	; 9451  A...A...A...A...
	defb 041h,081h,001h,081h,041h,041h,081h,001h,041h,001h,081h,081h,041h,001h,081h,001h	; 9461  A...AA..A...A...
	defb 041h,081h,001h,081h,041h,011h,081h,081h,041h,001h,081h,081h,041h,001h,081h,030h	; 9471  A...A...A...A..0
	defb 030h,041h,080h,080h,030h,030h,040h,040h,080h,080h,040h,040h,0fbh,002h,047h,094h	; 9481  0A..00@@..@@..G.
	defb 081h,001h,041h,001h,081h,081h,041h,001h,081h,001h,041h,081h,001h,081h,041h,011h	; 9491  ..A...A...A...A.
	defb 081h,041h,041h,041h,081h,041h,041h,041h,081h,030h,030h,040h,040h,080h,080h,040h	; 94a1  .AAA.AAA.00@@..@
	defb 040h,080h,080h,030h,040h,040h,080h,0fdh,015h,094h	; 94b1  @..0@@....

; ----------------------------------------------------------------------
; DATOS pista_94BB: pista de la partitura (sonido 65 canal 1, sonido 66 canal
;   1); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x94bb..0x9548  (141 bytes)
DATA_pista_94BB:
	defb 0feh,001h,0e9h,004h,0eah,00ch,0ebh,011h,035h,0d1h,041h,0c3h,027h,001h,0c1h,02dh	; 94bb  ........5.A.'..-
	defb 041h,0c3h,027h,051h,0c1h,051h,043h,023h,0eah,00ah,0d2h,050h,060h,070h,080h,0eah	; 94cb  A.'Q.QC#...P`p..
	defb 00ch,0d1h,071h,0c3h,057h,031h,0c1h,05dh,071h,0c3h,057h,081h,0c1h,081h,073h,053h	; 94db  ..q.W1.]q.W...sS
	defb 033h,041h,0c3h,027h,001h,0c1h,02dh,041h,0c3h,027h,051h,0c1h,051h,043h,023h,0eah	; 94eb  3A.'..-A.'Q.QC#.
	defb 00ah,0d2h,050h,060h,070h,080h,0eah,00ch,0d1h,071h,0c3h,057h,031h,0c1h,05dh,071h	; 94fb  ..P`p....q.W1.]q
	defb 0c3h,057h,081h,0c1h,081h,073h,053h,0f8h,015h,0d2h,050h,070h,080h,030h,0eeh,002h	; 950b  .W...sS...Pp.0..
	defb 0eah,00ah,0ebh,011h,010h,0d1h,0c3h,0f9h,00ah,097h,031h,0eeh,001h,0d1h,0a3h,0f9h	; 951b  ..........1.....
	defb 041h,097h,0d2h,0c3h,0a3h,0d1h,001h,019h,003h,011h,085h,0c1h,0eah,00bh,0d0h,0a1h	; 952b  A...............
	defb 091h,081h,0c1h,071h,061h,051h,0c1h,041h,031h,029h,0fdh,0bdh,094h	; 953b  ...qaQ.A1)...

; ----------------------------------------------------------------------
; DATOS pista_9548: pista de la partitura (sonido 65 canal 5, sonido 66 canal
;   5); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x9548..0x9679  (305 bytes)
DATA_pista_9548:
	defb 0feh,001h,0f8h,026h,0e9h,004h,0eah,00fh,0ebh,009h,040h,0d5h,051h,071h,0d4h,021h	; 9548  ...&......@.Qq.!
	defb 001h,0d5h,0a1h,091h,071h,051h,0fbh,003h,054h,095h,051h,071h,071h,091h,091h,0a1h	; 9558  ....qQ..T.Qqq...
	defb 0a1h,0d4h,001h,0d5h,081h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0fbh,003h,06ch,095h	; 9568  ..............l.
	defb 0d5h,081h,0a1h,0d4h,001h,031h,011h,001h,0d5h,081h,0d4h,001h,0d5h,051h,071h,0d4h	; 9578  .....1.......Qq.
	defb 021h,001h,0d5h,0a1h,091h,071h,051h,0fbh,003h,085h,095h,051h,071h,071h,0d4h,001h	; 9588  !....qQ....Qqq..
	defb 001h,0d5h,0a1h,051h,091h,0d5h,081h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0fbh,003h	; 9598  ...Q............
	defb 09eh,095h,081h,0a1h,0a1h,0a1h,0ebh,01fh,0f5h,0d4h,030h,040h,050h,060h,070h,080h	; 95a8  ..........0@P`p.
	defb 090h,0a0h,0f8h,014h,0ebh,04fh,0f5h,0d4h,061h,081h,081h,061h,081h,081h,061h,081h	; 95b8  .....O..a..a..a.
	defb 0fbh,002h,0c0h,095h,081h,0a1h,0a1h,081h,0a1h,0a1h,081h,0a1h,081h,0a1h,0a1h,081h	; 95c8  ................
	defb 0ebh,01fh,0f5h,0d3h,030h,020h,010h,000h,0d4h,0b0h,0a0h,090h,080h,0ebh,04fh,0f5h	; 95d8  ....0 ........O.
	defb 061h,081h,081h,061h,081h,081h,061h,081h,0fbh,002h,0e8h,095h,051h,061h,0fbh,008h	; 95e8  a..a..a.....Qa..
	defb 0f5h,095h,081h,081h,081h,081h,081h,0ebh,00fh,0f5h,080h,080h,080h,080h,0ebh,04fh	; 95f8  ...............O
	defb 0f5h,0d4h,081h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,081h,0a1h,0a1h,0a1h,0a1h,0d3h	; 9608  ................
	defb 011h,0d4h,0a1h,081h,051h,061h,061h,061h,061h,061h,061h,061h,061h,081h,081h,081h	; 9618  ....Qaaaaaaaa...
	defb 081h,0a1h,0d3h,001h,0d4h,081h,081h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,0a1h,081h,0a1h	; 9628  ................
	defb 0a1h,0a1h,0a1h,0d3h,011h,0d4h,0a1h,081h,051h,061h,061h,061h,061h,061h,061h,061h	; 9638  ........Qaaaaaaa
	defb 061h,081h,081h,081h,0d3h,031h,001h,0d4h,081h,091h,051h,061h,061h,061h,061h,081h	; 9648  a....1....Qaaaa.
	defb 0a1h,061h,061h,081h,081h,081h,081h,0a1h,0d3h,001h,0d4h,081h,0f8h,023h,0a1h,0d3h	; 9658  .aa..........#..
	defb 0a1h,091h,081h,0c1h,071h,061h,051h,0c1h,041h,031h,0ebh,051h,015h,029h,0fdh,04ah	; 9668  ....qaQ.A1.Q.).J
	defb 095h	; 9678

; ----------------------------------------------------------------------
; DATOS pista_9679: pista de la partitura (sonido 65 canal 6, sonido 66 canal
;   6); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x9679..0x976c  (243 bytes)
DATA_pista_9679:
	defb 0feh,001h,0f8h,00ah,0e9h,004h,0eah,00fh,0ebh,051h,015h,0d1h,001h,0c3h,0d2h,0a7h	; 9679  .........Q......
	defb 091h,0c1h,0adh,0d1h,001h,0c3h,0d2h,0a7h,0d1h,021h,0c1h,021h,003h,0d2h,0a3h,0eah	; 9689  .........!.!....
	defb 00ah,0a0h,0d1h,000h,010h,020h,0eah,00fh,031h,0c3h,017h,001h,0c1h,01dh,031h,0c3h	; 9699  ..... ..1.....1.
	defb 017h,051h,0c1h,051h,033h,013h,003h,001h,0c3h,0d2h,0a7h,091h,0c1h,0adh,0d1h,001h	; 96a9  .Q.Q3...........
	defb 0c3h,0d2h,0a7h,0d1h,021h,0c1h,021h,003h,0d2h,0a3h,0eah,00ah,0a0h,0d1h,000h,010h	; 96b9  ....!.!.........
	defb 020h,0eah,00fh,031h,0c3h,017h,001h,0c1h,01dh,031h,0c3h,017h,051h,0c1h,051h,033h	; 96c9   ..1.....1..Q.Q3
	defb 013h,0f8h,015h,0d2h,0a0h,0d1h,000h,010h,0d2h,0a0h,0f8h,013h,0d1h,0f9h,00ah,097h	; 96d9  ................
	defb 035h,0f8h,013h,0eah,00eh,0f9h,041h,097h,001h,011h,0d2h,0a3h,0d1h,001h,019h,003h	; 96e9  5.....A.........
	defb 011h,089h,0c1h,0a1h,091h,081h,0c1h,071h,061h,051h,0c1h,041h,031h,029h,0fdh,07bh	; 96f9  .......qaQ.A1).{
	defb 096h,005h,035h,085h,035h,003h,033h,0f8h,015h,011h,0d2h,0a1h,0d1h,011h,051h,011h	; 9709  ..5.5.3.......Q.
	defb 0d2h,0a1h,0d1h,011h,051h,0a1h,051h,031h,051h,011h,051h,001h,051h,0f8h,013h,005h	; 9719  ....Q.Q1Q.Q.Q...
	defb 035h,085h,035h,003h,033h,0f8h,015h,0d2h,0a1h,0d1h,001h,011h,053h,0d2h,0a1h,0d1h	; 9729  5.5.3.......S...
	defb 001h,011h,051h,031h,051h,081h,051h,0fah,0a1h,0d2h,0a1h,0c1h,0d1h,001h,0c1h,013h	; 9739  ..Q1Q.Q.........
	defb 031h,053h,033h,011h,035h,055h,035h,0d2h,0a5h,0d1h,055h,033h,003h,011h,0d2h,0a1h	; 9749  1S3.5U5...U3....
	defb 0c1h,0d1h,001h,0c1h,013h,081h,053h,033h,011h,035h,055h,035h,0d2h,0a5h,0d1h,055h	; 9759  ......S3.5U5...U
	defb 031h,011h,0fah	; 9769

; ----------------------------------------------------------------------
; DATOS pista_976C: pista de la partitura (sonido 65 canal 7, sonido 66 canal
;   7); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x976c..0x9887  (283 bytes)
DATA_pista_976C:
	defb 0feh,001h,0e9h,004h,0eah,00fh,0ebh,051h,015h,0d2h,071h,0c3h,077h,051h,0c1h,07dh	; 976c  .......Q..q.wQ.}
	defb 071h,0c3h,077h,0eeh,001h,0eah,00ch,0d1h,021h,0c1h,021h,003h,0d2h,0a3h,0eah,008h	; 977c  q.w.....!.!.....
	defb 0a0h,0d1h,000h,010h,020h,0efh,0eah,00fh,0d2h,0a1h,0c3h,0a7h,081h,0c1h,0adh,0a1h	; 978c  .... ...........
	defb 0c3h,0a7h,051h,0c1h,051h,033h,013h,003h,0eeh,001h,0eah,00ah,0d1h,0c0h,001h,0c3h	; 979c  ..Q.Q3..........
	defb 0d2h,0a7h,091h,0c1h,0a4h,0d3h,0a0h,0d2h,000h,010h,0eah,00dh,0d3h,0a0h,0d2h,000h	; 97ac  ................
	defb 010h,030h,000h,0efh,0eah,00fh,0d2h,071h,0c3h,077h,0a1h,0c1h,0a1h,093h,073h,0eeh	; 97bc  .0.....q.w....s.
	defb 001h,0eah,008h,0a0h,0d1h,000h,010h,020h,0efh,0eah,00fh,0d2h,0a1h,0c3h,0a7h,081h	; 97cc  ....... ........
	defb 0c1h,0adh,0a1h,0c3h,0a7h,051h,0c1h,051h,033h,013h,0eeh,001h,0eah,008h,0d2h,0a0h	; 97dc  .....Q.Q3.......
	defb 0d1h,000h,0d1h,010h,0d2h,0a0h,0efh,0eah,00eh,085h,0d1h,005h,035h,005h,0d2h,083h	; 97ec  ............5...
	defb 0d1h,003h,0eeh,001h,0eah,00ch,0c1h,011h,0d2h,0a1h,0d1h,011h,051h,011h,0d2h,0a1h	; 97fc  ............Q...
	defb 0d1h,011h,051h,0a1h,051h,031h,051h,011h,051h,001h,0efh,0eah,00eh,0d2h,085h,0d1h	; 980c  ..Q.Q1Q.Q.......
	defb 005h,035h,005h,0d2h,083h,0d1h,003h,0eah,00ch,0eeh,001h,0d2h,0c1h,0a1h,0d1h,001h	; 981c  .5..............
	defb 011h,053h,0d2h,0a1h,0d1h,001h,0eah,00eh,0efh,011h,001h,011h,051h,011h,005h,0d2h	; 982c  .S..........Q...
	defb 0a1h,0d3h,0a1h,0c1h,0d2h,001h,0c1h,013h,031h,0d1h,0d1h,013h,003h,0d2h,0a1h,0d1h	; 983c  ........1.......
	defb 005h,0d2h,055h,035h,0d3h,0a5h,0d2h,055h,033h,003h,011h,0d3h,0a1h,0c1h,0d2h,001h	; 984c  ..U5...U3.......
	defb 0c1h,013h,081h,053h,033h,011h,035h,015h,065h,0eeh,001h,0a5h,0efh,0d1h,015h,001h	; 985c  ...S3.5.e.......
	defb 0d2h,0a1h,081h,0a1h,063h,081h,0a9h,083h,0a1h,0d1h,039h,0c1h,021h,011h,001h,0d2h	; 986c  ....c.....9.!...
	defb 0c1h,0b1h,0a1h,091h,0c1h,081h,071h,069h,0fdh,06eh,097h	; 987c  ......qi.n.

; ----------------------------------------------------------------------
; DATOS pista_9887: pista de la partitura (sonido 67 canal 0, sonido 68 canal
;   0); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x9887..0x991d  (150 bytes)
DATA_pista_9887:
	defb 0feh,004h,0e9h,004h,081h,001h,041h,001h,081h,081h,041h,011h,0fbh,007h,08bh,098h	; 9887  ......A...A.....
	defb 081h,080h,080h,041h,081h,030h,030h,040h,040h,040h,040h,040h,040h,083h,042h,010h	; 9897  ...A.00@@@@@@.B.
	defb 081h,081h,041h,083h,081h,041h,081h,081h,041h,081h,081h,001h,041h,041h,081h,041h	; 98a7  ..A..A..A...AA.A
	defb 081h,081h,041h,081h,081h,041h,081h,081h,041h,041h,041h,083h,042h,010h,081h,081h	; 98b7  ..A..A..AAA.B...
	defb 041h,083h,081h,041h,081h,081h,081h,041h,041h,041h,081h,0fbh,00eh,0d0h,098h,030h	; 98c7  A..A...AAA.....0
	defb 030h,040h,040h,030h,030h,040h,040h,081h,011h,042h,000h,081h,081h,041h,011h,0fbh	; 98d7  0@@00@@..B...A..
	defb 004h,0deh,098h,081h,081h,041h,081h,081h,081h,041h,011h,081h,081h,041h,081h,081h	; 98e7  .....A...A...A..
	defb 081h,041h,011h,041h,081h,041h,081h,041h,041h,030h,030h,041h,041h,081h,041h,081h	; 98f7  .A.A.A.AA00AA.A.
	defb 041h,081h,030h,030h,041h,041h,081h,041h,081h,041h,081h,040h,040h,040h,040h,0fch	; 9907  A.00AA.A.A.@@@@.
	defb 002h,0deh,098h,0fdh,08bh,098h	; 9917

; ----------------------------------------------------------------------
; DATOS pista_991D: pista de la partitura (sonido 67 canal 1, sonido 68 canal
;   1); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x991d..0x9a15  (248 bytes)
DATA_pista_991D:
	defb 0feh,001h,0eeh,002h,0e9h,004h,0eah,00ah,0ebh,051h,010h,0d2h,0c1h,079h,041h,051h	; 991d  .........Q...yAQ
	defb 0d1h,00dh,001h,021h,031h,031h,0eah,007h,031h,0eah,00ah,051h,0eah,004h,051h,0eah	; 992d  ...!11..1..Q..Q.
	defb 00ah,071h,0eah,004h,071h,0eah,00ah,051h,0eah,004h,051h,0eah,00ah,021h,0eah,004h	; 993d  .q..q..Q..Q..!..
	defb 021h,0eah,00ah,0d2h,079h,079h,041h,051h,0d1h,00dh,001h,021h,031h,031h,0eah,004h	; 994d  !...yyAQ...!11..
	defb 031h,0eah,00ah,051h,0eah,004h,051h,0eah,00ah,0a1h,0eah,004h,0a1h,0eah,00ah,0d1h	; 995d  1..Q..Q.........
	defb 07fh,0eah,00ah,0ebh,051h,010h,0f2h,00ah,0f1h,051h,0d1h,0c3h,033h,021h,001h,0d2h	; 996d  ....Q....Q..3!..
	defb 0a1h,0d1h,001h,0c1h,053h,051h,051h,061h,071h,0d2h,0a3h,0efh,0eah,00bh,0d2h,031h	; 997d  ....SQQaq......1
	defb 031h,0eah,005h,031h,0eah,00bh,031h,031h,0eah,005h,031h,0eah,00bh,031h,031h,0eah	; 998d  1..1..11..1..11.
	defb 005h,031h,0eah,00bh,031h,031h,0eah,005h,031h,0eah,00bh,031h,031h,031h,0eah,00ah	; 999d  .1..11..1..111..
	defb 0d1h,0c3h,033h,021h,001h,0d2h,0a1h,0d1h,001h,0c1h,053h,051h,051h,061h,071h,0d2h	; 99ad  ..3!......SQQaq.
	defb 0a1h,0eah,00ch,0ebh,04fh,0f5h,0d4h,071h,071h,0b1h,071h,0d3h,001h,0d4h,071h,0d3h	; 99bd  ....O..qq.q...q.
	defb 021h,0ebh,063h,04fh,0d4h,073h,0ebh,04fh,0f5h,071h,0d3h,001h,021h,051h,071h,021h	; 99cd  !.cO.s.O.q..!Qq!
	defb 001h,0fbh,002h,0beh,099h,0eeh,001h,0e9h,004h,0eah,00ah,0ebh,011h,010h,0f2h,00ah	; 99dd  ................
	defb 0f1h,051h,0d2h,0c7h,041h,043h,053h,073h,09dh,0c7h,0b1h,0d1h,003h,023h,0d2h,083h	; 99ed  .Q..ACSs.....#..
	defb 0b3h,0d1h,053h,04bh,025h,001h,023h,043h,005h,001h,023h,043h,005h,0e9h,008h,07dh	; 99fd  ..SK%.#C..#C...}
	defb 0efh,0fbh,002h,0e2h,099h,0fdh,01fh,099h	; 9a0d  ........

; ----------------------------------------------------------------------
; DATOS pista_9A15: pista de la partitura (sonido 67 canal 5, sonido 68 canal
;   5); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x9a15..0x9b24  (271 bytes)
DATA_pista_9A15:
	defb 0feh,001h,0f8h,022h,0e9h,004h,0eah,00fh,0ebh,009h,035h,0d4h,001h,001h,041h,001h	; 9a15  ..."......5...A.
	defb 051h,001h,071h,0ebh,003h,01ah,053h,0ebh,009h,035h,051h,091h,051h,0a1h,051h,0b1h	; 9a25  Q.q...S..5Q.Q.Q.
	defb 0ebh,009h,01ah,033h,0ebh,009h,035h,031h,071h,031h,081h,031h,0a1h,0ebh,009h,01ah	; 9a35  ...3..51q1.1....
	defb 073h,0ebh,009h,035h,071h,0b1h,0d3h,001h,011h,021h,0d4h,0b1h,071h,0fbh,002h,020h	; 9a45  s..5q....!..q.. 
	defb 09ah,021h,031h,0fbh,006h,057h,09ah,0ebh,009h,01ah,053h,0ebh,009h,035h,051h,0fbh	; 9a55  .!1..W....S..5Q.
	defb 007h,063h,09ah,0f8h,026h,0c1h,001h,001h,0fbh,004h,06ah,09ah,0c1h,0d3h,001h,001h	; 9a65  .c..&.....j.....
	defb 001h,0f8h,022h,0d4h,021h,031h,0fbh,006h,07ah,09ah,0ebh,009h,01ah,053h,0ebh,009h	; 9a75  ..".!1..z....S..
	defb 035h,051h,0fbh,007h,086h,09ah,0f8h,026h,0d5h,071h,071h,0b1h,071h,0d4h,001h,0d5h	; 9a85  5Q.....&.qq.q...
	defb 071h,0d4h,021h,0ebh,009h,01ah,0d5h,073h,0ebh,009h,035h,071h,0d4h,001h,021h,051h	; 9a95  q.!....s..5q..!Q
	defb 071h,021h,001h,0fbh,002h,08dh,09ah,0f8h,022h,0d4h,001h,001h,041h,001h,0a1h,091h	; 9aa5  q!......"...A...
	defb 071h,0ebh,009h,01ah,053h,0ebh,009h,035h,051h,091h,051h,051h,041h,021h,0ebh,009h	; 9ab5  q...S..5Q.QQA!..
	defb 01ah,0d5h,073h,0ebh,009h,035h,071h,0b1h,071h,0d4h,001h,0d5h,071h,0d4h,021h,0ebh	; 9ac5  ..s..5q.q...q.!.
	defb 009h,01ah,0d5h,043h,0ebh,009h,035h,041h,081h,041h,091h,041h,0d4h,021h,0ebh,009h	; 9ad5  ...C..5A.A.A.!..
	defb 01ah,0d5h,093h,0ebh,009h,035h,091h,0d4h,001h,0d5h,091h,091h,0ebh,009h,01ah,075h	; 9ae5  .....5.........u
	defb 0ebh,009h,035h,051h,0fbh,008h,0f8h,09ah,061h,0fbh,008h,0fdh,09ah,071h,071h,0b1h	; 9af5  ..5Q....a....qq.
	defb 071h,0d4h,001h,0d5h,071h,0d4h,021h,0ebh,009h,01ah,0d5h,073h,0ebh,009h,035h,071h	; 9b05  q...q.!....s..5q
	defb 0b1h,0d4h,021h,051h,071h,021h,0d5h,0b1h,0fch,002h,0aeh,09ah,0fdh,020h,09ah	; 9b15  ..!Qq!....... .

; ----------------------------------------------------------------------
; DATOS pista_9B24: pista de la partitura (sonido 67 canal 6, sonido 68 canal
;   6); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x9b24..0x9c42  (286 bytes)
DATA_pista_9B24:
	defb 0feh,001h,0f8h,013h,0e9h,004h,0eah,00fh,0ebh,051h,015h,0d2h,079h,041h,051h,0d1h	; 9b24  .........Q..yAQ.
	defb 00dh,001h,021h,031h,031h,0eah,009h,031h,0eah,00fh,051h,0eah,009h,051h,0eah,00fh	; 9b34  ..!11..1..Q..Q..
	defb 071h,0eah,009h,071h,0eah,00fh,051h,0eah,009h,051h,0eah,00fh,021h,0eah,009h,021h	; 9b44  q..q..Q..Q..!..!
	defb 0eah,00dh,0d2h,079h,079h,041h,051h,0d1h,00dh,001h,021h,031h,031h,0eah,009h,031h	; 9b54  ...yyAQ...!11..1
	defb 0eah,00fh,051h,0eah,009h,051h,0eah,00fh,0a1h,0eah,009h,0a1h,0eah,00fh,0d1h,07fh	; 9b64  ..Q..Q..........
	defb 0c1h,0f2h,00ah,0f1h,051h,0d1h,033h,021h,001h,0d2h,0a1h,0d1h,001h,0c1h,053h,051h	; 9b74  ....Q.3!......SQ
	defb 051h,061h,071h,0d2h,0a5h,0c1h,0d1h,031h,031h,0eah,009h,031h,0eah,00fh,031h,031h	; 9b84  Qaq....11..1..11
	defb 0eah,009h,031h,0eah,00fh,031h,031h,0eah,009h,031h,0eah,00fh,031h,031h,0eah,009h	; 9b94  ..1..11..1..11..
	defb 031h,0eah,00fh,031h,031h,031h,0d1h,033h,021h,001h,0d2h,0a1h,0d1h,001h,0c1h,053h	; 9ba4  1..111.3!......S
	defb 051h,051h,061h,071h,0d2h,0a5h,0f8h,015h,0d3h,070h,0b0h,020h,0b0h,020h,050h,020h	; 9bb4  QQaq.....p. . P 
	defb 050h,070h,050h,060h,0b0h,070h,0b0h,0d2h,020h,0d3h,0b0h,0d2h,020h,050h,020h,050h	; 9bc4  PpP`.p.. ... P P
	defb 070h,050h,070h,0b0h,070h,0b0h,0d1h,020h,0d2h,0b0h,0d1h,020h,050h,070h,050h,0d2h	; 9bd4  pPp.p.. ... PpP.
	defb 070h,0b0h,020h,0b0h,020h,050h,020h,050h,070h,050h,060h,0b0h,070h,0b0h,0d1h,020h	; 9be4  p. . P PpP`.p.. 
	defb 0d2h,0b0h,0d1h,020h,050h,020h,050h,070h,050h,070h,0b0h,070h,0b0h,0d0h,020h,0d1h	; 9bf4  ... P PpPp.p.. .
	defb 0b0h,0d0h,020h,050h,070h,050h,0f8h,00dh,0e9h,004h,0ebh,04fh,0f5h,0f2h,00ah,0f1h	; 9c04  .. PpP.....O....
	defb 052h,0d4h,001h,001h,0f8h,013h,0ebh,051h,015h,0d2h,041h,043h,053h,073h,09dh,0c7h	; 9c14  R......Q..ACSs..
	defb 0b1h,0d1h,003h,023h,0d2h,083h,0b3h,0d1h,053h,04bh,025h,001h,023h,043h,005h,001h	; 9c24  ...#....SK%.#C..
	defb 023h,043h,005h,0e9h,008h,07fh,0efh,0fch,002h,00ah,09ch,0fdh,026h,09bh	; 9c34  #C..........&.

; ----------------------------------------------------------------------
; DATOS pista_9C42: pista de la partitura (sonido 67 canal 7, sonido 68 canal
;   7); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x9c42..0x9d62  (288 bytes)
DATA_pista_9C42:
	defb 0feh,001h,0e9h,004h,0eah,00eh,0ebh,051h,015h,0d3h,079h,041h,051h,0d2h,00dh,001h	; 9c42  .......Q..yAQ...
	defb 021h,071h,071h,0eah,007h,071h,0eah,00dh,091h,0eah,007h,091h,0eah,00dh,0a1h,0eah	; 9c52  !qq..q..........
	defb 007h,0a1h,0eah,00dh,091h,0eah,007h,091h,0eah,00dh,051h,0eah,007h,051h,0eah,00ch	; 9c62  ..........Q..Q..
	defb 029h,0d3h,079h,041h,051h,0d2h,00dh,001h,021h,071h,071h,0eah,007h,071h,0eah,00dh	; 9c72  ).yAQ...!qq..q..
	defb 0a1h,0eah,007h,0a1h,0eah,00dh,0d1h,021h,0eah,007h,021h,0eah,00dh,007h,0d2h,0b9h	; 9c82  .......!..!.....
	defb 0eah,00eh,0f2h,00ah,0f1h,051h,0d2h,0a3h,091h,071h,051h,071h,0c1h,0d1h,003h,001h	; 9c92  .....Q...qQq....
	defb 001h,011h,021h,0d2h,055h,0c1h,0a1h,0a1h,0eah,008h,0a1h,0eah,00eh,0a1h,0a1h,0eah	; 9ca2  ..!.U...........
	defb 008h,0a1h,0eah,00eh,0a1h,0a1h,0eah,008h,0a1h,0eah,00eh,0a1h,0a1h,0eah,008h,0a1h	; 9cb2  ................
	defb 0eah,00eh,0a1h,031h,031h,0d2h,0a3h,091h,071h,051h,071h,0c1h,0d1h,003h,001h,001h	; 9cc2  ...11...qQq.....
	defb 011h,021h,0d2h,055h,0eah,00ah,0ebh,051h,010h,0eeh,001h,0d3h,0c1h,070h,0b0h,020h	; 9cd2  .!.U...Q.....p. 
	defb 0b0h,020h,050h,020h,050h,070h,050h,060h,0b0h,070h,0b0h,0d2h,020h,0d3h,0b0h,0d2h	; 9ce2  . P PpP`.p.. ...
	defb 020h,050h,020h,050h,070h,050h,070h,0b0h,070h,0b0h,0d1h,020h,0d2h,0b0h,0d1h,020h	; 9cf2   P PpPp.p.. ... 
	defb 050h,070h,050h,0d2h,070h,0b0h,020h,0b0h,020h,050h,020h,050h,070h,050h,060h,0b0h	; 9d02  PpP.p. . P PpP`.
	defb 070h,0b0h,0d1h,020h,0d2h,0b0h,0d1h,020h,050h,020h,050h,070h,050h,070h,0b0h,070h	; 9d12  p.. ... P PpPp.p
	defb 0b0h,0d0h,020h,0d1h,0b0h,0d0h,020h,050h,0eah,00eh,0e9h,004h,0ebh,051h,015h,0f2h	; 9d22  .. ... P.....Q..
	defb 00ah,0f1h,052h,0d3h,0c3h,041h,043h,053h,073h,09dh,0c7h,0b1h,0d2h,003h,0d3h,0b3h	; 9d32  ..R..ACSs.......
	defb 053h,083h,0d2h,023h,00bh,0d3h,0b5h,091h,0b3h,0d2h,003h,0d3h,095h,091h,0b3h,0d2h	; 9d42  S..#............
	defb 003h,0d3h,095h,0d2h,02dh,001h,0d3h,0bfh,0efh,0fch,002h,02ah,09dh,0fdh,044h,09ch	; 9d52  ....-......*..D.

; ----------------------------------------------------------------------
; DATOS pista_9D62: pista de la partitura (sonido 60 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9d62..0x9d9f  (61 bytes)
DATA_pista_9D62:
	defb 0feh,004h,0e9h,006h,041h,040h,040h,040h,030h,040h,040h,030h,040h,040h,030h,080h	; 9d62  ....A@@@0@@0@@0.
	defb 000h,080h,040h,000h,000h,0fbh,003h,071h,09dh,080h,000h,080h,040h,000h,040h,080h	; 9d72  ..@....q....@.@.
	defb 000h,080h,040h,000h,000h,0fbh,002h,07bh,09dh,080h,080h,000h,040h,080h,010h,040h	; 9d82  ..@....{....@..@
	defb 040h,080h,040h,040h,080h,000h,040h,040h,040h,040h,080h,040h,0ffh	; 9d92  @.@@..@@@@.@.

; ----------------------------------------------------------------------
; DATOS pista_9D9F: pista de la partitura (sonido 60 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9d9f..0x9dd7  (56 bytes)
DATA_pista_9D9F:
	defb 0feh,001h,0e9h,006h,0ebh,051h,015h,0eah,00eh,0d4h,0c4h,0c3h,0c2h,001h,000h,0fbh	; 9d9f  .....Q..........
	defb 005h,0ach,09dh,001h,0c0h,0c1h,0c0h,0c1h,0c0h,001h,000h,0fbh,006h,0b8h,09dh,000h	; 9daf  ................
	defb 030h,050h,030h,0a0h,070h,080h,050h,0d3h,000h,0d4h,0a0h,020h,050h,0a0h,000h,030h	; 9dbf  0P0.p.P.... P..0
	defb 070h,000h,070h,0e9h,008h,0d3h,000h,0ffh	; 9dcf  p.p.....

; ----------------------------------------------------------------------
; DATOS pista_9DD7: pista de la partitura (sonido 60 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9dd7..0x9e38  (97 bytes)
DATA_pista_9DD7:
	defb 0feh,001h,0f8h,00dh,0e9h,006h,0ebh,051h,035h,0eah,00fh,0d2h,0c4h,000h,051h,000h	; 9dd7  .......Q5.....Q.
	defb 031h,000h,0ebh,02fh,0f5h,0d3h,000h,000h,0a0h,090h,000h,070h,0fbh,002h,0edh,09dh	; 9de7  1../.......p....
	defb 000h,000h,0a0h,090h,000h,0ebh,051h,035h,0d2h,000h,051h,000h,031h,000h,0ebh,02fh	; 9df7  ......Q5..Q.1../
	defb 0f5h,0d3h,000h,000h,0a0h,090h,000h,070h,000h,000h,0a0h,090h,000h,070h,000h,000h	; 9e07  .......p.....p..
	defb 0a0h,090h,000h,000h,0ebh,03dh,055h,0d2h,000h,030h,050h,030h,0a0h,070h,080h,050h	; 9e17  .....=U..0P0.p.P
	defb 0d1h,000h,0d2h,0a0h,020h,050h,0a0h,000h,030h,070h,000h,070h,0e9h,008h,0d1h,000h	; 9e27  .... P..0p.p....
	defb 0ffh	; 9e37

; ----------------------------------------------------------------------
; DATOS pista_9E38: pista de la partitura (sonido 60 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9e38..0x9e8b  (83 bytes)
DATA_pista_9E38:
	defb 0feh,001h,0f8h,00dh,0eeh,001h,0e9h,006h,0ebh,051h,010h,0eah,00bh,0d2h,0c5h,030h	; 9e38  .........Q.....0
	defb 091h,030h,071h,0d2h,0f8h,017h,0ebh,071h,010h,0c3h,0a1h,093h,091h,075h,0d2h,0f8h	; 9e48  .0q....q.....u..
	defb 00dh,0ebh,051h,010h,030h,091h,030h,071h,0f8h,017h,0ebh,071h,010h,0c3h,0a1h,093h	; 9e58  ..Q.0.0q...q....
	defb 091h,075h,0f8h,00ah,0ebh,03dh,055h,0d3h,0eah,00fh,000h,030h,050h,030h,0a0h,070h	; 9e68  .u...=U....0P0.p
	defb 080h,050h,0d2h,000h,0d3h,0a0h,020h,050h,0a0h,000h,030h,070h,000h,070h,0e9h,008h	; 9e78  .P.... P..0p.p..
	defb 0d2h,000h,0ffh	; 9e88

; ----------------------------------------------------------------------
; DATOS pista_9E8B: pista de la partitura (sonido 60 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9e8b..0x9ede  (83 bytes)
DATA_pista_9E8B:
	defb 0feh,001h,0f8h,00dh,0e9h,006h,0ebh,051h,035h,0eah,00fh,0d2h,0c4h,030h,091h,030h	; 9e8b  .......Q5....0.0
	defb 071h,030h,0d2h,0f8h,017h,0ebh,072h,015h,0c2h,0a1h,093h,091h,075h,0d2h,0f8h,00dh	; 9e9b  q0....r.....u...
	defb 0ebh,051h,035h,030h,091h,030h,071h,030h,0f8h,017h,0ebh,072h,015h,0c2h,0a1h,093h	; 9eab  .Q50.0q0...r....
	defb 091h,077h,0f8h,00dh,0ebh,04dh,055h,0eah,00bh,0eeh,001h,0d2h,000h,030h,050h,030h	; 9ebb  .w...MU......0P0
	defb 0a0h,070h,080h,050h,0d1h,000h,0d2h,0a0h,020h,050h,0a0h,000h,030h,070h,000h,0e9h	; 9ecb  .p.P.... P..0p..
	defb 008h,070h,0ffh	; 9edb

; ----------------------------------------------------------------------
; DATOS pista_9EDE: pista de la partitura (sonido 60 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9ede..0x9f34  (86 bytes)
DATA_pista_9EDE:
	defb 0feh,001h,0e9h,006h,0ebh,051h,035h,0eah,00fh,0d3h,0c4h,070h,0d2h,001h,0d3h,070h	; 9ede  .....Q5....p...p
	defb 0a1h,070h,0ebh,071h,015h,0d2h,0c2h,071h,053h,051h,035h,0ebh,051h,035h,0d3h,070h	; 9eee  .p.q...qSQ5.Q5.p
	defb 0d2h,001h,0d3h,070h,0a1h,070h,0ebh,071h,015h,0d2h,0c2h,071h,053h,051h,036h,0ebh	; 9efe  ...p.p.q...qSQ6.
	defb 03dh,055h,0eah,006h,0d3h,070h,0eah,00fh,0d2h,000h,030h,0d3h,0a0h,0d2h,070h,030h	; 9f0e  =U...p....0...p0
	defb 050h,000h,080h,050h,0d3h,0a0h,0d2h,020h,050h,0d3h,070h,0d2h,000h,030h,0d3h,070h	; 9f1e  P..P... P.p..0.p
	defb 0d2h,030h,0e9h,008h,070h,0ffh	; 9f2e

; ----------------------------------------------------------------------
; DATOS pista_9F34: pista de la partitura (sonido 61 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f34..0x9f35  (1 bytes)
DATA_pista_9F34:
	defb 0ffh	; 9f34

; ----------------------------------------------------------------------
; DATOS pista_9F35: pista de la partitura (sonido 61 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f35..0x9f36  (1 bytes)
DATA_pista_9F35:
	defb 0ffh	; 9f35

; ----------------------------------------------------------------------
; DATOS pista_9F36: pista de la partitura (sonido 61 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f36..0x9f37  (1 bytes)
DATA_pista_9F36:
	defb 0ffh	; 9f36

; ----------------------------------------------------------------------
; DATOS pista_9F37: pista de la partitura (sonido 61 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f37..0x9f38  (1 bytes)
DATA_pista_9F37:
	defb 0ffh	; 9f37

; ----------------------------------------------------------------------
; DATOS pista_9F38: pista de la partitura (sonido 61 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f38..0x9f39  (1 bytes)
DATA_pista_9F38:
	defb 0ffh	; 9f38

; ----------------------------------------------------------------------
; DATOS pista_9F39: pista de la partitura (sonido 61 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f39..0x9f3a  (1 bytes)
DATA_pista_9F39:
	defb 0ffh	; 9f39

; ----------------------------------------------------------------------
; DATOS pista_9F3A: pista de la partitura (sonido 61 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f3a..0x9f3b  (1 bytes)
DATA_pista_9F3A:
	defb 0ffh	; 9f3a

; ----------------------------------------------------------------------
; DATOS pista_9F3B: pista de la partitura (sonido 61 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f3b..0x9f3c  (1 bytes)
DATA_pista_9F3B:
	defb 0ffh	; 9f3b

; ----------------------------------------------------------------------
; DATOS pista_9F3C: pista de la partitura (sonido 62 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f3c..0x9f66  (42 bytes)
DATA_pista_9F3C:
	defb 0feh,004h,0e9h,003h,087h,087h,083h,083h,041h,041h,041h,041h,083h,081h,081h,041h	; 9f3c  ........AAAA...A
	defb 081h,081h,010h,000h,081h,081h,083h,043h,081h,081h,081h,011h,043h,043h,083h,041h	; 9f4c  .......C....CC.A
	defb 041h,001h,011h,041h,081h,081h,041h,0fdh,048h,09fh	; 9f5c  A..A..A.H.

; ----------------------------------------------------------------------
; DATOS pista_9F66: pista de la partitura (sonido 62 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f66..0x9f8e  (40 bytes)
DATA_pista_9F66:
	defb 0feh,001h,0e9h,003h,0eah,00ch,0ebh,001h,055h,0d3h,047h,027h,007h,0d4h,0b5h,045h	; 9f66  ........U.G'...E
	defb 0ebh,053h,055h,0d3h,041h,0d4h,041h,071h,0d3h,071h,0d4h,071h,091h,0cbh,073h,091h	; 9f76  .SU.A.Aq.q.q..s.
	defb 0c9h,073h,095h,075h,047h,0fdh,076h,09fh	; 9f86  .s.uG.v.

; ----------------------------------------------------------------------
; DATOS pista_9F8E: pista de la partitura (sonido 62 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x9f8e..0x9fd3  (69 bytes)
DATA_pista_9F8E:
	defb 0feh,001h,0eeh,003h,0e9h,003h,0eah,009h,0ebh,001h,055h,0d1h,047h,077h,097h,0b5h	; 9f8e  ..........U.Gw..
	defb 0d0h,041h,0ebh,001h,012h,0e9h,003h,0eah,00bh,0cfh,0c1h,0d1h,025h,041h,0cfh,0cdh	; 9f9e  .A..........%A..
	defb 0f1h,055h,075h,0f0h,041h,0cfh,0c1h,025h,041h,0cfh,0c5h,0f1h,055h,0d1h,041h,0c5h	; 9fae  .Uu.A..%A...U.A.
	defb 045h,0e9h,001h,0eah,009h,030h,020h,0eah,008h,010h,000h,0eah,007h,0d2h,0b0h,0a0h	; 9fbe  E....0 .........
	defb 0fbh,002h,0a3h,09fh,0ffh	; 9fce

; ----------------------------------------------------------------------
; DATOS pista_9FD3: pista de la partitura (sonido 62 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir (sigue en la pagina siguiente)
;   0x9fd3..0xa000  (45 bytes)
DATA_pista_9FD3:
	defb 0feh,001h,0f8h,026h,0e9h,003h,0eah,00fh,0ebh,021h,065h,0d4h,047h,027h,007h,0d5h	; 9fd3  ...&.....!e.G'..
	defb 0b5h,045h,0ebh,061h,015h,0d5h,0eah,00ah,0d3h,041h,0eah,00eh,0d5h,041h,071h,0d4h	; 9fe3  .E.a.....A...Aq.
	defb 071h,0d5h,071h,091h,0cbh,073h,091h,0c9h,073h,095h,075h,047h,0fdh	; 9ff3  q.q..s..s.uG.
