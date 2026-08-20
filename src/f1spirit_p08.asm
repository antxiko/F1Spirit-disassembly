; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 08 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS rle_col_7FFB: colores RLE: 44 tiles desde el 212 (lista 0x6c36)
;   0x8000..0x8016  (22 bytes)
DATA_rle_col_7FFB:
	defb 0c1h,028h,091h,008h,081h,00bh,041h,004h,064h,009h,091h,008h,021h,008h,0a1h,008h	; 8000  .(....A.d...!...
	defb 091h,008h,081h,008h,061h,000h	; 8010

; ----------------------------------------------------------------------
; DATOS rle_pat_8016: patrones RLE: 71 tiles desde el 64 (lista 0x6d34)
;   0x8016..0x80ef  (217 bytes)
DATA_rle_pat_8016:
	defb 030h,007h,04dh,0ffh,003h,0feh,003h,0fch,003h,0f8h,002h,0f0h,012h,0ffh,084h,0feh	; 8016  0.M.............
	defb 0fch,0f8h,0f8h,003h,0f0h,003h,0e0h,003h,0c0h,003h,080h,00ch,000h,002h,001h,010h	; 8026  ................
	defb 0ffh,082h,0f0h,080h,007h,000h,002h,001h,002h,003h,007h,000h,002h,01fh,003h,03fh	; 8036  ...............?
	defb 003h,07fh,014h,0ffh,008h,000h,081h,07fh,004h,0ffh,007h,000h,00eh,0ffh,002h,0feh	; 8046  ................
	defb 084h,0fch,0f8h,0f8h,0f0h,008h,0ffh,008h,000h,005h,0ffh,007h,000h,008h,0ffh,086h	; 8056  ................
	defb 0feh,0f8h,0e0h,0c0h,0c0h,080h,006h,000h,008h,0ffh,002h,000h,002h,001h,002h,003h	; 8066  ................
	defb 002h,007h,005h,0ffh,087h,00fh,01fh,01fh,03fh,03fh,07fh,07fh,003h,0ffh,084h,0feh	; 8076  ........??......
	defb 0f8h,0c0h,080h,005h,000h,010h,0ffh,002h,0feh,08ch,0fch,0f0h,0c0h,0c0h,080h,081h	; 8086  ................
	defb 081h,001h,003h,083h,083h,080h,00ah,000h,084h,0feh,0fch,0fch,0f8h,003h,0f0h,005h	; 8096  ................
	defb 0e0h,002h,0c0h,081h,080h,008h,000h,006h,0ffh,016h,000h,088h,001h,007h,00fh,007h	; 80a6  ................
	defb 007h,003h,001h,001h,004h,000h,003h,0f8h,003h,0f0h,006h,000h,003h,001h,003h,003h	; 80b6  ................
	defb 082h,01fh,07fh,007h,0ffh,082h,0f7h,0c7h,003h,00fh,003h,01fh,003h,03fh,003h,07fh	; 80c6  .............?..
	defb 011h,0ffh,003h,0feh,003h,0fch,003h,0f8h,003h,0f0h,003h,0e0h,003h,0c0h,003h,080h	; 80d6  ................
	defb 002h,000h,003h,0c0h,003h,080h,002h,000h,000h	; 80e6  .........

; ----------------------------------------------------------------------
; DATOS rle_pat_80EF: patrones RLE: 2 tiles desde el 135 (tabla85[83])
;   0x80ef..0x80fe  (15 bytes)
DATA_rle_pat_80EF:
	defb 002h,000h,083h,03fh,07fh,0ffh,005h,000h,083h,0fch,0f8h,0f0h,003h,000h,000h	; 80ef  ...?...........

; ----------------------------------------------------------------------
; DATOS rle_pat_80FE: patrones RLE: 2 tiles desde el 153 (tabla85[84])
;   0x80fe..0x810d  (15 bytes)
DATA_rle_pat_80FE:
	defb 003h,000h,083h,00fh,01fh,03fh,005h,000h,085h,0ffh,0feh,0fch,000h,000h,000h	; 80fe  .....?.........

; ----------------------------------------------------------------------
; DATOS rle_pat_810D: patrones RLE: 64 tiles desde el 159 (lista 0x6d34)
;   0x810d..0x8210  (259 bytes)
DATA_rle_pat_810D:
	defb 084h,000h,001h,003h,003h,005h,007h,082h,003h,001h,003h,000h,002h,00fh,002h,01fh	; 810d  ................
	defb 081h,03fh,014h,000h,081h,03fh,004h,0ffh,083h,0f0h,0e0h,0e0h,004h,0ffh,003h,000h	; 811d  .?...?..........
	defb 005h,0ffh,00ch,000h,005h,0ffh,003h,000h,004h,0ffh,002h,007h,081h,00fh,004h,0ffh	; 812d  ................
	defb 081h,0feh,00ch,000h,085h,0fch,0f8h,0f8h,0f0h,0f0h,003h,000h,083h,081h,0e1h,0f1h	; 813d  ................
	defb 003h,0f3h,086h,0f7h,0e7h,0e7h,0cfh,08fh,00fh,00ch,000h,082h,00fh,03fh,003h,07fh	; 814d  .............?..
	defb 086h,0ffh,0feh,0feh,0fch,0fdh,0fdh,003h,0fbh,003h,0f0h,003h,0e0h,00ch,000h,005h	; 815d  ................
	defb 0ffh,002h,000h,082h,001h,003h,005h,0ffh,012h,000h,082h,0f0h,0fch,005h,0feh,003h	; 816d  ................
	defb 0fch,084h,0f8h,0f9h,0f1h,0c1h,003h,003h,003h,007h,00ch,000h,002h,01fh,003h,03fh	; 817d  ...............?
	defb 003h,07fh,003h,0feh,003h,0fdh,003h,0fbh,003h,0f7h,00ch,000h,082h,0c7h,0dfh,003h	; 818d  ................
	defb 0bfh,003h,07fh,003h,0feh,003h,0fdh,003h,0f8h,003h,0f0h,00ch,000h,005h,0ffh,081h	; 819d  ................
	defb 080h,003h,000h,005h,0ffh,086h,00fh,007h,007h,003h,001h,001h,00ch,000h,081h,0fch	; 81ad  ................
	defb 004h,0ffh,002h,03fh,08dh,07fh,0ffh,0ffh,0feh,0feh,0fch,0f0h,0e0h,0f0h,0f0h,0f8h	; 81bd  ...?............
	defb 0fch,0fch,00ch,000h,002h,003h,003h,087h,002h,08fh,081h,00fh,003h,01fh,003h,03fh	; 81cd  ...............?
	defb 003h,07fh,003h,0feh,00ch,000h,002h,0fbh,083h,0f3h,0f7h,0f7h,003h,0e0h,003h,0c0h	; 81dd  ................
	defb 003h,080h,012h,000h,005h,0ffh,003h,00fh,003h,01fh,003h,03fh,003h,07fh,003h,0feh	; 81ed  ...........?....
	defb 00ch,000h,005h,0ffh,003h,0e0h,003h,0c0h,003h,080h,012h,000h,003h,0e0h,002h,0c0h	; 81fd  ................
	defb 014h,000h,000h	; 820d

; ----------------------------------------------------------------------
; DATOS rle_pat_8210: patrones RLE: 15 tiles desde el 223 (lista 0x6d34)
;   0x8210..0x827f  (111 bytes)
DATA_rle_pat_8210:
	defb 081h,00fh,005h,003h,002h,000h,083h,0dbh,01bh,01fh,003h,01bh,002h,000h,09bh,07ch	; 8210  ...............|
	defb 060h,078h,060h,060h,07ch,000h,000h,036h,036h,016h,01fh,019h,009h,000h,000h,0ddh	; 8220  `x``|..66.......
	defb 0ddh,094h,0b6h,0beh,022h,000h,000h,008h,098h,0f0h,003h,060h,002h,000h,081h,07eh	; 8230  ...."......`...~
	defb 005h,018h,002h,000h,081h,070h,004h,0d8h,08ch,070h,000h,000h,01eh,018h,018h,01eh	; 8240  .....p...p......
	defb 018h,018h,000h,000h,073h,004h,0dbh,08ch,073h,000h,000h,0c8h,06ch,06fh,0cch,06ch	; 8250  ....s...s...lo.l
	defb 06ch,000h,000h,05bh,004h,0dbh,083h,0ceh,000h,000h,003h,061h,002h,063h,08bh,07bh	; 8260  l..[.......a.c.{
	defb 000h,000h,0c1h,0c3h,041h,06dh,0e1h,061h,000h,000h,006h,0c0h,002h,000h,000h	; 8270  ....Am.a.......

; ----------------------------------------------------------------------
; DATOS rle_col_827F: colores RLE: vacio: solo patrones (lista 0x6d34)
;   0x827f..0x8280  (1 bytes)
DATA_rle_col_827F:
	defb 000h	; 827f

; ----------------------------------------------------------------------
; DATOS pantalla_8280: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 32 tiles; p00 0x5CFF (con 8/9): al buffer E4A0
;   0x8280..0x8325  (165 bytes)
DATA_pantalla_8280:
	defb 00ch,0deh,040h,046h,04ch,052h,058h,05eh,064h,06ah,06fh,074h,079h,0f0h,087h,002h	; 8280  ..@FLRX^djoty...
	defb 097h,098h,083h,0deh,01dh,041h,047h,04dh,053h,059h,05fh,065h,06bh,070h,075h,07ah	; 8290  .....AGMSY_ekpuz
	defb 07eh,082h,086h,0a3h,0a7h,0abh,0afh,0b3h,0b7h,0bbh,0bfh,0c3h,0c7h,0cbh,0cfh,0d3h	; 82a0  ~...............
	defb 0d7h,0dbh,083h,0deh,01dh,042h,048h,04eh,054h,05ah,060h,066h,06ch,071h,076h,07bh	; 82b0  .....BHNTZ`flqv{
	defb 07fh,083h,09fh,0a4h,0a8h,0ach,0b0h,0b4h,0b8h,0bch,0c0h,0c4h,0c8h,0cch,0d0h,0d4h	; 82c0  ................
	defb 0d8h,0dch,083h,0deh,01dh,043h,049h,04fh,055h,05bh,061h,067h,06dh,072h,077h,07ch	; 82d0  .....CIOU[agmrw|
	defb 080h,084h,0a0h,0a5h,0a9h,0adh,0b1h,0b5h,0b9h,0bdh,0c1h,0c5h,0c9h,0cdh,0d1h,0d5h	; 82e0  ................
	defb 0d9h,0ddh,083h,0deh,01ch,044h,04ah,050h,056h,05ch,062h,068h,06eh,073h,078h,07dh	; 82f0  .....DJPV\bhnsx}
	defb 081h,085h,0a1h,0a6h,0aah,0aeh,0b2h,0b6h,0bah,0beh,0c2h,0c6h,0cah,0ceh,0d2h,0d6h	; 8300  ................
	defb 0dah,084h,0deh,007h,045h,04bh,051h,057h,05dh,063h,069h,0e6h,099h,001h,0a2h,0efh	; 8310  ....EKQW]ci.....
	defb 0dfh,002h,0deh,0deh,000h	; 8320

; ----------------------------------------------------------------------
; DATOS rle_pat_8325: patrones RLE: 25 tiles desde el 178 (lista 0x6e14)
;   0x8325..0x83ca  (165 bytes)
DATA_rle_pat_8325:
	defb 082h,047h,078h,004h,080h,083h,078h,047h,0e0h,006h,000h,083h,0e0h,002h,004h,004h	; 8325  .Gx...xG........
	defb 008h,084h,004h,002h,001h,07dh,004h,085h,088h,07dh,001h,000h,000h,07fh,040h,040h	; 8335  .....}...}....@@
	defb 07fh,004h,000h,08eh,0ffh,000h,000h,0ffh,000h,000h,001h,006h,0f8h,000h,000h,0f8h	; 8345  ................
	defb 006h,001h,008h,081h,003h,000h,002h,03fh,006h,000h,002h,0ffh,009h,000h,081h,004h	; 8355  .......?........
	defb 005h,000h,085h,008h,018h,0f8h,07bh,002h,005h,003h,08ah,007h,0ffh,000h,000h,0c0h	; 8365  ......{.........
	defb 0f8h,0ffh,0ffh,0aah,0ffh,005h,000h,083h,0e0h,0fch,0f8h,003h,000h,081h,030h,003h	; 8375  ..............0.
	defb 000h,09ah,030h,000h,0ffh,0ffh,02eh,0ffh,03eh,0c1h,07fh,000h,000h,001h,003h,00fh	; 8385  ..0.....>.......
	defb 03fh,07fh,000h,000h,004h,00ah,004h,000h,011h,00eh,000h,063h,005h,03fh,083h,07fh	; 8395  ?..........c.?..
	defb 000h,01fh,006h,0dfh,084h,000h,0ffh,0ffh,000h,003h,03fh,082h,0ffh,000h,005h,0f8h	; 83a5  ..........?.....
	defb 002h,0fch,089h,000h,048h,048h,030h,000h,084h,078h,000h,000h,003h,07fh,085h,078h	; 83b5  ....HH0..x.....x
	defb 070h,0c0h,000h,000h,000h	; 83c5

; ----------------------------------------------------------------------
; DATOS rle_pat_83CA: patrones RLE: 16 tiles desde el 219 (lista 0x6e14)
;   0x83ca..0x8424  (90 bytes)
DATA_rle_pat_83CA:
	defb 004h,000h,081h,07fh,003h,041h,081h,03fh,006h,040h,082h,03fh,080h,006h,040h,081h	; 83ca  .....A.?.@.?..@.
	defb 080h,006h,000h,082h,01fh,020h,006h,000h,002h,0ffh,081h,000h,005h,001h,083h,0e1h	; 83da  ..... ..........
	defb 011h,0ffh,007h,000h,081h,080h,007h,040h,007h,041h,089h,040h,00eh,00eh,015h,015h	; 83ea  .......@.A.@....
	defb 024h,024h,044h,05fh,004h,000h,002h,080h,082h,040h,0ffh,007h,040h,081h,0feh,007h	; 83fa  $$D_.....@..@...
	defb 000h,095h,07fh,009h,008h,004h,004h,002h,002h,001h,0feh,000h,0ffh,00ch,01ch,02ah	; 840a  ...............*
	defb 04ah,089h,0ffh,040h,080h,000h,0ffh,004h,081h,000h	; 841a  J..@......

; ----------------------------------------------------------------------
; DATOS rle_col_8424: colores RLE: 25 tiles desde el 64 (lista 0x6e14)
;   0x8424..0x846c  (72 bytes)
DATA_rle_col_8424:
	defb 056h,080h,081h,0e0h,005h,080h,081h,0f0h,003h,080h,081h,0f0h,00dh,080h,081h,0a0h	; 8424  V...............
	defb 00ch,080h,081h,0e0h,005h,080h,085h,0f0h,080h,0a8h,080h,0a8h,00fh,080h,082h,0e0h	; 8434  ................
	defb 0f0h,005h,080h,081h,0a0h,003h,080h,081h,0f8h,003h,080h,081h,0a0h,003h,080h,081h	; 8444  ................
	defb 0f0h,004h,080h,088h,0e0h,080h,080h,0f0h,0f0h,080h,080h,0a0h,007h,080h,082h,0e0h	; 8454  ................
	defb 0f0h,006h,080h,081h,0a0h,003h,080h,000h	; 8464  ........

; ----------------------------------------------------------------------
; DATOS rle_col_846C: colores RLE: 16 tiles desde el 105 (lista 0x6e14)
;   0x846c..0x8473  (7 bytes)
DATA_rle_col_846C:
	defb 027h,080h,081h,000h,058h,080h,000h	; 846c

; ----------------------------------------------------------------------
; DATOS rle_col_8473: colores RLE: 25 tiles desde el 121 (lista 0x6e14)
;   0x8473..0x84bb  (72 bytes)
DATA_rle_col_8473:
	defb 056h,040h,081h,0e0h,005h,040h,081h,0f0h,003h,040h,081h,0f0h,00dh,040h,081h,0a0h	; 8473  V@...@...@...@..
	defb 00ch,040h,081h,0e0h,005h,040h,085h,0f0h,040h,0a4h,040h,0a4h,00fh,040h,082h,0e0h	; 8483  .@...@..@.@..@..
	defb 0f0h,005h,040h,081h,0a0h,003h,040h,081h,0f4h,003h,040h,081h,0a0h,003h,040h,081h	; 8493  ..@...@...@...@.
	defb 0f0h,004h,040h,088h,0e0h,040h,040h,0f0h,0f0h,040h,040h,0a0h,007h,040h,082h,0e0h	; 84a3  ..@..@@..@@..@..
	defb 0f0h,006h,040h,081h,0a0h,003h,040h,000h	; 84b3  ..@...@.

; ----------------------------------------------------------------------
; DATOS rle_col_84BB: colores RLE: 16 tiles desde el 162 (lista 0x6e14)
;   0x84bb..0x84c2  (7 bytes)
DATA_rle_col_84BB:
	defb 027h,040h,081h,000h,058h,040h,000h	; 84bb

; ----------------------------------------------------------------------
; DATOS rle_col_84C2: colores RLE: 25 tiles desde el 178 (lista 0x6e14)
;   0x84c2..0x850a  (72 bytes)
DATA_rle_col_84C2:
	defb 056h,0a0h,081h,0e0h,005h,0a0h,081h,0f0h,003h,0a0h,081h,0f0h,00dh,0a0h,081h,080h	; 84c2  V...............
	defb 00ch,0a0h,081h,0e0h,005h,0a0h,085h,0f0h,0a0h,0a8h,0a0h,0a8h,00fh,0a0h,082h,0e0h	; 84d2  ................
	defb 0f0h,005h,0a0h,081h,080h,003h,0a0h,081h,0fah,003h,0a0h,081h,080h,003h,0a0h,081h	; 84e2  ................
	defb 0f0h,004h,0a0h,088h,0e0h,0a0h,0a0h,0f0h,0f0h,0a0h,0a0h,080h,007h,0a0h,082h,0e0h	; 84f2  ................
	defb 0f0h,006h,0a0h,081h,080h,003h,0a0h,000h	; 8502  ........

; ----------------------------------------------------------------------
; DATOS rle_col_850A: colores RLE: 16 tiles desde el 219 (lista 0x6e14)
;   0x850a..0x850f  (5 bytes)
DATA_rle_col_850A:
	defb 07fh,0a0h,081h,0a0h,000h	; 850a

; ----------------------------------------------------------------------
; DATOS rle_pat_850F: patrones RLE: 25 tiles desde el 170 (lista 0x6e4b)
;   0x850f..0x85b5  (166 bytes)
DATA_rle_pat_850F:
	defb 089h,041h,05eh,060h,0c0h,0c0h,060h,05eh,041h,0f0h,006h,000h,083h,0f0h,002h,004h	; 850f  .A^`..`^A.......
	defb 004h,008h,084h,004h,002h,000h,07eh,004h,081h,09ah,07eh,000h,090h,098h,08fh,088h	; 851f  ......~...~.....
	defb 088h,08fh,098h,090h,00fh,00bh,0eah,012h,012h,0eah,00bh,00fh,03eh,0a2h,0ffh,080h	; 852f  ............>...
	defb 080h,0ffh,0a2h,03eh,008h,081h,003h,000h,002h,03fh,006h,000h,002h,0ffh,009h,000h	; 853f  ...>.....?......
	defb 081h,004h,003h,000h,086h,00fh,008h,018h,078h,0fbh,063h,005h,000h,08bh,001h,0ffh	; 854f  ........x.c.....
	defb 0ffh,000h,040h,040h,000h,01fh,040h,04ah,04ah,004h,000h,084h,0f0h,000h,0a0h,0a8h	; 855f  ..@@..@JJ.......
	defb 003h,000h,081h,030h,003h,000h,083h,030h,000h,07fh,004h,0ffh,093h,07fh,03fh,000h	; 856f  ...0...0......?.
	defb 000h,001h,003h,00fh,03fh,07fh,000h,000h,004h,00ah,004h,000h,011h,00eh,000h,07fh	; 857f  ....?...........
	defb 005h,03fh,085h,07fh,000h,0ffh,0ffh,01fh,004h,0dfh,003h,000h,004h,0ffh,081h,0f0h	; 858f  .?..............
	defb 003h,000h,004h,0c0h,002h,000h,002h,048h,08ah,030h,000h,084h,078h,000h,000h,01fh	; 859f  .......H.0..x...
	defb 04fh,067h,040h,004h,000h,000h	; 85af

; ----------------------------------------------------------------------
; DATOS rle_pat_85B5: patrones RLE: 14 tiles desde el 209 (lista 0x6e4b)
;   0x85b5..0x8608  (83 bytes)
DATA_rle_pat_85B5:
	defb 004h,000h,081h,07fh,003h,041h,081h,03fh,006h,040h,082h,03fh,080h,006h,040h,082h	; 85b5  .....A.?.@.?..@.
	defb 080h,000h,007h,001h,081h,0ffh,007h,000h,081h,080h,007h,040h,007h,041h,089h,040h	; 85c5  ...........@.A.@
	defb 00eh,00eh,015h,015h,024h,024h,044h,04fh,004h,000h,002h,080h,085h,040h,0ffh,01fh	; 85d5  ....$$DO.....@..
	defb 020h,020h,004h,040h,002h,0ffh,004h,000h,097h,03fh,040h,09fh,0c1h,040h,040h,07ch	; 85e5    .@.....?@..@@|
	defb 042h,0c2h,002h,0f9h,000h,0ffh,00ch,01ch,02ah,04ah,089h,0ffh,040h,080h,000h,0ffh	; 85f5  B.......*J..@...
	defb 004h,081h,000h	; 8605

; ----------------------------------------------------------------------
; DATOS rle_pat_8608: patrones RLE: 6 tiles desde el 10 (lista 0x6e0d)
;   0x8608..0x8627  (31 bytes)
DATA_rle_pat_8608:
	defb 003h,000h,002h,0ffh,003h,000h,008h,018h,003h,000h,002h,01fh,003h,018h,003h,000h	; 8608  ................
	defb 002h,0f8h,006h,018h,002h,01fh,003h,000h,003h,018h,002h,0f8h,003h,000h,000h	; 8618  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_8627: colores RLE: 25 tiles desde el 64 (lista 0x6e4b)
;   0x8627..0x8666  (63 bytes)
DATA_rle_col_8627:
	defb 040h,050h,081h,000h,015h,050h,081h,0e0h,004h,050h,081h,0f0h,009h,050h,002h,0f0h	; 8627  @P...P...P...P..
	defb 086h,050h,0e0h,0e0h,0f0h,0f0h,050h,003h,0f0h,006h,050h,002h,0f0h,003h,050h,081h	; 8637  .P....P...P...P.
	defb 0e0h,005h,050h,081h,0feh,013h,050h,082h,0e0h,0f0h,00bh,050h,081h,0f5h,007h,050h	; 8647  ..P...P....P...P
	defb 082h,0ffh,055h,006h,050h,081h,0f0h,009h,050h,082h,0e0h,0f0h,00ah,050h,000h	; 8657  ..U.P...P....P.

; ----------------------------------------------------------------------
; DATOS rle_col_8666: colores RLE: 14 tiles desde el 103 (lista 0x6e4b)
;   0x8666..0x8669  (3 bytes)
DATA_rle_col_8666:
	defb 070h,050h,000h	; 8666

; ----------------------------------------------------------------------
; DATOS rle_col_8669: colores RLE: 25 tiles desde el 117 (lista 0x6e4b)
;   0x8669..0x86a4  (59 bytes)
DATA_rle_col_8669:
	defb 056h,080h,081h,0e0h,004h,080h,081h,0f0h,009h,080h,002h,0f0h,086h,080h,0e0h,0e0h	; 8669  V...............
	defb 0f0h,0f0h,080h,003h,0f0h,006h,080h,002h,0f0h,084h,080h,0e0h,080h,0e0h,005h,080h	; 8679  ................
	defb 081h,0feh,013h,080h,082h,0e0h,0f0h,00bh,080h,081h,0f8h,007h,080h,081h,0f0h,007h	; 8689  ................
	defb 080h,081h,0f0h,009h,080h,082h,0e0h,0f0h,00ah,080h,000h	; 8699  ...........

; ----------------------------------------------------------------------
; DATOS rle_col_86A4: colores RLE: 14 tiles desde el 156 (lista 0x6e4b)
;   0x86a4..0x86a7  (3 bytes)
DATA_rle_col_86A4:
	defb 070h,080h,000h	; 86a4

; ----------------------------------------------------------------------
; DATOS rle_col_86A7: colores RLE: 25 tiles desde el 170 (lista 0x6e4b)
;   0x86a7..0x86dd  (54 bytes)
DATA_rle_col_86A7:
	defb 056h,070h,005h,0e0h,081h,0f0h,009h,070h,002h,0f0h,086h,070h,0e0h,0e0h,0f0h,0f0h	; 86a7  Vp.....p...p....
	defb 070h,003h,0f0h,006h,070h,002h,0f0h,004h,0e0h,005h,070h,081h,0feh,013h,070h,082h	; 86b7  p...p.....p...p.
	defb 0e0h,0f0h,00bh,070h,081h,0f7h,007h,070h,081h,0f0h,007h,070h,081h,0f0h,009h,070h	; 86c7  ...p...p...p...p
	defb 082h,0e0h,0f0h,00ah,070h,000h	; 86d7

; ----------------------------------------------------------------------
; DATOS rle_col_86DD: colores RLE: 14 tiles desde el 209 (lista 0x6e4b)
;   0x86dd..0x86e0  (3 bytes)
DATA_rle_col_86DD:
	defb 070h,070h,000h	; 86dd

; ----------------------------------------------------------------------
; DATOS rle_col_86E0: colores RLE: 6 tiles desde el 10 (lista 0x6e0d)
;   0x86e0..0x86e3  (3 bytes)
DATA_rle_col_86E0:
	defb 030h,0e0h,000h	; 86e0

; ----------------------------------------------------------------------
; DATOS rle_pat_86E3: patrones RLE: 15 tiles desde el 158 (lista 0x6e82)
;   0x86e3..0x8740  (93 bytes)
DATA_rle_pat_86E3:
	defb 003h,000h,002h,03fh,006h,000h,002h,0ffh,009h,000h,081h,010h,006h,000h,002h,0c0h	; 86e3  ...?............
	defb 081h,03fh,003h,000h,085h,018h,01ch,01eh,01fh,0ffh,006h,000h,082h,03fh,0feh,006h	; 86f3  .?...........?..
	defb 000h,082h,020h,003h,003h,000h,002h,07ch,083h,078h,070h,060h,005h,000h,002h,001h	; 8703  .. ....|.xp`....
	defb 002h,000h,093h,006h,00eh,03eh,07ah,0fah,0fah,000h,001h,010h,028h,010h,000h,044h	; 8713  .....>z.....(..D
	defb 038h,000h,0ffh,0ffh,00fh,00fh,003h,0efh,081h,000h,007h,0ffh,081h,000h,003h,0fch	; 8723  8...............
	defb 004h,0f8h,089h,000h,001h,020h,050h,020h,001h,088h,070h,000h,000h	; 8733  ..... P ..p..

; ----------------------------------------------------------------------
; DATOS rle_pat_8740: patrones RLE: 16 tiles desde el 189 (lista 0x6e82)
;   0x8740..0x87aa  (106 bytes)
DATA_rle_pat_8740:
	defb 003h,000h,005h,001h,003h,000h,081h,0feh,004h,002h,081h,07eh,004h,081h,083h,07eh	; 8740  ...........~...~
	defb 038h,054h,003h,000h,081h,00fh,004h,010h,003h,000h,081h,0ffh,005h,000h,002h,001h	; 8750  8T..............
	defb 086h,0f9h,005h,005h,002h,002h,0feh,005h,001h,082h,0feh,038h,005h,000h,083h,0fch	; 8760  ...........8....
	defb 084h,084h,004h,001h,082h,000h,001h,004h,002h,08ah,000h,003h,07ch,0c0h,000h,000h	; 8770  ............|...
	defb 052h,091h,090h,0ffh,004h,000h,002h,010h,08bh,09fh,0e0h,00fh,010h,020h,020h,000h	; 8780  R............  .
	defb 000h,0ffh,000h,0f0h,003h,010h,002h,001h,081h,0ffh,003h,000h,085h,03fh,041h,054h	; 8790  .............?AT
	defb 092h,0feh,003h,002h,082h,0feh,000h,008h,084h,000h	; 87a0  ..........

; ----------------------------------------------------------------------
; DATOS rle_col_87AA: colores RLE: 15 tiles desde el 64 (lista 0x6e82)
;   0x87aa..0x87d9  (47 bytes)
DATA_rle_col_87AA:
	defb 016h,050h,081h,0e0h,006h,050h,002h,0e0h,081h,0e5h,007h,050h,021h,0e0h,004h,050h	; 87aa  .P...P.....P!..P
	defb 003h,0e0h,006h,050h,082h,0e0h,0f0h,003h,050h,081h,0feh,007h,050h,081h,0f0h,007h	; 87ba  ...P....P...P...
	defb 050h,081h,0f0h,005h,050h,081h,0e0h,003h,050h,002h,0e0h,082h,0f0h,050h,000h	; 87ca  P...P...P....P.

; ----------------------------------------------------------------------
; DATOS rle_col_87D9: colores RLE: 16 tiles desde el 95 (lista 0x6e82)
;   0x87d9..0x87de  (5 bytes)
DATA_rle_col_87D9:
	defb 07fh,050h,081h,050h,000h	; 87d9

; ----------------------------------------------------------------------
; DATOS rle_col_87DE: colores RLE: 15 tiles desde el 111 (lista 0x6e82)
;   0x87de..0x8812  (52 bytes)
DATA_rle_col_87DE:
	defb 016h,080h,081h,0e0h,006h,080h,002h,0e0h,081h,0e8h,003h,000h,004h,080h,021h,0e0h	; 87de  ..............!.
	defb 004h,080h,003h,0e0h,006h,080h,082h,0e0h,0f0h,003h,080h,081h,0feh,007h,080h,081h	; 87ee  ................
	defb 0ffh,004h,080h,084h,000h,080h,080h,0f0h,005h,080h,081h,0e0h,003h,080h,002h,0e0h	; 87fe  ................
	defb 082h,0f0h,080h,000h	; 880e

; ----------------------------------------------------------------------
; DATOS rle_col_8812: colores RLE: 16 tiles desde el 142 (lista 0x6e82)
;   0x8812..0x8817  (5 bytes)
DATA_rle_col_8812:
	defb 07fh,080h,081h,080h,000h	; 8812

; ----------------------------------------------------------------------
; DATOS rle_col_8817: colores RLE: 15 tiles desde el 158 (lista 0x6e82)
;   0x8817..0x884b  (52 bytes)
DATA_rle_col_8817:
	defb 016h,0c0h,081h,0e0h,006h,0c0h,002h,0e0h,081h,0ech,007h,0c0h,081h,0eeh,020h,0e0h	; 8817  .............. .
	defb 004h,0c0h,004h,0e0h,005h,0c0h,082h,0e0h,0f0h,003h,0c0h,081h,0feh,004h,0c0h,084h	; 8827  ................
	defb 000h,0c0h,0c0h,0f0h,007h,0c0h,081h,0f0h,005h,0c0h,081h,0e0h,003h,0c0h,002h,0e0h	; 8837  ................
	defb 082h,0f0h,000h,000h	; 8847

; ----------------------------------------------------------------------
; DATOS rle_col_884B: colores RLE: 16 tiles desde el 189 (lista 0x6e82)
;   0x884b..0x8854  (9 bytes)
DATA_rle_col_884B:
	defb 003h,000h,005h,0c0h,081h,000h,077h,0c0h,000h	; 884b  ......w..

; ----------------------------------------------------------------------
; DATOS rle_pat_8854: patrones RLE: 17 tiles desde el 64 (lista 0x6eb9)
;   0x8854..0x88cd  (121 bytes)
DATA_rle_pat_8854:
	defb 003h,000h,002h,03fh,006h,000h,002h,0ffh,00ah,000h,081h,001h,005h,000h,0a8h,03fh	; 8854  ...?...........?
	defb 0c0h,080h,000h,000h,003h,00ch,030h,0c0h,0f1h,07dh,000h,0ffh,011h,021h,041h,081h	; 8864  ......0..}...!A.
	defb 000h,0ffh,000h,080h,0f0h,00fh,003h,03ch,01fh,0c0h,000h,000h,007h,0f8h,0c0h,0fch	; 8874  .......<........
	defb 0f0h,0e0h,000h,01fh,0e0h,0ffh,0c0h,003h,000h,004h,0f0h,002h,000h,089h,0c0h,080h	; 8884  ................
	defb 001h,005h,009h,013h,007h,07fh,07fh,003h,000h,086h,00eh,004h,000h,011h,00eh,000h	; 8894  ................
	defb 003h,03dh,081h,000h,003h,03fh,081h,000h,003h,0ffh,081h,000h,003h,0ffh,081h,000h	; 88a4  .=...?..........
	defb 003h,0dfh,081h,000h,003h,0ffh,085h,000h,0e0h,0c0h,0c0h,000h,003h,0c0h,002h,000h	; 88b4  ................
	defb 087h,070h,020h,000h,088h,070h,000h,000h,000h	; 88c4  .p ..p...

; ----------------------------------------------------------------------
; DATOS rle_pat_88CD: patrones RLE: 16 tiles desde el 97 (lista 0x6eb9)
;   0x88cd..0x892e  (97 bytes)
DATA_rle_pat_88CD:
	defb 002h,000h,082h,03fh,021h,003h,041h,084h,07fh,000h,07fh,080h,006h,000h,083h,0e0h	; 88cd  ...?!.A.........
	defb 01fh,000h,004h,002h,083h,000h,001h,0feh,006h,000h,083h,0ffh,000h,000h,004h,040h	; 88dd  ...............@
	defb 082h,003h,0fch,006h,000h,081h,0ffh,007h,000h,081h,0f0h,007h,010h,003h,040h,081h	; 88ed  ..............@.
	defb 041h,004h,042h,085h,07fh,000h,001h,082h,004h,003h,008h,082h,03fh,0c0h,006h,000h	; 88fd  A.B.........?...
	defb 084h,07fh,081h,040h,02fh,004h,011h,084h,040h,000h,007h,038h,004h,040h,085h,000h	; 890d  ...@/...@..8.@..
	defb 01fh,0e0h,000h,07fh,003h,081h,082h,000h,0ffh,006h,000h,082h,010h,0f0h,006h,040h	; 891d  ...............@
	defb 000h	; 892d

; ----------------------------------------------------------------------
; DATOS rle_pat_892E: patrones RLE: 20 tiles desde el 113 (lista 0x6eb9)
;   0x892e..0x89b6  (136 bytes)
DATA_rle_pat_892E:
	defb 003h,000h,002h,03fh,006h,000h,002h,0ffh,003h,000h,008h,010h,006h,000h,002h,007h	; 892e  ...?............
	defb 006h,000h,082h,0f0h,0e0h,007h,000h,081h,001h,005h,000h,0a8h,03fh,0c0h,080h,000h	; 893e  ............?...
	defb 000h,003h,00ch,030h,0c0h,0f1h,07dh,000h,0ffh,011h,021h,041h,081h,0ffh,0ffh,000h	; 894e  ...0..}...!A....
	defb 080h,0f0h,00fh,003h,03ch,01fh,0c0h,000h,000h,007h,0f8h,0c0h,0fch,0f0h,0e0h,000h	; 895e  ....<...........
	defb 007h,0f8h,0ffh,0c0h,003h,000h,081h,010h,003h,0f0h,002h,000h,089h,0c0h,080h,001h	; 896e  ................
	defb 005h,009h,013h,007h,07fh,07fh,003h,000h,086h,00eh,004h,000h,011h,00eh,000h,003h	; 897e  ................
	defb 03dh,081h,000h,003h,03fh,081h,000h,003h,0ffh,081h,000h,003h,0ffh,081h,000h,003h	; 898e  =...?...........
	defb 0dfh,081h,000h,003h,0ffh,085h,000h,0e0h,0c0h,0c0h,000h,003h,0c0h,002h,000h,087h	; 899e  ................
	defb 070h,020h,000h,088h,070h,000h,000h,000h	; 89ae  p ..p...

; ----------------------------------------------------------------------
; DATOS rle_pat_89B6: patrones RLE: 15 tiles desde el 148 (lista 0x6eb9)
;   0x89b6..0x8a12  (92 bytes)
DATA_rle_pat_89B6:
	defb 002h,000h,082h,03fh,021h,003h,041h,084h,07fh,000h,07fh,080h,006h,000h,083h,0e0h	; 89b6  ...?!.A.........
	defb 01fh,000h,004h,002h,083h,000h,001h,0feh,006h,000h,083h,0ffh,000h,000h,004h,040h	; 89c6  ...............@
	defb 082h,003h,0fch,006h,000h,081h,0ffh,007h,004h,081h,0f0h,007h,010h,003h,040h,081h	; 89d6  ..............@.
	defb 041h,004h,042h,085h,07fh,000h,001h,082h,004h,003h,008h,082h,03fh,0c0h,006h,000h	; 89e6  A.B.........?...
	defb 084h,07fh,081h,040h,02fh,004h,011h,084h,040h,000h,007h,038h,004h,040h,085h,000h	; 89f6  ...@/...@..8.@..
	defb 01fh,0e0h,000h,07fh,003h,081h,082h,004h,0fch,006h,004h,000h	; 8a06  ............

; ----------------------------------------------------------------------
; DATOS rle_pat_8A12: patrones RLE: 19 tiles desde el 163 (lista 0x6eb9)
;   0x8a12..0x8a90  (126 bytes)
DATA_rle_pat_8A12:
	defb 008h,081h,003h,000h,002h,03fh,006h,000h,002h,0ffh,00ah,000h,081h,001h,005h,000h	; 8a12  .....?..........
	defb 09bh,03fh,0c0h,080h,000h,000h,003h,00ch,030h,0c0h,0f1h,07dh,000h,0ffh,011h,021h	; 8a22  .?......0..}...!
	defb 041h,081h,000h,0ffh,000h,080h,0f0h,00fh,000h,000h,01fh,0c0h,004h,000h,084h,0f7h	; 8a32  A...............
	defb 0f8h,0feh,0fch,003h,000h,087h,01fh,0e0h,0ffh,003h,001h,000h,000h,006h,0ffh,087h	; 8a42  ................
	defb 001h,005h,009h,013h,007h,07fh,07fh,003h,000h,086h,00eh,004h,000h,011h,00eh,000h	; 8a52  ................
	defb 003h,03dh,081h,000h,003h,03fh,081h,000h,003h,0ffh,081h,000h,003h,0ffh,081h,000h	; 8a62  .=...?..........
	defb 003h,0dfh,081h,000h,003h,0ffh,081h,000h,003h,0f8h,081h,000h,003h,0f8h,002h,000h	; 8a72  ................
	defb 08ah,070h,020h,000h,088h,070h,000h,000h,0fch,0f0h,0c0h,005h,000h,000h	; 8a82  .p ..p........

; ----------------------------------------------------------------------
; DATOS rle_pat_8A90: patrones RLE: 15 tiles desde el 197 (lista 0x6eb9)
;   0x8a90..0x8aec  (92 bytes)
DATA_rle_pat_8A90:
	defb 002h,000h,082h,03fh,021h,003h,041h,084h,07fh,0ffh,07fh,080h,006h,000h,083h,0e0h	; 8a90  ...?!.A.........
	defb 01fh,000h,004h,002h,002h,000h,081h,0ffh,006h,000h,083h,00fh,0f0h,000h,004h,040h	; 8aa0  ...............@
	defb 082h,003h,0fch,006h,000h,081h,0ffh,007h,000h,081h,0ffh,007h,081h,003h,040h,081h	; 8ab0  ..............@.
	defb 041h,004h,042h,085h,07fh,000h,001h,082h,004h,003h,008h,082h,03fh,0c0h,006h,000h	; 8ac0  A.B.........?...
	defb 084h,07fh,081h,040h,02fh,004h,011h,084h,040h,000h,007h,038h,004h,040h,085h,000h	; 8ad0  ...@/...@..8.@..
	defb 01fh,0e0h,000h,07fh,003h,081h,082h,000h,0ffh,006h,000h,000h	; 8ae0  ............

; ----------------------------------------------------------------------
; DATOS rle_col_8AEC: colores RLE: 17 tiles desde el 64 (lista 0x6eb9)
;   0x8aec..0x8b35  (73 bytes)
DATA_rle_col_8AEC:
	defb 016h,070h,009h,0f0h,081h,070h,005h,0e0h,002h,0f0h,083h,070h,0f0h,0f0h,005h,070h	; 8aec  .p...p.....p...p
	defb 084h,0f0h,070h,0f0h,0f0h,003h,0f7h,082h,070h,0f7h,003h,0f0h,002h,0f7h,003h,070h	; 8afc  ..p.....p......p
	defb 002h,0f0h,081h,0f7h,005h,070h,081h,0f0h,00bh,070h,004h,090h,005h,040h,083h,0e0h	; 8b0c  .....p...p...@..
	defb 0f0h,0f0h,004h,070h,004h,090h,004h,070h,004h,090h,004h,070h,004h,090h,004h,070h	; 8b1c  ...p...p...p...p
	defb 004h,090h,004h,040h,081h,0e0h,003h,0f0h,000h	; 8b2c  ...@.....

; ----------------------------------------------------------------------
; DATOS rle_col_8B35: colores RLE: 16 tiles desde el 97 (lista 0x6eb9)
;   0x8b35..0x8b3a  (5 bytes)
DATA_rle_col_8B35:
	defb 07fh,070h,081h,070h,000h	; 8b35

; ----------------------------------------------------------------------
; DATOS rle_col_8B3A: colores RLE: 20 tiles desde el 113 (lista 0x6eb9)
;   0x8b3a..0x8b8b  (81 bytes)
DATA_rle_col_8B3A:
	defb 01eh,0c0h,081h,0f0h,007h,0c0h,081h,0f0h,008h,0c0h,008h,0f0h,081h,0c0h,005h,0e0h	; 8b3a  ................
	defb 002h,0f0h,083h,0c0h,0f0h,0f0h,004h,0c0h,081h,000h,004h,0f0h,003h,0fch,082h,0c0h	; 8b4a  ................
	defb 0fch,003h,0f0h,002h,0fch,003h,0c0h,002h,0f0h,081h,0fch,006h,0c0h,081h,0f0h,00ah	; 8b5a  ................
	defb 0c0h,003h,0e0h,006h,0c0h,083h,0e0h,0f0h,0f0h,004h,0c0h,004h,0e0h,004h,0c0h,004h	; 8b6a  ................
	defb 0e0h,004h,0c0h,004h,0e0h,004h,0c0h,004h,0e0h,004h,0c0h,084h,0e0h,0f0h,0c0h,0c0h	; 8b7a  ................
	defb 000h	; 8b8a

; ----------------------------------------------------------------------
; DATOS rle_col_8B8B: colores RLE: 15 tiles desde el 148 (lista 0x6eb9)
;   0x8b8b..0x8b8e  (3 bytes)
DATA_rle_col_8B8B:
	defb 078h,0c0h,000h	; 8b8b

; ----------------------------------------------------------------------
; DATOS rle_col_8B8E: colores RLE: 19 tiles desde el 163 (lista 0x6eb9)
;   0x8b8e..0x8bd9  (75 bytes)
DATA_rle_col_8B8E:
	defb 01eh,080h,002h,0f0h,005h,080h,002h,0f0h,081h,080h,005h,0e0h,002h,0f0h,083h,080h	; 8b8e  ................
	defb 0f0h,0ffh,005h,080h,004h,0f0h,003h,0f8h,082h,0f0h,0f8h,005h,0f0h,081h,0f8h,004h	; 8b9e  ................
	defb 080h,002h,0f0h,081h,0f8h,005h,080h,081h,0f0h,009h,080h,003h,0a0h,006h,080h,083h	; 8bae  ................
	defb 0e0h,0f0h,0f0h,004h,080h,004h,0a0h,004h,080h,004h,0a0h,004h,080h,004h,0a0h,004h	; 8bbe  ................
	defb 080h,004h,0a0h,004h,080h,082h,0e0h,0f0h,00ah,080h,000h	; 8bce  ...........

; ----------------------------------------------------------------------
; DATOS rle_col_8BD9: colores RLE: 15 tiles desde el 197 (lista 0x6eb9)
;   0x8bd9..0x8bdc  (3 bytes)
DATA_rle_col_8BD9:
	defb 078h,080h,000h	; 8bd9

; ----------------------------------------------------------------------
; DATOS rle_pat_8BDC: patrones RLE: 2 tiles desde el 164 (lista 0x6ef0)
;   0x8bdc..0x8be7  (11 bytes)
DATA_rle_pat_8BDC:
	defb 003h,000h,002h,03fh,006h,000h,002h,0ffh,003h,000h,000h	; 8bdc  ...?.......

; ----------------------------------------------------------------------
; DATOS rle_pat_8BE7: patrones RLE: 21 tiles desde el 66 (lista 0x6ef0)
;   0x8be7..0x8c6e  (135 bytes)
DATA_rle_pat_8BE7:
	defb 006h,000h,082h,003h,00ch,006h,000h,081h,0ffh,007h,000h,082h,0c0h,030h,005h,000h	; 8be7  .............0..
	defb 083h,001h,007h,01fh,004h,000h,002h,03fh,08eh,0e0h,0c0h,000h,0fch,003h,007h,0ffh	; 8bf7  .......?........
	defb 0c0h,020h,06fh,030h,0c0h,000h,000h,004h,0ffh,004h,000h,004h,0feh,093h,00eh,003h	; 8c07  . o0............
	defb 003h,007h,0f9h,0feh,0fch,0f8h,000h,0c0h,0fch,0f8h,087h,001h,000h,000h,0fch,0f8h	; 8c17  ................
	defb 000h,005h,0f8h,003h,03fh,002h,000h,002h,07fh,089h,000h,080h,080h,08ah,004h,000h	; 8c27  ....?...........
	defb 011h,00eh,000h,003h,02fh,002h,000h,002h,03fh,081h,000h,003h,0ffh,002h,000h,002h	; 8c37  ..../...?.......
	defb 0ffh,099h,000h,0feh,0feh,0fdh,000h,000h,0ffh,0ffh,000h,0f8h,0f8h,0f0h,000h,000h	; 8c47  ................
	defb 0f8h,0f0h,000h,000h,048h,030h,000h,084h,078h,000h,000h,003h,070h,082h,060h,040h	; 8c57  ....H0..x...p.`@
	defb 003h,000h,008h,022h,008h,004h,000h	; 8c67

; ----------------------------------------------------------------------
; DATOS rle_pat_8C6E: patrones RLE: 14 tiles desde el 101 (lista 0x6ef0)
;   0x8c6e..0x8cc6  (88 bytes)
DATA_rle_pat_8C6E:
	defb 002h,000h,082h,007h,019h,004h,021h,085h,00fh,070h,080h,040h,03fh,003h,000h,085h	; 8c6e  ......!..p.@?...
	defb 0ffh,008h,004h,003h,0fch,003h,000h,099h,0ffh,000h,000h,0ffh,000h,000h,07fh,080h	; 8c7e  ................
	defb 0ffh,000h,000h,0ffh,000h,000h,0ffh,000h,0ffh,008h,010h,0e0h,000h,000h,0fch,008h	; 8c8e  ................
	defb 0ffh,006h,002h,082h,0c2h,0f8h,007h,004h,081h,03eh,007h,020h,006h,000h,003h,001h	; 8c9e  .........>. ....
	defb 002h,002h,002h,004h,084h,0fch,004h,004h,000h,003h,001h,004h,002h,081h,0ffh,007h	; 8cae  ................
	defb 000h,083h,0f1h,002h,004h,005h,008h,000h	; 8cbe  ........

; ----------------------------------------------------------------------
; DATOS rle_pat_8CC6: patrones RLE: 19 tiles desde el 117 (lista 0x6ef0)
;   0x8cc6..0x8d46  (128 bytes)
DATA_rle_pat_8CC6:
	defb 005h,000h,083h,001h,007h,018h,005h,000h,002h,0ffh,081h,00fh,005h,000h,083h,080h	; 8cc6  ................
	defb 0e0h,018h,005h,000h,083h,007h,03fh,07fh,004h,000h,08eh,01fh,00eh,0e0h,0c0h,000h	; 8cd6  ......?.........
	defb 0feh,001h,006h,0f8h,007h,0ffh,07fh,020h,0c0h,003h,000h,003h,0ffh,004h,00fh,081h	; 8ce6  ....... ........
	defb 000h,003h,0ffh,0b6h,006h,001h,000h,001h,00fh,0ffh,0feh,0fch,0feh,0f8h,000h,0e0h	; 8cf6  ................
	defb 0e0h,0f0h,0f0h,0f8h,07fh,07fh,000h,000h,03fh,03fh,03eh,000h,080h,080h,00ah,004h	; 8d06  ........??>.....
	defb 000h,011h,00eh,000h,03fh,03fh,000h,03ch,03fh,03fh,000h,000h,0ffh,0ffh,000h,000h	; 8d16  ....??.<??......
	defb 0ffh,0ffh,000h,000h,0fch,0f8h,000h,000h,0f8h,0f8h,003h,000h,08ch,048h,030h,000h	; 8d26  .............H0.
	defb 084h,078h,000h,000h,0f8h,000h,000h,0f0h,0c0h,003h,000h,008h,022h,008h,004h,000h	; 8d36  .x.........."...

; ----------------------------------------------------------------------
; DATOS rle_pat_8D46: patrones RLE: 14 tiles desde el 150 (lista 0x6ef0)
;   0x8d46..0x8d9e  (88 bytes)
DATA_rle_pat_8D46:
	defb 002h,000h,082h,007h,019h,004h,021h,085h,00fh,070h,080h,040h,03fh,003h,000h,085h	; 8d46  ......!..p.@?...
	defb 0ffh,008h,004h,003h,0fch,003h,000h,099h,0ffh,000h,000h,0ffh,000h,000h,07fh,080h	; 8d56  ................
	defb 0ffh,000h,000h,0ffh,000h,000h,07fh,000h,0ffh,008h,010h,0e0h,000h,000h,0fch,008h	; 8d66  ................
	defb 0ffh,006h,002h,082h,0c2h,0f8h,007h,004h,081h,03eh,007h,020h,006h,000h,003h,001h	; 8d76  .........>. ....
	defb 002h,002h,002h,004h,084h,0fch,004h,004h,000h,003h,001h,004h,002h,081h,0ffh,007h	; 8d86  ................
	defb 000h,083h,0f1h,002h,004h,005h,008h,000h	; 8d96  ........

; ----------------------------------------------------------------------
; DATOS rle_pat_8D9E: patrones RLE: 20 tiles desde el 166 (lista 0x6ef0)
;   0x8d9e..0x8e22  (132 bytes)
DATA_rle_pat_8D9E:
	defb 007h,000h,081h,01fh,007h,000h,081h,0feh,006h,000h,082h,0ffh,0feh,007h,000h,081h	; 8d9e  ................
	defb 001h,004h,000h,08dh,003h,01fh,060h,080h,000h,003h,00ch,070h,0e0h,0f0h,0c0h,03fh	; 8dae  ......`....p...?
	defb 0e0h,005h,000h,002h,0ffh,003h,00fh,002h,000h,090h,003h,0feh,0e0h,0f8h,007h,0ffh	; 8dbe  ................
	defb 000h,007h,0ffh,01ch,018h,000h,0f0h,00fh,07fh,0ffh,004h,000h,09fh,078h,0f8h,0fch	; 8dce  .............x..
	defb 0fch,000h,0ffh,070h,007h,00fh,03fh,07fh,0ffh,0ffh,07eh,000h,080h,000h,00ah,004h	; 8dde  ...p..?...~.....
	defb 000h,011h,00eh,000h,03fh,01fh,01fh,000h,000h,01fh,00fh,000h,003h,0ffh,002h,000h	; 8dee  ....?...........
	defb 002h,0ffh,09ch,000h,0e0h,0feh,0ffh,000h,000h,0ffh,0ffh,000h,018h,018h,0f8h,000h	; 8dfe  ................
	defb 000h,0f8h,0f0h,000h,000h,048h,030h,000h,084h,078h,000h,000h,070h,060h,040h,005h	; 8e0e  .....H0..x..p`@.
	defb 000h,008h,081h,000h	; 8e1e

; ----------------------------------------------------------------------
; DATOS rle_pat_8E22: patrones RLE: 15 tiles desde el 201 (lista 0x6ef0)
;   0x8e22..0x8e87  (101 bytes)
DATA_rle_pat_8E22:
	defb 002h,000h,082h,007h,01dh,004h,025h,082h,00fh,0f0h,006h,000h,084h,0ffh,008h,004h	; 8e22  ......%.........
	defb 003h,003h,000h,09ah,003h,0ffh,000h,000h,0ffh,000h,000h,0ffh,000h,0ffh,000h,000h	; 8e32  ................
	defb 0ffh,000h,000h,0fbh,008h,0ffh,008h,010h,0e0h,000h,000h,0ffh,000h,0ffh,005h,000h	; 8e42  ................
	defb 083h,0e0h,01eh,0fch,003h,004h,084h,000h,0ffh,081h,081h,003h,025h,081h,03fh,004h	; 8e52  ............%.?.
	defb 020h,003h,000h,005h,001h,083h,00ch,030h,0c0h,007h,000h,081h,00fh,005h,010h,002h	; 8e62   ......0........
	defb 008h,081h,0f9h,006h,001h,084h,01eh,0e0h,000h,01fh,003h,010h,081h,0e0h,003h,000h	; 8e72  ................
	defb 081h,0feh,003h,002h,000h	; 8e82

; ----------------------------------------------------------------------
; DATOS rle_col_8E87: colores RLE: 2 tiles desde el 64 (lista 0x6ef0)
;   0x8e87..0x8e8a  (3 bytes)
DATA_rle_col_8E87:
	defb 010h,080h,000h	; 8e87

; ----------------------------------------------------------------------
; DATOS rle_col_8E8A: colores RLE: 21 tiles desde el 66 (lista 0x6ef0)
;   0x8e8a..0x8ed7  (77 bytes)
DATA_rle_col_8E8A:
	defb 007h,080h,081h,0e0h,01dh,080h,090h,0f8h,0f0h,080h,080h,0f0h,0e8h,0e0h,080h,0f8h	; 8e8a  ................
	defb 0f8h,080h,0e0h,0e0h,080h,080h,0f0h,007h,080h,081h,0f0h,007h,080h,081h,0f8h,004h	; 8e9a  ................
	defb 080h,088h,0e0h,080h,0f8h,080h,0e0h,080h,080h,0e0h,009h,080h,006h,0e0h,002h,080h	; 8eaa  ................
	defb 004h,0e0h,081h,0f0h,003h,080h,006h,0e0h,002h,080h,006h,0e0h,002h,080h,006h,0e0h	; 8eba  ................
	defb 002h,080h,00bh,0e0h,003h,0f0h,002h,080h,003h,0e0h,013h,080h,000h	; 8eca  .............

; ----------------------------------------------------------------------
; DATOS rle_col_8ED7: colores RLE: 14 tiles desde el 101 (lista 0x6ef0)
;   0x8ed7..0x8eda  (3 bytes)
DATA_rle_col_8ED7:
	defb 070h,080h,000h	; 8ed7

; ----------------------------------------------------------------------
; DATOS rle_col_8EDA: colores RLE: 2 tiles desde el 115 (lista 0x6ef0)
;   0x8eda..0x8edd  (3 bytes)
DATA_rle_col_8EDA:
	defb 010h,040h,000h	; 8eda

; ----------------------------------------------------------------------
; DATOS rle_col_8EDD: colores RLE: 19 tiles desde el 117 (lista 0x6ef0)
;   0x8edd..0x8f3d  (96 bytes)
DATA_rle_col_8EDD:
	defb 005h,040h,083h,0f0h,040h,0e0h,005h,040h,081h,0f0h,007h,040h,083h,0f0h,040h,0e0h	; 8edd  .@..@..@...@..@.
	defb 009h,040h,081h,0f0h,003h,040h,081h,0f4h,003h,040h,087h,0f0h,0e4h,0e0h,040h,0f4h	; 8eed  .@...@...@....@.
	defb 040h,040h,005h,0e0h,081h,0f0h,007h,040h,085h,0f0h,040h,040h,0e0h,0e0h,003h,0f0h	; 8efd  @@.....@..@@....
	defb 084h,0f4h,040h,040h,0e0h,007h,040h,082h,060h,0a0h,006h,040h,082h,060h,0a0h,003h	; 8f0d  ..@@..@.`..@.`..
	defb 040h,085h,0e0h,0f0h,0f0h,060h,0a0h,006h,040h,082h,060h,0a0h,006h,040h,082h,060h	; 8f1d  @....`..@.`..@.`
	defb 0a0h,006h,040h,081h,0a0h,003h,040h,081h,0e0h,003h,0f0h,081h,0a0h,017h,040h,000h	; 8f2d  ..@...@.......@.

; ----------------------------------------------------------------------
; DATOS rle_col_8F3D: colores RLE: 14 tiles desde el 150 (lista 0x6ef0)
;   0x8f3d..0x8f40  (3 bytes)
DATA_rle_col_8F3D:
	defb 070h,040h,000h	; 8f3d

; ----------------------------------------------------------------------
; DATOS rle_col_8F40: colores RLE: 2 tiles desde el 164 (lista 0x6ef0)
;   0x8f40..0x8f43  (3 bytes)
DATA_rle_col_8F40:
	defb 010h,0a0h,000h	; 8f40

; ----------------------------------------------------------------------
; DATOS rle_col_8F43: colores RLE: 20 tiles desde el 166 (lista 0x6ef0)
;   0x8f43..0x8fa6  (99 bytes)
DATA_rle_col_8F43:
	defb 010h,0f0h,006h,0a0h,081h,0f0h,009h,0a0h,007h,0f0h,081h,0a0h,004h,0e0h,085h,0f0h	; 8f43  ................
	defb 0a0h,0fah,0a0h,0e0h,007h,0a0h,081h,0f0h,007h,0a0h,083h,0f0h,0fah,0aah,005h,0a0h	; 8f53  ................
	defb 002h,0f0h,082h,0fah,0f0h,006h,0a0h,081h,0f0h,003h,0a0h,081h,000h,007h,0a0h,081h	; 8f63  ................
	defb 090h,006h,0a0h,086h,0e0h,0f0h,0f0h,0a0h,0a0h,090h,003h,0a0h,002h,090h,002h,0a0h	; 8f73  ................
	defb 081h,090h,003h,0a0h,081h,090h,003h,0a0h,081h,090h,003h,0a0h,081h,090h,003h,0a0h	; 8f83  ................
	defb 081h,090h,003h,0a0h,081h,090h,005h,0a0h,081h,0e0h,003h,0f0h,002h,0a0h,081h,090h	; 8f93  ................
	defb 00dh,0a0h,000h	; 8fa3

; ----------------------------------------------------------------------
; DATOS rle_col_8FA6: colores RLE: 15 tiles desde el 201 (lista 0x6ef0)
;   0x8fa6..0x8fad  (7 bytes)
DATA_rle_col_8FA6:
	defb 014h,0a0h,002h,000h,062h,0a0h,000h	; 8fa6

; ----------------------------------------------------------------------
; DATOS rle_pat_8FAD: patrones RLE: 21 tiles desde el 64 (lista 0x6f39)
;   0x8fad..0x9033  (134 bytes)
DATA_rle_pat_8FAD:
	defb 003h,000h,002h,03fh,006h,000h,002h,0ffh,005h,000h,089h,001h,002h,004h,008h,010h	; 8fad  ...?............
	defb 020h,000h,000h,0ffh,007h,000h,082h,0ffh,000h,004h,010h,088h,000h,01fh,0feh,00eh	; 8fbd   ...............
	defb 006h,007h,003h,003h,007h,000h,081h,080h,003h,000h,091h,001h,00fh,00fh,017h,037h	; 8fcd  ...............7
	defb 000h,000h,00fh,0f0h,0ffh,081h,000h,000h,040h,0e0h,0e0h,00fh,004h,0dfh,003h,000h	; 8fdd  ........@.......
	defb 005h,0ffh,002h,010h,093h,00fh,0dfh,0dfh,0dch,0dch,0d8h,001h,007h,0f8h,0ffh,000h	; 8fed  ................
	defb 001h,001h,000h,0c0h,0c0h,0e0h,0e0h,000h,003h,0fch,085h,03eh,000h,0feh,0feh,0fch	; 8ffd  ...........>....
	defb 004h,000h,087h,03ch,018h,000h,024h,018h,000h,000h,004h,05fh,004h,000h,004h,0ffh	; 900d  ...<..$...._....
	defb 004h,000h,002h,0d8h,002h,0f8h,005h,000h,08ah,070h,020h,000h,088h,070h,000h,000h	; 901d  .........p ..p..
	defb 07ch,078h,070h,005h,000h,000h	; 902d

; ----------------------------------------------------------------------
; DATOS rle_pat_9033: patrones RLE: 14 tiles desde el 99 (lista 0x6f39)
;   0x9033..0x9085  (82 bytes)
DATA_rle_pat_9033:
	defb 089h,001h,01eh,060h,040h,043h,04ch,058h,058h,0ffh,003h,000h,091h,0fdh,000h,002h	; 9033  ...`@CLXX.......
	defb 002h,080h,040h,03fh,000h,09fh,060h,018h,006h,000h,000h,0ffh,000h,0ffh,003h,000h	; 9043  ..@?..`.........
	defb 089h,07fh,080h,000h,000h,0ffh,010h,010h,000h,0ffh,003h,000h,089h,0fdh,002h,004h	; 9053  ................
	defb 008h,0f0h,008h,004h,004h,0c4h,003h,024h,008h,098h,003h,004h,005h,008h,004h,001h	; 9063  .......$........
	defb 004h,002h,081h,0ffh,007h,000h,081h,0ffh,007h,000h,082h,0f0h,01fh,006h,011h,008h	; 9073  ................
	defb 024h,000h	; 9083

; ----------------------------------------------------------------------
; DATOS rle_pat_9085: patrones RLE: 22 tiles desde el 113 (lista 0x6f39)
;   0x9085..0x9110  (139 bytes)
DATA_rle_pat_9085:
	defb 003h,000h,002h,03fh,006h,000h,002h,0ffh,009h,000h,082h,01fh,060h,006h,000h,082h	; 9085  ...?........`...
	defb 0f0h,01ch,007h,000h,081h,078h,005h,000h,083h,007h,01fh,03fh,003h,000h,002h,001h	; 9095  .....x.....?....
	defb 08ch,0feh,0e0h,0c0h,001h,006h,018h,0e0h,0e0h,00fh,0efh,06fh,080h,004h,000h,003h	; 90a5  ...........o....
	defb 0ffh,003h,01fh,095h,000h,0dfh,0dfh,0ddh,0ddh,000h,0f0h,0ffh,07fh,0f0h,0feh,05ch	; 90b5  ...............\
	defb 058h,003h,01fh,0e0h,0ffh,087h,001h,000h,000h,008h,0f8h,005h,03fh,002h,07fh,0b6h	; 90c5  X...........?...
	defb 000h,080h,080h,08ah,004h,080h,011h,00eh,000h,02fh,02fh,000h,02fh,000h,02fh,02fh	; 90d5  .........//././/
	defb 000h,0ffh,0ffh,000h,0ffh,000h,0ffh,0ffh,000h,0ddh,0ddh,000h,0dfh,000h,0dfh,0ffh	; 90e5  ................
	defb 000h,058h,058h,000h,0f8h,000h,0f8h,0f0h,000h,000h,048h,030h,000h,084h,078h,000h	; 90f5  .XX.......H0..x.
	defb 000h,078h,078h,070h,060h,040h,003h,000h,008h,010h,000h	; 9105  .xxp`@.....

; ----------------------------------------------------------------------
; DATOS rle_pat_9110: patrones RLE: 15 tiles desde el 150 (lista 0x6f39)
;   0x9110..0x916c  (92 bytes)
DATA_rle_pat_9110:
	defb 002h,000h,082h,01fh,028h,004h,050h,083h,000h,07fh,080h,006h,000h,08ch,0e0h,01fh	; 9110  ....(.P.........
	defb 000h,01fh,020h,040h,040h,000h,001h,0feh,000h,0ffh,004h,000h,093h,0ffh,000h,000h	; 9120  .. @@...........
	defb 0e0h,020h,020h,021h,003h,0fch,000h,000h,007h,018h,060h,080h,0ffh,010h,010h,0d0h	; 9130  .  !......`.....
	defb 004h,010h,081h,0f0h,007h,010h,081h,05fh,007h,050h,08ah,0ffh,000h,001h,001h,000h	; 9140  ......._.P......
	defb 00fh,009h,009h,080h,080h,006h,000h,083h,01fh,020h,040h,005h,080h,081h,0e6h,007h	; 9150  ......... @.....
	defb 008h,082h,000h,07fh,006h,080h,082h,010h,0d0h,006h,050h,000h	; 9160  ..........P.

; ----------------------------------------------------------------------
; DATOS rle_pat_916C: patrones RLE: 25 tiles desde el 165 (lista 0x6f39)
;   0x916c..0x9204  (152 bytes)
DATA_rle_pat_916C:
	defb 003h,000h,002h,03fh,006h,000h,002h,0ffh,00ah,000h,081h,001h,004h,000h,084h,01fh	; 916c  ...?............
	defb 060h,0c0h,080h,004h,000h,081h,0ffh,003h,001h,004h,000h,084h,0f8h,00eh,007h,003h	; 917c  `...............
	defb 007h,000h,081h,080h,005h,000h,083h,007h,01fh,03fh,003h,000h,002h,001h,08bh,0ffh	; 918c  .........?......
	defb 0e0h,0c0h,003h,006h,00ch,0f8h,0e0h,0ffh,0f7h,077h,005h,000h,003h,0ffh,004h,001h	; 919c  .........w......
	defb 081h,0ffh,003h,0fdh,08eh,003h,007h,00fh,01fh,0f0h,0feh,0fch,0f8h,0c0h,0e0h,0f8h	; 91ac  ................
	defb 0ffh,087h,001h,005h,000h,005h,0f8h,005h,03fh,002h,07fh,0b5h,000h,080h,080h,08ah	; 91bc  ........?.......
	defb 004h,080h,011h,00eh,000h,037h,037h,000h,037h,000h,037h,03fh,000h,0ffh,0ffh,000h	; 91cc  .....77.7.7?....
	defb 0ffh,000h,0ffh,0ffh,000h,0fdh,0fdh,000h,0fdh,000h,0fdh,0ffh,000h,0f8h,0f8h,000h	; 91dc  ................
	defb 0f8h,000h,0f8h,0f0h,000h,000h,048h,030h,000h,084h,078h,000h,000h,070h,060h,040h	; 91ec  ......H0..x..p`@
	defb 040h,004h,000h,008h,008h,008h,010h,000h	; 91fc  @.......

; ----------------------------------------------------------------------
; DATOS rle_pat_9204: patrones RLE: 15 tiles desde el 204 (lista 0x6f39)
;   0x9204..0x9262  (94 bytes)
DATA_rle_pat_9204:
	defb 002h,000h,082h,01fh,028h,004h,050h,083h,000h,07fh,080h,006h,000h,08ch,0e0h,01fh	; 9204  ....(.P.........
	defb 000h,01fh,020h,040h,040h,000h,001h,0feh,000h,0ffh,004h,000h,084h,0ffh,000h,000h	; 9214  .. @@...........
	defb 0ffh,003h,000h,089h,003h,0fch,000h,000h,0e0h,010h,021h,042h,0ffh,004h,000h,085h	; 9224  ..........!B....
	defb 038h,0c8h,008h,000h,0f0h,006h,010h,081h,05fh,007h,050h,08ah,0ffh,000h,001h,001h	; 9234  8......._.P.....
	defb 000h,00fh,009h,009h,080h,080h,006h,000h,083h,01fh,020h,040h,005h,080h,081h,0ffh	; 9244  .......... @....
	defb 007h,000h,081h,084h,007h,008h,004h,050h,084h,028h,01fh,000h,000h,000h	; 9254  .......P.(....

; ----------------------------------------------------------------------
; DATOS rle_col_9262: colores RLE: 21 tiles desde el 64 (lista 0x6f39)
;   0x9262..0x92b4  (82 bytes)
DATA_rle_col_9262:
	defb 013h,070h,007h,0e0h,011h,0f0h,010h,070h,002h,0f0h,003h,070h,003h,0f0h,082h,0f7h	; 9262  .p.....p...p....
	defb 077h,003h,070h,084h,0e0h,0f0h,070h,0f0h,003h,070h,081h,080h,004h,0f0h,002h,070h	; 9272  w.p...p..p.....p
	defb 002h,080h,004h,0f0h,081h,070h,003h,080h,002h,070h,086h,0f7h,077h,070h,0e0h,080h	; 9282  .....p...p..wp..
	defb 080h,005h,070h,081h,0e0h,004h,080h,002h,070h,008h,040h,081h,0e0h,003h,0f0h,002h	; 9292  ..p.....p.@.....
	defb 080h,006h,040h,002h,080h,006h,040h,002h,080h,009h,040h,002h,0e0h,003h,0f0h,008h	; 92a2  ..@...@...@.....
	defb 040h,000h	; 92b2

; ----------------------------------------------------------------------
; DATOS rle_col_92B4: colores RLE: 14 tiles desde el 99 (lista 0x6f39)
;   0x92b4..0x92b7  (3 bytes)
DATA_rle_col_92B4:
	defb 070h,070h,000h	; 92b4

; ----------------------------------------------------------------------
; DATOS rle_col_92B7: colores RLE: 22 tiles desde el 113 (lista 0x6f39)
;   0x92b7..0x9316  (95 bytes)
DATA_rle_col_92B7:
	defb 017h,0f0h,081h,0e0h,017h,0f0h,004h,0e0h,083h,0f0h,0e0h,0feh,005h,0e0h,083h,0f0h	; 92b7  ................
	defb 0e0h,0f0h,007h,0e0h,088h,0f0h,0e0h,0e0h,0f0h,0f0h,0e0h,0f0h,0f0h,003h,0e0h,004h	; 92c7  ................
	defb 0f0h,081h,0feh,003h,0e0h,002h,0f0h,081h,0feh,005h,0e0h,081h,0f0h,007h,0e0h,002h	; 92d7  ................
	defb 080h,082h,0e0h,050h,004h,0e0h,002h,080h,004h,0e0h,002h,0f0h,002h,080h,004h,050h	; 92e7  ...P...........P
	defb 002h,0e0h,002h,080h,004h,050h,002h,0e0h,002h,080h,004h,050h,002h,0e0h,002h,080h	; 92f7  .....P.....P....
	defb 004h,050h,002h,0e0h,081h,000h,004h,0e0h,081h,0f0h,00ah,0e0h,008h,0f0h,000h	; 9307  .P.............

; ----------------------------------------------------------------------
; DATOS rle_col_9316: colores RLE: 15 tiles desde el 150 (lista 0x6f39)
;   0x9316..0x9319  (3 bytes)
DATA_rle_col_9316:
	defb 078h,0f0h,000h	; 9316

; ----------------------------------------------------------------------
; DATOS rle_col_9319: colores RLE: 25 tiles desde el 165 (lista 0x6f39)
;   0x9319..0x9383  (106 bytes)
DATA_rle_col_9319:
	defb 016h,0b0h,006h,0e0h,081h,0f0h,007h,0e0h,081h,0f0h,007h,0b0h,002h,0f0h,00fh,0b0h	; 9319  ................
	defb 002h,0f0h,004h,0b0h,085h,0f0h,0b0h,0f0h,0b0h,0b0h,003h,0e0h,083h,0f0h,0b0h,0f0h	; 9329  ................
	defb 007h,0b0h,081h,0f0h,006h,0b0h,081h,0f0h,006h,0b0h,082h,0f0h,0fbh,006h,0b0h,081h	; 9339  ................
	defb 0f0h,007h,0b0h,081h,0f0h,004h,0b0h,002h,080h,082h,0e0h,050h,004h,0b0h,002h,080h	; 9349  ...........P....
	defb 002h,0e0h,086h,0b0h,0e0h,0f0h,0f0h,080h,080h,004h,050h,002h,0b0h,002h,080h,004h	; 9359  ..........P.....
	defb 050h,002h,0b0h,002h,080h,004h,050h,002h,0b0h,002h,080h,004h,050h,002h,0b0h,005h	; 9369  P.....P.....P...
	defb 0e0h,081h,0f0h,004h,0b0h,006h,0a0h,010h,0b0h,000h	; 9379  ..........

; ----------------------------------------------------------------------
; DATOS rle_col_9383: colores RLE: 15 tiles desde el 204 (lista 0x6f39)
;   0x9383..0x9386  (3 bytes)
DATA_rle_col_9383:
	defb 078h,0b0h,000h	; 9383

; ----------------------------------------------------------------------
; DATOS pantalla_9386: flujo RLE de 8 columnas que p01 0x7CE8 descomprime en
;   EC D5 (`ld de,0x9386 / ld hl,0xECD5 / ld a,8 / call RLE_DESDE_P08`, que
;   mapea 8/9 y vuelve a 1/2/3): 64 bytes de flujo, 96 escritos
;   0x9386..0x93c6  (64 bytes)
DATA_pantalla_9386:
	defb 084h,001h,002h,003h,004h,085h,001h,006h,005h,002h,002h,006h,007h,001h,0e3h,008h	; 9386  ................
	defb 083h,002h,002h,00bh,001h,0e4h,00ch,004h,002h,010h,011h,001h,0e5h,012h,001h,011h	; 9396  ................
	defb 083h,001h,0e4h,017h,084h,001h,0e3h,01bh,085h,001h,0e3h,01eh,083h,001h,001h,021h	; 93a6  ...............!
	defb 0e4h,021h,083h,021h,002h,001h,001h,0e4h,025h,084h,001h,0e4h,029h,08ah,001h,000h	; 93b6  .!.!....%...)...

; ----------------------------------------------------------------------
; DATOS pantalla_93C6: flujo RLE de 7 columnas que p01 0x7D64 descomprime en
;   ECD6 (`ld de,0x93C6 / ld hl,0xECD6 / ld a,7 / call RLE_DESDE_P08`): 34
;   bytes de flujo, 77 escritos
;   0x93c6..0x93e8  (34 bytes)
DATA_pantalla_93C6:
	defb 09dh,001h,0e4h,02dh,083h,001h,0e4h,031h,083h,001h,0e3h,035h,083h,001h,0e6h,038h	; 93c6  ...-...1...5...8
	defb 002h,001h,021h,0e5h,03eh,002h,021h,001h,0e4h,025h,083h,001h,0e4h,029h,002h,001h	; 93d6  ..!.>.!..%...)..
	defb 001h,000h	; 93e6

; ----------------------------------------------------------------------
; DATOS rle_pat_93E8: patrones RLE: 55 tiles desde el 64 (lista 0x6f70)
;   0x93e8..0x9562  (378 bytes)
DATA_rle_pat_93E8:
	defb 002h,000h,08eh,01fh,060h,080h,087h,088h,088h,001h,002h,0feh,002h,002h,0feh,002h	; 93e8  ....`...........
	defb 002h,004h,000h,084h,003h,00ch,030h,026h,004h,088h,084h,006h,001h,000h,0dbh,003h	; 93f8  ......0&........
	defb 004h,002h,00ch,085h,08ch,06ch,02ch,000h,0ffh,004h,000h,082h,0ffh,000h,008h,054h	; 9408  .....l,........T
	defb 008h,026h,008h,0dbh,005h,02ch,003h,024h,004h,026h,084h,030h,00ch,003h,000h,004h	; 9418  .&...,.$.&.0....
	defb 0dbh,084h,000h,001h,006h,088h,004h,022h,084h,062h,082h,002h,001h,008h,088h,002h	; 9428  .......".b......
	defb 000h,084h,010h,03ch,07ch,0fch,004h,000h,089h,0ffh,080h,040h,020h,01fh,000h,001h	; 9438  ...<|......@ ...
	defb 001h,0feh,003h,000h,082h,0ffh,000h,004h,010h,08ah,020h,040h,080h,000h,088h,087h	; 9448  .......... @....
	defb 080h,080h,040h,03fh,003h,000h,0a4h,0ffh,000h,000h,00fh,010h,090h,090h,000h,0ffh	; 9458  ..@?............
	defb 000h,000h,0ffh,000h,000h,0ffh,000h,0ffh,020h,040h,0ffh,000h,000h,0ffh,000h,0ffh	; 9468  ........ @......
	defb 000h,000h,0feh,001h,001h,0e1h,000h,0ffh,000h,000h,01fh,003h,020h,085h,000h,0f8h	; 9478  ............ ...
	defb 010h,020h,0c0h,003h,000h,0a0h,091h,093h,093h,096h,096h,08ch,080h,080h,08eh,011h	; 9488  . ..............
	defb 020h,024h,020h,011h,00eh,00eh,000h,000h,080h,080h,0e0h,011h,00eh,04eh,031h,019h	; 9498   $ ..........N1.
	defb 019h,00dh,0edh,016h,008h,048h,008h,020h,0a3h,080h,07ch,006h,006h,003h,003h,001h	; 94a8  .....H. ..|.....
	defb 000h,00eh,011h,020h,024h,020h,011h,08eh,0ffh,00eh,011h,0e0h,080h,080h,000h,000h	; 94b8  ... $ ..........
	defb 0ffh,008h,010h,0efh,00ch,018h,018h,030h,0e0h,020h,020h,0c0h,005h,000h,004h,088h	; 94c8  .......0.  .....
	defb 084h,087h,080h,060h,01ch,004h,000h,09ah,0c0h,020h,010h,008h,000h,000h,03fh,040h	; 94d8  ...`..... ....?@
	defb 040h,04fh,048h,048h,000h,000h,0ffh,000h,000h,0ffh,000h,000h,024h,024h,0e4h,004h	; 94e8  @OHH........$$..
	defb 004h,0f8h,007h,000h,09bh,00fh,008h,010h,002h,002h,004h,008h,010h,0e1h,006h,001h	; 94f8  ................
	defb 008h,008h,068h,008h,0e8h,007h,0e0h,0ffh,044h,042h,059h,040h,05ch,082h,01dh,0feh	; 9508  ..h.....DBY@\...
	defb 003h,000h,084h,080h,040h,03fh,080h,006h,000h,083h,0ffh,000h,001h,004h,000h,084h	; 9518  ....@?..........
	defb 004h,086h,0ffh,07fh,007h,000h,084h,080h,010h,020h,0ffh,005h,000h,09dh,007h,000h	; 9528  ......... ......
	defb 0f3h,008h,004h,002h,001h,000h,01fh,0e0h,0e7h,008h,0e8h,068h,008h,088h,0e3h,01ch	; 9538  ...........h....
	defb 09fh,040h,05ch,059h,042h,044h,080h,000h,03fh,040h,080h,003h,000h,083h,001h,002h	; 9548  .@\YBD..?@......
	defb 0feh,005h,000h,004h,048h,081h,030h,003h,000h,000h	; 9558  ....H.0...

; ----------------------------------------------------------------------
; DATOS rle_pat_9562: patrones RLE: 2 tiles desde el 121 (lista 0x6f70)
;   0x9562..0x9574  (18 bytes)
DATA_rle_pat_9562:
	defb 090h,0ffh,042h,081h,099h,099h,081h,042h,03ch,0e0h,02ch,034h,004h,004h,024h,054h	; 9562  ..B....B<.,4..$T
	defb 054h,000h	; 9572

; ----------------------------------------------------------------------
; DATOS rle_pat_9574: patrones RLE: 1 tiles desde el 124 (lista 0x6f70)
;   0x9574..0x957d  (9 bytes)
DATA_rle_pat_9574:
	defb 082h,000h,03fh,004h,040h,082h,03fh,000h,000h	; 9574  ..?.@.?..

; ----------------------------------------------------------------------
; DATOS rle_pat_957D: patrones RLE: 30 tiles desde el 125 (lista 0x6f70)
;   0x957d..0x965a  (221 bytes)
DATA_rle_pat_957D:
	defb 004h,088h,084h,087h,040h,020h,01fh,004h,000h,093h,0ffh,000h,000h,0ffh,010h,010h	; 957d  ....@ ..........
	defb 00fh,000h,0ffh,000h,000h,0fch,000h,000h,0ffh,000h,000h,0c0h,020h,004h,010h,005h	; 958d  ............ ...
	defb 090h,08eh,000h,00fh,030h,040h,040h,047h,048h,048h,000h,0feh,004h,004h,008h,0f8h	; 959d  ....0@@GHH......
	defb 004h,000h,082h,001h,002h,004h,004h,002h,000h,08ah,0ffh,0a5h,0c6h,0e7h,063h,0a5h	; 95ad  ..............c.
	defb 003h,000h,080h,040h,004h,020h,084h,008h,088h,044h,044h,004h,024h,08dh,090h,091h	; 95bd  ...@. ...DD.$...
	defb 092h,094h,098h,081h,085h,085h,084h,012h,051h,054h,0b4h,003h,06dh,003h,000h,088h	; 95cd  ........QT..m...
	defb 080h,040h,030h,008h,008h,000h,000h,001h,005h,002h,085h,004h,0f8h,000h,000h,038h	; 95dd  .@0............8
	defb 003h,044h,08dh,0c6h,0e7h,063h,0a5h,0c6h,0e7h,063h,0a5h,020h,01eh,001h,000h,01ch	; 95ed  .D...c...c. ....
	defb 006h,024h,0bdh,0a2h,0a1h,090h,088h,087h,040h,03fh,000h,000h,0ffh,000h,005h,0e5h	; 95fd  .$......@?......
	defb 030h,033h,0b4h,0b4h,033h,030h,06dh,06dh,008h,0f8h,000h,000h,0f8h,008h,088h,088h	; 960d  03..30mm........
	defb 002h,0fch,040h,020h,010h,008h,004h,003h,044h,042h,041h,040h,03fh,000h,000h,0ffh	; 961d  ..@ ....DBA@?...
	defb 0c6h,0e7h,0ffh,000h,0ffh,010h,008h,0ffh,024h,044h,084h,004h,0fch,000h,000h,0ffh	; 962d  ........$D......
	defb 004h,080h,097h,07fh,000h,000h,0ffh,011h,008h,004h,002h,0ffh,000h,000h,0ffh,06dh	; 963d  ...............m
	defb 0b4h,054h,051h,002h,004h,008h,0f0h,030h,040h,080h,005h,000h,000h	; 964d  .TQ....0@....

; ----------------------------------------------------------------------
; DATOS rle_col_965A: colores RLE: 55 tiles desde el 64 (lista 0x6f70)
;   0x965a..0x9669  (15 bytes)
DATA_rle_col_965A:
	defb 068h,0c0h,070h,0a0h,002h,000h,03eh,0a0h,058h,0e0h,010h,0c0h,038h,0e0h,000h	; 965a  h.p...>.X...8..

; ----------------------------------------------------------------------
; DATOS rle_col_9669: colores RLE: 2 tiles desde el 121 (lista 0x6f70)
;   0x9669..0x966c  (3 bytes)
DATA_rle_col_9669:
	defb 010h,0c0h,000h	; 9669

; ----------------------------------------------------------------------
; DATOS rle_col_966C: colores RLE: 1 tiles desde el 124 (lista 0x6f70)
;   0x966c..0x966f  (3 bytes)
DATA_rle_col_966C:
	defb 008h,0c0h,000h	; 966c

; ----------------------------------------------------------------------
; DATOS rle_col_966F: colores RLE: 33 tiles desde el 125 (lista 0x6f70)
;   0x966f..0x9676  (7 bytes)
DATA_rle_col_966F:
	defb 018h,0c0h,07fh,080h,071h,080h,000h	; 966f

; ----------------------------------------------------------------------
; DATOS rle_pat_9676: patrones RLE: 8 tiles desde el 64 (lista 0x6fcc)
;   0x9676..0x96b3  (61 bytes)
DATA_rle_pat_9676:
	defb 003h,000h,002h,0ffh,003h,000h,091h,030h,038h,02ch,026h,026h,023h,024h,027h,00ch	; 9676  .......08,&&#$'.
	defb 01ch,034h,064h,063h,0e3h,024h,0e4h,024h,006h,025h,0a1h,024h,0f8h,004h,077h,074h	; 9686  .4dc.$.$.%.$..wt
	defb 074h,077h,004h,0f8h,0f8h,007h,0b8h,04bh,04bh,0b8h,007h,0f8h,027h,020h,023h,026h	; 9696  tw.....KK...' #&
	defb 026h,02ch,038h,030h,0e4h,024h,0e4h,064h,064h,034h,01ch,00ch,000h	; 96a6  &,80.$.dd4...

; ----------------------------------------------------------------------
; DATOS rle_pat_96B3: patrones RLE: 19 tiles desde el 72 (lista 0x6fcc)
;   0x96b3..0x9739  (134 bytes)
DATA_rle_pat_96B3:
	defb 005h,000h,083h,0c0h,0f0h,038h,006h,000h,082h,001h,00fh,005h,000h,090h,0c0h,020h	; 96b3  .....8......... 
	defb 020h,023h,02ch,02bh,010h,017h,02eh,02eh,05eh,010h,0eeh,021h,0dch,043h,003h,080h	; 96c3   #,+....^..!.C..
	defb 002h,000h,08fh,0c0h,038h,085h,07eh,004h,018h,013h,029h,044h,082h,001h,002h,004h	; 96d3  ....8.~...)D....
	defb 008h,0c0h,003h,080h,004h,000h,088h,05dh,0bdh,07dh,0fah,0fah,07ah,074h,0b4h,005h	; 96e3  .......].}..zt..
	defb 000h,002h,008h,08eh,005h,018h,024h,042h,081h,041h,062h,0b4h,048h,010h,020h,040h	; 96f3  ......$B.Ab.H. @
	defb 080h,080h,003h,000h,099h,044h,078h,000h,078h,04fh,030h,00fh,020h,01eh,023h,05ah	; 9703  .....Dx.xO0. .#Z
	defb 09ah,082h,07eh,003h,0f8h,080h,000h,080h,060h,000h,000h,0e0h,01fh,007h,007h,000h	; 9713  ..~.....`.......
	defb 083h,0c0h,03eh,001h,005h,000h,084h,0f8h,007h,0f0h,00fh,005h,000h,087h,09ch,0e2h	; 9723  ..>.............
	defb 0eah,022h,01ch,000h,000h,000h	; 9733

; ----------------------------------------------------------------------
; DATOS rle_pat_9739: patrones RLE: 5 tiles desde el 96 (lista 0x6fcc)
;   0x9739..0x975a  (33 bytes)
DATA_rle_pat_9739:
	defb 005h,000h,083h,0c3h,024h,0dbh,005h,000h,083h,0ffh,000h,0ffh,007h,025h,08ah,024h	; 9739  ....$........%.$
	defb 026h,02ah,029h,02dh,02ah,02ah,029h,02fh,000h,003h,006h,084h,0beh,0a2h,0f2h,00ah	; 9749  &*)-**)/........
	defb 000h	; 9759

; ----------------------------------------------------------------------
; DATOS rle_pat_975A: patrones RLE: 1 tiles desde el 104 (lista 0x6fcc)
;   0x975a..0x9763  (9 bytes)
DATA_rle_pat_975A:
	defb 003h,000h,085h,007h,00fh,018h,030h,030h,000h	; 975a  ......00.

; ----------------------------------------------------------------------
; DATOS rle_pat_9763: patrones RLE: 19 tiles desde el 105 (lista 0x6fcc)
;   0x9763..0x97eb  (136 bytes)
DATA_rle_pat_9763:
	defb 006h,000h,002h,001h,005h,000h,083h,0c0h,020h,020h,006h,000h,09fh,0c0h,030h,000h	; 9763  ........  ....0.
	defb 003h,007h,008h,008h,010h,010h,021h,0c0h,080h,0c0h,0c0h,040h,080h,080h,000h,023h	; 9773  ......!....@...#
	defb 02ch,02bh,010h,017h,02eh,02eh,05eh,02ch,0a3h,058h,0c6h,041h,003h,080h,002h,000h	; 9783  ,+....^,.X.A....
	defb 0bfh,0c1h,031h,08ah,062h,01ch,004h,021h,0c2h,032h,00ch,002h,002h,004h,004h,05dh	; 9793  ..1.b..!.2.....]
	defb 0bdh,07dh,0fah,0fah,07ah,074h,0b4h,008h,008h,010h,010h,00ch,003h,03fh,080h,008h	; 97a3  .}..zt.......?..
	defb 008h,010h,010h,020h,020h,0c0h,000h,044h,078h,0ffh,078h,04fh,030h,00fh,020h,000h	; 97b3  ...  ..Dx.xO0. .
	defb 000h,001h,002h,084h,07ch,003h,0f8h,0ffh,0f8h,007h,034h,036h,004h,0e4h,01fh,007h	; 97c3  ....|.....46....
	defb 007h,000h,083h,0c0h,03eh,001h,005h,000h,084h,0f8h,007h,0f0h,00fh,005h,000h,087h	; 97d3  ....>...........
	defb 09ch,0e2h,0eah,022h,01ch,000h,000h,000h	; 97e3  ..."....

; ----------------------------------------------------------------------
; DATOS rle_pat_97EB: patrones RLE: 19 tiles desde el 124 (lista 0x6fcc)
;   0x97eb..0x986b  (128 bytes)
DATA_rle_pat_97EB:
	defb 005h,000h,002h,020h,0aeh,0f8h,00fh,003h,000h,000h,001h,003h,003h,000h,0ffh,0feh	; 97eb  ... ............
	defb 08ah,0beh,0fch,0e8h,088h,09eh,000h,001h,003h,002h,000h,0c1h,0f3h,032h,0fch,0f8h	; 97fb  .............2..
	defb 0c8h,09eh,0fch,0f8h,0ceh,08ch,023h,02ch,02bh,010h,017h,02eh,02eh,05eh,00bh,0edh	; 980b  ......#,+....^..
	defb 02dh,0c1h,041h,003h,081h,083h,0feh,004h,004h,003h,005h,002h,004h,004h,000h,08ch	; 981b  -.A.............
	defb 09ch,0a2h,02ah,022h,05dh,0bdh,07dh,0fah,0fah,07ah,074h,0b4h,007h,001h,081h,000h	; 982b  ..*"].}..zt.....
	defb 007h,004h,082h,0f8h,01ch,007h,000h,097h,044h,078h,000h,078h,04fh,030h,00fh,020h	; 983b  ........Dx.xO0. 
	defb 001h,002h,004h,008h,0ffh,000h,0ffh,0ffh,008h,068h,068h,008h,0ffh,000h,0ffh,005h	; 984b  .........hh.....
	defb 000h,083h,0ffh,000h,0ffh,004h,000h,085h,038h,0c4h,054h,0c4h,038h,008h,004h,000h	; 985b  ........8.T.8...

; ----------------------------------------------------------------------
; DATOS rle_col_986B: colores RLE: 8 tiles desde el 64 (lista 0x6fcc)
;   0x986b..0x986e  (3 bytes)
DATA_rle_col_986B:
	defb 040h,0c0h,000h	; 986b

; ----------------------------------------------------------------------
; DATOS rle_col_986E: colores RLE: 19 tiles desde el 72 (lista 0x6fcc)
;   0x986e..0x9875  (7 bytes)
DATA_rle_col_986E:
	defb 067h,0e0h,081h,0c0h,030h,0e0h,000h	; 986e

; ----------------------------------------------------------------------
; DATOS rle_col_9875: colores RLE: 5 tiles desde el 96 (lista 0x6fcc)
;   0x9875..0x9878  (3 bytes)
DATA_rle_col_9875:
	defb 028h,0c0h,000h	; 9875

; ----------------------------------------------------------------------
; DATOS rle_col_9878: colores RLE: 1 tiles desde el 104 (lista 0x6fcc)
;   0x9878..0x987b  (3 bytes)
DATA_rle_col_9878:
	defb 008h,0c0h,000h	; 9878

; ----------------------------------------------------------------------
; DATOS rle_col_987B: colores RLE: 19 tiles desde el 105 (lista 0x6fcc)
;   0x987b..0x9886  (11 bytes)
DATA_rle_col_987B:
	defb 062h,0a0h,081h,000h,004h,0a0h,081h,0c0h,030h,0a0h,000h	; 987b  b.......0..

; ----------------------------------------------------------------------
; DATOS rle_col_9886: colores RLE: 19 tiles desde el 124 (lista 0x6fcc)
;   0x9886..0x9897  (17 bytes)
DATA_rle_col_9886:
	defb 02bh,080h,081h,0c0h,043h,080h,081h,0c0h,007h,080h,081h,000h,018h,080h,008h,0e0h	; 9886  +...C...........
	defb 000h	; 9896

; ----------------------------------------------------------------------
; DATOS rle_pat_9897: patrones RLE: 21 tiles desde el 64 (lista 0x6f95)
;   0x9897..0x9927  (144 bytes)
DATA_rle_pat_9897:
	defb 007h,000h,08bh,060h,000h,001h,006h,00ah,011h,020h,020h,040h,07eh,081h,003h,000h	; 9897  ...`.....  @~...
	defb 08bh,080h,07ch,0c3h,058h,0c4h,042h,041h,040h,040h,020h,050h,004h,000h,002h,080h	; 98a7  ..|.X.BA@@ P....
	defb 002h,041h,004h,004h,003h,00bh,081h,08bh,004h,020h,004h,0d0h,082h,041h,081h,004h	; 98b7  .A....... ...A..
	defb 082h,092h,085h,049h,000h,000h,018h,03ch,03ch,018h,000h,000h,088h,088h,044h,044h	; 98c7  ...I...<<.....DD
	defb 047h,041h,081h,082h,004h,02fh,08ch,0e1h,001h,000h,000h,0cbh,0ebh,0ebh,0cbh,08bh	; 98d7  GA.../..........
	defb 00bh,004h,004h,006h,0d0h,002h,020h,09bh,050h,020h,020h,010h,008h,006h,001h,000h	; 98e7  ...... .P  .....
	defb 0c3h,03ch,002h,001h,000h,000h,081h,07eh,002h,004h,004h,008h,090h,060h,080h,000h	; 98f7  .<.....~.....`..
	defb 004h,004h,008h,004h,017h,084h,097h,020h,020h,010h,005h,0e8h,088h,0d7h,0f7h,0f7h	; 9907  .......  .......
	defb 0d7h,097h,017h,008h,004h,006h,0e8h,082h,010h,020h,006h,000h,082h,0ffh,000h,000h	; 9917  ......... ......

; ----------------------------------------------------------------------
; DATOS rle_pat_9927: patrones RLE: 10 tiles desde el 95 (lista 0x6f95)
;   0x9927..0x9962  (59 bytes)
DATA_rle_pat_9927:
	defb 002h,000h,081h,001h,005h,002h,002h,000h,084h,0ffh,000h,000h,007h,003h,000h,083h	; 9927  ................
	defb 007h,008h,00ah,004h,0cah,088h,0eah,0cah,0cah,0c6h,0c7h,0c3h,003h,003h,008h,004h	; 9937  ................
	defb 081h,003h,006h,001h,002h,003h,00ah,001h,003h,0e1h,002h,0e3h,088h,0fbh,0e3h,0e3h	; 9947  ................
	defb 0e1h,0e0h,0e0h,000h,000h,006h,004h,082h,003h,000h,000h	; 9957  ...........

; ----------------------------------------------------------------------
; DATOS rle_pat_9962: patrones RLE: 7 tiles desde el 105 (lista 0x6f95)
;   0x9962..0x9999  (55 bytes)
DATA_rle_pat_9962:
	defb 08ah,000h,001h,006h,008h,010h,020h,020h,040h,07eh,081h,004h,000h,08ch,07ch,0c3h	; 9962  ......  @~....|.
	defb 058h,0c4h,042h,041h,040h,040h,020h,010h,041h,081h,004h,082h,08ch,081h,041h,040h	; 9972  X.BA@@ .A.....A@
	defb 020h,020h,010h,008h,006h,001h,000h,0c3h,03ch,004h,000h,08ah,081h,07eh,002h,004h	; 9982    ......<....~..
	defb 004h,008h,010h,060h,080h,000h,000h	; 9992

; ----------------------------------------------------------------------
; DATOS rle_pat_9999: patrones RLE: 1 tiles desde el 113 (lista 0x6f95)
;   0x9999..0x99a3  (10 bytes)
DATA_rle_pat_9999:
	defb 088h,07eh,081h,000h,081h,081h,000h,03ch,0c3h,000h	; 9999  .~.....<..

; ----------------------------------------------------------------------
; DATOS rle_pat_99A3: patrones RLE: 3 tiles desde el 117 (lista 0x6f95)
;   0x99a3..0x99bc  (25 bytes)
DATA_rle_pat_99A3:
	defb 08ah,000h,001h,006h,008h,013h,026h,02ch,048h,059h,091h,004h,092h,08ah,091h,059h	; 99a3  ......&,HY.....Y
	defb 048h,02ch,026h,013h,008h,006h,001h,000h,000h	; 99b3  H,&......

; ----------------------------------------------------------------------
; DATOS rle_pat_99BC: patrones RLE: 2 tiles desde el 120 (lista 0x6f95)
;   0x99bc..0x99c7  (11 bytes)
DATA_rle_pat_99BC:
	defb 006h,000h,002h,001h,004h,03fh,002h,001h,002h,000h,000h	; 99bc  .....?.....

; ----------------------------------------------------------------------
; DATOS rle_col_99C7: colores RLE: 21 tiles desde el 64 (lista 0x6f95)
;   0x99c7..0x99d4  (13 bytes)
DATA_rle_col_99C7:
	defb 028h,0a0h,010h,090h,020h,0a0h,010h,090h,018h,0a0h,028h,090h,000h	; 99c7  (... .....(..

; ----------------------------------------------------------------------
; DATOS rle_col_99D4: colores RLE: 10 tiles desde el 95 (lista 0x6f95)
;   0x99d4..0x99d7  (3 bytes)
DATA_rle_col_99D4:
	defb 050h,090h,000h	; 99d4

; ----------------------------------------------------------------------
; DATOS rle_col_99D7: colores RLE: 7 tiles desde el 105 (lista 0x6f95)
;   0x99d7..0x99da  (3 bytes)
DATA_rle_col_99D7:
	defb 038h,0a0h,000h	; 99d7

; ----------------------------------------------------------------------
; DATOS rle_col_99DA: colores RLE: 1 tiles desde el 113 (lista 0x6f95)
;   0x99da..0x99dd  (3 bytes)
DATA_rle_col_99DA:
	defb 008h,050h,000h	; 99da

; ----------------------------------------------------------------------
; DATOS rle_col_99DD: colores RLE: 3 tiles desde el 117 (lista 0x6f95)
;   0x99dd..0x99e0  (3 bytes)
DATA_rle_col_99DD:
	defb 018h,050h,000h	; 99dd

; ----------------------------------------------------------------------
; DATOS rle_col_99E0: colores RLE: 2 tiles desde el 120 (lista 0x6f95)
;   0x99e0..0x99e3  (3 bytes)
DATA_rle_col_99E0:
	defb 010h,090h,000h	; 99e0

; ----------------------------------------------------------------------
; DATOS rle_pat_99E3: patrones RLE: 38 tiles desde el 64 (lista 0x7009)
;   0x99e3..0x9af6  (275 bytes)
DATA_rle_pat_99E3:
	defb 002h,000h,086h,018h,03eh,03fh,01fh,01fh,00fh,005h,000h,003h,080h,002h,00fh,083h	; 99e3  ....>?..........
	defb 00eh,00ah,00ah,003h,014h,003h,028h,003h,050h,002h,0a0h,082h,000h,03fh,003h,040h	; 99f3  ......(.P....?.@
	defb 085h,04fh,07fh,04fh,000h,0ffh,003h,000h,08bh,00fh,0ffh,00fh,000h,000h,0f8h,007h	; 9a03  .O.O............
	defb 000h,000h,0ffh,0ceh,003h,000h,085h,0c0h,03fh,038h,0ffh,038h,004h,000h,083h,0ffh	; 9a13  ........?8.8....
	defb 000h,0ffh,003h,000h,08dh,03dh,042h,0f2h,001h,0ffh,000h,0a0h,0a0h,0efh,010h,013h	; 9a23  .....=B.........
	defb 0e0h,0c0h,004h,000h,0c7h,080h,0c0h,080h,080h,0e0h,000h,04eh,0ffh,01eh,01eh,0ffh	; 9a33  ...........N....
	defb 04eh,000h,071h,071h,0ffh,071h,071h,0ffh,071h,071h,0ceh,0ceh,0ffh,0ceh,0ceh,0ffh	; 9a43  N.qq.qq.qq......
	defb 0ceh,0ceh,001h,039h,0efh,029h,029h,0efh,039h,001h,0e0h,0e0h,0ffh,0e0h,0e0h,0ffh	; 9a53  ...9.)).9.......
	defb 0e0h,0e0h,000h,000h,0ffh,000h,000h,0ffh,000h,007h,000h,000h,0ffh,000h,000h,0ffh	; 9a63  ................
	defb 000h,0ffh,0a0h,020h,0e0h,020h,020h,0e0h,020h,0e0h,020h,020h,006h,000h,081h,040h	; 9a73  ... .  . .  ...@
	defb 003h,05ch,085h,05fh,05ch,05fh,05ch,001h,003h,071h,0a6h,0ffh,071h,0ffh,071h,0ceh	; 9a83  .\._\_\..q..q.q.
	defb 0c0h,0c0h,0c3h,0ffh,0c3h,0ffh,0c3h,038h,038h,039h,081h,0ffh,081h,0ffh,081h,000h	; 9a93  .......889......
	defb 000h,0e1h,0e1h,0ffh,0e1h,0ffh,0e1h,008h,008h,0c9h,02ah,02ch,028h,030h,0e0h,0c0h	; 9aa3  ..........*,(0..
	defb 080h,006h,000h,083h,05ch,040h,03fh,005h,000h,083h,071h,001h,0c0h,004h,020h,083h	; 9ab3  ....\@?...q... .
	defb 01fh,0c3h,0c0h,003h,000h,084h,001h,002h,0fch,081h,003h,000h,081h,0ffh,003h,000h	; 9ac3  ................
	defb 085h,0e0h,000h,001h,002h,0fch,005h,000h,091h,003h,004h,007h,01fh,020h,020h,000h	; 9ad3  .............  .
	defb 000h,0e0h,010h,0f0h,0f0h,010h,010h,018h,006h,001h,005h,000h,003h,010h,081h,0e0h	; 9ae3  ................
	defb 00ch,0a0h,000h	; 9af3

; ----------------------------------------------------------------------
; DATOS rle_col_9AF6: colores RLE: 38 tiles desde el 64 (lista 0x7009)
;   0x9af6..0x9b20  (42 bytes)
DATA_rle_col_9AF6:
	defb 070h,0c0h,002h,080h,086h,0c8h,080h,080h,0c8h,080h,080h,008h,0c0h,002h,080h,086h	; 9af6  p...............
	defb 0c8h,080h,080h,0c8h,080h,080h,028h,0c0h,004h,0a0h,085h,0cah,0a0h,0cah,0a0h,080h	; 9b06  ......(.........
	defb 003h,0a0h,084h,0cah,0a0h,0cah,0a0h,070h,0c0h,000h	; 9b16  .......p..

; ----------------------------------------------------------------------
; DATOS tabla_objetos_pista: 21 punteros (por la carrera (E25C)) a la lista de
;   objetos de la pista de cada circuito; la lee 0x5F5D con 7/8/9
;   0x9b20..0x9b4a  (42 bytes)
DATA_tabla_objetos_pista:
	defw 09b4ah	; 9b20  -> DATA_objetos_pista_00
	defw 09c59h	; 9b22  -> DATA_objetos_pista_01
	defw 09cc0h	; 9b24  -> DATA_objetos_pista_02
	defw 09d39h	; 9b26  -> DATA_objetos_pista_03
	defw 09d9dh	; 9b28  -> DATA_objetos_pista_04
	defw 09e3ah	; 9b2a  -> DATA_objetos_pista_05
	defw 09ec5h	; 9b2c  -> DATA_objetos_pista_06
	defw 09f4ah	; 9b2e  -> DATA_objetos_pista_07
	defw 09fdeh	; 9b30  -> DATA_objetos_pista_08
	defw 0a07eh	; 9b32
	defw 0a115h	; 9b34
	defw 0a170h	; 9b36
	defw 0a1ddh	; 9b38
	defw 0a26eh	; 9b3a
	defw 0a30bh	; 9b3c
	defw 0a375h	; 9b3e
	defw 0a3f7h	; 9b40
	defw 0a491h	; 9b42
	defw 0a53dh	; 9b44
	defw 0a5bch	; 9b46
	defw 0a650h	; 9b48

; ----------------------------------------------------------------------
; DATOS objetos_pista_00: objetos de la pista de la carrera 0 (RALLY): 90
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57)
;   0x9b4a..0x9c59  (271 bytes)
DATA_objetos_pista_00:
	defb 05ah	; 9b4a
	defb 012h,000h,0c0h	; 9b4b
	defb 022h,000h,0c0h	; 9b4e
	defb 0f6h,001h,002h	; 9b51
	defb 005h,002h,002h	; 9b54
	defb 006h,002h,088h	; 9b57
	defb 026h,002h,0bah	; 9b5a
	defb 055h,002h,0c1h	; 9b5d
	defb 056h,002h,001h	; 9b60
	defb 065h,002h,001h	; 9b63
	defb 066h,002h,084h	; 9b66
	defb 075h,002h,0b6h	; 9b69
	defb 095h,002h,0c1h	; 9b6c
	defb 096h,002h,004h	; 9b6f
	defb 0a5h,002h,004h	; 9b72
	defb 0a6h,002h,088h	; 9b75
	defb 0c6h,002h,0b9h	; 9b78
	defb 0e6h,002h,0c1h	; 9b7b
	defb 0f5h,002h,004h	; 9b7e
	defb 006h,003h,004h	; 9b81
	defb 016h,003h,088h	; 9b84
	defb 026h,003h,0b9h	; 9b87
	defb 056h,003h,0c1h	; 9b8a
	defb 086h,003h,001h	; 9b8d
	defb 096h,003h,001h	; 9b90
	defb 0a6h,003h,084h	; 9b93
	defb 0b6h,003h,0b6h	; 9b96
	defb 0e5h,003h,0c1h	; 9b99
	defb 0e6h,003h,004h	; 9b9c
	defb 0f5h,003h,004h	; 9b9f
	defb 0f6h,003h,088h	; 9ba2
	defb 006h,004h,0b9h	; 9ba5
	defb 036h,004h,0c1h	; 9ba8
	defb 046h,004h,003h	; 9bab
	defb 056h,004h,003h	; 9bae
	defb 066h,004h,084h	; 9bb1
	defb 076h,004h,0b5h	; 9bb4
	defb 0b6h,004h,0c2h	; 9bb7
	defb 0d6h,004h,0c1h	; 9bba
	defb 006h,005h,004h	; 9bbd
	defb 016h,005h,004h	; 9bc0
	defb 026h,005h,088h	; 9bc3
	defb 046h,005h,0b9h	; 9bc6
	defb 086h,005h,0c1h	; 9bc9
	defb 095h,005h,003h	; 9bcc
	defb 0a5h,005h,003h	; 9bcf
	defb 0a6h,005h,084h	; 9bd2
	defb 0b6h,005h,0b5h	; 9bd5
	defb 0e6h,005h,0c1h	; 9bd8
	defb 006h,006h,002h	; 9bdb
	defb 016h,006h,002h	; 9bde
	defb 025h,006h,088h	; 9be1
	defb 036h,006h,0bah	; 9be4
	defb 065h,006h,0c1h	; 9be7
	defb 066h,006h,004h	; 9bea
	defb 075h,006h,004h	; 9bed
	defb 076h,006h,088h	; 9bf0
	defb 086h,006h,0b9h	; 9bf3
	defb 0c5h,006h,0c1h	; 9bf6
	defb 0c6h,006h,001h	; 9bf9
	defb 0d5h,006h,001h	; 9bfc
	defb 0d6h,006h,084h	; 9bff
	defb 0e6h,006h,0b6h	; 9c02
	defb 005h,007h,0c1h	; 9c05
	defb 006h,007h,003h	; 9c08
	defb 015h,007h,003h	; 9c0b
	defb 016h,007h,084h	; 9c0e
	defb 026h,007h,0b5h	; 9c11
	defb 066h,007h,0c1h	; 9c14
	defb 076h,007h,004h	; 9c17
	defb 086h,007h,004h	; 9c1a
	defb 096h,007h,088h	; 9c1d
	defb 0a6h,007h,0b9h	; 9c20
	defb 0e6h,007h,0c1h	; 9c23
	defb 006h,008h,002h	; 9c26
	defb 016h,008h,002h	; 9c29
	defb 026h,008h,088h	; 9c2c
	defb 036h,008h,0bah	; 9c2f
	defb 065h,008h,0c1h	; 9c32
	defb 066h,008h,003h	; 9c35
	defb 075h,008h,003h	; 9c38
	defb 076h,008h,084h	; 9c3b
	defb 086h,008h,0b5h	; 9c3e
	defb 0b6h,008h,0c1h	; 9c41
	defb 0c0h,008h,002h	; 9c44
	defb 0d0h,008h,002h	; 9c47
	defb 0e6h,008h,088h	; 9c4a
	defb 0f6h,008h,0bah	; 9c4d
	defb 016h,009h,0c1h	; 9c50
	defb 0a0h,009h,0c7h	; 9c53
	defb 0f6h,009h,0c6h	; 9c56

; ----------------------------------------------------------------------
; DATOS objetos_pista_01: objetos de la pista de la carrera 1 (STOCK): 34
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57)
;   0x9c59..0x9cc0  (103 bytes)
DATA_objetos_pista_01:
	defb 022h	; 9c59
	defb 013h,000h,0c0h	; 9c5a
	defb 023h,000h,0c0h	; 9c5d
	defb 0e6h,001h,003h	; 9c60
	defb 0f5h,001h,003h	; 9c63
	defb 006h,002h,084h	; 9c66
	defb 016h,002h,0b6h	; 9c69
	defb 096h,002h,0c2h	; 9c6c
	defb 0e6h,002h,0c1h	; 9c6f
	defb 0f6h,002h,005h	; 9c72
	defb 006h,003h,005h	; 9c75
	defb 016h,003h,084h	; 9c78
	defb 026h,003h,0b5h	; 9c7b
	defb 066h,003h,0c2h	; 9c7e
	defb 0a6h,003h,0c2h	; 9c81
	defb 0e6h,003h,0c1h	; 9c84
	defb 056h,004h,003h	; 9c87
	defb 066h,004h,003h	; 9c8a
	defb 076h,004h,084h	; 9c8d
	defb 086h,004h,0b6h	; 9c90
	defb 016h,005h,0c2h	; 9c93
	defb 096h,005h,0c1h	; 9c96
	defb 0d6h,005h,003h	; 9c99
	defb 0e6h,005h,003h	; 9c9c
	defb 0f6h,005h,084h	; 9c9f
	defb 006h,006h,0b6h	; 9ca2
	defb 040h,006h,0c2h	; 9ca5
	defb 076h,006h,0c1h	; 9ca8
	defb 086h,006h,004h	; 9cab
	defb 096h,006h,004h	; 9cae
	defb 0a6h,006h,088h	; 9cb1
	defb 0b6h,006h,0b9h	; 9cb4
	defb 006h,007h,0c1h	; 9cb7
	defb 090h,007h,0c7h	; 9cba
	defb 0e6h,007h,0c6h	; 9cbd

; ----------------------------------------------------------------------
; DATOS objetos_pista_02: objetos de la pista de la carrera 2 (ENDURANCE): 40
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57)
;   0x9cc0..0x9d39  (121 bytes)
DATA_objetos_pista_02:
	defb 028h	; 9cc0
	defb 000h,000h,0c6h	; 9cc1
	defb 016h,000h,0c0h	; 9cc4
	defb 026h,000h,0c0h	; 9cc7
	defb 036h,002h,004h	; 9cca
	defb 046h,002h,004h	; 9ccd
	defb 056h,002h,088h	; 9cd0
	defb 066h,002h,0b9h	; 9cd3
	defb 0a6h,002h,0c1h	; 9cd6
	defb 0b6h,002h,003h	; 9cd9
	defb 0c6h,002h,003h	; 9cdc
	defb 0d6h,002h,084h	; 9cdf
	defb 0e6h,002h,0b6h	; 9ce2
	defb 046h,003h,0c2h	; 9ce5
	defb 0c6h,003h,0c1h	; 9ce8
	defb 016h,004h,003h	; 9ceb
	defb 026h,004h,003h	; 9cee
	defb 036h,004h,084h	; 9cf1
	defb 046h,004h,0b6h	; 9cf4
	defb 086h,004h,0c2h	; 9cf7
	defb 0d6h,004h,0c1h	; 9cfa
	defb 0b6h,005h,006h	; 9cfd
	defb 0c6h,005h,006h	; 9d00
	defb 0d6h,005h,088h	; 9d03
	defb 0f6h,005h,0bah	; 9d06
	defb 066h,006h,0c2h	; 9d09
	defb 0a6h,006h,0c2h	; 9d0c
	defb 0f6h,006h,0c1h	; 9d0f
	defb 026h,007h,003h	; 9d12
	defb 036h,007h,003h	; 9d15
	defb 046h,007h,084h	; 9d18
	defb 066h,007h,0b5h	; 9d1b
	defb 0b6h,007h,0c1h	; 9d1e
	defb 0e6h,007h,006h	; 9d21
	defb 0f6h,007h,006h	; 9d24
	defb 006h,008h,088h	; 9d27
	defb 016h,008h,0bah	; 9d2a
	defb 066h,008h,0c2h	; 9d2d
	defb 0a6h,008h,0c2h	; 9d30
	defb 0f6h,008h,0c1h	; 9d33
	defb 0a0h,009h,0c7h	; 9d36

; ----------------------------------------------------------------------
; DATOS objetos_pista_03: objetos de la pista de la carrera 3 (F3): 33
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57)
;   0x9d39..0x9d9d  (100 bytes)
DATA_objetos_pista_03:
	defb 021h	; 9d39
	defb 012h,000h,0c0h	; 9d3a
	defb 022h,000h,0c0h	; 9d3d
	defb 0d6h,001h,004h	; 9d40
	defb 0e6h,001h,004h	; 9d43
	defb 0f6h,001h,088h	; 9d46
	defb 006h,002h,0b9h	; 9d49
	defb 076h,002h,0c1h	; 9d4c
	defb 0d6h,002h,005h	; 9d4f
	defb 0e6h,002h,005h	; 9d52
	defb 0f6h,002h,084h	; 9d55
	defb 006h,003h,0b6h	; 9d58
	defb 056h,003h,0c2h	; 9d5b
	defb 0a6h,003h,0c2h	; 9d5e
	defb 0e6h,003h,0c1h	; 9d61
	defb 006h,004h,004h	; 9d64
	defb 016h,004h,004h	; 9d67
	defb 026h,004h,088h	; 9d6a
	defb 036h,004h,0b9h	; 9d6d
	defb 0a6h,004h,0c1h	; 9d70
	defb 0d6h,004h,005h	; 9d73
	defb 0e6h,004h,005h	; 9d76
	defb 0f6h,004h,084h	; 9d79
	defb 016h,005h,0b6h	; 9d7c
	defb 056h,005h,0c2h	; 9d7f
	defb 0b6h,005h,0c2h	; 9d82
	defb 0f6h,005h,0c1h	; 9d85
	defb 036h,006h,004h	; 9d88
	defb 046h,006h,004h	; 9d8b
	defb 056h,006h,088h	; 9d8e
	defb 066h,006h,0b9h	; 9d91
	defb 0e6h,006h,0c1h	; 9d94
	defb 0a0h,007h,0c7h	; 9d97
	defb 016h,008h,0c6h	; 9d9a

; ----------------------------------------------------------------------
; DATOS objetos_pista_04: objetos de la pista de la carrera 4 (F3000): 52
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57)
;   0x9d9d..0x9e3a  (157 bytes)
DATA_objetos_pista_04:
	defb 034h	; 9d9d
	defb 012h,000h,0c0h	; 9d9e
	defb 022h,000h,0c0h	; 9da1
	defb 0d5h,001h,002h	; 9da4
	defb 0e5h,001h,002h	; 9da7
	defb 0f6h,001h,088h	; 9daa
	defb 006h,002h,0bbh	; 9dad
	defb 025h,002h,0c1h	; 9db0
	defb 026h,002h,003h	; 9db3
	defb 035h,002h,003h	; 9db6
	defb 036h,002h,084h	; 9db9
	defb 045h,002h,0b5h	; 9dbc
	defb 086h,002h,0c2h	; 9dbf
	defb 0b5h,002h,0c1h	; 9dc2
	defb 0b6h,002h,004h	; 9dc5
	defb 0c5h,002h,004h	; 9dc8
	defb 0c6h,002h,088h	; 9dcb
	defb 0e6h,002h,0bbh	; 9dce
	defb 020h,003h,0c2h	; 9dd1
	defb 066h,003h,0c1h	; 9dd4
	defb 0d6h,004h,003h	; 9dd7
	defb 0e6h,004h,003h	; 9dda
	defb 0f6h,004h,084h	; 9ddd
	defb 005h,005h,0b4h	; 9de0
	defb 046h,005h,0c2h	; 9de3
	defb 075h,005h,0c1h	; 9de6
	defb 076h,005h,005h	; 9de9
	defb 085h,005h,005h	; 9dec
	defb 086h,005h,084h	; 9def
	defb 0a6h,005h,0b5h	; 9df2
	defb 0e0h,005h,0c2h	; 9df5
	defb 056h,006h,0c2h	; 9df8
	defb 096h,006h,0c1h	; 9dfb
	defb 0a6h,006h,004h	; 9dfe
	defb 0b5h,006h,004h	; 9e01
	defb 0c6h,006h,088h	; 9e04
	defb 0d5h,006h,0b9h	; 9e07
	defb 020h,007h,0c2h	; 9e0a
	defb 055h,007h,0c1h	; 9e0d
	defb 056h,007h,003h	; 9e10
	defb 065h,007h,003h	; 9e13
	defb 066h,007h,084h	; 9e16
	defb 075h,007h,0b5h	; 9e19
	defb 0c0h,007h,0c2h	; 9e1c
	defb 0c6h,007h,003h	; 9e1f
	defb 0d6h,007h,003h	; 9e22
	defb 0e5h,007h,0c1h	; 9e25
	defb 0e6h,007h,084h	; 9e28
	defb 0f5h,007h,0b7h	; 9e2b
	defb 040h,008h,0c2h	; 9e2e
	defb 076h,008h,0c1h	; 9e31
	defb 020h,009h,0c7h	; 9e34
	defb 076h,009h,0c6h	; 9e37

; ----------------------------------------------------------------------
; DATOS objetos_pista_05: objetos de la pista de la carrera 5 (F1 ROUND 1): 46
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57)
;   0x9e3a..0x9ec5  (139 bytes)
DATA_objetos_pista_05:
	defb 02eh	; 9e3a
	defb 012h,000h,0c0h	; 9e3b
	defb 022h,000h,0c0h	; 9e3e
	defb 096h,001h,003h	; 9e41
	defb 0a6h,001h,003h	; 9e44
	defb 0b6h,001h,084h	; 9e47
	defb 0d6h,001h,0b6h	; 9e4a
	defb 006h,002h,0c2h	; 9e4d
	defb 066h,002h,0c1h	; 9e50
	defb 086h,002h,004h	; 9e53
	defb 096h,002h,004h	; 9e56
	defb 0a6h,002h,088h	; 9e59
	defb 0b6h,002h,0bah	; 9e5c
	defb 010h,003h,0c2h	; 9e5f
	defb 056h,003h,0c1h	; 9e62
	defb 076h,003h,005h	; 9e65
	defb 086h,003h,005h	; 9e68
	defb 096h,003h,084h	; 9e6b
	defb 0a6h,003h,0b7h	; 9e6e
	defb 020h,004h,0c2h	; 9e71
	defb 070h,004h,0c2h	; 9e74
	defb 0a6h,004h,0c1h	; 9e77
	defb 0c6h,005h,003h	; 9e7a
	defb 0d6h,005h,003h	; 9e7d
	defb 0e6h,005h,084h	; 9e80
	defb 0f6h,005h,0b5h	; 9e83
	defb 076h,006h,0c1h	; 9e86
	defb 086h,006h,004h	; 9e89
	defb 096h,006h,004h	; 9e8c
	defb 0a6h,006h,088h	; 9e8f
	defb 0b6h,006h,0bah	; 9e92
	defb 000h,007h,0c2h	; 9e95
	defb 045h,007h,0c1h	; 9e98
	defb 046h,007h,004h	; 9e9b
	defb 055h,007h,004h	; 9e9e
	defb 056h,007h,088h	; 9ea1
	defb 066h,007h,0bbh	; 9ea4
	defb 0b0h,007h,0c2h	; 9ea7
	defb 0f6h,007h,0c1h	; 9eaa
	defb 006h,008h,003h	; 9ead
	defb 016h,008h,003h	; 9eb0
	defb 026h,008h,084h	; 9eb3
	defb 036h,008h,0b5h	; 9eb6
	defb 070h,008h,0c2h	; 9eb9
	defb 0a6h,008h,0c1h	; 9ebc
	defb 040h,009h,0c7h	; 9ebf
	defb 080h,009h,0c6h	; 9ec2

; ----------------------------------------------------------------------
; DATOS objetos_pista_06: objetos de la pista de la carrera 6 (F1 ROUND 2): 44
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57)
;   0x9ec5..0x9f4a  (133 bytes)
DATA_objetos_pista_06:
	defb 02ch	; 9ec5
	defb 012h,000h,0c0h	; 9ec6
	defb 022h,000h,0c0h	; 9ec9
	defb 086h,001h,003h	; 9ecc
	defb 096h,001h,003h	; 9ecf
	defb 0a6h,001h,084h	; 9ed2
	defb 0b6h,001h,0b5h	; 9ed5
	defb 036h,002h,0c1h	; 9ed8
	defb 046h,002h,004h	; 9edb
	defb 056h,002h,004h	; 9ede
	defb 066h,002h,088h	; 9ee1
	defb 076h,002h,0b8h	; 9ee4
	defb 0b6h,002h,0c2h	; 9ee7
	defb 006h,003h,0c1h	; 9eea
	defb 016h,003h,004h	; 9eed
	defb 026h,003h,004h	; 9ef0
	defb 036h,003h,088h	; 9ef3
	defb 046h,003h,0b8h	; 9ef6
	defb 096h,003h,0c2h	; 9ef9
	defb 0e5h,003h,0c1h	; 9efc
	defb 0e6h,003h,003h	; 9eff
	defb 0f6h,003h,003h	; 9f02
	defb 006h,004h,084h	; 9f05
	defb 016h,004h,0b4h	; 9f08
	defb 066h,004h,0c2h	; 9f0b
	defb 0b6h,004h,0c1h	; 9f0e
	defb 0c6h,004h,002h	; 9f11
	defb 0d6h,004h,002h	; 9f14
	defb 0e6h,004h,088h	; 9f17
	defb 0f6h,004h,0bbh	; 9f1a
	defb 036h,005h,0c1h	; 9f1d
	defb 076h,005h,004h	; 9f20
	defb 086h,005h,004h	; 9f23
	defb 096h,005h,088h	; 9f26
	defb 0a6h,005h,0b9h	; 9f29
	defb 0e6h,005h,0c2h	; 9f2c
	defb 026h,006h,0c1h	; 9f2f
	defb 076h,006h,004h	; 9f32
	defb 086h,006h,004h	; 9f35
	defb 096h,006h,088h	; 9f38
	defb 0b6h,006h,0bbh	; 9f3b
	defb 000h,007h,0c2h	; 9f3e
	defb 026h,007h,0c1h	; 9f41
	defb 0c0h,007h,0c7h	; 9f44
	defb 006h,008h,0c6h	; 9f47

; ----------------------------------------------------------------------
; DATOS objetos_pista_07: objetos de la pista de la carrera 7 (F1 ROUND 3): 49
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57)
;   0x9f4a..0x9fde  (148 bytes)
DATA_objetos_pista_07:
	defb 031h	; 9f4a
	defb 012h,000h,0c0h	; 9f4b
	defb 022h,000h,0c0h	; 9f4e
	defb 036h,000h,003h	; 9f51
	defb 046h,000h,003h	; 9f54
	defb 056h,000h,084h	; 9f57
	defb 076h,000h,0b5h	; 9f5a
	defb 0b6h,000h,0c2h	; 9f5d
	defb 0f6h,000h,0c1h	; 9f60
	defb 090h,001h,0c6h	; 9f63
	defb 0d0h,001h,0c1h	; 9f66
	defb 016h,004h,004h	; 9f69
	defb 026h,004h,004h	; 9f6c
	defb 036h,004h,088h	; 9f6f
	defb 056h,004h,0b8h	; 9f72
	defb 086h,004h,0c2h	; 9f75
	defb 0b0h,004h,0c2h	; 9f78
	defb 0d5h,004h,0c1h	; 9f7b
	defb 0d6h,004h,003h	; 9f7e
	defb 0e5h,004h,003h	; 9f81
	defb 0e6h,004h,084h	; 9f84
	defb 0f6h,004h,0b6h	; 9f87
	defb 056h,005h,0c2h	; 9f8a
	defb 095h,005h,0c1h	; 9f8d
	defb 096h,005h,004h	; 9f90
	defb 0a6h,005h,004h	; 9f93
	defb 0b6h,005h,088h	; 9f96
	defb 0c6h,005h,0b9h	; 9f99
	defb 026h,006h,0c2h	; 9f9c
	defb 036h,006h,006h	; 9f9f
	defb 046h,006h,006h	; 9fa2
	defb 070h,006h,0c2h	; 9fa5
	defb 0c6h,006h,0c2h	; 9fa8
	defb 000h,007h,0c2h	; 9fab
	defb 016h,007h,0c1h	; 9fae
	defb 026h,007h,004h	; 9fb1
	defb 036h,007h,004h	; 9fb4
	defb 046h,007h,088h	; 9fb7
	defb 056h,007h,0b8h	; 9fba
	defb 0b6h,007h,0c1h	; 9fbd
	defb 0d6h,007h,001h	; 9fc0
	defb 0e6h,007h,001h	; 9fc3
	defb 0f6h,007h,084h	; 9fc6
	defb 006h,008h,0b6h	; 9fc9
	defb 026h,008h,0c1h	; 9fcc
	defb 036h,008h,002h	; 9fcf
	defb 045h,008h,002h	; 9fd2
	defb 046h,008h,088h	; 9fd5
	defb 056h,008h,0bah	; 9fd8
	defb 076h,008h,0c1h	; 9fdb

; ----------------------------------------------------------------------
; DATOS objetos_pista_08: objetos de la pista de la carrera 8 (F1 ROUND 4): 53
;   registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos
;   y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre
;   0x5E6C por (ix+0x57) (sigue en la pagina siguiente)
;   0x9fde..0xa000  (34 bytes)
DATA_objetos_pista_08:
	defb 035h	; 9fde
	defb 010h,000h,0c6h	; 9fdf
	defb 016h,000h,0c0h	; 9fe2
	defb 026h,000h,0c0h	; 9fe5
	defb 066h,000h,004h	; 9fe8
	defb 076h,000h,004h	; 9feb
	defb 086h,000h,088h	; 9fee
	defb 096h,000h,0b9h	; 9ff1
	defb 0c6h,000h,0c1h	; 9ff4
	defb 066h,002h,004h	; 9ff7
	defb 076h,002h,004h	; 9ffa
	defb 086h,002h,088h	; 9ffd
