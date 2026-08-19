; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 06 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS rle_col_9FEF: colores RLE: 12 tiles desde el 47 (lista 0x6485)
;   0xa000..0xa020  (32 bytes)
DATA_rle_col_9FEF:
	defb 008h,0fch,003h,0ech,003h,0feh,002h,0f1h,008h,0feh,082h,0a1h,0f1h,006h,0feh,010h	; a000  ................
	defb 0ech,081h,0c1h,007h,0f1h,081h,0a1h,008h,0f1h,007h,0c1h,081h,0f1h,007h,0a1h,000h	; a010  ................

; ----------------------------------------------------------------------
; DATOS rle_col_A020: colores RLE: 12 tiles desde el 47 (lista 0x6485)
;   0xa020..0xa056  (54 bytes)
DATA_rle_col_A020:
	defb 005h,0fch,083h,011h,0a1h,091h,005h,0fch,083h,0f1h,0a1h,0c1h,008h,0fch,004h,0ech	; a020  ................
	defb 00ch,0f1h,081h,0a1h,006h,0f1h,092h,0ffh,091h,041h,081h,0a1h,0e1h,051h,011h,0ffh	; a030  .........A...Q..
	defb 041h,0a1h,081h,091h,0e1h,071h,011h,0ffh,0c1h,007h,0f1h,081h,0a1h,008h,0f1h,007h	; a040  A....q..........
	defb 0c1h,081h,0f1h,007h,0a1h,000h	; a050

; ----------------------------------------------------------------------
; DATOS rle_col_A056: colores RLE: 12 tiles desde el 47 (lista 0x6485)
;   0xa056..0xa08a  (52 bytes)
DATA_rle_col_A056:
	defb 007h,0fch,081h,011h,007h,0fch,081h,011h,005h,0fch,003h,0f1h,003h,0ech,00dh,0f1h	; a056  ................
	defb 081h,0a1h,007h,0f1h,092h,091h,041h,081h,0a1h,0e1h,051h,011h,0ffh,041h,0a1h,081h	; a066  ......A...Q..A..
	defb 091h,0e1h,071h,011h,0ffh,0c1h,0c1h,006h,0f1h,002h,0a1h,008h,0f1h,006h,0c1h,002h	; a076  ..q.............
	defb 0f1h,006h,0a1h,000h	; a086

; ----------------------------------------------------------------------
; DATOS rle_col_A08A: colores RLE: 12 tiles desde el 29 (lista 0x62a3)
;   0xa08a..0xa0bb  (49 bytes)
DATA_rle_col_A08A:
	defb 090h,0ffh,011h,0a1h,091h,0c1h,041h,0f1h,061h,0ffh,011h,0a1h,0c1h,051h,0a1h,081h	; a08a  ......A.a....Q..
	defb 0e1h,008h,0f9h,003h,0e9h,003h,0feh,002h,0f1h,008h,0feh,082h,0a1h,0f1h,006h,0feh	; a09a  ................
	defb 010h,0e9h,081h,0c1h,007h,0f1h,081h,0a1h,008h,0f1h,007h,0c1h,081h,0f1h,007h,0a1h	; a0aa  ................
	defb 000h	; a0ba

; ----------------------------------------------------------------------
; DATOS rle_col_A0BB: colores RLE: 12 tiles desde el 29 (lista 0x62a3)
;   0xa0bb..0xa0f1  (54 bytes)
DATA_rle_col_A0BB:
	defb 005h,0f9h,083h,011h,0a1h,091h,005h,0f9h,083h,0f1h,0a1h,0c1h,008h,0f9h,004h,0e9h	; a0bb  ................
	defb 00ch,0f1h,081h,0a1h,006h,0f1h,092h,0ffh,091h,041h,081h,0a1h,0e1h,051h,011h,0ffh	; a0cb  .........A...Q..
	defb 041h,0a1h,081h,091h,0e1h,071h,011h,0ffh,0c1h,007h,0f1h,081h,0a1h,008h,0f1h,007h	; a0db  A....q..........
	defb 0c1h,081h,0f1h,007h,0a1h,000h	; a0eb

; ----------------------------------------------------------------------
; DATOS rle_col_A0F1: colores RLE: 12 tiles desde el 29 (lista 0x62a3)
;   0xa0f1..0xa125  (52 bytes)
DATA_rle_col_A0F1:
	defb 007h,0f9h,081h,011h,007h,0f9h,081h,011h,005h,0f9h,003h,0f1h,003h,0e9h,00dh,0f1h	; a0f1  ................
	defb 081h,0a1h,007h,0f1h,092h,091h,041h,081h,0a1h,0e1h,051h,011h,0ffh,041h,0a1h,081h	; a101  ......A...Q..A..
	defb 091h,0e1h,071h,011h,0ffh,0c1h,0c1h,006h,0f1h,002h,0a1h,008h,0f1h,006h,0c1h,002h	; a111  ..q.............
	defb 0f1h,006h,0a1h,000h	; a121

; ----------------------------------------------------------------------
; DATOS rle_col_A125: colores RLE: 4 tiles desde el 123 (lista 0x6415)
;   0xa125..0xa12a  (5 bytes)
DATA_rle_col_A125:
	defb 00bh,0c1h,015h,0ech,000h	; a125

; ----------------------------------------------------------------------
; DATOS rle_col_A12A: colores RLE: 4 tiles desde el 97 (lista 0x62a3)
;   0xa12a..0xa12f  (5 bytes)
DATA_rle_col_A12A:
	defb 00bh,091h,015h,0e9h,000h	; a12a

; ----------------------------------------------------------------------
; DATOS rle_col_A12F: colores RLE: 12 tiles desde el 17 (lista 0x62a3)
;   0xa12f..0xa13e  (15 bytes)
DATA_rle_col_A12F:
	defb 00ch,0f9h,081h,091h,003h,0f1h,040h,0f6h,004h,0f1h,004h,091h,008h,0f9h,000h	; a12f  ......@........

; ----------------------------------------------------------------------
; DATOS rle_col_A13E: colores RLE: 12 tiles desde el 17 (lista 0x62a3)
;   0xa13e..0xa14f  (17 bytes)
DATA_rle_col_A13E:
	defb 004h,0f9h,004h,0ffh,008h,0f9h,040h,0f6h,004h,0f1h,004h,091h,004h,0f9h,004h,091h	; a13e  ......@.........
	defb 000h	; a14e

; ----------------------------------------------------------------------
; DATOS rle_col_A14F: colores RLE: 12 tiles desde el 17 (lista 0x62a3)
;   0xa14f..0xa15c  (13 bytes)
DATA_rle_col_A14F:
	defb 010h,0f9h,040h,0f6h,005h,0f1h,003h,091h,003h,0f1h,005h,091h,000h	; a14f  ..@..........

; ----------------------------------------------------------------------
; DATOS rle_col_A15C: colores RLE: 2 tiles desde el 203 (tabla85[56])
;   0xa15c..0xa15f  (3 bytes)
DATA_rle_col_A15C:
	defb 010h,0feh,000h	; a15c

; ----------------------------------------------------------------------
; DATOS rle_col_A15F: colores RLE: 2 tiles desde el 154 (tabla85[57])
;   0xa15f..0xa164  (5 bytes)
DATA_rle_col_A15F:
	defb 008h,0e1h,008h,0ebh,000h	; a15f

; ----------------------------------------------------------------------
; DATOS rle_col_A164: colores RLE: 1 tiles desde el 205 (lista 0x6415)
;   0xa164..0xa167  (3 bytes)
DATA_rle_col_A164:
	defb 008h,01eh,000h	; a164

; ----------------------------------------------------------------------
; DATOS rle_col_A167: colores RLE: 16 tiles desde el 15 (lista 0x65ab)
;   0xa167..0xa172  (11 bytes)
DATA_rle_col_A167:
	defb 010h,09ah,063h,0a1h,005h,091h,004h,0a1h,004h,091h,000h	; a167  ..c........

; ----------------------------------------------------------------------
; DATOS rle_col_A172: colores RLE: 16 tiles desde el 15 (lista 0x65ab)
;   0xa172..0xa17d  (11 bytes)
DATA_rle_col_A172:
	defb 010h,09ah,064h,0a1h,004h,091h,004h,0a1h,004h,091h,000h	; a172  ..d........

; ----------------------------------------------------------------------
; DATOS rle_col_A17D: colores RLE: 16 tiles desde el 15 (lista 0x65ab)
;   0xa17d..0xa188  (11 bytes)
DATA_rle_col_A17D:
	defb 00ch,09ah,081h,091h,067h,0a1h,004h,091h,008h,0a9h,000h	; a17d  ....g......

; ----------------------------------------------------------------------
; DATOS rle_col_A188: colores RLE: 14 tiles desde el 1 (lista 0x6568)
;   0xa188..0xa193  (11 bytes)
DATA_rle_col_A188:
	defb 010h,096h,050h,0f6h,007h,061h,081h,091h,008h,061h,000h	; a188  ..P..a...a.

; ----------------------------------------------------------------------
; DATOS rle_col_A193: colores RLE: 14 tiles desde el 1 (lista 0x6568)
;   0xa193..0xa1a0  (13 bytes)
DATA_rle_col_A193:
	defb 010h,096h,050h,0f6h,005h,061h,003h,091h,005h,061h,003h,091h,000h	; a193  ..P..a...a...

; ----------------------------------------------------------------------
; DATOS rle_col_A1A0: colores RLE: 14 tiles desde el 1 (lista 0x6568)
;   0xa1a0..0xa1af  (15 bytes)
DATA_rle_col_A1A0:
	defb 00ch,096h,081h,091h,003h,061h,050h,0f6h,005h,061h,003h,091h,008h,069h,000h	; a1a0  .....aP..a...i.

; ----------------------------------------------------------------------
; DATOS rle_col_A1AF: colores RLE: 2 tiles desde el 93 (lista 0x68b9)
;   0xa1af..0xa1b8  (9 bytes)
DATA_rle_col_A1AF:
	defb 004h,021h,004h,023h,004h,021h,004h,023h,000h	; a1af  .!.#.!.#.

; ----------------------------------------------------------------------
; DATOS rle_col_A1B8: colores RLE: 2 tiles desde el 93 (lista 0x68cf)
;   0xa1b8..0xa1c1  (9 bytes)
DATA_rle_col_A1B8:
	defb 004h,091h,004h,09bh,004h,091h,004h,09bh,000h	; a1b8  .........

; ----------------------------------------------------------------------
; DATOS rle_col_A1C1: colores RLE: 10 tiles desde el 9 (lista 0x71d4)
;   0xa1c1..0xa1d0  (15 bytes)
DATA_rle_col_A1C1:
	defb 040h,0f6h,007h,061h,089h,0f6h,0f1h,0f1h,041h,0a1h,061h,091h,0e1h,071h,000h	; a1c1  @..a....A.a..q.

; ----------------------------------------------------------------------
; DATOS rle_col_A1D0: colores RLE: 10 tiles desde el 9 (lista 0x71d4)
;   0xa1d0..0xa1dd  (13 bytes)
DATA_rle_col_A1D0:
	defb 040h,0f6h,008h,061h,003h,0f1h,085h,041h,0a1h,061h,091h,0e1h,000h	; a1d0  @..a...A.a...

; ----------------------------------------------------------------------
; DATOS rle_col_A1DD: colores RLE: 10 tiles desde el 9 (lista 0x71d4)
;   0xa1dd..0xa1ec  (15 bytes)
DATA_rle_col_A1DD:
	defb 040h,0f6h,082h,051h,061h,006h,061h,004h,0f1h,084h,041h,0a1h,061h,0e1h,000h	; a1dd  @..Qa.a...A.a..

; ----------------------------------------------------------------------
; DATOS rle_col_A1EC: colores RLE: 3 tiles desde el 35 (lista 0x6605)
;   0xa1ec..0xa1f3  (7 bytes)
DATA_rle_col_A1EC:
	defb 008h,0f5h,008h,095h,008h,0f9h,000h	; a1ec

; ----------------------------------------------------------------------
; DATOS rle_col_A1F3: colores RLE: 3 tiles desde el 35 (lista 0x6673)
;   0xa1f3..0xa1fa  (7 bytes)
DATA_rle_col_A1F3:
	defb 008h,0a4h,008h,064h,008h,0a6h,000h	; a1f3

; ----------------------------------------------------------------------
; DATOS rle_col_A1FA: colores RLE: 3 tiles desde el 35 (lista 0x66e1)
;   0xa1fa..0xa201  (7 bytes)
DATA_rle_col_A1FA:
	defb 008h,0a1h,008h,061h,008h,0a6h,000h	; a1fa

; ----------------------------------------------------------------------
; DATOS rle_col_A201: colores RLE: 3 tiles desde el 38 (lista 0x6605)
;   0xa201..0xa208  (7 bytes)
DATA_rle_col_A201:
	defb 008h,055h,008h,099h,008h,0ffh,000h	; a201

; ----------------------------------------------------------------------
; DATOS rle_col_A208: colores RLE: 3 tiles desde el 38 (lista 0x6673)
;   0xa208..0xa20f  (7 bytes)
DATA_rle_col_A208:
	defb 008h,044h,008h,066h,008h,0aah,000h	; a208

; ----------------------------------------------------------------------
; DATOS rle_col_A20F: colores RLE: 3 tiles desde el 38 (lista 0x66e1)
;   0xa20f..0xa216  (7 bytes)
DATA_rle_col_A20F:
	defb 008h,011h,008h,066h,008h,0aah,000h	; a20f

; ----------------------------------------------------------------------
; DATOS rle_col_A216: colores RLE: 3 tiles desde el 97 (lista 0x7113)
;   0xa216..0xa21d  (7 bytes)
DATA_rle_col_A216:
	defb 00bh,021h,003h,061h,00ah,021h,000h	; a216

; ----------------------------------------------------------------------
; DATOS rle_col_A21D: colores RLE: 3 tiles desde el 97 (lista 0x73b8)
;   0xa21d..0xa224  (7 bytes)
DATA_rle_col_A21D:
	defb 00bh,091h,003h,061h,00ah,091h,000h	; a21d

; ----------------------------------------------------------------------
; DATOS rle_col_A224: colores RLE: 2 tiles desde el 95 (lista 0x68b9)
;   0xa224..0xa227  (3 bytes)
DATA_rle_col_A224:
	defb 010h,021h,000h	; a224

; ----------------------------------------------------------------------
; DATOS rle_col_A227: colores RLE: 2 tiles desde el 95 (lista 0x68cf)
;   0xa227..0xa22a  (3 bytes)
DATA_rle_col_A227:
	defb 010h,091h,000h	; a227

; ----------------------------------------------------------------------
; DATOS rle_col_A22A: colores RLE: 12 tiles desde el 3 (lista 0x6529)
;   0xa22a..0xa239  (15 bytes)
DATA_rle_col_A22A:
	defb 00ch,052h,081h,021h,003h,051h,040h,05fh,004h,051h,004h,021h,008h,052h,000h	; a22a  .R.!.Q@_.Q.!.R.

; ----------------------------------------------------------------------
; DATOS rle_col_A239: colores RLE: 12 tiles desde el 3 (lista 0x6513)
;   0xa239..0xa248  (15 bytes)
DATA_rle_col_A239:
	defb 00ch,0fch,081h,0c1h,003h,0f1h,040h,0f6h,004h,0f1h,004h,0c1h,008h,0fch,000h	; a239  ......@........

; ----------------------------------------------------------------------
; DATOS rle_col_A248: colores RLE: 12 tiles desde el 3 (lista 0x6529)
;   0xa248..0xa259  (17 bytes)
DATA_rle_col_A248:
	defb 004h,052h,004h,055h,008h,052h,040h,05fh,004h,051h,004h,021h,004h,052h,004h,021h	; a248  .R.U.R@_.Q.!.R.!
	defb 000h	; a258

; ----------------------------------------------------------------------
; DATOS rle_col_A259: colores RLE: 12 tiles desde el 3 (lista 0x6513)
;   0xa259..0xa26a  (17 bytes)
DATA_rle_col_A259:
	defb 004h,0fch,004h,0ffh,008h,0fch,040h,0f6h,004h,0f1h,004h,0c1h,004h,0fch,004h,0c1h	; a259  ......@.........
	defb 000h	; a269

; ----------------------------------------------------------------------
; DATOS rle_col_A26A: colores RLE: 12 tiles desde el 3 (lista 0x6529)
;   0xa26a..0xa277  (13 bytes)
DATA_rle_col_A26A:
	defb 010h,052h,040h,05fh,005h,051h,003h,021h,003h,051h,005h,021h,000h	; a26a  .R@_.Q.!.Q.!.

; ----------------------------------------------------------------------
; DATOS rle_col_A277: colores RLE: 12 tiles desde el 3 (lista 0x6513)
;   0xa277..0xa284  (13 bytes)
DATA_rle_col_A277:
	defb 010h,0fch,040h,0f6h,005h,0f1h,003h,0c1h,003h,0f1h,005h,0c1h,000h	; a277  ..@..........

; ----------------------------------------------------------------------
; DATOS rle_col_A284: colores RLE: 16 tiles desde el 15 (lista 0x6585)
;   0xa284..0xa291  (13 bytes)
DATA_rle_col_A284:
	defb 010h,026h,060h,06ah,003h,061h,005h,021h,004h,061h,004h,021h,000h	; a284  .&`j.a.!.a.!.

; ----------------------------------------------------------------------
; DATOS rle_col_A291: colores RLE: 16 tiles desde el 15 (lista 0x6598)
;   0xa291..0xa29e  (13 bytes)
DATA_rle_col_A291:
	defb 010h,0c1h,060h,01ah,003h,01ch,005h,0cch,004h,01ch,004h,0cch,000h	; a291  ..`..........

; ----------------------------------------------------------------------
; DATOS rle_col_A29E: colores RLE: 16 tiles desde el 15 (lista 0x6585)
;   0xa29e..0xa2a9  (11 bytes)
DATA_rle_col_A29E:
	defb 010h,026h,064h,06ah,004h,021h,004h,061h,004h,021h,000h	; a29e  .&dj.!.a.!.

; ----------------------------------------------------------------------
; DATOS rle_col_A2A9: colores RLE: 16 tiles desde el 15 (lista 0x6598)
;   0xa2a9..0xa2b6  (13 bytes)
DATA_rle_col_A2A9:
	defb 010h,0c1h,060h,01ah,004h,01ch,004h,0cch,004h,01ch,004h,0cch,000h	; a2a9  ..`..........

; ----------------------------------------------------------------------
; DATOS rle_col_A2B6: colores RLE: 16 tiles desde el 15 (lista 0x6585)
;   0xa2b6..0xa2c1  (11 bytes)
DATA_rle_col_A2B6:
	defb 00ch,026h,081h,021h,067h,06ah,004h,021h,008h,062h,000h	; a2b6  .&.!gj.!.b.

; ----------------------------------------------------------------------
; DATOS rle_col_A2C1: colores RLE: 16 tiles desde el 15 (lista 0x6598)
;   0xa2c1..0xa2ce  (13 bytes)
DATA_rle_col_A2C1:
	defb 00ch,0c1h,081h,0cch,063h,01ah,004h,01ch,004h,0cch,008h,01ch,000h	; a2c1  ....c........

; ----------------------------------------------------------------------
; DATOS rle_col_A2CE: colores RLE: 14 tiles desde el 1 (lista 0x653f)
;   0xa2ce..0xa2d9  (11 bytes)
DATA_rle_col_A2CE:
	defb 010h,0cfh,050h,06fh,007h,0f1h,081h,0c1h,008h,0f1h,000h	; a2ce  ..Po.......

; ----------------------------------------------------------------------
; DATOS rle_col_A2D9: colores RLE: 14 tiles desde el 1 (lista 0x653f)
;   0xa2d9..0xa2e6  (13 bytes)
DATA_rle_col_A2D9:
	defb 010h,0cfh,050h,06fh,005h,0f1h,003h,0c1h,005h,0f1h,003h,0c1h,000h	; a2d9  ..Po.........

; ----------------------------------------------------------------------
; DATOS rle_col_A2E6: colores RLE: 14 tiles desde el 1 (lista 0x653f)
;   0xa2e6..0xa2f5  (15 bytes)
DATA_rle_col_A2E6:
	defb 00ch,0cfh,081h,0c1h,003h,0f1h,050h,06fh,005h,0f1h,003h,0c1h,008h,0fch,000h	; a2e6  ......Po.......

; ----------------------------------------------------------------------
; DATOS rle_col_A2F5: colores RLE: 8 tiles desde el 1 (lista 0x71d4)
;   0xa2f5..0xa2f8  (3 bytes)
DATA_rle_col_A2F5:
	defb 040h,0f4h,000h	; a2f5

; ----------------------------------------------------------------------
; DATOS rle_col_A2F8: colores RLE: 6 tiles desde el 62 (lista 0x67ea)
;   0xa2f8..0xa307  (15 bytes)
DATA_rle_col_A2F8:
	defb 008h,0f2h,018h,021h,005h,0e2h,085h,0e1h,021h,021h,0e2h,0e1h,006h,021h,000h	; a2f8  ...!....!!...!.

; ----------------------------------------------------------------------
; DATOS rle_col_A307: colores RLE: 6 tiles desde el 62 (lista 0x6834)
;   0xa307..0xa316  (15 bytes)
DATA_rle_col_A307:
	defb 008h,049h,018h,091h,005h,0e9h,085h,0e4h,091h,091h,0e9h,0e4h,006h,091h,000h	; a307  .I.............

; ----------------------------------------------------------------------
; DATOS rle_col_A316: colores RLE: 6 tiles desde el 62 (lista 0x6859)
;   0xa316..0xa325  (15 bytes)
DATA_rle_col_A316:
	defb 008h,0fch,018h,0c6h,005h,09ch,085h,096h,0c6h,0c6h,09ch,096h,006h,0c6h,000h	; a316  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_A325: colores RLE: 6 tiles desde el 62 (lista 0x680f)
;   0xa325..0xa334  (15 bytes)
DATA_rle_col_A325:
	defb 008h,0ech,018h,0ceh,005h,0fch,085h,0feh,0ceh,0ceh,0fch,0feh,006h,0ceh,000h	; a325  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_A334: colores RLE: 6 tiles desde el 62 (lista 0x67ea)
;   0xa334..0xa343  (15 bytes)
DATA_rle_col_A334:
	defb 008h,0f2h,018h,021h,006h,0e2h,085h,0e1h,021h,020h,0e2h,0e1h,005h,021h,000h	; a334  ...!....! ...!.

; ----------------------------------------------------------------------
; DATOS rle_col_A343: colores RLE: 6 tiles desde el 62 (lista 0x6834)
;   0xa343..0xa352  (15 bytes)
DATA_rle_col_A343:
	defb 008h,049h,018h,091h,006h,0e9h,085h,0e4h,091h,090h,0e9h,0e4h,005h,091h,000h	; a343  .I.............

; ----------------------------------------------------------------------
; DATOS rle_col_A352: colores RLE: 6 tiles desde el 62 (lista 0x6859)
;   0xa352..0xa361  (15 bytes)
DATA_rle_col_A352:
	defb 008h,0fch,018h,0c6h,006h,09ch,085h,096h,0c6h,0c0h,09ch,096h,005h,0c6h,000h	; a352  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_A361: colores RLE: 6 tiles desde el 62 (lista 0x680f)
;   0xa361..0xa370  (15 bytes)
DATA_rle_col_A361:
	defb 008h,0ech,018h,0ceh,006h,0fch,085h,0feh,0ceh,0c0h,0fch,0feh,005h,0ceh,000h	; a361  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_A370: colores RLE: 6 tiles desde el 62 (lista 0x67ea)
;   0xa370..0xa381  (17 bytes)
DATA_rle_col_A370:
	defb 008h,0f2h,018h,021h,004h,0e2h,087h,022h,021h,0e1h,0e2h,020h,021h,0e1h,005h,0e2h	; a370  ...!..."!.. !...
	defb 000h	; a380

; ----------------------------------------------------------------------
; DATOS rle_col_A381: colores RLE: 6 tiles desde el 62 (lista 0x6834)
;   0xa381..0xa392  (17 bytes)
DATA_rle_col_A381:
	defb 008h,049h,018h,091h,004h,0e9h,087h,099h,091h,0e4h,0e9h,090h,091h,0e4h,005h,0e9h	; a381  .I..............
	defb 000h	; a391

; ----------------------------------------------------------------------
; DATOS rle_col_A392: colores RLE: 6 tiles desde el 62 (lista 0x6859)
;   0xa392..0xa3a3  (17 bytes)
DATA_rle_col_A392:
	defb 008h,0fch,018h,0c6h,004h,09ch,087h,0cch,0c6h,096h,09ch,0c0h,0c6h,096h,005h,09ch	; a392  ................
	defb 000h	; a3a2

; ----------------------------------------------------------------------
; DATOS rle_col_A3A3: colores RLE: 6 tiles desde el 62 (lista 0x680f)
;   0xa3a3..0xa3b4  (17 bytes)
DATA_rle_col_A3A3:
	defb 008h,0ech,018h,0ceh,004h,0fch,087h,0cch,0ceh,0feh,0fch,0c0h,0ceh,0feh,005h,0fch	; a3a3  ................
	defb 000h	; a3b3

; ----------------------------------------------------------------------
; DATOS pantalla_A3B4: pantalla comprimida para RLE_A_RAM (p01 0x637A): 16
;   filas de 32 tiles, destino 0xe400 en la cabecera; p00 0x5F9B (con 5/6)
;   0xa3b4..0xa4ed  (313 bytes)
DATA_pantalla_A3B4:
	defb 000h,0e4h,001h,06dh,08eh,04ah,091h,05eh,001h,06eh,0eeh,001h,001h,05fh,090h,05eh	; a3b4  ...m.J.^.n..._.^
	defb 001h,06eh,08eh,000h,001h,05fh,090h,05eh,005h,06eh,000h,000h,052h,047h,0e3h,053h	; a3c4  .n..._.^.n..RG.S
	defb 0f3h,064h,00bh,047h,061h,050h,050h,051h,05eh,05eh,048h,03ch,03bh,049h,0e7h,03dh	; a3d4  .d.GaPPQ^^H<;I.=
	defb 016h,018h,071h,04bh,06eh,000h,000h,056h,000h,057h,058h,060h,06fh,067h,066h,000h	; a3e4  ..qKn..V.WX`ogf.
	defb 065h,000h,000h,05fh,05eh,044h,045h,0ech,019h,004h,04bh,06eh,000h,000h,0e5h,059h	; a3f4  e.._^DE...Kn...Y
	defb 0f5h,06ch,004h,04eh,04eh,04fh,039h,0e4h,025h,001h,070h,0e4h,029h,0e4h,02ch,003h	; a404  .l.NNO9.%.p.).,.
	defb 031h,04bh,06eh,08eh,000h,006h,05fh,04ch,04ch,035h,033h,04dh,086h,05eh,002h,046h	; a414  1Kn..._LL53M.^.F
	defb 037h,083h,05eh,001h,06eh,0e4h,00fh,001h,000h,0e5h,013h,084h,000h,006h,05fh,05eh	; a424  7.^.n........._^
	defb 05eh,030h,032h,034h,086h,05eh,006h,036h,038h,03ah,05eh,05eh,05ch,0e4h,000h,0e3h	; a434  ^024.^.68:^^\...
	defb 003h,087h,000h,003h,05eh,03ch,03dh,0e3h,027h,086h,040h,006h,017h,000h,05dh,040h	; a444  ....^<=.'.@...]@
	defb 040h,05ch,0e4h,000h,005h,003h,003h,006h,005h,007h,085h,000h,003h,05eh,05dh,018h	; a454  @\...........^].
	defb 0e3h,02ah,001h,03fh,084h,02dh,0e4h,02eh,003h,03eh,040h,05ch,08eh,000h,001h,05eh	; a464  .*.?.-...>@\...^
	defb 0e8h,032h,083h,039h,011h,03ah,03bh,01bh,018h,026h,05ch,008h,007h,009h,00ah,000h	; a474  .2.9.:;..&\.....
	defb 00bh,00ch,009h,00dh,004h,00eh,083h,000h,002h,05eh,01ah,083h,000h,003h,05fh,000h	; a484  .........^...._.
	defb 019h,086h,01ch,00ah,01bh,018h,023h,05ch,000h,00fh,010h,003h,011h,00dh,088h,000h	; a494  ......#\........
	defb 001h,05eh,0e8h,04dh,083h,054h,006h,055h,056h,01bh,018h,041h,05ch,08eh,000h,003h	; a4a4  .^.M.T.UV..A\...
	defb 05eh,05dh,018h,0e3h,045h,001h,05ah,084h,048h,0e4h,049h,014h,059h,05bh,05ch,008h	; a4b4  ^]..E.Z.H.I.Y[\.
	defb 003h,012h,010h,003h,003h,000h,013h,014h,00fh,015h,00ch,016h,000h,05eh,057h,058h	; a4c4  .............^WX
	defb 0e3h,042h,086h,05bh,006h,017h,000h,05dh,05bh,05bh,025h,08eh,024h,083h,05bh,0e3h	; a4d4  .B.[...][[%.$.[.
	defb 01dh,086h,05bh,0e3h,020h,002h,05bh,05bh,000h	; a4e4  ..[. .[[.

; ----------------------------------------------------------------------
; DATOS rle_pat_A4ED: patrones RLE: 21 tiles desde el 67 (lista 0x7010)
;   0xa4ed..0xa583  (150 bytes)
DATA_rle_pat_A4ED:
	defb 08ah,0f0h,0c0h,09eh,0a2h,0a2h,0ddh,0c1h,03fh,000h,083h,003h,001h,002h,0feh,091h	; a4ed  ........?.......
	defb 0ffh,03fh,00fh,0e7h,017h,013h,0ech,00ch,0f0h,00fh,00fh,0ffh,0ffh,0f8h,0ffh,00fh	; a4fd  .?..............
	defb 00fh,008h,0ffh,081h,0c0h,007h,0fch,092h,01eh,03ch,0fch,0ffh,0ffh,0fch,0f0h,0e0h	; a50d  .........<......
	defb 001h,0aah,0aah,0ffh,0ffh,0c8h,0c8h,0ech,0c0h,0f0h,004h,0fch,08dh,03ch,01ch,0c0h	; a51d  .............<..
	defb 0e0h,0e0h,0f0h,0d0h,0d8h,0cfh,0cfh,06ch,064h,074h,003h,036h,002h,0ffh,088h,00ch	; a52d  .......ldt.6....
	defb 01ch,01ch,03ch,02ch,06ch,0cch,0cch,003h,0cfh,082h,030h,0ffh,003h,0cfh,007h,0ffh	; a53d  ..<,l.....0.....
	defb 081h,0feh,003h,0cch,002h,0fch,004h,0cch,09fh,0d8h,07bh,018h,0f3h,0f0h,0f3h,0f0h	; a54d  ..........{.....
	defb 000h,000h,0ffh,000h,0ffh,000h,0ffh,000h,0cch,06ch,078h,060h,03ch,03ch,0bch,03ch	; a55d  .........lx`<<.<
	defb 0f3h,0f0h,0e3h,0a0h,060h,0f0h,07fh,080h,006h,000h,08ah,0ffh,000h,0bch,03ch,09ch	; a56d  ....`.........<.
	defb 014h,018h,03ch,0f8h,000h,000h	; a57d

; ----------------------------------------------------------------------
; DATOS rle_pat_A583: patrones RLE: 21 tiles desde el 67 (lista 0x7029)
;   0xa583..0xa613  (144 bytes)
DATA_rle_pat_A583:
	defb 084h,0f8h,080h,03fh,0c0h,004h,080h,085h,000h,0ffh,0ffh,099h,0ffh,003h,000h,084h	; a583  ...?............
	defb 01fh,001h,0fch,003h,004h,0feh,005h,080h,083h,000h,0c9h,0c9h,006h,0ffh,002h,03ch	; a593  ...............<
	defb 005h,0feh,0a0h,0ffh,093h,093h,0c9h,0c0h,0ffh,0f0h,0e0h,0c0h,0e0h,0e0h,03ch,03ch	; a5a3  ..............<<
	defb 0ffh,060h,030h,098h,0c8h,0c8h,093h,003h,0ffh,00fh,007h,003h,007h,007h,0e0h,0f0h	; a5b3  .`0.............
	defb 0d0h,0d7h,0dfh,003h,0cfh,002h,0c8h,081h,0c0h,005h,0ffh,085h,007h,00fh,00bh,0ebh	; a5c3  ................
	defb 0fbh,003h,0f3h,083h,0cfh,030h,0ffh,003h,0cfh,082h,00fh,08fh,008h,0ffh,083h,0f3h	; a5d3  .....0..........
	defb 00ch,0ffh,003h,0f3h,084h,0f0h,0f1h,070h,0f8h,005h,0f0h,081h,0e0h,003h,0c0h,087h	; a5e3  .......p........
	defb 0f8h,0ffh,000h,000h,0cch,00eh,01fh,005h,00fh,08bh,007h,0e0h,0c0h,0e0h,0ffh,080h	; a5f3  ................
	defb 0c0h,0c0h,0f8h,0c6h,0c6h,006h,0e3h,085h,007h,003h,007h,0ffh,0feh,003h,0fch,000h	; a603  ................

; ----------------------------------------------------------------------
; DATOS rle_pat_A613: patrones RLE: 21 tiles desde el 67 (lista 0x7042)
;   0xa613..0xa696  (131 bytes)
DATA_rle_pat_A613:
	defb 085h,0e0h,080h,080h,003h,003h,003h,0fbh,081h,07fh,003h,040h,003h,080h,086h,00eh	; a613  ...........@....
	defb 007h,001h,001h,0c0h,0c0h,003h,09eh,002h,0fbh,002h,0fah,002h,0f6h,002h,0b4h,002h	; a623  ................
	defb 081h,082h,000h,030h,004h,060h,092h,09eh,01eh,00ch,000h,07fh,07fh,03fh,03fh,084h	; a633  ...0.`.......??.
	defb 084h,086h,087h,085h,084h,084h,08ch,060h,07eh,006h,0ffh,002h,03fh,08ah,0ffh,0e1h	; a643  .......`~...?...
	defb 0a1h,021h,021h,031h,08ch,08ch,084h,0ffh,004h,087h,007h,0ffh,084h,0feh,031h,031h	; a653  .!!1..........11
	defb 021h,005h,01ch,002h,087h,004h,083h,002h,0bdh,006h,0feh,002h,0fch,002h,01ch,006h	; a663  !...............
	defb 03ch,084h,0bdh,0bfh,0bfh,083h,003h,080h,081h,07fh,004h,0fch,002h,0ffh,002h,000h	; a673  <...............
	defb 004h,07dh,003h,001h,081h,0feh,006h,09fh,002h,000h,006h,0ffh,002h,000h,006h,0fah	; a683  .}..............
	defb 002h,0ffh,000h	; a693

; ----------------------------------------------------------------------
; DATOS rle_pat_A696: patrones RLE: 21 tiles desde el 67 (lista 0x705b)
;   0xa696..0xa71b  (133 bytes)
DATA_rle_pat_A696:
	defb 004h,0ffh,004h,0f0h,003h,0ffh,085h,0e7h,099h,0bdh,0bdh,03ch,004h,0ffh,081h,00fh	; a696  ...........<....
	defb 004h,0f0h,087h,0f1h,0c7h,0c6h,0c1h,0c0h,0c3h,0c1h,004h,03ch,004h,07eh,08ch,0f0h	; a6a6  ...........<.~..
	defb 070h,000h,0c0h,020h,0c0h,0e0h,020h,0c4h,0feh,0ffh,0f8h,004h,0f0h,08ch,07eh,0feh	; a6b6  p.. .. .......~.
	defb 0ffh,0ffh,0e7h,0c3h,0c3h,081h,040h,080h,000h,000h,00ch,0f0h,002h,081h,002h,099h	; a6c6  ......@.........
	defb 084h,081h,0dbh,0dbh,0feh,007h,0f0h,081h,020h,007h,0f0h,0a9h,0f3h,0fdh,0fch,0fdh	; a6d6  ........ .......
	defb 0fch,0fdh,0feh,07eh,07eh,0f0h,010h,0f0h,010h,0f0h,020h,0f0h,030h,08eh,084h,081h	; a6e6  ...~~..... .0...
	defb 080h,087h,080h,084h,08ch,07eh,07eh,03ch,0e7h,0e7h,066h,000h,0f7h,080h,040h,020h	; a6f6  .....~~<..f...@ 
	defb 0c0h,0e0h,020h,040h,080h,008h,0f8h,002h,0ffh,082h,07eh,000h,004h,018h,004h,0e0h	; a706  .. @......~.....
	defb 081h,000h,003h,0e0h,000h	; a716

; ----------------------------------------------------------------------
; DATOS rle_pat_A71B: patrones RLE: 21 tiles desde el 67 (lista 0x7074)
;   0xa71b..0xa7a7  (140 bytes)
DATA_rle_pat_A71B:
	defb 003h,0ffh,005h,0f0h,085h,0ffh,0e7h,0c3h,0c3h,03ch,003h,07eh,003h,0ffh,002h,00fh	; a71b  .........<.~....
	defb 004h,0f0h,088h,0f7h,00eh,009h,007h,000h,007h,00bh,07eh,006h,040h,08bh,060h,0f0h	; a72b  ..........~.@.`.
	defb 010h,080h,060h,010h,0e0h,0f0h,020h,00ch,0feh,003h,0ffh,086h,0fch,0f8h,0f8h,040h	; a73b  ..`... ........@
	defb 0c3h,081h,004h,0a5h,083h,099h,0c0h,080h,004h,000h,002h,0e0h,003h,0f0h,005h,0e0h	; a74b  ................
	defb 088h,0bdh,099h,081h,0c3h,0ffh,0c3h,0dbh,0dbh,003h,0f0h,005h,0f8h,004h,0e0h,002h	; a75b  ................
	defb 0f0h,002h,0f8h,088h,05ah,000h,03ch,028h,03ch,028h,03ch,028h,004h,0f8h,002h,0f0h	; a76b  ....Z.<(<(<(....
	defb 002h,0e0h,002h,007h,08ah,004h,001h,004h,000h,007h,000h,0bdh,03ch,081h,081h,003h	; a77b  ............<...
	defb 024h,003h,000h,086h,0c0h,020h,0c0h,0e0h,000h,0e0h,007h,0f8h,004h,0ffh,081h,03ch	; a78b  $.... .........<
	defb 004h,018h,081h,000h,003h,0e0h,084h,000h,0e0h,0e0h,000h,000h	; a79b  ............

; ----------------------------------------------------------------------
; DATOS rle_pat_A7A7: patrones RLE: 21 tiles desde el 67 (lista 0x708d)
;   0xa7a7..0xa82c  (133 bytes)
DATA_rle_pat_A7A7:
	defb 081h,0ffh,006h,0f0h,085h,087h,0e7h,018h,0dbh,0bdh,004h,03ch,081h,000h,006h,0f0h	; a7a7  ...........<....
	defb 08bh,000h,087h,084h,081h,080h,085h,086h,086h,0ffh,03ch,03ch,003h,07eh,003h,020h	; a7b7  ..........<<.~. 
	defb 088h,000h,0c0h,020h,0c0h,0e0h,040h,080h,000h,004h,0ffh,081h,0f0h,003h,0e0h,002h	; a7c7  ... ..@.........
	defb 020h,002h,0c3h,004h,0a5h,008h,0f8h,008h,0e0h,088h,0bdh,099h,099h,081h,0c3h,040h	; a7d7   ..............@
	defb 060h,060h,008h,0f8h,002h,0e0h,003h,0f0h,083h,0f8h,0fch,0fch,005h,060h,002h,020h	; a7e7  ``...........`. 
	defb 083h,07eh,0f8h,0f8h,003h,0f0h,083h,0e0h,0c0h,0c0h,003h,0feh,08dh,007h,006h,005h	; a7f7  .~..............
	defb 003h,000h,07eh,07eh,03ch,03ch,018h,0ffh,0dbh,0c3h,003h,080h,086h,000h,080h,040h	; a807  ..~~<<.........@
	defb 020h,0c0h,003h,003h,007h,003h,0f8h,004h,0ffh,081h,00fh,004h,018h,004h,0e0h,084h	; a817   ...............
	defb 000h,0e0h,0e0h,000h,000h	; a827

; ----------------------------------------------------------------------
; DATOS rle_pat_A82C: patrones RLE: 7 tiles desde el 130 (lista 0x7010)
;   0xa82c..0xa83f  (19 bytes)
DATA_rle_pat_A82C:
	defb 006h,0ffh,003h,07fh,00dh,03fh,007h,01fh,00fh,00fh,004h,01fh,004h,03fh,003h,07fh	; a82c  .....?.......?..
	defb 081h,0ffh,000h	; a83c

; ----------------------------------------------------------------------
; DATOS rle_pat_A83F: patrones RLE: 7 tiles desde el 130 (lista 0x7029)
;   0xa83f..0xa854  (21 bytes)
DATA_rle_pat_A83F:
	defb 005h,0ffh,002h,03fh,00bh,01fh,002h,00fh,002h,007h,01ah,003h,003h,007h,002h,00fh	; a83f  ...?............
	defb 002h,01fh,081h,03fh,000h	; a84f

; ----------------------------------------------------------------------
; DATOS rle_pat_A854: patrones RLE: 7 tiles desde el 130 (lista 0x7042)
;   0xa854..0xa863  (15 bytes)
DATA_rle_pat_A854:
	defb 003h,0ffh,083h,07fh,03fh,03fh,022h,01fh,006h,00fh,008h,007h,002h,0ffh,000h	; a854  ....??"........

; ----------------------------------------------------------------------
; DATOS rle_pat_A863: patrones RLE: 7 tiles desde el 130 (lista 0x705b)
;   0xa863..0xa870  (13 bytes)
DATA_rle_pat_A863:
	defb 00bh,0ffh,011h,07fh,00ah,03fh,005h,07fh,006h,0ffh,007h,01fh,000h	; a863  .....?.......

; ----------------------------------------------------------------------
; DATOS rle_pat_A870: patrones RLE: 7 tiles desde el 130 (lista 0x7074)
;   0xa870..0xa87d  (13 bytes)
DATA_rle_pat_A870:
	defb 00dh,0ffh,00bh,07fh,00ah,03fh,009h,07fh,005h,0ffh,008h,01fh,000h	; a870  .....?.......

; ----------------------------------------------------------------------
; DATOS rle_pat_A87D: patrones RLE: 7 tiles desde el 130 (lista 0x708d)
;   0xa87d..0xa88a  (13 bytes)
DATA_rle_pat_A87D:
	defb 00bh,0ffh,00fh,07fh,00ah,03fh,007h,07fh,005h,0ffh,008h,01fh,000h	; a87d  .....?.......

; ----------------------------------------------------------------------
; DATOS rle_col_A88A: colores RLE: 21 tiles desde el 88 (lista 0x7010)
;   0xa88a..0xa8e1  (87 bytes)
DATA_rle_col_A88A:
	defb 081h,0e1h,004h,0e5h,081h,054h,004h,051h,003h,0e5h,084h,054h,051h,051h,0e1h,004h	; a88a  .....T.Q...TQQ..
	defb 0e5h,083h,051h,041h,041h,004h,054h,081h,075h,00bh,054h,002h,041h,002h,051h,084h	; a89a  ..QAA.T.u.T.A.Q.
	defb 071h,051h,041h,041h,009h,051h,002h,041h,002h,051h,00bh,041h,008h,051h,006h,041h	; a8aa  qQAA.Q.A.Q.A.Q.A
	defb 002h,054h,008h,041h,003h,051h,081h,075h,004h,051h,008h,054h,008h,041h,004h,051h	; a8ba  .T.A.Q.u.Q.T.A.Q
	defb 002h,041h,082h,051h,071h,00fh,041h,082h,071h,051h,003h,041h,003h,051h,081h,0e1h	; a8ca  .A.Qq.A.qQ.A.Q..
	defb 003h,044h,006h,051h,007h,041h,000h	; a8da

; ----------------------------------------------------------------------
; DATOS rle_col_A8E1: colores RLE: 21 tiles desde el 109 (lista 0x7010)
;   0xa8e1..0xa93a  (89 bytes)
DATA_rle_col_A8E1:
	defb 081h,0e1h,004h,0ebh,081h,0bah,004h,0b1h,003h,0ebh,084h,0bah,0b1h,0b1h,0e1h,004h	; a8e1  ................
	defb 0ebh,083h,0b1h,0a1h,0a1h,004h,0bah,081h,0fbh,00bh,0bah,002h,0a1h,002h,0b1h,084h	; a8f1  ................
	defb 0f1h,0b1h,0a1h,0a1h,009h,0b1h,002h,0a1h,002h,0b1h,003h,041h,008h,0a1h,008h,0b1h	; a901  ...........A....
	defb 006h,041h,002h,0bah,008h,0a1h,003h,0b1h,081h,0fbh,004h,0b1h,008h,0bah,008h,0a1h	; a911  .A..............
	defb 004h,0b1h,002h,0a1h,082h,0b1h,0f1h,00fh,0a1h,082h,0f1h,0b1h,003h,0a1h,003h,0b1h	; a921  ................
	defb 081h,0e1h,003h,0aah,006h,0b1h,007h,0a1h,000h	; a931  .........

; ----------------------------------------------------------------------
; DATOS rle_col_A93A: colores RLE: 21 tiles desde el 67 (lista 0x7010)
;   0xa93a..0xa993  (89 bytes)
DATA_rle_col_A93A:
	defb 081h,0e1h,004h,0e8h,081h,086h,004h,081h,003h,0e8h,084h,086h,081h,081h,0e1h,004h	; a93a  ................
	defb 0e8h,083h,081h,061h,061h,004h,086h,081h,098h,00bh,086h,002h,061h,002h,081h,084h	; a94a  ...aa.......a...
	defb 091h,081h,061h,061h,009h,081h,002h,061h,002h,081h,003h,041h,008h,061h,008h,081h	; a95a  ..aa...a...A.a..
	defb 006h,041h,002h,086h,008h,061h,003h,081h,081h,098h,004h,081h,008h,086h,008h,061h	; a96a  .A...a.........a
	defb 004h,081h,002h,061h,082h,081h,091h,00fh,061h,082h,091h,081h,003h,061h,003h,081h	; a97a  ...a....a....a..
	defb 081h,0e1h,003h,066h,006h,081h,007h,061h,000h	; a98a  ...f...a.

; ----------------------------------------------------------------------
; DATOS rle_col_A993: colores RLE: 21 tiles desde el 67 (lista 0x7029)
;   0xa993..0xa9f7  (100 bytes)
DATA_rle_col_A993:
	defb 084h,0e1h,0e4h,074h,041h,004h,0f7h,004h,041h,004h,0f7h,084h,0e1h,0e4h,074h,041h	; a993  ...tA...A.....tA
	defb 004h,074h,006h,0f7h,00ah,075h,006h,074h,002h,075h,082h,074h,071h,007h,074h,002h	; a9a3  .t...u.t.u.tq.t.
	defb 071h,005h,041h,081h,074h,007h,071h,004h,074h,004h,071h,003h,041h,00eh,071h,081h	; a9b3  q.A.t.q.t.q.A.q.
	defb 0f7h,00fh,071h,081h,0f7h,006h,071h,082h,0f7h,071h,003h,075h,002h,071h,083h,074h	; a9c3  ..q...q..q.u.q.t
	defb 077h,011h,003h,054h,003h,041h,085h,0f7h,071h,074h,074h,075h,003h,071h,004h,074h	; a9d3  w..T.A..qttu.q.t
	defb 084h,0e7h,0e5h,0e4h,0e1h,003h,041h,002h,077h,083h,055h,044h,011h,005h,071h,083h	; a9e3  ......A.w.UD..q.
	defb 051h,041h,011h,000h	; a9f3

; ----------------------------------------------------------------------
; DATOS rle_col_A9F7: colores RLE: 21 tiles desde el 88 (lista 0x7029)
;   0xa9f7..0xaa5b  (100 bytes)
DATA_rle_col_A9F7:
	defb 084h,0e1h,0e4h,0f4h,041h,004h,0ffh,004h,041h,004h,0ffh,084h,0e1h,0e4h,0f4h,041h	; a9f7  ....A...A......A
	defb 004h,0f4h,006h,0ffh,00ah,0f5h,006h,0f4h,002h,0f5h,082h,0f4h,0f1h,007h,0f4h,002h	; aa07  ................
	defb 0f1h,005h,041h,081h,0f4h,007h,0f1h,004h,0f4h,004h,0f1h,003h,041h,00eh,0f1h,081h	; aa17  ..A.........A...
	defb 0ffh,00fh,0f1h,081h,0ffh,006h,0f1h,082h,0ffh,0f1h,003h,0f5h,002h,0f1h,083h,0f4h	; aa27  ................
	defb 0ffh,011h,003h,054h,003h,041h,085h,0ffh,0f1h,0f4h,0f4h,0f5h,003h,0f1h,004h,0f4h	; aa37  ...T.A..........
	defb 084h,0efh,0e5h,0e4h,0e1h,003h,041h,002h,0ffh,083h,055h,044h,011h,005h,0f1h,083h	; aa47  ......A...UD....
	defb 051h,041h,011h,000h	; aa57

; ----------------------------------------------------------------------
; DATOS rle_col_AA5B: colores RLE: 21 tiles desde el 109 (lista 0x7029)
;   0xaa5b..0xaabf  (100 bytes)
DATA_rle_col_AA5B:
	defb 084h,0e1h,0e4h,0a4h,041h,004h,0fah,004h,041h,004h,0fah,084h,0e1h,0e4h,0a4h,041h	; aa5b  ....A...A......A
	defb 004h,0a4h,006h,0fah,00ah,0a5h,006h,0a4h,002h,0a5h,082h,0a4h,0a1h,007h,0a4h,002h	; aa6b  ................
	defb 0a1h,005h,041h,081h,0a4h,007h,0a1h,004h,0a4h,004h,0a1h,003h,041h,00eh,0a1h,081h	; aa7b  ..A.........A...
	defb 0fah,00fh,0a1h,081h,0fah,006h,0a1h,082h,0fah,0a1h,003h,0a5h,002h,0a1h,083h,0a4h	; aa8b  ................
	defb 0aah,011h,003h,054h,003h,041h,085h,0fah,0a1h,0a4h,0a4h,0a5h,003h,0a1h,004h,0a4h	; aa9b  ...T.A..........
	defb 084h,0eah,0e5h,0e4h,0e1h,003h,041h,002h,0aah,083h,055h,044h,011h,005h,0a1h,083h	; aaab  ......A...UD....
	defb 051h,041h,011h,000h	; aabb

; ----------------------------------------------------------------------
; DATOS rle_col_AABF: colores RLE: 21 tiles desde el 88 (lista 0x7042)
;   0xaabf..0xab1f  (96 bytes)
DATA_rle_col_AABF:
	defb 085h,0e2h,0ech,0e1h,021h,021h,003h,032h,008h,0f3h,085h,0e2h,0ech,0e1h,021h,021h	; aabf  ....!!.2......!!
	defb 007h,032h,004h,03ch,082h,0f2h,021h,006h,041h,004h,032h,004h,021h,007h,0fch,083h	; aacf  .2.<..!.A.2.!...
	defb 0f1h,021h,0f1h,006h,031h,002h,021h,005h,02ch,081h,021h,003h,0f1h,005h,0f3h,008h	; aadf  .!..1.!.,.!.....
	defb 032h,003h,021h,081h,0f2h,004h,032h,003h,0f3h,082h,0f1h,0fch,003h,0f2h,00bh,032h	; aaef  2.!...2........2
	defb 086h,012h,0c2h,032h,0f2h,032h,0fch,004h,03ch,002h,031h,081h,0f3h,004h,032h,003h	; aaff  ...2.2..<.1...2.
	defb 0c1h,081h,02fh,007h,02ch,081h,0f2h,006h,031h,00ah,03eh,006h,032h,002h,0e0h,000h	; ab0f  ../.,...1.>.2...

; ----------------------------------------------------------------------
; DATOS rle_col_AB1F: colores RLE: 21 tiles desde el 67 (lista 0x7042)
;   0xab1f..0xab7f  (96 bytes)
DATA_rle_col_AB1F:
	defb 085h,0e5h,0e4h,0e1h,051h,051h,003h,075h,008h,0f7h,085h,0e5h,0e4h,0e1h,051h,051h	; ab1f  ....QQ.u......QQ
	defb 007h,075h,004h,074h,082h,0f5h,051h,006h,041h,004h,075h,004h,051h,007h,0f4h,083h	; ab2f  .u.t..Q.A.u.Q...
	defb 0f1h,051h,0f1h,006h,071h,002h,051h,005h,054h,081h,051h,003h,0f1h,005h,0f7h,008h	; ab3f  .Q..q.Q.T.Q.....
	defb 075h,003h,051h,081h,0f5h,004h,075h,003h,0f7h,082h,0f1h,0f4h,003h,0f5h,00bh,075h	; ab4f  u.Q...u........u
	defb 086h,015h,045h,075h,0f5h,075h,0f4h,004h,074h,002h,071h,081h,0f7h,004h,075h,003h	; ab5f  ..Eu.u..t.q...u.
	defb 041h,081h,05fh,007h,054h,081h,0f5h,006h,071h,00ah,07eh,006h,075h,002h,0e0h,000h	; ab6f  A._.T...q.~.u...

; ----------------------------------------------------------------------
; DATOS rle_col_AB7F: colores RLE: 21 tiles desde el 109 (lista 0x7042)
;   0xab7f..0xabdf  (96 bytes)
DATA_rle_col_AB7F:
	defb 085h,0e8h,0e6h,0e1h,081h,081h,003h,098h,008h,0a9h,085h,0e8h,0e6h,0e1h,081h,081h	; ab7f  ................
	defb 007h,098h,004h,096h,082h,0a8h,081h,006h,041h,004h,098h,004h,081h,007h,0a6h,083h	; ab8f  ........A.......
	defb 0a1h,081h,0a1h,006h,091h,002h,081h,005h,086h,081h,081h,003h,0a1h,005h,0a9h,008h	; ab9f  ................
	defb 098h,003h,081h,081h,0a8h,004h,098h,003h,0a9h,082h,0a1h,0a6h,003h,0a8h,00bh,098h	; abaf  ................
	defb 086h,018h,068h,098h,0a8h,098h,0a6h,004h,096h,002h,091h,081h,0a9h,004h,098h,003h	; abbf  ..h.............
	defb 061h,081h,08ah,007h,086h,081h,0a8h,006h,091h,00ah,09eh,006h,098h,002h,0e0h,000h	; abcf  a...............

; ----------------------------------------------------------------------
; DATOS rle_col_ABDF: colores RLE: 21 tiles desde el 88 (lista 0x705b)
;   0xabdf..0xac3d  (94 bytes)
DATA_rle_col_ABDF:
	defb 00ch,0e2h,004h,02ch,005h,0e2h,003h,021h,002h,0e2h,006h,0e1h,082h,02ch,021h,006h	; abdf  ...,...!.....,!.
	defb 02ch,003h,021h,005h,041h,004h,0e1h,084h,0e3h,0e2h,0ech,0ech,004h,02ch,004h,021h	; abef  ,.!.A........,.!
	defb 081h,0e1h,003h,041h,084h,031h,021h,0c1h,0c1h,008h,0ech,008h,021h,007h,0c1h,081h	; abff  ...A.1!.....!...
	defb 0e1h,008h,0ech,006h,021h,002h,02ch,006h,0e1h,002h,0c1h,008h,0e1h,003h,02ch,005h	; ac0f  ....!.,.......,.
	defb 0c1h,088h,041h,0e1h,041h,0e1h,041h,041h,0e1h,041h,004h,0ech,084h,0e1h,0ech,0e2h	; ac1f  ..A.A.AA.A......
	defb 0eeh,004h,02ch,084h,011h,0cch,0f3h,011h,006h,0c1h,082h,021h,011h,000h	; ac2f  ..,........!..

; ----------------------------------------------------------------------
; DATOS rle_col_AC3D: colores RLE: 21 tiles desde el 109 (lista 0x705b)
;   0xac3d..0xac9a  (93 bytes)
DATA_rle_col_AC3D:
	defb 00ch,0e5h,004h,054h,005h,0e5h,003h,051h,002h,0e5h,006h,0e1h,082h,054h,051h,006h	; ac3d  ...T...Q.....TQ.
	defb 054h,003h,051h,005h,041h,004h,0e1h,084h,0e7h,0e5h,0e4h,0e4h,004h,054h,004h,051h	; ac4d  T.Q.A........T.Q
	defb 081h,0e1h,003h,041h,084h,071h,051h,041h,041h,008h,0e4h,008h,051h,007h,041h,081h	; ac5d  ...A.qQAA...Q.A.
	defb 0e1h,008h,0e4h,006h,051h,002h,054h,006h,0e1h,002h,041h,008h,0e1h,003h,054h,006h	; ac6d  ....Q.T...A...T.
	defb 041h,087h,0e1h,041h,0e1h,041h,041h,0e1h,041h,004h,0e4h,084h,0e1h,0e4h,0e5h,0eeh	; ac7d  A..A.AA.A.......
	defb 004h,054h,084h,011h,044h,0f7h,011h,006h,041h,082h,051h,011h,000h	; ac8d  .T..D...A.Q..

; ----------------------------------------------------------------------
; DATOS rle_col_AC9A: colores RLE: 21 tiles desde el 67 (lista 0x705b)
;   0xac9a..0xacf8  (94 bytes)
DATA_rle_col_AC9A:
	defb 00ch,0e8h,004h,086h,005h,0e8h,003h,081h,002h,0e8h,006h,0e1h,082h,086h,081h,006h	; ac9a  ................
	defb 086h,003h,081h,005h,041h,004h,0e1h,084h,0e9h,0e8h,0e6h,0e6h,004h,086h,004h,081h	; acaa  ....A...........
	defb 081h,0e1h,003h,041h,084h,091h,081h,061h,061h,008h,0e6h,008h,081h,007h,061h,081h	; acba  ...A...aa.....a.
	defb 0e1h,008h,0e6h,006h,081h,002h,086h,006h,0e1h,002h,061h,008h,0e1h,003h,086h,005h	; acca  ..........a.....
	defb 061h,088h,041h,0e1h,041h,0e1h,041h,041h,0e1h,041h,004h,0e6h,084h,0e1h,0e6h,0e8h	; acda  a.A.A.AA.A......
	defb 0eeh,004h,086h,084h,011h,066h,0a9h,011h,006h,061h,082h,081h,011h,000h	; acea  .....f...a....

; ----------------------------------------------------------------------
; DATOS rle_col_ACF8: colores RLE: 21 tiles desde el 67 (lista 0x7074)
;   0xacf8..0xad5d  (101 bytes)
DATA_rle_col_ACF8:
	defb 004h,0e7h,003h,0e4h,004h,0e5h,081h,075h,004h,054h,004h,0e7h,086h,0e4h,041h,041h	; acf8  .......u.T....AA
	defb 051h,0e5h,0e5h,006h,0e1h,081h,054h,007h,075h,002h,051h,003h,041h,083h,0e1h,041h	; ad08  Q.....T.u.Q.A..A
	defb 041h,006h,0e1h,083h,0e7h,0e5h,075h,007h,051h,006h,041h,082h,071h,051h,008h,0e4h	; ad18  A.....u.Q.A.qQ..
	defb 008h,051h,008h,041h,007h,0e4h,082h,0e5h,051h,007h,0e1h,007h,041h,081h,051h,009h	; ad28  .Q.A....Q...A.Q.
	defb 0e1h,085h,041h,0e1h,0e1h,041h,051h,004h,0e1h,002h,041h,081h,0e1h,003h,041h,089h	; ad38  ..A..AQ...A...A.
	defb 01eh,014h,0e4h,0e4h,0e1h,0e4h,0e5h,0e5h,011h,003h,054h,084h,011h,044h,0f7h,011h	; ad48  ..........T..D..
	defb 006h,041h,002h,051h,000h	; ad58

; ----------------------------------------------------------------------
; DATOS rle_col_AD5D: colores RLE: 21 tiles desde el 109 (lista 0x7074)
;   0xad5d..0xadc2  (101 bytes)
DATA_rle_col_AD5D:
	defb 004h,0efh,003h,0e5h,004h,0e7h,081h,0f7h,004h,075h,004h,0efh,086h,0e5h,051h,051h	; ad5d  .........u....QQ
	defb 071h,0e7h,0e7h,006h,0e1h,081h,075h,007h,0f7h,002h,071h,003h,041h,083h,0e1h,041h	; ad6d  q.....u...q.A..A
	defb 041h,006h,0e1h,083h,0efh,0e7h,0f7h,007h,071h,006h,041h,082h,0f1h,071h,008h,0e5h	; ad7d  A.......q.A..q..
	defb 008h,071h,008h,051h,007h,0e5h,082h,0e7h,071h,007h,0e1h,007h,051h,081h,071h,009h	; ad8d  .q.Q....q...Q.q.
	defb 0e1h,085h,051h,0e1h,0e1h,041h,051h,004h,0e1h,002h,041h,081h,0e1h,003h,041h,089h	; ad9d  ..Q..AQ...A...A.
	defb 01eh,015h,0e5h,0e5h,0e1h,0e5h,0e7h,0e7h,011h,003h,075h,084h,011h,055h,0ffh,011h	; adad  ..........u..U..
	defb 006h,051h,002h,071h,000h	; adbd

; ----------------------------------------------------------------------
; DATOS rle_col_ADC2: colores RLE: 21 tiles desde el 88 (lista 0x7074)
;   0xadc2..0xae27  (101 bytes)
DATA_rle_col_ADC2:
	defb 004h,0e9h,003h,0e6h,004h,0e8h,081h,098h,004h,086h,004h,0e9h,086h,0e6h,061h,061h	; adc2  ..............aa
	defb 081h,0e8h,0e8h,006h,0e1h,081h,086h,007h,098h,002h,081h,003h,041h,083h,0e1h,041h	; add2  ............A..A
	defb 041h,006h,0e1h,083h,0e9h,0e8h,098h,007h,081h,006h,041h,082h,091h,081h,008h,0e6h	; ade2  A.........A.....
	defb 008h,081h,008h,061h,007h,0e6h,082h,0e8h,081h,007h,0e1h,007h,061h,081h,081h,009h	; adf2  ...a........a...
	defb 0e1h,085h,061h,0e1h,0e1h,041h,051h,004h,0e1h,002h,041h,081h,0e1h,003h,041h,089h	; ae02  ..a..AQ...A...A.
	defb 01eh,016h,0e6h,0e6h,0e1h,0e6h,0e8h,0e8h,011h,003h,086h,084h,011h,066h,0a9h,011h	; ae12  .............f..
	defb 006h,061h,002h,081h,000h	; ae22

; ----------------------------------------------------------------------
; DATOS rle_col_AE27: colores RLE: 21 tiles desde el 67 (lista 0x708d)
;   0xae27..0xae8c  (101 bytes)
DATA_rle_col_AE27:
	defb 002h,0e1h,002h,0e8h,093h,0e1h,0e6h,0e8h,0e1h,0e8h,081h,086h,086h,081h,086h,088h	; ae27  ................
	defb 081h,01eh,01eh,08eh,081h,011h,061h,081h,009h,0e1h,005h,086h,003h,098h,003h,041h	; ae37  ......a........A
	defb 081h,0e1h,004h,041h,005h,0e1h,085h,0e9h,0e8h,0e6h,098h,098h,006h,081h,005h,011h	; ae47  ...A............
	defb 083h,091h,081h,061h,008h,0e6h,005h,081h,003h,098h,008h,061h,008h,0e6h,007h,098h	; ae57  ...a.......a....
	defb 081h,086h,008h,061h,003h,0e6h,005h,0e1h,005h,086h,007h,061h,003h,041h,002h,0e1h	; ae67  ...a.......a.A..
	defb 003h,061h,081h,0e1h,003h,0e6h,081h,011h,003h,086h,085h,011h,066h,0a9h,011h,041h	; ae77  .a..........f..A
	defb 004h,081h,003h,061h,000h	; ae87

; ----------------------------------------------------------------------
; DATOS rle_col_AE8C: colores RLE: 21 tiles desde el 88 (lista 0x708d)
;   0xae8c..0xaeef  (99 bytes)
DATA_rle_col_AE8C:
	defb 002h,0e1h,002h,0e5h,093h,0e1h,0e4h,0e5h,0e1h,0e5h,051h,054h,054h,051h,054h,055h	; ae8c  ..........QTTQTU
	defb 051h,01eh,01eh,05eh,051h,011h,041h,051h,009h,0e1h,005h,054h,003h,075h,003h,041h	; ae9c  Q..^Q.AQ...T.u.A
	defb 081h,0e1h,004h,041h,005h,0e1h,085h,0e7h,0e5h,0e4h,075h,075h,006h,051h,005h,011h	; aeac  ...A......uu.Q..
	defb 083h,071h,051h,041h,008h,0e4h,005h,051h,003h,075h,008h,041h,008h,0e4h,007h,075h	; aebc  .qQA...Q.u.A...u
	defb 081h,054h,008h,041h,003h,0e4h,005h,0e1h,005h,054h,00ah,041h,002h,0e1h,003h,041h	; aecc  .T.A.....T.A...A
	defb 081h,0e1h,003h,0e4h,081h,011h,003h,054h,085h,011h,044h,0f7h,011h,041h,004h,051h	; aedc  .......T..D..A.Q
	defb 003h,041h,000h	; aeec

; ----------------------------------------------------------------------
; DATOS rle_col_AEEF: colores RLE: 21 tiles desde el 109 (lista 0x708d)
;   0xaeef..0xaf54  (101 bytes)
DATA_rle_col_AEEF:
	defb 002h,0e1h,002h,0ebh,093h,0e1h,0eah,0ebh,0e1h,0ebh,0b1h,0bah,0bah,0b1h,0bah,0bbh	; aeef  ................
	defb 0b1h,01eh,01eh,0beh,0b1h,011h,0a1h,0b1h,009h,0e1h,005h,0bah,003h,0fbh,003h,041h	; aeff  ...............A
	defb 081h,0e1h,004h,041h,005h,0e1h,085h,0efh,0ebh,0eah,0fbh,0fbh,006h,0b1h,005h,011h	; af0f  ...A............
	defb 083h,0f1h,0b1h,0a1h,008h,0eah,005h,0b1h,003h,0fbh,008h,0a1h,008h,0eah,007h,0fbh	; af1f  ................
	defb 081h,0bah,008h,0a1h,003h,0eah,005h,0e1h,005h,0bah,007h,0a1h,003h,041h,002h,0e1h	; af2f  .............A..
	defb 003h,0a1h,081h,0e1h,003h,0eah,081h,011h,003h,0bah,085h,011h,0aah,0ffh,011h,041h	; af3f  ...............A
	defb 004h,0b1h,003h,0a1h,000h	; af4f

; ----------------------------------------------------------------------
; DATOS rle_col_AF54: colores RLE: 7 tiles desde el 130 (lista 0x708d)
;   0xaf54..0xaf57  (3 bytes)
DATA_rle_col_AF54:
	defb 038h,0e1h,000h	; af54

; ----------------------------------------------------------------------
; DATOS plantilla_AF57: plantilla de 7 filas x 4 tiles que copia p01 0x70E6
;   (tiles + 21*c; los >= 0x82 tal cual)
;   0xaf57..0xaf73  (28 bytes)
DATA_plantilla_AF57:
	defb 043h,044h,045h,082h	; af57
	defb 046h,047h,048h,083h	; af5b
	defb 049h,04ah,04bh,084h	; af5f
	defb 04ch,04dh,04eh,085h	; af63
	defb 04fh,050h,051h,086h	; af67
	defb 052h,053h,054h,087h	; af6b
	defb 055h,056h,057h,088h	; af6f

; ----------------------------------------------------------------------
; DATOS plantillas_AF73: dos plantillas mas de la misma forma (7 x 4, tiles
;   0x58-0x81 seguidos y 0x82-0x88 en la cuarta columna); quien las lee, por
;   ver
;   0xaf73..0xafab  (56 bytes)
DATA_plantillas_AF73:
	defb 058h,059h,05ah,082h	; af73
	defb 05bh,05ch,05dh,083h	; af77
	defb 05eh,05fh,060h,084h	; af7b
	defb 061h,062h,063h,085h	; af7f
	defb 064h,065h,066h,086h	; af83
	defb 067h,068h,069h,087h	; af87
	defb 06ah,06bh,06ch,088h	; af8b
	defb 06dh,06eh,06fh,082h	; af8f
	defb 070h,071h,072h,083h	; af93
	defb 073h,074h,075h,084h	; af97
	defb 076h,077h,078h,085h	; af9b
	defb 079h,07ah,07bh,086h	; af9f
	defb 07ch,07dh,07eh,087h	; afa3
	defb 07fh,080h,081h,088h	; afa7

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (318 bytes)
;   0xafab..0xb0e9  (318 bytes)
DATA_pendiente_de_trazar:
	defb 0b4h,0ffh,08eh,001h,003h,027h,002h,02ch,08ah,001h,0e3h,003h,08ah,001h,0e3h,006h	; afab  .....'.,........
	defb 08ah,001h,0e3h,009h,08ah,001h,083h,002h,089h,001h,005h,028h,002h,00ch,002h,02dh	; afbb  ...........(...-
	defb 088h,001h,005h,028h,002h,00ch,002h,02dh,088h,001h,009h,028h,002h,00ch,002h,02dh	; afcb  ...(...-...(...-
	defb 001h,001h,012h,013h,084h,001h,009h,028h,002h,00ch,002h,02dh,001h,001h,014h,015h	; afdb  .......(...-....
	defb 084h,001h,009h,029h,02ah,002h,02fh,02eh,001h,001h,016h,017h,084h,001h,006h,02bh	; afeb  ...)*./........+
	defb 00dh,00eh,00dh,001h,001h,0e5h,018h,084h,001h,001h,00fh,083h,001h,0e5h,01dh,005h	; affb  ................
	defb 001h,001h,010h,010h,011h,083h,010h,0e5h,022h,002h,010h,024h,08dh,002h,0b4h,0ffh	; b00b  ........"..$....
	defb 000h,089h,0ffh,002h,031h,032h,084h,000h,002h,033h,031h,0e5h,034h,092h,0ffh,008h	; b01b  ....12...31.4...
	defb 031h,039h,000h,000h,082h,033h,031h,03ah,085h,000h,092h,0ffh,007h,031h,03bh,000h	; b02b  19...31:.....1;.
	defb 000h,033h,031h,03ah,086h,000h,092h,0ffh,006h,031h,03bh,000h,03ch,035h,03dh,084h	; b03b  .31:.....1;.<5=.
	defb 000h,003h,03eh,03fh,000h,092h,0ffh,003h,031h,040h,041h,0e3h,041h,007h,000h,000h	; b04b  ..>?....1@A.A...
	defb 044h,000h,045h,046h,000h,092h,0ffh,004h,031h,047h,048h,031h,0e5h,049h,004h,000h	; b05b  D.EF....1GH1.I..
	defb 04eh,04fh,000h,092h,0ffh,006h,031h,050h,031h,031h,052h,051h,0e3h,053h,004h,000h	; b06b  NO....1P11RQ.S..
	defb 04eh,04fh,000h,092h,0ffh,002h,031h,056h,083h,031h,0e5h,057h,003h,04eh,05ch,000h	; b07b  NO....1V.1.W.N\.
	defb 092h,0ffh,002h,031h,05dh,083h,031h,0e7h,05eh,001h,000h,092h,0ffh,004h,031h,065h	; b08b  ...1].1.^.....1e
	defb 031h,031h,0e7h,066h,002h,067h,000h,092h,0ffh,004h,031h,06dh,031h,031h,0e6h,06eh	; b09b  11.f.g....1m11.n
	defb 003h,000h,000h,082h,092h,0ffh,008h,031h,074h,031h,031h,075h,076h,000h,077h,083h	; b0ab  .......1t11uv.w.
	defb 000h,002h,078h,079h,092h,0ffh,001h,031h,0e4h,07ah,084h,000h,0e4h,07fh,092h,0ffh	; b0bb  ..xy...1.z......
	defb 003h,031h,083h,084h,084h,000h,0e3h,085h,003h,000h,088h,089h,092h,0ffh,003h,031h	; b0cb  .1.............1
	defb 031h,08ah,084h,000h,006h,08bh,031h,000h,000h,08ch,031h,089h,0ffh,000h	; b0db  1.....1...1...

; ----------------------------------------------------------------------
; DATOS rle_pat_B0E9: patrones RLE: 6 tiles desde el 35 (lista 0x64cf)
;   0xb0e9..0xb114  (43 bytes)
DATA_rle_pat_B0E9:
	defb 003h,0ffh,085h,080h,0f0h,0fch,001h,001h,003h,0ffh,085h,0feh,0f0h,0c0h,000h,000h	; b0e9  ................
	defb 008h,001h,08dh,003h,01fh,0ffh,000h,000h,0c0h,0f0h,0feh,001h,001h,0fch,0f0h,080h	; b0f9  ................
	defb 003h,0c0h,002h,000h,083h,0c0h,0f0h,0feh,003h,0ffh,000h	; b109  ...........

; ----------------------------------------------------------------------
; DATOS rle_pat_B114: patrones RLE: 6 tiles desde el 41 (lista 0x64cf)
;   0xb114..0xb13f  (43 bytes)
DATA_rle_pat_B114:
	defb 088h,000h,080h,0c0h,0e0h,0f0h,0f8h,0ffh,002h,006h,000h,003h,0ffh,091h,0feh,0fch	; b114  ................
	defb 0f8h,0f0h,0e0h,0c0h,03fh,0fch,0fch,0f8h,0f0h,0e0h,0c0h,080h,000h,0ffh,000h,006h	; b124  ....?...........
	defb 0ffh,002h,03fh,086h,0e0h,0f0h,0f8h,0fch,0feh,0ffh,000h	; b134  ..?........

; ----------------------------------------------------------------------
; DATOS rle_pat_B13F: patrones RLE: 4 tiles desde el 96 (lista 0x7415)
;   0xb13f..0xb161  (34 bytes)
DATA_rle_pat_B13F:
	defb 083h,07fh,080h,0beh,003h,0bfh,085h,09fh,033h,001h,0c7h,018h,003h,0e7h,089h,0c7h	; b13f  ........3.......
	defb 03fh,0feh,0c7h,0dch,0dfh,0dfh,0c2h,0d8h,003h,0feh,086h,04eh,038h,0c7h,047h,00eh	; b14f  ?..........N8.G.
	defb 07eh,000h	; b15f

; ----------------------------------------------------------------------
; DATOS rle_pat_B161: patrones RLE: 4 tiles desde el 112 (lista 0x6415)
;   0xb161..0xb171  (16 bytes)
DATA_rle_pat_B161:
	defb 082h,0ffh,07fh,005h,03fh,083h,07fh,0ffh,0ffh,00eh,03fh,005h,0ffh,003h,03fh,000h	; b161  ....?.....?...?.

; ----------------------------------------------------------------------
; DATOS rle_pat_B171: patrones RLE: 12 tiles desde el 162 (lista 0x6415)
;   0xb171..0xb1b4  (67 bytes)
DATA_rle_pat_B171:
	defb 004h,000h,004h,001h,004h,0e0h,004h,0c0h,004h,00eh,004h,01ch,002h,007h,002h,00eh	; b171  ................
	defb 002h,01ch,002h,038h,002h,0e0h,002h,0c0h,002h,080h,004h,000h,002h,001h,002h,003h	; b181  ...8............
	defb 002h,007h,004h,0fch,004h,0f8h,004h,07fh,004h,0ffh,004h,0c7h,004h,08fh,002h,0f1h	; b191  ................
	defb 002h,0e3h,002h,0c7h,004h,08fh,002h,01fh,002h,03fh,002h,07fh,004h,0ffh,002h,0feh	; b1a1  .........?......
	defb 002h,0fch,000h	; b1b1

; ----------------------------------------------------------------------
; DATOS rle_pat_B1B4: patrones RLE: 5 tiles desde el 186 (lista 0x6415)
;   0xb1b4..0xb1d1  (29 bytes)
DATA_rle_pat_B1B4:
	defb 004h,0e7h,004h,0f3h,004h,09fh,004h,0cfh,002h,0e7h,002h,0f3h,002h,0f9h,002h,0fch	; b1b4  ................
	defb 002h,0feh,006h,0ffh,002h,07fh,002h,03fh,002h,09fh,002h,0cfh,000h	; b1c4  .......?.....

; ----------------------------------------------------------------------
; DATOS rle_col_B1D1: colores RLE: 6 tiles desde el 35 (lista 0x64cf)
;   0xb1d1..0xb1ec  (27 bytes)
DATA_rle_col_B1D1:
	defb 003h,0cch,003h,075h,002h,0e7h,003h,0c7h,005h,054h,008h,0e7h,004h,054h,004h,041h	; b1d1  ...u.....T...T.A
	defb 002h,0e7h,003h,075h,003h,0c1h,005h,054h,003h,010h,000h	; b1e1  ...u...T...

; ----------------------------------------------------------------------
; DATOS rle_col_B1EC: colores RLE: 6 tiles desde el 41 (lista 0x64cf)
;   0xb1ec..0xb203  (23 bytes)
DATA_rle_col_B1EC:
	defb 007h,098h,081h,0f9h,008h,098h,007h,086h,083h,061h,096h,091h,006h,098h,081h,061h	; b1ec  .........a.....a
	defb 007h,081h,002h,061h,006h,086h,000h	; b1fc

; ----------------------------------------------------------------------
; DATOS rle_col_B203: colores RLE: 4 tiles desde el 96 (lista 0x7415)
;   0xb203..0xb223  (32 bytes)
DATA_rle_col_B203:
	defb 081h,0fah,003h,0b1h,003h,0a1h,084h,096h,0fbh,0a1h,0fah,004h,0a1h,081h,091h,003h	; b203  ................
	defb 0f1h,08dh,091h,081h,061h,0f1h,0f1h,0fch,0e1h,061h,0e8h,081h,081h,091h,0f1h,000h	; b213  ....a....a......

; ----------------------------------------------------------------------
; DATOS rle_col_B223: colores RLE: 4 tiles desde el 112 (lista 0x6415)
;   0xb223..0xb226  (3 bytes)
DATA_rle_col_B223:
	defb 020h,0c1h,000h	; b223

; ----------------------------------------------------------------------
; DATOS rle_col_B226: colores RLE: 12 tiles desde el 162 (lista 0x6415)
;   0xb226..0xb22b  (5 bytes)
DATA_rle_col_B226:
	defb 030h,0feh,030h,0e6h,000h	; b226

; ----------------------------------------------------------------------
; DATOS rle_col_B22B: colores RLE: 5 tiles desde el 186 (lista 0x6415)
;   0xb22b..0xb22e  (3 bytes)
DATA_rle_col_B22B:
	defb 028h,0ebh,000h	; b22b

; ----------------------------------------------------------------------
; DATOS minimapa_00: camino del minimapa de la carrera 0 (RALLY): 81 pasos,
;   cada byte dos nibbles con signo (0x784E: el ALTO a la x del marcador, el
;   BAJO a la y) que p01 0x7827 va sumando desde (x=157, y=36); los deltas
;   suman cero en los dos ejes, o sea el trazado cierra
;   0xb22e..0xb27f  (81 bytes)
DATA_minimapa_00:
	defb 00eh,00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh	; b22e  ................
	defb 00fh,00fh,010h,03eh,02dh,03ch,04dh,050h,042h,032h,050h,021h,044h,020h,030h,020h	; b23e  ...>-<MPB2P!D 0 
	defb 03dh,05eh,051h,023h,031h,03fh,03eh,021h,021h,020h,020h,021h,024h,0a6h,0f5h,005h	; b24e  =^Q#1?>!!  !$...
	defb 043h,034h,002h,0e3h,092h,0cdh,0d0h,0deh,0e1h,0e1h,0e0h,0e0h,0d3h,0c1h,0b0h,0cfh	; b25e  C4..............
	defb 0deh,0e0h,0e0h,0efh,0cch,0c0h,0c1h,0a7h,0e0h,0efh,0bbh,00eh,00fh,00eh,00fh,00fh	; b26e  ................
	defb 000h	; b27e

; ----------------------------------------------------------------------
; DATOS minimapa_01: camino del minimapa de la carrera 1 (STOCK): 65 pasos,
;   cada byte dos nibbles con signo (0x784E: el ALTO a la x del marcador, el
;   BAJO a la y) que p01 0x7827 va sumando desde (x=193, y=24); los deltas
;   suman cero en los dos ejes, o sea el trazado cierra
;   0xb27f..0xb2c0  (65 bytes)
DATA_minimapa_01:
	defb 020h,020h,020h,020h,010h,010h,020h,010h,010h,020h,010h,010h,010h,010h,010h,010h	; b27f      .. .. ......
	defb 010h,010h,010h,06dh,05dh,04eh,063h,0f5h,0c1h,0a2h,0c2h,0e3h,0c1h,0deh,0dfh,0c3h	; b28f  ...m]Nc.........
	defb 0d2h,0ceh,0efh,0e0h,0e0h,0f0h,0f0h,0e1h,0e1h,0e1h,0e1h,0cfh,0ddh,0fdh,0deh,0dfh	; b29f  ................
	defb 0deh,0ceh,0beh,0fah,050h,056h,060h,031h,021h,021h,021h,020h,020h,020h,020h,020h	; b2af  ....PV`1!!!     
	defb 000h	; b2bf

; ----------------------------------------------------------------------
; DATOS minimapa_02: camino del minimapa de la carrera 2 (ENDURANCE): 81
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=181, y=8);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb2c0..0xb311  (81 bytes)
DATA_minimapa_02:
	defb 030h,030h,020h,010h,020h,020h,020h,010h,010h,020h,020h,020h,010h,020h,020h,020h	; b2c0  00 .   ..   .   
	defb 010h,010h,010h,020h,010h,052h,053h,040h,040h,031h,022h,023h,0f4h,0e2h,0e1h,0f1h	; b2d0  ... .RS@@1"#....
	defb 0e2h,0e2h,0e2h,0e2h,0f3h,002h,0f0h,0e0h,0f0h,0f0h,0f0h,0f0h,0f0h,0e0h,0f0h,0e0h	; b2e0  ................
	defb 0e0h,0e0h,0ffh,0f0h,0ffh,0d1h,0e1h,0efh,0efh,0ceh,0ddh,0ffh,0d0h,0c2h,0d2h,0ceh	; b2f0  ................
	defb 0eeh,0ddh,00eh,00eh,00dh,0bbh,0ddh,01dh,02eh,02fh,020h,020h,020h,020h,030h,020h	; b300  ........./    0 
	defb 000h	; b310

; ----------------------------------------------------------------------
; DATOS minimapa_03: camino del minimapa de la carrera 3 (F3): 71 pasos, cada
;   byte dos nibbles con signo (0x784E: el ALTO a la x del marcador, el BAJO a
;   la y) que p01 0x7827 va sumando desde (x=183, y=8); los deltas suman cero
;   en los dos ejes, o sea el trazado cierra
;   0xb311..0xb358  (71 bytes)
DATA_minimapa_03:
	defb 020h,010h,020h,010h,020h,010h,020h,010h,020h,010h,020h,010h,020h,010h,020h,010h	; b311   . . . . . . . .
	defb 020h,010h,021h,021h,012h,011h,002h,001h,001h,002h,002h,043h,033h,0e7h,093h,0b5h	; b321   .!!.......C3...
	defb 0d4h,0c3h,0c0h,0b0h,0efh,0efh,0efh,0dfh,0c0h,0c0h,0c1h,0d2h,0b1h,0d9h,07ah,009h	; b331  ..............z.
	defb 0dch,0cdh,0fdh,00eh,00dh,01dh,01eh,010h,01fh,010h,020h,010h,020h,010h,020h,010h	; b341  .......... . . .
	defb 020h,010h,020h,010h,020h,010h,000h	; b351

; ----------------------------------------------------------------------
; DATOS minimapa_04: camino del minimapa de la carrera 4 (F3000): 81 pasos,
;   cada byte dos nibbles con signo (0x784E: el ALTO a la x del marcador, el
;   BAJO a la y) que p01 0x7827 va sumando desde (x=205, y=29); los deltas
;   suman cero en los dos ejes, o sea el trazado cierra
;   0xb358..0xb3a9  (81 bytes)
DATA_minimapa_04:
	defb 010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h	; b358  ................
	defb 010h,010h,034h,053h,07ah,0aah,0feh,00eh,03dh,02fh,02dh,0fdh,0dch,0dfh,0b2h,0c1h	; b368  ..4Sz...=/-.....
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0d0h,0d0h,0b2h,0d2h,0bch,0ddh,090h,0b1h	; b378  ................
	defb 0d4h,0d3h,0c2h,0e3h,0f3h,034h,032h,023h,004h,0d5h,0b4h,037h,071h,07eh,04fh,02dh	; b388  .....42#...7q~O-
	defb 050h,04eh,0f9h,09ah,07ah,074h,021h,000h,010h,010h,000h,010h,010h,000h,010h,010h	; b398  PN..zt!.........
	defb 000h	; b3a8

; ----------------------------------------------------------------------
; DATOS minimapa_05: camino del minimapa de la carrera 5 (F1 ROUND 1): 81
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=173, y=16);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb3a9..0xb3fa  (81 bytes)
DATA_minimapa_05:
	defb 010h,010h,020h,020h,020h,020h,020h,020h,020h,010h,020h,010h,020h,020h,020h,010h	; b3a9  ..       . .   .
	defb 03eh,02fh,051h,033h,017h,0e7h,0c4h,096h,0e2h,014h,044h,050h,04ch,04ch,04eh,02dh	; b3b9  >/Q3......DPLLN-
	defb 00bh,00bh,04ah,05eh,05bh,0fah,0cfh,090h,090h,090h,090h,090h,090h,090h,0a0h,0a0h	; b3c9  ..J^[...........
	defb 0a0h,0a0h,093h,0f7h,007h,017h,077h,004h,033h,032h,041h,04dh,02eh,00dh,00ch,079h	; b3d9  ......w.32AM...y
	defb 0aah,0b1h,0c0h,0c0h,0ddh,00ch,03eh,020h,010h,010h,010h,010h,010h,010h,010h,010h	; b3e9  ......> ........
	defb 000h	; b3f9

; ----------------------------------------------------------------------
; DATOS minimapa_06: camino del minimapa de la carrera 6 (F1 ROUND 2): 69
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=181, y=41);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb3fa..0xb43f  (69 bytes)
DATA_minimapa_06:
	defb 010h,010h,020h,010h,020h,010h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h	; b3fa  .. . .          
	defb 05ch,009h,02dh,02eh,03dh,05bh,04ch,0ebh,0bdh,096h,0b1h,0b0h,0adh,0cfh,0c2h,016h	; b40a  \.-.=[L.........
	defb 032h,024h,003h,003h,0f3h,0e1h,0e1h,0dfh,0c0h,0d0h,0dfh,0efh,0e1h,0c1h,0b0h,0beh	; b41a  2$..............
	defb 0bfh,0c3h,0f7h,052h,030h,030h,020h,020h,011h,021h,02fh,02fh,010h,000h,010h,010h	; b42a  ...R00  .!//....
	defb 010h,010h,010h,010h,000h	; b43a

; ----------------------------------------------------------------------
; DATOS minimapa_07: camino del minimapa de la carrera 7 (F1 ROUND 3): 71
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=173, y=40);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb43f..0xb486  (71 bytes)
DATA_minimapa_07:
	defb 0e0h,0f0h,0e0h,0d0h,0e0h,0d1h,093h,0beh,0eah,04ch,020h,010h,020h,01fh,02fh,02fh	; b43f  .........L . .//
	defb 02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh	; b44f  ////////////////
	defb 02fh,02fh,02fh,02fh,010h,042h,05dh,03eh,031h,031h,060h,061h,024h,0c4h,0d0h,0e0h	; b45f  ////.B]>11`a$...
	defb 0c2h,09fh,09eh,0d7h,075h,06dh,070h,007h,0b5h,054h,007h,0c1h,0a0h,0d0h,0efh,0efh	; b46f  ....ump..T......
	defb 0efh,0adh,09dh,094h,090h,0cch,000h	; b47f

; ----------------------------------------------------------------------
; DATOS minimapa_08: camino del minimapa de la carrera 8 (F1 ROUND 4): 63
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=169, y=10);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb486..0xb4c5  (63 bytes)
DATA_minimapa_08:
	defb 02fh,02fh,02fh,02fh,02fh,02fh,02fh,041h,034h,022h,011h,010h,011h,021h,010h,021h	; b486  ///////A4"...!.!
	defb 011h,010h,011h,021h,010h,021h,022h,035h,031h,05eh,05ah,050h,034h,0d5h,007h,052h	; b496  ...!.!"51^ZP4..R
	defb 045h,0d5h,0d1h,0d0h,0cfh,0dch,0eeh,0ddh,0ddh,0ddh,0ddh,0deh,0deh,0dfh,0bfh,0cch	; b4a6  E...............
	defb 0dbh,0beh,0a4h,0f6h,093h,0a1h,090h,0cbh,04ah,030h,03fh,02fh,02fh,02fh,000h	; b4b6  ........J0?///.

; ----------------------------------------------------------------------
; DATOS minimapa_09: camino del minimapa de la carrera 9 (F1 ROUND 5): 69
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=209, y=45);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb4c5..0xb50a  (69 bytes)
DATA_minimapa_09:
	defb 010h,010h,010h,000h,010h,010h,000h,010h,010h,000h,010h,010h,010h,010h,010h,010h	; b4c5  ................
	defb 010h,010h,032h,052h,05dh,00ch,0ceh,0a0h,0c0h,0e1h,0bdh,0f9h,049h,051h,05eh,01ch	; b4d5  ..2R].......IQ^.
	defb 0ddh,0deh,0ddh,0ddh,0c0h,0b1h,0c4h,0b3h,0c0h,0c0h,0d0h,0b3h,096h,0dfh,0e0h,0e0h	; b4e5  ................
	defb 0c0h,0ceh,092h,024h,022h,014h,0b6h,063h,07dh,070h,070h,070h,071h,023h,031h,020h	; b4f5  ...$"..c}pppq#1 
	defb 010h,020h,010h,020h,000h	; b505

; ----------------------------------------------------------------------
; DATOS minimapa_10: camino del minimapa de la carrera 10 (F1 ROUND 6): 61
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=173, y=41);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb50a..0xb547  (61 bytes)
DATA_minimapa_10:
	defb 0ffh,0f0h,0efh,0efh,0efh,0efh,0efh,0efh,0efh,0efh,0efh,0efh,0efh,0efh,00eh,01eh	; b50a  ................
	defb 0fbh,02dh,04fh,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,030h,030h,030h	; b51a  .-O          000
	defb 030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,06dh,063h,025h,007h,0b5h,0ceh	; b52a  0000000000mc%...
	defb 0dfh,0c3h,0d1h,093h,090h,0d4h,0b3h,0b0h,0d0h,0ffh,0f0h,0efh,000h	; b53a  .............

; ----------------------------------------------------------------------
; DATOS minimapa_11: camino del minimapa de la carrera 11 (F1 ROUND 7): 65
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=164, y=44);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb547..0xb588  (65 bytes)
DATA_minimapa_11:
	defb 00fh,0ffh,0eeh,0ffh,0eeh,0ffh,0eeh,0ffh,0eeh,0f0h,0dch,03ch,03fh,020h,02fh,02fh	; b547  ...........<? //
	defb 02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,02fh,03dh,03dh,02fh,033h,033h,043h	; b557  //////////==/33C
	defb 042h,042h,042h,042h,042h,061h,033h,0e3h,0d3h,0e2h,0d3h,0d3h,0d3h,0c2h,0d1h,0d0h	; b567  BBBBBa3.........
	defb 0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0c2h,0d2h,0ffh,0efh,0ffh,0ffh,00fh,0ffh	; b577  ................
	defb 000h	; b587

; ----------------------------------------------------------------------
; DATOS minimapa_12: camino del minimapa de la carrera 12 (F1 ROUND 8): 73
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=149, y=29);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb588..0xb5d1  (73 bytes)
DATA_minimapa_12:
	defb 0fah,00bh,00dh,00dh,00dh,00dh,00ch,01eh,02eh,02fh,020h,030h,020h,030h,030h,030h	; b588  ........./ 0 000
	defb 030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h	; b598  0000000000000000
	defb 030h,030h,032h,012h,022h,022h,033h,012h,0e2h,0c3h,0f4h,043h,025h,0c3h,0cfh,0b0h	; b5a8  002.""3....C%...
	defb 0a3h,0b1h,0bdh,0d0h,0e0h,0f0h,0d0h,0d0h,0efh,0eeh,0ddh,0cch,0bbh,0dch,0b0h,005h	; b5b8  ................
	defb 027h,0d6h,0b1h,0a3h,0d0h,0efh,0efh,0feh,000h	; b5c8  '........

; ----------------------------------------------------------------------
; DATOS minimapa_13: camino del minimapa de la carrera 13 (F1 ROUND 9): 73
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=197, y=49);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb5d1..0xb61a  (73 bytes)
DATA_minimapa_13:
	defb 0e0h,0e0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h	; b5d1  ................
	defb 0e0h,0f0h,0a2h,09fh,0dbh,02ch,04fh,060h,062h,072h,06ah,0dbh,0a0h,0beh,0ech,0cdh	; b5e1  .....,O`brj.....
	defb 0eeh,0eeh,0eeh,0efh,0ddh,01ch,02dh,03eh,041h,042h,020h,020h,042h,032h,050h,05dh	; b5f1  ......->AB  B2P]
	defb 02dh,04fh,033h,023h,022h,042h,041h,062h,013h,005h,0f5h,0d2h,091h,094h,074h,07eh	; b601  -O3#"BAb......t~
	defb 037h,0b2h,0d0h,0e0h,0e0h,0e0h,0e0h,0e0h,000h	; b611  7........

; ----------------------------------------------------------------------
; DATOS minimapa_14: camino del minimapa de la carrera 14 (F1 ROUND 10): 73
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=205, y=44);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb61a..0xb663  (73 bytes)
DATA_minimapa_14:
	defb 0f0h,0f0h,0f0h,000h,0f0h,0f0h,000h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; b61a  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0ebh,0ceh,0ceh,0a9h,0bah,09ch,09fh,0cah,04bh,03fh,041h	; b62a  .............K?A
	defb 042h,040h,040h,040h,060h,050h,050h,050h,050h,040h,05dh,062h,034h,0f4h,0c2h,0cfh	; b63a  B@@@`PPPP@]b4...
	defb 0d0h,0d0h,09dh,093h,0f7h,072h,073h,074h,050h,050h,041h,033h,0f4h,0d3h,0d1h,0e0h	; b64a  .....rstPPA3....
	defb 0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,000h	; b65a  .........

; ----------------------------------------------------------------------
; DATOS minimapa_15: camino del minimapa de la carrera 15 (F1 ROUND 11): 65
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=213, y=37);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb663..0xb6a4  (65 bytes)
DATA_minimapa_15:
	defb 0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h	; b663  ................
	defb 0e0h,0f0h,0d3h,0d1h,0cfh,0c1h,0b5h,0c2h,0b1h,0deh,0ech,00bh,009h,01ch,01dh,0b9h	; b673  ................
	defb 0d9h,06bh,070h,041h,032h,024h,044h,044h,033h,033h,042h,05dh,041h,042h,041h,020h	; b683  .kpA2$DD33B]ABA 
	defb 030h,030h,030h,020h,05dh,05eh,053h,005h,0d3h,0c2h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; b693  000 ]^S.........
	defb 000h	; b6a3

; ----------------------------------------------------------------------
; DATOS minimapa_16: camino del minimapa de la carrera 16 (F1 ROUND 12): 73
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=197, y=52);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb6a4..0xb6ed  (73 bytes)
DATA_minimapa_16:
	defb 0c0h,0d0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; b6a4  ................
	defb 0e0h,0e0h,0dfh,0dfh,0fdh,0fah,009h,0d9h,0fdh,02dh,041h,031h,043h,07eh,062h,0e6h	; b6b4  .........-A1C~b.
	defb 0b5h,0d3h,024h,05fh,03eh,03fh,040h,040h,040h,041h,032h,040h,01dh,0ech,099h,0deh	; b6c4  ..$_>?@@@A2@....
	defb 0bah,03ah,07fh,042h,020h,020h,021h,022h,022h,044h,034h,006h,032h,050h,063h,025h	; b6d4  .:.B  !""D4.2Pc%
	defb 0d5h,0b2h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,000h	; b6e4  .........

; ----------------------------------------------------------------------
; DATOS minimapa_17: camino del minimapa de la carrera 17 (F1 ROUND 13): 75
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=189, y=16);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb6ed..0xb738  (75 bytes)
DATA_minimapa_17:
	defb 0f0h,0f0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; b6ed  ................
	defb 0e0h,0e0h,0d1h,0ceh,0fdh,03bh,06eh,033h,044h,060h,060h,06eh,01eh,02eh,05fh,060h	; b6fd  .....;n3D``n.._`
	defb 032h,023h,076h,034h,033h,033h,034h,014h,0c1h,0edh,0bdh,090h,090h,0b2h,0d4h,0f3h	; b70d  2#v4334.........
	defb 006h,0f3h,0c2h,0a0h,0ddh,0ddh,0aah,009h,039h,05eh,021h,031h,031h,010h,010h,000h	; b71d  ........9^!11...
	defb 010h,010h,010h,000h,010h,010h,050h,02bh,0ddh,0f0h,000h	; b72d  ......P+...

; ----------------------------------------------------------------------
; DATOS minimapa_18: camino del minimapa de la carrera 18 (F1 ROUND 14): 65
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=209, y=30);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb738..0xb779  (65 bytes)
DATA_minimapa_18:
	defb 092h,093h,0e1h,0e1h,0f1h,0e1h,0e1h,0f0h,0e1h,0e1h,0f1h,0e1h,0f0h,0e1h,0f1h,0f0h	; b738  ................
	defb 0f1h,0f0h,0f1h,0f0h,0f1h,0f0h,0e1h,0f1h,0f0h,0e1h,0f1h,0f0h,09fh,009h,0ech,00dh	; b748  ................
	defb 00ch,00ch,00ch,0bah,0cdh,0fah,050h,062h,06dh,033h,033h,032h,0e3h,0d2h,0f4h,053h	; b758  ......Pbm332...S
	defb 05dh,052h,07dh,07ch,041h,031h,031h,02fh,02fh,02fh,02fh,020h,031h,023h,0e4h,0d1h	; b768  ]R}|A11//// 1#..
	defb 000h	; b778

; ----------------------------------------------------------------------
; DATOS minimapa_19: camino del minimapa de la carrera 19 (F1 ROUND 15): 75
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=173, y=41);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb779..0xb7c4  (75 bytes)
DATA_minimapa_19:
	defb 0f0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; b779  ................
	defb 0f0h,0f0h,0cbh,04ch,020h,020h,02fh,030h,021h,031h,05ch,05bh,051h,05eh,02ch,00ch	; b789  ...L  /0!1\[Q^,.
	defb 00ch,06ah,051h,056h,007h,007h,007h,007h,063h,029h,009h,059h,050h,034h,051h,05ah	; b799  .jQV....c).YP4QZ
	defb 0dah,0adh,0d0h,0d0h,0d0h,0e0h,0c0h,090h,0f0h,0f1h,0e1h,0d3h,0f3h,005h,0d5h,005h	; b7a9  ................
	defb 014h,0d4h,0a0h,0beh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,000h	; b7b9  ...........

; ----------------------------------------------------------------------
; DATOS minimapa_20: camino del minimapa de la carrera 20 (F1 ROUND 16): 65
;   pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del
;   marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=161, y=16);
;   los deltas suman cero en los dos ejes, o sea el trazado cierra
;   0xb7c4..0xb805  (65 bytes)
DATA_minimapa_20:
	defb 010h,010h,020h,020h,020h,040h,04fh,02fh,021h,031h,03eh,03fh,03dh,02eh,03dh,043h	; b7c4  ..   @O/!1>?=.=C
	defb 022h,032h,07dh,060h,034h,033h,021h,020h,02fh,052h,014h,0e2h,0d2h,0e2h,0e2h,0e2h	; b7d4  "2}`43! /R......
	defb 0e2h,0e2h,0d3h,0e2h,0e2h,0d1h,0b0h,0c0h,0b0h,0c0h,0b0h,0c0h,0b0h,0c0h,0b0h,0c0h	; b7e4  ................
	defb 0b0h,0c0h,0dfh,00bh,07ch,03bh,0bbh,090h,0ebh,03dh,010h,010h,010h,010h,010h,010h	; b7f4  ....|;...=......
	defb 000h	; b804

; ----------------------------------------------------------------------
; DATOS pantalla_B805: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[0]
;   0xb805..0xb841  (60 bytes)
DATA_pantalla_B805:
	defb 008h,000h,000h,0e2h,0e7h,0dch,000h,000h,0dch,084h,000h,001h,0efh,083h,000h,00bh	; b805  ................
	defb 0ech,0f1h,000h,0ech,0f6h,0e7h,000h,0deh,000h,0fch,0fdh,085h,000h,004h,0f0h,000h	; b815  ................
	defb 0deh,000h,0e3h,0feh,084h,000h,005h,0deh,000h,0deh,000h,0dch,086h,000h,00ch,0e6h	; b825  ................
	defb 000h,0eah,0efh,000h,0ech,0e8h,0dch,0e2h,0f6h,0e7h,0efh,000h	; b835  ............

; ----------------------------------------------------------------------
; DATOS pantalla_B841: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[2]
;   0xb841..0xb872  (49 bytes)
DATA_pantalla_B841:
	defb 002h,000h,0e2h,086h,0dbh,001h,0e8h,083h,000h,001h,0ebh,087h,000h,005h,0dah,0e5h	; b841  ................
	defb 000h,000h,0deh,087h,000h,006h,0f0h,000h,000h,0f4h,0e3h,0e7h,084h,000h,004h,0f5h	; b851  ................
	defb 000h,0fch,0fdh,083h,000h,006h,0edh,0f6h,0dbh,0dbh,0f7h,000h,0e3h,0feh,088h,000h	; b861  ................
	defb 000h	; b871

; ----------------------------------------------------------------------
; DATOS pantalla_B872: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[3]
;   0xb872..0xb8a8  (54 bytes)
DATA_pantalla_B872:
	defb 002h,000h,0e2h,085h,0dbh,001h,0e7h,084h,000h,001h,0deh,086h,000h,001h,0deh,083h	; b872  ................
	defb 000h,001h,0e6h,086h,000h,001h,0e6h,084h,000h,001h,0deh,085h,000h,001h,0efh,083h	; b882  ................
	defb 000h,001h,0e1h,085h,000h,00fh,0e0h,000h,0fch,0fdh,000h,0ech,0f2h,0dah,0edh,0ddh	; b892  ................
	defb 0f1h,000h,000h,0feh,0ffh,000h	; b8a2

; ----------------------------------------------------------------------
; DATOS pantalla_B8A8: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[4]
;   0xb8a8..0xb8e5  (61 bytes)
DATA_pantalla_B8A8:
	defb 006h,000h,000h,0e4h,0dah,0e9h,0e3h,083h,0dbh,004h,0f2h,0e5h,000h,0e0h,088h,000h	; b8a8  ................
	defb 007h,0f0h,000h,0ebh,000h,000h,0e2h,0e8h,084h,000h,007h,0ebh,000h,000h,0deh,000h	; b8b8  ................
	defb 0ebh,000h,083h,0dah,004h,0eeh,0efh,000h,0e1h,083h,000h,001h,0deh,083h,000h,007h	; b8c8  ................
	defb 0fch,0fdh,000h,0eah,0e3h,0f1h,0dah,084h,000h,002h,0feh,0ffh,000h	; b8d8  .............

; ----------------------------------------------------------------------
; DATOS pantalla_B8E5: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[1]
;   0xb8e5..0xb90e  (41 bytes)
DATA_pantalla_B8E5:
	defb 08bh,000h,003h,0f9h,0e9h,0dch,086h,000h,006h,0e3h,0e7h,000h,0edh,0e8h,0edh,084h	; b8e5  ................
	defb 0dbh,003h,0f2h,0e3h,0f1h,083h,000h,006h,0eah,0e3h,0dbh,0f8h,0f6h,0f1h,08bh,000h	; b8f5  ................
	defb 002h,0fch,0fdh,089h,000h,002h,0feh,0ffh,000h	; b905  .........

; ----------------------------------------------------------------------
; DATOS pantalla_B90E: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[5]
;   0xb90e..0xb94a  (60 bytes)
DATA_pantalla_B90E:
	defb 001h,0e2h,089h,0dbh,003h,0e7h,0deh,0e2h,084h,0dbh,029h,0f2h,0e5h,000h,000h,0efh	; b90e  ..........).....
	defb 0deh,0ech,0ddh,0e7h,000h,0fch,0fdh,0dfh,000h,0e0h,000h,0eah,000h,000h,0f0h,000h	; b91e  ................
	defb 0feh,0ffh,0f5h,000h,0deh,000h,000h,0deh,000h,0deh,000h,000h,0e1h,000h,0e3h,0f7h	; b92e  ................
	defb 000h,000h,0edh,0f1h,083h,000h,002h,0eah,0efh,083h,000h,000h	; b93e  ............

; ----------------------------------------------------------------------
; DATOS pantalla_B94A: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[6]
;   0xb94a..0xb97d  (51 bytes)
DATA_pantalla_B94A:
	defb 00ah,000h,000h,0fch,0fdh,000h,0e2h,0e8h,0dch,0e4h,0e5h,083h,000h,0e3h,0feh,001h	; b94a  ................
	defb 0ebh,083h,000h,001h,0f0h,086h,000h,00eh,0dfh,000h,000h,0f5h,000h,000h,0e0h,0edh	; b95a  ................
	defb 0dbh,0f6h,0dbh,0f1h,000h,0dfh,083h,000h,003h,0ech,0ddh,0f8h,084h,0ddh,001h,0f1h	; b96a  ................
	defb 08eh,000h,000h	; b97a

; ----------------------------------------------------------------------
; DATOS pantalla_B97D: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[7]
;   0xb97d..0xb9b8  (59 bytes)
DATA_pantalla_B97D:
	defb 003h,000h,0fch,0fdh,083h,000h,006h,0e3h,0f8h,0f6h,0dbh,0e7h,000h,0e3h,0feh,00bh	; b97d  ................
	defb 0e3h,0f2h,000h,0e2h,0e8h,0e3h,0f1h,000h,000h,0e3h,0f2h,083h,000h,006h,0eah,0e3h	; b98d  ................
	defb 0e7h,000h,0e2h,0f2h,087h,000h,00ch,0f0h,000h,0eah,0e3h,0dbh,0e7h,0dch,0e2h,0e8h	; b99d  ................
	defb 000h,000h,0e6h,088h,000h,004h,0edh,0ddh,0f1h,000h,000h	; b9ad  ...........

; ----------------------------------------------------------------------
; DATOS pantalla_B9B8: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[8]
;   0xb9b8..0xb9ef  (55 bytes)
DATA_pantalla_B9B8:
	defb 005h,000h,000h,0e3h,0f2h,0e9h,086h,000h,016h,0e2h,0f2h,000h,0e0h,0e5h,0edh,0e8h	; b9b8  ................
	defb 000h,000h,0dch,000h,0eah,0e3h,0f8h,0f7h,000h,0ech,0e8h,0eeh,0efh,000h,0fah,084h	; b9c8  ................
	defb 000h,006h,0fch,0fdh,000h,0f4h,000h,0f9h,085h,000h,0e3h,0feh,004h,000h,0f4h,000h	; b9d8  ................
	defb 0e5h,089h,000h,002h,0ech,0f1h,000h	; b9e8

; ----------------------------------------------------------------------
; DATOS pantalla_B9EF: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[9]
;   0xb9ef..0xba2a  (59 bytes)
DATA_pantalla_B9EF:
	defb 004h,000h,000h,0fch,0fdh,083h,000h,002h,0e2h,0e7h,084h,000h,00dh,0feh,0ffh,0e2h	; b9ef  ................
	defb 0dbh,0f2h,000h,000h,0e6h,000h,0f9h,0edh,0dbh,0f1h,084h,000h,005h,0e2h,0f1h,000h	; b9ff  ................
	defb 000h,0fah,086h,000h,005h,0deh,000h,000h,0f9h,0e3h,083h,0dbh,006h,0e7h,000h,000h	; ba0f  ................
	defb 0ech,0dbh,0e7h,086h,000h,083h,0dah,002h,0edh,0f1h,000h	; ba1f  ...........

; ----------------------------------------------------------------------
; DATOS pantalla_BA2A: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[10]
;   0xba2a..0xba52  (40 bytes)
DATA_pantalla_BA2A:
	defb 08bh,000h,001h,0e2h,087h,0dbh,004h,0f2h,0e5h,000h,0fah,088h,000h,004h,0dfh,000h	; ba2a  ................
	defb 0edh,0e8h,085h,000h,003h,0e3h,0f6h,0f1h,083h,000h,008h,0edh,0e8h,0dch,0e4h,0dah	; ba3a  ................
	defb 000h,0fch,0fdh,089h,000h,0e3h,0feh,000h	; ba4a  ........

; ----------------------------------------------------------------------
; DATOS pantalla_BA52: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[11]
;   0xba52..0xba89  (55 bytes)
DATA_pantalla_BA52:
	defb 084h,000h,002h,0f5h,0f4h,087h,000h,006h,0e3h,0f2h,000h,000h,0edh,0e8h,083h,000h	; ba52  ................
	defb 002h,0e2h,0f2h,083h,000h,007h,0fch,0fdh,000h,0edh,0e7h,000h,0ebh,084h,000h,0e3h	; ba62  ................
	defb 0feh,005h,000h,0f5h,000h,000h,0f4h,086h,000h,001h,0f5h,084h,000h,002h,0eah,0e2h	; ba72  ................
	defb 083h,0dbh,001h,0f2h,083h,000h,000h	; ba82

; ----------------------------------------------------------------------
; DATOS pantalla_BA89: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[12]
;   0xba89..0xbab9  (48 bytes)
DATA_pantalla_BA89:
	defb 001h,0e2h,088h,0dbh,003h,0e7h,000h,0deh,089h,000h,005h,0f4h,0deh,000h,0f9h,0e9h	; ba89  ................
	defb 083h,000h,00bh,0fch,0fdh,000h,0e1h,0deh,000h,0dfh,000h,0f4h,000h,000h,0e3h,0feh	; ba99  ................
	defb 00ch,0ebh,0eah,0e3h,0f1h,000h,000h,0ech,0ddh,0e8h,0e3h,0dbh,0f1h,08bh,000h,000h	; baa9  ................

; ----------------------------------------------------------------------
; DATOS pantalla_BAB9: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[13]
;   0xbab9..0xbaf2  (57 bytes)
DATA_pantalla_BAB9:
	defb 007h,000h,0e0h,0edh,0e7h,0dch,0e4h,0e9h,085h,000h,001h,0ebh,085h,000h,002h,0edh	; bab9  ................
	defb 0e7h,084h,000h,001h,0e6h,085h,000h,001h,0dfh,085h,000h,011h,0ech,0e7h,000h,000h	; bac9  ................
	defb 0e3h,0f1h,0fch,0fdh,000h,0e2h,0dbh,0e8h,0efh,000h,0f9h,0e3h,0e7h,0e3h,0feh,002h	; bad9  ................
	defb 0eah,0e3h,085h,0ddh,003h,0f1h,000h,000h,000h	; bae9  .........

; ----------------------------------------------------------------------
; DATOS pantalla_BAF2: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[14]
;   0xbaf2..0xbb26  (52 bytes)
DATA_pantalla_BAF2:
	defb 002h,0e0h,0edh,085h,0dbh,006h,0f2h,0e5h,000h,000h,0ech,0e8h,083h,000h,004h,0e0h	; baf2  ................
	defb 0edh,0dbh,0f1h,084h,000h,005h,0e5h,000h,000h,0ech,0e8h,085h,000h,003h,0fch,0fdh	; bb02  ................
	defb 0eah,083h,000h,005h,0edh,0dbh,0e7h,000h,000h,0e3h,0feh,001h,0e5h,084h,0dch,001h	; bb12  ................
	defb 0efh,08ch,000h,000h	; bb22

; ----------------------------------------------------------------------
; DATOS pantalla_BB26: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[15]
;   0xbb26..0xbb5b  (53 bytes)
DATA_pantalla_BB26:
	defb 003h,0e0h,0dah,0e5h,085h,000h,007h,0fch,0fdh,000h,0ebh,000h,000h,0f4h,084h,000h	; bb26  ................
	defb 0e3h,0feh,00ch,000h,0fah,000h,000h,0f4h,0e3h,0e8h,000h,000h,0e3h,0e7h,0dfh,086h	; bb36  ................
	defb 000h,009h,0dah,0dah,000h,0efh,0dfh,000h,000h,0e2h,0f1h,085h,0dah,004h,000h,000h	; bb46  ................
	defb 0ech,0f2h,088h,000h,000h	; bb56

; ----------------------------------------------------------------------
; DATOS pantalla_BB5B: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[16]
;   0xbb5b..0xbb93  (56 bytes)
DATA_pantalla_BB5B:
	defb 004h,000h,000h,0fch,0fdh,089h,000h,0e3h,0feh,003h,0e0h,0edh,0e7h,083h,000h,009h	; bb5b  ................
	defb 0f9h,0edh,0f8h,0e7h,000h,0eah,000h,000h,0f4h,083h,000h,008h,0deh,000h,0f5h,000h	; bb6b  ................
	defb 000h,0f4h,000h,0dfh,083h,000h,00ch,0deh,0f9h,0e3h,0dbh,0dbh,0e8h,0fah,000h,0dah	; bb7b  ................
	defb 0e5h,000h,0eah,088h,0dch,001h,0efh,000h	; bb8b  ........

; ----------------------------------------------------------------------
; DATOS pantalla_BB93: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[17]
;   0xbb93..0xbbd0  (61 bytes)
DATA_pantalla_BB93:
	defb 007h,0e0h,0e9h,0dch,0dch,0e4h,0dah,0e9h,084h,000h,001h,0ech,084h,0dbh,003h,0e7h	; bb93  ................
	defb 000h,0e6h,085h,000h,007h,0e0h,0edh,0dbh,0f1h,000h,000h,0f4h,084h,000h,008h,0deh	; bba3  ................
	defb 000h,000h,0e0h,0dah,0dah,0eeh,0fah,083h,000h,007h,0f4h,000h,0dfh,000h,000h,0fch	; bbb3  ................
	defb 0fdh,085h,000h,004h,0ech,0f1h,000h,000h,0e3h,0feh,001h,000h,000h	; bbc3  .............

; ----------------------------------------------------------------------
; DATOS pantalla_BBD0: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[18]
;   0xbbd0..0xbc09  (57 bytes)
DATA_pantalla_BBD0:
	defb 004h,0f9h,0edh,0f2h,0eah,088h,000h,017h,0f4h,000h,0f0h,000h,000h,0e3h,0e8h,0e3h	; bbd0  ................
	defb 0e7h,000h,000h,0dfh,000h,0ech,0f6h,0f2h,000h,000h,0e3h,0f1h,000h,000h,0dfh,084h	; bbe0  ................
	defb 000h,002h,0e3h,0f2h,085h,000h,008h,0fah,000h,0e3h,0f2h,000h,000h,0fch,0fdh,083h	; bbf0  ................
	defb 000h,002h,0ech,0f2h,084h,000h,0e3h,0feh,000h	; bc00  .........

; ----------------------------------------------------------------------
; DATOS pantalla_BC09: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[19]
;   0xbc09..0xbc3f  (54 bytes)
DATA_pantalla_BC09:
	defb 007h,000h,000h,0fch,0fdh,000h,0e0h,0e5h,083h,0dch,083h,000h,0e3h,0feh,006h,0deh	; bc09  ................
	defb 0e0h,0deh,000h,000h,0e5h,083h,000h,014h,0e2h,0f1h,000h,0deh,0deh,0e0h,0e9h,0efh	; bc19  ................
	defb 0e2h,0f6h,0f1h,000h,000h,0f9h,000h,0deh,0deh,000h,000h,0ech,083h,0ddh,004h,0e8h	; bc29  ................
	defb 0efh,000h,0fbh,08eh,000h,000h	; bc39

; ----------------------------------------------------------------------
; DATOS pantalla_BC3F: pantalla comprimida para RLE_A_RAM (p01 0x637A): 6
;   filas de 11 tiles; tabla 0xBC6D[20]
;   0xbc3f..0xbc6d  (46 bytes)
DATA_pantalla_BC3F:
	defb 085h,000h,00bh,0f5h,0f4h,0e3h,0e7h,000h,000h,0e2h,0dbh,0dbh,0f6h,0f2h,084h,000h	; bc3f  ................
	defb 004h,0ech,0e7h,0ech,0e7h,084h,000h,007h,0fch,0fdh,000h,000h,0f0h,000h,0efh,084h	; bc4f  ................
	defb 000h,0e3h,0feh,003h,0f5h,000h,0f9h,087h,0dch,001h,0f5h,08dh,000h,000h	; bc5f  ..............

; ----------------------------------------------------------------------
; DATOS tabla_pantallas_BC6D: 21 punteros a pantallas comprimidas de 11 de
;   ancho; p01 0x61B5/0x75F3 (con 5/6), por (E25C): al buffer E423
;   0xbc6d..0xbc97  (42 bytes)
DATA_tabla_pantallas_BC6D:
	defw 0b805h	; bc6d  -> DATA_pantalla_B805
	defw 0b8e5h	; bc6f  -> DATA_pantalla_B8E5
	defw 0b841h	; bc71  -> DATA_pantalla_B841
	defw 0b872h	; bc73  -> DATA_pantalla_B872
	defw 0b8a8h	; bc75  -> DATA_pantalla_B8A8
	defw 0b90eh	; bc77  -> DATA_pantalla_B90E
	defw 0b94ah	; bc79  -> DATA_pantalla_B94A
	defw 0b97dh	; bc7b  -> DATA_pantalla_B97D
	defw 0b9b8h	; bc7d  -> DATA_pantalla_B9B8
	defw 0b9efh	; bc7f  -> DATA_pantalla_B9EF
	defw 0ba2ah	; bc81  -> DATA_pantalla_BA2A
	defw 0ba52h	; bc83  -> DATA_pantalla_BA52
	defw 0ba89h	; bc85  -> DATA_pantalla_BA89
	defw 0bab9h	; bc87  -> DATA_pantalla_BAB9
	defw 0baf2h	; bc89  -> DATA_pantalla_BAF2
	defw 0bb26h	; bc8b  -> DATA_pantalla_BB26
	defw 0bb5bh	; bc8d  -> DATA_pantalla_BB5B
	defw 0bb93h	; bc8f  -> DATA_pantalla_BB93
	defw 0bbd0h	; bc91  -> DATA_pantalla_BBD0
	defw 0bc09h	; bc93  -> DATA_pantalla_BC09
	defw 0bc3fh	; bc95  -> DATA_pantalla_BC3F

; ----------------------------------------------------------------------
; DATOS atributos_final_A: 37 atributos de sprite (y, x, patron, color) y
;   0xFF: la primera lista de la secuencia final (p02 0x8639[0]); los patrones
;   van 0x24, 0x10, 0x14, 0x18, 0x1C, 0x20 y la posicion baja y se va a la
;   izquierda
;   0xbc97..0xbd2c  (149 bytes)
DATA_atributos_final_A:
	defb 051h,0b0h,024h,081h	; bc97
	defb 050h,0b0h,024h,081h	; bc9b
	defb 04fh,0afh,010h,00bh	; bc9f
	defb 04fh,0b2h,010h,00bh	; bca3
	defb 04fh,0b0h,024h,081h	; bca7
	defb 051h,0aeh,010h,00bh	; bcab
	defb 051h,0b0h,010h,08bh	; bcaf
	defb 053h,0ach,010h,00bh	; bcb3
	defb 053h,0b0h,010h,08bh	; bcb7
	defb 057h,0aah,014h,00bh	; bcbb
	defb 057h,0aah,018h,009h	; bcbf
	defb 057h,0aeh,014h,00bh	; bcc3
	defb 057h,0aeh,018h,089h	; bcc7
	defb 05bh,0a6h,014h,00bh	; bccb
	defb 05bh,0a6h,018h,009h	; bccf
	defb 05bh,0ach,014h,00bh	; bcd3
	defb 05bh,0ach,018h,089h	; bcd7
	defb 05fh,0a1h,014h,00bh	; bcdb
	defb 05fh,0a1h,018h,009h	; bcdf
	defb 060h,0a9h,014h,00bh	; bce3
	defb 060h,0a9h,018h,089h	; bce7
	defb 063h,09dh,014h,00bh	; bceb
	defb 063h,09dh,018h,009h	; bcef
	defb 064h,0a7h,014h,00bh	; bcf3
	defb 064h,0a7h,018h,089h	; bcf7
	defb 067h,098h,01ch,00ah	; bcfb
	defb 067h,098h,020h,009h	; bcff
	defb 069h,0a3h,01ch,00ah	; bd03
	defb 069h,0a3h,020h,089h	; bd07
	defb 06ch,092h,01ch,00ah	; bd0b
	defb 06ch,092h,020h,009h	; bd0f
	defb 06eh,09eh,01ch,00ah	; bd13
	defb 06eh,09eh,020h,089h	; bd17
	defb 070h,08ch,01ch,00ah	; bd1b
	defb 070h,08ch,020h,009h	; bd1f
	defb 073h,09bh,01ch,00ah	; bd23
	defb 073h,09bh,020h,089h	; bd27
	defb 0ffh	; bd2b

; ----------------------------------------------------------------------
; DATOS atributos_final_B: 37 atributos de sprite (y, x, patron, color) y
;   0xFF: la segunda (p02 0x8639[1]), la misma figura unos 15 pixeles a la
;   derecha
;   0xbd2c..0xbdc1  (149 bytes)
DATA_atributos_final_B:
	defb 051h,0bfh,024h,081h	; bd2c
	defb 050h,0bfh,024h,081h	; bd30
	defb 04fh,0beh,010h,00bh	; bd34
	defb 04fh,0c1h,010h,00bh	; bd38
	defb 04fh,0bfh,024h,081h	; bd3c
	defb 051h,0bdh,010h,00bh	; bd40
	defb 051h,0bfh,010h,08bh	; bd44
	defb 053h,0bbh,010h,00bh	; bd48
	defb 053h,0bfh,010h,08bh	; bd4c
	defb 057h,0b9h,014h,00bh	; bd50
	defb 057h,0b9h,018h,009h	; bd54
	defb 057h,0bdh,014h,00bh	; bd58
	defb 057h,0bdh,018h,089h	; bd5c
	defb 05bh,0b6h,014h,00bh	; bd60
	defb 05bh,0b6h,018h,009h	; bd64
	defb 05bh,0bch,014h,00bh	; bd68
	defb 05bh,0bch,018h,089h	; bd6c
	defb 05fh,0b2h,014h,00bh	; bd70
	defb 05fh,0b2h,018h,009h	; bd74
	defb 05fh,0bah,014h,00bh	; bd78
	defb 05fh,0bah,018h,089h	; bd7c
	defb 063h,0afh,014h,00bh	; bd80
	defb 063h,0afh,018h,009h	; bd84
	defb 063h,0b9h,014h,00bh	; bd88
	defb 063h,0b9h,018h,089h	; bd8c
	defb 067h,0ach,01ch,00ah	; bd90
	defb 067h,0ach,020h,009h	; bd94
	defb 067h,0b7h,01ch,00ah	; bd98
	defb 067h,0b7h,020h,089h	; bd9c
	defb 06ch,0a9h,01ch,00ah	; bda0
	defb 06ch,0a9h,020h,009h	; bda4
	defb 06ch,0b5h,01ch,00ah	; bda8
	defb 06ch,0b5h,020h,089h	; bdac
	defb 070h,0a5h,01ch,00ah	; bdb0
	defb 070h,0a5h,020h,009h	; bdb4
	defb 070h,0b4h,01ch,00ah	; bdb8
	defb 070h,0b4h,020h,089h	; bdbc
	defb 0ffh	; bdc0

; ----------------------------------------------------------------------
; DATOS mandos_grabados_BDC1: 269 pares (mascara de mandos, cuadros que dura)
;   que suman 4199 cuadros: 84 s a 50 Hz. Mismo formato que p15 0xBAB9, con
;   mas mascaras distintas (39). Nadie lo referencia con una direccion
;   literal: lo que encaja es una partida grabada para la demo (hipotesis
;   fundada, sin medir en el emulador)
;   0xbdc1..0xbfdc  (539 bytes)
DATA_mandos_grabados_BDC1:
	defb 000h,002h	; bdc1
	defb 010h,003h	; bdc3
	defb 000h,01eh	; bdc5
	defb 010h,003h	; bdc7
	defb 000h,02ah	; bdc9
	defb 010h,002h	; bdcb
	defb 000h,025h	; bdcd
	defb 002h,003h	; bdcf
	defb 000h,023h	; bdd1
	defb 010h,002h	; bdd3
	defb 000h,026h	; bdd5
	defb 010h,004h	; bdd7
	defb 000h,01dh	; bdd9
	defb 008h,003h	; bddb
	defb 000h,01bh	; bddd
	defb 010h,004h	; bddf
	defb 000h,021h	; bde1
	defb 010h,002h	; bde3
	defb 000h,05fh	; bde5
	defb 014h,007h	; bde7
	defb 018h,006h	; bde9
	defb 010h,00dh	; bdeb
	defb 011h,005h	; bded
	defb 010h,01ah	; bdef
	defb 011h,003h	; bdf1
	defb 010h,0e4h	; bdf3
	defb 018h,005h	; bdf5
	defb 010h,004h	; bdf7
	defb 014h,006h	; bdf9
	defb 010h,010h	; bdfb
	defb 018h,005h	; bdfd
	defb 010h,008h	; bdff
	defb 014h,004h	; be01
	defb 010h,00eh	; be03
	defb 014h,004h	; be05
	defb 010h,003h	; be07
	defb 018h,008h	; be09
	defb 010h,009h	; be0b
	defb 018h,003h	; be0d
	defb 010h,001h	; be0f
	defb 014h,006h	; be11
	defb 010h,023h	; be13
	defb 014h,00ah	; be15
	defb 010h,005h	; be17
	defb 018h,004h	; be19
	defb 010h,004h	; be1b
	defb 018h,006h	; be1d
	defb 010h,006h	; be1f
	defb 014h,006h	; be21
	defb 010h,005h	; be23
	defb 04fh,000h	; be25
	defb 002h,010h	; be27
	defb 002h,000h	; be29
	defb 01fh,010h	; be2b
	defb 003h,000h	; be2d
	defb 02fh,010h	; be2f
	defb 003h,000h	; be31
	defb 023h,002h	; be33
	defb 005h,000h	; be35
	defb 00eh,002h	; be37
	defb 005h,000h	; be39
	defb 00eh,002h	; be3b
	defb 004h,000h	; be3d
	defb 010h,002h	; be3f
	defb 004h,000h	; be41
	defb 010h,002h	; be43
	defb 004h,000h	; be45
	defb 011h,008h	; be47
	defb 004h,000h	; be49
	defb 011h,008h	; be4b
	defb 003h,000h	; be4d
	defb 013h,008h	; be4f
	defb 004h,000h	; be51
	defb 010h,008h	; be53
	defb 004h,000h	; be55
	defb 011h,008h	; be57
	defb 004h,000h	; be59
	defb 013h,008h	; be5b
	defb 004h,000h	; be5d
	defb 013h,008h	; be5f
	defb 004h,000h	; be61
	defb 014h,008h	; be63
	defb 004h,000h	; be65
	defb 015h,008h	; be67
	defb 004h,000h	; be69
	defb 026h,010h	; be6b
	defb 002h,000h	; be6d
	defb 015h,010h	; be6f
	defb 003h,000h	; be71
	defb 014h,008h	; be73
	defb 005h,000h	; be75
	defb 013h,008h	; be77
	defb 005h,000h	; be79
	defb 016h,010h	; be7b
	defb 005h,000h	; be7d
	defb 014h,010h	; be7f
	defb 002h,000h	; be81
	defb 05ch,010h	; be83
	defb 006h,018h	; be85
	defb 008h,010h	; be87
	defb 001h,014h	; be89
	defb 009h,010h	; be8b
	defb 00bh,014h	; be8d
	defb 005h,010h	; be8f
	defb 002h,018h	; be91
	defb 004h,010h	; be93
	defb 005h,011h	; be95
	defb 004h,010h	; be97
	defb 027h,011h	; be99
	defb 005h,010h	; be9b
	defb 039h,011h	; be9d
	defb 004h,010h	; be9f
	defb 002h,018h	; bea1
	defb 003h,010h	; bea3
	defb 002h,014h	; bea5
	defb 004h,010h	; bea7
	defb 00fh,014h	; bea9
	defb 006h,010h	; beab
	defb 002h,018h	; bead
	defb 005h,010h	; beaf
	defb 012h,000h	; beb1
	defb 00ah,008h	; beb3
	defb 007h,000h	; beb5
	defb 001h,004h	; beb7
	defb 005h,000h	; beb9
	defb 014h,010h	; bebb
	defb 00fh,000h	; bebd
	defb 002h,004h	; bebf
	defb 005h,000h	; bec1
	defb 003h,008h	; bec3
	defb 004h,000h	; bec5
	defb 002h,008h	; bec7
	defb 005h,000h	; bec9
	defb 002h,004h	; becb
	defb 004h,000h	; becd
	defb 002h,008h	; becf
	defb 00ah,000h	; bed1
	defb 004h,004h	; bed3
	defb 00fh,024h	; bed5
	defb 001h,034h	; bed7
	defb 001h,024h	; bed9
	defb 003h,004h	; bedb
	defb 002h,008h	; bedd
	defb 005h,000h	; bedf
	defb 005h,008h	; bee1
	defb 007h,000h	; bee3
	defb 005h,010h	; bee5
	defb 00bh,018h	; bee7
	defb 00ah,010h	; bee9
	defb 00eh,000h	; beeb
	defb 007h,004h	; beed
	defb 001h,000h	; beef
	defb 002h,004h	; bef1
	defb 013h,000h	; bef3
	defb 001h,008h	; bef5
	defb 002h,018h	; bef7
	defb 003h,010h	; bef9
	defb 003h,038h	; befb
	defb 008h,028h	; befd
	defb 00dh,008h	; beff
	defb 003h,000h	; bf01
	defb 004h,002h	; bf03
	defb 004h,000h	; bf05
	defb 006h,002h	; bf07
	defb 003h,010h	; bf09
	defb 005h,014h	; bf0b
	defb 004h,010h	; bf0d
	defb 017h,011h	; bf0f
	defb 004h,010h	; bf11
	defb 00eh,011h	; bf13
	defb 004h,010h	; bf15
	defb 02fh,014h	; bf17
	defb 004h,010h	; bf19
	defb 001h,018h	; bf1b
	defb 004h,010h	; bf1d
	defb 00dh,018h	; bf1f
	defb 005h,010h	; bf21
	defb 001h,014h	; bf23
	defb 005h,010h	; bf25
	defb 00ch,014h	; bf27
	defb 005h,010h	; bf29
	defb 009h,014h	; bf2b
	defb 00ah,010h	; bf2d
	defb 002h,018h	; bf2f
	defb 001h,038h	; bf31
	defb 004h,028h	; bf33
	defb 003h,008h	; bf35
	defb 003h,018h	; bf37
	defb 001h,008h	; bf39
	defb 001h,018h	; bf3b
	defb 00ah,010h	; bf3d
	defb 001h,014h	; bf3f
	defb 005h,010h	; bf41
	defb 001h,018h	; bf43
	defb 003h,010h	; bf45
	defb 008h,014h	; bf47
	defb 006h,010h	; bf49
	defb 00ah,018h	; bf4b
	defb 006h,014h	; bf4d
	defb 006h,010h	; bf4f
	defb 00ch,018h	; bf51
	defb 00fh,014h	; bf53
	defb 01bh,038h	; bf55
	defb 006h,018h	; bf57
	defb 006h,010h	; bf59
	defb 001h,014h	; bf5b
	defb 005h,010h	; bf5d
	defb 003h,018h	; bf5f
	defb 00bh,010h	; bf61
	defb 001h,014h	; bf63
	defb 004h,010h	; bf65
	defb 006h,018h	; bf67
	defb 003h,010h	; bf69
	defb 003h,014h	; bf6b
	defb 004h,010h	; bf6d
	defb 001h,014h	; bf6f
	defb 003h,010h	; bf71
	defb 001h,018h	; bf73
	defb 004h,010h	; bf75
	defb 007h,012h	; bf77
	defb 004h,014h	; bf79
	defb 001h,034h	; bf7b
	defb 008h,014h	; bf7d
	defb 002h,010h	; bf7f
	defb 003h,018h	; bf81
	defb 004h,038h	; bf83
	defb 004h,018h	; bf85
	defb 00fh,014h	; bf87
	defb 007h,010h	; bf89
	defb 008h,018h	; bf8b
	defb 005h,010h	; bf8d
	defb 001h,014h	; bf8f
	defb 006h,010h	; bf91
	defb 00dh,011h	; bf93
	defb 004h,010h	; bf95
	defb 012h,000h	; bf97
	defb 002h,020h	; bf99
	defb 00fh,024h	; bf9b
	defb 00ah,020h	; bf9d
	defb 003h,028h	; bf9f
	defb 002h,018h	; bfa1
	defb 005h,038h	; bfa3
	defb 001h,028h	; bfa5
	defb 002h,020h	; bfa7
	defb 035h,000h	; bfa9
	defb 072h,010h	; bfab
	defb 022h,011h	; bfad
	defb 004h,010h	; bfaf
	defb 010h,011h	; bfb1
	defb 004h,010h	; bfb3
	defb 006h,018h	; bfb5
	defb 003h,010h	; bfb7
	defb 005h,018h	; bfb9
	defb 009h,010h	; bfbb
	defb 001h,014h	; bfbd
	defb 00ah,010h	; bfbf
	defb 007h,011h	; bfc1
	defb 005h,010h	; bfc3
	defb 02ch,014h	; bfc5
	defb 007h,010h	; bfc7
	defb 001h,018h	; bfc9
	defb 005h,010h	; bfcb
	defb 06eh,018h	; bfcd
	defb 007h,010h	; bfcf
	defb 003h,014h	; bfd1
	defb 004h,010h	; bfd3
	defb 018h,014h	; bfd5
	defb 007h,010h	; bfd7
	defb 001h,04fh	; bfd9
	defb 0ffh	; bfdb

; ----------------------------------------------------------------------
; DATOS relleno_BFDC: 36 bytes a 0xFF hasta el final de la pagina: espacio
;   libre, comprobado byte a byte
;   0xbfdc..0xc000  (36 bytes)
DATA_relleno_BFDC:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfec  ................
	defb 0ffh,0ffh,0ffh,0ffh	; bffc
