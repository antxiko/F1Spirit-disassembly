; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 12 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS metatiles_C: tabla de metatiles C: 256 metatiles de 16 B (4 filas x 4
;   tiles); la usan las carreras 3,4,5,6,7,10,11,12,13,14,15,16,17,18,19
;   0xa000..0xa698  (1688 bytes)
DATA_metatiles_C:
	defb 06dh,045h,013h,014h,06eh,044h,015h,016h,06dh,045h,017h,018h,06eh,044h,019h,01ah	; a000  mE..nD..mE..nD..
	defb 06dh,045h,01bh,01ch,06eh,044h,01dh,01eh,06dh,045h,001h,002h,06eh,044h,003h,004h	; a010  mE..nD..mE..nD..
	defb 06dh,045h,005h,006h,06eh,044h,007h,008h,06dh,045h,009h,00ah,06eh,044h,00bh,00ch	; a020  mE..nD..mE..nD..
	defb 06dh,045h,00dh,00eh,06eh,044h,069h,068h,06dh,045h,04fh,068h,06eh,044h,04eh,04eh	; a030  mE..nDihmEOhnDNN
	defb 06dh,045h,04dh,04fh,06eh,044h,04eh,068h,06dh,046h,049h,068h,06eh,044h,04fh,068h	; a040  mEMOnDNhmFIhnDOh
	defb 06dh,045h,04dh,04eh,06eh,044h,04dh,04fh,06dh,045h,04dh,04fh,06eh,044h,04fh,068h	; a050  mEMNnDMOmEMOnDOh
	defb 06dh,047h,048h,068h,06eh,068h,068h,069h,03dh,02ch,036h,037h,03dh,04ah,027h,03bh	; a060  mGHhnhhi=,67=J';
	defb 03dh,04ch,027h,03ah,03dh,04ah,027h,03bh,03dh,04ch,025h,03ah,03dh,04ah,028h,03bh	; a070  =L':=J';=L%:=J(;
	defb 03dh,04ch,028h,03ah,03dh,04ah,028h,03bh,03dh,04ch,023h,03ah,03dh,04ah,026h,03bh	; a080  =L(:=J(;=L#:=J&;
	defb 03dh,04ch,026h,03ah,03dh,04ah,026h,03bh,03dh,04ch,024h,03ah,03dh,04ah,027h,03bh	; a090  =L&:=J&;=L$:=J';
	defb 03dh,04ch,027h,03ah,03dh,04ah,027h,03bh,031h,032h,038h,039h,068h,066h,066h,03ch	; a0a0  =L':=J';1289hff<
	defb 067h,06ah,069h,06bh,069h,068h,068h,06ch,0c3h,0c3h,0c3h,0c3h,0c3h,0c6h,0c7h,0c3h	; a0b0  gjikihhl........
	defb 0c5h,0c8h,0c9h,0c5h,0c5h,0cah,0c4h,0c5h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h	; a0c0  ................
	defb 0c5h,0c5h,0c5h,0c5h,0c5h,0c5h,0c5h,0c5h,0c3h,0afh,0afh,0afh,0c3h,0afh,0afh,0afh	; a0d0  ................
	defb 0c5h,0b1h,0b1h,0b1h,0c5h,0b1h,0b1h,0b1h,06ah,067h,067h,06bh,059h,05ah,061h,06ch	; a0e0  ........jggkYZal
	defb 05bh,05ch,062h,06bh,05dh,05eh,063h,06ch,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h	; a0f0  [\bk]^cl........
	defb 0a0h,0c5h,0c5h,0c5h,0a4h,0c5h,0c5h,0c5h,088h,069h,06ah,067h,08ch,067h,069h,068h	; a100  .........ijg.gih
	defb 06dh,069h,067h,06ah,06eh,067h,068h,069h,09fh,0c3h,0c3h,0c3h,0a3h,0c3h,0c3h,0c3h	; a110  migjnghi........
	defb 080h,0a0h,0c5h,0c5h,084h,0a4h,0c5h,0c5h,081h,0a1h,0c3h,0c3h,06ah,085h,0a5h,0c3h	; a120  ............j...
	defb 067h,081h,0a1h,0c5h,069h,068h,085h,0a5h,0c3h,0c3h,0c3h,0c3h,0a5h,0c3h,0c3h,0c3h	; a130  g...ih..........
	defb 0a1h,0c5h,0c5h,0c5h,085h,0a5h,0c5h,0c5h,0c3h,0afh,0cbh,0afh,0a5h,0afh,0cch,0afh	; a140  ................
	defb 0a1h,0b1h,0c8h,0c9h,085h,0b1h,0cah,0c4h,098h,078h,06ah,067h,09ch,07ch,069h,06ah	; a150  .........xjg.|ij
	defb 099h,079h,067h,068h,0c5h,09eh,07eh,076h,070h,090h,0afh,0afh,074h,094h,0afh,0afh	; a160  .ygh..~vp...t...
	defb 071h,091h,0b1h,0b1h,096h,0c5h,0b1h,0b1h,06dh,068h,04eh,04dh,06eh,06ah,068h,04fh	; a170  q.......mhNMnjhO
	defb 077h,067h,069h,042h,07bh,069h,067h,068h,03fh,06bh,0afh,0afh,03eh,06ch,0afh,0afh	; a180  wgiB{igh?k..>l..
	defb 041h,06fh,0b1h,0b1h,069h,073h,0b1h,0b1h,03fh,06bh,0afh,0afh,03eh,06ch,0afh,0afh	; a190  Ao..is..?k..>l..
	defb 03fh,06bh,0b1h,0b1h,03eh,06ch,0b1h,0b1h,06dh,068h,04eh,01fh,06eh,04fh,04dh,026h	; a1a0  ?k..>l..mhN.nOM&
	defb 06dh,04eh,04dh,024h,06eh,069h,04eh,027h,06dh,068h,04eh,025h,06eh,04fh,04dh,028h	; a1b0  mNM$niN'mhN%nOM(
	defb 06dh,04eh,04dh,023h,06eh,069h,04eh,026h,06dh,068h,04eh,024h,06eh,04fh,04dh,027h	; a1c0  mNM#niN&mhN$nOM'
	defb 06dh,04eh,04dh,022h,06eh,069h,04eh,04fh,068h,043h,040h,070h,04fh,04eh,03eh,074h	; a1d0  mNM"niNOhC@pON>t
	defb 04eh,04dh,03fh,06bh,06ah,04dh,03eh,06ch,090h,0c3h,0c3h,0c3h,094h,0c3h,0c3h,0c3h	; a1e0  NM?kjM>l........
	defb 08fh,0c5h,0c5h,0c5h,093h,0c5h,0c5h,0c5h,04eh,04dh,03fh,06bh,04dh,04ah,03eh,06ch	; a1f0  ........NM?kMJ>l
	defb 04eh,04dh,03fh,06bh,029h,02ah,029h,0c1h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h	; a200  NM?k)*).........
	defb 0bfh,0bfh,0bfh,0bfh,0c0h,0c1h,0c0h,0c1h,088h,069h,06ah,067h,08ch,067h,069h,068h	; a210  .........ijg.gih
	defb 06dh,069h,067h,06ah,0c0h,02ah,068h,069h,026h,026h,026h,0c2h,02bh,04dh,03eh,06ch	; a220  migj.*hi&&&.+M>l
	defb 02bh,064h,03fh,06bh,065h,0cdh,0cdh,0cdh,0c2h,0c2h,0c2h,0c2h,0bfh,0bfh,0bfh,0bfh	; a230  +d?ke...........
	defb 0c5h,0c5h,0c5h,0c5h,0cdh,0cdh,0cdh,0cdh,0c2h,026h,04fh,043h,06eh,02bh,04eh,04eh	; a240  .........&OCn+NN
	defb 06dh,02bh,064h,04dh,0cdh,0cdh,0cdh,04dh,040h,06bh,0afh,0afh,03eh,06ch,0afh,0afh	; a250  m+dM...M@k..>l..
	defb 03fh,06bh,0b1h,0b1h,03eh,06ch,0b1h,0b1h,0c3h,0aah,08ah,082h,0adh,08dh,069h,068h	; a260  ?k..>l........ih
	defb 0a7h,087h,067h,06ah,0abh,08bh,068h,069h,0a2h,0afh,0afh,0afh,085h,0a5h,0afh,0afh	; a270  ..gj..hi........
	defb 07fh,09fh,0b1h,0b1h,083h,0a3h,0b1h,0b1h,067h,080h,0afh,0afh,06ah,084h,0afh,0afh	; a280  ........g...j...
	defb 068h,06bh,0b1h,0b1h,069h,06ch,0b1h,0b1h,068h,071h,091h,0c3h,075h,095h,0c3h,0c3h	; a290  hk..il..hq..u...
	defb 06fh,08fh,0c5h,0c5h,073h,093h,0c5h,0c5h,06ah,067h,069h,071h,069h,068h,075h,095h	; a2a0  o...s...jgiqihu.
	defb 067h,06ah,071h,091h,069h,075h,095h,0c5h,091h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h	; a2b0  gjq.iu..........
	defb 0c5h,0c5h,0c5h,0c5h,0c5h,0c5h,0c5h,0c5h,069h,071h,091h,0c3h,075h,095h,0c3h,0c3h	; a2c0  ........iq..u...
	defb 071h,091h,0c5h,0c5h,095h,0c5h,0c5h,0c5h,091h,0afh,0afh,0afh,0c3h,0afh,0afh,0afh	; a2d0  q...............
	defb 0c5h,0b1h,0b1h,0b1h,0c5h,0b1h,0b1h,0b1h,06dh,045h,069h,067h,06eh,044h,069h,068h	; a2e0  ........mEignDih
	defb 06dh,045h,067h,06ah,06eh,044h,068h,069h,06dh,045h,05bh,05ch,06eh,044h,05dh,056h	; a2f0  mEgjnDhimE[\nD]V
	defb 06dh,045h,06ah,057h,06eh,044h,059h,054h,06dh,045h,068h,056h,06eh,044h,068h,057h	; a300  mEjWnDYTmEhVnDhW
	defb 06dh,045h,06ah,056h,06eh,044h,059h,054h,06dh,045h,05bh,053h,06eh,044h,05dh,057h	; a310  mEjVnDYTmE[SnD]W
	defb 06dh,045h,06ah,056h,06eh,044h,068h,057h,05ah,061h,06ah,03fh,05ch,062h,069h,03eh	; a320  mEjVnDhWZaj?\bi>
	defb 054h,063h,068h,03fh,055h,05ah,061h,03eh,053h,05ch,062h,03fh,05ch,054h,05fh,03eh	; a330  Tch?UZa>S\b?\T_>
	defb 054h,05ch,062h,03fh,055h,054h,05fh,03eh,053h,05ch,060h,03fh,05ch,062h,063h,03eh	; a340  T\b?UT_>S\`?\bc>
	defb 054h,060h,068h,03fh,058h,063h,068h,03eh,06ah,068h,06ah,03fh,059h,05ah,061h,03eh	; a350  T`h?Xch>jhj?YZa>
	defb 05bh,05ch,062h,03fh,05dh,05eh,063h,03eh,04eh,04dh,03fh,06bh,04dh,04ah,03eh,06ch	; a360  [\b?]^c>NM?kMJ>l
	defb 04eh,04dh,03fh,06bh,04eh,04eh,03eh,06ch,04fh,04dh,03fh,06bh,068h,04fh,03eh,06ch	; a370  NM?kNN>lOM?khO>l
	defb 068h,042h,041h,06bh,069h,06ah,069h,06ch,06dh,068h,068h,04eh,06eh,068h,04fh,04dh	; a380  hBAkijilmhhNnhOM
	defb 06dh,06ah,04eh,04dh,06eh,069h,069h,04eh,06ah,06bh,08fh,0afh,069h,06ch,093h,0afh	; a390  mjNMniiNjk..il..
	defb 067h,06bh,0a0h,0b1h,069h,06ch,0a4h,0b1h,0afh,0afh,0afh,0a7h,0afh,0afh,0afh,0abh	; a3a0  gk..il..........
	defb 0b1h,0b1h,0b1h,098h,0b1h,0b1h,0b1h,09ch,087h,067h,06ah,067h,08bh,068h,069h,06ah	; a3b0  .........gjg.hij
	defb 078h,06ah,067h,06ah,07ch,067h,068h,069h,07fh,09fh,0afh,0afh,083h,0a3h,0afh,0afh	; a3c0  xjgj|ghi........
	defb 070h,090h,0b1h,0b1h,074h,094h,0b1h,0b1h,0afh,0afh,097h,06dh,0afh,0afh,09bh,06eh	; a3d0  p...t......m...n
	defb 0b1h,0b1h,0a8h,06dh,0b1h,0b1h,0ach,06eh,06ah,068h,06ah,067h,07eh,068h,069h,068h	; a3e0  ...m...njhjg~hih
	defb 09ah,07ah,06ah,068h,0b1h,09dh,07dh,068h,0afh,0afh,099h,079h,0afh,0afh,0afh,09eh	; a3f0  .zjh..}h...y....
	defb 0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,068h,06ah,06ah,067h,07eh,068h,069h,068h	; a400  ........hjjg~hih
	defb 09ah,07ah,06ah,068h,0afh,09eh,07eh,068h,081h,0a1h,0afh,0afh,069h,086h,0a6h,0afh	; a410  .zjh..~h....i...
	defb 068h,06ah,082h,0a2h,068h,069h,068h,086h,06bh,0afh,0afh,0afh,06ch,0afh,0afh,0afh	; a420  hj..hih.k...l...
	defb 06bh,0b1h,0b1h,0b1h,06ch,0b4h,0b4h,0b4h,0afh,0afh,0afh,0afh,0afh,0afh,0afh,0afh	; a430  k...l...........
	defb 0b1h,0b1h,0b1h,0b1h,0b4h,0b4h,0b4h,0b4h,06bh,0b4h,0b4h,0b4h,06ch,0b4h,0b4h,0b4h	; a440  ........k...l...
	defb 06bh,0b1h,0b1h,0b1h,06ch,0b1h,0b1h,0b1h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h	; a450  k...l...........
	defb 0b1h,0b2h,0b3h,0b1h,0b1h,0b1h,0b1h,0b1h,06bh,0b4h,0b4h,0b4h,06ch,0b4h,0b4h,0b4h	; a460  ........k...l...
	defb 06bh,0bfh,0bfh,0bfh,0c1h,0c0h,0c1h,0c0h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h	; a470  k...............
	defb 0bfh,0bfh,0bfh,0bfh,0c1h,0c0h,0c1h,0c0h,0bah,0bbh,0bch,0bdh,0bfh,0bfh,0bfh,0bfh	; a480  ................
	defb 0b1h,0b2h,0b3h,0b1h,0b0h,0b0h,0b0h,0b0h,06ah,067h,068h,03fh,069h,068h,069h,03eh	; a490  ........jgh?ihi>
	defb 02bh,02bh,02bh,02bh,064h,052h,064h,052h,06bh,0afh,0afh,0afh,06ch,0afh,0afh,0afh	; a4a0  ++++dRdRk...l...
	defb 0b6h,0b6h,0b6h,0b6h,0b8h,0b7h,0b8h,0b7h,0afh,0afh,0afh,0afh,0afh,0afh,0afh,0afh	; a4b0  ................
	defb 0b6h,0b6h,0b6h,0b6h,0b8h,0b7h,0b8h,0b7h,06dh,045h,06ah,067h,06eh,044h,069h,068h	; a4c0  ........mEjgnDih
	defb 0b6h,02bh,02bh,02bh,0b8h,052h,064h,052h,0c5h,0c5h,0c3h,029h,0c5h,0c5h,0c3h,029h	; a4d0  .+++.RdR...)...)
	defb 0c5h,0c5h,0c3h,029h,0c5h,0c5h,0c3h,029h,0bdh,0bdh,0bch,0bch,0bdh,0bdh,0bch,0bch	; a4e0  ...)...)........
	defb 0bdh,0bdh,0bch,0bch,0bdh,0bdh,0bch,0bch,0bdh,050h,0c3h,0c3h,0bdh,050h,0c3h,0c3h	; a4f0  .........P...P..
	defb 0bdh,050h,0c3h,0c3h,0bdh,050h,0c3h,0c3h,0bdh,0bdh,0bch,0bch,0bdh,0bdh,0bch,0bch	; a500  .P...P..........
	defb 0bdh,0bdh,0bch,0bch,0bah,0b9h,0bah,0b9h,0bdh,050h,0c3h,0c3h,0bdh,050h,0c3h,0c3h	; a510  .........P...P..
	defb 0bdh,050h,0c3h,0c3h,0bah,051h,065h,051h,0c5h,0c5h,0c3h,029h,0c5h,0c5h,0c3h,029h	; a520  .P...QeQ...)...)
	defb 0c5h,0c5h,0c3h,029h,065h,051h,065h,051h,0c0h,0c0h,0c0h,02ah,0bfh,0bfh,0c1h,026h	; a530  ...)eQeQ...*...&
	defb 067h,06ah,068h,03fh,069h,067h,067h,03eh,0b5h,0b5h,0b5h,0b5h,0bbh,0bbh,0bbh,0bbh	; a540  gjh?igg>........
	defb 06bh,0b1h,0b1h,0b1h,06ch,0b1h,0b1h,0b1h,0b5h,0b5h,0b5h,0b5h,0bbh,0bbh,0bbh,0bbh	; a550  k...l...........
	defb 0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b5h,02ah,0c0h,0c0h,0bbh,026h,0c2h,0bfh	; a560  .........*...&..
	defb 06dh,045h,067h,06ah,06eh,044h,068h,069h,0c0h,0c0h,0c0h,0c0h,0bfh,0bfh,0bfh,0bfh	; a570  mEgjnDhi........
	defb 067h,06ah,067h,06ah,069h,067h,068h,069h,06ah,067h,06ah,067h,069h,068h,069h,068h	; a580  gjgjighijgjgihih
	defb 02bh,02bh,02bh,02bh,064h,052h,064h,052h,06ah,067h,06ah,03fh,069h,068h,067h,03eh	; a590  ++++dRdRjgj?ihg>
	defb 067h,06ah,068h,03fh,0beh,0beh,0beh,03eh,06dh,045h,0cdh,067h,06eh,044h,0cdh,068h	; a5a0  gjh?...>mE.gnD.h
	defb 06dh,045h,0cdh,06ah,06eh,044h,0cdh,0beh,052h,064h,052h,03fh,0c3h,0c5h,0c5h,03eh	; a5b0  mE.jnD..RdR?...>
	defb 0c3h,0c5h,0c5h,03fh,0c3h,0c5h,0c5h,03eh,0c3h,0c5h,0c5h,03fh,0c3h,0c5h,0c5h,03eh	; a5c0  ...?...>...?...>
	defb 0c3h,0c5h,0c5h,03fh,051h,065h,051h,03eh,06dh,045h,0cdh,064h,06eh,044h,0cdh,0c3h	; a5d0  ...?QeQ>mE.dnD..
	defb 06dh,045h,0cdh,0c3h,06eh,044h,0cdh,0c3h,06dh,045h,0cdh,0c3h,06eh,044h,0cdh,0c3h	; a5e0  mE..nD..mE..nD..
	defb 06dh,045h,0cdh,0c3h,06eh,044h,0cdh,065h,0beh,0beh,0beh,03fh,06ah,069h,069h,03eh	; a5f0  mE..nD.e...?jii>
	defb 067h,06ah,067h,03fh,069h,067h,068h,03eh,06ah,067h,06ah,067h,069h,068h,069h,068h	; a600  gjg?igh>jgjgihih
	defb 067h,06ah,067h,06ah,0beh,0beh,0beh,0beh,0c3h,0c5h,0c5h,0c3h,0c3h,0c5h,0c5h,0c3h	; a610  gjgj............
	defb 0c3h,0c5h,0c5h,0c3h,051h,065h,051h,065h,06dh,045h,0cdh,0beh,06eh,044h,0cdh,069h	; a620  ....QeQemE..nD.i
	defb 06dh,045h,0cdh,067h,06eh,044h,0cdh,069h,052h,064h,052h,064h,0c3h,0c5h,0c5h,0c3h	; a630  mE.gnD.iRdRd....
	defb 0c3h,0c5h,0c5h,0c3h,0c3h,0c5h,0c5h,0c3h,0beh,0beh,0beh,0beh,06ah,069h,06ah,069h	; a640  ............jiji
	defb 067h,06ah,067h,06ah,069h,067h,068h,069h,06dh,045h,067h,059h,06eh,044h,061h,057h	; a650  gjgjighimEgYnDaW
	defb 06dh,045h,060h,056h,06eh,044h,0cdh,05ch,06dh,045h,0cdh,054h,06eh,044h,055h,053h	; a660  mE`VnD.\mE.TnDUS
	defb 06dh,045h,05ch,05ch,06eh,044h,0cdh,05ch,06dh,045h,0cdh,067h,06eh,044h,0cdh,068h	; a670  mE\\nD.\mE.gnD.h
	defb 06dh,045h,0cdh,06ah,06eh,044h,0cdh,069h,06dh,045h,0cdh,055h,06eh,044h,062h,05ch	; a680  mE.jnD.imE.UnDb\
	defb 06dh,045h,063h,054h,06eh,044h,068h,057h	; a690  mEcTnDhW

; ----------------------------------------------------------------------
; DATOS metatiles_D: tabla de metatiles D: 142 metatiles de 16 B (4 filas x 4
;   tiles); la usan las carreras 1,9
;   0xa698..0xaf78  (2272 bytes)
DATA_metatiles_D:
	defb 081h,080h,083h,080h,083h,081h,082h,081h,080h,083h,080h,083h,082h,080h,081h,082h	; a698  ................
	defb 0bbh,08eh,08dh,08dh,0bbh,08eh,08dh,08dh,0bch,08eh,08fh,08fh,0bch,08eh,08fh,08fh	; a6a8  ................
	defb 08dh,08dh,08dh,08eh,08dh,08dh,08dh,08eh,08fh,08fh,08fh,08eh,08fh,08fh,08fh,08eh	; a6b8  ................
	defb 08dh,08dh,08dh,08dh,08dh,08dh,08dh,08dh,08fh,08fh,08fh,08fh,08fh,08fh,08fh,08fh	; a6c8  ................
	defb 0abh,0c1h,08dh,08dh,0ach,0c2h,08dh,08dh,0bch,08eh,08fh,08fh,0bch,08eh,08fh,08fh	; a6d8  ................
	defb 08dh,08dh,08dh,0c3h,08dh,08dh,08dh,0c4h,08fh,08fh,08fh,08eh,08fh,08fh,08fh,08eh	; a6e8  ................
	defb 09dh,080h,083h,080h,09eh,081h,082h,081h,0beh,083h,080h,083h,0beh,080h,081h,082h	; a6f8  ................
	defb 0c9h,0cch,0cdh,0c9h,0c9h,0c6h,0c7h,0c9h,0cbh,0c8h,0cah,0cbh,0cbh,0cbh,0cbh,0cbh	; a708  ................
	defb 0bbh,08eh,08dh,08dh,0bbh,08eh,08dh,08dh,0bch,08eh,0cch,0cdh,0bch,08eh,08fh,08fh	; a718  ................
	defb 08dh,08dh,08dh,08eh,08dh,0cch,0cdh,08eh,08fh,08fh,08fh,08eh,08fh,08fh,08fh,08eh	; a728  ................
	defb 0bbh,090h,090h,090h,0bbh,08eh,08dh,08dh,0bch,08eh,0cch,0cdh,0bch,08eh,08fh,08fh	; a738  ................
	defb 090h,090h,090h,090h,08dh,0cch,0cdh,08eh,08fh,08fh,08fh,08eh,08fh,08fh,08fh,08eh	; a748  ................
	defb 0abh,08eh,08dh,08dh,0ach,08eh,08dh,08dh,0abh,0a0h,08fh,08fh,0ach,0a3h,08fh,08fh	; a758  ................
	defb 08dh,08dh,08dh,08eh,08dh,08dh,08dh,08eh,08fh,08fh,08fh,092h,08fh,08fh,08fh,095h	; a768  ................
	defb 056h,07ah,083h,080h,058h,07bh,082h,081h,050h,07ch,080h,083h,051h,056h,081h,082h	; a778  Vz..X{..P|..QV..
	defb 04fh,051h,056h,07ah,050h,04fh,058h,079h,04fh,051h,050h,07bh,051h,051h,054h,07ch	; a788  OQVzPOXyOQP{QQT|
	defb 050h,058h,079h,081h,058h,07bh,07ch,081h,050h,07ch,083h,080h,051h,056h,082h,081h	; a798  PXy.X{|.P|..QV..
	defb 04fh,051h,050h,078h,050h,04fh,058h,07bh,058h,079h,05eh,07ch,054h,07ch,081h,082h	; a7a8  OQPxPOX{Xy^|T|..
	defb 04fh,051h,056h,07ah,051h,051h,058h,07bh,04fh,05ch,050h,078h,050h,051h,058h,07bh	; a7b8  OQVzQQX{O\PxPQX{
	defb 058h,04fh,050h,078h,050h,04fh,058h,07bh,058h,050h,07bh,078h,04fh,04fh,050h,079h	; a7c8  XOPxPOX{XP{xOOPy
	defb 051h,051h,056h,07ah,051h,050h,058h,07bh,04fh,058h,07bh,07ch,05ch,050h,07ch,083h	; a7d8  QQVzQPX{OX{|\P|.
	defb 04fh,058h,079h,081h,058h,07bh,07ch,081h,050h,079h,082h,080h,054h,07ch,080h,083h	; a7e8  OXy.X{|.Py..T|..
	defb 051h,051h,050h,078h,058h,050h,058h,07bh,04fh,058h,07bh,07ch,051h,050h,07ch,082h	; a7f8  QQPxXPX{OX{|QP|.
	defb 081h,080h,083h,052h,083h,081h,055h,04fh,080h,083h,057h,050h,082h,080h,05dh,053h	; a808  ...R..UO..WP..]S
	defb 057h,058h,04fh,04fh,05dh,052h,050h,051h,083h,053h,04fh,051h,055h,050h,050h,058h	; a818  WXOO]RPQ.SOQUPPX
	defb 057h,058h,051h,04fh,05dh,05eh,052h,050h,083h,082h,053h,058h,081h,080h,081h,053h	; a828  WXQO]^RP..SX...S
	defb 057h,058h,04fh,05ch,05dh,052h,050h,04fh,080h,053h,052h,050h,081h,082h,053h,058h	; a838  WXO\]RPO.SRP..SX
	defb 081h,080h,052h,04fh,083h,081h,053h,050h,082h,055h,050h,04fh,055h,050h,058h,051h	; a848  ..RO..SP.UPOUPXQ
	defb 081h,080h,052h,04fh,083h,052h,04fh,050h,080h,053h,050h,04fh,082h,080h,053h,050h	; a858  ..RO.ROP.SPO..SP
	defb 081h,082h,081h,052h,083h,081h,052h,04fh,081h,083h,053h,050h,082h,080h,082h,053h	; a868  ...R..RO..SP...S
	defb 081h,081h,082h,052h,083h,080h,052h,050h,080h,052h,050h,04fh,055h,050h,058h,051h	; a878  ...R..RP.RPOUPXQ
	defb 04fh,051h,04fh,04fh,050h,04fh,050h,04fh,04fh,051h,04fh,051h,050h,04fh,050h,051h	; a888  OQOOPOPOOQOQPOPQ
	defb 04fh,051h,050h,078h,050h,04fh,058h,07bh,050h,058h,07bh,07ch,058h,050h,07ch,075h	; a898  OQPxPOX{PX{|XP|u
	defb 051h,058h,079h,0c5h,051h,050h,078h,0c5h,04fh,058h,07bh,0c5h,051h,050h,07ch,0c5h	; a8a8  QXy.QPx.OX{.QP|.
	defb 04fh,058h,079h,074h,051h,050h,07ch,061h,04fh,058h,056h,07ah,050h,051h,058h,07bh	; a8b8  OXytQP|aOXVzPQX{
	defb 081h,080h,083h,080h,083h,081h,082h,081h,080h,083h,080h,083h,06eh,06eh,06fh,070h	; a8c8  ............nnop
	defb 080h,081h,080h,083h,081h,083h,081h,082h,083h,080h,083h,080h,071h,072h,073h,076h	; a8d8  ............qrsv
	defb 049h,04ah,049h,04ah,027h,027h,028h,049h,049h,04bh,025h,023h,04ah,048h,026h,049h	; a8e8  IJIJ''(IIK%#JH&I
	defb 049h,04bh,025h,04ah,04ah,048h,026h,049h,049h,04bh,025h,023h,04ah,048h,026h,049h	; a8f8  IK%JJH&IIK%#JH&I
	defb 027h,027h,027h,027h,027h,027h,028h,049h,049h,04bh,025h,023h,04ah,048h,026h,049h	; a908  ''''''(IIK%#JH&I
	defb 027h,011h,00ah,0c0h,048h,00bh,00ch,0c0h,024h,00dh,00eh,0c0h,048h,00fh,010h,0c0h	; a918  '...H...$...H...
	defb 04bh,009h,00ah,0c0h,048h,00bh,00ch,0c0h,024h,00dh,00eh,0c0h,048h,00fh,010h,0c0h	; a928  K...H...$...H...
	defb 04bh,001h,002h,0c0h,048h,003h,004h,0c0h,024h,005h,006h,0c0h,048h,007h,008h,0c0h	; a938  K...H...$...H...
	defb 029h,029h,02ah,023h,04ah,049h,04ah,049h,049h,04ah,049h,04ah,029h,029h,029h,029h	; a948  ))*#JIJIIJIJ))))
	defb 024h,001h,002h,0c0h,04bh,003h,004h,0c0h,048h,005h,006h,0c0h,029h,007h,008h,0c0h	; a958  $...K...H...)...
	defb 04ah,048h,025h,049h,049h,04bh,026h,04ah,029h,029h,02ah,023h,04ah,049h,04ah,049h	; a968  JH%IIK&J))*#JIJI
	defb 068h,068h,069h,06ah,062h,062h,063h,064h,080h,083h,080h,083h,082h,080h,081h,082h	; a978  hhijbbcd........
	defb 06bh,06ch,06dh,0c0h,065h,066h,066h,067h,080h,083h,080h,083h,082h,080h,081h,082h	; a988  klm.effg........
	defb 049h,04bh,02bh,0bfh,04ah,048h,042h,0bfh,049h,04bh,042h,0bfh,04ah,048h,042h,0bfh	; a998  IK+.JHB.IKB.JHB.
	defb 049h,04bh,02ch,0bfh,04ah,048h,044h,0bfh,049h,04bh,044h,0bfh,04ah,048h,044h,0bfh	; a9a8  IK,.JHD.IKD.JHD.
	defb 049h,04bh,02dh,0bfh,04ah,048h,043h,0bfh,049h,04bh,043h,0bfh,04ah,048h,043h,0bfh	; a9b8  IK-.JHC.IKC.JHC.
	defb 087h,0adh,0c9h,0c9h,092h,0aeh,0c9h,0c9h,0b1h,0cbh,0cbh,0cbh,0b2h,0cbh,0cbh,0cbh	; a9c8  ................
	defb 0b4h,0c9h,0c9h,0c9h,0b5h,0a0h,0c9h,0c9h,0c9h,0b6h,0cbh,0cbh,08ch,0b7h,0cbh,0cbh	; a9d8  ................
	defb 04bh,043h,038h,0c0h,048h,043h,03ah,03bh,024h,043h,037h,03bh,048h,043h,03ah,03bh	; a9e8  KC8.HC:;$C7;HC:;
	defb 04bh,02bh,037h,03bh,048h,042h,03ah,03bh,024h,042h,037h,03bh,048h,042h,03ah,03bh	; a9f8  K+7;HB:;$B7;HB:;
	defb 04bh,02ch,037h,03bh,048h,044h,03ah,03bh,024h,044h,037h,03bh,048h,044h,03ah,03bh	; aa08  K,7;HD:;$D7;HD:;
	defb 04bh,02dh,037h,03bh,048h,043h,03ah,03bh,024h,043h,037h,03bh,048h,043h,03ah,03bh	; aa18  K-7;HC:;$C7;HC:;
	defb 04bh,02dh,037h,03bh,048h,043h,03ah,03bh,024h,043h,039h,03bh,048h,043h,043h,0c0h	; aa28  K-7;HC:;$C9;HCC.
	defb 0bdh,03eh,041h,081h,0bdh,03ch,04eh,080h,0beh,03dh,04dh,04eh,0beh,03ch,04dh,081h	; aa38  .>A..<N..=MN.<M.
	defb 0bdh,03dh,04dh,04eh,0bdh,03ch,04eh,082h,0beh,03fh,040h,080h,0beh,080h,081h,081h	; aa48  .=MN.<N..?@.....
	defb 0bdh,03dh,013h,014h,0bdh,03ch,015h,016h,0beh,03dh,017h,018h,0beh,03ch,019h,01ah	; aa58  .=...<...=...<..
	defb 0bdh,03dh,01bh,01ch,0bdh,03ch,01dh,01eh,0beh,03dh,01fh,020h,0beh,03ch,021h,022h	; aa68  .=...<...=. .<!"
	defb 0bdh,03dh,07dh,05ah,0bdh,03ch,07eh,05ch,0beh,03dh,07fh,060h,0beh,03ch,080h,081h	; aa78  .=}Z.<~\.=.`.<..
	defb 059h,080h,082h,052h,05bh,081h,052h,04fh,05fh,083h,053h,050h,082h,080h,081h,053h	; aa88  Y..R[.RO_.SP...S
	defb 0bdh,03dh,035h,04eh,0bdh,03ch,046h,04dh,0beh,03dh,046h,04dh,0beh,03ch,046h,04eh	; aa98  .=5N.<FM.=FM.<FN
	defb 0bdh,03dh,034h,04dh,0bdh,03ch,045h,04ch,0beh,03dh,045h,04ch,0beh,03ch,045h,04dh	; aaa8  .=4M.<EL.=EL.<EM
	defb 0bdh,03dh,036h,04dh,0bdh,03ch,047h,04ch,0beh,03dh,047h,04dh,0beh,03ch,047h,04eh	; aab8  .=6M.<GL.=GM.<GN
	defb 0bdh,03dh,04ch,04dh,0bdh,03ch,049h,04ch,0beh,03dh,048h,04dh,0beh,03ch,04ch,04eh	; aac8  .=LM.<IL.=HM.<LN
	defb 0bdh,03dh,030h,04dh,0bdh,03ch,047h,04ch,0beh,03dh,047h,04dh,0beh,03ch,047h,04eh	; aad8  .=0M.<GL.=GM.<GN
	defb 0bdh,03dh,030h,04dh,0bdh,03ch,047h,04ch,0beh,03dh,035h,04dh,0beh,03ch,046h,04eh	; aae8  .=0M.<GL.=5M.<FN
	defb 0bdh,03dh,036h,04dh,0bdh,03ch,047h,04ch,0beh,03dh,047h,04dh,0beh,03ch,033h,04eh	; aaf8  .=6M.<GL.=GM.<3N
	defb 0bdh,03dh,035h,04dh,0bdh,03ch,046h,04ch,0beh,03dh,046h,04dh,0beh,03ch,032h,04eh	; ab08  .=5M.<FL.=FM.<2N
	defb 059h,057h,051h,04fh,05bh,05dh,052h,050h,05fh,082h,053h,058h,082h,080h,081h,053h	; ab18  YWQO[]RP_.SX...S
	defb 059h,080h,082h,052h,05bh,081h,052h,050h,05fh,052h,050h,04fh,055h,050h,058h,051h	; ab28  Y..R[.RP_RPOUPXQ
	defb 0bdh,03dh,04dh,080h,0bdh,03ch,04ch,081h,0beh,03dh,04dh,083h,0beh,03ch,04eh,081h	; ab38  .=M..<L..=M..<N.
	defb 0bdh,03dh,04dh,04eh,0bdh,03ch,04ch,04dh,0beh,03dh,04ch,04dh,0beh,03ch,04dh,04eh	; ab48  .=MN.<LM.=LM.<MN
	defb 081h,080h,083h,080h,083h,081h,082h,084h,080h,083h,080h,085h,082h,080h,081h,086h	; ab58  ................
	defb 087h,0adh,08dh,08dh,092h,0aeh,08dh,08dh,0afh,08fh,08fh,08fh,0b0h,08fh,08fh,08fh	; ab68  ................
	defb 080h,087h,0adh,08dh,084h,092h,0aeh,08dh,085h,0afh,08fh,08fh,086h,0b0h,08fh,08fh	; ab78  ................
	defb 081h,080h,087h,0adh,083h,084h,092h,0aeh,081h,085h,0afh,08fh,082h,086h,0b0h,08fh	; ab88  ................
	defb 081h,080h,081h,087h,083h,081h,084h,092h,080h,083h,085h,0afh,082h,080h,086h,0b0h	; ab98  ................
	defb 0adh,08dh,08dh,08dh,0aeh,08dh,08dh,08dh,08fh,08fh,08fh,08fh,08fh,08fh,08fh,08fh	; aba8  ................
	defb 08dh,08dh,08dh,08dh,08dh,08dh,08dh,08dh,08fh,08fh,08fh,092h,08fh,08fh,08fh,095h	; abb8  ................
	defb 091h,097h,080h,081h,094h,09ah,081h,081h,098h,080h,083h,080h,09bh,081h,082h,081h	; abc8  ................
	defb 08dh,08dh,08dh,091h,08dh,08dh,08dh,094h,08fh,08fh,092h,098h,08fh,08fh,095h,09bh	; abd8  ................
	defb 097h,080h,082h,082h,09ah,081h,083h,082h,080h,083h,080h,083h,081h,082h,081h,082h	; abe8  ................
	defb 08dh,091h,097h,080h,08dh,094h,09ah,081h,092h,098h,080h,082h,095h,09bh,081h,082h	; abf8  ................
	defb 08dh,08dh,091h,097h,08dh,08dh,094h,09ah,08fh,092h,098h,080h,08fh,095h,09bh,081h	; ac08  ................
	defb 081h,080h,083h,082h,082h,081h,082h,081h,080h,083h,080h,080h,082h,080h,081h,085h	; ac18  ................
	defb 080h,0b3h,0b2h,08dh,085h,0b1h,08dh,08dh,0b3h,0b2h,08fh,08fh,0b1h,08fh,08fh,08fh	; ac28  ................
	defb 081h,082h,080h,0b3h,083h,081h,085h,0b1h,080h,080h,0b3h,0b2h,082h,085h,0b1h,08fh	; ac38  ................
	defb 0b2h,08dh,08dh,08dh,08dh,08dh,08dh,08dh,08fh,08fh,08fh,08fh,08fh,08fh,08fh,08fh	; ac48  ................
	defb 08dh,08dh,093h,099h,08dh,096h,09ch,080h,08fh,093h,099h,081h,096h,09ch,080h,082h	; ac58  ................
	defb 08dh,08dh,08dh,08dh,08dh,08dh,08dh,096h,08fh,08fh,08fh,093h,08fh,08fh,096h,09ch	; ac68  ................
	defb 093h,099h,083h,080h,09ch,081h,082h,081h,099h,083h,080h,083h,080h,082h,081h,082h	; ac78  ................
	defb 056h,07ah,080h,0c5h,058h,07bh,082h,0c5h,050h,07ch,081h,0c5h,051h,056h,083h,0c5h	; ac88  Vz..X{..P|..QV..
	defb 04fh,058h,079h,0c5h,058h,07bh,07ch,0c5h,050h,079h,082h,0c5h,054h,07ch,080h,0c5h	; ac98  OXy.X{|.Py..T|..
	defb 050h,058h,079h,0c5h,058h,07bh,07ch,0c5h,050h,07ch,082h,0c5h,051h,056h,080h,0c5h	; aca8  PXy.X{|.P|..QV..
	defb 059h,080h,052h,04fh,05bh,081h,053h,050h,05fh,082h,052h,04fh,080h,055h,050h,051h	; acb8  Y.RO[.SP_.RO.UPQ
	defb 049h,012h,02bh,0bfh,04ah,048h,042h,0bfh,049h,04bh,042h,0bfh,04ah,048h,042h,0bfh	; acc8  I.+.JHB.IKB.JHB.
	defb 049h,04ah,049h,04ah,04ah,049h,04ah,049h,049h,04ah,049h,04ah,04ah,049h,04ah,049h	; acd8  IJIJJIJIIJIJJIJI
	defb 09dh,080h,083h,080h,09eh,081h,082h,081h,09dh,083h,080h,083h,09eh,080h,081h,082h	; ace8  ................
	defb 0bdh,080h,083h,080h,0bdh,081h,082h,081h,0beh,082h,080h,083h,0beh,080h,081h,082h	; acf8  ................
	defb 08dh,0b4h,08bh,080h,08dh,0b5h,0a0h,088h,08fh,08fh,0b6h,089h,08fh,08fh,0b7h,08ah	; ad08  ................
	defb 08dh,08dh,0b4h,08bh,08dh,08dh,0b5h,0a0h,08fh,08fh,08fh,0b6h,08fh,08fh,08fh,0b7h	; ad18  ................
	defb 080h,083h,081h,082h,088h,082h,080h,081h,089h,081h,081h,082h,08ah,080h,083h,081h	; ad28  ................
	defb 08dh,08dh,08dh,0b4h,08dh,08dh,08dh,0b5h,08fh,08fh,08fh,08fh,08fh,08fh,08fh,08fh	; ad38  ................
	defb 08bh,080h,083h,082h,0a0h,088h,082h,080h,0b6h,089h,080h,083h,0b7h,08ah,083h,081h	; ad48  ................
	defb 0b4h,08bh,080h,083h,0b5h,0a0h,088h,081h,08fh,0b6h,089h,081h,08fh,0b7h,08ah,082h	; ad58  ................
	defb 080h,081h,082h,0a5h,082h,080h,081h,0a8h,080h,083h,080h,083h,081h,081h,082h,081h	; ad68  ................
	defb 09fh,08dh,08dh,08dh,0a2h,08dh,08dh,08dh,0a6h,0a0h,08fh,08fh,0a9h,0a3h,08fh,08fh	; ad78  ................
	defb 0a5h,09fh,08dh,08dh,0a8h,0a2h,08dh,08dh,080h,0a6h,0a0h,08fh,081h,0a9h,0a3h,08fh	; ad88  ................
	defb 081h,0a5h,09fh,08dh,082h,0a8h,0a2h,08dh,080h,082h,0a6h,0a0h,083h,080h,0a9h,0a3h	; ad98  ................
	defb 081h,083h,0a5h,09fh,082h,081h,0a8h,0a2h,081h,080h,081h,0a6h,080h,082h,081h,0a9h	; ada8  ................
	defb 08dh,08dh,08dh,08dh,08dh,08dh,08dh,08dh,0a0h,08fh,08fh,08fh,0a3h,08fh,08fh,08fh	; adb8  ................
	defb 08dh,0b9h,0bah,080h,08dh,08dh,0b8h,089h,08fh,08fh,0b9h,0bah,08fh,08fh,08fh,0b8h	; adc8  ................
	defb 081h,080h,082h,081h,080h,081h,083h,080h,082h,083h,082h,083h,089h,080h,081h,082h	; add8  ................
	defb 08dh,08dh,08dh,0b9h,08dh,08dh,08dh,08dh,08fh,08fh,08fh,08fh,08fh,08fh,08fh,08fh	; ade8  ................
	defb 0a7h,0a1h,08dh,08dh,083h,0aah,0a4h,08dh,081h,0a7h,0a1h,08fh,083h,080h,0aah,0a4h	; adf8  ................
	defb 081h,080h,0a7h,0a1h,082h,081h,080h,0aah,083h,081h,082h,0a7h,081h,082h,081h,080h	; ae08  ................
	defb 08dh,08dh,08dh,08dh,0a4h,08dh,08dh,08dh,0a1h,08fh,08fh,08fh,0aah,0a4h,08fh,08fh	; ae18  ................
	defb 0c9h,0c9h,0c9h,0c9h,0c9h,0c9h,0c9h,0c9h,0cbh,0cbh,0cbh,0cbh,0cbh,0cbh,0cbh,0cbh	; ae28  ................
	defb 0bbh,08eh,08dh,08dh,0bbh,08eh,08dh,0c6h,0bch,08eh,08fh,0c8h,0bch,08eh,08fh,08fh	; ae38  ................
	defb 08dh,08dh,08dh,08eh,0c7h,08dh,08dh,08eh,0cah,08fh,08fh,08eh,08fh,08fh,08fh,08eh	; ae48  ................
	defb 0bah,080h,082h,081h,0b8h,089h,081h,083h,0b9h,0bah,080h,082h,08fh,0b8h,089h,081h	; ae58  ................
	defb 055h,056h,07ah,081h,057h,058h,07bh,083h,05dh,05eh,07ch,081h,083h,081h,083h,082h	; ae68  UVz.WX{.]^|.....
	defb 081h,083h,082h,081h,082h,055h,056h,07ah,081h,057h,058h,07bh,083h,05dh,05eh,07ch	; ae78  .....UVz.WX{.]^|
	defb 082h,080h,0b3h,0b2h,081h,085h,0b1h,08dh,080h,0b3h,0b2h,08fh,085h,0b1h,08fh,08fh	; ae88  ................
	defb 081h,080h,082h,080h,083h,081h,081h,085h,080h,083h,080h,0b3h,082h,080h,085h,0b1h	; ae98  ................
	defb 0b3h,0b2h,08dh,08dh,0b1h,08dh,08dh,08dh,0b2h,08fh,08fh,08fh,08fh,08fh,08fh,08fh	; aea8  ................
	defb 0b9h,0bah,080h,081h,08dh,0b8h,089h,080h,08fh,0b9h,0bah,082h,08fh,08fh,0b8h,089h	; aeb8  ................
	defb 08dh,08dh,0b9h,0bah,08dh,08dh,08dh,0b8h,08fh,08fh,08fh,0b9h,08fh,08fh,08fh,08fh	; aec8  ................
	defb 080h,081h,083h,080h,089h,080h,082h,081h,0bah,082h,080h,083h,0b8h,089h,081h,082h	; aed8  ................
	defb 08dh,08dh,08dh,08dh,08dh,08dh,08dh,08dh,08fh,08fh,08fh,08fh,08fh,08fh,08fh,096h	; aee8  ................
	defb 08dh,093h,099h,080h,096h,09ch,082h,081h,093h,099h,080h,083h,09ch,080h,081h,082h	; aef8  ................
	defb 08dh,08dh,08dh,093h,08dh,08dh,096h,09ch,08fh,08fh,093h,099h,08fh,096h,09ch,080h	; af08  ................
	defb 099h,080h,083h,080h,082h,081h,082h,081h,080h,083h,080h,083h,081h,082h,081h,082h	; af18  ................
	defb 081h,080h,080h,0a7h,083h,081h,081h,083h,080h,083h,081h,081h,082h,080h,082h,083h	; af28  ................
	defb 0a1h,08dh,08dh,08dh,0aah,0a4h,08dh,08dh,0a7h,0a1h,08fh,08fh,080h,0aah,0a4h,08fh	; af38  ................
	defb 080h,0a7h,0a1h,08dh,081h,083h,0aah,0a4h,081h,081h,0a7h,0a1h,082h,083h,080h,0aah	; af48  ................
	defb 08dh,08dh,08dh,08dh,08dh,08dh,08dh,08dh,08fh,08fh,08fh,08fh,0a4h,08fh,08fh,08fh	; af58  ................
	defb 0abh,08eh,08dh,08dh,0ach,08eh,08dh,08dh,0abh,08eh,08fh,08fh,0ach,08eh,08fh,08fh	; af68  ................

; ----------------------------------------------------------------------
; DATOS tabla_metatiles: 21 punteros (por (E25C)) a la tabla de metatiles de
;   cada carrera
;   0xaf78..0xafa2  (42 bytes)
DATA_tabla_metatiles:
	defw 07fd8h	; af78
	defw 0a698h	; af7a  -> DATA_metatiles_D
	defw 08ad8h	; af7c
	defw 09698h	; af7e
	defw 09698h	; af80
	defw 09698h	; af82
	defw 09698h	; af84
	defw 09698h	; af86
	defw 08ad8h	; af88
	defw 0a698h	; af8a  -> DATA_metatiles_D
	defw 09698h	; af8c
	defw 09698h	; af8e
	defw 09698h	; af90
	defw 09698h	; af92
	defw 09698h	; af94
	defw 09698h	; af96
	defw 09698h	; af98
	defw 09698h	; af9a
	defw 09698h	; af9c
	defw 09698h	; af9e
	defw 08ad8h	; afa0

; ----------------------------------------------------------------------
; DATOS tabla_piezas: 21 punteros (por (E25C)) a la tabla de piezas de cada
;   carrera
;   0xafa2..0xafcc  (42 bytes)
DATA_tabla_piezas:
	defw 06000h	; afa2
	defw 07848h	; afa4
	defw 06618h	; afa6
	defw 06dc8h	; afa8
	defw 06dc8h	; afaa
	defw 06dc8h	; afac
	defw 06dc8h	; afae
	defw 06dc8h	; afb0
	defw 06618h	; afb2
	defw 07848h	; afb4
	defw 06dc8h	; afb6
	defw 06dc8h	; afb8
	defw 06dc8h	; afba
	defw 06dc8h	; afbc
	defw 06dc8h	; afbe
	defw 06dc8h	; afc0
	defw 06dc8h	; afc2
	defw 06dc8h	; afc4
	defw 06dc8h	; afc6
	defw 06dc8h	; afc8
	defw 06618h	; afca

; ----------------------------------------------------------------------
; DATOS rle_pat_AFCC: patrones RLE: 1 tiles desde el 180 (lista 0x733c)
;   0xafcc..0xafd1  (5 bytes)
DATA_rle_pat_AFCC:
	defb 004h,0f0h,004h,00fh,000h	; afcc

; ----------------------------------------------------------------------
; DATOS rle_pat_AFD1: patrones RLE: 2 tiles desde el 31 (lista 0x66e1)
;   0xafd1..0xafdf  (14 bytes)
DATA_rle_pat_AFD1:
	defb 084h,0ffh,03fh,00fh,003h,005h,000h,083h,0c0h,0f0h,0fch,004h,0ffh,000h	; afd1  ..?...........

; ----------------------------------------------------------------------
; DATOS rle_pat_AFDF: patrones RLE: 2 tiles desde el 31 (lista 0x66e1)
;   0xafdf..0xafe6  (7 bytes)
DATA_rle_pat_AFDF:
	defb 004h,0ffh,008h,000h,004h,0ffh,000h	; afdf

; ----------------------------------------------------------------------
; DATOS rle_pat_AFE6: patrones RLE: 2 tiles desde el 31 (lista 0x66e1)
;   0xafe6..0xaff4  (14 bytes)
DATA_rle_pat_AFE6:
	defb 004h,0ffh,083h,0fch,0f0h,0c0h,005h,000h,084h,003h,00fh,03fh,0ffh,000h	; afe6  ...........?..

; ----------------------------------------------------------------------
; DATOS rle_pat_AFF4: patrones RLE: 3 tiles desde el 41 (tabla85[73])
;   0xaff4..0xb00d  (25 bytes)
DATA_rle_pat_AFF4:
	defb 085h,0ffh,088h,094h,0a2h,0c1h,004h,0ffh,084h,011h,029h,045h,083h,003h,0ffh,088h	; aff4  ..........)E....
	defb 001h,0c7h,0abh,093h,0abh,0c7h,083h,0feh,000h	; b004  .........

; ----------------------------------------------------------------------
; DATOS rle_pat_B00D: patrones RLE: 3 tiles desde el 59 (lista 0x73b8)
;   0xb00d..0xb016  (9 bytes)
DATA_rle_pat_B00D:
	defb 008h,043h,003h,003h,005h,0f0h,008h,001h,000h	; b00d  .C.......

; ----------------------------------------------------------------------
; DATOS rle_pat_B016: patrones RLE: 3 tiles desde el 100 (lista 0x73b8)
;   0xb016..0xb02f  (25 bytes)
DATA_rle_pat_B016:
	defb 090h,07fh,03fh,01fh,00fh,007h,003h,001h,000h,000h,080h,0c0h,0e0h,0f0h,0f8h,0fch	; b016  ..?.............
	defb 0feh,004h,0ffh,084h,0fbh,0bfh,0ffh,0ffh,000h	; b026  .........

; ----------------------------------------------------------------------
; DATOS rle_pat_B02F: patrones RLE: 1 tiles desde el 187 (tabla85[77])
;   0xb02f..0xb032  (3 bytes)
DATA_rle_pat_B02F:
	defb 008h,0ffh,000h	; b02f

; ----------------------------------------------------------------------
; DATOS rle_pat_B032: patrones RLE: 10 tiles desde el 44 (lista 0x67b2)
;   0xb032..0xb06f  (61 bytes)
DATA_rle_pat_B032:
	defb 088h,0ffh,000h,000h,044h,066h,080h,0c4h,006h,004h,00fh,084h,010h,018h,044h,066h	; b032  ....Df........Df
	defb 003h,000h,003h,0f0h,092h,040h,060h,0fdh,07fh,0ffh,0ffh,0fbh,03fh,00fh,003h,0ffh	; b042  .....@`.....?...
	defb 0fbh,0ffh,0ffh,0bfh,0ffh,0fdh,0ffh,008h,001h,081h,000h,007h,0ffh,003h,0f0h,005h	; b052  ................
	defb 0ffh,003h,000h,082h,0f0h,00fh,008h,000h,083h,0c0h,0f0h,0fch,000h	; b062  .............

; ----------------------------------------------------------------------
; DATOS rle_pat_B06F: patrones RLE: 5 tiles desde el 54 (lista 0x67b2)
;   0xb06f..0xb092  (35 bytes)
DATA_rle_pat_B06F:
	defb 081h,00fh,007h,000h,003h,00fh,088h,070h,07eh,07eh,03eh,00ch,000h,0e0h,0fch,005h	; b06f  .......p~~>.....
	defb 0ffh,090h,003h,070h,07eh,07eh,03eh,00ch,0c1h,0f3h,003h,070h,07eh,07eh,03eh,00ch	; b07f  ...p~~>....p~~>.
	defb 041h,043h,000h	; b08f

; ----------------------------------------------------------------------
; DATOS rle_pat_B092: patrones RLE: 10 tiles desde el 44 (lista 0x67b2)
;   0xb092..0xb0ce  (60 bytes)
DATA_rle_pat_B092:
	defb 097h,0ffh,000h,000h,044h,066h,080h,0c4h,006h,0ffh,000h,000h,044h,066h,080h,0c4h	; b092  ....Df......Df..
	defb 006h,0ffh,000h,000h,044h,066h,080h,0c4h,011h,006h,006h,001h,002h,000h,098h,010h	; b0a2  ....Df..........
	defb 018h,042h,063h,000h,0ffh,000h,000h,010h,018h,042h,063h,000h,0ffh,000h,000h,010h	; b0b2  .Bc......Bc.....
	defb 018h,042h,063h,000h,0ffh,000h,000h,006h,0ffh,002h,000h,000h	; b0c2  .Bc.........

; ----------------------------------------------------------------------
; DATOS rle_pat_B0CE: patrones RLE: 5 tiles desde el 54 (lista 0x67b2)
;   0xb0ce..0xb0f1  (35 bytes)
DATA_rle_pat_B0CE:
	defb 081h,0fdh,007h,07fh,002h,0ffh,082h,003h,03ch,003h,07eh,081h,03ch,006h,0ffh,002h	; b0ce  ........<.~.<...
	defb 000h,082h,043h,03ch,003h,07eh,085h,03ch,001h,003h,043h,03ch,003h,07eh,083h,03ch	; b0de  ..C<.~.<..C<.~.<
	defb 001h,043h,000h	; b0ee

; ----------------------------------------------------------------------
; DATOS rle_pat_B0F1: patrones RLE: 10 tiles desde el 44 (lista 0x67b2)
;   0xb0f1..0xb122  (49 bytes)
DATA_rle_pat_B0F1:
	defb 00eh,0ffh,082h,0f0h,000h,004h,0ffh,087h,0f0h,000h,040h,060h,0fch,0f0h,0c0h,00dh	; b0f1  ..........@`....
	defb 000h,008h,001h,085h,05ah,063h,010h,018h,044h,003h,066h,087h,062h,010h,05ah,062h	; b101  ....Zc..D.f.b.Zb
	defb 000h,00fh,0f0h,004h,000h,082h,00fh,0f0h,003h,000h,083h,0fch,0f0h,0c0h,005h,000h	; b111  ................
	defb 000h	; b121

; ----------------------------------------------------------------------
; DATOS rle_pat_B122: patrones RLE: 5 tiles desde el 54 (lista 0x67b2)
;   0xb122..0xb147  (37 bytes)
DATA_rle_pat_B122:
	defb 004h,0ffh,088h,0fch,0f0h,0c0h,000h,0fch,0f0h,0c0h,03ch,003h,07eh,081h,070h,006h	; b122  ..........<.~.p.
	defb 0ffh,092h,0fch,0e0h,041h,00ch,03eh,07eh,07eh,070h,003h,003h,041h,00ch,03eh,07eh	; b132  ....A.>~~p..A.>~
	defb 07eh,070h,003h,003h,000h	; b142

; ----------------------------------------------------------------------
; DATOS rle_pat_B147: patrones RLE: 2 tiles desde el 107 (lista 0x69d9)
;   0xb147..0xb14a  (3 bytes)
DATA_rle_pat_B147:
	defb 010h,0f0h,000h	; b147

; ----------------------------------------------------------------------
; DATOS rle_pat_B14A: patrones RLE: 8 tiles desde el 111 (lista 0x69d9)
;   0xb14a..0xb180  (54 bytes)
DATA_rle_pat_B14A:
	defb 004h,00fh,004h,01fh,084h,0ffh,0efh,0ffh,0ffh,004h,001h,002h,00fh,002h,01fh,002h	; b14a  ................
	defb 03fh,002h,07fh,088h,000h,001h,003h,007h,00fh,01fh,03fh,07fh,004h,0c0h,004h,080h	; b15a  ?.........?.....
	defb 004h,0fch,004h,0f8h,002h,0ffh,002h,0feh,002h,0fch,002h,0f8h,088h,0ffh,0feh,0fch	; b16a  ................
	defb 0f8h,0f0h,0e0h,0c0h,080h,000h	; b17a

; ----------------------------------------------------------------------
; DATOS rle_pat_B180: patrones RLE: 8 tiles desde el 127 (lista 0x69d9)
;   0xb180..0xb1b6  (54 bytes)
DATA_rle_pat_B180:
	defb 004h,007h,004h,003h,004h,07fh,004h,03fh,002h,007h,002h,003h,002h,001h,002h,000h	; b180  .......?........
	defb 088h,07fh,03fh,01fh,00fh,007h,003h,001h,000h,004h,0feh,002h,0ffh,082h,0efh,0ffh	; b190  ..?.............
	defb 004h,0e0h,004h,0f0h,002h,080h,002h,0c0h,002h,0e0h,002h,0f0h,088h,080h,0c0h,0e0h	; b1a0  ................
	defb 0f0h,0f8h,0fch,0feh,0ffh,000h	; b1b0

; ----------------------------------------------------------------------
; DATOS rle_pat_B1B6: patrones RLE: 8 tiles desde el 143 (lista 0x69d9)
;   0xb1b6..0xb1e9  (51 bytes)
DATA_rle_pat_B1B6:
	defb 004h,0e0h,004h,0c0h,004h,0feh,004h,0fch,002h,0e0h,002h,0c0h,002h,080h,002h,000h	; b1b6  ................
	defb 088h,0ffh,0feh,0fch,0f8h,0f0h,0e0h,0c0h,080h,004h,07fh,004h,0ffh,004h,007h,004h	; b1c6  ................
	defb 00fh,002h,001h,002h,003h,002h,007h,002h,00fh,088h,000h,001h,003h,007h,00fh,01fh	; b1d6  ................
	defb 03fh,07fh,000h	; b1e6

; ----------------------------------------------------------------------
; DATOS rle_pat_B1E9: patrones RLE: 8 tiles desde el 159 (lista 0x69d9)
;   0xb1e9..0xb21c  (51 bytes)
DATA_rle_pat_B1E9:
	defb 004h,00fh,004h,01fh,004h,000h,004h,001h,002h,00fh,002h,01fh,002h,03fh,002h,07fh	; b1e9  .............?..
	defb 088h,001h,003h,007h,00fh,01fh,03fh,07fh,0ffh,004h,0c0h,004h,080h,004h,0fch,004h	; b1f9  ......?.........
	defb 0f8h,002h,0ffh,002h,0feh,002h,0fch,002h,0f8h,088h,0feh,0fch,0f8h,0f0h,0e0h,0c0h	; b209  ................
	defb 080h,000h,000h	; b219

; ----------------------------------------------------------------------
; DATOS rle_pat_B21C: patrones RLE: 3 tiles desde el 80 (tabla85[74])
;   0xb21c..0xb22b  (15 bytes)
DATA_rle_pat_B21C:
	defb 00ch,000h,084h,003h,00fh,03fh,0ffh,004h,000h,084h,0c0h,0f0h,0fch,0ffh,000h	; b21c  .....?.........

; ----------------------------------------------------------------------
; DATOS rle_pat_B22B: patrones RLE: 10 tiles desde el 181 (tabla85[75])
;   0xb22b..0xb277  (76 bytes)
DATA_rle_pat_B22B:
	defb 083h,003h,00fh,03fh,006h,0ffh,08eh,0f1h,0f8h,0f8h,0fah,0fah,0f1h,0ffh,0ffh,0e1h	; b22b  ...?............
	defb 0c3h,0d3h,013h,033h,021h,003h,0ffh,091h,006h,033h,0c3h,033h,002h,0ffh,0ffh,0feh	; b23b  ...3!....3.3....
	defb 027h,003h,013h,03fh,03eh,0ffh,0ffh,031h,038h,003h,039h,081h,010h,003h,0ffh,081h	; b24b  '..?>..18.9.....
	defb 020h,003h,024h,081h,020h,003h,0ffh,085h,089h,0c0h,0c4h,0cfh,08fh,003h,0ffh,081h	; b25b   .$. ...........
	defb 083h,003h,093h,085h,083h,0ffh,0c0h,0f0h,0fch,005h,0ffh,000h	; b26b  ............

; ----------------------------------------------------------------------
; DATOS rle_pat_B277: patrones RLE: 3 tiles desde el 80 (lista 0x72aa)
;   0xb277..0xb289  (18 bytes)
DATA_rle_pat_B277:
	defb 00ah,0ffh,08eh,0fch,080h,003h,0fch,0f8h,0ffh,0ffh,01fh,01fh,03fh,03fh,07fh,07fh	; b277  ............??..
	defb 0ffh,000h	; b287

; ----------------------------------------------------------------------
; DATOS rle_pat_B289: patrones RLE: 10 tiles desde el 181 (lista 0x6a82)
;   0xb289..0xb2d9  (80 bytes)
DATA_rle_pat_B289:
	defb 087h,0ffh,003h,007h,0f8h,0e0h,007h,01fh,004h,0ffh,082h,01fh,03fh,004h,0ffh,0bfh	; b289  ............?...
	defb 0c7h,0c6h,080h,081h,010h,01ch,0ffh,0ffh,087h,01ch,078h,0f0h,070h,018h,0ffh,0ffh	; b299  ..........x.p...
	defb 001h,030h,070h,0e1h,0c3h,00fh,0ffh,0ffh,0c7h,0c3h,081h,088h,01ch,01eh,0ffh,0ffh	; b2a9  .0p.............
	defb 08fh,08eh,01ch,018h,031h,023h,0ffh,0ffh,00fh,00fh,047h,007h,0e3h,0e3h,0ffh,0ffh	; b2b9  ....1#....G.....
	defb 0c3h,0c3h,081h,088h,018h,01dh,0ffh,0ffh,0c3h,083h,006h,046h,08ch,08ch,0ffh,000h	; b2c9  ...........F....

; ----------------------------------------------------------------------
; DATOS rle_pat_B2D9: patrones RLE: 3 tiles desde el 80 (lista 0x70cd)
;   0xb2d9..0xb2e8  (15 bytes)
DATA_rle_pat_B2D9:
	defb 009h,0ffh,081h,0f0h,004h,0e0h,083h,0f0h,0ffh,0ffh,006h,007h,081h,0ffh,000h	; b2d9  ...............

; ----------------------------------------------------------------------
; DATOS rle_pat_B2E8: patrones RLE: 10 tiles desde el 181 (lista 0x6a36)
;   0xb2e8..0xb33a  (82 bytes)
DATA_rle_pat_B2E8:
	defb 087h,0ffh,000h,0f0h,0f0h,0ffh,0f0h,000h,003h,0ffh,085h,070h,043h,0fch,041h,0c0h	; b2e8  ...........pC.A.
	defb 003h,0ffh,099h,003h,0e0h,000h,0e0h,000h,0ffh,0ffh,0e0h,083h,0c0h,0f8h,087h,0e0h	; b2f8  ................
	defb 0ffh,0ffh,007h,0e1h,01fh,003h,081h,007h,0ffh,0ffh,0e0h,000h,003h,0e0h,081h,0f0h	; b308  ................
	defb 003h,0ffh,081h,010h,003h,0f0h,081h,010h,003h,0ffh,085h,061h,00fh,03fh,07fh,07fh	; b318  ...........a.?..
	defb 003h,0ffh,081h,0c0h,003h,007h,081h,0c0h,003h,0ffh,081h,00fh,003h,083h,082h,00fh	; b328  ................
	defb 0ffh,000h	; b338

; ----------------------------------------------------------------------
; DATOS rle_pat_B33A: patrones RLE: 3 tiles desde el 80 (lista 0x7354)
;   0xb33a..0xb34b  (17 bytes)
DATA_rle_pat_B33A:
	defb 009h,0ffh,08bh,080h,0e0h,0e0h,0c1h,0c1h,000h,0ffh,0ffh,007h,083h,007h,004h,0ffh	; b33a  ................
	defb 000h	; b34a

; ----------------------------------------------------------------------
; DATOS rle_pat_B34B: patrones RLE: 10 tiles desde el 181 (lista 0x6a49)
;   0xb34b..0xb39b  (80 bytes)
DATA_rle_pat_B34B:
	defb 0afh,0ffh,001h,0e0h,0e0h,0c0h,0c1h,007h,0ffh,0ffh,0c0h,0e0h,0c1h,0c1h,083h,080h	; b34b  ................
	defb 0ffh,0ffh,040h,0f1h,0e3h,0e3h,0c7h,00fh,0ffh,0ffh,0c1h,0e0h,0c0h,0c4h,08eh,007h	; b35b  ..@.............
	defb 0ffh,0ffh,0c0h,0e1h,043h,003h,007h,007h,0ffh,0ffh,0c0h,0e0h,0c1h,0c1h,083h,080h	; b36b  ....C...........
	defb 005h,0ffh,09ch,0f9h,0e1h,003h,0ffh,0ffh,0c0h,083h,083h,007h,007h,080h,0ffh,0ffh	; b37b  ................
	defb 006h,083h,083h,003h,007h,01ch,0ffh,0ffh,000h,083h,080h,007h,007h,003h,0ffh,000h	; b38b  ................

; ----------------------------------------------------------------------
; DATOS rle_pat_B39B: patrones RLE: 2 tiles desde el 42 (tabla85[78])
;   0xb39b..0xb39e  (3 bytes)
DATA_rle_pat_B39B:
	defb 010h,060h,000h	; b39b

; ----------------------------------------------------------------------
; DATOS rle_pat_B39E: patrones RLE: 1 tiles desde el 82 (tabla85[79])
;   0xb39e..0xb3a3  (5 bytes)
DATA_rle_pat_B39E:
	defb 004h,0ffh,004h,000h,000h	; b39e

; ----------------------------------------------------------------------
; DATOS rle_pat_B3A3: patrones RLE: 1 tiles desde el 81 (tabla85[81])
;   0xb3a3..0xb3a8  (5 bytes)
DATA_rle_pat_B3A3:
	defb 004h,000h,004h,0ffh,000h	; b3a3

; ----------------------------------------------------------------------
; DATOS rle_pat_B3A8: patrones RLE: 3 tiles desde el 190 (lista 0x7388)
;   0xb3a8..0xb3b6  (14 bytes)
DATA_rle_pat_B3A8:
	defb 008h,060h,088h,0ffh,042h,010h,081h,020h,084h,031h,04bh,008h,060h,000h	; b3a8  .`..B.. .1K.`.

; ----------------------------------------------------------------------
; DATOS rle_pat_B3B6: patrones RLE: 1 tiles desde el 193 (lista 0x7388)
;   0xb3b6..0xb3c0  (10 bytes)
DATA_rle_pat_B3B6:
	defb 002h,0ffh,002h,0feh,084h,0fch,0f8h,0e0h,000h,000h	; b3b6  ..........

; ----------------------------------------------------------------------
; DATOS rle_pat_B3C0: patrones RLE: 4 tiles desde el 103 (lista 0x73b8)
;   0xb3c0..0xb3e2  (34 bytes)
DATA_rle_pat_B3C0:
	defb 0a0h,0ffh,0efh,0ffh,0bfh,0ffh,0fdh,0dfh,0f7h,075h,0dfh,0bah,0efh,07bh,0dfh,0b6h	; b3c0  .........u...{..
	defb 0dfh,0ffh,0ffh,0bfh,0fbh,0ffh,0ffh,07fh,0f7h,0bah,0efh,0bdh,0ffh,0d7h,07dh,0dfh	; b3d0  ..............}.
	defb 0b5h,000h	; b3e0

; ----------------------------------------------------------------------
; DATOS rle_pat_B3E2: patrones RLE: 6 tiles desde el 35 (lista 0x719e)
;   0xb3e2..0xb411  (47 bytes)
DATA_rle_pat_B3E2:
	defb 096h,0efh,0c6h,0e0h,08fh,0d9h,083h,071h,0c6h,0ffh,01fh,09fh,06fh,03fh,01fh,01fh	; b3e2  .......q....o?..
	defb 0efh,094h,0a4h,0a4h,066h,099h,0cdh,003h,0ffh,092h,0e3h,041h,080h,0c0h,070h,03ch	; b3f2  ....f......A..p<
	defb 00ch,0bfh,0fbh,0ffh,0ffh,07fh,0f7h,0ffh,0ffh,081h,081h,0e3h,005h,0ffh,000h	; b402  ...............

; ----------------------------------------------------------------------
; DATOS rle_pat_B411: patrones RLE: 8 tiles desde el 9 (lista 0x71d4)
;   0xb411..0xb449  (56 bytes)
DATA_rle_pat_B411:
	defb 081h,00fh,005h,000h,085h,003h,01ch,0ffh,0ffh,00fh,004h,000h,0a0h,0c0h,020h,024h	; b411  .............. $
	defb 04ah,048h,044h,042h,040h,044h,030h,008h,008h,004h,004h,022h,052h,04ah,02ah,028h	; b421  JHDB@D0...."RJ*(
	defb 014h,012h,008h,006h,001h,000h,02ah,012h,002h,004h,004h,018h,0e0h,006h,000h,083h	; b431  ......*.........
	defb 0f0h,0ffh,0ffh,007h,000h,081h,0f0h,000h	; b441  ........

; ----------------------------------------------------------------------
; DATOS rle_pat_B449: patrones RLE: 8 tiles desde el 9 (lista 0x71d4)
;   0xb449..0xb47b  (50 bytes)
DATA_rle_pat_B449:
	defb 002h,0ffh,006h,000h,002h,0ffh,006h,000h,0a0h,003h,00ch,010h,026h,028h,048h,046h	; b449  ............&(HF
	defb 040h,0c0h,030h,008h,004h,004h,002h,032h,04ah,040h,046h,048h,028h,026h,010h,00ch	; b459  @.0....2J@FH(&..
	defb 003h,04ah,032h,002h,004h,004h,008h,030h,0c0h,007h,000h,081h,0ffh,007h,000h,081h	; b469  .J2....0........
	defb 0ffh,000h	; b479

; ----------------------------------------------------------------------
; DATOS rle_pat_B47B: patrones RLE: 8 tiles desde el 9 (lista 0x71d4)
;   0xb47b..0xb4b3  (56 bytes)
DATA_rle_pat_B47B:
	defb 002h,0ffh,081h,0f0h,005h,000h,081h,0f0h,008h,000h,0a1h,001h,006h,008h,012h,014h	; b47b  ................
	defb 028h,02ah,000h,0e0h,018h,004h,004h,002h,012h,02ah,044h,040h,042h,044h,048h,04ah	; b48b  (*.......*D@BDHJ
	defb 024h,020h,04ah,052h,022h,004h,004h,008h,008h,030h,01ch,003h,005h,000h,082h,00fh	; b49b  $ JR"....0......
	defb 0c0h,004h,000h,083h,00fh,0ffh,0ffh,000h	; b4ab  ........

; ----------------------------------------------------------------------
; DATOS rle_pat_B4B3: patrones RLE: 1 tiles desde el 77 (tabla85[0])
;   0xb4b3..0xb4bd  (10 bytes)
DATA_rle_pat_B4B3:
	defb 088h,06dh,025h,091h,049h,0dbh,049h,093h,0b7h,000h	; b4b3  .m%.I.I...

; ----------------------------------------------------------------------
; DATOS rle_pat_B4BD: patrones RLE: 2 tiles desde el 15 (tabla85[4])
;   0xb4bd..0xb4cf  (18 bytes)
DATA_rle_pat_B4BD:
	defb 090h,07fh,03bh,039h,079h,0dbh,0cfh,0cfh,0dfh,0bfh,060h,09fh,0b7h,0f3h,0f3h,0f7h	; b4bd  ..;9y.....`.....
	defb 0ffh,000h	; b4cd

; ----------------------------------------------------------------------
; DATOS rle_pat_B4CF: patrones RLE: 7 tiles desde el 86 (lista 0x68cf)
;   0xb4cf..0xb509  (58 bytes)
DATA_rle_pat_B4CF:
	defb 0b8h,0f8h,0d1h,03fh,053h,0bah,06ah,065h,02ch,06bh,0bch,0dbh,037h,05fh,0e8h,005h	; b4cf  ...?S.je,k..7_..
	defb 0fdh,094h,0bch,058h,0a8h,070h,001h,003h,02fh,0e6h,06eh,03fh,089h,06dh,0dbh,076h	; b4df  ...X.p../.n?.m.v
	defb 0cch,01fh,08bh,0fch,0cah,05dh,056h,0a6h,034h,06bh,0bch,0dbh,037h,05fh,0e8h,005h	; b4ef  .....]V.4k..7_..
	defb 0fdh,065h,069h,09bh,0a8h,050h,074h,0c0h,028h,000h	; b4ff  .ei..Pt.(.

; ----------------------------------------------------------------------
; DATOS rle_col_B509: colores RLE: 1 tiles desde el 180 (lista 0x733c)
;   0xb509..0xb50c  (3 bytes)
DATA_rle_col_B509:
	defb 008h,01fh,000h	; b509

; ----------------------------------------------------------------------
; DATOS rle_col_B50C: colores RLE: 2 tiles desde el 31 (lista 0x6673)
;   0xb50c..0xb50f  (3 bytes)
DATA_rle_col_B50C:
	defb 010h,0c4h,000h	; b50c

; ----------------------------------------------------------------------
; DATOS rle_col_B50F: colores RLE: 2 tiles desde el 33 (lista 0x66e1)
;   0xb50f..0xb512  (3 bytes)
DATA_rle_col_B50F:
	defb 010h,0c6h,000h	; b50f

; ----------------------------------------------------------------------
; DATOS rle_col_B512: colores RLE: 3 tiles desde el 41 (tabla85[73])
;   0xb512..0xb524  (18 bytes)
DATA_rle_col_B512:
	defb 082h,0ffh,0f5h,004h,0f1h,084h,0eeh,011h,0f1h,0f5h,004h,0f1h,082h,0eeh,011h,008h	; b512  ................
	defb 0e1h,000h	; b522

; ----------------------------------------------------------------------
; DATOS rle_col_B524: colores RLE: 3 tiles desde el 59 (lista 0x7354)
;   0xb524..0xb52d  (9 bytes)
DATA_rle_col_B524:
	defb 008h,0e1h,003h,061h,005h,0c6h,008h,0fch,000h	; b524  ...a.....

; ----------------------------------------------------------------------
; DATOS rle_col_B52D: colores RLE: 3 tiles desde el 100 (tabla85[76])
;   0xb52d..0xb534  (7 bytes)
DATA_rle_col_B52D:
	defb 010h,0c1h,003h,010h,005h,0c2h,000h	; b52d

; ----------------------------------------------------------------------
; DATOS rle_col_B534: colores RLE: 1 tiles desde el 187 (tabla85[77])
;   0xb534..0xb537  (3 bytes)
DATA_rle_col_B534:
	defb 008h,011h,000h	; b534

; ----------------------------------------------------------------------
; DATOS rle_col_B537: colores RLE: 1 tiles desde el 194 (lista 0x6a49)
;   0xb537..0xb53a  (3 bytes)
DATA_rle_col_B537:
	defb 008h,044h,000h	; b537

; ----------------------------------------------------------------------
; DATOS rle_col_B53A: colores RLE: 1 tiles desde el 138 (lista 0x6dea)
;   0xb53a..0xb53d  (3 bytes)
DATA_rle_col_B53A:
	defb 008h,0eeh,000h	; b53a

; ----------------------------------------------------------------------
; DATOS rle_col_B53D: colores RLE: 1 tiles desde el 139 (lista 0x6dea)
;   0xb53d..0xb540  (3 bytes)
DATA_rle_col_B53D:
	defb 008h,0ffh,000h	; b53d

; ----------------------------------------------------------------------
; DATOS rle_col_B540: colores RLE: 1 tiles desde el 140 (lista 0x6dea)
;   0xb540..0xb543  (3 bytes)
DATA_rle_col_B540:
	defb 008h,099h,000h	; b540

; ----------------------------------------------------------------------
; DATOS rle_col_B543: colores RLE: 1 tiles desde el 194 (lista 0x733c)
;   0xb543..0xb546  (3 bytes)
DATA_rle_col_B543:
	defb 008h,055h,000h	; b543

; ----------------------------------------------------------------------
; DATOS rle_col_B546: colores RLE: 10 tiles desde el 44 (lista 0x671e)
;   0xb546..0xb575  (47 bytes)
DATA_rle_col_B546:
	defb 003h,0f1h,08dh,0c1h,041h,071h,091h,0c1h,0cch,0cfh,0f1h,011h,0a1h,081h,051h,0a1h	; b546  ....Aq........Q.
	defb 004h,0fch,084h,01fh,011h,091h,061h,005h,0c2h,003h,0c6h,008h,0c2h,081h,0fch,007h	; b556  ......a.........
	defb 0ech,008h,0efh,082h,011h,0f1h,006h,0efh,004h,0f1h,004h,0feh,008h,0e4h,000h	; b566  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_B575: colores RLE: 5 tiles desde el 54 (lista 0x671e)
;   0xb575..0xb593  (30 bytes)
DATA_rle_col_B575:
	defb 008h,0c6h,002h,0fch,003h,0f1h,083h,051h,041h,041h,008h,0e4h,086h,0e1h,0f1h,0f1h	; b575  .......QAA......
	defb 051h,041h,041h,003h,0e1h,002h,0f1h,085h,051h,041h,041h,0e1h,0e1h,000h	; b585  QAA.....QAA...

; ----------------------------------------------------------------------
; DATOS rle_col_B593: colores RLE: 10 tiles desde el 44 (lista 0x671e)
;   0xb593..0xb5c9  (54 bytes)
DATA_rle_col_B593:
	defb 003h,0f1h,085h,0c1h,041h,071h,091h,0c1h,003h,0f1h,085h,0c1h,041h,071h,091h,0c1h	; b593  ....Aq......Aq..
	defb 003h,0f1h,085h,0c1h,041h,071h,091h,0c1h,008h,066h,008h,011h,008h,0fch,084h,081h	; b5a3  ....Aq...f......
	defb 0a1h,0f1h,081h,004h,0f1h,084h,081h,0a1h,0f1h,081h,004h,0f1h,084h,081h,0a1h,0f1h	; b5b3  ................
	defb 081h,004h,0f1h,008h,041h,000h	; b5c3

; ----------------------------------------------------------------------
; DATOS rle_col_B5C9: colores RLE: 5 tiles desde el 54 (lista 0x671e)
;   0xb5c9..0xb5e8  (31 bytes)
DATA_rle_col_B5C9:
	defb 002h,0c2h,006h,066h,003h,0e1h,084h,041h,051h,0f1h,051h,009h,041h,086h,0e1h,041h	; b5c9  ...f...AQ.Q.A..A
	defb 051h,0f1h,051h,041h,003h,0e1h,087h,041h,051h,0f1h,051h,041h,0e1h,0e1h,000h	; b5d9  Q.QA...AQ.QA...

; ----------------------------------------------------------------------
; DATOS rle_col_B5E8: colores RLE: 10 tiles desde el 44 (lista 0x671e)
;   0xb5e8..0xb605  (29 bytes)
DATA_rle_col_B5E8:
	defb 016h,0f1h,082h,0c1h,041h,008h,0f6h,008h,0c1h,008h,0fch,08ch,081h,0a1h,0e1h,051h	; b5e8  ....A..........Q
	defb 061h,091h,011h,0ffh,061h,091h,0e1h,071h,00ch,0f1h,008h,041h,000h	; b5f8  a...a..q...A.

; ----------------------------------------------------------------------
; DATOS rle_col_B605: colores RLE: 5 tiles desde el 54 (lista 0x678d)
;   0xb605..0xb623  (30 bytes)
DATA_rle_col_B605:
	defb 008h,0f6h,003h,0f1h,002h,041h,083h,051h,0f1h,0f1h,008h,041h,086h,0e1h,041h,041h	; b605  .....A.Q...A..AA
	defb 051h,0f1h,0f1h,003h,0e1h,002h,041h,085h,051h,0f1h,0f1h,0e1h,0e1h,000h	; b615  Q.....A.Q.....

; ----------------------------------------------------------------------
; DATOS rle_col_B623: colores RLE: 2 tiles desde el 107 (lista 0x68e5)
;   0xb623..0xb628  (5 bytes)
DATA_rle_col_B623:
	defb 008h,0cfh,008h,0c6h,000h	; b623

; ----------------------------------------------------------------------
; DATOS rle_col_B628: colores RLE: 8 tiles desde el 111 (lista 0x68e5)
;   0xb628..0xb631  (9 bytes)
DATA_rle_col_B628:
	defb 008h,0fch,004h,0c2h,014h,0fch,020h,0c6h,000h	; b628  ...... ..

; ----------------------------------------------------------------------
; DATOS rle_col_B631: colores RLE: 8 tiles desde el 127 (lista 0x68e5)
;   0xb631..0xb63a  (9 bytes)
DATA_rle_col_B631:
	defb 020h,0fch,004h,0c6h,004h,0c2h,018h,0c6h,000h	; b631   ........

; ----------------------------------------------------------------------
; DATOS rle_col_B63A: colores RLE: 8 tiles desde el 143 (lista 0x69d9)
;   0xb63a..0xb63f  (5 bytes)
DATA_rle_col_B63A:
	defb 020h,0feh,020h,0e6h,000h	; b63a

; ----------------------------------------------------------------------
; DATOS rle_col_B63F: colores RLE: 8 tiles desde el 159 (lista 0x69d9)
;   0xb63f..0xb648  (9 bytes)
DATA_rle_col_B63F:
	defb 020h,0feh,010h,0e6h,002h,0eeh,00eh,0e6h,000h	; b63f   ........

; ----------------------------------------------------------------------
; DATOS rle_col_B648: colores RLE: 3 tiles desde el 80 (tabla85[74])
;   0xb648..0xb64b  (3 bytes)
DATA_rle_col_B648:
	defb 018h,0f6h,000h	; b648

; ----------------------------------------------------------------------
; DATOS rle_col_B64B: colores RLE: 10 tiles desde el 181 (tabla85[75])
;   0xb64b..0xb652  (7 bytes)
DATA_rle_col_B64B:
	defb 008h,0f6h,040h,0f1h,008h,0f6h,000h	; b64b

; ----------------------------------------------------------------------
; DATOS rle_col_B652: colores RLE: 3 tiles desde el 80 (lista 0x72aa)
;   0xb652..0xb65b  (9 bytes)
DATA_rle_col_B652:
	defb 008h,0f6h,005h,0f9h,003h,0f6h,008h,0f5h,000h	; b652  .........

; ----------------------------------------------------------------------
; DATOS rle_col_B65B: colores RLE: 10 tiles desde el 181 (lista 0x6a82)
;   0xb65b..0xb662  (7 bytes)
DATA_rle_col_B65B:
	defb 003h,0f9h,00dh,0f6h,040h,0f5h,000h	; b65b

; ----------------------------------------------------------------------
; DATOS rle_col_B662: colores RLE: 3 tiles desde el 80 (lista 0x7156)
;   0xb662..0xb66b  (9 bytes)
DATA_rle_col_B662:
	defb 008h,046h,005h,049h,003h,046h,008h,04fh,000h	; b662  .F.I.F.O.

; ----------------------------------------------------------------------
; DATOS rle_col_B66B: colores RLE: 10 tiles desde el 181 (lista 0x6a5c)
;   0xb66b..0xb672  (7 bytes)
DATA_rle_col_B66B:
	defb 003h,049h,00dh,046h,040h,04fh,000h	; b66b

; ----------------------------------------------------------------------
; DATOS rle_col_B672: colores RLE: 3 tiles desde el 80 (lista 0x70cd)
;   0xb672..0xb675  (3 bytes)
DATA_rle_col_B672:
	defb 018h,0f6h,000h	; b672

; ----------------------------------------------------------------------
; DATOS rle_col_B675: colores RLE: 10 tiles desde el 181 (lista 0x6a36)
;   0xb675..0xb678  (3 bytes)
DATA_rle_col_B675:
	defb 050h,0f6h,000h	; b675

; ----------------------------------------------------------------------
; DATOS rle_col_B678: colores RLE: 3 tiles desde el 80 (lista 0x7354)
;   0xb678..0xb67b  (3 bytes)
DATA_rle_col_B678:
	defb 018h,0a1h,000h	; b678

; ----------------------------------------------------------------------
; DATOS rle_col_B67B: colores RLE: 10 tiles desde el 181 (lista 0x6a49)
;   0xb67b..0xb67e  (3 bytes)
DATA_rle_col_B67B:
	defb 050h,0a1h,000h	; b67b

; ----------------------------------------------------------------------
; DATOS rle_col_B67E: colores RLE: 3 tiles desde el 80 (lista 0x7238)
;   0xb67e..0xb681  (3 bytes)
DATA_rle_col_B67E:
	defb 018h,04fh,000h	; b67e

; ----------------------------------------------------------------------
; DATOS rle_col_B681: colores RLE: 10 tiles desde el 181 (lista 0x6a6f)
;   0xb681..0xb684  (3 bytes)
DATA_rle_col_B681:
	defb 050h,04fh,000h	; b681

; ----------------------------------------------------------------------
; DATOS rle_col_B684: colores RLE: 2 tiles desde el 42 (tabla85[78])
;   0xb684..0xb696  (18 bytes)
DATA_rle_col_B684:
	defb 090h,0ffh,0eeh,044h,041h,049h,01fh,055h,055h,0ffh,0eeh,044h,041h,048h,04bh,099h	; b684  ...DAI.UU..DAHK.
	defb 099h,000h	; b694

; ----------------------------------------------------------------------
; DATOS rle_col_B696: colores RLE: 1 tiles desde el 81 (tabla85[81])
;   0xb696..0xb699  (3 bytes)
DATA_rle_col_B696:
	defb 008h,0f9h,000h	; b696

; ----------------------------------------------------------------------
; DATOS rle_col_B699: colores RLE: 1 tiles desde el 100 (tabla85[80])
;   0xb699..0xb69c  (3 bytes)
DATA_rle_col_B699:
	defb 008h,069h,000h	; b699

; ----------------------------------------------------------------------
; DATOS rle_col_B69C: colores RLE: 3 tiles desde el 190 (lista 0x7388)
;   0xb69c..0xb6b4  (24 bytes)
DATA_rle_col_B69C:
	defb 089h,0ffh,0eeh,044h,041h,049h,011h,099h,099h,066h,004h,096h,003h,098h,088h,0ffh	; b69c  ...DAI...f......
	defb 0eeh,044h,041h,049h,018h,066h,066h,000h	; b6ac  .DAI.ff.

; ----------------------------------------------------------------------
; DATOS rle_col_B6B4: colores RLE: 1 tiles desde el 193 (lista 0x7388)
;   0xb6b4..0xb6b9  (5 bytes)
DATA_rle_col_B6B4:
	defb 005h,065h,003h,085h,000h	; b6b4

; ----------------------------------------------------------------------
; DATOS rle_col_B6B9: colores RLE: 2 tiles desde el 107 (lista 0x695f)
;   0xb6b9..0xb6c2  (9 bytes)
DATA_rle_col_B6B9:
	defb 004h,09fh,004h,096h,004h,09ah,004h,094h,000h	; b6b9  .........

; ----------------------------------------------------------------------
; DATOS rle_col_B6C2: colores RLE: 2 tiles desde el 107 (lista 0x69d9)
;   0xb6c2..0xb6c7  (5 bytes)
DATA_rle_col_B6C2:
	defb 008h,09fh,008h,096h,000h	; b6c2

; ----------------------------------------------------------------------
; DATOS rle_col_B6C7: colores RLE: 2 tiles desde el 107 (lista 0x699c)
;   0xb6c7..0xb6cc  (5 bytes)
DATA_rle_col_B6C7:
	defb 008h,0cfh,008h,0c4h,000h	; b6c7

; ----------------------------------------------------------------------
; DATOS rle_col_B6CC: colores RLE: 2 tiles desde el 107 (lista 0x6922)
;   0xb6cc..0xb6d1  (5 bytes)
DATA_rle_col_B6CC:
	defb 008h,02fh,008h,026h,000h	; b6cc

; ----------------------------------------------------------------------
; DATOS rle_col_B6D1: colores RLE: 2 tiles desde el 31 (lista 0x6642)
;   0xb6d1..0xb6d4  (3 bytes)
DATA_rle_col_B6D1:
	defb 010h,024h,000h	; b6d1

; ----------------------------------------------------------------------
; DATOS rle_col_B6D4: colores RLE: 2 tiles desde el 31 (lista 0x66b0)
;   0xb6d4..0xb6d7  (3 bytes)
DATA_rle_col_B6D4:
	defb 010h,094h,000h	; b6d4

; ----------------------------------------------------------------------
; DATOS rle_col_B6D7: colores RLE: 2 tiles desde el 31 (lista 0x6605)
;   0xb6d7..0xb6da  (3 bytes)
DATA_rle_col_B6D7:
	defb 010h,0c5h,000h	; b6d7

; ----------------------------------------------------------------------
; DATOS rle_col_B6DA: colores RLE: 2 tiles desde el 31 (lista 0x66e1)
;   0xb6da..0xb6dd  (3 bytes)
DATA_rle_col_B6DA:
	defb 010h,0c1h,000h	; b6da

; ----------------------------------------------------------------------
; DATOS rle_col_B6DD: colores RLE: 2 tiles desde el 33 (lista 0x6642)
;   0xb6dd..0xb6e0  (3 bytes)
DATA_rle_col_B6DD:
	defb 010h,026h,000h	; b6dd

; ----------------------------------------------------------------------
; DATOS rle_col_B6E0: colores RLE: 2 tiles desde el 33 (lista 0x66b0)
;   0xb6e0..0xb6e3  (3 bytes)
DATA_rle_col_B6E0:
	defb 010h,096h,000h	; b6e0

; ----------------------------------------------------------------------
; DATOS rle_col_B6E3: colores RLE: 2 tiles desde el 33 (lista 0x6605)
;   0xb6e3..0xb6e6  (3 bytes)
DATA_rle_col_B6E3:
	defb 010h,0c9h,000h	; b6e3

; ----------------------------------------------------------------------
; DATOS rle_col_B6E6: colores RLE: 3 tiles desde el 59 (lista 0x7113)
;   0xb6e6..0xb6ef  (9 bytes)
DATA_rle_col_B6E6:
	defb 008h,0e1h,003h,061h,005h,026h,008h,0f2h,000h	; b6e6  ...a.&...

; ----------------------------------------------------------------------
; DATOS rle_col_B6EF: colores RLE: 3 tiles desde el 59 (lista 0x73b8)
;   0xb6ef..0xb6f8  (9 bytes)
DATA_rle_col_B6EF:
	defb 008h,0e1h,003h,061h,005h,096h,008h,0f9h,000h	; b6ef  ...a.....

; ----------------------------------------------------------------------
; DATOS rle_col_B6F8: colores RLE: 3 tiles desde el 59 (lista 0x730b)
;   0xb6f8..0xb701  (9 bytes)
DATA_rle_col_B6F8:
	defb 008h,0e1h,003h,041h,005h,0c4h,008h,0fch,000h	; b6f8  ...A.....

; ----------------------------------------------------------------------
; DATOS rle_col_B701: colores RLE: 3 tiles desde el 100 (lista 0x7113)
;   0xb701..0xb708  (7 bytes)
DATA_rle_col_B701:
	defb 010h,021h,003h,010h,005h,023h,000h	; b701

; ----------------------------------------------------------------------
; DATOS rle_col_B708: colores RLE: 3 tiles desde el 100 (lista 0x73b8)
;   0xb708..0xb70f  (7 bytes)
DATA_rle_col_B708:
	defb 010h,091h,003h,010h,005h,09ah,000h	; b708

; ----------------------------------------------------------------------
; DATOS rle_col_B70F: colores RLE: 10 tiles desde el 44 (lista 0x6768)
;   0xb70f..0xb73e  (47 bytes)
DATA_rle_col_B70F:
	defb 003h,0f1h,08dh,0c1h,041h,071h,091h,0c1h,022h,02fh,0f1h,011h,0a1h,081h,051h,0a1h	; b70f  ....Aq.."/....Q.
	defb 004h,0f2h,084h,01fh,011h,091h,061h,005h,02ah,003h,026h,008h,02ah,081h,0f2h,007h	; b71f  ......a.*.&.*...
	defb 0e2h,008h,0efh,082h,011h,0f1h,006h,0efh,004h,0f1h,004h,0feh,008h,0e4h,000h	; b72f  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_B73E: colores RLE: 10 tiles desde el 44 (lista 0x678d)
;   0xb73e..0xb76d  (47 bytes)
DATA_rle_col_B73E:
	defb 003h,0f1h,08dh,0c1h,041h,071h,091h,0c1h,099h,09fh,0f1h,011h,0a1h,081h,051h,0a1h	; b73e  ....Aq........Q.
	defb 004h,0f9h,084h,01fh,011h,091h,061h,005h,09ah,003h,096h,008h,09ah,081h,0f9h,007h	; b74e  ......a.........
	defb 0e9h,008h,0efh,082h,011h,0f1h,006h,0efh,004h,0f1h,004h,0feh,008h,0e4h,000h	; b75e  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_B76D: colores RLE: 10 tiles desde el 44 (lista 0x67b2)
;   0xb76d..0xb79c  (47 bytes)
DATA_rle_col_B76D:
	defb 003h,0f1h,08dh,0c1h,041h,071h,091h,0c1h,0cch,0cfh,0f1h,011h,0a1h,081h,051h,0a1h	; b76d  ....Aq........Q.
	defb 004h,0fch,084h,01fh,011h,091h,061h,005h,0c2h,003h,0c6h,008h,0c2h,081h,0fch,007h	; b77d  ......a.........
	defb 0ech,008h,0efh,082h,011h,0f1h,006h,0efh,004h,0f1h,004h,0feh,008h,0e1h,000h	; b78d  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_B79C: colores RLE: 10 tiles desde el 44 (lista 0x6743)
;   0xb79c..0xb7cb  (47 bytes)
DATA_rle_col_B79C:
	defb 003h,0f1h,08dh,0c1h,041h,071h,091h,0c1h,0cch,0cfh,0f1h,011h,0a1h,081h,051h,0a1h	; b79c  ....Aq........Q.
	defb 004h,0fch,084h,01fh,011h,091h,091h,005h,0c2h,003h,0c9h,008h,0c2h,081h,0fch,007h	; b7ac  ................
	defb 0ech,008h,0efh,082h,011h,0f1h,006h,0efh,004h,0f1h,004h,0feh,008h,0e5h,000h	; b7bc  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_B7CB: colores RLE: 10 tiles desde el 44 (lista 0x6768)
;   0xb7cb..0xb801  (54 bytes)
DATA_rle_col_B7CB:
	defb 003h,0f1h,085h,0c1h,041h,071h,091h,0c1h,003h,0f1h,085h,0c1h,041h,071h,091h,0c1h	; b7cb  ....Aq......Aq..
	defb 003h,0f1h,085h,0c1h,041h,071h,091h,0c1h,008h,066h,008h,011h,008h,0f2h,084h,081h	; b7db  ....Aq...f......
	defb 0a1h,0f1h,081h,004h,0f1h,084h,081h,0a1h,0f1h,081h,004h,0f1h,084h,081h,0a1h,0f1h	; b7eb  ................
	defb 081h,004h,0f1h,008h,041h,000h	; b7fb

; ----------------------------------------------------------------------
; DATOS rle_col_B801: colores RLE: 10 tiles desde el 44 (lista 0x678d)
;   0xb801..0xb837  (54 bytes)
DATA_rle_col_B801:
	defb 003h,0f1h,085h,0c1h,041h,071h,091h,0c1h,003h,0f1h,085h,0c1h,041h,071h,091h,0c1h	; b801  ....Aq......Aq..
	defb 003h,0f1h,085h,0c1h,041h,071h,091h,0c1h,008h,066h,008h,011h,008h,0f9h,084h,081h	; b811  ....Aq...f......
	defb 0a1h,0f1h,081h,004h,0f1h,084h,081h,0a1h,0f1h,081h,004h,0f1h,084h,081h,0a1h,0f1h	; b821  ................
	defb 081h,004h,0f1h,008h,041h,000h	; b831

; ----------------------------------------------------------------------
; DATOS rle_col_B837: colores RLE: 10 tiles desde el 44 (lista 0x67b2)
;   0xb837..0xb86d  (54 bytes)
DATA_rle_col_B837:
	defb 003h,0f1h,085h,0c1h,041h,071h,091h,0c1h,003h,0f1h,085h,0c1h,041h,071h,091h,0c1h	; b837  ....Aq......Aq..
	defb 003h,0f1h,085h,0c1h,041h,071h,091h,0c1h,008h,066h,008h,011h,008h,0fch,084h,081h	; b847  ....Aq...f......
	defb 0a1h,0f1h,081h,004h,0f1h,084h,081h,0a1h,0f1h,081h,004h,0f1h,084h,081h,0a1h,0f1h	; b857  ................
	defb 081h,004h,0f1h,008h,011h,000h	; b867

; ----------------------------------------------------------------------
; DATOS rle_col_B86D: colores RLE: 10 tiles desde el 44 (lista 0x6743)
;   0xb86d..0xb8a3  (54 bytes)
DATA_rle_col_B86D:
	defb 003h,0f1h,085h,0c1h,041h,071h,091h,0c1h,003h,0f1h,085h,0c1h,051h,071h,091h,0c1h	; b86d  ....Aq......Qq..
	defb 003h,0f1h,085h,0c1h,051h,071h,091h,0c1h,008h,099h,008h,011h,008h,0fch,084h,081h	; b87d  ....Qq..........
	defb 0a1h,0f1h,081h,004h,0f1h,084h,081h,0a1h,0f1h,081h,004h,0f1h,084h,081h,0a1h,0f1h	; b88d  ................
	defb 081h,004h,0f1h,008h,051h,000h	; b89d

; ----------------------------------------------------------------------
; DATOS rle_col_B8A3: colores RLE: 10 tiles desde el 44 (lista 0x6768)
;   0xb8a3..0xb8c0  (29 bytes)
DATA_rle_col_B8A3:
	defb 016h,0f1h,082h,0c1h,041h,008h,0f6h,008h,021h,008h,0f2h,08ch,081h,0a1h,0e1h,051h	; b8a3  ....A...!......Q
	defb 061h,091h,011h,0ffh,061h,091h,0e1h,071h,00ch,0f1h,008h,041h,000h	; b8b3  a...a..q...A.

; ----------------------------------------------------------------------
; DATOS rle_col_B8C0: colores RLE: 10 tiles desde el 44 (lista 0x678d)
;   0xb8c0..0xb8dd  (29 bytes)
DATA_rle_col_B8C0:
	defb 016h,0f1h,082h,0c1h,041h,008h,096h,008h,091h,008h,0f9h,08ch,081h,0a1h,0e1h,051h	; b8c0  ....A..........Q
	defb 061h,091h,011h,0ffh,061h,091h,0e1h,071h,00ch,0f1h,008h,041h,000h	; b8d0  a...a..q...A.

; ----------------------------------------------------------------------
; DATOS rle_col_B8DD: colores RLE: 10 tiles desde el 44 (lista 0x67b2)
;   0xb8dd..0xb8fa  (29 bytes)
DATA_rle_col_B8DD:
	defb 016h,0f1h,082h,0c1h,041h,008h,0f6h,008h,0c1h,008h,0fch,08ch,081h,0a1h,0e1h,051h	; b8dd  ....A..........Q
	defb 061h,091h,011h,0ffh,061h,091h,0e1h,071h,00ch,0f1h,008h,011h,000h	; b8ed  a...a..q.....

; ----------------------------------------------------------------------
; DATOS rle_col_B8FA: colores RLE: 10 tiles desde el 44 (lista 0x6743)
;   0xb8fa..0xb917  (29 bytes)
DATA_rle_col_B8FA:
	defb 016h,0f1h,082h,0c1h,051h,008h,0f9h,008h,0c1h,008h,0fch,08ch,081h,0a1h,0e1h,051h	; b8fa  ....Q..........Q
	defb 091h,091h,011h,0ffh,091h,091h,0e1h,071h,00ch,0f1h,008h,051h,000h	; b90a  .......q...Q.

; ----------------------------------------------------------------------
; DATOS rle_col_B917: colores RLE: 5 tiles desde el 54 (lista 0x6768)
;   0xb917..0xb935  (30 bytes)
DATA_rle_col_B917:
	defb 008h,026h,002h,0fch,003h,0f1h,083h,051h,041h,041h,008h,0e4h,086h,0e1h,0f1h,0f1h	; b917  .&.....QAA......
	defb 051h,041h,041h,003h,0e1h,002h,0f1h,085h,051h,041h,041h,0e1h,0e1h,000h	; b927  QAA.....QAA...

; ----------------------------------------------------------------------
; DATOS rle_col_B935: colores RLE: 5 tiles desde el 54 (lista 0x678d)
;   0xb935..0xb953  (30 bytes)
DATA_rle_col_B935:
	defb 008h,096h,002h,0fch,003h,0f1h,083h,051h,041h,041h,008h,0e4h,086h,0e1h,0f1h,0f1h	; b935  .......QAA......
	defb 051h,041h,041h,003h,0e1h,002h,0f1h,085h,051h,041h,041h,0e1h,0e1h,000h	; b945  QAA.....QAA...

; ----------------------------------------------------------------------
; DATOS rle_col_B953: colores RLE: 5 tiles desde el 54 (lista 0x6743)
;   0xb953..0xb971  (30 bytes)
DATA_rle_col_B953:
	defb 008h,0c9h,002h,0fch,003h,0f1h,083h,051h,041h,041h,008h,0e5h,086h,0e1h,0f1h,0f1h	; b953  .......QAA......
	defb 051h,041h,041h,003h,0e1h,002h,0f1h,085h,051h,041h,041h,0e1h,0e1h,000h	; b963  QAA.....QAA...

; ----------------------------------------------------------------------
; DATOS rle_col_B971: colores RLE: 5 tiles desde el 54 (lista 0x67b2)
;   0xb971..0xb98e  (29 bytes)
DATA_rle_col_B971:
	defb 008h,0c6h,002h,0fch,003h,0f1h,083h,051h,041h,041h,009h,0e1h,002h,0f1h,083h,051h	; b971  .......QAA.....Q
	defb 041h,041h,003h,0e1h,002h,0f1h,085h,051h,041h,041h,0e1h,0e1h,000h	; b981  AA.....QAA...

; ----------------------------------------------------------------------
; DATOS rle_col_B98E: colores RLE: 5 tiles desde el 54 (lista 0x6768)
;   0xb98e..0xb9ad  (31 bytes)
DATA_rle_col_B98E:
	defb 002h,023h,006h,066h,003h,0e1h,084h,041h,051h,0f1h,051h,009h,041h,086h,0e1h,041h	; b98e  .#.f...AQ.Q.A..A
	defb 051h,0f1h,051h,041h,003h,0e1h,087h,041h,051h,0f1h,051h,041h,0e1h,0e1h,000h	; b99e  Q.QA...AQ.QA...

; ----------------------------------------------------------------------
; DATOS rle_col_B9AD: colores RLE: 5 tiles desde el 54 (lista 0x678d)
;   0xb9ad..0xb9cc  (31 bytes)
DATA_rle_col_B9AD:
	defb 002h,09ah,006h,066h,003h,0e1h,084h,041h,051h,0f1h,051h,009h,041h,086h,0e1h,041h	; b9ad  ...f...AQ.Q.A..A
	defb 051h,0f1h,051h,041h,003h,0e1h,087h,041h,051h,0f1h,051h,041h,0e1h,0e1h,000h	; b9bd  Q.QA...AQ.QA...

; ----------------------------------------------------------------------
; DATOS rle_col_B9CC: colores RLE: 5 tiles desde el 54 (lista 0x6743)
;   0xb9cc..0xb9ec  (32 bytes)
DATA_rle_col_B9CC:
	defb 002h,0c2h,006h,099h,003h,0e1h,085h,041h,051h,0f1h,051h,041h,008h,051h,086h,0e1h	; b9cc  .......AQ.QA.Q..
	defb 041h,051h,0f1h,051h,041h,003h,0e1h,087h,041h,051h,0f1h,051h,041h,0e1h,0e1h,000h	; b9dc  AQ.QA...AQ.QA...

; ----------------------------------------------------------------------
; DATOS rle_col_B9EC: colores RLE: 5 tiles desde el 54 (lista 0x67b2)
;   0xb9ec..0xba0c  (32 bytes)
DATA_rle_col_B9EC:
	defb 002h,0c2h,006h,066h,003h,0e1h,085h,041h,051h,0f1h,051h,041h,008h,011h,086h,0e1h	; b9ec  ...f...AQ.QA....
	defb 041h,051h,0f1h,051h,041h,003h,0e1h,087h,041h,051h,0f1h,051h,041h,0e1h,0e1h,000h	; b9fc  AQ.QA...AQ.QA...

; ----------------------------------------------------------------------
; DATOS rle_col_BA0C: colores RLE: 5 tiles desde el 54 (lista 0x6743)
;   0xba0c..0xba2a  (30 bytes)
DATA_rle_col_BA0C:
	defb 008h,0f9h,003h,0f1h,002h,041h,083h,051h,0f1h,0f1h,008h,051h,086h,0e1h,041h,041h	; ba0c  .....A.Q...Q..AA
	defb 051h,0f1h,0f1h,003h,0e1h,002h,041h,085h,051h,0f1h,0f1h,0e1h,0e1h,000h	; ba1c  Q.....A.Q.....

; ----------------------------------------------------------------------
; DATOS rle_col_BA2A: colores RLE: 5 tiles desde el 54 (lista 0x67b2)
;   0xba2a..0xba48  (30 bytes)
DATA_rle_col_BA2A:
	defb 008h,0f6h,003h,0f1h,002h,041h,083h,051h,0f1h,0f1h,008h,011h,086h,0e1h,041h,041h	; ba2a  .....A.Q......AA
	defb 051h,0f1h,0f1h,003h,0e1h,002h,041h,085h,051h,0f1h,0f1h,0e1h,0e1h,000h	; ba3a  Q.....A.Q.....

; ----------------------------------------------------------------------
; DATOS rle_col_BA48: colores RLE: 8 tiles desde el 111 (lista 0x6922)
;   0xba48..0xba51  (9 bytes)
DATA_rle_col_BA48:
	defb 008h,0f2h,004h,02ch,014h,0f2h,020h,026h,000h	; ba48  ...,.. &.

; ----------------------------------------------------------------------
; DATOS rle_col_BA51: colores RLE: 8 tiles desde el 111 (lista 0x695f)
;   0xba51..0xba72  (33 bytes)
DATA_rle_col_BA51:
	defb 004h,0f9h,004h,069h,004h,092h,004h,069h,004h,0f9h,004h,069h,004h,0f9h,004h,069h	; ba51  ...i...i...i...i
	defb 004h,09ah,004h,094h,004h,09ah,004h,094h,004h,09ah,004h,094h,004h,09ah,004h,094h	; ba61  ................
	defb 000h	; ba71

; ----------------------------------------------------------------------
; DATOS rle_col_BA72: colores RLE: 8 tiles desde el 111 (lista 0x69d9)
;   0xba72..0xba7d  (11 bytes)
DATA_rle_col_BA72:
	defb 008h,0f9h,004h,092h,014h,0f9h,018h,096h,008h,096h,000h	; ba72  ...........

; ----------------------------------------------------------------------
; DATOS rle_col_BA7D: colores RLE: 8 tiles desde el 111 (lista 0x699c)
;   0xba7d..0xba86  (9 bytes)
DATA_rle_col_BA7D:
	defb 008h,0fch,004h,0c2h,014h,0fch,020h,0c4h,000h	; ba7d  ...... ..

; ----------------------------------------------------------------------
; DATOS rle_col_BA86: colores RLE: 8 tiles desde el 127 (lista 0x6922)
;   0xba86..0xba8f  (9 bytes)
DATA_rle_col_BA86:
	defb 020h,0f2h,004h,026h,004h,02ch,018h,026h,000h	; ba86   ..&.,.&.

; ----------------------------------------------------------------------
; DATOS rle_col_BA8F: colores RLE: 8 tiles desde el 127 (lista 0x695f)
;   0xba8f..0xbab0  (33 bytes)
DATA_rle_col_BA8F:
	defb 004h,0f9h,004h,069h,004h,0f9h,004h,069h,004h,0f9h,004h,069h,004h,0f9h,004h,069h	; ba8f  ...i...i...i...i
	defb 004h,09ah,004h,09bh,004h,09ah,004h,094h,004h,09ah,004h,094h,004h,09ah,004h,094h	; ba9f  ................
	defb 000h	; baaf

; ----------------------------------------------------------------------
; DATOS rle_col_BAB0: colores RLE: 8 tiles desde el 127 (lista 0x69d9)
;   0xbab0..0xbab9  (9 bytes)
DATA_rle_col_BAB0:
	defb 020h,0f9h,004h,096h,004h,092h,018h,096h,000h	; bab0   ........

; ----------------------------------------------------------------------
; DATOS rle_col_BAB9: colores RLE: 8 tiles desde el 127 (lista 0x699c)
;   0xbab9..0xbac2  (9 bytes)
DATA_rle_col_BAB9:
	defb 020h,0fch,004h,0c4h,004h,0c2h,018h,0c4h,000h	; bab9   ........

; ----------------------------------------------------------------------
; DATOS rle_col_BAC2: colores RLE: 8 tiles desde el 143 (lista 0x695f)
;   0xbac2..0xbae3  (33 bytes)
DATA_rle_col_BAC2:
	defb 004h,0feh,004h,06eh,004h,0feh,004h,06eh,004h,0feh,004h,06eh,004h,0feh,004h,06eh	; bac2  ...n...n...n...n
	defb 004h,0eah,004h,0e4h,004h,0eah,004h,0e4h,004h,0eah,004h,0e4h,004h,0eah,004h,0e4h	; bad2  ................
	defb 000h	; bae2

; ----------------------------------------------------------------------
; DATOS rle_col_BAE3: colores RLE: 8 tiles desde el 143 (lista 0x699c)
;   0xbae3..0xbae8  (5 bytes)
DATA_rle_col_BAE3:
	defb 020h,0feh,020h,0e4h,000h	; bae3

; ----------------------------------------------------------------------
; DATOS rle_col_BAE8: colores RLE: 8 tiles desde el 159 (lista 0x695f)
;   0xbae8..0xbb0b  (35 bytes)
DATA_rle_col_BAE8:
	defb 004h,0feh,004h,06eh,004h,0feh,004h,06eh,004h,0feh,004h,06eh,004h,0feh,004h,06eh	; bae8  ...n...n...n...n
	defb 004h,0eah,004h,0e4h,004h,0eah,004h,0e4h,002h,0eeh,002h,0eah,004h,0e4h,004h,0eah	; baf8  ................
	defb 004h,0e4h,000h	; bb08

; ----------------------------------------------------------------------
; DATOS rle_col_BB0B: colores RLE: 8 tiles desde el 159 (lista 0x699c)
;   0xbb0b..0xbb14  (9 bytes)
DATA_rle_col_BB0B:
	defb 020h,0feh,010h,0e4h,002h,0eeh,00eh,0e4h,000h	; bb0b   ........

; ----------------------------------------------------------------------
; DATOS rle_col_BB14: colores RLE: 4 tiles desde el 103 (lista 0x7354)
;   0xbb14..0xbb36  (34 bytes)
DATA_rle_col_BB14:
	defb 087h,0c2h,0c3h,0c3h,0c2h,0c3h,0cbh,0c3h,003h,0c2h,086h,0cbh,0c2h,0c3h,0c2h,0c2h	; bb14  ................
	defb 0c3h,003h,0c2h,081h,0cbh,003h,0c3h,002h,0c2h,087h,0c3h,0c2h,0c2h,0cbh,0c3h,0c2h	; bb24  ................
	defb 0c3h,000h	; bb34

; ----------------------------------------------------------------------
; DATOS rle_col_BB36: colores RLE: 4 tiles desde el 103 (lista 0x7113)
;   0xbb36..0xbb55  (31 bytes)
DATA_rle_col_BB36:
	defb 084h,02ch,029h,029h,02ch,003h,029h,003h,02ch,086h,029h,02ch,029h,02ch,02ch,029h	; bb36  .,)),.).,.),),,)
	defb 003h,02ch,004h,029h,002h,02ch,087h,029h,02ch,02ch,029h,029h,02ch,029h,000h	; bb46  .,.).,.),,)),).

; ----------------------------------------------------------------------
; DATOS rle_col_BB55: colores RLE: 4 tiles desde el 103 (lista 0x73b8)
;   0xbb55..0xbb74  (31 bytes)
DATA_rle_col_BB55:
	defb 084h,099h,09bh,09bh,099h,003h,09bh,003h,099h,086h,09bh,099h,09bh,099h,099h,09bh	; bb55  ................
	defb 003h,099h,004h,09bh,002h,099h,087h,09bh,099h,099h,09bh,09bh,099h,09bh,000h	; bb65  ...............

; ----------------------------------------------------------------------
; DATOS rle_col_BB74: colores RLE: 4 tiles desde el 103 (lista 0x7156)
;   0xbb74..0xbb96  (34 bytes)
DATA_rle_col_BB74:
	defb 087h,0c2h,0c9h,0c9h,0c2h,0c9h,0cbh,0c9h,003h,0c2h,086h,0cbh,0c2h,0c9h,0c2h,0c2h	; bb74  ................
	defb 0c9h,003h,0c2h,081h,0cbh,003h,0c9h,002h,0c2h,087h,0c9h,0c2h,0c2h,0cbh,0c9h,0c2h	; bb84  ................
	defb 0c9h,000h	; bb94

; ----------------------------------------------------------------------
; DATOS rle_col_BB96: colores RLE: 6 tiles desde el 35 (lista 0x719e)
;   0xbb96..0xbbbb  (37 bytes)
DATA_rle_col_BB96:
	defb 002h,0c3h,091h,0c2h,0c3h,031h,021h,021h,031h,0c3h,0c2h,0c1h,0c1h,0c3h,0c2h,0c1h	; bb96  .....1!!1.......
	defb 0c1h,031h,021h,021h,005h,0c1h,083h,0cch,0c1h,0c1h,005h,061h,081h,0c2h,004h,0c3h	; bba6  .1!!.......a....
	defb 003h,0c2h,008h,0c1h,000h	; bbb6

; ----------------------------------------------------------------------
; DATOS rle_col_BBBB: colores RLE: 8 tiles desde el 9 (lista 0x71d4)
;   0xbbbb..0xbbbe  (3 bytes)
DATA_rle_col_BBBB:
	defb 040h,0f6h,000h	; bbbb

; ----------------------------------------------------------------------
; DATOS rle_col_BBBE: colores RLE: 1 tiles desde el 77 (tabla85[0])
;   0xbbbe..0xbbc8  (10 bytes)
DATA_rle_col_BBBE:
	defb 088h,095h,096h,091h,051h,041h,091h,096h,091h,000h	; bbbe  ....QA....

; ----------------------------------------------------------------------
; DATOS rle_col_BBC8: colores RLE: 2 tiles desde el 1 (tabla85[1])
;   0xbbc8..0xbbd9  (17 bytes)
DATA_rle_col_BBC8:
	defb 086h,091h,094h,095h,091h,091h,095h,003h,091h,084h,0a9h,091h,091h,096h,003h,091h	; bbc8  ................
	defb 000h	; bbd8

; ----------------------------------------------------------------------
; DATOS rle_col_BBD9: colores RLE: 1 tiles desde el 77 (tabla85[2])
;   0xbbd9..0xbbe3  (10 bytes)
DATA_rle_col_BBD9:
	defb 088h,025h,026h,021h,051h,041h,021h,026h,021h,000h	; bbd9  .%&!QA!&!.

; ----------------------------------------------------------------------
; DATOS rle_col_BBE3: colores RLE: 2 tiles desde el 1 (tabla85[3])
;   0xbbe3..0xbbf4  (17 bytes)
DATA_rle_col_BBE3:
	defb 086h,021h,024h,025h,021h,021h,025h,003h,021h,084h,0a2h,021h,021h,026h,003h,021h	; bbe3  .!$%!!%.!..!!&.!
	defb 000h	; bbf3

; ----------------------------------------------------------------------
; DATOS rle_col_BBF4: colores RLE: 2 tiles desde el 15 (tabla85[4])
;   0xbbf4..0xbc05  (17 bytes)
DATA_rle_col_BBF4:
	defb 086h,0c1h,0c4h,0c5h,0c1h,0c1h,0c5h,003h,0c1h,084h,0ach,0c1h,0c1h,0c6h,003h,0c1h	; bbf4  ................
	defb 000h	; bc04

; ----------------------------------------------------------------------
; DATOS rle_col_BC05: colores RLE: 7 tiles desde el 86 (lista 0x68cf)
;   0xbc05..0xbc3e  (57 bytes)
DATA_rle_col_BC05:
	defb 002h,092h,086h,0c9h,021h,0c1h,021h,0c2h,021h,003h,0c1h,002h,0c9h,088h,091h,0c9h	; bc05  ....!.!.!.......
	defb 091h,021h,0c1h,0c1h,021h,0c1h,003h,091h,083h,092h,0c9h,0c9h,003h,0c2h,002h,0c1h	; bc15  .!..!...........
	defb 002h,092h,086h,0c9h,021h,0c1h,021h,0c2h,021h,003h,0c1h,002h,0c9h,088h,091h,0c9h	; bc25  ....!.!.!.......
	defb 091h,021h,0c1h,0c1h,021h,021h,003h,0c1h,000h	; bc35  .!..!!...

; ----------------------------------------------------------------------
; DATOS rle_col_BC3E: colores RLE: 7 tiles desde el 86 (lista 0x68b9)
;   0xbc3e..0xbc75  (55 bytes)
DATA_rle_col_BC3E:
	defb 002h,022h,086h,0c2h,021h,0c1h,021h,0c2h,021h,003h,0c1h,002h,0c2h,088h,021h,0c2h	; bc3e  ."..!.!.!.....!.
	defb 021h,021h,0c1h,0c1h,021h,0c1h,003h,021h,081h,022h,005h,0c2h,002h,0c1h,002h,022h	; bc4e  !!..!..!."....."
	defb 086h,0c2h,021h,0c1h,021h,0c2h,021h,003h,0c1h,002h,0c2h,088h,021h,0c2h,021h,021h	; bc5e  ..!.!.!.....!.!!
	defb 0c1h,0c1h,021h,021h,003h,0c1h,000h	; bc6e

; ----------------------------------------------------------------------
; DATOS rle_pat_BC75: patrones RLE: 22 tiles desde el 97 (lista 0x6aa8)
;   0xbc75..0xbcf7  (130 bytes)
DATA_rle_pat_BC75:
	defb 002h,0feh,088h,0bfh,0fbh,0ffh,0ffh,07fh,0f7h,000h,000h,003h,0ffh,095h,0efh,0ffh	; bc75  ................
	defb 0ffh,000h,000h,0ffh,0bfh,0ffh,0ffh,0fbh,0ffh,000h,000h,0ffh,0ffh,0fbh,0bfh,0ffh	; bc85  ................
	defb 0ffh,000h,000h,003h,0ffh,08dh,0efh,0ffh,0ffh,000h,000h,0ffh,0ffh,0fbh,0bfh,0ffh	; bc95  ................
	defb 0ffh,003h,003h,004h,0ffh,083h,07fh,0f7h,0ffh,007h,000h,002h,0ffh,008h,000h,081h	; bca5  ................
	defb 0ffh,008h,000h,005h,0ffh,004h,000h,081h,0f0h,003h,0ffh,006h,000h,081h,0f0h,004h	; bcb5  ................
	defb 0ffh,085h,010h,09ah,0c3h,020h,030h,004h,0ffh,084h,022h,033h,044h,066h,005h,0ffh	; bcc5  ..... 0..."3Df..
	defb 083h,004h,046h,060h,006h,0ffh,088h,044h,066h,0ffh,0ffh,0bfh,0fbh,000h,0f0h,006h	; bcd5  ..F`...Df.......
	defb 0ffh,084h,0efh,0ffh,0ffh,0f0h,010h,001h,088h,0fdh,07fh,0ffh,0ffh,0fbh,0bfh,0ffh	; bce5  ................
	defb 0ffh,000h	; bcf5

; ----------------------------------------------------------------------
; DATOS rle_pat_BCF7: patrones RLE: 22 tiles desde el 97 (lista 0x6aa8)
;   0xbcf7..0xbd77  (128 bytes)
DATA_rle_pat_BCF7:
	defb 002h,0ffh,086h,0bfh,0fbh,0ffh,0ffh,07fh,0f7h,005h,0ffh,081h,0efh,003h,0ffh,08dh	; bcf7  ................
	defb 0fdh,0ffh,0bfh,0ffh,0ffh,0fbh,0ffh,0fdh,07fh,0ffh,0ffh,0fbh,0bfh,007h,0ffh,089h	; bd07  ................
	defb 0efh,0ffh,0ffh,0fdh,07fh,0ffh,0ffh,0fbh,0bfh,004h,0ffh,08ah,0bfh,0fbh,0ffh,0ffh	; bd17  ................
	defb 07fh,0f7h,010h,018h,042h,063h,004h,0ffh,084h,044h,066h,010h,018h,004h,000h,084h	; bd27  ....Bc...Df.....
	defb 010h,018h,042h,063h,004h,0ffh,084h,010h,018h,042h,063h,00ah,0ffh,002h,000h,006h	; bd37  ..Bc.....Bc.....
	defb 0ffh,002h,000h,002h,0ffh,082h,0bfh,0fbh,008h,0ffh,081h,0efh,005h,0ffh,082h,0bfh	; bd47  ................
	defb 0fbh,008h,0ffh,081h,0efh,005h,0ffh,082h,0bfh,0fbh,008h,0ffh,081h,0efh,003h,0ffh	; bd57  ................
	defb 008h,001h,006h,0ffh,002h,001h,088h,0fdh,07fh,0ffh,0ffh,0fbh,0bfh,0ffh,0ffh,000h	; bd67  ................

; ----------------------------------------------------------------------
; DATOS rle_pat_BD77: patrones RLE: 22 tiles desde el 97 (lista 0x6aa8)
;   0xbd77..0xbe02  (139 bytes)
DATA_rle_pat_BD77:
	defb 004h,001h,002h,0ffh,087h,07fh,0f7h,044h,066h,0ffh,0ffh,0efh,007h,0ffh,082h,0fbh	; bd77  .......Df.......
	defb 0bfh,004h,0ffh,094h,0bfh,0fbh,0ffh,0ffh,07fh,0f7h,0ffh,0ffh,0bfh,0fbh,0ffh,0ffh	; bd87  ................
	defb 07fh,0f7h,0fdh,07fh,0ffh,0ffh,0fbh,0bfh,004h,0ffh,0a6h,0bfh,0fbh,0ffh,0ffh,07fh	; bd97  ................
	defb 0f7h,010h,05ah,063h,010h,05ah,063h,010h,018h,010h,05ah,063h,010h,05ah,063h,010h	; bda7  ..Zc.Zc...Zc.Zc.
	defb 018h,010h,05ah,063h,010h,05ah,063h,010h,018h,088h,0cch,010h,05ah,062h,010h,05ah	; bdb7  ..Zc.Zc.....Zb.Z
	defb 062h,007h,0ffh,081h,0f0h,005h,0ffh,003h,0f0h,002h,0ffh,081h,0bfh,005h,0fbh,004h	; bdc7  b...............
	defb 0ffh,004h,0efh,084h,0fdh,07fh,0ffh,0ffh,004h,0fbh,002h,0ffh,081h,0bfh,003h,0fbh	; bdd7  ................
	defb 004h,0ffh,081h,0bfh,00dh,0fbh,004h,001h,002h,0ffh,082h,07fh,0f7h,005h,0ffh,003h	; bde7  ................
	defb 001h,088h,0fdh,07fh,0ffh,0ffh,0fbh,07fh,03fh,01fh,000h	; bdf7  ........?..

; ----------------------------------------------------------------------
; DATOS rle_col_BE02: colores RLE: 22 tiles desde el 97 (lista 0x6aa8)
;   0xbe02..0xbe65  (99 bytes)
DATA_rle_col_BE02:
	defb 002h,0c1h,081h,0c2h,004h,0c3h,081h,0c2h,005h,0c1h,003h,0c2h,003h,0c1h,005h,0c2h	; be02  ................
	defb 004h,0c1h,004h,0c2h,005h,0c1h,003h,0c2h,004h,0c1h,004h,0c2h,002h,0c1h,005h,0c3h	; be12  ................
	defb 081h,0c2h,008h,0feh,081h,011h,007h,0feh,003h,0f1h,005h,0feh,004h,0f1h,014h,0efh	; be22  ................
	defb 090h,0cch,0fch,011h,091h,071h,051h,0a1h,091h,0cch,0cch,0fch,011h,051h,061h,071h	; be32  .....qQ......Qaq
	defb 0a1h,003h,0cch,085h,0fch,011h,0a1h,051h,081h,004h,0cch,084h,0fch,011h,071h,051h	; be42  .......Q......qQ
	defb 003h,0c2h,081h,0c3h,004h,0fch,007h,0c2h,002h,0fch,007h,0ech,081h,0cch,007h,0fch	; be52  ................
	defb 008h,0c2h,000h	; be62

; ----------------------------------------------------------------------
; DATOS rle_col_BE65: colores RLE: 22 tiles desde el 97 (lista 0x6aa8)
;   0xbe65..0xbebc  (87 bytes)
DATA_rle_col_BE65:
	defb 003h,0c2h,004h,0c3h,02ch,0c2h,004h,0c3h,0a1h,0c2h,041h,061h,081h,0a1h,011h,0ffh	; be65  ....,.....Aa....
	defb 011h,011h,061h,0a1h,0e1h,071h,0e1h,0ffh,011h,011h,081h,0a1h,0f1h,081h,011h,0ffh	; be75  ..a..q..........
	defb 011h,011h,081h,091h,0e1h,071h,011h,0ffh,011h,011h,010h,0f1h,003h,0c2h,003h,0c3h	; be85  .....q..........
	defb 082h,0ffh,011h,006h,0c2h,082h,0ffh,011h,003h,0c2h,004h,0c3h,081h,0ffh,007h,0c2h	; be95  ................
	defb 081h,0ffh,003h,0c2h,004h,0c3h,081h,0ffh,007h,0c2h,081h,0ffh,006h,0fch,002h,0cch	; bea5  ................
	defb 006h,0c2h,002h,0fch,008h,0c2h,000h	; beb5

; ----------------------------------------------------------------------
; DATOS rle_col_BEBC: colores RLE: 22 tiles desde el 97 (lista 0x6aa8)
;   0xbebc..0xbf3b  (127 bytes)
DATA_rle_col_BEBC:
	defb 004h,0fch,003h,0c3h,085h,0c2h,061h,091h,011h,0fch,004h,0c2h,002h,011h,081h,0f4h	; bebc  ......a.........
	defb 005h,0c2h,083h,011h,0fch,0c2h,004h,0c3h,084h,0c2h,0fch,0c2h,0c2h,004h,0c3h,00ch	; becc  ................
	defb 0c2h,004h,0c3h,0a1h,0c2h,0a1h,091h,071h,041h,081h,0a1h,0e1h,051h,0a1h,091h,071h	; bedc  .......qA...Q..q
	defb 041h,081h,0a1h,0e1h,051h,0a1h,091h,071h,041h,081h,0a1h,0e1h,051h,0c1h,051h,041h	; beec  A...Q..qA...Q.QA
	defb 0a1h,061h,091h,0e1h,071h,00dh,0fch,083h,0f1h,011h,0cch,003h,0c2h,085h,0c3h,0cch	; befc  .a..q...........
	defb 0ffh,0ffh,011h,005h,0c2h,002h,0ffh,081h,011h,005h,0c2h,083h,0ffh,011h,011h,003h	; bf0c  ................
	defb 0c2h,085h,0c3h,0cch,0ffh,011h,011h,003h,0c2h,082h,0c3h,0cch,003h,0ffh,005h,0cch	; bf1c  ................
	defb 003h,0ffh,004h,0fch,003h,0c3h,006h,0c2h,003h,0fch,005h,0c2h,003h,0c1h,000h	; bf2c  ...............

; ----------------------------------------------------------------------
; DATOS mandos_grabados_BF3B: 96 pares (mascara de mandos, cuadros que dura)
;   que suman 626 cuadros: 12,5 s a 50 Hz. Mismo formato que p15 0xBAB9 y p06
;   0xBDC1, pero aqui las mascaras llevan tambien el bit 7 (80 84 88 90 94
;   98). Partida grabada para la demo (hipotesis fundada, sin medir en el
;   emulador)
;   0xbf3b..0xbffc  (193 bytes)
DATA_mandos_grabados_BF3B:
	defb 000h,002h	; bf3b
	defb 010h,003h	; bf3d
	defb 000h,015h	; bf3f
	defb 010h,002h	; bf41
	defb 000h,019h	; bf43
	defb 002h,003h	; bf45
	defb 000h,015h	; bf47
	defb 010h,003h	; bf49
	defb 000h,01bh	; bf4b
	defb 010h,002h	; bf4d
	defb 000h,020h	; bf4f
	defb 010h,004h	; bf51
	defb 000h,01bh	; bf53
	defb 008h,004h	; bf55
	defb 000h,015h	; bf57
	defb 010h,004h	; bf59
	defb 000h,013h	; bf5b
	defb 010h,002h	; bf5d
	defb 000h,014h	; bf5f
	defb 090h,005h	; bf61
	defb 080h,015h	; bf63
	defb 090h,004h	; bf65
	defb 080h,014h	; bf67
	defb 090h,002h	; bf69
	defb 080h,04ch	; bf6b
	defb 010h,00ah	; bf6d
	defb 018h,004h	; bf6f
	defb 090h,006h	; bf71
	defb 094h,002h	; bf73
	defb 010h,001h	; bf75
	defb 014h,001h	; bf77
	defb 084h,002h	; bf79
	defb 080h,002h	; bf7b
	defb 010h,001h	; bf7d
	defb 018h,003h	; bf7f
	defb 010h,000h	; bf81
	defb 084h,002h	; bf83
	defb 080h,002h	; bf85
	defb 014h,001h	; bf87
	defb 084h,001h	; bf89
	defb 094h,001h	; bf8b
	defb 010h,000h	; bf8d
	defb 090h,007h	; bf8f
	defb 098h,003h	; bf91
	defb 011h,000h	; bf93
	defb 090h,003h	; bf95
	defb 010h,003h	; bf97
	defb 094h,002h	; bf99
	defb 090h,017h	; bf9b
	defb 011h,001h	; bf9d
	defb 080h,003h	; bf9f
	defb 010h,002h	; bfa1
	defb 090h,009h	; bfa3
	defb 014h,008h	; bfa5
	defb 010h,005h	; bfa7
	defb 018h,003h	; bfa9
	defb 010h,004h	; bfab
	defb 018h,000h	; bfad
	defb 098h,001h	; bfaf
	defb 010h,000h	; bfb1
	defb 090h,003h	; bfb3
	defb 000h,002h	; bfb5
	defb 020h,001h	; bfb7
	defb 098h,001h	; bfb9
	defb 000h,002h	; bfbb
	defb 090h,005h	; bfbd
	defb 098h,001h	; bfbf
	defb 090h,01ch	; bfc1
	defb 001h,003h	; bfc3
	defb 011h,002h	; bfc5
	defb 010h,005h	; bfc7
	defb 018h,006h	; bfc9
	defb 010h,003h	; bfcb
	defb 014h,003h	; bfcd
	defb 098h,001h	; bfcf
	defb 010h,003h	; bfd1
	defb 088h,003h	; bfd3
	defb 080h,004h	; bfd5
	defb 084h,006h	; bfd7
	defb 080h,00bh	; bfd9
	defb 090h,008h	; bfdb
	defb 014h,001h	; bfdd
	defb 094h,003h	; bfdf
	defb 010h,001h	; bfe1
	defb 018h,002h	; bfe3
	defb 090h,002h	; bfe5
	defb 010h,004h	; bfe7
	defb 080h,001h	; bfe9
	defb 014h,000h	; bfeb
	defb 088h,001h	; bfed
	defb 010h,003h	; bfef
	defb 080h,002h	; bff1
	defb 018h,005h	; bff3
	defb 010h,003h	; bff5
	defb 014h,002h	; bff7
	defb 010h,009h	; bff9
	defb 04fh	; bffb

; ----------------------------------------------------------------------
; DATOS relleno_BFFC: 4 bytes a 0xFF hasta el final de la pagina
;   0xbffc..0xc000  (4 bytes)
DATA_relleno_BFFC:
	defb 0ffh,0ffh,0ffh,0ffh	; bffc
