; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 15 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS pista_9FD3: pista de la partitura (sonido 62 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa000..0xa002  (2 bytes)

; ----------------------------------------------------------------------
; Los dos primeros bytes de la pagina no son una pista: son el operando
; del salto FD E5 9F cuyo 0xFD es el ULTIMO byte de la pagina 14. La
; pista que empieza en 0x9FD3 (pagina 14) vuelve a 0x9FE5 y suena en
; bucle; el interprete cruza la frontera de banco sin enterarse.
; ----------------------------------------------------------------------
DATA_pista_9FD3:
	defb 0e5h,09fh	; a000

; ----------------------------------------------------------------------
; DATOS pista_A002: pista de la partitura (sonido 62 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa002..0xa048  (70 bytes)
DATA_pista_A002:
	defb 0feh,001h,0f8h,038h,0e9h,003h,0eah,00bh,0ebh,071h,015h,0d2h,027h,027h,047h,035h	; a002  ...8.....q..''G5
	defb 0b1h,0ebh,001h,023h,0e9h,003h,0d2h,0cfh,0c1h,0eah,00ah,095h,0b1h,0cfh,0cdh,0f1h	; a012  ...#............
	defb 055h,0d1h,025h,0f0h,0d2h,0b1h,0cfh,0c1h,095h,0b1h,0cfh,0c5h,0f1h,055h,0d1h,0b1h	; a022  U.%..........U..
	defb 0c5h,0b5h,0e9h,001h,0eah,009h,0a0h,090h,0eah,008h,080h,070h,0eah,007h,060h,050h	; a032  ...........p..`P
	defb 0f0h,0fbh,002h,016h,0a0h,0ffh	; a042

; ----------------------------------------------------------------------
; DATOS pista_A048: pista de la partitura (sonido 62 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa048..0xa094  (76 bytes)
DATA_pista_A048:
	defb 0feh,001h,0f8h,038h,0e9h,003h,0eah,00eh,0ebh,071h,015h,0d1h,047h,077h,097h,0b5h	; a048  ...8.....q..Gw..
	defb 0d0h,041h,0ebh,001h,012h,0e9h,003h,0eah,00bh,0cfh,0c1h,0d1h,025h,041h,0cfh,0cdh	; a058  .A..........%A..
	defb 0f1h,055h,0b5h,0f0h,041h,0cfh,0c1h,025h,041h,0cfh,0c5h,0f1h,055h,0d0h,041h,0c5h	; a068  .U..A..%A...U.A.
	defb 043h,0e9h,001h,0eah,00ah,030h,020h,010h,000h,0eah,009h,0d1h,0b0h,0a0h,090h,080h	; a078  C....0 .........
	defb 0eah,008h,070h,060h,050h,040h,0f0h,0fbh,002h,05dh,0a0h,0ffh	; a088  ..p`P@...]..

; ----------------------------------------------------------------------
; DATOS pista_A094: pista de la partitura (sonido 62 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa094..0xa0fa  (102 bytes)
DATA_pista_A094:
	defb 0feh,001h,0f8h,038h,0e9h,003h,0eah,00fh,0ebh,071h,015h,0d2h,047h,077h,097h,0b5h	; a094  ...8.....q..Gw..
	defb 0d1h,041h,0d2h,0f8h,021h,0ebh,001h,0cdh,0eah,006h,030h,0c0h,040h,0c0h,020h,0c0h	; a0a4  .A..!.....0.@. .
	defb 040h,0c0h,020h,0c0h,020h,0c0h,040h,0c0h,020h,0c0h,020h,0c0h,020h,0c0h,040h,0c0h	; a0b4  @. . .@. . . .@.
	defb 020h,0c0h,020h,0c0h,040h,0c0h,020h,0c0h,020h,0c0h,0fbh,008h,0aeh,0a0h,0f8h,00dh	; a0c4   . .@. . .......
	defb 0ebh,038h,0f5h,0eah,00ch,0d4h,043h,0ebh,02fh,0f5h,0eah,008h,0d2h,041h,0eah,00ch	; a0d4  .8....C./....A..
	defb 0d4h,041h,071h,0d3h,071h,0d4h,071h,091h,0ebh,038h,0f5h,0cbh,073h,091h,0c9h,073h	; a0e4  .Aq.q.q..8..s..s
	defb 095h,075h,047h,0fdh,0dbh,0a0h	; a0f4

; ----------------------------------------------------------------------
; DATOS pista_A0FA: pista de la partitura (sonido 62 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa0fa..0xa15a  (96 bytes)
DATA_pista_A0FA:
	defb 0feh,001h,0e9h,003h,0eah,00bh,0ebh,071h,015h,0d3h,0b7h,0b7h,0a7h,095h,0d2h,041h	; a0fa  .......q.......A
	defb 0d3h,0ebh,001h,0cdh,0eah,006h,030h,0c0h,040h,0c0h,090h,0c0h,040h,0c0h,090h,0c0h	; a10a  ......0.@...@...
	defb 090h,0c0h,040h,0c0h,090h,0c0h,090h,0c0h,090h,0c0h,040h,0c0h,090h,0c0h,090h,0c0h	; a11a  ..@.......@.....
	defb 040h,0c0h,090h,0c0h,090h,0c0h,0fbh,008h,010h,0a1h,0ebh,038h,0f5h,0eah,00ch,0d5h	; a12a  @..........8....
	defb 043h,0ebh,02fh,0f5h,0eah,008h,0d3h,041h,0eah,00ch,0d5h,041h,071h,0d4h,071h,0d5h	; a13a  C./....A...Aq.q.
	defb 071h,091h,0ebh,038h,0f5h,0cbh,073h,091h,0c9h,073h,095h,075h,047h,0fdh,03bh,0a1h	; a14a  q..8..s..s.uG.;.

; ----------------------------------------------------------------------
; DATOS pista_A15A: pista de la partitura (sonido 63 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa15a..0xa193  (57 bytes)
DATA_pista_A15A:
	defb 0feh,004h,0e9h,006h,081h,080h,080h,041h,080h,080h,081h,080h,041h,080h,040h,080h	; a15a  .......A....A.@.
	defb 081h,080h,080h,041h,080h,080h,081h,080h,040h,040h,040h,041h,081h,080h,080h,041h	; a16a  ...A....@@@A...A
	defb 080h,080h,081h,080h,041h,080h,040h,080h,081h,080h,080h,041h,040h,040h,040h,040h	; a17a  ....A.@....A@@@@
	defb 040h,040h,040h,040h,040h,040h,0fdh,05eh,0a1h	; a18a  @@@@@@.^.

; ----------------------------------------------------------------------
; DATOS pista_A193: pista de la partitura (sonido 63 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa193..0xa1d7  (68 bytes)
DATA_pista_A193:
	defb 0feh,001h,0e9h,006h,0eah,00bh,0ebh,02fh,0f5h,0d2h,070h,0c1h,090h,0c1h,0b0h,0c0h	; a193  ......./..p.....
	defb 0d1h,020h,0c1h,0d2h,0b0h,0c1h,090h,0c0h,070h,0c1h,090h,0c1h,0b0h,0c0h,0ebh,039h	; a1a3  . ......p......9
	defb 011h,072h,0d2h,014h,0ebh,02fh,0f5h,070h,0c1h,090h,0c1h,0b0h,0c0h,0d1h,020h,0c1h	; a1b3  .r.../.p...... .
	defb 0d2h,0b0h,0c1h,090h,0c0h,070h,0c1h,090h,0c1h,0b0h,0c0h,0ebh,039h,011h,072h,0d1h	; a1c3  .....p......9.r.
	defb 014h,0fdh,099h,0a1h	; a1d3

; ----------------------------------------------------------------------
; DATOS pista_A1D7: pista de la partitura (sonido 63 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa1d7..0xa217  (64 bytes)
DATA_pista_A1D7:
	defb 0feh,001h,0e9h,006h,0eah,00bh,0ebh,02fh,0f5h,0d1h,010h,0c1h,020h,0c1h,040h,0c0h	; a1d7  ......./.... .@.
	defb 070h,0c1h,040h,0c1h,020h,0c0h,010h,0c1h,020h,0c1h,040h,0c0h,0ebh,039h,011h,012h	; a1e7  p.@. ... .@..9..
	defb 0d2h,074h,0ebh,02fh,0f5h,0d1h,010h,0c1h,020h,0c1h,040h,0c0h,070h,0c1h,040h,0c1h	; a1f7  .t./.... .@.p.@.
	defb 020h,0c0h,010h,0c1h,020h,0c1h,040h,0c0h,0ebh,039h,011h,012h,074h,0fdh,0ddh,0a1h	; a207   ... .@..9..t...

; ----------------------------------------------------------------------
; DATOS pista_A217: pista de la partitura (sonido 63 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa217..0xa23a  (35 bytes)
DATA_pista_A217:
	defb 0feh,001h,0f8h,02bh,0e9h,006h,0eah,00fh,0ebh,03eh,011h,0d5h,091h,0ebh,02fh,0f5h	; a217  ...+.....>..../.
	defb 090h,090h,0d4h,070h,090h,020h,040h,010h,020h,040h,070h,020h,040h,020h,0d5h,070h	; a227  ...p. @. @p @ .p
	defb 0fdh,01fh,0a2h	; a237

; ----------------------------------------------------------------------
; DATOS pista_A23A: pista de la partitura (sonido 63 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa23a..0xa29f  (101 bytes)
DATA_pista_A23A:
	defb 0feh,001h,0f8h,013h,0e9h,006h,0eah,00dh,0ebh,038h,012h,0d2h,0f9h,04ch,0a2h,0fdh	; a23a  .........8...L..
	defb 03ch,0a2h,0f2h,00ah,0f1h,041h,09bh,090h,0b0h,0d1h,011h,023h,013h,0d2h,0b3h,073h	; a24a  <....A.....#...s
	defb 090h,0c1h,04ch,0f8h,00ch,090h,0c1h,04ch,0f8h,013h,0d2h,09bh,0d1h,010h,020h,040h	; a25a  ..L....L...... @
	defb 060h,073h,063h,073h,093h,060h,0c1h,04ch,0f8h,00ch,060h,0c1h,04ch,0e9h,006h,0f8h	; a26a  `scs.`.L..`.L...
	defb 013h,073h,070h,070h,060h,0c0h,070h,0c0h,060h,070h,0c0h,070h,0c1h,073h,070h,070h	; a27a  .spp`.p.`p.p.spp
	defb 060h,0c0h,070h,0c0h,060h,040h,0c0h,022h,070h,0c1h,09ch,0f8h,00ch,070h,0c1h,09ch	; a28a  `.p.`@."p....p..
	defb 0fbh,002h,077h,0a2h,0fah	; a29a

; ----------------------------------------------------------------------
; DATOS pista_A29F: pista de la partitura (sonido 63 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa29f..0xa301  (98 bytes)
DATA_pista_A29F:
	defb 0feh,001h,0f8h,013h,0e9h,006h,0eah,00dh,0ebh,038h,012h,0d2h,0f9h,0b1h,0a2h,0fdh	; a29f  .........8......
	defb 0a1h,0a2h,0f2h,00ah,0f1h,041h,04bh,040h,070h,091h,0b3h,093h,073h,023h,040h,0c1h	; a2af  .....AK@p...s#@.
	defb 01ch,0f8h,00ch,040h,0c1h,01ch,0f8h,013h,04bh,040h,090h,0b0h,0d1h,010h,023h,013h	; a2bf  ...@....K@....#.
	defb 023h,043h,020h,0c1h,01ch,0f8h,00ch,020h,0c1h,01ch,0f8h,013h,023h,020h,020h,020h	; a2cf  #C .... ....#   
	defb 0c0h,020h,0c0h,020h,020h,0c0h,020h,0c1h,023h,020h,020h,020h,0c0h,020h,0c0h,020h	; a2df  . .  . .#   . . 
	defb 000h,0c0h,0d2h,0b2h,0d1h,020h,0c1h,04ch,0f8h,00ch,020h,0c1h,04ch,0fbh,002h,0d9h	; a2ef  ..... .L.. .L...
	defb 0a2h,0fah	; a2ff

; ----------------------------------------------------------------------
; DATOS pista_A301: pista de la partitura (sonido 63 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa301..0xa348  (71 bytes)
DATA_pista_A301:
	defb 0feh,001h,0f8h,026h,0e9h,006h,0eah,00dh,0ebh,01fh,0f5h,0d5h,091h,090h,090h,0d3h	; a301  ...&............
	defb 070h,090h,020h,040h,010h,020h,040h,070h,020h,040h,020h,070h,0fbh,008h,00ch,0a3h	; a311  p. @. @p @ p....
	defb 0ebh,038h,012h,0d3h,0b3h,0b0h,0b0h,090h,0c0h,0b0h,0c0h,090h,0b0h,0c0h,0b0h,0c1h	; a321  .8..............
	defb 0b3h,0b0h,0b0h,090h,0c0h,0b0h,0c0h,090h,070h,0c0h,072h,0b0h,0c1h,0d2h,01ch,0cfh	; a331  ........p.r.....
	defb 0fbh,002h,024h,0a3h,0fdh,005h,0a3h	; a341

; ----------------------------------------------------------------------
; DATOS pista_A348: pista de la partitura (sonido 63 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa348..0xa36e  (38 bytes)
DATA_pista_A348:
	defb 0feh,001h,0e9h,006h,0eah,008h,0ebh,018h,012h,0d3h,0c0h,090h,070h,0c0h,0d2h,010h	; a348  ............p...
	defb 020h,0c0h,0d3h,070h,0fbh,002h,051h,0a3h,0c0h,090h,070h,0c0h,0d2h,010h,020h,0c0h	; a358   ..p..Q...p... .
	defb 0d3h,070h,0c7h,0fdh,04ah,0a3h	; a368

; ----------------------------------------------------------------------
; DATOS pista_A36E: pista de la partitura (sonido 64 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa36e..0xa37d  (15 bytes)
DATA_pista_A36E:
	defb 0feh,004h,0e9h,00ch,080h,000h,000h,000h,040h,000h,000h,080h,0fdh,072h,0a3h	; a36e  ........@....r.

; ----------------------------------------------------------------------
; DATOS pista_A37D: pista de la partitura (sonido 64 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa37d..0xa3f0  (115 bytes)
DATA_pista_A37D:
	defb 0feh,001h,0e9h,00ch,0eah,00bh,0ebh,021h,014h,0d2h,070h,070h,040h,040h,0b0h,0eah	; a37d  .......!..pp@@..
	defb 00ah,0b0h,0eah,009h,0b0h,0eah,008h,0b0h,0b0h,0b0h,0eah,00bh,040h,040h,070h,070h	; a38d  ............@@pp
	defb 0b0h,0b0h,0a0h,0a0h,050h,050h,020h,0eah,00ah,020h,0eah,009h,020h,0eah,008h,020h	; a39d  ....PP .. .. .. 
	defb 020h,020h,0eah,00bh,020h,020h,050h,050h,0a0h,0a0h,090h,090h,050h,050h,000h,0eah	; a3ad    ..  PP....PP..
	defb 00ah,000h,0eah,009h,000h,0eah,008h,000h,000h,000h,0eah,00bh,000h,000h,050h,050h	; a3bd  ..............PP
	defb 090h,090h,080h,080h,050h,050h,000h,0eah,00ah,000h,0eah,009h,000h,0eah,008h,000h	; a3cd  ....PP..........
	defb 000h,000h,000h,000h,0eah,00bh,020h,0eah,00ah,020h,0eah,009h,020h,0eah,008h,020h	; a3dd  ...... .. .. .. 
	defb 0fdh,07fh,0a3h	; a3ed

; ----------------------------------------------------------------------
; DATOS pista_A3F0: pista de la partitura (sonido 64 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa3f0..0xa45f  (111 bytes)
DATA_pista_A3F0:
	defb 0feh,001h,0eeh,002h,0e9h,00ch,0eah,009h,0ebh,021h,010h,0d2h,072h,070h,040h,040h	; a3f0  .........!..rp@@
	defb 0b0h,0eah,008h,0b0h,0eah,007h,0b0h,0eah,006h,0b0h,0b0h,0b0h,0eah,009h,040h,040h	; a400  ..............@@
	defb 070h,070h,0b0h,0b0h,0a0h,0a0h,050h,050h,020h,0eah,008h,020h,0eah,007h,020h,0eah	; a410  pp....PP .. .. .
	defb 006h,020h,020h,020h,0eah,009h,020h,020h,050h,050h,0a0h,0a0h,090h,090h,050h,050h	; a420  .   ..  PP....PP
	defb 000h,0eah,008h,000h,0eah,007h,000h,0eah,006h,000h,000h,000h,0eah,009h,000h,000h	; a430  ................
	defb 050h,050h,090h,090h,080h,080h,050h,050h,000h,0eah,008h,000h,0eah,007h,000h,0eah	; a440  PP....PP........
	defb 006h,000h,000h,000h,000h,000h,0eah,009h,020h,0eah,008h,020h,0fdh,0f4h,0a3h	; a450  ........ .. ...

; ----------------------------------------------------------------------
; DATOS pista_A45F: pista de la partitura (sonido 64 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa45f..0xa493  (52 bytes)
DATA_pista_A45F:
	defb 0feh,001h,0f8h,02bh,0e9h,00ch,0eah,00eh,0ebh,051h,015h,0d4h,006h,0d5h,070h,0d4h	; a45f  ...+.....Q....p.
	defb 000h,0d5h,070h,0d4h,005h,0d5h,076h,0d4h,020h,0d5h,070h,0c0h,074h,070h,0d4h,026h	; a46f  ..p...v. .p.tp.&
	defb 0d5h,090h,0d4h,020h,0d5h,090h,0d4h,025h,0d5h,056h,0d4h,000h,0d5h,050h,0c0h,054h	; a47f  ... ...%.V...P.T
	defb 050h,0fdh,06ah,0a4h	; a48f

; ----------------------------------------------------------------------
; DATOS pista_A493: pista de la partitura (sonido 64 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa493..0xa503  (112 bytes)
DATA_pista_A493:
	defb 0feh,001h,0f8h,015h,0e9h,00ch,0eah,00ch,0ebh,011h,015h,0d2h,0b6h,0f9h,0c6h,0a4h	; a493  ................
	defb 051h,0fbh,002h,09eh,0a4h,0f8h,00ch,0d2h,049h,0f9h,0dfh,0a4h,023h,0fbh,002h,0aah	; a4a3  Q.......I...#...
	defb 0a4h,0f8h,015h,0d2h,0b6h,0f9h,0c6h,0a4h,051h,0d2h,045h,077h,0f9h,0f0h,0a4h,051h	; a4b3  ........Q.Ew...Q
	defb 0fdh,0a8h,0a4h,0d1h,000h,0d2h,0b0h,070h,043h,040h,030h,023h,093h,072h,092h,071h	; a4c3  .......pC@0#.r.q
	defb 055h,000h,0d3h,095h,090h,0d2h,000h,050h,089h,081h,071h,0fah,041h,071h,0b1h,0a3h	; a4d3  U......P..q.Aq..
	defb 0d1h,093h,075h,090h,070h,055h,000h,0d2h,098h,0d1h,057h,003h,0fah,040h,030h,023h	; a4e3  ..u.pU....W..@0#
	defb 093h,072h,092h,071h,055h,000h,0d3h,095h,090h,0d2h,000h,050h,089h,081h,071h,0fah	; a4f3  .r.qU......P..q.

; ----------------------------------------------------------------------
; DATOS pista_A503: pista de la partitura (sonido 64 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa503..0xa537  (52 bytes)
DATA_pista_A503:
	defb 0feh,001h,0f8h,015h,0eeh,001h,0e9h,00ch,0eah,008h,0ebh,011h,010h,0d2h,0b7h,0f9h	; a503  ................
	defb 0c6h,0a4h,050h,0fbh,002h,010h,0a5h,0f8h,00ch,0d2h,04ah,0f9h,0dfh,0a4h,022h,0fbh	; a513  ..P.......J...".
	defb 002h,01ch,0a5h,0f8h,015h,0d2h,0b7h,0f9h,0c6h,0a4h,050h,0d2h,04eh,0f9h,0f0h,0a4h	; a523  ..........P.N...
	defb 050h,0fdh,01ah,0a5h	; a533

; ----------------------------------------------------------------------
; DATOS pista_A537: pista de la partitura (sonido 64 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa537..0xa5ab  (116 bytes)
DATA_pista_A537:
	defb 0feh,001h,0f8h,015h,0e9h,00ch,0eah,009h,0ebh,011h,015h,0d2h,076h,0f9h,06dh,0a5h	; a537  ............v.m.
	defb 021h,0fbh,002h,03bh,0a5h,0f8h,005h,0eah,007h,0d2h,009h,0f9h,085h,0a5h,083h,0fbh	; a547  !..;............
	defb 002h,04eh,0a5h,0f8h,015h,0eah,009h,0d2h,076h,0f9h,06dh,0a5h,021h,0d2h,002h,0f9h	; a557  .N......v.m.!...
	defb 095h,0a5h,021h,0fdh,04ch,0a5h,090h,070h,040h,003h,001h,0d3h,0a3h,0d2h,053h,042h	; a567  ..!.L..p@.....SB
	defb 052h,041h,025h,0d3h,090h,055h,050h,090h,0d2h,000h,059h,051h,041h,0fah,001h,041h	; a577  RA%..UP...YQA..A
	defb 041h,073h,0d1h,053h,025h,050h,020h,025h,0d2h,090h,058h,087h,083h,0fah,072h,0b7h	; a587  As.S%P %..X...r.
	defb 001h,0d3h,0a3h,0d2h,053h,042h,052h,041h,025h,0d3h,090h,055h,050h,090h,0d2h,000h	; a597  ....SBRA%..UP...
	defb 059h,051h,041h,0fah	; a5a7

; ----------------------------------------------------------------------
; DATOS pista_A5AB: pista de la partitura (sonido 64 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0xa5ab..0xa5de  (51 bytes)
DATA_pista_A5AB:
	defb 0feh,001h,0eeh,002h,0e9h,00ch,0eah,005h,0ebh,011h,010h,0d2h,077h,0f9h,06dh,0a5h	; a5ab  ............w.m.
	defb 020h,0fbh,002h,0afh,0a5h,0eah,004h,0d2h,00ah,0f9h,085h,0a5h,082h,0fbh,002h,0c0h	; a5bb   ...............
	defb 0a5h,0eah,005h,0d2h,076h,0f9h,06dh,0a5h,021h,0d2h,003h,0f9h,095h,0a5h,020h,0fdh	; a5cb  ....v.m.!..... .
	defb 0c0h,0a5h,0ffh	; a5db

; ----------------------------------------------------------------------
; DATOS pista_A5DE: pista de la partitura (sonido 70 canal 0, sonido 70 canal
;   1, sonido 70 canal 2, sonido 70 canal 3, sonido 70 canal 4, sonido 70
;   canal 5, sonido 70 canal 6, sonido 70 canal 7); hasta donde empieza la
;   pista siguiente: el final exacto lo dira el lector de la partitura, por
;   escribir
;   0xa5de..0xa5df  (1 bytes)

; ----------------------------------------------------------------------
; La pista de los ocho canales del sonido 70 es este unico 0xFF: el
; canal que la lee se suelta en el acto (0x64DB -> 0x681A). O sea que
; el sonido 70 no suena nada: sirve para callar los canales que gane.
; ----------------------------------------------------------------------
DATA_pista_A5DE:
	defb 0ffh	; a5de

; ======================================================================
; CODIGO 0xa5df..0xa81d  (574 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; EL MOTOR DEL COCHE 1. Lo llama p13 0x6470 con IX = E084 (el canal 3,
; el primero del SCC) cuando ese canal no lo ocupa ningun sonido de
; partitura y el bit 3 de E190 esta puesto. No lee ningun flujo: cada
; fotograma calcula el periodo desde las vueltas, el volumen desde
; E197 y la forma de onda desde el terreno.
; ----------------------------------------------------------------------
MOTOR_COCHE_1:		; IX = E084 (canal 3, SCC); desde p13 0x6470
	ld a,(0e190h)		;a5df   ; E190 lleva los bits de sonido de los dos coches, un nibble cada uno
	and 004h		;a5e2   ; bit 2 del nibble bajo: el coche 1 esta parado con la salida ya dada (p02 0x86D0)
	jp nz,AVISO_PARADO_1		;a5e4   ; parado: el canal deja de hacer de motor y pita (0xA698)
	ld a,(0e19dh)		;a5e7   ; E19D es el byte alto de E19C: tope de vueltas menos vueltas, con signo
	or a			;a5ea
	jp p,MOTOR_1_MAS_GRAVE		;a5eb   ; positivo = todavia por debajo del tope, y el periodo se alarga
	ld hl,00000h		;a5ee   ; negativo = pasado del tope: hace falta el valor absoluto
	ld de,(0e19ch)		;a5f1
	or a			;a5f5
	sbc hl,de		;a5f6   ; HL = 0 - E19C, o sea cuanto se pasa de vueltas
	ld a,h			;a5f8
	and 00fh		;a5f9   ; se mira el nibble bajo de H: a cero, el exceso cabe entero en L
	cp 000h		;a5fb
	jr z,L_A604		;a5fd   ; cabe: se usa tal cual
	ld de,000ffh		;a5ff   ; no cabe: se topa en 0xFF, que es todo lo que se deja subir el tono
	jr MOTOR_1_MAS_AGUDO		;a602
L_A604:
	ld h,a			;a604   ; DE = el exceso, ya en un byte
	ex de,hl			;a605
MOTOR_1_MAS_AGUDO:		; periodo = 0x300 - el exceso de vueltas
	ld hl,00300h		;a606   ; 0x300 es el periodo del motor del coche 1 justo en el tope de vueltas
	or a			;a609
	sbc hl,de		;a60a   ; menos periodo es mas agudo: pasarse de vueltas sube el tono
	jr MOTOR_1_ESCRIBE		;a60c
MOTOR_1_MAS_GRAVE:		; periodo = 0x300 + lo que falta para el tope
	ld hl,00300h		;a60e   ; por debajo del tope el periodo se alarga y el motor suena mas grave
	ld de,(0e19ch)		;a611
	add hl,de			;a615
	ld a,h			;a616
	and 0f0h		;a617   ; el periodo del SCC son 12 bits: lo que se sale hay que toparlo
	jr z,MOTOR_1_ESCRIBE		;a619
	ld hl,00fffh		;a61b   ; el periodo mas largo que admite el chip: el ralenti mas grave
MOTOR_1_ESCRIBE:		; +0D, +0A/+0B y la forma de onda segun el terreno
	ld (ix+00dh),002h		;a61e   ; +0D = 2 (tono, sin ruido); es un canal del SCC, la mezcla del PSG no le toca
	ld (ix+00ah),l		;a622   ; +0A/+0B = el periodo que el volcado de p13 0x6B8B le pasara al chip
	ld (ix+00bh),h		;a625
	ld a,(0e19bh)		;a628   ; E19B = 1 si el terreno bajo el coche es menor de 10 (p02 0x8A0C)
	or a			;a62b
	jr nz,MOTOR_1_FUERA		;a62c
	ld a,042h		;a62e   ; sobre asfalto: forma de onda 0x42 de la tabla p13 0x6F04
	call 06a20h		;a630   ; la misma rutina que ejecuta la orden 0xF8 de las partituras
	jr MOTOR_1_VOLUMEN		;a633
MOTOR_1_FUERA:		; fuera del asfalto: onda 0x44 y volumen fijo
	ld a,044h		;a635   ; fuera del asfalto suena la otra onda, la 0x44 (la ultima de la tabla)
	call 06a20h		;a637
	ld (ix+00ch),00fh		;a63a   ; y ahi el volumen no se negocia: el maximo, sin mirar E197
	jr MOTOR_1_FIN		;a63e
MOTOR_1_VOLUMEN:		; E197 -> (ix+0C), ocho tramos de 0x20
	ld a,(0e197h)		;a640   ; E197 = volumen del motor del coche 1, que calcula p02 0x877D
	cp 0f0h		;a643   ; ocho comparaciones de 0x20 en 0x20 reparten nueve volumenes, del 7 (E197 por debajo de 0x10) al 15 (de 0xF0 arriba)
	jr nc,L_A693		;a645
	cp 0d0h		;a647
	jr nc,L_A68D		;a649
	cp 0b0h		;a64b
	jr nc,L_A687		;a64d
	cp 090h		;a64f
	jr nc,L_A681		;a651
	cp 070h		;a653
	jr nc,L_A67B		;a655
	cp 050h		;a657
	jr nc,L_A675		;a659
	cp 030h		;a65b
	jr nc,L_A66F		;a65d
	cp 010h		;a65f
	jr nc,L_A669		;a661
	ld (ix+00ch),007h		;a663   ; por debajo de 0x10, el volumen mas bajo del motor: 7
	jr MOTOR_1_FIN		;a667
L_A669:
	ld (ix+00ch),008h		;a669
	jr MOTOR_1_FIN		;a66d
L_A66F:
	ld (ix+00ch),009h		;a66f
	jr MOTOR_1_FIN		;a673
L_A675:
	ld (ix+00ch),00ah		;a675
	jr MOTOR_1_FIN		;a679
L_A67B:
	ld (ix+00ch),00bh		;a67b
	jr MOTOR_1_FIN		;a67f
L_A681:
	ld (ix+00ch),00ch		;a681
	jr MOTOR_1_FIN		;a685
L_A687:
	ld (ix+00ch),00dh		;a687
	jr MOTOR_1_FIN		;a68b
L_A68D:
	ld (ix+00ch),00eh		;a68d
	jr MOTOR_1_FIN		;a691
L_A693:
	ld (ix+00ch),00fh		;a693   ; de 0xF0 arriba, 15: el motor a fondo
MOTOR_1_FIN:		; el ret al que van a parar todas las ramas
	ret			;a697

; ----------------------------------------------------------------------
; EL PITIDO DEL COCHE 1 PARADO. p02 0x86D0 pone el bit 2 de E190
; cuando el coche no se mueve ((iy+10,11) = 0) y la salida ya esta dada
; (E221 >= 7). Entonces el canal del motor toca esto: tres pitidos cada
; vez mas agudos (periodos 0x400, 0x380 y 0x340) separados por
; silencios, un paso por fotograma, ciclo de seis fotogramas.
; ----------------------------------------------------------------------
AVISO_PARADO_1:		; el pitido del coche 1 parado; el paso va en E195
	ld a,(0e195h)		;a698   ; E195 es el paso del ciclo, 0 a 5, y solo lo escribe esta pagina
	cp 005h		;a69b   ; la escalera prueba del 5 al 1; lo que no encaja es el paso 0
	jr z,AVISO_1_PASO_5		;a69d
	cp 004h		;a69f
	jr z,AVISO_1_PASO_4		;a6a1
	cp 003h		;a6a3
	jr z,AVISO_1_PASO_3		;a6a5
	cp 002h		;a6a7
	jr z,AVISO_1_PASO_2		;a6a9
	cp 001h		;a6ab
	jr z,AVISO_1_PASO_1		;a6ad
	ld hl,00400h		;a6af   ; paso 0: primer pitido, periodo 0x400, el mas grave de los tres
	ld a,001h		;a6b2
	ld (0e195h),a		;a6b4   ; y deja anotado el paso 1 para el fotograma siguiente
	jr AVISO_1_PITA		;a6b7
AVISO_1_PASO_1:		; silencio entre el primer pitido y el segundo
	ld a,002h		;a6b9   ; los pasos impares son los silencios: solo mueven E195
	ld (0e195h),a		;a6bb
	jr AVISO_1_CALLA		;a6be
AVISO_1_PASO_2:		; segundo pitido, 0x380
	ld hl,00380h		;a6c0   ; paso 2: segundo pitido, 0x380, un poco mas agudo que el primero
	ld a,003h		;a6c3
	ld (0e195h),a		;a6c5
	jr AVISO_1_PITA		;a6c8
AVISO_1_PASO_3:		; el segundo silencio
	ld a,004h		;a6ca   ; paso 3: el otro silencio
	ld (0e195h),a		;a6cc
	jr AVISO_1_CALLA		;a6cf
AVISO_1_PASO_4:		; tercer pitido, 0x340
	ld hl,00340h		;a6d1   ; paso 4: tercer pitido, 0x340, el mas agudo de los tres
	ld a,005h		;a6d4
	ld (0e195h),a		;a6d6
	jr AVISO_1_PITA		;a6d9
AVISO_1_PASO_5:		; se calla y vuelve al paso 0
	xor a			;a6db   ; paso 5: E195 a cero; el ciclo entero son seis fotogramas
	ld (0e195h),a		;a6dc
AVISO_1_CALLA:		; mezcla en tono pero volumen 0
	ld (ix+00dh),002h		;a6df   ; los silencios dejan la mezcla puesta...
	ld (ix+00ch),000h		;a6e3   ; ...y callan con el volumen a cero, sin tocar el periodo
	jr MOTOR_1_FIN		;a6e7
AVISO_1_PITA:		; mezcla, periodo, onda 4 y volumen 15
	ld (ix+00dh),002h		;a6e9   ; el pitido: mezcla en tono...
	ld (ix+00ah),l		;a6ed   ; ...el periodo que traiga el paso...
	ld (ix+00bh),h		;a6f0
	ld a,004h		;a6f3   ; ...la onda 4, que no es ninguna de las dos del motor...
	call 06a20h		;a6f5
	ld (ix+00ch),00fh		;a6f8   ; ...y el volumen al maximo
	jr MOTOR_1_FIN		;a6fc

; ----------------------------------------------------------------------
; EL MOTOR DEL COCHE 2. Lo llama p13 0x6494 con IX = E0B0 (el canal 4,
; el segundo del SCC) y el bit 7 de E190. Es el mismo codigo de 0xA5DF
; byte a byte con el otro juego de variables (E1A1/E1A2, E1A0, E198,
; E196 y el bit 6 en vez del 2); la unica diferencia de datos es el
; periodo de partida, 0x310 en vez de 0x300.
; ----------------------------------------------------------------------
MOTOR_COCHE_2:		; IX = E0B0 (canal 4, SCC); desde p13 0x6494
	ld a,(0e190h)		;a6fe   ; el mismo arranque que 0xA5DF pero mirando el nibble alto de E190
	and 040h		;a701   ; bit 6: el coche 2 esta parado con la salida ya dada
	jp nz,AVISO_PARADO_2		;a703   ; parado: el pitido de 0xA7B7
	ld a,(0e1a2h)		;a706   ; E1A1/E1A2 es para el coche 2 lo que E19C/E19D para el 1
	or a			;a709
	jp p,MOTOR_2_MAS_GRAVE		;a70a   ; positivo: por debajo del tope de vueltas
	ld hl,00000h		;a70d
	ld de,(0e1a1h)		;a710
	or a			;a714
	sbc hl,de		;a715   ; HL = 0 - E1A1: el exceso de vueltas
	ld a,h			;a717
	and 00fh		;a718   ; el mismo nibble bajo de H: a cero, el exceso cabe entero en L
	cp 000h		;a71a
	jr z,L_A723		;a71c
	ld de,000ffh		;a71e   ; topado en 0xFF
	jr MOTOR_2_MAS_AGUDO		;a721
L_A723:
	ld h,a			;a723
	ex de,hl			;a724
MOTOR_2_MAS_AGUDO:		; periodo = 0x310 - el exceso de vueltas
	ld hl,00310h		;a725   ; 0x310, y no 0x300: es el unico dato en que los dos motores se separan
	or a			;a728
	sbc hl,de		;a729   ; pasarse de vueltas acorta el periodo y sube el tono
	jr MOTOR_2_ESCRIBE		;a72b
MOTOR_2_MAS_GRAVE:		; periodo = 0x310 + lo que falta para el tope
	ld hl,00310h		;a72d   ; por debajo del tope, el periodo crece desde 0x310
	ld de,(0e1a1h)		;a730
	add hl,de			;a734
	ld a,h			;a735
	and 0f0h		;a736   ; los mismos 12 bits del SCC
	jr z,MOTOR_2_ESCRIBE		;a738
	ld hl,00fffh		;a73a   ; el tope grave
MOTOR_2_ESCRIBE:		; +0D, +0A/+0B y la forma de onda segun el terreno
	ld (ix+00dh),002h		;a73d   ; mezcla en tono para el canal 4
	ld (ix+00ah),l		;a741   ; el periodo calculado
	ld (ix+00bh),h		;a744
	ld a,(0e1a0h)		;a747   ; E1A0 = 1 si el terreno bajo el coche 2 es menor de 10 (p02 0x8A3E)
	or a			;a74a
	jr nz,MOTOR_2_FUERA		;a74b
	ld a,042h		;a74d   ; sobre asfalto, onda 0x42
	call 06a20h		;a74f
	jr MOTOR_2_VOLUMEN		;a752
MOTOR_2_FUERA:		; fuera del asfalto: onda 0x44 y volumen fijo
	ld a,044h		;a754   ; fuera del asfalto, onda 0x44
	call 06a20h		;a756
	ld (ix+00ch),00fh		;a759   ; y el volumen al maximo
	jr MOTOR_2_FIN		;a75d
MOTOR_2_VOLUMEN:		; E198 -> (ix+0C), ocho tramos de 0x20
	ld a,(0e198h)		;a75f   ; E198 = volumen del motor del coche 2 (p02 0x8792)
	cp 0f0h		;a762   ; la misma escalera de ocho comparaciones y nueve volumenes que en el coche 1
	jr nc,L_A7B2		;a764
	cp 0d0h		;a766
	jr nc,L_A7AC		;a768
	cp 0b0h		;a76a
	jr nc,L_A7A6		;a76c
	cp 090h		;a76e
	jr nc,L_A7A0		;a770
	cp 070h		;a772
	jr nc,L_A79A		;a774
	cp 050h		;a776
	jr nc,L_A794		;a778
	cp 030h		;a77a
	jr nc,L_A78E		;a77c
	cp 010h		;a77e
	jr nc,L_A788		;a780
	ld (ix+00ch),007h		;a782   ; el minimo, 7
	jr MOTOR_2_FIN		;a786
L_A788:
	ld (ix+00ch),008h		;a788
	jr MOTOR_2_FIN		;a78c
L_A78E:
	ld (ix+00ch),009h		;a78e
	jr MOTOR_2_FIN		;a792
L_A794:
	ld (ix+00ch),00ah		;a794
	jr MOTOR_2_FIN		;a798
L_A79A:
	ld (ix+00ch),00bh		;a79a
	jr MOTOR_2_FIN		;a79e
L_A7A0:
	ld (ix+00ch),00ch		;a7a0
	jr MOTOR_2_FIN		;a7a4
L_A7A6:
	ld (ix+00ch),00dh		;a7a6
	jr MOTOR_2_FIN		;a7aa
L_A7AC:
	ld (ix+00ch),00eh		;a7ac
	jr MOTOR_2_FIN		;a7b0
L_A7B2:
	ld (ix+00ch),00fh		;a7b2   ; el maximo, 15
MOTOR_2_FIN:		; el ret comun
	ret			;a7b6

; ----------------------------------------------------------------------
; EL PITIDO DEL COCHE 2 PARADO, calcado de 0xA698 con E196 de contador.
; ----------------------------------------------------------------------
AVISO_PARADO_2:		; el pitido del coche 2 parado; el paso va en E196
	ld a,(0e196h)		;a7b7   ; E196 es el paso del ciclo del coche 2
	cp 005h		;a7ba
	jr z,AVISO_2_PASO_5		;a7bc
	cp 004h		;a7be
	jr z,AVISO_2_PASO_4		;a7c0
	cp 003h		;a7c2
	jr z,AVISO_2_PASO_3		;a7c4
	cp 002h		;a7c6
	jr z,AVISO_2_PASO_2		;a7c8
	cp 001h		;a7ca
	jr z,AVISO_2_PASO_1		;a7cc
	ld hl,00400h		;a7ce   ; paso 0: primer pitido, 0x400
	ld a,001h		;a7d1
	ld (0e196h),a		;a7d3
	jr AVISO_2_PITA		;a7d6
AVISO_2_PASO_1:		; primer silencio
	ld a,002h		;a7d8   ; paso 1: silencio
	ld (0e196h),a		;a7da
	jr AVISO_2_CALLA		;a7dd
AVISO_2_PASO_2:		; segundo pitido, 0x380
	ld hl,00380h		;a7df   ; paso 2: 0x380
	ld a,003h		;a7e2
	ld (0e196h),a		;a7e4
	jr AVISO_2_PITA		;a7e7
AVISO_2_PASO_3:		; segundo silencio
	ld a,004h		;a7e9   ; paso 3: silencio
	ld (0e196h),a		;a7eb
	jr AVISO_2_CALLA		;a7ee
AVISO_2_PASO_4:		; tercer pitido, 0x340
	ld hl,00340h		;a7f0   ; paso 4: 0x340
	ld a,005h		;a7f3
	ld (0e196h),a		;a7f5
	jr AVISO_2_PITA		;a7f8
AVISO_2_PASO_5:		; se calla y vuelve al paso 0
	xor a			;a7fa   ; paso 5: E196 a cero y vuelta a empezar
	ld (0e196h),a		;a7fb
AVISO_2_CALLA:		; mezcla en tono pero volumen 0
	ld (ix+00dh),002h		;a7fe   ; la mezcla se queda puesta...
	ld (ix+00ch),000h		;a802   ; ...y el volumen a cero
	jr MOTOR_2_FIN		;a806
AVISO_2_PITA:		; mezcla, periodo, onda 4 y volumen 15
	ld (ix+00dh),002h		;a808   ; el pitido del coche 2, con la onda 4 y el volumen al maximo
	ld (ix+00ah),l		;a80c
	ld (ix+00bh),h		;a80f
	ld a,004h		;a812   ; la onda 4, la misma que el aviso del coche 1
	call 06a20h		;a814
	ld (ix+00ch),00fh		;a817
	jr MOTOR_2_FIN		;a81b

; ----------------------------------------------------------------------
; DATOS rle_pat_A81D: patrones RLE: 81 tiles desde el 1 (lista 0x6d6b)
;   0xa81d..0xaa4b  (558 bytes)
DATA_rle_pat_A81D:
	defb 002h,0ffh,083h,0e0h,0feh,0feh,003h,0e0h,002h,007h,083h,003h,073h,073h,003h,003h	; a81d  ............ss..
	defb 005h,080h,083h,09fh,080h,080h,005h,000h,081h,0e0h,005h,000h,085h,0fbh,082h,0fbh	; a82d  ................
	defb 00ah,0fah,003h,000h,085h,0efh,028h,0efh,008h,00fh,003h,000h,085h,0beh,020h,0a0h	; a83d  ......(....... .
	defb 020h,0beh,003h,000h,085h,0beh,0a0h,0beh,0a0h,0a0h,003h,000h,081h,0beh,003h,0a0h	; a84d   ...............
	defb 081h,0beh,003h,000h,085h,0fbh,088h,0f8h,088h,088h,003h,000h,081h,0ebh,003h,08ah	; a85d  ................
	defb 081h,08bh,003h,000h,085h,0e8h,02ch,02ah,029h,0e8h,003h,000h,005h,080h,005h,000h	; a86d  ......,*).......
	defb 081h,0ffh,004h,000h,004h,03ch,004h,000h,081h,0feh,004h,092h,003h,000h,085h,07ch	; a87d  .....<.........|
	defb 082h,0feh,082h,082h,003h,000h,085h,0c6h,06ch,038h,06ch,0c6h,003h,000h,085h,0fch	; a88d  ........l8l.....
	defb 082h,082h,0fch,080h,003h,000h,081h,0feh,003h,082h,081h,0feh,003h,000h,004h,092h	; a89d  ................
	defb 081h,0feh,003h,000h,085h,0feh,080h,0feh,080h,0feh,003h,000h,088h,0fch,082h,082h	; a8ad  ................
	defb 0fch,086h,000h,000h,0ffh,004h,080h,084h,000h,080h,0fch,003h,003h,000h,088h,070h	; a8bd  ...............p
	defb 088h,004h,001h,000h,080h,040h,040h,003h,020h,082h,000h,0ffh,004h,000h,002h,001h	; a8cd  .....@@. .......
	defb 086h,004h,0ffh,000h,000h,00fh,0f0h,003h,000h,094h,0ffh,000h,000h,0ffh,000h,01fh	; a8dd  ................
	defb 038h,000h,0ffh,000h,000h,0ffh,000h,0f8h,000h,000h,0ffh,000h,000h,0ffh,003h,000h	; a8ed  8...............
	defb 085h,03eh,0ffh,000h,000h,0ffh,003h,000h,085h,010h,0e0h,020h,040h,0c1h,003h,042h	; a8fd  .>......... @..B
	defb 003h,000h,088h,0f8h,004h,002h,072h,072h,040h,020h,020h,005h,010h,008h,001h,094h	; a90d  ......rr@  .....
	defb 030h,0c0h,000h,00fh,071h,081h,001h,0ffh,021h,021h,020h,020h,010h,010h,008h,0f6h	; a91d  0...q...!!  ....
	defb 024h,004h,088h,070h,003h,000h,081h,003h,004h,020h,002h,040h,081h,0bfh,007h,000h	; a92d  $..p..... .@....
	defb 082h,0ffh,000h,004h,038h,083h,01fh,000h,0ffh,005h,000h,084h,0f8h,000h,080h,07fh	; a93d  ....8...........
	defb 007h,000h,08dh,0ffh,042h,042h,041h,020h,020h,010h,008h,0f6h,072h,002h,004h,0f8h	; a94d  ....BBA  ...r...
	defb 003h,000h,081h,003h,003h,010h,08dh,020h,03fh,040h,080h,001h,0ffh,001h,001h,000h	; a95d  ....... ?@......
	defb 00fh,010h,03fh,020h,003h,001h,082h,03eh,0c0h,003h,001h,089h,0ffh,001h,001h,000h	; a96d  ..? ...>........
	defb 0ffh,000h,0ffh,000h,0fch,007h,001h,081h,0ffh,003h,001h,084h,080h,040h,0e0h,020h	; a97d  .............@. 
	defb 008h,001h,081h,0ffh,003h,001h,086h,01fh,020h,07fh,040h,0fch,000h,006h,001h,081h	; a98d  ........ .@.....
	defb 0ffh,003h,001h,08dh,0ffh,000h,0ffh,000h,0ffh,000h,003h,00ch,010h,023h,02ch,03fh	; a99d  .............#,?
	defb 0ffh,003h,001h,085h,0c0h,020h,0f0h,010h,0ffh,004h,001h,084h,018h,064h,082h,0ffh	; a9ad  ..... .......d..
	defb 005h,001h,085h,000h,001h,0ffh,000h,007h,005h,004h,089h,0ffh,001h,080h,040h,020h	; a9bd  ..............@ 
	defb 01fh,000h,000h,0ffh,003h,001h,085h,000h,0f0h,00fh,000h,0ffh,004h,001h,084h,000h	; a9cd  ................
	defb 0e0h,01fh,0ffh,005h,001h,08bh,000h,0c0h,0ffh,001h,001h,000h,000h,001h,006h,008h	; a9dd  ................
	defb 0ffh,004h,000h,084h,0ffh,003h,000h,0ffh,003h,001h,002h,000h,08ch,003h,00ch,001h	; a9ed  ................
	defb 006h,008h,010h,010h,0a0h,020h,021h,001h,000h,006h,001h,004h,000h,085h,0ffh,000h	; a9fd  ..... !.........
	defb 000h,0ffh,0ffh,006h,001h,082h,000h,0ffh,005h,001h,002h,000h,081h,0ffh,007h,000h	; aa0d  ................
	defb 081h,01fh,007h,001h,081h,000h,007h,001h,081h,07fh,007h,001h,002h,000h,081h,0ffh	; aa1d  ................
	defb 003h,000h,085h,0ffh,000h,001h,001h,0fdh,003h,001h,083h,0fdh,001h,0ffh,003h,000h	; aa2d  ................
	defb 085h,0ffh,000h,000h,0ffh,0fdh,003h,001h,084h,0fdh,001h,001h,0fdh,000h	; aa3d  ..............

; ----------------------------------------------------------------------
; DATOS rle_pat_AA4B: patrones RLE: 15 tiles desde el 97 (lista 0x6d6b)
;   0xaa4b..0xaaad  (98 bytes)
DATA_rle_pat_AA4B:
	defb 004h,000h,084h,001h,003h,004h,005h,004h,000h,085h,0f8h,00ch,00ah,08ah,07fh,003h	; aa4b  ................
	defb 050h,081h,05fh,003h,050h,089h,0ffh,007h,008h,008h,0d0h,010h,03fh,020h,003h,007h	; aa5b  P._.P.......? ..
	defb 005h,090h,0cah,0aah,0a2h,0b8h,0a6h,0a1h,0a0h,0bfh,050h,000h,07fh,083h,07ch,083h	; aa6b  ..........P...|.
	defb 070h,0ffh,006h,005h,085h,003h,001h,000h,002h,003h,003h,002h,085h,003h,0ffh,0a0h	; aa7b  p...............
	defb 0a0h,0ffh,003h,000h,085h,0ffh,080h,001h,006h,0ffh,003h,000h,08bh,0ffh,000h,040h	; aa8b  ...............@
	defb 040h,0e0h,020h,020h,010h,0f0h,00fh,0ffh,00fh,001h,082h,040h,080h,004h,000h,002h	; aa9b  @.  .......@....
	defb 080h,000h	; aaab

; ----------------------------------------------------------------------
; DATOS rle_pat_AAAD: patrones RLE: 1 tiles desde el 113 (lista 0x6d6b)
;   0xaaad..0xaab3  (6 bytes)
DATA_rle_pat_AAAD:
	defb 006h,001h,082h,0ffh,000h,000h	; aaad

; ----------------------------------------------------------------------
; DATOS rle_pat_AAB3: patrones RLE: 38 tiles desde el 0 (lista 0x6d6b)
;   0xaab3..0xaba5  (242 bytes)
DATA_rle_pat_AAB3:
	defb 008h,0ffh,002h,000h,082h,018h,028h,003h,008h,003h,000h,085h,07ch,002h,03eh,040h	; aab3  ......(.....|.>@
	defb 07eh,003h,000h,081h,07eh,003h,042h,081h,07eh,003h,000h,002h,082h,083h,0feh,082h	; aac3  ~...~.B.~.......
	defb 082h,003h,000h,085h,0fch,082h,082h,0fch,080h,003h,000h,085h,0fch,082h,082h,0fch	; aad3  ................
	defb 086h,003h,000h,081h,0feh,004h,092h,003h,000h,004h,03ch,004h,000h,005h,010h,003h	; aae3  ..........<.....
	defb 000h,085h,0c2h,0a2h,092h,08ah,086h,003h,000h,004h,092h,081h,0feh,003h,000h,085h	; aaf3  ................
	defb 0feh,080h,0feh,080h,0feh,003h,000h,085h,0feh,080h,0beh,082h,0feh,003h,000h,081h	; ab03  ................
	defb 0feh,004h,010h,003h,000h,085h,07eh,040h,07ch,002h,07ch,003h,000h,085h,00eh,012h	; ab13  ......~@|.|.....
	defb 022h,07eh,002h,003h,000h,085h,086h,098h,0e0h,098h,086h,005h,000h,081h,07eh,005h	; ab23  "~............~.
	defb 000h,085h,07eh,042h,07eh,002h,07eh,006h,000h,002h,018h,003h,000h,085h,0feh,080h	; ab33  ..~B~.~.........
	defb 0feh,002h,0feh,003h,000h,081h,07eh,003h,080h,082h,07eh,000h,008h,040h,008h,001h	; ab43  ......~...~..@..
	defb 082h,004h,007h,004h,006h,082h,007h,004h,008h,020h,008h,082h,082h,000h,0ffh,004h	; ab53  ......... ......
	defb 000h,096h,0ffh,000h,020h,03fh,010h,00fh,000h,001h,001h,0ffh,000h,0ffh,000h,0ffh	; ab63  .... ?..........
	defb 000h,001h,001h,0ffh,020h,0e0h,040h,080h,003h,001h,085h,0ffh,040h,07fh,020h,01fh	; ab73  .... .@.....@. .
	defb 003h,001h,085h,0ffh,000h,0ffh,000h,0ffh,003h,001h,085h,0ffh,010h,0f0h,020h,0c0h	; ab83  .............. .
	defb 003h,001h,082h,0ffh,07fh,006h,001h,081h,07fh,007h,000h,081h,0ffh,007h,080h,081h	; ab93  ................
	defb 0ffh,000h	; aba3

; ----------------------------------------------------------------------
; DATOS rle_pat_ABA5: patrones RLE: 27 tiles desde el 65 (lista 0x6d6b)
;   0xaba5..0xac54  (175 bytes)
DATA_rle_pat_ABA5:
	defb 081h,07fh,007h,001h,006h,020h,082h,03fh,010h,006h,000h,082h,0ffh,000h,006h,020h	; aba5  ..... .?....... 
	defb 083h,0e0h,040h,00fh,005h,000h,08bh,001h,002h,0ffh,0f8h,038h,024h,062h,0a1h,020h	; abb5  ..@........8$b. 
	defb 020h,080h,005h,000h,083h,080h,040h,0ffh,007h,000h,0a0h,0c0h,020h,010h,008h,004h	; abc5   .....@..... ...
	defb 002h,001h,000h,040h,040h,07fh,020h,01fh,003h,006h,0cch,000h,000h,0ffh,000h,0ffh	; abd5  ...@@. .........
	defb 0c0h,060h,030h,010h,010h,0f0h,020h,0c0h,000h,0ffh,082h,006h,010h,082h,011h,01eh	; abe5  .`0... .........
	defb 005h,001h,08bh,00fh,0f0h,000h,004h,008h,010h,020h,03fh,0c0h,000h,000h,003h,020h	; abf5  ......... ?.... 
	defb 082h,0ffh,080h,003h,000h,088h,020h,010h,008h,0ffh,000h,000h,001h,006h,003h,001h	; ac05  ...... .........
	defb 084h,0ffh,000h,000h,0ffh,006h,000h,083h,003h,0fch,004h,005h,000h,08eh,0ffh,000h	; ac15  ................
	defb 000h,030h,00ch,003h,002h,004h,0f8h,000h,000h,018h,00eh,0ffh,005h,000h,093h,0ffh	; ac25  .0..............
	defb 001h,001h,000h,01fh,01fh,010h,010h,0ffh,001h,001h,000h,0ffh,0ffh,001h,001h,0ffh	; ac35  ................
	defb 001h,001h,003h,000h,083h,0ffh,001h,0feh,007h,001h,081h,0ffh,007h,001h,000h	; ac45  ...............

; ----------------------------------------------------------------------
; DATOS rle_pat_AC54: patrones RLE: 2 tiles desde el 94 (lista 0x6d6b)
;   0xac54..0xac59  (5 bytes)
DATA_rle_pat_AC54:
	defb 008h,080h,008h,010h,000h	; ac54

; ----------------------------------------------------------------------
; DATOS rle_col_AC59: colores RLE: 81 tiles desde el 1 (lista 0x6d6b)
;   0xac59..0xacaf  (86 bytes)
DATA_rle_col_AC59:
	defb 072h,0e0h,006h,0f0h,07fh,0e0h,07fh,0e0h,081h,0e0h,004h,0c0h,00ah,0e0h,006h,0c0h	; ac59  r...............
	defb 006h,0e0h,00bh,0c0h,005h,0e0h,00bh,0c0h,006h,0e0h,00ah,0c0h,004h,0e0h,081h,0c0h	; ac69  ................
	defb 007h,0e0h,004h,0c0h,004h,0e0h,005h,0c0h,003h,0e0h,007h,0c0h,082h,0e0h,0c0h,007h	; ac79  ................
	defb 0e0h,002h,0c0h,006h,0e0h,005h,0c0h,003h,0e0h,006h,0c0h,002h,0e0h,007h,0c0h,081h	; ac89  ................
	defb 0e0h,005h,0c0h,003h,0e0h,081h,0c0h,007h,0e0h,004h,0c0h,004h,0e0h,081h,0ech,007h	; ac99  ................
	defb 0e0h,081h,0ech,05fh,0c0h,000h	; aca9

; ----------------------------------------------------------------------
; DATOS rle_col_ACAF: colores RLE: 15 tiles desde el 97 (lista 0x6d6b)
;   0xacaf..0xacb2  (3 bytes)
DATA_rle_col_ACAF:
	defb 078h,0c0h,000h	; acaf

; ----------------------------------------------------------------------
; DATOS rle_col_ACB2: colores RLE: 1 tiles desde el 113 (lista 0x6d6b)
;   0xacb2..0xacb5  (3 bytes)
DATA_rle_col_ACB2:
	defb 008h,0e0h,000h	; acb2

; ----------------------------------------------------------------------
; DATOS rle_col_ACB5: colores RLE: 38 tiles desde el 0 (lista 0x6d6b)
;   0xacb5..0xacd6  (33 bytes)
DATA_rle_col_ACB5:
	defb 008h,000h,038h,0e0h,008h,0f0h,07fh,0e0h,026h,0e0h,003h,0c0h,005h,0e0h,003h,0c0h	; acb5  ..8.....&.......
	defb 004h,0e0h,004h,0c0h,004h,0e0h,004h,0c0h,004h,0e0h,004h,0c0h,004h,0e0h,01ch,0c0h	; acc5  ................
	defb 000h	; acd5

; ----------------------------------------------------------------------
; DATOS rle_col_ACD6: colores RLE: 27 tiles desde el 65 (lista 0x6d6b)
;   0xacd6..0xacf1  (27 bytes)
DATA_rle_col_ACD6:
	defb 008h,0c0h,07fh,0e0h,029h,0e0h,004h,0c0h,004h,0e0h,004h,0c0h,004h,0e0h,006h,0c0h	; acd6  ....)...........
	defb 002h,0e0h,081h,0c0h,006h,0e0h,081h,0ech,008h,0c0h,000h	; ace6  ...........

; ----------------------------------------------------------------------
; DATOS rle_col_ACF1: colores RLE: 2 tiles desde el 94 (lista 0x6d6b)
;   0xacf1..0xacf6  (5 bytes)
DATA_rle_col_ACF1:
	defb 008h,0c0h,008h,0e0h,000h	; acf1

; ----------------------------------------------------------------------
; DATOS rle_pat_ACF6: patrones RLE: 1 tiles desde el 255 (lista 0x6dae)
;   0xacf6..0xacf9  (3 bytes)
DATA_rle_pat_ACF6:
	defb 008h,0ffh,000h	; acf6

; ----------------------------------------------------------------------
; DATOS rle_col_ACF9: colores RLE: 1 tiles desde el 255 (lista 0x6dae)
;   0xacf9..0xacfc  (3 bytes)
DATA_rle_col_ACF9:
	defb 008h,000h,000h	; acf9

; ----------------------------------------------------------------------
; DATOS rle_pat_ACFC: patrones RLE: 44 tiles desde el 1 (lista 0x6dbc)
;   0xacfc..0xae0f  (275 bytes)
DATA_rle_pat_ACFC:
	defb 008h,000h,008h,0ffh,004h,0feh,00ah,0ffh,08dh,03fh,0bfh,000h,000h,03fh,0ffh,0b0h	; acfc  .........?...?..
	defb 080h,04eh,060h,0dfh,0dfh,02fh,004h,00fh,08bh,02fh,07eh,07dh,079h,0f3h,0f7h,0e7h	; ad0c  .N`../.../~}y...
	defb 08fh,080h,0e4h,0e3h,003h,0ffh,096h,0fch,080h,000h,0c0h,0c0h,080h,080h,001h,003h	; ad1c  ................
	defb 006h,039h,078h,07fh,0feh,0f9h,0e7h,09fh,07fh,0ffh,0dfh,0bfh,07fh,005h,0ffh,085h	; ad2c  .9x.............
	defb 003h,0fch,080h,007h,03fh,003h,0ffh,082h,0c7h,03fh,00bh,0ffh,087h,0fch,0f0h,0c0h	; ad3c  ....?....?......
	defb 0ffh,0fch,0f0h,0c0h,008h,000h,084h,003h,00fh,03eh,0feh,003h,0ffh,081h,080h,006h	; ad4c  .........>......
	defb 000h,087h,003h,00fh,01fh,03fh,07fh,0feh,0e0h,007h,000h,088h,0fch,0f8h,0f0h,0e0h	; ad5c  .....?..........
	defb 0c0h,0c0h,080h,080h,006h,0ffh,08ah,000h,0ffh,01fh,0ffh,0fch,0f0h,0c0h,080h,000h	; ad6c  ................
	defb 000h,004h,0ffh,086h,0feh,001h,0ffh,0ffh,0f0h,00fh,006h,000h,004h,0ffh,088h,003h	; ad7c  ................
	defb 0fch,0ffh,0ffh,000h,000h,0c0h,0c0h,003h,0f0h,087h,0fch,080h,080h,00fh,0f0h,000h	; ad8c  ................
	defb 007h,007h,0f8h,003h,0fch,002h,0feh,082h,07fh,03fh,004h,000h,08dh,007h,003h,001h	; ad9c  .........?......
	defb 0c0h,0e0h,020h,020h,060h,0feh,0e0h,000h,000h,007h,003h,000h,085h,0ffh,000h,000h	; adac  ..  `...........
	defb 07dh,07dh,003h,07eh,003h,000h,08bh,03fh,0c0h,000h,000h,0ffh,003h,01fh,0ffh,000h	; adbc  }}.~...?........
	defb 000h,007h,003h,0ffh,084h,0fch,080h,000h,01fh,003h,0ffh,081h,080h,003h,000h,08ch	; adcc  ................
	defb 0f0h,0feh,0ffh,0ffh,001h,003h,007h,007h,00fh,00fh,01fh,01fh,003h,03fh,004h,07fh	; addc  .............?..
	defb 002h,000h,007h,001h,088h,0ffh,0f8h,0e6h,0e9h,0d0h,050h,068h,060h,003h,001h,008h	; adec  ..........Ph`...
	defb 002h,083h,003h,000h,000h,007h,001h,003h,000h,088h,004h,008h,030h,0c0h,080h,000h	; adfc  ............0...
	defb 010h,060h,000h	; ae0c

; ----------------------------------------------------------------------
; DATOS rle_pat_AE0F: patrones RLE: 6 tiles desde el 45 (lista 0x6dc3)
;   0xae0f..0xae31  (34 bytes)
DATA_rle_pat_AE0F:
	defb 086h,0feh,0fch,0f8h,0f8h,0f0h,0f0h,003h,0e0h,004h,0c0h,005h,080h,00ch,000h,08ah	; ae0f  ................
	defb 007h,07fh,001h,003h,007h,00fh,01fh,01fh,03fh,03fh,004h,07fh,084h,03bh,011h,000h	; ae1f  ........??...;..
	defb 000h,000h	; ae2f

; ----------------------------------------------------------------------
; DATOS rle_pat_AE31: patrones RLE: 26 tiles desde el 57 (lista 0x6dc3)
;   0xae31..0xaebd  (140 bytes)
DATA_rle_pat_AE31:
	defb 006h,000h,08dh,0ffh,000h,0ffh,0ffh,000h,0ffh,0ffh,0bfh,017h,002h,0ffh,0ffh,000h	; ae31  ................
	defb 003h,0ffh,084h,0bdh,018h,077h,022h,006h,000h,002h,0ffh,083h,07fh,04fh,007h,003h	; ae41  .....w"......O..
	defb 000h,003h,0ffh,088h,0fdh,0e8h,040h,000h,000h,0ffh,0ffh,000h,005h,0ffh,006h,000h	; ae51  ......@.........
	defb 002h,0ffh,081h,040h,008h,000h,086h,002h,000h,010h,000h,000h,080h,006h,000h,081h	; ae61  ...@............
	defb 040h,008h,000h,083h,004h,000h,020h,00dh,000h,089h,010h,000h,010h,000h,020h,000h	; ae71  @..... ....... .
	defb 000h,040h,0c0h,003h,000h,002h,003h,002h,006h,004h,000h,002h,018h,002h,030h,081h	; ae81  .@............0.
	defb 070h,006h,000h,083h,007h,00fh,01eh,006h,000h,083h,00fh,000h,03ch,005h,000h,085h	; ae91  p...........<...
	defb 080h,000h,080h,000h,080h,003h,000h,081h,080h,006h,000h,081h,080h,008h,000h,083h	; aea1  ................
	defb 080h,000h,080h,005h,000h,081h,080h,009h,000h,008h,0ffh,000h	; aeb1  ............

; ----------------------------------------------------------------------
; DATOS rle_pat_AEBD: patrones RLE: 70 tiles desde el 80 (lista 0x6dd6)
;   0xaebd..0xb087  (458 bytes)
DATA_rle_pat_AEBD:
	defb 018h,0ffh,085h,003h,007h,007h,00fh,00fh,003h,01fh,005h,03fh,08bh,01fh,00fh,007h	; aebd  ...........?....
	defb 0f0h,0c0h,0c0h,080h,080h,0e0h,0c1h,086h,005h,03fh,083h,07fh,03fh,03fh,005h,0f8h	; aecd  .........?..??..
	defb 002h,0f0h,081h,0e0h,003h,0c0h,004h,0e0h,093h,0c0h,0e0h,078h,084h,006h,033h,043h	; aedd  ...........x..3C
	defb 08fh,01fh,08ch,088h,080h,06eh,07dh,07bh,07fh,03eh,0ffh,0ffh,003h,07fh,003h,03fh	; aeed  .....n}{.>.....?
	defb 082h,0fch,0feh,006h,0ffh,003h,000h,085h,080h,0c0h,0e0h,0f0h,0f8h,005h,0ffh,083h	; aefd  ................
	defb 01fh,007h,003h,003h,01fh,003h,00fh,002h,007h,006h,0ffh,082h,0f8h,0e0h,004h,0ffh	; af0d  ................
	defb 086h,0feh,0fch,0fch,0f8h,0c0h,080h,006h,000h,002h,0f8h,005h,0f0h,089h,0f8h,0c0h	; af1d  ................
	defb 080h,080h,0feh,0f0h,0c0h,080h,080h,005h,000h,003h,080h,081h,0feh,003h,0fch,002h	; af2d  ................
	defb 0f8h,002h,0f0h,004h,000h,084h,003h,00fh,03bh,0f7h,008h,0ffh,085h,0e1h,0e7h,0cfh	; af3d  ........;.......
	defb 01fh,03fh,003h,0ffh,085h,0f7h,0afh,0afh,06fh,04fh,003h,01fh,002h,0fdh,085h,0fbh	; af4d  .?......oO......
	defb 0fah,0fah,0f8h,0f8h,007h,000h,08ah,0c0h,0f0h,0f8h,0fch,0feh,03eh,00fh,003h,001h	; af5d  ............>...
	defb 000h,003h,07fh,005h,03fh,002h,0ffh,005h,0feh,006h,0fch,003h,0feh,003h,03fh,003h	; af6d  ....?.........?.
	defb 07fh,002h,0ffh,0e8h,076h,0ceh,01ch,0fch,0f8h,0e0h,007h,0ffh,000h,001h,002h,005h	; af7d  ....v...........
	defb 00ah,015h,008h,017h,02ah,055h,0aah,055h,0fah,0ffh,01fh,00fh,000h,040h,0a0h,050h	; af8d  ....*U.U.....@.P
	defb 0a8h,050h,0a8h,0d4h,008h,010h,03ch,01eh,0bfh,01fh,0afh,05fh,00fh,00eh,01eh,03ch	; af9d  .P....<...._...<
	defb 0fch,0fdh,0fdh,0b9h,008h,004h,012h,004h,002h,004h,0cah,0f4h,02eh,010h,029h,010h	; afad  ..............).
	defb 008h,017h,00bh,007h,062h,0e2h,0feh,007h,079h,004h,0c0h,075h,0f8h,0f0h,068h,010h	; afbd  ....b...y..u..h.
	defb 000h,010h,0a0h,050h,02bh,005h,022h,010h,028h,014h,08ah,0d5h,082h,0c1h,0f2h,0e4h	; afcd  ...P+.".(.......
	defb 000h,000h,001h,087h,090h,030h,030h,070h,0f8h,0f8h,0e0h,080h,007h,000h,081h,0f8h	; afdd  .....00p........
	defb 003h,000h,088h,0e0h,0f0h,0f8h,0fch,0fch,0cah,0e0h,060h,005h,0e0h,004h,01fh,002h	; afed  ..........`.....
	defb 00fh,082h,007h,0feh,004h,007h,084h,03fh,07fh,0efh,09fh,003h,007h,002h,0ffh,097h	; affd  .......?........
	defb 0c3h,0feh,0fdh,01dh,01eh,00fh,00fh,007h,00ch,03eh,0ffh,0e0h,0f0h,0f0h,0fch,003h	; b00d  .........>......
	defb 007h,007h,01fh,000h,0ffh,000h,000h,003h,0c0h,082h,080h,030h,004h,000h,003h,00fh	; b01d  ...........0....
	defb 002h,03fh,002h,07fh,081h,0f8h,003h,0f0h,008h,0fch,08bh,0dch,0eeh,077h,03bh,0dfh	; b02d  .?...........w;.
	defb 0efh,07fh,03fh,01fh,060h,0fch,004h,0ffh,088h,00eh,0feh,067h,033h,019h,0fch,0f0h	; b03d  ..?.`......g3...
	defb 0c0h,003h,000h,08eh,020h,0f0h,0f8h,0fch,0feh,0ffh,019h,007h,01fh,00fh,097h,097h	; b04d  .... ...........
	defb 01bh,01dh,005h,0ffh,092h,0fch,0f0h,0c0h,0ffh,0fch,0f0h,0c0h,00ch,067h,073h,039h	; b05d  .............gs9
	defb 0fch,001h,07fh,0f8h,01fh,03fh,07eh,004h,000h,085h,001h,003h,007h,00fh,01fh,006h	; b06d  .....?~.........
	defb 07fh,085h,01eh,021h,021h,01eh,0c0h,005h,000h,000h	; b07d  ...!!.....

; ----------------------------------------------------------------------
; DATOS rle_pat_B087: patrones RLE: 72 tiles desde el 150 (lista 0x6de3)
;   0xb087..0xb29e  (535 bytes)
DATA_rle_pat_B087:
	defb 0e9h,055h,0aah,055h,0aah,055h,0aah,055h,0aah,050h,0a8h,050h,0a8h,050h,0a8h,050h	; b087  .U.U.U.U.P.P.P.P
	defb 0a8h,015h,00ah,015h,00ah,015h,00ah,015h,00ah,055h,0aah,055h,0aah,050h,080h,003h	; b097  .........U.U.P..
	defb 003h,055h,0aah,055h,0aah,005h,046h,08ch,0cch,050h,0a1h,055h,0a5h,055h,0a4h,052h	; b0a7  .U.U..F..P.U.U.R
	defb 0a8h,015h,00ah,025h,02ah,024h,048h,010h,020h,054h,0a8h,050h,0a8h,050h,0a0h,050h	; b0b7  ...%*$H. T.P.P.P
	defb 0a2h,015h,00ah,005h,002h,005h,002h,001h,000h,055h,02ah,055h,02ah,055h,02ah,055h	; b0c7  .........U*U*U*U
	defb 02ah,052h,0a0h,050h,0a0h,050h,0a8h,050h,0a8h,055h,0aah,055h,02ah,055h,02ah,055h	; b0d7  *R.P.P.P.U.U*U*U
	defb 02ah,050h,0a8h,051h,0a9h,051h,0a9h,050h,0a0h,013h,004h,01fh,003h,03fh,003h,0f8h	; b0e7  *P.Q.Q.P.....?..
	defb 005h,0f0h,081h,07fh,007h,0ffh,090h,055h,0aah,055h,0aah,055h,00ah,0c5h,0f2h,054h	; b0f7  .......U.U.U...T
	defb 0aah,054h,0aah,054h,0aah,054h,0a9h,007h,0feh,089h,0fdh,055h,0a9h,055h,0a9h,053h	; b107  .T.T.T.....U.U.S
	defb 0abh,053h,0abh,004h,0fdh,004h,0fbh,002h,003h,003h,007h,088h,00fh,007h,0f3h,055h	; b117  .S.............U
	defb 0a0h,000h,00fh,003h,005h,000h,088h,070h,07fh,07fh,0ffh,083h,0b1h,008h,03ch,004h	; b127  .......p......<.
	defb 0feh,092h,0c0h,088h,0c1h,081h,0f9h,0f3h,0ffh,0fdh,0fbh,0f1h,080h,080h,09fh,08fh	; b137  ................
	defb 0bfh,09eh,0deh,08dh,005h,000h,093h,001h,007h,00fh,080h,004h,020h,070h,0f8h,0fch	; b147  ............ p..
	defb 0fch,0ffh,072h,063h,068h,029h,034h,097h,08eh,087h,005h,000h,08fh,007h,00fh,01ch	; b157  ..rch)4.........
	defb 000h,004h,004h,01eh,0feh,0feh,0ffh,03ch,000h,00eh,010h,020h,003h,03fh,085h,01eh	; b167  .......<... .?..
	defb 0f0h,066h,060h,0f0h,003h,0ffh,084h,007h,01bh,01eh,01ch,004h,03fh,09bh,01fh,0dbh	; b177  .f`.........?...
	defb 010h,030h,0fbh,0fbh,0fdh,0cdh,001h,098h,09dh,08ch,00eh,007h,003h,001h,000h,089h	; b187  .0..............
	defb 0f9h,003h,077h,0feh,09eh,0fch,071h,001h,001h,003h,003h,003h,007h,085h,083h,0c3h	; b197  ..w...q.........
	defb 077h,03fh,03fh,003h,0ffh,002h,07fh,08fh,0bdh,0b9h,09ch,00ch,002h,000h,0f4h,0f8h	; b1a7  w??.............
	defb 0f8h,0f4h,0f4h,0e2h,062h,000h,07fh,004h,0ffh,08eh,07fh,07eh,07eh,000h,078h,04fh	; b1b7  ....b......~~.xO
	defb 040h,0c6h,08ch,099h,083h,010h,010h,0f0h,005h,000h,002h,03fh,002h,01fh,0ebh,007h	; b1c7  @..........?....
	defb 07fh,07fh,07eh,055h,0aah,015h,08ah,0c5h,022h,001h,070h,009h,0e2h,002h,0c4h,004h	; b1d7  ..~U....".p.....
	defb 0c9h,011h,0e3h,011h,009h,048h,04ch,0c4h,0c4h,0c0h,080h,0efh,0f5h,0f2h,0e2h,081h	; b1e7  .....HL.........
	defb 081h,00eh,01eh,01fh,01eh,00eh,007h,001h,008h,00fh,00fh,054h,0aah,055h,0aah,054h	; b1f7  ...........T.U.T
	defb 0aah,054h,001h,0fdh,0fdh,0ffh,0ffh,0feh,0feh,0ffh,0ffh,0e0h,0fch,0feh,0feh,07fh	; b207  .T..............
	defb 01fh,007h,007h,03fh,03bh,019h,00ch,006h,003h,001h,0ffh,03eh,01fh,08fh,0c3h,0e0h	; b217  ...?;......>....
	defb 070h,038h,008h,001h,000h,080h,0f8h,008h,0c8h,098h,010h,0f0h,01fh,001h,0c0h,0c0h	; b227  p8..............
	defb 0e0h,070h,078h,050h,020h,050h,020h,040h,020h,000h,004h,060h,002h,070h,003h,0f8h	; b237  .pxP P @ ..`.p..
	defb 081h,0f0h,004h,0e0h,0b5h,0e3h,08fh,03fh,03ch,000h,0bah,044h,0fch,07ch,000h,0f0h	; b247  .......?<..D.|..
	defb 00fh,00fh,01fh,03fh,00fh,07dh,0beh,0dfh,0f1h,0f0h,0f1h,0f2h,0fdh,0fch,0ffh,033h	; b257  ...?.}.........3
	defb 083h,0c0h,0c0h,0e0h,0f0h,0f8h,078h,098h,0c3h,007h,007h,00fh,01eh,03eh,03ch,039h	; b267  ......x......><9
	defb 050h,0a0h,040h,0a0h,040h,0a0h,007h,03fh,080h,080h,004h,001h,002h,003h,004h,000h	; b277  P.@.@..?........
	defb 08dh,008h,03ch,03eh,0dfh,079h,0bch,0bch,0deh,0deh,0ceh,0e6h,0e4h,038h,003h,000h	; b287  ..<>.y.......8..
	defb 002h,0feh,002h,0fch,008h,0ffh,000h	; b297

; ----------------------------------------------------------------------
; DATOS rle_col_B29E: colores RLE: 44 tiles desde el 1 (lista 0x6dbc)
;   0xb29e..0xb2d1  (51 bytes)
DATA_rle_col_B29E:
	defb 07fh,041h,009h,041h,007h,051h,011h,054h,006h,041h,003h,051h,007h,054h,005h,041h	; b29e  .A.A.Q.T.A.Q.T.A
	defb 004h,051h,007h,054h,005h,041h,006h,051h,008h,041h,002h,051h,081h,041h,00ch,054h	; b2ae  .Q.T.A.Q.A.Q.A.T
	defb 009h,051h,009h,041h,007h,051h,009h,041h,004h,051h,004h,041h,004h,051h,004h,041h	; b2be  .Q.A.Q.A.Q.A.Q.A
	defb 04ch,051h,000h	; b2ce

; ----------------------------------------------------------------------
; DATOS rle_col_B2D1: colores RLE: 6 tiles desde el 45 (lista 0x6dc3)
;   0xb2d1..0xb2e6  (21 bytes)
DATA_rle_col_B2D1:
	defb 006h,041h,085h,051h,041h,051h,051h,041h,00dh,051h,008h,041h,002h,051h,081h,041h	; b2d1  .A.QAQQA.Q.A.Q.A
	defb 009h,051h,004h,054h,000h	; b2e1

; ----------------------------------------------------------------------
; DATOS rle_col_B2E6: colores RLE: 26 tiles desde el 57 (lista 0x6dc3)
;   0xb2e6..0xb2ed  (7 bytes)
DATA_rle_col_B2E6:
	defb 038h,054h,07fh,041h,019h,041h,000h	; b2e6

; ----------------------------------------------------------------------
; DATOS rle_col_B2ED: colores RLE: 70 tiles desde el 80 (lista 0x6dd6)
;   0xb2ed..0xb396  (169 bytes)
DATA_rle_col_B2ED:
	defb 008h,011h,008h,0ffh,018h,0b1h,005h,0bah,008h,0a9h,081h,0a8h,009h,0a1h,081h,091h	; b2ed  ................
	defb 008h,0f9h,081h,091h,007h,0b9h,003h,0a9h,005h,091h,027h,0fbh,081h,0fah,022h,0f6h	; b2fd  ..........'...".
	defb 081h,0e6h,03ch,061h,00fh,081h,002h,061h,081h,0f6h,01fh,0f1h,006h,0e1h,004h,061h	; b30d  ..<a...a.......a
	defb 002h,081h,004h,091h,085h,061h,081h,081h,096h,098h,003h,091h,006h,081h,014h,091h	; b31d  .....a..........
	defb 081h,081h,04ch,091h,008h,096h,086h,061h,011h,019h,096h,066h,098h,003h,091h,083h	; b32d  ..L....a...f....
	defb 096h,066h,068h,003h,086h,002h,061h,085h,071h,051h,051h,041h,041h,003h,061h,085h	; b33d  .fh...a.qQQAA.a.
	defb 098h,096h,096h,091h,0f9h,003h,0e9h,004h,086h,084h,011h,0f9h,0e6h,0e6h,005h,086h	; b34d  ................
	defb 083h,061h,019h,096h,004h,091h,002h,098h,002h,096h,003h,091h,081h,081h,004h,061h	; b35d  .a.............a
	defb 003h,091h,086h,096h,091h,091h,096h,096h,091h,006h,0f1h,082h,0f6h,0b1h,003h,0bah	; b36d  ................
	defb 004h,0a7h,018h,071h,004h,074h,005h,091h,007h,0e1h,005h,0f1h,003h,061h,005h,0ffh	; b37d  ...q.t.......a..
	defb 085h,086h,0a8h,0a8h,0a6h,0a6h,006h,061h,000h	; b38d  .......a.

; ----------------------------------------------------------------------
; DATOS rle_col_B396: colores RLE: 70 tiles desde el 149 (lista 0x6dd6)
;   0xb396..0xb412  (124 bytes)
DATA_rle_col_B396:
	defb 008h,011h,008h,0ffh,018h,0b1h,005h,0bah,009h,0afh,009h,0a1h,081h,0f1h,008h,0ffh	; b396  ................
	defb 081h,0f1h,007h,0bfh,003h,0afh,005h,0f1h,027h,0fbh,081h,0fah,022h,0ffh,081h,0efh	; b3a6  ........'..."...
	defb 04dh,0f1h,081h,0ffh,01fh,0f1h,006h,0e1h,00dh,0f1h,002h,0ffh,06ah,0f1h,008h,0ffh	; b3b6  M...........j...
	defb 083h,0f1h,011h,01fh,003h,0ffh,003h,0f1h,006h,0ffh,003h,0f1h,002h,051h,002h,041h	; b3c6  .............Q.A
	defb 003h,0f1h,003h,0ffh,082h,0f1h,0ffh,003h,0efh,004h,0ffh,084h,011h,0ffh,0efh,0efh	; b3d6  ................
	defb 005h,0ffh,083h,0f1h,01fh,0ffh,004h,0f1h,004h,0ffh,00bh,0f1h,085h,0ffh,0f1h,0f1h	; b3e6  ................
	defb 0ffh,0ffh,007h,0f1h,082h,0ffh,0b1h,003h,0bah,004h,0afh,018h,0f1h,004h,0f4h,005h	; b3f6  ................
	defb 0f1h,007h,0e1h,008h,0f1h,006h,0ffh,004h,0afh,006h,0f1h,000h	; b406  ............

; ----------------------------------------------------------------------
; DATOS rle_col_B412: colores RLE: 72 tiles desde el 150 (lista 0x6de3)
;   0xb412..0xb463  (81 bytes)
DATA_rle_col_B412:
	defb 07fh,061h,034h,061h,07fh,0b1h,021h,0b1h,082h,0b6h,0bbh,018h,0b6h,00ah,061h,006h	; b412  .a4a..!.......a.
	defb 0b1h,005h,091h,00bh,0b1h,081h,061h,007h,0b1h,00ah,061h,00dh,091h,00bh,096h,081h	; b422  ......a...a.....
	defb 066h,00ah,096h,009h,0b6h,005h,096h,007h,061h,004h,091h,00ch,061h,008h,0b1h,005h	; b432  f.......a...a...
	defb 061h,081h,0b6h,003h,0b1h,005h,061h,006h,0b1h,006h,091h,00dh,061h,004h,0b1h,006h	; b442  a.....a.....a...
	defb 061h,003h,0b1h,003h,061h,002h,0b1h,082h,061h,091h,006h,0b1h,004h,0b6h,00ch,061h	; b452  a...a...a......a
	defb 000h	; b462

; ----------------------------------------------------------------------
; DATOS rle_pat_B463: patrones RLE: 47 tiles desde el 1 (lista 0x6cd1)
;   0xb463..0xb5a3  (320 bytes)
DATA_rle_pat_B463:
	defb 00ah,000h,098h,080h,0c0h,020h,010h,010h,090h,0c2h,081h,030h,05bh,0ech,0f6h,07bh	; b463  ..... .....0[..{
	defb 03dh,01eh,00fh,007h,003h,001h,006h,038h,0c4h,001h,001h,003h,003h,00bh,007h,008h	; b473  =......8........
	defb 000h,002h,003h,002h,001h,003h,000h,091h,001h,0efh,0b7h,057h,023h,0b3h,0b1h,099h	; b483  ...........W#...
	defb 098h,0dfh,0ddh,0ebh,0ebh,0f7h,0f7h,0fah,0fah,003h,000h,0b7h,003h,01fh,0ffh,0feh	; b493  ................
	defb 0f8h,0f0h,00fh,0f0h,0fch,0c0h,0fch,0ffh,0ffh,0f9h,07dh,0fdh,0feh,07fh,03fh,0bfh	; b4a3  ..........}...?.
	defb 09fh,01eh,07fh,001h,002h,007h,007h,003h,007h,07eh,080h,0fch,03fh,007h,0e0h,0f8h	; b4b3  .........~..?...
	defb 0c0h,048h,0ech,07ch,03eh,01eh,00fh,087h,00ch,000h,000h,003h,01fh,07fh,0feh,0fch	; b4c3  .H.|>...........
	defb 0f8h,0f0h,0f0h,003h,0e0h,083h,0c0h,0c1h,0c1h,003h,0c0h,083h,0e0h,0f0h,0fch,007h	; b4d3  ................
	defb 0ffh,083h,07fh,03fh,007h,004h,000h,099h,0c0h,0f0h,0e8h,0c4h,000h,000h,0f8h,0c0h	; b4e3  ...?............
	defb 0fch,001h,007h,00fh,01fh,03fh,07fh,0feh,0feh,0fch,0f8h,0f0h,060h,0b8h,0dfh,0e7h	; b4f3  .....?......`...
	defb 0f8h,003h,0ffh,090h,008h,03ch,0f4h,0cch,038h,0f8h,0f0h,0e0h,0e0h,0c0h,080h,000h	; b503  .....<..8.......
	defb 040h,0b0h,08ch,0c3h,007h,000h,081h,0f0h,006h,000h,082h,0fch,083h,003h,00fh,003h	; b513  @...............
	defb 000h,08ch,080h,0e0h,0e0h,060h,0c0h,080h,000h,0f0h,00fh,00fh,0ffh,0f0h,003h,00fh	; b523  .....`..........
	defb 006h,000h,081h,0f0h,003h,00fh,086h,000h,007h,003h,0f0h,00fh,00fh,003h,000h,003h	; b533  ................
	defb 0ffh,090h,00fh,0f0h,00fh,00fh,000h,0e0h,0f0h,0f8h,0fch,0feh,00fh,0f0h,00fh,0f0h	; b543  ................
	defb 00fh,00fh,005h,000h,085h,0dfh,00fh,0f0h,00fh,00fh,003h,000h,099h,083h,003h,003h	; b553  ................
	defb 007h,0f0h,00fh,00fh,000h,0fch,08eh,0f6h,0f6h,0feh,00eh,0f0h,00fh,0e0h,000h,0feh	; b563  ................
	defb 07ch,001h,00fh,0feh,0f0h,00fh,00fh,0ffh,003h,000h,003h,080h,002h,0c0h,0a0h,00fh	; b573  |...............
	defb 000h,000h,0c0h,0f8h,07fh,03fh,007h,005h,00dh,009h,0bfh,037h,02fh,08fh,08bh,0e0h	; b583  .....?.....7/...
	defb 0e0h,0f0h,0f0h,0f8h,0f8h,07ch,07ch,0f0h,0fch,07fh,07fh,03dh,071h,043h,083h,000h	; b593  .....||....=qC..

; ----------------------------------------------------------------------
; DATOS rle_pat_B5A3: patrones RLE: 3 tiles desde el 48 (lista 0x6cd1)
;   0xb5a3..0xb5b5  (18 bytes)
DATA_rle_pat_B5A3:
	defb 002h,000h,088h,0ffh,000h,03ch,042h,000h,018h,0ffh,0ffh,008h,000h,081h,0c3h,005h	; b5a3  .....<B.........
	defb 000h,000h	; b5b3

; ----------------------------------------------------------------------
; DATOS rle_pat_B5B5: patrones RLE: 14 tiles desde el 65 (lista 0x6cd1)
;   0xb5b5..0xb61b  (102 bytes)
DATA_rle_pat_B5B5:
	defb 002h,018h,004h,01ch,085h,00fh,000h,07ch,07ch,03fh,003h,000h,084h,0f0h,000h,009h	; b5b5  .......||?......
	defb 018h,004h,038h,08ah,00ah,002h,07fh,03fh,0bfh,03fh,07fh,0ffh,000h,000h,003h,0ffh	; b5c5  ..8....?.?......
	defb 085h,07fh,03fh,000h,010h,018h,007h,000h,096h,03fh,001h,007h,008h,018h,010h,030h	; b5d5  ..?......?.....0
	defb 020h,060h,02fh,002h,000h,001h,001h,003h,003h,001h,040h,0c0h,080h,080h,0fch,003h	; b5e5   `/.......@.....
	defb 0ffh,005h,000h,002h,0ffh,083h,0f8h,002h,002h,004h,012h,003h,010h,084h,080h,0ffh	; b5f5  ................
	defb 0c0h,0e0h,003h,0fch,090h,040h,000h,0ffh,000h,03ch,042h,000h,018h,0f0h,0e0h,0e8h	; b605  .....@...<B.....
	defb 0e0h,0f0h,018h,040h,0c0h,000h	; b615

; ----------------------------------------------------------------------
; DATOS rle_pat_B61B: patrones RLE: 1 tiles desde el 79 (lista 0x6cd1)
;   0xb61b..0xb620  (5 bytes)
DATA_rle_pat_B61B:
	defb 006h,000h,002h,0ffh,000h	; b61b

; ----------------------------------------------------------------------
; DATOS rle_col_B620: colores RLE: 47 tiles desde el 1 (lista 0x6cd1)
;   0xb620..0xb6db  (187 bytes)
DATA_rle_col_B620:
	defb 010h,0f4h,081h,0e4h,005h,0f4h,00ch,0f1h,01ah,0e1h,017h,061h,002h,081h,003h,086h	; b620  ...........a....
	defb 002h,061h,002h,041h,004h,064h,004h,061h,004h,064h,003h,041h,005h,061h,081h,0e1h	; b630  .a.A.d.a.d.A.a..
	defb 004h,061h,002h,041h,083h,064h,061h,061h,005h,064h,081h,041h,005h,0e4h,081h,0e8h	; b640  .a.A.daa.d.A....
	defb 003h,0f9h,002h,0e8h,012h,0e6h,003h,0e1h,005h,064h,006h,0e4h,088h,0e6h,086h,0e8h	; b650  .........d......
	defb 0e8h,0e9h,0f9h,0f9h,0f8h,005h,0e1h,082h,0f1h,0e1h,006h,0e6h,083h,0f1h,0e1h,0e9h	; b660  ................
	defb 005h,0e6h,081h,0e1h,003h,061h,004h,0f1h,00eh,0b4h,084h,094h,091h,0bah,0a9h,006h	; b670  .....a..........
	defb 091h,005h,0f4h,087h,0b4h,0bah,0a9h,044h,0b4h,0bah,0a9h,004h,091h,004h,0b4h,083h	; b680  .......D........
	defb 0bah,0a9h,091h,003h,061h,082h,0b1h,0bah,004h,0a9h,004h,061h,08eh,0b1h,0bah,0a9h	; b690  ....a......a....
	defb 0a9h,064h,061h,061h,064h,064h,061h,0b1h,0bah,0b1h,0fah,006h,0a9h,084h,064h,061h	; b6a0  .daadda.......da
	defb 0f1h,0fah,004h,0a9h,081h,061h,003h,0a1h,086h,0f1h,0fah,0a9h,0a9h,0a6h,0a6h,004h	; b6b0  .....a..........
	defb 0a1h,088h,0f1h,0bah,086h,096h,061h,061h,0a1h,0a1h,003h,0a9h,01ch,091h,006h,096h	; b6c0  ......aa........
	defb 005h,061h,006h,091h,002h,098h,002h,091h,006h,096h,000h	; b6d0  .a.........

; ----------------------------------------------------------------------
; DATOS rle_col_B6DB: colores RLE: 3 tiles desde el 48 (lista 0x6cd1)
;   0xb6db..0xb6e2  (7 bytes)
DATA_rle_col_B6DB:
	defb 003h,081h,007h,0f1h,00eh,041h,000h	; b6db

; ----------------------------------------------------------------------
; DATOS rle_col_B6E2: colores RLE: 14 tiles desde el 65 (lista 0x6cd1)
;   0xb6e2..0xb6f9  (23 bytes)
DATA_rle_col_B6E2:
	defb 010h,041h,016h,081h,02ah,0f1h,004h,081h,005h,0f1h,003h,081h,005h,0f1h,003h,081h	; b6e2  .A..*...........
	defb 004h,0f1h,006h,081h,002h,0f1h,000h	; b6f2

; ----------------------------------------------------------------------
; DATOS rle_col_B6F9: colores RLE: 1 tiles desde el 79 (lista 0x6cd1)
;   0xb6f9..0xb6fc  (3 bytes)
DATA_rle_col_B6F9:
	defb 008h,081h,000h	; b6f9

; ----------------------------------------------------------------------
; DATOS pantalla_B6FC: pantalla comprimida para RLE_A_RAM (p01 0x637A): 8
;   filas de 8 tiles; tabla p01 0x68D9 (entradas 0,2,5,7,8,10)
;   0xb6fc..0xb737  (59 bytes)
DATA_pantalla_B6FC:
	defb 004h,01ch,011h,016h,015h,084h,001h,003h,005h,012h,017h,0f3h,003h,01ah,001h,001h	; b6fc  ................
	defb 006h,013h,01ah,004h,01eh,01bh,001h,001h,008h,014h,018h,019h,02ch,01dh,01fh,020h	; b70c  ............,.. 
	defb 00eh,00ch,00fh,009h,00ah,02fh,02bh,007h,0e3h,021h,008h,010h,00dh,02dh,02eh,00bh	; b71c  ...../+..!...-..
	defb 02ah,02ah,029h,0e5h,024h,086h,02ah,002h,029h,02ah,000h	; b72c  **).$.*.)*.

; ----------------------------------------------------------------------
; DATOS pantalla_B737: pantalla comprimida para RLE_A_RAM (p01 0x637A): 8
;   filas de 8 tiles; tabla p01 0x68D9 (entradas 1,3,4,6,9,11)
;   0xb737..0xb764  (45 bytes)
DATA_pantalla_B737:
	defb 090h,007h,008h,038h,039h,031h,04fh,04fh,031h,047h,046h,0e3h,03ah,002h,050h,050h	; b737  ...891OO1GF.:.PP
	defb 0f3h,04ah,008h,035h,037h,040h,036h,044h,04eh,045h,043h,0e3h,03dh,002h,030h,030h	; b747  .J.57@6DNEC.=.00
	defb 0f3h,04dh,002h,033h,034h,084h,032h,002h,042h,041h,088h,007h,000h	; b757  .M.34.2.BA...

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (19 bytes)
;   0xb764..0xb777  (19 bytes)
DATA_pendiente_de_trazar:
	defb 000h,0deh,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0e3h	; b764  ................
	defb 000h,000h,000h	; b774

; ----------------------------------------------------------------------
; DATOS rle_pat_B777: patrones RLE: 43 tiles desde el 16 (lista 0x6db5)
;   0xb777..0xb8af  (312 bytes)
DATA_rle_pat_B777:
	defb 002h,000h,081h,07eh,003h,0eeh,081h,0fch,003h,000h,081h,03ch,004h,01ch,003h,000h	; b777  ...~.......<....
	defb 085h,0feh,00eh,0feh,0e0h,0feh,003h,000h,085h,0feh,00eh,03ch,00eh,0feh,003h,000h	; b787  ...........<....
	defb 085h,01eh,02eh,04eh,0feh,00eh,003h,000h,085h,0feh,0e0h,0feh,00eh,0fch,003h,000h	; b797  ...N............
	defb 085h,07eh,0e0h,0feh,0eeh,0feh,003h,000h,085h,0feh,01ch,038h,070h,0e0h,003h,000h	; b7a7  .~.........8p...
	defb 085h,0feh,0eeh,07ch,0eeh,0feh,003h,000h,090h,0feh,0eeh,0feh,00eh,0fch,000h,03ch	; b7b7  ...|...........<
	defb 042h,09dh,0a1h,0a1h,09dh,042h,03ch,000h,00fh,003h,07fh,082h,00fh,007h,003h,000h	; b7c7  B....B<.........
	defb 084h,0fch,0c0h,0c0h,080h,007h,000h,002h,018h,003h,000h,002h,018h,083h,000h,018h	; b7d7  ................
	defb 018h,00dh,000h,081h,07eh,005h,000h,085h,07ch,0eeh,0feh,0eeh,0eeh,003h,000h,085h	; b7e7  ....~...|.......
	defb 0feh,0eeh,0fch,0eeh,0feh,003h,000h,081h,07eh,003h,0e0h,081h,0feh,003h,000h,081h	; b7f7  ........~.......
	defb 0fch,003h,0eeh,081h,0fch,003h,000h,085h,0feh,0e0h,0fch,0e0h,0feh,003h,000h,085h	; b807  ................
	defb 0feh,0e0h,0fch,0e0h,0e0h,003h,000h,085h,07eh,0e0h,0eeh,0eeh,0feh,003h,000h,002h	; b817  ........~.......
	defb 0eeh,083h,0feh,0eeh,0eeh,003h,000h,005h,03ch,003h,000h,002h,00eh,002h,0eeh,081h	; b827  ........<.......
	defb 07eh,003h,000h,085h,0eeh,0fch,0f8h,0fch,0eeh,003h,000h,004h,0e0h,081h,0feh,003h	; b837  ~...............
	defb 000h,081h,0feh,004h,0b6h,003h,000h,085h,0ceh,0eeh,0feh,0eeh,0e6h,003h,000h,081h	; b847  ................
	defb 0feh,003h,0eeh,081h,0feh,003h,000h,085h,0feh,0eeh,0feh,0e0h,0e0h,003h,000h,081h	; b857  ................
	defb 0feh,003h,0eeh,089h,0feh,00ch,000h,000h,0feh,0eeh,0feh,0ech,0e6h,003h,000h,085h	; b867  ................
	defb 0feh,0e0h,0feh,00eh,0feh,003h,000h,081h,0feh,004h,038h,003h,000h,004h,0eeh,081h	; b877  ..........8.....
	defb 0feh,003h,000h,085h,0c6h,0eeh,07ch,038h,010h,003h,000h,004h,0b6h,081h,0feh,003h	; b887  ......|8........
	defb 000h,085h,0eeh,07ch,038h,07ch,0eeh,003h,000h,082h,0eeh,07ch,003h,038h,003h,000h	; b897  ...|8|.....|.8..
	defb 086h,0feh,01ch,038h,070h,0feh,000h,000h	; b8a7  ...8p...

; ----------------------------------------------------------------------
; DATOS rle_col_B8AF: colores RLE: 43 tiles desde el 16 (lista 0x6db5)
;   0xb8af..0xb8b6  (7 bytes)
DATA_rle_col_B8AF:
	defb 07fh,0efh,07fh,0efh,05ah,0efh,000h	; b8af

; ----------------------------------------------------------------------
; DATOS rle_col_B8B6: colores RLE: 43 tiles desde el 96 (lista 0x6d6b)
;   0xb8b6..0xb8bd  (7 bytes)
DATA_rle_col_B8B6:
	defb 07fh,0f0h,07fh,0f0h,05ah,0f0h,000h	; b8b6

; ----------------------------------------------------------------------
; DATOS tabla_B8BD: 16 punteros: p02 0x814E lee el de (E25B) y luego el byte
;   (iy-2) de su fila; los 6 primeros van a filas de 9 bytes y los 10
;   siguientes a listas de registros de 3 bytes terminadas en 0xFF
;   0xb8bd..0xb8dd  (32 bytes)
DATA_tabla_B8BD:
	defw 0b8ddh	; b8bd  -> DATA_filas_B8DD
	defw 0b8e6h	; b8bf
	defw 0b8efh	; b8c1
	defw 0b8f8h	; b8c3
	defw 0b901h	; b8c5
	defw 0b90ah	; b8c7
	defw 0b913h	; b8c9  -> DATA_listas_B913
	defw 0b926h	; b8cb
	defw 0b939h	; b8cd
	defw 0b94ch	; b8cf
	defw 0b95fh	; b8d1
	defw 0b972h	; b8d3
	defw 0b985h	; b8d5
	defw 0b998h	; b8d7
	defw 0b9abh	; b8d9
	defw 0b9beh	; b8db

; ----------------------------------------------------------------------
; DATOS filas_B8DD: 6 filas de 9 bytes (una por categoria (E25B)): el byte
;   (iy-2) de la fila elegida va a (iy-16)
;   0xb8dd..0xb913  (54 bytes)
DATA_filas_B8DD:
	defb 008h,008h,008h,000h,000h,000h,000h,000h,000h	; b8dd  .........
	defb 005h,003h,004h,003h,001h,001h,001h,001h,001h	; b8e6  .........
	defb 007h,006h,007h,006h,002h,002h,002h,002h,002h	; b8ef  .........
	defb 005h,003h,006h,000h,006h,003h,003h,003h,003h	; b8f8  .........
	defb 003h,002h,000h,005h,004h,004h,004h,004h,004h	; b901  .........
	defb 005h,002h,006h,000h,005h,005h,005h,005h,005h	; b90a  .........

; ----------------------------------------------------------------------
; DATOS listas_B913: 10 listas de registros de 3 bytes terminadas en 0xFF (las
;   entradas 6..15 de la tabla 0xB8BD; 6 registros cada una salvo la ultima: 4
;   bytes y 0xFF)
;   0xb913..0xb9c3  (176 bytes)
DATA_listas_B913:
	defb 000h,00ah,083h	; b913
	defb 001h,005h,081h	; b916
	defb 001h,00ah,082h	; b919
	defb 000h,014h,001h	; b91c
	defb 000h,00ah,002h	; b91f
	defb 001h,00ah,082h	; b922
	defb 0ffh	; b925
	defb 000h,00ah,082h	; b926
	defb 001h,00ah,081h	; b929
	defb 002h,014h,083h	; b92c
	defb 005h,00ah,002h	; b92f
	defb 002h,005h,081h	; b932
	defb 001h,00fh,083h	; b935
	defb 0ffh	; b938
	defb 006h,005h,081h	; b939
	defb 001h,00ah,002h	; b93c
	defb 003h,00fh,084h	; b93f
	defb 001h,005h,002h	; b942
	defb 000h,00ah,082h	; b945
	defb 001h,00ah,081h	; b948
	defb 0ffh	; b94b
	defb 004h,014h,003h	; b94c
	defb 002h,00ah,002h	; b94f
	defb 006h,00ah,001h	; b952
	defb 003h,00ah,082h	; b955
	defb 005h,005h,001h	; b958
	defb 001h,005h,082h	; b95b
	defb 0ffh	; b95e
	defb 004h,00ah,002h	; b95f
	defb 006h,005h,082h	; b962
	defb 004h,005h,081h	; b965
	defb 004h,00fh,003h	; b968
	defb 005h,00ah,082h	; b96b
	defb 007h,005h,001h	; b96e
	defb 0ffh	; b971
	defb 007h,005h,001h	; b972
	defb 006h,00ah,002h	; b975
	defb 007h,00ah,081h	; b978
	defb 000h,008h,002h	; b97b
	defb 000h,00fh,081h	; b97e
	defb 006h,005h,002h	; b981
	defb 0ffh	; b984
	defb 004h,00fh,082h	; b985
	defb 000h,00ah,081h	; b988
	defb 000h,00ah,082h	; b98b
	defb 001h,00fh,002h	; b98e
	defb 004h,005h,081h	; b991
	defb 006h,005h,001h	; b994
	defb 0ffh	; b997
	defb 008h,014h,082h	; b998
	defb 000h,00ah,082h	; b99b
	defb 000h,005h,001h	; b99e
	defb 008h,00fh,002h	; b9a1
	defb 008h,00ah,082h	; b9a4
	defb 000h,005h,081h	; b9a7
	defb 0ffh	; b9aa
	defb 004h,00ah,081h	; b9ab
	defb 000h,014h,080h	; b9ae
	defb 000h,00ah,081h	; b9b1
	defb 001h,005h,002h	; b9b4
	defb 004h,014h,080h	; b9b7
	defb 006h,005h,001h	; b9ba
	defb 0ffh	; b9bd
	defb 000h,000h,000h	; b9be
	defb 000h	; b9c1
	defb 0ffh	; b9c2

; ----------------------------------------------------------------------
; DATOS tabla_B9C3: 9 punteros por (iy-18) (p02 0x8105) a las listas de abajo;
;   de la lista coge el registro (iy-17) (x3): [0] -> D, [1] -> C...; 0xFF =
;   fin
;   0xb9c3..0xb9d5  (18 bytes)
DATA_tabla_B9C3:
	defw 0b9d5h	; b9c3  -> DATA_listas_B9D5
	defw 0b9eeh	; b9c5
	defw 0ba07h	; b9c7
	defw 0ba20h	; b9c9
	defw 0ba39h	; b9cb
	defw 0ba52h	; b9cd
	defw 0ba6bh	; b9cf
	defw 0ba84h	; b9d1
	defw 0ba9dh	; b9d3

; ----------------------------------------------------------------------
; DATOS listas_B9D5: 9 listas de 8 registros de 3 bytes (la ultima 9)
;   terminadas en 0xFF, para p02 0x8105
;   0xb9d5..0xbab9  (228 bytes)
DATA_listas_B9D5:
	defb 008h,001h,001h	; b9d5
	defb 00ch,006h,0ffh	; b9d8
	defb 02ch,006h,0ffh	; b9db
	defb 018h,001h,0ffh	; b9de
	defb 018h,002h,001h	; b9e1
	defb 00ch,004h,001h	; b9e4
	defb 028h,001h,0ffh	; b9e7
	defb 028h,001h,001h	; b9ea
	defb 0ffh	; b9ed
	defb 00ch,003h,0f8h	; b9ee
	defb 014h,003h,0eeh	; b9f1
	defb 020h,006h,0e7h	; b9f4
	defb 028h,002h,00ah	; b9f7
	defb 020h,002h,01eh	; b9fa
	defb 00ch,006h,000h	; b9fd
	defb 00ch,001h,01eh	; ba00
	defb 028h,007h,00ah	; ba03
	defb 0ffh	; ba06
	defb 004h,006h,000h	; ba07
	defb 00ch,006h,005h	; ba0a
	defb 018h,003h,00ah	; ba0d
	defb 020h,002h,00fh	; ba10
	defb 020h,005h,00ah	; ba13
	defb 018h,004h,019h	; ba16
	defb 024h,003h,000h	; ba19
	defb 020h,003h,005h	; ba1c
	defb 0ffh	; ba1f
	defb 010h,001h,000h	; ba20
	defb 020h,001h,00ah	; ba23
	defb 018h,003h,00ah	; ba26
	defb 020h,002h,000h	; ba29
	defb 014h,004h,0ech	; ba2c
	defb 018h,005h,0e7h	; ba2f
	defb 018h,006h,0fbh	; ba32
	defb 020h,004h,01eh	; ba35
	defb 0ffh	; ba38
	defb 00ch,002h,000h	; ba39
	defb 018h,002h,00ah	; ba3c
	defb 01ch,004h,014h	; ba3f
	defb 004h,003h,0ffh	; ba42
	defb 010h,003h,0ech	; ba45
	defb 014h,007h,0e2h	; ba48
	defb 018h,005h,0ech	; ba4b
	defb 017h,004h,0e2h	; ba4e
	defb 0ffh	; ba51
	defb 00ch,001h,0ffh	; ba52
	defb 018h,002h,00ah	; ba55
	defb 020h,003h,014h	; ba58
	defb 004h,004h,01eh	; ba5b
	defb 004h,005h,00ah	; ba5e
	defb 018h,001h,014h	; ba61
	defb 00ch,007h,0e2h	; ba64
	defb 020h,003h,0ech	; ba67
	defb 0ffh	; ba6a
	defb 018h,002h,000h	; ba6b
	defb 018h,007h,019h	; ba6e
	defb 020h,001h,01eh	; ba71
	defb 030h,007h,005h	; ba74
	defb 00ch,001h,014h	; ba77
	defb 018h,002h,0fbh	; ba7a
	defb 018h,004h,0e2h	; ba7d
	defb 018h,003h,0fbh	; ba80
	defb 0ffh	; ba83
	defb 010h,002h,000h	; ba84
	defb 010h,002h,0f1h	; ba87
	defb 020h,003h,0ech	; ba8a
	defb 030h,001h,00fh	; ba8d
	defb 020h,005h,014h	; ba90
	defb 00ch,004h,019h	; ba93
	defb 018h,004h,01eh	; ba96
	defb 020h,001h,014h	; ba99
	defb 0ffh	; ba9c
	defb 030h,003h,0ffh	; ba9d
	defb 030h,006h,001h	; baa0
	defb 018h,006h,001h	; baa3
	defb 030h,003h,0ffh	; baa6
	defb 030h,004h,0ffh	; baa9
	defb 018h,005h,001h	; baac
	defb 018h,002h,00bh	; baaf
	defb 030h,002h,001h	; bab2
	defb 030h,002h,0ffh	; bab5
	defb 0ffh	; bab8

; ----------------------------------------------------------------------
; DATOS mandos_grabados: 229 pares (mascara de mandos, cuadros que dura) que
;   suman 2178 cuadros: 43,6 s a 50 Hz. Las mascaras que aparecen -00 01 02 04
;   08 10 11 14 18 20 24 28 4F- son combinaciones de los bits 0-5, la forma de
;   las direcciones y los dos botones. Nadie lo referencia con una direccion
;   literal, asi que quien lo lee esta por encontrar: lo que encaja es una
;   partida grabada para la demo (hipotesis fundada, sin medir en el emulador)
;   0xbab9..0xbc84  (459 bytes)
DATA_mandos_grabados:
	defb 000h,002h	; bab9
	defb 010h,003h	; babb
	defb 000h,010h	; babd
	defb 010h,004h	; babf
	defb 000h,01bh	; bac1
	defb 010h,006h	; bac3
	defb 000h,00eh	; bac5
	defb 002h,005h	; bac7
	defb 000h,004h	; bac9
	defb 002h,005h	; bacb
	defb 000h,003h	; bacd
	defb 002h,006h	; bacf
	defb 000h,004h	; bad1
	defb 002h,004h	; bad3
	defb 000h,005h	; bad5
	defb 002h,005h	; bad7
	defb 000h,00fh	; bad9
	defb 008h,005h	; badb
	defb 000h,005h	; badd
	defb 008h,005h	; badf
	defb 000h,005h	; bae1
	defb 008h,005h	; bae3
	defb 000h,005h	; bae5
	defb 008h,005h	; bae7
	defb 000h,005h	; bae9
	defb 008h,005h	; baeb
	defb 000h,005h	; baed
	defb 008h,005h	; baef
	defb 000h,005h	; baf1
	defb 008h,006h	; baf3
	defb 000h,004h	; baf5
	defb 008h,005h	; baf7
	defb 000h,005h	; baf9
	defb 008h,005h	; bafb
	defb 000h,005h	; bafd
	defb 008h,005h	; baff
	defb 000h,005h	; bb01
	defb 008h,005h	; bb03
	defb 000h,005h	; bb05
	defb 008h,005h	; bb07
	defb 000h,005h	; bb09
	defb 008h,005h	; bb0b
	defb 000h,005h	; bb0d
	defb 008h,005h	; bb0f
	defb 000h,019h	; bb11
	defb 010h,002h	; bb13
	defb 000h,027h	; bb15
	defb 002h,004h	; bb17
	defb 000h,014h	; bb19
	defb 010h,002h	; bb1b
	defb 000h,012h	; bb1d
	defb 008h,005h	; bb1f
	defb 000h,005h	; bb21
	defb 008h,005h	; bb23
	defb 000h,007h	; bb25
	defb 008h,005h	; bb27
	defb 000h,00dh	; bb29
	defb 008h,006h	; bb2b
	defb 000h,00dh	; bb2d
	defb 008h,008h	; bb2f
	defb 000h,015h	; bb31
	defb 004h,004h	; bb33
	defb 000h,00dh	; bb35
	defb 010h,002h	; bb37
	defb 000h,016h	; bb39
	defb 008h,005h	; bb3b
	defb 000h,006h	; bb3d
	defb 008h,005h	; bb3f
	defb 000h,00eh	; bb41
	defb 010h,003h	; bb43
	defb 000h,021h	; bb45
	defb 008h,004h	; bb47
	defb 000h,015h	; bb49
	defb 010h,002h	; bb4b
	defb 000h,024h	; bb4d
	defb 010h,003h	; bb4f
	defb 000h,019h	; bb51
	defb 008h,004h	; bb53
	defb 000h,00ch	; bb55
	defb 010h,005h	; bb57
	defb 000h,018h	; bb59
	defb 010h,002h	; bb5b
	defb 000h,060h	; bb5d
	defb 010h,032h	; bb5f
	defb 000h,001h	; bb61
	defb 001h,008h	; bb63
	defb 000h,001h	; bb65
	defb 010h,040h	; bb67
	defb 001h,008h	; bb69
	defb 010h,04bh	; bb6b
	defb 011h,001h	; bb6d
	defb 001h,008h	; bb6f
	defb 000h,003h	; bb71
	defb 010h,046h	; bb73
	defb 000h,002h	; bb75
	defb 020h,006h	; bb77
	defb 028h,004h	; bb79
	defb 008h,005h	; bb7b
	defb 000h,00dh	; bb7d
	defb 008h,003h	; bb7f
	defb 000h,00fh	; bb81
	defb 008h,00eh	; bb83
	defb 000h,005h	; bb85
	defb 024h,004h	; bb87
	defb 004h,006h	; bb89
	defb 014h,00ch	; bb8b
	defb 010h,001h	; bb8d
	defb 000h,007h	; bb8f
	defb 008h,002h	; bb91
	defb 028h,005h	; bb93
	defb 008h,00ah	; bb95
	defb 018h,001h	; bb97
	defb 010h,00bh	; bb99
	defb 000h,009h	; bb9b
	defb 002h,004h	; bb9d
	defb 000h,002h	; bb9f
	defb 008h,00ah	; bba1
	defb 000h,003h	; bba3
	defb 014h,010h	; bba5
	defb 004h,001h	; bba7
	defb 000h,00ch	; bba9
	defb 008h,007h	; bbab
	defb 000h,004h	; bbad
	defb 008h,004h	; bbaf
	defb 000h,006h	; bbb1
	defb 008h,001h	; bbb3
	defb 018h,006h	; bbb5
	defb 010h,001h	; bbb7
	defb 000h,00ah	; bbb9
	defb 004h,002h	; bbbb
	defb 000h,005h	; bbbd
	defb 004h,002h	; bbbf
	defb 000h,001h	; bbc1
	defb 010h,009h	; bbc3
	defb 014h,005h	; bbc5
	defb 004h,003h	; bbc7
	defb 000h,005h	; bbc9
	defb 010h,003h	; bbcb
	defb 014h,005h	; bbcd
	defb 000h,008h	; bbcf
	defb 010h,012h	; bbd1
	defb 018h,003h	; bbd3
	defb 008h,004h	; bbd5
	defb 000h,003h	; bbd7
	defb 008h,004h	; bbd9
	defb 000h,008h	; bbdb
	defb 010h,001h	; bbdd
	defb 018h,003h	; bbdf
	defb 010h,001h	; bbe1
	defb 000h,007h	; bbe3
	defb 008h,004h	; bbe5
	defb 010h,00ah	; bbe7
	defb 018h,003h	; bbe9
	defb 000h,005h	; bbeb
	defb 010h,024h	; bbed
	defb 011h,001h	; bbef
	defb 001h,004h	; bbf1
	defb 010h,003h	; bbf3
	defb 018h,00ah	; bbf5
	defb 010h,003h	; bbf7
	defb 000h,003h	; bbf9
	defb 020h,006h	; bbfb
	defb 000h,001h	; bbfd
	defb 008h,009h	; bbff
	defb 000h,005h	; bc01
	defb 004h,011h	; bc03
	defb 014h,00ch	; bc05
	defb 010h,003h	; bc07
	defb 000h,005h	; bc09
	defb 002h,004h	; bc0b
	defb 010h,013h	; bc0d
	defb 014h,006h	; bc0f
	defb 004h,002h	; bc11
	defb 000h,004h	; bc13
	defb 010h,001h	; bc15
	defb 018h,007h	; bc17
	defb 010h,003h	; bc19
	defb 018h,004h	; bc1b
	defb 008h,004h	; bc1d
	defb 000h,006h	; bc1f
	defb 008h,004h	; bc21
	defb 000h,00ah	; bc23
	defb 010h,001h	; bc25
	defb 018h,001h	; bc27
	defb 008h,002h	; bc29
	defb 000h,003h	; bc2b
	defb 008h,003h	; bc2d
	defb 018h,001h	; bc2f
	defb 010h,008h	; bc31
	defb 014h,006h	; bc33
	defb 004h,008h	; bc35
	defb 000h,005h	; bc37
	defb 010h,005h	; bc39
	defb 014h,005h	; bc3b
	defb 010h,003h	; bc3d
	defb 000h,007h	; bc3f
	defb 010h,007h	; bc41
	defb 014h,003h	; bc43
	defb 010h,014h	; bc45
	defb 000h,001h	; bc47
	defb 001h,006h	; bc49
	defb 011h,001h	; bc4b
	defb 010h,031h	; bc4d
	defb 014h,005h	; bc4f
	defb 010h,01bh	; bc51
	defb 000h,001h	; bc53
	defb 020h,00bh	; bc55
	defb 000h,006h	; bc57
	defb 002h,005h	; bc59
	defb 000h,001h	; bc5b
	defb 004h,00ah	; bc5d
	defb 014h,003h	; bc5f
	defb 010h,003h	; bc61
	defb 000h,001h	; bc63
	defb 008h,006h	; bc65
	defb 018h,005h	; bc67
	defb 010h,004h	; bc69
	defb 004h,008h	; bc6b
	defb 000h,006h	; bc6d
	defb 018h,007h	; bc6f
	defb 010h,002h	; bc71
	defb 000h,001h	; bc73
	defb 008h,00bh	; bc75
	defb 000h,004h	; bc77
	defb 004h,004h	; bc79
	defb 024h,005h	; bc7b
	defb 004h,00eh	; bc7d
	defb 014h,001h	; bc7f
	defb 04fh,0ffh	; bc81
	defb 0ffh	; bc83

; ----------------------------------------------------------------------
; DATOS relleno_BC84: 716 bytes a 0xFF: espacio libre del cartucho, comprobado
;   byte a byte
;   0xbc84..0xbf50  (716 bytes)
DATA_relleno_BC84:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc84  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc94  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bca4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcb4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcc4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcd4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bce4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcf4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd04  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd14  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd24  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd34  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd44  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd54  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd64  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd74  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd84  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd94  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bda4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdb4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdc4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdd4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bde4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdf4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be04  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be14  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be24  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be34  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be44  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be54  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be64  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be74  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be84  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be94  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bea4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beb4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bec4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bed4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bee4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bef4  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf04  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf14  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf24  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf34  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf44  ............

; ======================================================================
; CODIGO 0xbf50..0xbfc6  (118 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Busca en las cuatro ranuras (y en las subranuras de las expandidas)
; otro cartucho Konami: lee con RDSLT y compara tres firmas, 5 bytes en
; 0x4010, 6 en 0xBFFA y 6 en 0x7FFA. En E1DE deja 2 si alguna encaja y
; 0 si no. OJO: los unicos valores que escribe son 2 y 0, asi que E1DE
; no es "el identificador de la ranura" -como decia esta nota antes-
; sino una bandera; y la comparacion de p01 0x702A contra el valor 1
; no se puede dar, porque este es el unico sitio del listado que
; escribe E1DE.
; QUE DESBLOQUEA (era la pregunta abierta): p00 0x49A3 lee E1DE y, si
; vale 2, pone E1DF = 1; y con E1DF distinto de cero p01 0x6227
; (COMPARA_PUNTOS) deja de comparar los puntos y da por buena cualquier
; categoria. Es exactamente el efecto de la contrasena MAXPOINT (p01
; 0x74AC). Ademas, con E1DE = 2 el truco UJM3EDC se queda sin efecto
; (p01 0x74CC sale sin hacer nada).
; Las tres direcciones encajan con tres tamanos de cartucho: 0x4010 es
; la cabecera, 0x7FFA los ultimos seis bytes de uno de 16 KB y 0xBFFA
; los de uno de 32 KB (lectura de las direcciones, sin medir). De que
; juegos son esas firmas, sin cerrar.
; ----------------------------------------------------------------------
BUSCA_CARTUCHOS:		; desde INIT (0x4138) con D/E/F mapeadas
	ld bc,00400h		;bf50   ; B = las cuatro ranuras, C = el numero de la primera
	ld hl,0fcc1h		;bf53   ; FCC1 es EXPTBL: un byte por ranura, con el bit 7 puesto si esta expandida
L_BF56:
	push bc			;bf56
	push hl			;bf57
	ld a,(hl)			;bf58   ; el byte de EXPTBL de esta ranura
	bit 7,a		;bf59   ; Z = ranura sin expandir, y con eso entra en 0xBF6D
	call BUSCA_EN_RANURA		;bf5b
	pop hl			;bf5e
	pop bc			;bf5f
	jr c,L_BF69		;bf60   ; carry = encontrado, y A ya trae el 2
	inc hl			;bf62
	inc c			;bf63   ; la ranura siguiente
	djnz L_BF56		;bf64
	xor a			;bf66   ; ninguna de las cuatro: A = 0
	jr L_BF69		;bf67   ; un salto a la instruccion de al lado: dos bytes que no hacen nada
L_BF69:
	ld (0e1deh),a		;bf69   ; E1DE = 2 si hay otro cartucho, 0 si no
	ret			;bf6c
BUSCA_EN_RANURA:		; C = ranura; si esta expandida prueba sus 4 subranuras
	jr z,COMPARA_FIRMAS		;bf6d   ; sin expandir: se prueba la ranura tal cual
	and 080h		;bf6f   ; expandida: el identificador se monta con el bit 7 y el numero de ranura
	or c			;bf71
	ld c,a			;bf72
	ld b,004h		;bf73   ; y hay que recorrer sus cuatro subranuras
SUBRANURA_SIGUIENTE:		; las cuatro subranuras de una ranura expandida
	push bc			;bf75
	call COMPARA_FIRMAS		;bf76
	pop bc			;bf79
	ret c			;bf7a   ; encontrado en esta subranura: se sale con el carry
	ld a,c			;bf7b
	add a,004h		;bf7c   ; la subranura va en los bits 2 y 3: sumar 4 es pasar a la siguiente
	ld c,a			;bf7e
	djnz SUBRANURA_SIGUIENTE		;bf7f
	xor a			;bf81   ; ninguna de las cuatro: A = 0 y sin carry
	ret			;bf82
COMPARA_FIRMAS:		; carry si alguna de las tres firmas coincide
	call FIRMA_4010		;bf83   ; primera firma: la cabecera del otro cartucho
	ld a,002h		;bf86   ; el 2 se carga antes del ret: es la bandera que acaba en E1DE
	ret c			;bf88
	call FIRMA_BFFA		;bf89   ; segunda firma: el final de un cartucho de 32 KB
	ld a,002h		;bf8c
	ret c			;bf8e
	call FIRMA_7FFA		;bf8f   ; tercera firma: el final de uno de 16 KB
	ld a,002h		;bf92
	ret			;bf94   ; el carry lo deja la comparacion; el A = 2 sirve para las tres
FIRMA_4010:		; 5 bytes en 0x4010 contra 0xBFD2
	ld de,0bfd2h		;bf95   ; la firma esperada, en esta misma pagina
	ld hl,04010h		;bf98   ; 0x4010 es lo que sigue a la cabecera AB del cartucho
	ld b,005h		;bf9b
	jr COMPARA_B_BYTES		;bf9d
FIRMA_BFFA:		; 6 bytes en 0xBFFA contra 0xBFCC
	ld de,0bfcch		;bf9f   ; la segunda firma
	ld hl,0bffah		;bfa2   ; 0xBFFA: los seis ultimos bytes de un cartucho de 32 KB
	ld b,006h		;bfa5
	jr COMPARA_B_BYTES		;bfa7
FIRMA_7FFA:		; 6 bytes en 0x7FFA contra 0xBFC6
	ld de,0bfc6h		;bfa9   ; la tercera firma
	ld hl,07ffah		;bfac   ; 0x7FFA: los seis ultimos de uno de 16 KB
	ld b,006h		;bfaf
COMPARA_B_BYTES:		; B bytes leidos con RDSLT (ranura C) contra (DE)
	push bc			;bfb1   ; RDSLT se lleva BC y DE por delante: se guardan en cada vuelta
	push de			;bfb2
	ld a,c			;bfb3   ; A = el identificador de ranura: el contador C de 0xBF63, con el bit 7 y la subranura si estaba expandida (0xBF6F)
	call 0000ch		;bfb4   ; BIOS RDSLT - Reads the value of an address in another slot | lee UN byte de otra ranura; no hay manera de leer un bloque
	pop de			;bfb7
	pop bc			;bfb8
	ex de,hl			;bfb9   ; el byte leido (A) contra el de la firma, que va en DE
	cp (hl)			;bfba
	ex de,hl			;bfbb
	jr nz,FIRMA_NO_COINCIDE		;bfbc   ; a la primera diferencia se abandona esta ranura
	inc hl			;bfbe
	inc de			;bfbf
	djnz COMPARA_B_BYTES		;bfc0
	scf			;bfc2   ; los B bytes iguales: carry, encontrado
	ret			;bfc3
FIRMA_NO_COINCIDE:		; sin carry: esta firma no es
	and a			;bfc4   ; sin carry para que el llamador siga probando
	ret			;bfc5

; ----------------------------------------------------------------------
; DATOS firma_7FFA: 00 30 31 13 35 AA: los seis bytes que tiene que haber en
;   0x7FFA del otro cartucho (los lee 0xBFA9)
;   0xbfc6..0xbfcc  (6 bytes)
DATA_firma_7FFA:
	defb 000h,030h,031h,013h,035h,0aah	; bfc6

; ----------------------------------------------------------------------
; DATOS firma_BFFA: BA B2 86 07 46 AA: los seis bytes que tiene que haber en
;   0xBFFA del otro cartucho (los lee 0xBF9F)
;   0xbfcc..0xbfd2  (6 bytes)
DATA_firma_BFFA:
	defb 0bah,0b2h,086h,007h,046h,0aah	; bfcc

; ----------------------------------------------------------------------
; DATOS firma_4010: "CD" 07 "E" FF: los cinco bytes que tiene que haber en
;   0x4010 del otro cartucho (los lee 0xBF95). Este cartucho lleva ahi "CD" 07
;   "R" FF, o sea que F-1 Spirit NO se encuentra a si mismo: la letra cambia
;   0xbfd2..0xbfd7  (5 bytes)
DATA_firma_4010:
	defb 043h,044h,007h,045h,0ffh	; bfd2

; ----------------------------------------------------------------------
; DATOS relleno_FF: 41 bytes a 0xFF hasta el final de la ROM
;   0xbfd7..0xc000  (41 bytes)
DATA_relleno_FF:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd7  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe7  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff7  .........
