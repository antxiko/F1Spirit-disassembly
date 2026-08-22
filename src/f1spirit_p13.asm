; ==========================================================================
; F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC) - pagina 13 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ======================================================================
; CODIGO 0x6000..0x60e2  (226 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Entrada de ordenes: A = numero de sonido (1..70). 0x80-0x83 son
; ordenes de control (banderas de E160). Para las demas copia la
; cabecera del sonido (18 bytes) a E162 y, canal a canal segun la
; mascara del primer byte, arranca la pista si su prioridad gana a la
; que suena (0x60C2).
; ----------------------------------------------------------------------
SONIDO_ORDEN:		; A = numero de sonido; 0x80..0x83 control
	ld c,a			;6000   ; el numero pedido se guarda en C porque A hace falta para mirar las ordenes de control
	cp 080h		;6001   ; 0x80..0x83 no son sonidos: son el mando del fundido y de la pausa
	jp z,FUNDIDO_QUITA		;6003
	cp 081h		;6006   ; 0x81 enciende el fundido de salida
	jp z,FUNDIDO_ARRANCA		;6008
	cp 082h		;600b   ; 0x82 lo saca de la pausa
	jp z,PAUSA_QUITA		;600d
	cp 083h		;6010   ; CALL y no JP a proposito: al volver de la pausa sigue por 0x6015 con C = 0x2D
	call z,PAUSA_PON		;6012
	ld hl,0e161h		;6015   ; E161 = el ultimo sonido pedido; SONIDO_CANAL lo copia en cada canal que ocupe
	ld (hl),c			;6018   ; el sonido queda apuntado antes de repartirlo por los canales
	ld hl,0611eh		;6019   ; la tabla se indexa como si tuviese entrada 0, que caeria en el codigo: el sonido 0 no existe
	ld a,c			;601c
	add a,c			;601d   ; dos bytes por entrada, de ahi sumar C dos veces
	ld e,a			;601e
	ld d,000h		;601f
	add hl,de			;6021
	ld e,(hl)			;6022   ; HL = la cabecera del sonido, dentro de 0x61AC-0x6422
	inc hl			;6023
	ld d,(hl)			;6024
	ex de,hl			;6025   ; HL = la cabecera en la ROM, DE = donde se copia en RAM
	ld de,0e162h		;6026   ; la cabecera se copia a RAM para poder recorrerla con esta pagina ya desmapeada
	ld bc,00012h		;6029   ; 18 bytes fijos: mascara, prioridad y ocho punteros de pista; se copian sobren o no
	ldir		;602c
	ld ix,0e164h		;602e   ; IX = el primer puntero de pista de la copia, y avanza dos por cada canal que se use
	ld hl,0e162h		;6032   ; el primer byte de la cabecera es la mascara de canales
	bit 7,(hl)		;6035   ; bit 7 = canal 0; el reparto va del canal 0 al 7 en ocho bloques iguales
	jr z,L_6045		;6037
	inc hl			;6039   ; el segundo byte de la cabecera es la prioridad
	ld a,(hl)			;603a   ; E163 = la prioridad, la misma para todos los canales del sonido
	ld hl,0e001h		;603b   ; canal 0: PSG A
	call SONIDO_CANAL		;603e
	inc ix		;6041   ; el puntero de pista solo avanza si el canal iba en la mascara
	inc ix		;6043
L_6045:
	ld hl,0e162h		;6045
	bit 6,(hl)		;6048   ; bit 6 = canal 1
	jr z,L_6058		;604a
	inc hl			;604c
	ld a,(hl)			;604d
	ld hl,0e02dh		;604e   ; canal 1: PSG B
	call SONIDO_CANAL		;6051
	inc ix		;6054
	inc ix		;6056
L_6058:
	ld hl,0e162h		;6058
	bit 5,(hl)		;605b   ; bit 5 = canal 2
	jr z,L_606B		;605d
	inc hl			;605f
	ld a,(hl)			;6060
	ld hl,0e059h		;6061   ; canal 2: PSG C
	call SONIDO_CANAL		;6064
	inc ix		;6067
	inc ix		;6069
L_606B:
	ld hl,0e162h		;606b
	bit 4,(hl)		;606e   ; bit 4 = canal 3
	jr z,L_607E		;6070
	inc hl			;6072
	ld a,(hl)			;6073
	ld hl,0e085h		;6074   ; canal 3: el primero del SCC
	call SONIDO_CANAL		;6077
	inc ix		;607a
	inc ix		;607c
L_607E:
	ld hl,0e162h		;607e
	bit 3,(hl)		;6081   ; bit 3 = canal 4
	jr z,L_6091		;6083
	inc hl			;6085
	ld a,(hl)			;6086
	ld hl,0e0b1h		;6087   ; canal 4: segundo del SCC
	call SONIDO_CANAL		;608a
	inc ix		;608d
	inc ix		;608f
L_6091:
	ld hl,0e162h		;6091
	bit 2,(hl)		;6094   ; bit 2 = canal 5
	jr z,L_60A4		;6096
	inc hl			;6098
	ld a,(hl)			;6099
	ld hl,0e0ddh		;609a   ; canal 5: tercero del SCC
	call SONIDO_CANAL		;609d
	inc ix		;60a0
	inc ix		;60a2
L_60A4:
	ld hl,0e162h		;60a4
	bit 1,(hl)		;60a7   ; bit 1 = canal 6
	jr z,L_60B7		;60a9
	inc hl			;60ab
	ld a,(hl)			;60ac
	ld hl,0e109h		;60ad   ; canal 6: cuarto del SCC
	call SONIDO_CANAL		;60b0
	inc ix		;60b3
	inc ix		;60b5
L_60B7:
	ld hl,0e162h		;60b7
	bit 0,(hl)		;60ba   ; bit 0 = canal 7, el ultimo; por eso aqui se sale con RET y no con salto
	ret z			;60bc
	inc hl			;60bd
	ld a,(hl)			;60be
	ld hl,0e135h		;60bf   ; canal 7: quinto del SCC, y se entra en SONIDO_CANAL cayendo
SONIDO_CANAL:		; arranca la pista en el canal HL si la prioridad A gana a la suya
	ld b,(hl)			;60c2   ; B = la prioridad de lo que ya esta sonando en ese canal
	cp b			;60c3   ; gana el numero mas alto, y en el empate gana el que llega: el sonido nuevo se queda el canal
	ret c			;60c4   ; pierde: ni se toca el canal ni se apunta nada
	ex de,hl			;60c5   ; DE recorre el bloque del canal de corrido a partir de aqui
	ld (de),a			;60c6   ; +01 = la prioridad nueva
	dec de			;60c7   ; hacia atras, que el +00 esta por debajo de la base con que se llamo
	ld hl,0e161h		;60c8   ; E161 sigue guardando el sonido pedido, aunque HL e IX hayan cambiado de manos
	ld a,(hl)			;60cb   ; A = el sonido pedido, guardado en 0x6015
	ld (de),a			;60cc   ; +00 = el numero de sonido: es lo que mira 0x645D para saber si el canal esta ocupado
	inc de			;60cd
	inc de			;60ce   ; se salta el +01, que ya lleva la prioridad
	ld a,(ix+000h)		;60cf   ; +02/+03 = la pista de ESTE canal, la que apunto IX en la copia de la cabecera
	ld (de),a			;60d2
	inc de			;60d3
	ld a,(ix+001h)		;60d4   ; el byte alto de la pista
	ld (de),a			;60d7
	inc de			;60d8
	ld hl,060e2h		;60d9   ; los doce bytes con que arranca todo lo demas del bloque
	ld bc,0000ch		;60dc   ; doce bytes: de +04 a +0F
	ldir		;60df   ; +04 a 1 y +05..+0F a cero: la cuenta atras salta en el fotograma siguiente y el canal empieza sin interprete
	ret			;60e1

; ----------------------------------------------------------------------
; DATOS tabla_60D9: los 12 bytes con que SONIDO_CANAL (0x60D9) inicializa un
;   canal: +04 a 1 (la cuenta atras salta en el fotograma siguiente) y
;   +05..+0F a cero, asi que el canal arranca sin interprete, sin banderas y
;   con la mezcla callada
;   0x60e2..0x60ee  (12 bytes)
DATA_tabla_60D9:
	defb 001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 60e2  ............

; ======================================================================
; CODIGO 0x60ee..0x6120  (50 bytes)
; ======================================================================


FUNDIDO_QUITA:		; orden 0x80: cancela el fundido y pone su reloj a cero
	ld hl,0e160h		;60ee   ; bit 0 de E160 = fundido en marcha
	res 0,(hl)		;60f1
	jr FUNDIDO_A_CERO		;60f3
FUNDIDO_ARRANCA:		; orden 0x81: enciende el fundido de salida
	ld hl,0e160h		;60f5
	set 0,(hl)		;60f8   ; encender el fundido es solo el bit: el trabajo lo hace 0x679C fotograma a fotograma
FUNDIDO_A_CERO:		; reloj (E174) y nivel (E175) del fundido a cero
	ld hl,0e174h		;60fa   ; las dos ordenes dejan el fundido en el escalon cero
	xor a			;60fd   ; un fundido siempre empieza desde arriba
	ld (hl),a			;60fe
	inc hl			;60ff
	ld (hl),a			;6100
	ret			;6101
PAUSA_QUITA:		; orden 0x82: quita la pausa y devuelve el fundido que aparco
	ld hl,0e160h		;6102
	res 1,(hl)		;6105   ; bit 1 = pausa
	bit 3,(hl)		;6107   ; si el fundido quedo aparcado en el bit 3 al pausar, se devuelve al bit 0
	jr z,L_610F		;6109
	res 3,(hl)		;610b   ; el fundido que se aparco al pausar vuelve a estar en marcha
	set 0,(hl)		;610d
L_610F:
	ret			;610f
PAUSA_PON:		; orden 0x83: pausa, aparca el fundido y deja C = sonido 0x2D
	ld hl,0e160h		;6110
	set 1,(hl)		;6113   ; pausar es encender el bit 1
	bit 0,(hl)		;6115   ; el fundido no sigue corriendo durante la pausa: se aparca en el bit 3
	jr z,L_611D		;6117
	res 0,(hl)		;6119
	set 3,(hl)		;611b   ; el bit 3 recuerda que al pausar habia un fundido en marcha
L_611D:
	ld c,02dh		;611d   ; vuelve a 0x6015 pidiendo el sonido 0x2D, que es lo que se oye al pausar
	ret			;611f

; ----------------------------------------------------------------------
; DATOS tabla_sonidos: punteros a las cabeceras de los sonidos 1..70 (`ld
;   hl,611Eh` en 0x6019 y 2*A: la entrada 0, en 0x611E, son los bytes 2D C9
;   del codigo; el sonido 0 no existe)
;   0x6120..0x61ac  (140 bytes)
DATA_tabla_sonidos:
	defw 061ach,061b2h,061c4h,061cch,061d2h,061d8h,061deh,061e4h	; 6120
	defw 061eah,061f0h,061f6h,061fch,06202h,06208h,0620ch,06212h	; 6130
	defw 06218h,0621eh,06224h,0622ah,06230h,06236h,0623ch,06242h	; 6140
	defw 06248h,0624eh,06254h,0625ah,06260h,06266h,0626ch,06272h	; 6150
	defw 06278h,0627eh,06284h,06288h,0628ch,06292h,06298h,0629eh	; 6160
	defw 062b0h,062beh,062cch,062deh,062e6h,062f8h,062fch,06300h	; 6170
	defw 06304h,06308h,0630ch,0631eh,06330h,0633eh,0634ah,06356h	; 6180
	defw 0637ah,06386h,06392h,063b6h,063c4h,063d6h,063e8h,063fah	; 6190
	defw 06362h,0639eh,0636eh,063aah,0640ch,06410h	; 61a0

; ----------------------------------------------------------------------
; DATOS cabeceras_sonidos: las cabeceras de los 70 sonidos: mascara de canales
;   y, por canal, prioridad y puntero a la pista (formato exacto pendiente de
;   leer en 0x6023-0x60E1)
;   0x61ac..0x6422  (630 bytes)
DATA_cabeceras_sonidos:
	defb 030h,014h,070h,073h,070h,073h,0ffh,03ch,009h,074h,044h,074h,07fh,074h,08fh,074h	; 61ac  0.psps.<.tDt.t.t
	defb 09dh,074h,0afh,074h,0c1h,074h,0d3h,074h,038h,00eh,0e5h,074h,0f1h,074h,0ffh,074h	; 61bc  .t.t.t.t8..t.t.t
	defb 028h,003h,071h,073h,07dh,073h,028h,003h,087h,073h,0c8h,073h,030h,003h,071h,073h	; 61cc  (.qs}s(..s.s0.qs
	defb 07dh,073h,028h,003h,071h,073h,07dh,073h,030h,003h,087h,073h,0c8h,073h,028h,003h	; 61dc  }s(.qs}s0..s.s(.
	defb 087h,073h,0c8h,073h,030h,003h,071h,073h,07dh,073h,030h,003h,087h,073h,0c8h,073h	; 61ec  .s.s0.qs}s0..s.s
	defb 030h,008h,00fh,075h,0a4h,075h,028h,008h,00fh,075h,0a4h,075h,020h,001h,001h,076h	; 61fc  0..u.u(..u.u ..v
	defb 030h,00bh,0aeh,076h,047h,077h,028h,00bh,0aeh,076h,047h,077h,030h,004h,09ah,077h	; 620c  0..vGw(..vGw0..w
	defb 0f7h,077h,028h,004h,09ah,077h,0f7h,077h,030h,004h,0b6h,077h,0feh,077h,028h,004h	; 621c  .w(..w.w0..w.w(.
	defb 0b6h,077h,0feh,077h,030h,008h,038h,078h,097h,078h,028h,008h,038h,078h,097h,078h	; 622c  .w.w0.8x.x(.8x.x
	defb 030h,009h,0f6h,078h,03fh,079h,028h,009h,0f6h,078h,03fh,079h,030h,00ch,08eh,079h	; 623c  0..x?y(..x?y0..y
	defb 0ddh,079h,028h,00ch,08eh,079h,0ddh,079h,030h,010h,01fh,07ah,074h,07ah,028h,010h	; 624c  .y(..y.y0..ztz(.
	defb 01fh,07ah,074h,07ah,030h,00fh,0e5h,07ah,052h,07bh,028h,00fh,0e5h,07ah,052h,07bh	; 625c  .ztz0..zR{(..zR{
	defb 030h,00fh,0bdh,07bh,022h,07ch,028h,00fh,0bdh,07bh,022h,07ch,030h,00ah,085h,07ch	; 626c  0..{"|(..{"|0..|
	defb 01ch,07dh,028h,00ah,085h,07ch,01ch,07dh,020h,001h,07fh,07dh,020h,030h,0beh,07dh	; 627c  .}(..|.} ..} 0.}
	defb 030h,016h,0bfh,07dh,0f4h,07dh,030h,016h,029h,07eh,062h,07eh,030h,015h,097h,07eh	; 628c  0..}.}0.)~b~0..~
	defb 098h,07eh,0ffh,018h,099h,07eh,09ah,07eh,09bh,07eh,09ch,07eh,09dh,07eh,09eh,07eh	; 629c  .~...~.~.~.~.~.~
	defb 09fh,07eh,0a0h,07eh,0e7h,040h,0a1h,07eh,0b8h,07eh,0c0h,07eh,0c8h,07eh,0f1h,07eh	; 62ac  .~.~.@.~.~.~.~.~
	defb 0f9h,07eh,0e7h,041h,001h,07fh,01ah,07fh,022h,07fh,02ah,07fh,053h,07fh,05bh,07fh	; 62bc  .~.A....".*.S.[.
	defb 0ffh,010h,078h,07fh,063h,07fh,064h,07fh,072h,080h,01fh,082h,06dh,07fh,065h,07fh	; 62cc  ..x.c.d.r...m.e.
	defb 077h,07fh,038h,010h,078h,07fh,072h,080h,01fh,082h,0ffh,0feh,02bh,082h,02ch,082h	; 62dc  w.8.x.r.....+.,.
	defb 02dh,082h,035h,082h,041h,082h,05bh,082h,05ch,082h,05dh,082h,000h,001h,05eh,082h	; 62ec  -.5.A.[.\.]...^.
	defb 000h,001h,05fh,082h,000h,001h,060h,082h,000h,001h,061h,082h,000h,001h,062h,082h	; 62fc  .._...`...a...b.
	defb 0ffh,03ch,063h,082h,094h,082h,0abh,082h,014h,083h,042h,083h,071h,083h,085h,083h	; 630c  .<c.......B.q...
	defb 0f0h,083h,0ffh,03ch,059h,084h,0b9h,084h,01dh,085h,029h,085h,054h,085h,07ah,085h	; 631c  ...<Y.....).T.z.
	defb 092h,085h,0adh,085h,0cfh,03ch,0c7h,085h,0feh,085h,06ch,086h,0fch,086h,05fh,087h	; 632c  .....<....l..._.
	defb 0a0h,087h,0c7h,03ch,0d5h,087h,091h,088h,04ch,089h,050h,08ah,051h,08bh,0c7h,03ch	; 633c  ...<....L.P.Q..<
	defb 03ah,08ch,0b1h,08ch,078h,08dh,0a5h,08eh,0a6h,08fh,0c7h,03ch,097h,090h,022h,091h	; 634c  :...x......<..".
	defb 058h,091h,05ah,092h,05bh,093h,0c7h,03ch,011h,094h,0bbh,094h,048h,095h,079h,096h	; 635c  X.Z.[..<....H.y.
	defb 06ch,097h,0c7h,03ch,087h,098h,01dh,099h,015h,09ah,024h,09bh,042h,09ch,0c7h,03ch	; 636c  l..<......$.B..<
	defb 0d5h,087h,091h,088h,04ch,089h,050h,08ah,051h,08bh,0c7h,03ch,03ah,08ch,0b1h,08ch	; 637c  ....L.P.Q..<:...
	defb 078h,08dh,0a5h,08eh,0a6h,08fh,0c7h,03ch,097h,090h,022h,091h,058h,091h,05ah,092h	; 638c  x......<..".X.Z.
	defb 05bh,093h,0c7h,03ch,011h,094h,0bbh,094h,048h,095h,079h,096h,06ch,097h,0c7h,03ch	; 639c  [..<....H.y.l..<
	defb 087h,098h,01dh,099h,015h,09ah,024h,09bh,042h,09ch,0cfh,03ch,062h,09dh,09fh,09dh	; 63ac  ......$.B..<b...
	defb 0d7h,09dh,038h,09eh,08bh,09eh,0deh,09eh,0ffh,001h,034h,09fh,035h,09fh,036h,09fh	; 63bc  ..8.......4.5.6.
	defb 037h,09fh,038h,09fh,039h,09fh,03ah,09fh,03bh,09fh,0ffh,03ch,08eh,09fh,066h,09fh	; 63cc  7.8.9.:.;..<..f.
	defb 03ch,09fh,0d3h,09fh,002h,0a0h,048h,0a0h,094h,0a0h,0fah,0a0h,0ffh,03ch,05ah,0a1h	; 63dc  <.....H......<Z.
	defb 093h,0a1h,0d7h,0a1h,017h,0a2h,03ah,0a2h,09fh,0a2h,001h,0a3h,048h,0a3h,0ffh,03ch	; 63ec  ......:.....H..<
	defb 06eh,0a3h,07dh,0a3h,0f0h,0a3h,05fh,0a4h,093h,0a4h,003h,0a5h,037h,0a5h,0abh,0a5h	; 63fc  n.}..._.....7...
	defb 000h,03ch,0ddh,0a5h,0ffh,0ffh,0deh,0a5h,0deh,0a5h,0deh,0a5h,0deh,0a5h,0deh,0a5h	; 640c  .<..............
	defb 0deh,0a5h,0deh,0a5h,0deh,0a5h	; 641c

; ======================================================================
; CODIGO 0x6422..0x6557  (309 bytes)
; ======================================================================


SONIDO_6422:		; desde la interrupcion (0x4061), tras vaciar la cola de ordenes; que hace, pendiente
	ld a,(0e176h)		;6422   ; el registro 7 del PSG se reescribe cada fotograma desde su copia en RAM
	call L_6B68		;6425   ; el registro 7 se escribe entero aunque nadie lo haya cambiado
	ld a,(0e160h)		;6428   ; el fundido corre aunque ninguna partitura avance
	bit 0,a		;642b
	call nz,FUNDIDO_TICK		;642d   ; el fundido va primero, antes de que los canales calculen sus volumenes
	ld a,001h		;6430   ; E177 lleva la mascara del canal que se atiende, no su numero
	ld (0e177h),a		;6432
	ld ix,0e000h		;6435   ; canal 0 (PSG A)
	call CANAL_ATIENDE		;6439
	ld a,002h		;643c   ; canal 1 (PSG B)
	ld (0e177h),a		;643e
	ld ix,0e02ch		;6441
	call CANAL_ATIENDE		;6445
	ld a,004h		;6448   ; canal 2 (PSG C)
	ld (0e177h),a		;644a
	ld ix,0e058h		;644d
	call CANAL_ATIENDE		;6451
	ld a,008h		;6454   ; canal 3, el primero del SCC
	ld (0e177h),a		;6456
	ld ix,0e084h		;6459   ; IX = el bloque del canal, que es como se le pasa a todo lo demas
	ld a,(ix+000h)		;645d   ; si no hay sonido ocupando el canal se puede usar para el motor
	or a			;6460
	jr nz,L_6475		;6461   ; con un sonido de partitura encima, el motor no suena: manda el sonido
	ld a,(0e190h)		;6463   ; E190 lo lleva la pagina 2: dice si el ruido del motor tiene que sonar
	and 008h		;6466
	jr nz,L_6470		;6468
	ld (ix+00dh),000h		;646a   ; ni sonido ni motor: se calla la mezcla del canal
	jr L_6478		;646e
L_6470:
	call 0a5dfh		;6470   ; el motor no es una partitura: lo genera la rutina 0xA5DF de la pagina 15
	jr L_6478		;6473
L_6475:
	call CANAL_ATIENDE		;6475
L_6478:
	ld a,010h		;6478   ; canal 4, segundo del SCC
	ld (0e177h),a		;647a
	ld ix,0e0b0h		;647d
	ld a,(ix+000h)		;6481
	or a			;6484
	jr nz,L_6499		;6485
	ld a,(0e190h)		;6487   ; el otro bit del motor en E190
	and 080h		;648a
	jr nz,L_6494		;648c
	ld (ix+00dh),000h		;648e
	jr L_649C		;6492
L_6494:
	call 0a6feh		;6494   ; el segundo generador de motor, 0xA6FE de la pagina 15
	jr L_649C		;6497
L_6499:
	call CANAL_ATIENDE		;6499
L_649C:
	ld a,020h		;649c   ; canal 5
	ld (0e177h),a		;649e
	ld ix,0e0dch		;64a1
	call CANAL_ATIENDE		;64a5
	ld a,040h		;64a8   ; canal 6
	ld (0e177h),a		;64aa
	ld ix,0e108h		;64ad
	call CANAL_ATIENDE		;64b1
	ld a,080h		;64b4   ; canal 7
	ld (0e177h),a		;64b6
	ld ix,0e134h		;64b9
	call CANAL_ATIENDE		;64bd
	call SONIDO_PASO		;64c0   ; con los ocho canales al dia, se vuelca todo a los chips
	ret			;64c3
CANAL_ATIENDE:		; el paso de un canal, si es que tiene sonido
	ld a,(ix+000h)		;64c4   ; +00 a cero es canal libre: no hay nada que descontar
	or a			;64c7
	call nz,CANAL_TICK		;64c8
	ret			;64cb
CANAL_TICK:		; descuenta un fotograma y, si toca, lee la partitura
	dec (ix+004h)		;64cc   ; un fotograma menos para el proximo evento de la partitura
	jp nz,CANAL_ENTRE_NOTAS		;64cf   ; todavia no toca nota: solo corren la envolvente, el vibrato y el ADSR
	ld l,(ix+002h)		;64d2   ; HL = por donde iba la partitura de este canal
	ld h,(ix+003h)		;64d5   ; HL = la partitura, y a partir de aqui manda ella
PARTITURA_LEE:		; el bucle de lectura: ordenes hasta dar con una nota
	ld a,(hl)			;64d8
	cp 0ffh		;64d9   ; 0xFF cierra la pista y suelta el canal
	jp z,CANAL_LIBERA		;64db
	cp 0d0h		;64de   ; de 0xD0 arriba son ordenes; por debajo, notas
	jr c,NOTA_REPARTE		;64e0
	call PARTITURA_ORDEN		;64e2   ; las ordenes no consumen tiempo: se ejecutan y se sigue leyendo hasta dar con una nota
	inc hl			;64e5   ; el byte de la orden queda consumido
	jp PARTITURA_LEE		;64e6
NOTA_REPARTE:		; la nota va al interprete que diga +09
	bit 0,(ix+009h)		;64e9   ; +09 lo fija la orden 0xFE, y dice que clase de canal es este
	call nz,NOTA_NIBBLES		;64ed   ; bit 0: la nota son dos nibbles, altura y duracion
	bit 1,(ix+009h)		;64f0
	call nz,NOTA_CRUDA		;64f4   ; bit 1: la nota trae el periodo escrito tal cual
	bit 2,(ix+009h)		;64f7
	call nz,NOTA_ENVOLVENTE		;64fb   ; bit 2: la nota elige envolvente
	ret			;64fe
NOTA_NIBBLES:		; nota de un byte: nibble alto la altura, nibble bajo la duracion
	ld a,(hl)			;64ff   ; el nibble bajo es cuantas unidades de nota dura
	and 00fh		;6500   ; el nibble bajo
	ld b,a			;6502
	ld a,(ix+014h)		;6503   ; A = el tempo, la duracion de una unidad
	jr z,L_650C		;6506   ; el cero del AND: nibble bajo 0 es una unidad justa, sin multiplicar
	ld e,a			;6508
L_6509:
	add a,e			;6509   ; duracion = tempo por (nibble + 1), a base de sumas
	djnz L_6509		;650a   ; tantas sumas como diga el nibble
L_650C:
	ld (ix+004h),a		;650c   ; +04 = los fotogramas que va a durar la nota
	ld a,(hl)			;650f   ; el nibble alto es la altura dentro de la octava
	and 0f0h		;6510   ; el nibble alto
	rrca			;6512
	rrca			;6513
	rrca			;6514
	rrca			;6515
	call PARTITURA_AVANZA		;6516   ; la partitura ya se puede dejar apuntando al byte siguiente
	bit 3,(ix+009h)		;6519   ; bit 3 de +09: este canal solo cuenta el tiempo; la altura la usa quien llamo (0x65E4)
	ret nz			;651d   ; la altura se devuelve en A para quien la sepa aprovechar
	cp 00ch		;651e   ; las alturas 0..11 son las doce notas de la octava; de 12 arriba, silencio
	jr nc,NOTA_SILENCIO		;6520
	ld hl,06557h		;6522   ; la tabla de 0x6557 son los periodos de una octava, de la nota mas aguda a la mas grave
	ld e,a			;6525
	ld d,000h		;6526
	add hl,de			;6528   ; la altura indexa la tabla de periodos
	ld l,(hl)			;6529   ; el periodo cabe en un byte porque es la octava mas alta
	ld h,000h		;652a   ; un periodo de un byte, que la tabla es de la octava mas alta
	ld a,(ix+016h)		;652c   ; +16 = cuantas octavas hay que bajar
	or a			;652f
	jr z,L_6536		;6530
	ld b,a			;6532
L_6533:
	add hl,hl			;6533   ; bajar una octava es doblar el periodo
	djnz L_6533		;6534   ; una vuelta por octava
L_6536:
	ld (ix+010h),l		;6536   ; +10/+11 = el periodo que pide la nota
	ld (ix+011h),h		;6539   ; el byte alto lo pone el desplazamiento
	ld e,(ix+015h)		;653c   ; esta nota no trae volumen: se toca con el volumen base del canal
	ld a,(0e160h)		;653f
	bit 0,a		;6542   ; con el fundido en marcha, el volumen baja antes de escribirse
	call nz,FUNDIDO_APLICA		;6544
	ld (ix+012h),e		;6547   ; +12 = el volumen de la nota, ya atenuado si habia fundido
	ld (ix+00dh),002h		;654a   ; mezcla 2 = solo tono; una nota de altura siempre enciende el tono
	call NOTA_MONTA		;654e   ; y con eso la nota queda montada
	ret			;6551
NOTA_SILENCIO:		; alturas 12..15: silencio, se apaga la mezcla del canal
	ld (ix+00dh),000h		;6552   ; silencio no es volumen cero: se apaga la mezcla y el canal deja de sonar
	ret			;6556

; ----------------------------------------------------------------------
; DATOS tabla_6522: los periodos de una octava, que es lo que indexa la altura
;   de la nota en 0x6522: 12 semitonos (0x6A a 0x38, cada uno un 6 % menor que
;   el anterior) mas el 0x35 de la octava siguiente, al que no llega nadie
;   porque 0x651E rechaza las alturas de 12 arriba
;   0x6557..0x6564  (13 bytes)
DATA_tabla_6522:
	defb 06ah,064h,05eh,059h,054h,04fh,04ah,046h,042h,03fh,03bh,038h,035h	; 6557  jd^YTOJFB?;85

; ======================================================================
; CODIGO 0x6564..0x6868  (772 bytes)
; ======================================================================


NOTA_CRUDA:		; nota con el periodo escrito tal cual, en uno o dos bytes
	ld a,(ix+00dh)		;6564   ; los dos bits bajos de +0D son la mezcla que pidieron las ordenes 0xE0..0xE3
	and 003h		;6567
	jr z,NOTA_CRUDA_FIN		;6569   ; mezcla 0: no suena nada, asi que la nota solo hace pasar el tiempo
	cp 001h		;656b
	jr z,NOTA_CRUDA_RUIDO		;656d   ; mezcla 1: solo ruido, y el ruido no tiene periodo
	ld a,(hl)			;656f   ; A = el primer byte de la nota
	bit 6,(ix+00eh)		;6570   ; bit 6: la nota es un solo byte y es el byte bajo del periodo
	jr nz,NOTA_CRUDA_BAJO		;6574
	bit 5,(ix+00eh)		;6576   ; bit 5: la nota es un solo byte con volumen y byte alto del periodo
	jr nz,NOTA_CRUDA_ALTO		;657a
	and 0f0h		;657c   ; el formato largo: nibble alto volumen, nibble bajo el alto del periodo
	ld b,a			;657e
	xor (hl)			;657f   ; el XOR contra el byte entero deja el nibble bajo
	ld d,a			;6580   ; D = el nibble bajo, que es la parte alta del periodo
	inc hl			;6581   ; el segundo byte de la nota
	ld a,(hl)			;6582   ; el segundo byte es la parte baja
	ld (ix+010h),a		;6583   ; +10/+11 = periodo de doce bits, byte bajo primero
	ld (ix+011h),d		;6586
	ld a,b			;6589
	rrca			;658a   ; el volumen estaba en el nibble alto
	rrca			;658b
	rrca			;658c
	rrca			;658d
	ld b,a			;658e   ; B = el volumen que pedia la nota
	jr NOTA_CRUDA_VOL		;658f
NOTA_CRUDA_BAJO:		; formato corto (+0E bit 6): solo el byte bajo del periodo
	ld (ix+010h),a		;6591   ; formato corto: solo cambia el byte bajo del periodo
	jr NOTA_CRUDA_APLICA		;6594   ; y no trae volumen, asi que se salta el calculo
NOTA_CRUDA_ALTO:		; formato corto (+0E bit 5): volumen y byte alto del periodo
	and 0f0h		;6596   ; formato corto con volumen: nibble alto el volumen
	rrca			;6598
	rrca			;6599
	rrca			;659a
	rrca			;659b
	ld b,a			;659c   ; B = el volumen
	ld a,(hl)			;659d
	and 00fh		;659e   ; y el nibble bajo es el alto del periodo
	ld (ix+011h),a		;65a0   ; +11 = el nibble bajo, el alto del periodo
	jr NOTA_CRUDA_VOL		;65a3
NOTA_CRUDA_RUIDO:		; mezcla 1 (solo ruido): el byte es volumen, no hay periodo
	ld a,(hl)			;65a5   ; en el ruido el byte entero es volumen
	and 00fh		;65a6
	ld b,a			;65a8
NOTA_CRUDA_VOL:		; el volumen de la nota, con el apano de la envolvente por hardware
	ld a,(0e177h)		;65a9   ; lo que sigue solo vale para los tres canales del PSG
	cp 008h		;65ac
	jr nc,L_65B8		;65ae
	bit 2,(ix+00dh)		;65b0   ; con la envolvente por hardware el volumen no es un numero: es el bit 4 del registro
	jr z,L_65B8		;65b4
	ld b,010h		;65b6   ; 0x10 en el registro de volumen del PSG = manda la envolvente
L_65B8:
	inc b			;65b8   ; el nibble se escribe en la pista con dos escalones menos de los que suenan
	inc b			;65b9   ; con la envolvente por hardware el 0x10 queda en 0x12, que para el PSG sigue siendo el bit 4
	ld (ix+012h),b		;65ba   ; +12 = el volumen que pide la nota
NOTA_CRUDA_APLICA:		; pasa el volumen por el fundido y monta la nota
	ld e,(ix+012h)		;65bd   ; el volumen que se escribe sale de +12, no del byte de la nota
	ld a,(0e160h)		;65c0
	bit 0,a		;65c3
	call nz,FUNDIDO_APLICA		;65c5   ; el fundido resta antes de que el volumen llegue al chip
	ld (ix+012h),e		;65c8   ; +12 se queda ya atenuado: en el formato corto de un byte, que no lo recalcula, el fundido vuelve a restar sobre lo restado
	call NOTA_MONTA		;65cb   ; con periodo y volumen en su sitio, se monta la nota
NOTA_CRUDA_FIN:		; avanza el puntero y carga la duracion fija de +13
	bit 3,(ix+009h)		;65ce   ; bit 3 de +09: viene de la envolvente, que lleva su propio puntero y su propio reloj
	ret nz			;65d2
	call PARTITURA_AVANZA		;65d3   ; la nota cruda ya esta leida: el puntero pasa al byte siguiente
	ld a,(ix+013h)		;65d6   ; estas notas no traen duracion: dura lo que dijeron las ordenes 0xE0..0xE3
	ld (ix+004h),a		;65d9
	ret			;65dc
NOTA_ENVOLVENTE:		; nota de canal con envolvente: la altura elige una de las diez
	ld (ix+009h),009h		;65dd   ; 9 = bits 0 y 3: se usa el lector de nibbles, pero sin tocar la altura
	call NOTA_NIBBLES		;65e1   ; asi calcula la duracion y devuelve la altura en A
	ld hl,06e23h		;65e4   ; la altura no es una nota: es cual de las diez envolventes
	add a,a			;65e7   ; dos bytes por entrada en la tabla de envolventes
	ld e,a			;65e8
	ld d,000h		;65e9
	add hl,de			;65eb
	ld e,(hl)			;65ec   ; HL = la envolvente, que es otra partitura
	inc hl			;65ed
	ld d,(hl)			;65ee
	ex de,hl			;65ef
	ld a,(hl)			;65f0   ; este byte no lo usa nadie: 0x64D8 vuelve a leer (HL) nada mas entrar
	set 0,(ix+00eh)		;65f1   ; bit 0 de +0E = hay envolvente corriendo en este canal
ENVOLVENTE_PASO:		; lee un paso de la envolvente con el mismo interprete que la partitura
	ld (ix+009h),00ah		;65f5   ; 0x0A = bits 1 y 3: los pasos de la envolvente son notas crudas sin avanzar la partitura
	call PARTITURA_LEE		;65f9   ; la envolvente se lee con el mismo interprete que la partitura, ordenes incluidas
	ld a,(ix+013h)		;65fc   ; la duracion que dejo el paso es lo que dura este escalon
	ld (ix+019h),a		;65ff   ; +19 = los fotogramas que dura este escalon
	inc hl			;6602   ; +17/+18 = por donde sigue la envolvente el proximo escalon
	ld (ix+017h),l		;6603
	ld (ix+018h),h		;6606
	ld (ix+009h),004h		;6609   ; y el canal vuelve a ser de los de envolvente
	ret			;660d
NOTA_MONTA:		; deja periodo y volumen listos para que 0x6AA5 los escriba
	call PERIODO_EFECTIVO		;660e   ; el periodo efectivo se recalcula porque el detune puede haber cambiado
	res 4,(ix+00eh)		;6611   ; nota nueva, vibrato desde el principio: se olvida el retardo cumplido
	ld a,(ix+00fh)		;6615   ; borra las fases 3 y 5 del ADSR y conserva el resto
	and 0d7h		;6618
	ld (ix+00fh),a		;661a
	xor a			;661d   ; contadores del vibrato y del ADSR a cero
	ld (ix+01dh),a		;661e   ; los contadores del vibrato
	ld (ix+01eh),a		;6621
	ld (ix+01fh),a		;6624   ; y los del ADSR
	ld (ix+020h),a		;6627
	set 2,(ix+00fh)		;662a   ; por defecto se da el ataque por cumplido: solo lo deshace el tener ataque de verdad
	ld a,(ix+012h)		;662e   ; el volumen que pidio la nota
	bit 7,(ix+00eh)		;6631   ; bit 7: el volumen de la nota es relativo al volumen base del canal
	jr z,L_663E		;6635
	ld e,(ix+015h)		;6637   ; el volumen base del canal hace de cero
	sub e			;663a
	call m,VOLUMEN_A_CERO		;663b   ; si la resta se pasa de cero, se queda en cero
L_663E:
	ld (ix+00ch),a		;663e   ; +0C es lo que 0x6AB9 escribira en el chip
	ld a,(0e177h)		;6641   ; lo que sigue solo estorba en el PSG
	cp 008h		;6644
	jr nc,L_664D		;6646
	bit 2,(ix+00dh)		;6648   ; con la envolvente por hardware el volumen no se toca mas
	ret nz			;664c
L_664D:
	bit 1,(ix+00fh)		;664d   ; bit 1 de +0F: sin ataque el volumen ya esta puesto y no hay nada mas que hacer
	ret z			;6651
	ld a,(ix+025h)		;6652   ; con ataque, la nota empieza en el volumen de +25 y sube desde ahi
	ld (ix+00ch),a		;6655   ; el volumen efectivo arranca donde diga +25
	res 2,(ix+00fh)		;6658   ; y se marca que el ataque esta por hacer
	ret			;665c
VOLUMEN_A_CERO:		; el volumen relativo no puede quedar por debajo de cero
	xor a			;665d
	ret			;665e
CANAL_ENTRE_NOTAS:		; lo que se hace en los fotogramas en que no hay evento
	bit 0,(ix+00eh)		;665f   ; entre nota y nota corren los tres efectos, cada uno con su bandera
	call nz,ENVOLVENTE_TICK		;6663   ; la envolvente puede cambiar la nota sin que la partitura avance
	bit 2,(ix+00eh)		;6666
	call nz,VIBRATO_TICK		;666a   ; el vibrato mueve el periodo
	bit 0,(ix+00fh)		;666d   ; bit 0 de +0F: el ADSR esta encendido
	call nz,ADSR_TICK		;6671   ; el ADSR mueve el volumen
	ret			;6674
ENVOLVENTE_TICK:		; descuenta el paso de la envolvente y lee el siguiente
	dec (ix+019h)		;6675   ; un fotograma menos de este escalon de la envolvente
	ret nz			;6678
	ld l,(ix+017h)		;6679   ; +17/+18 = donde se quedo la envolvente
	ld h,(ix+018h)		;667c
	ld a,(hl)			;667f   ; el byte del escalon siguiente
	cp 0ffh		;6680   ; 0xFF cierra la envolvente
	jr z,ENVOLVENTE_FIN		;6682
	call ENVOLVENTE_PASO		;6684   ; y si no, se lee el escalon siguiente
	ret			;6687
ENVOLVENTE_FIN:		; 0xFF en la envolvente: se apaga y calla el canal
	res 0,(ix+00eh)		;6688   ; la envolvente se apaga y de paso calla el canal
	ld (ix+00dh),000h		;668c   ; y el canal se queda callado hasta la nota que venga
	ret			;6690
PERIODO_EFECTIVO:		; suma el detune al periodo de la nota
	ld e,(ix+010h)		;6691   ; el periodo que pide la nota
	ld d,(ix+011h)		;6694
	bit 1,(ix+00eh)		;6697   ; bit 1 de +0E: hay detune
	jr z,L_66A5		;669b
	ld a,(ix+026h)		;669d   ; el detune se suma con acarreo al periodo de doce bits
	add a,e			;66a0
	ld e,a			;66a1
	jr nc,L_66A5		;66a2
	inc d			;66a4
L_66A5:
	ld (ix+00ah),e		;66a5   ; +0A/+0B es lo que 0x6AB9 y 0x6C97 comparan y escriben en los chips
	ld (ix+00bh),d		;66a8
	ret			;66ab
VIBRATO_TICK:		; cuenta hasta el retardo y luego hasta el periodo del vibrato
	inc (ix+01eh)		;66ac   ; un fotograma mas de vibrato
	ld a,(ix+01eh)		;66af   ; A = el contador de fotogramas del vibrato
	ld b,(ix+00eh)		;66b2   ; las banderas se copian a B porque se miran dos veces seguidas
	bit 4,b		;66b5   ; bit 4: el retardo ya paso, se va derecho a mover el periodo
	jr nz,L_66CB		;66b7
	bit 3,b		;66b9   ; bit 3: este vibrato empieza con retardo
	jr z,L_66CB		;66bb
	cp (ix+01ah)		;66bd   ; el retardo se cumple cuando el contador llega a +1A
	ret nz			;66c0
	ld (ix+01eh),000h		;66c1   ; y a partir de aqui el mismo contador vale para el periodo del vibrato
	set 4,(ix+00eh)		;66c5   ; el retardo queda cumplido para lo que le quede a la nota
	jr VIBRATO_APLICA		;66c9
L_66CB:
	cp (ix+01bh)		;66cb   ; sin retardo pendiente, la oscilacion va cada +1B fotogramas
	ret nz			;66ce
VIBRATO_APLICA:		; suma o resta la amplitud al periodo, alternando el signo
	ld e,(ix+00ah)		;66cf   ; se trabaja sobre el periodo efectivo, no sobre el de la nota
	ld d,(ix+00bh)		;66d2
	ld b,(ix+01ch)		;66d5   ; B = la amplitud
	ld a,(ix+01dh)		;66d8   ; el signo de la oscilacion anterior
	cpl			;66db   ; el signo se invierte en cada oscilacion: 0 y 0xFF alternandose
	ld (ix+01dh),a		;66dc   ; y se guarda ya invertido para la siguiente
	and a			;66df   ; el signo de antes de invertirlo es el que manda en esta
	ld a,e			;66e0
	jr nz,L_66EA		;66e1
	add a,b			;66e3   ; medio ciclo hacia arriba
	ld e,a			;66e4
	jr nc,L_66EF		;66e5
	inc d			;66e7   ; el acarreo sube al byte alto del periodo
	jr L_66EF		;66e8
L_66EA:
	sub b			;66ea   ; y el otro medio hacia abajo
	ld e,a			;66eb
	jr nc,L_66EF		;66ec
	dec d			;66ee   ; y el prestamo lo baja
L_66EF:
	ld (ix+00ah),e		;66ef   ; el periodo movido, ya listo para el chip
	ld (ix+00bh),d		;66f2
	ld (ix+01eh),000h		;66f5   ; el contador arranca de nuevo para la proxima oscilacion
	ret			;66f9
ADSR_TICK:		; mueve el volumen del canal, salvo si manda la envolvente del PSG
	ld a,(0e177h)		;66fa   ; otra vez, esto solo estorba en el PSG
	cp 008h		;66fd
	jr nc,L_6706		;66ff
	bit 2,(ix+00dh)		;6701   ; con la envolvente por hardware el ADSR sobra
	ret nz			;6705
L_6706:
	call ADSR_FASE		;6706   ; E vuelve con el volumen nuevo
	ld (ix+00ch),e		;6709   ; +0C = el volumen que se escribira en el chip
	ret			;670c
ADSR_FASE:		; la fase en que esta la nota decide si el volumen sube o baja
	ld e,(ix+00ch)		;670d   ; E = el volumen que hay ahora mismo
	inc (ix+01fh)		;6710   ; B = fotogramas dentro de la fase actual
	ld b,(ix+01fh)		;6713
	bit 5,(ix+00fh)		;6716   ; bit 5: ya se llego a la fase final
	jr nz,ADSR_EXTINCION		;671a
	bit 3,(ix+00fh)		;671c   ; bit 3: la caida esta hecha
	jr nz,ADSR_DESCENSO		;6720
	bit 2,(ix+00fh)		;6722   ; bit 2: el ataque esta hecho
	jr nz,ADSR_CAIDA		;6726
	ld a,e			;6728   ; ataque: un escalon de volumen por fotograma
	inc a			;6729   ; un escalon de volumen arriba
	ld e,a			;672a
	cp (ix+012h)		;672b   ; hasta llegar al volumen que pidio la nota
	ret c			;672e   ; todavia no ha llegado al volumen de la nota
	set 2,(ix+00fh)		;672f   ; llegado ahi, el ataque se da por cumplido
	ld e,(ix+012h)		;6733   ; y el volumen se clava en el objetivo, sin pasarse
	ld (ix+01fh),000h		;6736   ; el contador arranca de cero para la fase siguiente
	ret			;673a
ADSR_CAIDA:		; despues del ataque el volumen baja uno por fotograma
	ld a,e			;673b   ; caida: el volumen baja de uno en uno
	dec a			;673c   ; un escalon abajo
	jp m,L_6741		;673d   ; sin bajar de cero
	ld e,a			;6740
L_6741:
	ld a,b			;6741
	cp (ix+021h)		;6742   ; la caida dura +21 fotogramas
	ret c			;6745
	ld (ix+01fh),000h		;6746   ; el contador arranca para la fase siguiente
	set 3,(ix+00fh)		;674a   ; la caida queda cumplida
	ret			;674e
ADSR_DESCENSO:		; la caida larga, uno a uno o a saltos de +22
	bit 4,(ix+00fh)		;674f   ; bit 4: el descenso resta de golpe en vez de escalon a escalon
	jp nz,ADSR_DESCENSO_SALTO		;6753
	ld a,b			;6756
	cp (ix+022h)		;6757   ; solo se mueve el volumen cada +22 fotogramas
	ret nz			;675a
	ld a,e			;675b
	dec a			;675c   ; un escalon, con suelo en cero
	ret m			;675d
	ld e,a			;675e
	inc (ix+020h)		;675f   ; un paso mas de descenso dado
	ld a,(ix+020h)		;6762
	cp (ix+023h)		;6765   ; tras +23 pasos se pasa a la fase final
	ld (ix+01fh),000h		;6768   ; el contador de fotogramas se reinicia lo baje o no
	ret nz			;676c
	set 5,(ix+00fh)		;676d
	ret			;6771
ADSR_DESCENSO_SALTO:		; el descenso a saltos: resta +22 de una vez
	ld a,(ix+022h)		;6772   ; aqui el descenso no es un escalon: se resta +22 entero
	ld d,a			;6775
	ld a,e			;6776
	sub d			;6777
	ld e,000h		;6778   ; y si se pasa de cero, cero
	jp m,L_677E		;677a
	ld e,a			;677d
L_677E:
	ld a,b			;677e
	cp (ix+023h)		;677f   ; la fase final llega tras +23 fotogramas
	ret nz			;6782
	set 5,(ix+00fh)		;6783
	ret			;6787
ADSR_EXTINCION:		; la ultima fase: baja de uno en uno al acercarse el fin de la nota
	ld a,(ix+004h)		;6788   ; +04 = los fotogramas que le quedan a la nota
	cp (ix+024h)		;678b   ; mientras falte mas de +24 no se apaga nada
	ret nc			;678e
	ld a,e			;678f
	dec a			;6790   ; en los ultimos +24 fotogramas el volumen se extingue de uno en uno
	ret m			;6791
	ld e,a			;6792
	ret			;6793
PARTITURA_AVANZA:		; deja el puntero del canal en el byte siguiente al leido
	inc hl			;6794   ; el byte leido se da por consumido
	ld (ix+002h),l		;6795
	ld (ix+003h),h		;6798
	ret			;679b
FUNDIDO_TICK:		; un escalon de fundido cada 32 fotogramas, nueve escalones
	ld hl,0e174h		;679c   ; el reloj del fundido
	inc (hl)			;679f
	ld a,(hl)			;67a0
	cp 020h		;67a1   ; un escalon cada 32 fotogramas
	ret nz			;67a3
	ld (hl),000h		;67a4
	inc hl			;67a6
	inc (hl)			;67a7   ; E175 = el escalon en que va el fundido
	ld a,(hl)			;67a8
	cp 009h		;67a9   ; nueve escalones y se acabo
	ret nz			;67ab
	ld hl,0e160h		;67ac
	res 0,(hl)		;67af   ; el fundido se apaga solo al llegar al final
	xor a			;67b1
	ld hl,0e174h		;67b2
	ld (hl),a			;67b5
	inc hl			;67b6
	ld (hl),a			;67b7
	ld a,(0e02ch)		;67b8   ; los canales 1 y 2 llevando el mismo sonido es la senal de que tambien hay que callarlos
	ld e,a			;67bb
	ld a,(0e058h)		;67bc
	cp e			;67bf
	jr nz,FUNDIDO_CALLA		;67c0
	ld ix,0e058h		;67c2   ; esos dos son los unicos que el fundido no calla por su cuenta
	call CANAL_LIBERA		;67c6
	ld ix,0e084h		;67c9
	call CANAL_LIBERA		;67cd
FUNDIDO_CALLA:		; apaga los canales al terminar el fundido
	ld de,0002ch		;67d0   ; 0x2C bytes de un canal al siguiente
	ld ix,0e000h		;67d3   ; y cada canal se calla por su cuenta
	call CANAL_LIBERA		;67d7
	add ix,de		;67da
	call CANAL_LIBERA		;67dc
	ld ix,0e0b0h		;67df   ; los canales del SCC empiezan en E0B0
	call CANAL_LIBERA		;67e3
	add ix,de		;67e6
	call CANAL_LIBERA		;67e8
	add ix,de		;67eb
	call CANAL_LIBERA		;67ed
	add ix,de		;67f0
	call CANAL_LIBERA		;67f2
	ret			;67f5
FUNDIDO_APLICA:		; resta el nivel del fundido al volumen que iba a sonar
	ld a,(0e02ch)		;67f6   ; la misma comprobacion que en 0x67B8: canales 1 y 2 con el mismo sonido
	ld b,a			;67f9
	ld a,(0e058h)		;67fa
	cp b			;67fd
	jr z,FUNDIDO_RESTA		;67fe
	ld a,(0e177h)		;6800   ; la mascara sin los bits de los canales 2 y 3
	and 0f3h		;6803
	ret z			;6805   ; esos dos canales no se atenuan: son los que siguen sonando durante el fundido
FUNDIDO_RESTA:		; E menos E175, con suelo en cero
	bit 2,(ix+00dh)		;6806   ; con la envolvente por hardware no hay volumen que restar: se calla y ya
	jr nz,L_6817		;680a
	ld a,(0e175h)		;680c   ; el nivel del fundido se resta al volumen
	ld b,a			;680f
	ld a,e			;6810
	sub b			;6811
	ld e,000h		;6812   ; y no se da la vuelta: el suelo es cero
	ret m			;6814
	ld e,a			;6815
	ret			;6816
L_6817:
	ld e,000h		;6817
	ret			;6819
CANAL_LIBERA:		; deja el canal libre y borra lo que estaba sonando
	xor a			;681a   ; soltar un canal es olvidar el sonido, la prioridad y las banderas
	ld (ix+000h),a		;681b
	ld (ix+001h),a		;681e
	ld (ix+005h),a		;6821   ; tambien las vueltas de los dos bucles de repeticion
	ld (ix+006h),a		;6824
	ld (ix+00ah),a		;6827   ; y el periodo y el volumen que iban a escribirse
	ld (ix+00bh),a		;682a
	ld (ix+00ch),a		;682d
	ld (ix+00dh),a		;6830
	ld (ix+00eh),a		;6833
	ld (ix+00fh),a		;6836
	ld a,(0e177h)		;6839   ; lo que queda solo vale para el PSG
	cp 008h		;683c
	ret nc			;683e
	cp 004h		;683f   ; el canal 2 pide el ruido por un lado y los otros dos por otro
	ld hl,0e17ah		;6841   ; E17A dice que registros del PSG estan pendientes de escribir
	jr nz,L_6850		;6844
	res 1,(hl)		;6846   ; se retira la peticion de ruido de este canal
	bit 3,(hl)		;6848   ; si estaba servida, se pasa al bit que lo recuerda
	ret z			;684a
	res 3,(hl)		;684b
	set 2,(hl)		;684d
	ret			;684f
L_6850:
	res 3,(hl)		;6850
	ret			;6852
PARTITURA_ORDEN:		; byte >= 0xE0 del flujo: orden (A & 1F) por la tabla de 0x6868
	cp 0e0h		;6853   ; de 0xD0 a 0xDF son octava y volumen, que no gastan tabla
	jp c,L_6A90		;6855
	and 01fh		;6858   ; quedan 31 ordenes, de la 0xE0 a la 0xFE
	push hl			;685a   ; HL vuelve por la pila: cada orden lo recupera con su POP
	ld hl,06868h		;685b
	add a,a			;685e   ; dos bytes por entrada
	ld e,a			;685f
	ld d,000h		;6860
	add hl,de			;6862
	ld e,(hl)			;6863
	inc hl			;6864
	ld d,(hl)			;6865
	ex de,hl			;6866
	jp (hl)			;6867   ; se salta a la orden, y su RET devuelve al lector de la partitura

; ----------------------------------------------------------------------
; DATOS tabla_partitura: 31 palabras: las ordenes 0xE0..0xFE del interprete de
;   la partitura (jp (hl) en 0x6867)
;   0x6868..0x68a6  (62 bytes)
DATA_tabla_partitura:
	defw 068a6h	; 6868  -> L_68A6
	defw 068bch	; 686a  -> L_68BC
	defw 068a6h	; 686c  -> L_68A6
	defw 068bch	; 686e  -> L_68BC
	defw 068d9h	; 6870  -> L_68D9
	defw 06903h	; 6872  -> L_6903
	defw 06917h	; 6874  -> L_6917
	defw 06927h	; 6876  -> L_6927
	defw 06939h	; 6878  -> L_6939
	defw 06948h	; 687a  -> L_6948
	defw 0694fh	; 687c  -> L_694F
	defw 06956h	; 687e  -> L_6956
	defw 069a9h	; 6880  -> L_69A9
	defw 069afh	; 6882  -> L_69AF
	defw 069b6h	; 6884  -> L_69B6
	defw 069c1h	; 6886  -> L_69C1
	defw 069c7h	; 6888  -> L_69C7
	defw 069d1h	; 688a  -> L_69D1
	defw 069ech	; 688c  -> L_69EC
	defw 069fbh	; 688e  -> L_69FB
	defw 06a01h	; 6890  -> L_6A01
	defw 06a07h	; 6892  -> L_6A07
	defw 06a0dh	; 6894  -> L_6A0D
	defw 06a17h	; 6896  -> L_6A17
	defw 06a1dh	; 6898  -> L_6A1D
	defw 06a37h	; 689a  -> L_6A37
	defw 06a42h	; 689c  -> L_6A42
	defw 06a4ah	; 689e  -> L_6A4A
	defw 06a64h	; 68a0  -> L_6A64
	defw 06a79h	; 68a2  -> L_6A79
	defw 06a7ch	; 68a4  -> L_6A7C

; ======================================================================
; CODIGO 0x68a6..0x6b79  (723 bytes)
; ======================================================================


L_68A6:
	pop hl			;68a6
L_68A7:
	res 7,(ix+00eh)		;68a7   ; la vuelta comun de las ordenes: se sigue leyendo la partitura
	ld a,(hl)			;68ab   ; de aqui salen todas las ordenes que no cambian el flujo
	and 003h		;68ac
	ld (ix+00dh),a		;68ae
	ld b,a			;68b1
	inc hl			;68b2
	ld a,(hl)			;68b3
	ld (ix+013h),a		;68b4
	ld a,b			;68b7
	or a			;68b8
	ret nz			;68b9
	dec hl			;68ba
	ret			;68bb
L_68BC:
	pop hl			;68bc   ; el canal 4 -el del ruido- usa un par de bits y los demas otro
	ld a,(0e177h)		;68bd
	cp 004h		;68c0
	ld a,(0e17ah)		;68c2
	jr nz,L_68D0		;68c5
	set 0,a		;68c7
	res 1,a		;68c9
	ld (0e17ah),a		;68cb
	jr L_68A7		;68ce
L_68D0:
	set 2,a		;68d0
	res 3,a		;68d2
	ld (0e17ah),a		;68d4
	jr L_68A7		;68d7
L_68D9:
	pop hl			;68d9   ; el valor de ruido son cinco bits
	inc hl			;68da
	ld a,(hl)			;68db
	and 01fh		;68dc
	ld b,a			;68de
	ld a,(0e177h)		;68df
	cp 004h		;68e2
	ld a,b			;68e4
	jr nz,L_68F5		;68e5
	ld (0e178h),a		;68e7   ; el canal 4 escribe en E178...
	ld a,(0e17ah)		;68ea
	set 0,a		;68ed
	res 1,a		;68ef
	ld (0e17ah),a		;68f1
	ret			;68f4
L_68F5:
	ld (0e179h),a		;68f5   ; ...y los demas en E179
	ld a,(0e17ah)		;68f8
	set 2,a		;68fb
	res 3,a		;68fd
	ld (0e17ah),a		;68ff
	ret			;6902
L_6903:
	pop hl			;6903   ; el registro 13 es la FORMA de la envolvente
	inc hl			;6904
	res 3,(ix+00dh)		;6905
	ld a,(hl)			;6909
	ld (0e17bh),a		;690a
	ld de,0e17ah		;690d
	ld a,(de)			;6910
	set 5,a		;6911
	ld (de),a			;6913
	jp L_6918		;6914
L_6917:
	pop hl			;6917
L_6918:
	inc hl			;6918   ; el 12 es su periodo basto
	ld a,(hl)			;6919
	ld (0e17dh),a		;691a
	ld de,0e17ah		;691d
	ld a,(de)			;6920
	set 6,a		;6921
	ld (de),a			;6923
	jp L_6928		;6924
L_6927:
	pop hl			;6927
L_6928:
	inc hl			;6928   ; y el 11 el fino; los tres se marcan en E17A para escribirse en el paso siguiente
	ld a,(hl)			;6929
	ld (0e17ch),a		;692a
	ld de,0e17ah		;692d
	ld a,(de)			;6930
	set 7,a		;6931
	ld (de),a			;6933
	set 2,(ix+00dh)		;6934
	ret			;6938
L_6939:
	pop hl			;6939   ; esta orden apaga todos los avisos de envolvente de golpe
	ld de,0e17ah		;693a
	xor a			;693d
	ld (de),a			;693e
	ld a,(ix+00dh)		;693f
	and 0f3h		;6942
	ld (ix+00dh),a		;6944
	ret			;6947
L_6948:
	pop hl			;6948
	inc hl			;6949
	ld a,(hl)			;694a
	ld (ix+014h),a		;694b
	ret			;694e
L_694F:
	pop hl			;694f
	inc hl			;6950
	ld a,(hl)			;6951
	ld (ix+015h),a		;6952
	ret			;6955
L_6956:
	pop hl			;6956   ; dos nibbles: el de arriba es el ataque y el de abajo la caida del vibrato
	inc hl			;6957
	ld a,(ix+00fh)		;6958
	and 080h		;695b
	ld (ix+00fh),a		;695d
	ld a,(hl)			;6960
	and 0f0h		;6961
	rrca			;6963   ; cuatro rotaciones para bajar el nibble alto
	rrca			;6964
	rrca			;6965
	rrca			;6966
	cp 008h		;6967   ; por debajo de 8 el ajuste es hacia arriba y de ahi en adelante hacia abajo: el bit 3 es el signo
	jp nc,L_6970		;6969
	set 2,(ix+00fh)		;696c
L_6970:
	res 3,a		;6970   ; el `res 3` quita ese bit de signo y el `inc a` deja el valor de 1 a 8
	inc a			;6972
	bit 2,(ix+00fh)		;6973
	jp nz,L_697E		;6977
	set 1,(ix+00fh)		;697a
L_697E:
	ld (ix+021h),a		;697e   ; el ataque a (ix+21)...
	ld a,(hl)			;6981
	and 00fh		;6982
	cp 008h		;6984
	jp c,L_698D		;6986
	set 4,(ix+00fh)		;6989
L_698D:
	res 3,a		;698d   ; ...y la caida a (ix+22), con el mismo apano del signo
	inc a			;698f
	ld (ix+022h),a		;6990
	inc hl			;6993
	ld a,(hl)			;6994   ; el tercer byte trae los otros dos tramos del vibrato
	and 0f0h		;6995
	rrca			;6997
	rrca			;6998
	rrca			;6999
	rrca			;699a
	ld (ix+023h),a		;699b
	ld a,(hl)			;699e
	and 00fh		;699f
	ld (ix+024h),a		;69a1
	set 0,(ix+00fh)		;69a4
	ret			;69a8
L_69A9:
	pop hl			;69a9
	res 0,(ix+00fh)		;69aa
	ret			;69ae
L_69AF:
	pop hl			;69af
	inc hl			;69b0
	ld a,(hl)			;69b1
	ld (ix+025h),a		;69b2
	ret			;69b5
L_69B6:
	pop hl			;69b6   ; (ix+26) es el deslizamiento de nota, y el bit 1 de (ix+0E) lo enciende
	inc hl			;69b7
	ld a,(hl)			;69b8
	ld (ix+026h),a		;69b9
	set 1,(ix+00eh)		;69bc
	ret			;69c0
L_69C1:
	pop hl			;69c1
	res 1,(ix+00eh)		;69c2
	ret			;69c6
L_69C7:
	pop hl			;69c7
	ld a,(ix+00eh)		;69c8
	and 0e2h		;69cb
	ld (ix+00eh),a		;69cd
	ret			;69d0
L_69D1:
	pop hl			;69d1   ; los dos nibbles de esta orden son las dos fases de la envolvente por software
	inc hl			;69d2
	ld a,(ix+00eh)		;69d3
	or 014h		;69d6   ; el `or 0x14` enciende de golpe los dos bits que hacen falta
	ld (ix+00eh),a		;69d8
	ld a,(hl)			;69db
	and 00fh		;69dc
	ld (ix+01ch),a		;69de
	ld a,(hl)			;69e1   ; y el nibble de abajo es la otra fase
	and 0f0h		;69e2
	rrca			;69e4
	rrca			;69e5
	rrca			;69e6
	rrca			;69e7
	ld (ix+01bh),a		;69e8
	ret			;69eb
L_69EC:
	pop hl			;69ec   ; y esta pone el paso, con dos bits mas de (ix+0E)
	inc hl			;69ed
	ld a,(hl)			;69ee
	ld (ix+01ah),a		;69ef
	ld a,(ix+00eh)		;69f2
	or 00ch		;69f5
	ld (ix+00eh),a		;69f7
	ret			;69fa
L_69FB:
	pop hl			;69fb
	res 3,(ix+00eh)		;69fc
	ret			;6a00
L_6A01:
	pop hl			;6a01
	set 6,(ix+00eh)		;6a02
	ret			;6a06
L_6A07:
	pop hl			;6a07
	set 5,(ix+00eh)		;6a08
	ret			;6a0c
L_6A0D:
	pop hl			;6a0d
	ld a,(ix+00eh)		;6a0e
	and 09fh		;6a11
	ld (ix+00eh),a		;6a13
	ret			;6a16
L_6A17:
	pop hl			;6a17
	res 7,(ix+00eh)		;6a18
	ret			;6a1c
L_6A1D:
	pop hl			;6a1d
	inc hl			;6a1e
	ld a,(hl)			;6a1f
L_6A20:
	ld de,06f04h		;6a20   ; la tabla de 0x6F04 son parejas: los dos bytes del efecto que se activa
	add a,a			;6a23
	add a,e			;6a24
	ld e,a			;6a25
	jr nc,L_6A29		;6a26
	inc d			;6a28
L_6A29:
	ld a,(de)			;6a29   ; el primero a (ix+27)...
	ld (ix+027h),a		;6a2a
	inc de			;6a2d
	ld a,(de)			;6a2e
	ld (ix+028h),a		;6a2f   ; ...y el segundo a (ix+28), con el bit 7 de (ix+0F) para encenderlo
	set 7,(ix+00fh)		;6a32
	ret			;6a36
L_6A37:
	pop hl			;6a37
	call L_6A56		;6a38
	ld (ix+007h),e		;6a3b
	ld (ix+008h),d		;6a3e
	ret			;6a41
L_6A42:
	pop hl			;6a42
	ld l,(ix+007h)		;6a43
	ld h,(ix+008h)		;6a46
	ret			;6a49
L_6A4A:
	pop hl			;6a4a   ; el bucle de la partitura: se cuenta una vuelta mas y, al llegar al tope, se sigue de largo
	inc hl			;6a4b
	ld a,(ix+005h)		;6a4c
	inc a			;6a4f
	cp (hl)			;6a50
	jr z,L_6A5D		;6a51
	ld (ix+005h),a		;6a53
L_6A56:
	inc hl			;6a56   ; el destino del salto viene detras de la orden, dos bytes
	ld e,(hl)			;6a57
	inc hl			;6a58
	ld d,(hl)			;6a59
	ex de,hl			;6a5a
	dec hl			;6a5b
	ret			;6a5c
L_6A5D:
	inc hl			;6a5d
	inc hl			;6a5e
	ld (ix+005h),000h		;6a5f
	ret			;6a63
L_6A64:
	pop hl			;6a64   ; el segundo bucle, con su propio contador en (ix+6)
	inc hl			;6a65
	ld a,(ix+006h)		;6a66
	inc a			;6a69
	cp (hl)			;6a6a
	jr z,L_6A72		;6a6b
	ld (ix+006h),a		;6a6d
	jr L_6A56		;6a70
L_6A72:
	inc hl			;6a72
	inc hl			;6a73
	ld (ix+006h),000h		;6a74
	ret			;6a78
L_6A79:
	pop hl			;6a79
	jr L_6A56		;6a7a
L_6A7C:
	pop hl			;6a7c   ; la orden 4 apaga los tres bytes de efectos del canal
	inc hl			;6a7d
	ld a,(hl)			;6a7e
	ld (ix+009h),a		;6a7f
	cp 004h		;6a82   ; y con el valor 4 se apagan ademas los tres bytes de estado
	ret nz			;6a84
	xor a			;6a85
	ld (ix+00dh),a		;6a86
	ld (ix+00eh),a		;6a89
	ld (ix+00fh),a		;6a8c
	ret			;6a8f
L_6A90:
	ld a,(hl)			;6a90   ; por debajo de 6 el valor va a (ix+16); de ahi arriba enciende el bit 6 y va a (ix+15)
	and 00fh		;6a91
	cp 006h		;6a93
	jr nc,L_6A9B		;6a95
	ld (ix+016h),a		;6a97
	ret			;6a9a
L_6A9B:
	set 6,(ix+00eh)		;6a9b
	sub 005h		;6a9f
	ld (ix+015h),a		;6aa1
	ret			;6aa4
SONIDO_PASO:		; el paso del reproductor, una vez por interrupcion (desde 0x4046)
	call L_6AAC		;6aa5   ; un paso del reproductor por interrupcion: primero los canales y luego la cola
	call L_6B85		;6aa8
	ret			;6aab
L_6AAC:
	call L_6AB9		;6aac
	call L_6AEE		;6aaf
	call L_6B17		;6ab2
	call L_6B45		;6ab5
	ret			;6ab8
L_6AB9:
	ld b,000h		;6ab9   ; los tres canales del PSG, cada uno con sus dos bytes de periodo y su volumen
	ld c,008h		;6abb
	ld hl,0e00ah		;6abd
	call L_6AD0		;6ac0
	ld hl,0e036h		;6ac3
	call L_6AD0		;6ac6
	ld hl,0e062h		;6ac9
	call L_6AD0		;6acc
	ret			;6acf
L_6AD0:
	ld e,(hl)			;6ad0   ; el periodo son dos registros seguidos, el fino y el basto
	ld a,b			;6ad1
	call 00093h		;6ad2   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;6ad5
	inc b			;6ad6
	ld e,(hl)			;6ad7
	ld a,b			;6ad8
	call 00093h		;6ad9   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;6adc
	ld e,(hl)			;6add
	ld a,c			;6ade
	inc b			;6adf
	inc c			;6ae0
	inc hl			;6ae1
	bit 3,(hl)		;6ae2   ; el bit 3 del cuarto byte silencia el canal: ni se escribe el volumen
	ret nz			;6ae4
	call 00093h		;6ae5   ; BIOS WRTPSG - Writes data to PSG-register
	bit 2,(hl)		;6ae8
	ret z			;6aea
	set 3,(hl)		;6aeb   ; y el bit 2 hace que se escriba una sola vez
	ret			;6aed
L_6AEE:
	ld hl,0e17ah		;6aee   ; el registro 6 es el periodo del ruido, y se escribe en dos pasos con los bits 0 y 1 de E17A
	bit 0,(hl)		;6af1
	jr z,L_6B03		;6af3
	res 0,(hl)		;6af5
	set 1,(hl)		;6af7
	ld a,(0e178h)		;6af9
	ld e,a			;6afc
	ld a,006h		;6afd
	call 00093h		;6aff   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6b02
L_6B03:
	bit 1,(hl)		;6b03   ; el segundo valor de ruido va un paso despues: asi el ruido cambia con dos valores encadenados
	ret nz			;6b05
	bit 2,(hl)		;6b06
	ret z			;6b08
	res 2,(hl)		;6b09
	set 3,(hl)		;6b0b
	ld a,(0e179h)		;6b0d
	ld e,a			;6b10
	ld a,006h		;6b11
	call 00093h		;6b13   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6b16
L_6B17:
	ld hl,0e17ah		;6b17   ; los registros 11, 12 y 13 son la envolvente del PSG: periodo largo, periodo corto y forma
	bit 7,(hl)		;6b1a
	ret z			;6b1c
	res 7,(hl)		;6b1d
	ld a,(0e17ch)		;6b1f
	ld e,a			;6b22
	ld a,00bh		;6b23
	call 00093h		;6b25   ; BIOS WRTPSG - Writes data to PSG-register
	bit 6,(hl)		;6b28
	ret z			;6b2a
	res 6,(hl)		;6b2b
	ld a,(0e17dh)		;6b2d
	ld e,a			;6b30
	ld a,00ch		;6b31
	call 00093h		;6b33   ; BIOS WRTPSG - Writes data to PSG-register
	bit 5,(hl)		;6b36
	ret z			;6b38
	res 5,(hl)		;6b39
	ld a,(0e17bh)		;6b3b
	ld e,a			;6b3e
	ld a,00dh		;6b3f
	call 00093h		;6b41   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6b44
L_6B45:
	ld hl,0e00dh		;6b45   ; y por ultimo el arbitro de canales, que decide que suena en cada uno
	ld a,(hl)			;6b48
	ld hl,06b79h		;6b49   ; la tabla de 0x6B79 traduce el estado del canal a sus dos bits del mezclador
	call L_6B72		;6b4c
	ld b,(hl)			;6b4f
	ld hl,0e039h		;6b50   ; el segundo canal, en E039
	ld a,(hl)			;6b53
	ld hl,06b7dh		;6b54
	call L_6B72		;6b57
	ld c,(hl)			;6b5a
	ld hl,0e065h		;6b5b
	ld a,(hl)			;6b5e
	ld hl,06b81h		;6b5f
	call L_6B72		;6b62
	ld a,(hl)			;6b65
	or b			;6b66
	or c			;6b67
L_6B68:
	ld e,a			;6b68   ; el registro 7 es el mezclador: dice que canales suenan y cuales llevan ruido
	ld (0e176h),a		;6b69
	ld a,007h		;6b6c
	call 00093h		;6b6e   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6b71
L_6B72:
	and 003h		;6b72   ; los dos bits de abajo eligen la entrada de la tabla
	ld e,a			;6b74
	ld d,000h		;6b75
	add hl,de			;6b77
	ret			;6b78

; ----------------------------------------------------------------------
; DATOS tabla_6B49: 12 bytes que lee 0x6B49 (`ld hl,6B79h`); formato pendiente
;   0x6b79..0x6b85  (12 bytes)
DATA_tabla_6B49:
	defb 089h,081h,088h,080h,092h,082h,090h,080h,0a4h,084h,0a0h,080h	; 6b79  ............

; ======================================================================
; CODIGO 0x6b85..0x6e23  (670 bytes)
; ======================================================================


L_6B85:
	call L_6B92		;6b85   ; el paso del SCC: comparar, volcar, registros y formas de onda
	call L_6C97		;6b88
	call SCC_VUELCA_REGISTROS		;6b8b
	call SCC_FORMAS_ONDA		;6b8e
	ret			;6b91

; ----------------------------------------------------------------------
; EL FILTRO DE ESCRITURAS AL SCC. Los cinco canales tienen tres
; valores cada uno -periodo fino, periodo basto y volumen- y
; escribirlos todos en cada interrupcion costaria quince accesos.
; Este bloque compara cada valor con la copia que guarda en E180 y
; E18A, y solo enciende su bit en E17E/E17F cuando ha cambiado; el
; volcado de 0x6C97 escribe unicamente los que estan marcados. Son
; quince trozos calcados de siete instrucciones, escritos a mano y
; sin bucle: mas largos, pero sin cuentas de indices.
; ----------------------------------------------------------------------
L_6B92:
	ld ix,0e17eh		;6b92   ; IX apunta a los dos bytes de marcas, DE a las copias de periodos y BC a las de volumen
	ld bc,0e18ah		;6b96
	ld de,0e180h		;6b99
	ld hl,0e08eh		;6b9c   ; E08E es el primer canal del SCC; de uno al siguiente hay 0x2C bytes
	ld a,(de)			;6b9f
	res 0,(ix+000h)		;6ba0   ; la marca se apaga y solo se enciende si el valor ha cambiado
	cp (hl)			;6ba4
	jr z,L_6BAD		;6ba5
	set 0,(ix+000h)		;6ba7
	ld a,(hl)			;6bab
	ld (de),a			;6bac
L_6BAD:
	inc de			;6bad   ; el segundo byte del periodo
	inc hl			;6bae
	ld a,(de)			;6baf
	res 1,(ix+000h)		;6bb0
	cp (hl)			;6bb4
	jr z,L_6BBD		;6bb5
	set 1,(ix+000h)		;6bb7
	ld a,(hl)			;6bbb
	ld (de),a			;6bbc
L_6BBD:
	inc de			;6bbd   ; y el volumen, que lleva su marca en el otro byte
	inc hl			;6bbe
	res 2,(ix+001h)		;6bbf
	ld a,(bc)			;6bc3
	cp (hl)			;6bc4
	jr z,L_6BCD		;6bc5
	set 2,(ix+001h)		;6bc7
	ld a,(hl)			;6bcb
	ld (bc),a			;6bcc
L_6BCD:
	inc bc			;6bcd   ; segundo canal, en E0BA
	ld hl,0e0bah		;6bce
	ld a,(de)			;6bd1
	res 2,(ix+000h)		;6bd2
	cp (hl)			;6bd6
	jr z,L_6BDF		;6bd7
	set 2,(ix+000h)		;6bd9
	ld a,(hl)			;6bdd
	ld (de),a			;6bde
L_6BDF:
	inc de			;6bdf   ; su periodo basto
	inc hl			;6be0
	ld a,(de)			;6be1
	res 3,(ix+000h)		;6be2
	cp (hl)			;6be6
	jr z,L_6BEF		;6be7
	set 3,(ix+000h)		;6be9
	ld a,(hl)			;6bed
	ld (de),a			;6bee
L_6BEF:
	inc de			;6bef   ; y su volumen
	inc hl			;6bf0
	res 3,(ix+001h)		;6bf1
	ld a,(bc)			;6bf5
	cp (hl)			;6bf6
	jr z,L_6BFF		;6bf7
	set 3,(ix+001h)		;6bf9
	ld a,(hl)			;6bfd
	ld (bc),a			;6bfe
L_6BFF:
	inc bc			;6bff   ; tercer canal, en E0E6
	ld hl,0e0e6h		;6c00
	ld a,(de)			;6c03
	res 4,(ix+000h)		;6c04
	cp (hl)			;6c08
	jr z,L_6C11		;6c09
	set 4,(ix+000h)		;6c0b
	ld a,(hl)			;6c0f
	ld (de),a			;6c10
L_6C11:
	inc de			;6c11   ; su periodo basto
	inc hl			;6c12
	ld a,(de)			;6c13
	res 5,(ix+000h)		;6c14
	cp (hl)			;6c18
	jr z,L_6C21		;6c19
	set 5,(ix+000h)		;6c1b
	ld a,(hl)			;6c1f
	ld (de),a			;6c20
L_6C21:
	inc de			;6c21   ; y su volumen
	inc hl			;6c22
	res 4,(ix+001h)		;6c23
	ld a,(bc)			;6c27
	cp (hl)			;6c28
	jr z,L_6C31		;6c29
	set 4,(ix+001h)		;6c2b
	ld a,(hl)			;6c2f
	ld (bc),a			;6c30
L_6C31:
	inc bc			;6c31   ; cuarto canal, en E112
	ld hl,0e112h		;6c32
	ld a,(de)			;6c35
	res 6,(ix+000h)		;6c36
	cp (hl)			;6c3a
	jr z,L_6C43		;6c3b
	set 6,(ix+000h)		;6c3d
	ld a,(hl)			;6c41
	ld (de),a			;6c42
L_6C43:
	inc de			;6c43   ; su periodo basto
	inc hl			;6c44
	ld a,(de)			;6c45
	res 7,(ix+000h)		;6c46
	cp (hl)			;6c4a
	jr z,L_6C53		;6c4b
	set 7,(ix+000h)		;6c4d
	ld a,(hl)			;6c51
	ld (de),a			;6c52
L_6C53:
	inc de			;6c53   ; y su volumen
	inc hl			;6c54
	res 5,(ix+001h)		;6c55
	ld a,(bc)			;6c59
	cp (hl)			;6c5a
	jr z,L_6C63		;6c5b
	set 5,(ix+001h)		;6c5d
	ld a,(hl)			;6c61
	ld (bc),a			;6c62
L_6C63:
	inc bc			;6c63   ; quinto canal, en E13E
	ld hl,0e13eh		;6c64
	ld a,(de)			;6c67
	res 0,(ix+001h)		;6c68
	cp (hl)			;6c6c
	jr z,L_6C75		;6c6d
	set 0,(ix+001h)		;6c6f
	ld a,(hl)			;6c73
	ld (de),a			;6c74
L_6C75:
	inc de			;6c75   ; su periodo basto
	inc hl			;6c76
	ld a,(de)			;6c77
	res 1,(ix+001h)		;6c78
	cp (hl)			;6c7c
	jr z,L_6C85		;6c7d
	set 1,(ix+001h)		;6c7f
	ld a,(hl)			;6c83
	ld (de),a			;6c84
L_6C85:
	inc de			;6c85   ; y su volumen; con esto los quince valores estan comparados
	inc hl			;6c86
	res 6,(ix+001h)		;6c87
	ld a,(bc)			;6c8b
	cp (hl)			;6c8c
	jr z,L_6C95		;6c8d
	set 6,(ix+001h)		;6c8f
	ld a,(hl)			;6c93
	ld (bc),a			;6c94
L_6C95:
	inc bc			;6c95
	ret			;6c96
L_6C97:
	ld e,000h		;6c97   ; el mezclador del SCC: un bit por canal, encendido si su volumen no es cero
	ld hl,0e091h		;6c99
	ld c,001h		;6c9c
	ld a,(hl)			;6c9e
	or a			;6c9f
	jr z,L_6CA3		;6ca0
	ld a,c			;6ca2
L_6CA3:
	or e			;6ca3   ; el primer canal, en E091
	ld e,a			;6ca4
	ld hl,0e0bdh		;6ca5
	sla c		;6ca8
	ld a,(hl)			;6caa
	or a			;6cab
	jr z,L_6CAF		;6cac
	ld a,c			;6cae
L_6CAF:
	or e			;6caf   ; el segundo, con el bit corrido
	ld e,a			;6cb0
	ld hl,0e0e9h		;6cb1
	sla c		;6cb4
	ld a,(hl)			;6cb6
	or a			;6cb7
	jr z,L_6CBB		;6cb8
	ld a,c			;6cba
L_6CBB:
	or e			;6cbb   ; el tercero
	ld e,a			;6cbc
	ld hl,0e115h		;6cbd
	sla c		;6cc0
	ld a,(hl)			;6cc2
	or a			;6cc3
	jr z,L_6CC7		;6cc4
	ld a,c			;6cc6
L_6CC7:
	or e			;6cc7   ; el cuarto
	ld e,a			;6cc8
	ld hl,0e141h		;6cc9
	sla c		;6ccc
	ld a,(hl)			;6cce
	or a			;6ccf
	jr z,L_6CD3		;6cd0
	ld a,c			;6cd2
L_6CD3:
	or e			;6cd3   ; el quinto, y luego se compara con lo que ya habia
	ld e,a			;6cd4
	ld hl,0e18fh		;6cd5
	ld a,(hl)			;6cd8
	cp e			;6cd9
	jr z,L_6CE3		;6cda
	ld (hl),e			;6cdc   ; solo si el mezclador cambia se marca para escribirlo
	ld hl,0e17fh		;6cdd
	set 7,(hl)		;6ce0
	ret			;6ce2
L_6CE3:
	ld hl,0e17fh		;6ce3
	res 7,(hl)		;6ce6
	ret			;6ce8
SCC_VUELCA_REGISTROS:		; escribe en el SCC (0x9880-0x988F) los registros que E17E/E17F marcan cambiados, leyendolos de su copia en E180-E18F; corre en CADA fotograma desde 0x6B8B, y 0x42B9 lo usa con los 16 bits a 1 para forzar el volcado entero al arrancar
	ld ix,0e17eh		;6ce9   ; los dieciseis registros del SCC viven en 0x9880 y su copia en E180
	ld hl,0e180h		;6ced
	ld de,09880h		;6cf0
	bit 0,(ix+000h)		;6cf3
	jr z,L_6CFC		;6cf7
	call SCC_ESCRIBE_BYTE		;6cf9
L_6CFC:
	inc hl			;6cfc
	inc de			;6cfd
	bit 1,(ix+000h)		;6cfe
	jr z,L_6D07		;6d02
	call SCC_ESCRIBE_BYTE		;6d04
L_6D07:
	inc hl			;6d07
	inc de			;6d08
	bit 2,(ix+000h)		;6d09
	jr z,L_6D12		;6d0d
	call SCC_ESCRIBE_BYTE		;6d0f
L_6D12:
	inc hl			;6d12
	inc de			;6d13
	bit 3,(ix+000h)		;6d14
	jr z,L_6D1D		;6d18
	call SCC_ESCRIBE_BYTE		;6d1a
L_6D1D:
	inc hl			;6d1d
	inc de			;6d1e
	bit 4,(ix+000h)		;6d1f
	jr z,L_6D28		;6d23
	call SCC_ESCRIBE_BYTE		;6d25
L_6D28:
	inc hl			;6d28
	inc de			;6d29
	bit 5,(ix+000h)		;6d2a
	jr z,L_6D33		;6d2e
	call SCC_ESCRIBE_BYTE		;6d30
L_6D33:
	inc hl			;6d33
	inc de			;6d34
	bit 6,(ix+000h)		;6d35
	jr z,L_6D3E		;6d39
	call SCC_ESCRIBE_BYTE		;6d3b
L_6D3E:
	inc hl			;6d3e
	inc de			;6d3f
	bit 7,(ix+000h)		;6d40
	jr z,L_6D49		;6d44
	call SCC_ESCRIBE_BYTE		;6d46
L_6D49:
	inc hl			;6d49
	inc de			;6d4a
	bit 0,(ix+001h)		;6d4b
	jr z,L_6D54		;6d4f
	call SCC_ESCRIBE_BYTE		;6d51
L_6D54:
	inc hl			;6d54
	inc de			;6d55
	bit 1,(ix+001h)		;6d56
	jr z,L_6D5F		;6d5a
	call SCC_ESCRIBE_BYTE		;6d5c
L_6D5F:
	inc hl			;6d5f
	inc de			;6d60
	bit 2,(ix+001h)		;6d61
	jr z,L_6D6A		;6d65
	call SCC_ESCRIBE_BYTE		;6d67
L_6D6A:
	inc hl			;6d6a
	inc de			;6d6b
	bit 3,(ix+001h)		;6d6c
	jr z,L_6D75		;6d70
	call SCC_ESCRIBE_BYTE		;6d72
L_6D75:
	inc hl			;6d75
	inc de			;6d76
	bit 4,(ix+001h)		;6d77
	jr z,L_6D80		;6d7b
	call SCC_ESCRIBE_BYTE		;6d7d
L_6D80:
	inc hl			;6d80
	inc de			;6d81
	bit 5,(ix+001h)		;6d82
	jr z,L_6D8B		;6d86
	call SCC_ESCRIBE_BYTE		;6d88
L_6D8B:
	inc hl			;6d8b
	inc de			;6d8c
	bit 6,(ix+001h)		;6d8d
	jr z,L_6D96		;6d91
	call SCC_ESCRIBE_BYTE		;6d93
L_6D96:
	inc hl			;6d96   ; el ultimo par de registros
	inc de			;6d97
	bit 7,(ix+001h)		;6d98
	ret z			;6d9c
	call SCC_ESCRIBE_BYTE		;6d9d
	ret			;6da0
SCC_ESCRIBE_BYTE:		; mapea 0x3F en 0x8000, escribe (hl) en (de) del SCC y vuelve a poner la pagina 2
	ld a,(hl)			;6da1   ; escribir en el SCC pide mapear la pagina 0x3F en 0x8000 y devolver la 2 despues
	ld c,a			;6da2
	ld a,03fh		;6da3
	ld (09000h),a		;6da5   ; 0x9000 es el registro del mapper de esta ranura
	ld a,c			;6da8
	ld (de),a			;6da9
	ld a,002h		;6daa
	ld (09000h),a		;6dac
	ret			;6daf
SCC_FORMAS_ONDA:		; por cada canal con el bit 7 de su bandera: copia su forma de onda al SCC (0x9800/20/40/60)
	ld hl,0e093h		;6db0   ; la forma de onda son 32 bytes y solo se copia cuando el bit 7 de la bandera del canal lo pide
	bit 7,(hl)		;6db3
	jr z,L_6DC6		;6db5
	res 7,(hl)		;6db7
	ld hl,0e0abh		;6db9   ; el puntero a la forma esta en E0AB
	ld e,(hl)			;6dbc
	inc hl			;6dbd
	ld d,(hl)			;6dbe
	ex de,hl			;6dbf
	ld de,09800h		;6dc0
	call SCC_COPIA_ONDA		;6dc3
L_6DC6:
	ld hl,0e0bfh		;6dc6   ; segundo canal, forma en 0x9820
	bit 7,(hl)		;6dc9
	jr z,L_6DDC		;6dcb
	res 7,(hl)		;6dcd   ; la bandera se apaga: la forma ya esta copiada
	ld hl,0e0d7h		;6dcf
	ld e,(hl)			;6dd2
	inc hl			;6dd3
	ld d,(hl)			;6dd4
	ex de,hl			;6dd5
	ld de,09820h		;6dd6
	call SCC_COPIA_ONDA		;6dd9
L_6DDC:
	ld hl,0e0ebh		;6ddc   ; tercero, en 0x9840
	bit 7,(hl)		;6ddf
	jr z,L_6DF2		;6de1
	res 7,(hl)		;6de3   ; lo mismo en el tercero
	ld hl,0e103h		;6de5
	ld e,(hl)			;6de8
	inc hl			;6de9
	ld d,(hl)			;6dea
	ex de,hl			;6deb
	ld de,09840h		;6dec
	call SCC_COPIA_ONDA		;6def
L_6DF2:
	ld hl,0e117h		;6df2   ; y cuarto, en 0x9860; el quinto comparte la forma del cuarto, que es como funciona el SCC
	bit 7,(hl)		;6df5
	ret z			;6df7
	res 7,(hl)		;6df8
	ld hl,0e12fh		;6dfa
	ld e,(hl)			;6dfd
	inc hl			;6dfe
	ld d,(hl)			;6dff
	ex de,hl			;6e00
	ld de,09860h		;6e01
SCC_COPIA_ONDA:		; 32 bytes de HL a DE (0x98x0) con 0x3F en 0x8000; 0x988F = (E18F); vuelve a la pagina 2
	ld a,03fh		;6e04
	ld (09000h),a		;6e06
	xor a			;6e09
	ld (0988fh),a		;6e0a
	ld b,020h		;6e0d
L_6E0F:
	ld a,(hl)			;6e0f   ; y aqui se copian los 32 bytes de la forma de onda
	ld (de),a			;6e10
	inc hl			;6e11
	inc de			;6e12   ; los dos punteros suben a la vez, 32 vueltas
	djnz L_6E0F		;6e13
	ld hl,0988fh		;6e15
	ld de,0e18fh		;6e18
	ld a,(de)			;6e1b
	ld (hl),a			;6e1c
	ld a,002h		;6e1d
	ld (09000h),a		;6e1f
	ret			;6e22

; ----------------------------------------------------------------------
; DATOS tabla_envolventes: 10 punteros (0x65E4, por el numero de envolvente x
;   2) a las envolventes de abajo
;   0x6e23..0x6e37  (20 bytes)
DATA_tabla_envolventes:
	defw 06e37h	; 6e23  -> DATA_envolvente_0
	defw 06e3dh	; 6e25  -> DATA_envolvente_1
	defw 06e4ah	; 6e27  -> DATA_envolvente_2
	defw 06e63h	; 6e29  -> DATA_envolvente_3
	defw 06e78h	; 6e2b  -> DATA_envolvente_4
	defw 06e91h	; 6e2d  -> DATA_envolvente_5
	defw 06eaah	; 6e2f  -> DATA_envolvente_6
	defw 06ec5h	; 6e31  -> DATA_envolvente_7
	defw 06ee2h	; 6e33  -> DATA_envolvente_8
	defw 06ef1h	; 6e35  -> DATA_envolvente_9

; ----------------------------------------------------------------------
; DATOS envolvente_0: envolvente 0: 5 bytes y 0xFF al final; la recorre 0x65F5
;   byte a byte ((ix+17,18) es el puntero)
;   0x6e37..0x6e3d  (6 bytes)
DATA_envolvente_0:
	defb 0e1h,001h,0e4h,000h,007h,0ffh	; 6e37

; ----------------------------------------------------------------------
; DATOS envolvente_1: envolvente 1: 12 bytes y 0xFF al final; la recorre
;   0x65F5 byte a byte ((ix+17,18) es el puntero)
;   0x6e3d..0x6e4a  (13 bytes)
DATA_envolvente_1:
	defb 0e3h,001h,0e4h,000h,08ah,000h,0e1h,004h,006h,005h,004h,003h,0ffh	; 6e3d  .............

; ----------------------------------------------------------------------
; DATOS envolvente_2: envolvente 2: 24 bytes y 0xFF al final; la recorre
;   0x65F5 byte a byte ((ix+17,18) es el puntero)
;   0x6e4a..0x6e63  (25 bytes)
DATA_envolvente_2:
	defb 0e2h,001h,0a1h,02ah,091h,04ah,081h,055h,071h,060h,061h,06ah,051h,075h,041h,080h	; 6e4a  ...*.J.Uq`ajQuA.
	defb 031h,08ah,021h,095h,011h,0a0h,001h,0b0h,0ffh	; 6e5a  1.!......

; ----------------------------------------------------------------------
; DATOS envolvente_3: envolvente 3: 20 bytes y 0xFF al final; la recorre
;   0x65F5 byte a byte ((ix+17,18) es el puntero)
;   0x6e63..0x6e78  (21 bytes)
DATA_envolvente_3:
	defb 0e1h,001h,0e4h,014h,007h,0e2h,001h,072h,000h,0e1h,002h,0e4h,010h,003h,002h,0e1h	; 6e63  .......r........
	defb 001h,0e4h,006h,002h,0ffh	; 6e73

; ----------------------------------------------------------------------
; DATOS envolvente_4: envolvente 4: 24 bytes y 0xFF al final; la recorre
;   0x65F5 byte a byte ((ix+17,18) es el puntero)
;   0x6e78..0x6e91  (25 bytes)
DATA_envolvente_4:
	defb 0e2h,001h,0e5h,00ah,000h,042h,0c1h,0b0h,0e8h,0e1h,001h,0e4h,008h,008h,007h,006h	; 6e78  .....B..........
	defb 005h,004h,003h,002h,002h,001h,001h,000h,0ffh	; 6e88  .........

; ----------------------------------------------------------------------
; DATOS envolvente_5: envolvente 5: 24 bytes y 0xFF al final; la recorre
;   0x65F5 byte a byte ((ix+17,18) es el puntero)
;   0x6e91..0x6eaa  (25 bytes)
DATA_envolvente_5:
	defb 0e2h,001h,0b1h,05ah,091h,080h,081h,08ah,071h,095h,061h,0a0h,051h,0aah,041h,0b5h	; 6e91  ...Z....q.a.Q.A.
	defb 031h,0c0h,021h,0cah,011h,0d5h,001h,0e0h,0ffh	; 6ea1  1.!......

; ----------------------------------------------------------------------
; DATOS envolvente_6: envolvente 6: 26 bytes y 0xFF al final; la recorre
;   0x65F5 byte a byte ((ix+17,18) es el puntero)
;   0x6eaa..0x6ec5  (27 bytes)
DATA_envolvente_6:
	defb 0e2h,001h,0b1h,095h,0a1h,0c0h,091h,0cah,0b1h,0d5h,071h,0e0h,061h,0eah,051h,0f5h	; 6eaa  ..........q.a.Q.
	defb 042h,000h,032h,00ah,022h,015h,012h,020h,002h,030h,0ffh	; 6eba  B.2.".. .0.

; ----------------------------------------------------------------------
; DATOS envolvente_7: envolvente 7: 28 bytes y 0xFF al final; la recorre
;   0x65F5 byte a byte ((ix+17,18) es el puntero)
;   0x6ec5..0x6ee2  (29 bytes)
DATA_envolvente_7:
	defb 0e2h,001h,0c1h,0e0h,0b2h,010h,0a2h,01ah,092h,025h,082h,030h,072h,03ah,062h,045h	; 6ec5  .........%.0r:bE
	defb 052h,050h,042h,05ah,032h,065h,022h,070h,012h,07ah,002h,085h,0ffh	; 6ed5  RPBZ2e"p.z...

; ----------------------------------------------------------------------
; DATOS envolvente_8: envolvente 8: 14 bytes y 0xFF al final; la recorre
;   0x65F5 byte a byte ((ix+17,18) es el puntero)
;   0x6ee2..0x6ef1  (15 bytes)
DATA_envolvente_8:
	defb 0e2h,001h,0e5h,009h,003h,000h,093h,0d0h,096h,000h,097h,000h,098h,000h,0ffh	; 6ee2  ...............

; ----------------------------------------------------------------------
; DATOS envolvente_9: envolvente 9: 18 bytes y 0xFF al final; la recorre
;   0x65F5 byte a byte ((ix+17,18) es el puntero)
;   0x6ef1..0x6f04  (19 bytes)
DATA_envolvente_9:
	defb 0e2h,001h,0a1h,080h,0e5h,00ah,000h,0b8h,0e1h,001h,0e4h,004h,007h,005h,004h,003h	; 6ef1  ................
	defb 002h,001h,0ffh	; 6f01

; ----------------------------------------------------------------------
; DATOS tabla_ondas: 69 punteros (0x6A20, por el numero de instrumento x 2) a
;   las 28 formas de onda del SCC de abajo
;   0x6f04..0x6f8e  (138 bytes)
DATA_tabla_ondas:
	defw 06f8eh	; 6f04  -> DATA_ondas_scc
	defw 06f8eh	; 6f06  -> DATA_ondas_scc
	defw 06f8eh	; 6f08  -> DATA_ondas_scc
	defw 06faeh	; 6f0a
	defw 06faeh	; 6f0c
	defw 06fceh	; 6f0e
	defw 06feeh	; 6f10
	defw 06feeh	; 6f12
	defw 0700eh	; 6f14
	defw 0700eh	; 6f16
	defw 0700eh	; 6f18
	defw 0702eh	; 6f1a
	defw 0702eh	; 6f1c
	defw 0704eh	; 6f1e
	defw 0706eh	; 6f20
	defw 0706eh	; 6f22
	defw 0706eh	; 6f24
	defw 0706eh	; 6f26
	defw 0706eh	; 6f28
	defw 0708eh	; 6f2a
	defw 070aeh	; 6f2c
	defw 070ceh	; 6f2e
	defw 070eeh	; 6f30
	defw 0710eh	; 6f32
	defw 0712eh	; 6f34
	defw 0712eh	; 6f36
	defw 0712eh	; 6f38
	defw 0712eh	; 6f3a
	defw 0712eh	; 6f3c
	defw 0714eh	; 6f3e
	defw 0716eh	; 6f40
	defw 0718eh	; 6f42
	defw 0718eh	; 6f44
	defw 0718eh	; 6f46
	defw 071aeh	; 6f48
	defw 071ceh	; 6f4a
	defw 071eeh	; 6f4c
	defw 0720eh	; 6f4e
	defw 0722eh	; 6f50
	defw 0724eh	; 6f52
	defw 0724eh	; 6f54
	defw 0726eh	; 6f56
	defw 0726eh	; 6f58
	defw 0726eh	; 6f5a
	defw 0728eh	; 6f5c
	defw 0728eh	; 6f5e
	defw 0728eh	; 6f60
	defw 0728eh	; 6f62
	defw 0728eh	; 6f64
	defw 0728eh	; 6f66
	defw 0728eh	; 6f68
	defw 0728eh	; 6f6a
	defw 0728eh	; 6f6c
	defw 0728eh	; 6f6e
	defw 0728eh	; 6f70
	defw 0728eh	; 6f72
	defw 0728eh	; 6f74
	defw 072aeh	; 6f76
	defw 072aeh	; 6f78
	defw 072ceh	; 6f7a
	defw 072ceh	; 6f7c
	defw 072ceh	; 6f7e
	defw 072ceh	; 6f80
	defw 072ceh	; 6f82
	defw 072ceh	; 6f84
	defw 072ceh	; 6f86
	defw 072ceh	; 6f88
	defw 072eeh	; 6f8a
	defw 072eeh	; 6f8c

; ----------------------------------------------------------------------
; DATOS ondas_scc: 28 formas de onda del SCC de 32 bytes (una por fila):
;   SCC_COPIA_ONDA las sube a 0x9800/20/40/60 cuando la pista cambia de
;   instrumento
;   0x6f8e..0x730e  (896 bytes)
DATA_ondas_scc:
	defb 000h,0f8h,0f0h,0e8h,0e0h,0d8h,0d0h,0c8h,0c0h,0b8h,0b0h,0a8h,0a0h,098h,090h,088h,080h,078h,070h,068h,060h,058h,050h,048h,040h,038h,030h,028h,020h,018h,010h,008h	; 6f8e  .................xph`XPH@80( ...
	defb 000h,04eh,062h,06dh,075h,07ah,07dh,07eh,07fh,07eh,07dh,07ah,075h,06dh,062h,04eh,000h,0b1h,09dh,092h,08ah,085h,082h,081h,080h,081h,082h,085h,08ah,092h,09dh,0b1h	; 6fae  .Nbmuz}~.~}zumbN................
	defb 000h,019h,031h,047h,05ah,06ah,075h,07dh,07fh,07dh,075h,06ah,05ah,047h,031h,019h,000h,0e7h,0cfh,0b9h,0a6h,096h,08bh,083h,080h,083h,08bh,096h,0a6h,0b9h,0cfh,0e7h	; 6fce  ..1GZju}.}ujZG1.................
	defb 000h,0e0h,0c0h,0a0h,080h,0a0h,0c0h,0e0h,000h,020h,040h,060h,07fh,060h,040h,020h,000h,0e0h,0c0h,0a0h,080h,0a0h,0c0h,0e0h,000h,020h,040h,060h,07fh,060h,040h,020h	; 6fee  ......... @`.`@ ......... @`.`@
	defb 000h,019h,031h,047h,05ah,06ah,075h,07dh,07fh,07dh,075h,06ah,05ah,047h,031h,019h,080h,090h,0a0h,0b0h,0c0h,0d0h,0e0h,0f0h,000h,010h,020h,030h,040h,050h,060h,070h	; 700e  ..1GZju}.}ujZG1........... 0@P`p
	defb 001h,02ah,040h,050h,05ch,068h,070h,078h,07fh,078h,070h,068h,05ch,050h,040h,02ah,0ffh,0d6h,0c0h,0b0h,0a4h,098h,090h,088h,081h,088h,090h,098h,0a4h,0b0h,0c0h,0d6h	; 702e  .*@P\hpx.xph\P@*................
	defb 000h,040h,07fh,040h,001h,0c0h,081h,0c0h,001h,040h,07fh,040h,001h,0c0h,001h,040h,001h,0e0h,001h,020h,001h,0f0h,001h,010h,001h,0ffh,0ffh,0ffh,0ffh,040h,040h,040h	; 704e  .@.@.....@.@...@... .........@@@
	defb 000h,040h,07fh,040h,000h,0c0h,0ffh,0c0h,005h,0ebh,0d6h,0c3h,0b9h,0afh,0a4h,09ch,095h,08fh,089h,084h,081h,084h,089h,08fh,095h,09ch,0a4h,0afh,0b9h,0c3h,0d6h,0eah	; 706e  .@.@............................
	defb 000h,0f0h,0e0h,0d0h,0c0h,0b0h,0a0h,090h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,07fh,070h,060h,050h,040h,030h,020h,010h	; 708e  .........................p`P@0 .
	defb 000h,030h,050h,060h,070h,060h,050h,030h,000h,0d0h,0b0h,0a0h,090h,0a0h,0b0h,0d0h,000h,040h,060h,070h,060h,040h,000h,0c0h,0a0h,090h,0a0h,0c0h,000h,070h,000h,090h	; 70ae  .0P`p`P0.........@`p`@.......p..
	defb 030h,050h,050h,030h,000h,000h,010h,040h,060h,070h,060h,030h,0f0h,0e0h,0e0h,000h,020h,020h,010h,0c0h,0a0h,090h,0a0h,0c0h,000h,000h,0d0h,0b0h,0b0h,0d0h,000h,000h	; 70ce  0PP0...@`p`0....  ..............
	defb 0a0h,090h,090h,0a0h,0a0h,0b0h,0b0h,0b0h,0c0h,0c0h,0d0h,0d0h,0e0h,0e0h,0f0h,0f0h,000h,000h,010h,010h,020h,020h,030h,030h,040h,040h,050h,050h,060h,060h,060h,050h	; 70ee  ....................  00@@PP```P
	defb 000h,07fh,000h,080h,0a0h,0c0h,0d8h,0f0h,008h,020h,030h,040h,050h,060h,070h,078h,07ch,07fh,07ch,078h,070h,060h,050h,040h,030h,020h,008h,0f0h,0d8h,0c0h,0a0h,080h	; 710e  ......... 0@P`px|.|xp`P@0 ......
	defb 080h,08eh,0a0h,0c0h,0e0h,000h,020h,03fh,03eh,03ch,03ah,037h,031h,029h,020h,01ch,010h,000h,0e6h,0c0h,0d0h,000h,020h,03fh,010h,0e0h,080h,0c0h,000h,020h,000h,090h	; 712e  ...... ?><:71) ....... ?..... ..
	defb 000h,070h,050h,020h,050h,070h,030h,000h,050h,07fh,060h,010h,030h,040h,000h,0b0h,010h,060h,000h,0e0h,0f0h,000h,0b0h,090h,0c0h,010h,0e0h,0a0h,0c0h,0f0h,0c0h,0a0h	; 714e  .pP Pp0.P.`.0@...`..............
	defb 080h,088h,090h,098h,0a0h,0b0h,0b0h,0b8h,0c0h,0c8h,0d0h,0d8h,0e0h,0e8h,0f0h,0f8h,000h,008h,010h,018h,020h,028h,030h,038h,040h,048h,050h,058h,060h,068h,070h,078h	; 716e  .................... (08@HPX`hpx
	defb 078h,078h,078h,078h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h	; 718e  xxxx............................
	defb 078h,078h,078h,078h,078h,078h,078h,078h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h	; 71ae  xxxxxxxx........................
	defb 080h,0b0h,0c0h,010h,01ah,02ah,02ch,01ah,000h,0e0h,0d0h,0e0h,022h,053h,070h,075h,070h,031h,0eah,080h,088h,08ah,08ch,08eh,000h,07fh,075h,073h,062h,000h,0c0h,090h	; 71ce  .....*,....."Spup1........usb...
	defb 000h,020h,030h,040h,050h,058h,060h,068h,070h,068h,060h,058h,050h,040h,030h,020h,000h,0e0h,0d0h,0c0h,0b0h,0a0h,098h,090h,088h,090h,098h,0a0h,0b0h,0c0h,0d0h,0e0h	; 71ee  . 0@PX`hph`XP@0 ................
	defb 000h,000h,000h,000h,000h,070h,070h,000h,000h,080h,080h,080h,000h,000h,000h,000h,070h,070h,070h,000h,080h,080h,000h,000h,000h,000h,070h,070h,000h,000h,080h,080h	; 720e  .....pp.........ppp.......pp....
	defb 000h,000h,000h,080h,000h,070h,070h,070h,000h,000h,000h,080h,000h,000h,000h,080h,080h,080h,080h,000h,080h,000h,000h,000h,000h,080h,080h,080h,000h,080h,080h,080h	; 722e  .....ppp........................
	defb 070h,070h,070h,070h,070h,070h,070h,070h,080h,080h,080h,080h,080h,080h,080h,080h,070h,070h,070h,080h,080h,080h,070h,070h,070h,070h,080h,080h,080h,080h,080h,080h	; 724e  pppppppp........ppp...pppp......
	defb 000h,040h,07fh,040h,001h,0c0h,081h,0c0h,001h,040h,07fh,040h,001h,0c0h,001h,040h,001h,0e0h,001h,020h,001h,0f0h,001h,010h,001h,0ffh,0ffh,0ffh,0ffh,040h,040h,040h	; 726e  .@.@.....@.@...@... .........@@@
	defb 000h,0f8h,0f0h,0e8h,0e0h,0d8h,0d0h,0c8h,0c0h,0b8h,0b0h,0a8h,0a0h,098h,090h,088h,080h,07fh,070h,068h,060h,058h,050h,048h,040h,038h,030h,028h,020h,018h,010h,008h	; 728e  ..................ph`XPH@80( ...
	defb 000h,0f8h,0f0h,0e8h,0e0h,0d8h,0d0h,0c8h,0c0h,0b8h,0b0h,0a8h,0a0h,098h,090h,088h,080h,078h,070h,068h,060h,058h,050h,048h,040h,038h,030h,028h,020h,018h,010h,008h	; 72ae  .................xph`XPH@80( ...
	defb 000h,000h,000h,000h,000h,07fh,07fh,000h,000h,080h,080h,080h,000h,000h,000h,000h,07fh,07fh,07fh,000h,080h,080h,000h,000h,000h,000h,07fh,07fh,000h,000h,000h,080h	; 72ce  ................................
	defb 000h,080h,080h,080h,080h,080h,0ffh,0ffh,080h,080h,000h,000h,000h,080h,080h,080h,080h,0ffh,0ffh,0ffh,080h,000h,000h,080h,080h,080h,080h,0ffh,0ffh,080h,080h,000h	; 72ee  ................................

; ----------------------------------------------------------------------
; DATOS pendiente_de_trazar: Sin trazar ni identificar todavia (98 bytes)
;   0x730e..0x7370  (98 bytes)
DATA_pendiente_de_trazar:
	defb 07fh,07fh,07fh,07fh,07fh,080h,080h,07fh,07fh,0fdh,0fdh,0fdh,07fh,07fh,07fh,07fh	; 730e  ................
	defb 080h,080h,080h,0fdh,0fdh,0fdh,07fh,07fh,07fh,07fh,080h,080h,07fh,07fh,07fh,0fdh	; 731e  ................
	defb 07fh,080h,080h,080h,080h,080h,0fdh,0fdh,080h,080h,07fh,07fh,07fh,080h,080h,080h	; 732e  ................
	defb 080h,0fdh,0fdh,0fdh,080h,07fh,07fh,080h,080h,080h,0fdh,0fdh,080h,080h,07fh,07fh	; 733e  ................
	defb 07fh,000h,07fh,080h,07fh,000h,000h,07fh,07fh,080h,080h,000h,000h,07fh,07fh,080h	; 734e  ................
	defb 07fh,07fh,000h,07fh,07fh,080h,07fh,000h,000h,07fh,07fh,080h,080h,000h,000h,07fh	; 735e  ................
	defb 07fh,080h	; 736e

; ----------------------------------------------------------------------
; DATOS pista_7370: pista de la partitura (sonido 1 canal 2, sonido 1 canal
;   3); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7370..0x7371  (1 bytes)
DATA_pista_7370:
	defb 0ffh	; 7370

; ----------------------------------------------------------------------
; DATOS pista_7371: pista de la partitura (sonido 4 canal 2, sonido 6 canal 2,
;   sonido 7 canal 2, sonido 10 canal 2); hasta donde empieza la pista
;   siguiente: el final exacto lo dira el lector de la partitura, por escribir
;   0x7371..0x737d  (12 bytes)
DATA_pista_7371:
	defb 0feh,002h,0e0h,002h,0eeh,005h,0e2h,001h,0f9h,093h,073h,0ffh	; 7371  ..........s.

; ----------------------------------------------------------------------
; DATOS pista_737D: pista de la partitura (sonido 4 canal 4, sonido 6 canal 3,
;   sonido 7 canal 4, sonido 10 canal 3); hasta donde empieza la pista
;   siguiente: el final exacto lo dira el lector de la partitura, por escribir
;   0x737d..0x7387  (10 bytes)
DATA_pista_737D:
	defb 0feh,002h,0f8h,03ah,0e2h,001h,0f9h,0d2h,073h,0ffh	; 737d  ...:....s.

; ----------------------------------------------------------------------
; DATOS pista_7387: pista de la partitura (sonido 5 canal 2, sonido 8 canal 2,
;   sonido 9 canal 2, sonido 11 canal 2); hasta donde empieza la pista
;   siguiente: el final exacto lo dira el lector de la partitura, por escribir
;   0x7387..0x73c8  (65 bytes)
DATA_pista_7387:
	defb 0feh,002h,0e0h,002h,0eeh,005h,0e2h,003h,0f9h,093h,073h,0ffh,051h,056h,061h,057h	; 7387  ..........s.QVaW
	defb 071h,058h,081h,059h,081h,05ah,091h,05bh,0a1h,05ch,0e2h,003h,0a1h,060h,0a1h,066h	; 7397  qX.Y.Z.[.\...`.f
	defb 0a1h,070h,0a1h,080h,0a1h,090h,091h,096h,091h,097h,081h,096h,081h,097h,071h,096h	; 73a7  .p............q.
	defb 071h,097h,061h,096h,061h,096h,051h,096h,051h,096h,051h,096h,0e2h,005h,041h,096h	; 73b7  q.a.a.Q.Q.Q...A.
	defb 0fah	; 73c7

; ----------------------------------------------------------------------
; DATOS pista_73C8: pista de la partitura (sonido 5 canal 4, sonido 8 canal 3,
;   sonido 9 canal 4, sonido 11 canal 3); hasta donde empieza la pista
;   siguiente: el final exacto lo dira el lector de la partitura, por escribir
;   0x73c8..0x7409  (65 bytes)
DATA_pista_73C8:
	defb 0feh,002h,0f8h,03ah,0e2h,003h,0f9h,0d2h,073h,0ffh,011h,055h,021h,056h,031h,057h	; 73c8  ...:....s..U!V1W
	defb 041h,058h,051h,059h,061h,05ah,071h,05bh,081h,05ch,0e2h,003h,091h,060h,0a1h,066h	; 73d8  AXQYaZq[.\...`.f
	defb 0b1h,070h,0c1h,080h,0c1h,090h,0c1h,096h,0b1h,097h,0a1h,096h,091h,097h,081h,096h	; 73e8  .p..............
	defb 071h,097h,061h,096h,051h,096h,041h,096h,031h,096h,0e2h,005h,021h,096h,011h,096h	; 73f8  q.a.Q.A.1...!...
	defb 0fah	; 7408

; ----------------------------------------------------------------------
; DATOS pista_7409: pista de la partitura (sonido 2 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7409..0x7444  (59 bytes)
DATA_pista_7409:
	defb 0feh,002h,0e2h,003h,0f9h,015h,074h,0e2h,00ah,031h,0a0h,0ffh,041h,059h,051h,05ah	; 7409  ......t..1..AYQZ
	defb 061h,05bh,071h,05ch,071h,05dh,081h,05eh,081h,05fh,0e2h,003h,091h,060h,091h,066h	; 7419  a[q\q].^._...`.f
	defb 0a1h,070h,0a1h,080h,0a1h,090h,0a1h,0a0h,091h,0a1h,091h,0a0h,081h,0a1h,081h,0a0h	; 7429  .p..............
	defb 071h,0a1h,071h,0a0h,061h,0a0h,061h,0a0h,051h,0a0h,0fah	; 7439  q.q.a.a.Q..

; ----------------------------------------------------------------------
; DATOS pista_7444: pista de la partitura (sonido 2 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7444..0x747f  (59 bytes)
DATA_pista_7444:
	defb 0feh,002h,0e2h,002h,0f9h,050h,074h,0e2h,00ah,011h,0a0h,0ffh,011h,059h,021h,05ah	; 7444  .....Pt......Y!Z
	defb 031h,05bh,041h,05ch,051h,05dh,061h,05eh,071h,05fh,0e2h,003h,081h,060h,091h,066h	; 7454  1[A\Q]a^q_...`.f
	defb 0a1h,070h,0b1h,080h,0b1h,090h,0b1h,0a0h,0a1h,0a1h,091h,0a0h,081h,0a1h,071h,0a0h	; 7464  .p............q.
	defb 061h,0a1h,051h,0a0h,041h,0a0h,031h,0a0h,021h,0a0h,0fah	; 7474  a.Q.A.1.!..

; ----------------------------------------------------------------------
; DATOS pista_747F: pista de la partitura (sonido 2 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x747f..0x748f  (16 bytes)
DATA_pista_747F:
	defb 0feh,002h,0eeh,004h,0e2h,002h,000h,000h,0f9h,050h,074h,0e2h,00ah,011h,0a0h,0ffh	; 747f  .........Pt.....

; ----------------------------------------------------------------------
; DATOS pista_748F: pista de la partitura (sonido 2 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x748f..0x749d  (14 bytes)
DATA_pista_748F:
	defb 0feh,002h,0f8h,013h,0e2h,002h,0f9h,050h,074h,0e2h,00ah,011h,0a0h,0ffh	; 748f  .......Pt.....

; ----------------------------------------------------------------------
; DATOS pista_749D: pista de la partitura (sonido 2 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x749d..0x74af  (18 bytes)
DATA_pista_749D:
	defb 0feh,002h,0f8h,013h,0eeh,004h,0e2h,002h,000h,000h,0f9h,050h,074h,0e2h,00ah,011h	; 749d  ...........Pt...
	defb 0a0h,0ffh	; 74ad

; ----------------------------------------------------------------------
; DATOS pista_74AF: pista de la partitura (sonido 2 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x74af..0x74c1  (18 bytes)
DATA_pista_74AF:
	defb 0feh,002h,0f8h,013h,0eeh,007h,0e2h,002h,000h,000h,0f9h,050h,074h,0e2h,00ah,011h	; 74af  ...........Pt...
	defb 0a0h,0ffh	; 74bf

; ----------------------------------------------------------------------
; DATOS pista_74C1: pista de la partitura (sonido 2 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x74c1..0x74d3  (18 bytes)
DATA_pista_74C1:
	defb 0feh,002h,0f8h,013h,0eeh,00ah,0e2h,002h,000h,000h,0f9h,050h,074h,0e2h,00ah,011h	; 74c1  ...........Pt...
	defb 0a0h,0ffh	; 74d1

; ----------------------------------------------------------------------
; DATOS pista_74D3: pista de la partitura (sonido 2 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x74d3..0x74e5  (18 bytes)
DATA_pista_74D3:
	defb 0feh,002h,0f8h,013h,0eeh,00ch,0e2h,002h,000h,000h,0f9h,050h,074h,0e2h,00ah,011h	; 74d3  ...........Pt...
	defb 0a0h,0ffh	; 74e3

; ----------------------------------------------------------------------
; DATOS pista_74E5: pista de la partitura (sonido 3 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x74e5..0x74f1  (12 bytes)
DATA_pista_74E5:
	defb 0feh,002h,0e2h,001h,0f9h,015h,074h,0e2h,008h,031h,0a0h,0ffh	; 74e5  ......t..1..

; ----------------------------------------------------------------------
; DATOS pista_74F1: pista de la partitura (sonido 3 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x74f1..0x74ff  (14 bytes)
DATA_pista_74F1:
	defb 0feh,002h,0f8h,013h,0e2h,001h,0f9h,050h,074h,0e2h,008h,011h,0a0h,0ffh	; 74f1  .......Pt.....

; ----------------------------------------------------------------------
; DATOS pista_74FF: pista de la partitura (sonido 3 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x74ff..0x750f  (16 bytes)
DATA_pista_74FF:
	defb 0feh,002h,0f8h,013h,0eeh,004h,0e2h,001h,0f9h,050h,074h,0e2h,008h,011h,0a0h,0ffh	; 74ff  .........Pt.....

; ----------------------------------------------------------------------
; DATOS pista_750F: pista de la partitura (sonido 12 canal 2, sonido 13 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x750f..0x75a4  (149 bytes)
DATA_pista_750F:
	defb 0feh,002h,0e3h,001h,0e4h,018h,080h,028h,0e4h,017h,090h,02fh,0e4h,016h,0a0h,02eh	; 750f  .......(.../....
	defb 0e4h,016h,090h,02ch,0e4h,015h,090h,02eh,0e4h,014h,090h,02ch,0e4h,013h,090h,02fh	; 751f  ...,.......,.../
	defb 0fbh,002h,013h,075h,0e4h,012h,080h,028h,0e4h,011h,080h,02fh,0e4h,010h,090h,02eh	; 752f  ...u...(.../....
	defb 0e4h,00fh,080h,02ch,0e4h,00eh,080h,02eh,0e4h,00dh,080h,02ch,0e4h,00ch,080h,02fh	; 753f  ...,.......,.../
	defb 0e4h,00bh,060h,028h,0e4h,00ah,070h,02fh,0e4h,009h,080h,02eh,0e4h,008h,070h,02ch	; 754f  ..`(..p/......p,
	defb 0e4h,007h,070h,02eh,0e4h,006h,070h,02ch,0e4h,005h,070h,02fh,0e4h,009h,050h,028h	; 755f  ..p...p,..p/..P(
	defb 0e4h,008h,050h,02fh,0e4h,007h,050h,02eh,0e4h,006h,050h,02ch,0e4h,005h,050h,02eh	; 756f  ..P/..P...P,..P.
	defb 0e4h,004h,050h,02ch,0e4h,003h,050h,02fh,0e4h,009h,030h,028h,0e4h,008h,030h,02fh	; 757f  ..P,..P/..0(..0/
	defb 0e4h,007h,030h,02eh,0e4h,006h,030h,02ch,0e4h,005h,030h,02eh,0e4h,004h,030h,02ch	; 758f  ..0...0,..0...0,
	defb 0e4h,003h,030h,02fh,0ffh	; 759f

; ----------------------------------------------------------------------
; DATOS pista_75A4: pista de la partitura (sonido 12 canal 3, sonido 13 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x75a4..0x7601  (93 bytes)
DATA_pista_75A4:
	defb 0feh,002h,0f8h,005h,0e2h,001h,094h,000h,0b0h,060h,0b0h,06fh,0b0h,067h,0b0h,062h	; 75a4  .........`.o.g.b
	defb 0b0h,06ch,0b0h,06fh,0b0h,068h,0a0h,060h,0a0h,06fh,0a0h,067h,0a0h,062h,0a0h,06ch	; 75b4  .l.o.h.`.o.g.b.l
	defb 0a0h,06fh,0a0h,068h,080h,060h,080h,06fh,080h,067h,080h,062h,080h,06ch,080h,06fh	; 75c4  .o.h.`.o.g.b.l.o
	defb 080h,068h,030h,060h,030h,06fh,030h,067h,030h,062h,030h,06ch,030h,06fh,030h,068h	; 75d4  .h0`0o0g0b0l0o0h
	defb 010h,060h,010h,06fh,010h,067h,010h,062h,010h,06ch,010h,06fh,010h,068h,000h,060h	; 75e4  .`.o.g.b.l.o.h.`
	defb 000h,06fh,000h,067h,000h,062h,000h,06ch,000h,06fh,000h,068h,0ffh	; 75f4  .o.g.b.l.o.h.

; ----------------------------------------------------------------------
; DATOS pista_7601: pista de la partitura (sonido 14 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7601..0x76ae  (173 bytes)
DATA_pista_7601:
	defb 0feh,002h,0e3h,001h,0e4h,019h,058h,029h,0e4h,018h,067h,030h,0e4h,017h,076h,02dh	; 7601  ......X)..g0..v-
	defb 0e4h,016h,085h,02bh,0e4h,015h,094h,02dh,0e4h,014h,0a3h,02ch,0e4h,013h,0b2h,02fh	; 7611  ...+...-...,.../
	defb 0e4h,012h,0c1h,028h,000h,000h,0e4h,011h,038h,029h,0e4h,010h,057h,030h,0e4h,00fh	; 7621  ...(....8)..W0..
	defb 056h,02dh,0e4h,00eh,065h,02bh,0e4h,00dh,074h,02dh,0e4h,00ch,083h,02ch,0e4h,00bh	; 7631  V-..e+..t-...,..
	defb 092h,02fh,0e4h,00ah,0a1h,028h,000h,000h,0e4h,011h,078h,029h,0e4h,010h,077h,030h	; 7641  ./...(....x)..w0
	defb 0e4h,00fh,076h,02dh,0e4h,00eh,075h,02bh,0e4h,00dh,074h,02dh,0e4h,00ch,073h,02ch	; 7651  ..v-..u+..t-..s,
	defb 0e4h,00bh,072h,02fh,0e4h,00ah,071h,028h,000h,000h,0e4h,011h,058h,029h,0e4h,010h	; 7661  ..r/..q(....X)..
	defb 057h,030h,0e4h,00fh,056h,02dh,0e4h,00eh,055h,02bh,0e4h,00dh,054h,02dh,0e4h,00ch	; 7671  W0..V-..U+..T-..
	defb 053h,02ch,0e4h,00bh,052h,02fh,0e4h,00ah,051h,028h,000h,000h,0e4h,011h,058h,019h	; 7681  S,..R/..Q(....X.
	defb 0e4h,010h,037h,030h,0e4h,00fh,036h,02dh,0e4h,00eh,035h,02bh,0e4h,00dh,034h,02dh	; 7691  ..70..6-..5+..4-
	defb 0e4h,00ch,033h,02ch,0e4h,00bh,032h,02fh,0e4h,00ah,031h,028h,0ffh	; 76a1  ..3,..2/..1(.

; ----------------------------------------------------------------------
; DATOS pista_76AE: pista de la partitura (sonido 15 canal 2, sonido 16 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x76ae..0x7747  (153 bytes)
DATA_pista_76AE:
	defb 0feh,002h,0e3h,001h,0e4h,019h,0a0h,029h,0e4h,018h,090h,030h,0e4h,017h,0a0h,02dh	; 76ae  .......)...0...-
	defb 0e4h,016h,0b0h,02bh,0e4h,015h,0a0h,02dh,0e4h,014h,0a0h,02ch,0e4h,013h,0a0h,02fh	; 76be  ...+...-...,.../
	defb 0e4h,012h,0a0h,028h,0fbh,003h,0b0h,076h,0e4h,011h,080h,029h,0e4h,010h,090h,030h	; 76ce  ...(...v...)...0
	defb 0e4h,00fh,090h,02dh,0e4h,00eh,080h,02bh,0e4h,00dh,080h,02dh,0e4h,00ch,080h,02ch	; 76de  ...-...+...-...,
	defb 0e4h,00bh,080h,02fh,0e4h,00ah,070h,028h,0e4h,009h,070h,029h,0e4h,008h,070h,030h	; 76ee  .../..p(..p)..p0
	defb 0e4h,007h,070h,02dh,0e4h,006h,070h,02bh,0e4h,005h,070h,02dh,0e4h,004h,070h,02ch	; 76fe  ..p-..p+..p-..p,
	defb 0e4h,003h,050h,02fh,0e4h,002h,050h,028h,0e4h,009h,050h,029h,0e4h,008h,050h,030h	; 770e  ..P/..P(..P)..P0
	defb 0e4h,007h,050h,02dh,0e4h,006h,050h,02bh,0e4h,005h,050h,02dh,0e4h,004h,040h,02ch	; 771e  ..P-..P+..P-..@,
	defb 0e4h,003h,040h,02fh,0e4h,002h,040h,028h,0e4h,009h,040h,029h,0e4h,008h,040h,030h	; 772e  ..@/..@(..@)..@0
	defb 0e4h,007h,040h,02dh,0e4h,006h,040h,02bh,0ffh	; 773e  ..@-..@+.

; ----------------------------------------------------------------------
; DATOS pista_7747: pista de la partitura (sonido 15 canal 3, sonido 16 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7747..0x779a  (83 bytes)
DATA_pista_7747:
	defb 0feh,002h,0f8h,005h,0e2h,001h,0a4h,080h,0c0h,04eh,0c0h,058h,0c0h,054h,0c0h,052h	; 7747  .........N.X.T.R
	defb 0c0h,057h,0c0h,05ah,0c0h,056h,0fbh,003h,04fh,077h,080h,04eh,080h,058h,080h,054h	; 7757  .W.Z.V..Ow.N.X.T
	defb 080h,052h,080h,057h,080h,05ah,080h,056h,050h,04eh,050h,058h,050h,054h,050h,052h	; 7767  .R.W.Z.VPNPXPTPR
	defb 050h,057h,050h,05ah,050h,056h,030h,04eh,030h,058h,030h,054h,030h,052h,030h,057h	; 7777  PWPZPV0N0X0T0R0W
	defb 030h,05ah,030h,056h,010h,04eh,010h,058h,010h,054h,010h,052h,010h,057h,010h,05ah	; 7787  0Z0V.N.X.T.R.W.Z
	defb 010h,056h,0ffh	; 7797

; ----------------------------------------------------------------------
; DATOS pista_779A: pista de la partitura (sonido 17 canal 2, sonido 18 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x779a..0x77b6  (28 bytes)
DATA_pista_779A:
	defb 0feh,002h,0e3h,001h,0e4h,01fh,0b0h,02eh,0e4h,01eh,0b0h,031h,0e4h,01dh,0b0h,02dh	; 779a  ...........1...-
	defb 0e4h,01ch,0b0h,02eh,0e4h,01bh,0b0h,02dh,0e4h,01ah,0c0h,02eh	; 77aa  .......-....

; ----------------------------------------------------------------------
; DATOS pista_77B6: pista de la partitura (sonido 19 canal 2, sonido 20 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x77b6..0x77f7  (65 bytes)
DATA_pista_77B6:
	defb 0feh,002h,0e3h,001h,0e4h,019h,090h,029h,0e4h,018h,0c0h,030h,0e4h,017h,0b0h,02dh	; 77b6  .......)...0...-
	defb 0e4h,018h,090h,02bh,0e4h,017h,0a0h,02dh,0e4h,016h,090h,029h,0e4h,015h,0c0h,030h	; 77c6  ...+...-...)...0
	defb 0e4h,014h,0b0h,02dh,0e4h,013h,090h,02bh,0e4h,012h,0a0h,02dh,0e4h,011h,090h,029h	; 77d6  ...-...+...-...)
	defb 0e4h,010h,0c0h,030h,0e4h,00fh,0b0h,02dh,0e4h,00eh,090h,02bh,0e4h,00dh,0a0h,02dh	; 77e6  ...0...-...+...-
	defb 0ffh	; 77f6

; ----------------------------------------------------------------------
; DATOS pista_77F7: pista de la partitura (sonido 17 canal 3, sonido 18 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x77f7..0x77fe  (7 bytes)
DATA_pista_77F7:
	defb 0feh,002h,0f8h,004h,0f9h,006h,078h	; 77f7

; ----------------------------------------------------------------------
; DATOS pista_77FE: pista de la partitura (sonido 19 canal 3, sonido 20 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x77fe..0x7838  (58 bytes)
DATA_pista_77FE:
	defb 0feh,002h,0f8h,002h,0f9h,017h,078h,0ffh,0e2h,001h,0a3h,090h,0c0h,02eh,0c0h,031h	; 77fe  ......x........1
	defb 0c0h,02dh,0c0h,02eh,0c0h,02dh,0c0h,02eh,0fah,0e2h,001h,0a0h,029h,0c0h,030h,0c0h	; 780e  .-...-......).0.
	defb 02dh,0a0h,02bh,0b0h,02dh,0a0h,029h,0c0h,030h,0c0h,02dh,0a0h,02bh,0b0h,02dh,0a0h	; 781e  -.+.-.).0.-.+.-.
	defb 029h,0c0h,030h,0c0h,02dh,0a0h,02bh,0b0h,02dh,0fah	; 782e  ).0.-.+.-.

; ----------------------------------------------------------------------
; DATOS pista_7838: pista de la partitura (sonido 21 canal 2, sonido 22 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7838..0x7897  (95 bytes)
DATA_pista_7838:
	defb 0feh,002h,0e3h,001h,0e4h,01fh,0a0h,028h,0a0h,036h,0a0h,040h,0b0h,031h,0b0h,036h	; 7838  .......(.6.@.1.6
	defb 0b0h,022h,0e2h,001h,0c3h,000h,0c5h,000h,0e3h,001h,0e4h,01eh,0a3h,060h,0a4h,030h	; 7848  ."...........`.0
	defb 0a5h,000h,0e0h,003h,0e3h,001h,083h,060h,084h,030h,085h,000h,0e0h,003h,0e3h,001h	; 7858  .......`.0......
	defb 063h,060h,064h,030h,065h,000h,0e0h,003h,0e3h,001h,053h,060h,054h,030h,055h,000h	; 7868  c`d0e.....S`T0U.
	defb 0e0h,003h,0e3h,001h,043h,060h,044h,030h,045h,000h,0e0h,003h,0e3h,001h,033h,060h	; 7878  ....C`D0E.....3`
	defb 034h,030h,035h,000h,0e0h,003h,0e3h,001h,023h,060h,024h,030h,025h,000h,0ffh	; 7888  405.....#`$0%..

; ----------------------------------------------------------------------
; DATOS pista_7897: pista de la partitura (sonido 21 canal 3, sonido 22 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7897..0x78f6  (95 bytes)
DATA_pista_7897:
	defb 0feh,002h,0f8h,028h,0e2h,001h,0a0h,068h,0c1h,0aeh,0c2h,0adh,0c3h,0cbh,0c6h,000h	; 7897  ...(...h........
	defb 0e0h,001h,0e2h,001h,080h,068h,0a1h,0aeh,0a2h,0adh,0a3h,0cbh,0a6h,000h,000h,000h	; 78a7  .....h..........
	defb 0f8h,014h,070h,068h,091h,0aeh,092h,0adh,093h,0cbh,095h,000h,000h,000h,060h,068h	; 78b7  ..ph..........`h
	defb 081h,0aeh,072h,0adh,073h,0adh,073h,0cbh,076h,000h,000h,000h,040h,068h,041h,0aeh	; 78c7  ..r.s.s.v...@hA.
	defb 042h,0adh,043h,0cbh,046h,000h,000h,000h,020h,068h,021h,0aeh,022h,0adh,023h,0cbh	; 78d7  B.C.F... h!.".#.
	defb 026h,000h,000h,000h,010h,068h,011h,0aeh,012h,0adh,013h,0cbh,016h,000h,0ffh	; 78e7  &....h.........

; ----------------------------------------------------------------------
; DATOS pista_78F6: pista de la partitura (sonido 23 canal 2, sonido 24 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x78f6..0x793f  (73 bytes)
DATA_pista_78F6:
	defb 0feh,002h,0e3h,001h,0e4h,000h,0a0h,040h,0e4h,011h,0a0h,050h,0a0h,070h,0a0h,038h	; 78f6  .......@...P.p.8
	defb 000h,000h,0e4h,000h,080h,040h,0e4h,011h,080h,050h,080h,070h,080h,038h,000h,000h	; 7906  .....@...P.p.8..
	defb 0e4h,000h,060h,040h,0e4h,011h,060h,050h,060h,070h,060h,038h,000h,000h,0e4h,000h	; 7916  ..`@..`P`p`8....
	defb 040h,040h,0e4h,011h,040h,050h,040h,070h,040h,038h,000h,000h,0e4h,000h,020h,040h	; 7926  @@..@P@p@8.... @
	defb 0e4h,011h,020h,050h,020h,070h,020h,038h,0ffh	; 7936  .. P p 8.

; ----------------------------------------------------------------------
; DATOS pista_793F: pista de la partitura (sonido 23 canal 3, sonido 24 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x793f..0x798e  (79 bytes)
DATA_pista_793F:
	defb 0feh,002h,0f8h,028h,0e2h,001h,0c2h,0e9h,0c3h,0ceh,0c5h,034h,0c2h,0b6h,0c3h,09eh	; 793f  ...(.......4....
	defb 0c4h,0e9h,000h,000h,082h,000h,083h,000h,085h,000h,089h,000h,072h,004h,073h,008h	; 794f  ............r.s.
	defb 065h,010h,069h,020h,032h,000h,032h,0a0h,033h,050h,034h,000h,035h,0a0h,036h,055h	; 795f  e.i 2.2.3P4.5.6U
	defb 022h,000h,023h,000h,025h,000h,029h,000h,022h,004h,023h,008h,025h,010h,029h,020h	; 796f  ".#.%.).".#.%.)
	defb 003h,000h,005h,000h,009h,000h,002h,004h,003h,008h,005h,010h,009h,020h,0ffh	; 797f  ............. .

; ----------------------------------------------------------------------
; DATOS pista_798E: pista de la partitura (sonido 25 canal 2, sonido 26 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x798e..0x79dd  (79 bytes)
DATA_pista_798E:
	defb 0feh,002h,0e0h,001h,0f9h,0ceh,079h,0e3h,001h,0e4h,008h,080h,018h,080h,023h,080h	; 798e  ......y.......#.
	defb 02eh,090h,01fh,090h,026h,090h,012h,090h,00fh,090h,007h,000h,000h,050h,018h,050h	; 799e  ....&........P.P
	defb 023h,050h,02fh,060h,01fh,060h,026h,060h,012h,060h,00fh,060h,007h,000h,000h,030h	; 79ae  #P/`.`&`.`.`...0
	defb 018h,030h,023h,030h,02fh,030h,01fh,020h,026h,020h,012h,020h,00fh,020h,007h,0ffh	; 79be  .0#0/0. & . . ..
	defb 0e2h,001h,0b2h,0e9h,0b3h,0feh,0b6h,034h,0a2h,056h,0a3h,09eh,0a4h,0e9h,0fah	; 79ce  .......4.V.....

; ----------------------------------------------------------------------
; DATOS pista_79DD: pista de la partitura (sonido 25 canal 3, sonido 26 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x79dd..0x7a1f  (66 bytes)
DATA_pista_79DD:
	defb 0feh,002h,0f8h,028h,0f9h,0ceh,079h,000h,000h,000h,000h,082h,0e9h,083h,0feh,066h	; 79dd  ...(..y........f
	defb 034h,062h,056h,063h,09eh,064h,0e9h,000h,000h,042h,0e9h,043h,0feh,046h,034h,052h	; 79ed  4bVc.d...B.C.F4R
	defb 056h,053h,09eh,054h,0e9h,000h,000h,032h,0e9h,033h,0feh,036h,034h,022h,056h,023h	; 79fd  VS.T...2.3.64"V#
	defb 09eh,024h,0e9h,000h,000h,012h,0e9h,013h,0feh,016h,034h,012h,056h,013h,09eh,014h	; 7a0d  .$........4.V...
	defb 0e9h,0ffh	; 7a1d

; ----------------------------------------------------------------------
; DATOS pista_7A1F: pista de la partitura (sonido 27 canal 2, sonido 28 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7a1f..0x7a74  (85 bytes)
DATA_pista_7A1F:
	defb 0feh,002h,0e1h,002h,0e4h,01fh,00ch,0e4h,010h,00bh,0e4h,013h,00ah,0e4h,016h,009h	; 7a1f  ................
	defb 0e4h,01ah,008h,0e1h,002h,0e4h,000h,00bh,0e4h,008h,00bh,0e4h,010h,00bh,0e4h,018h	; 7a2f  ................
	defb 00bh,0e4h,01bh,00ah,0e4h,01ch,00bh,0e4h,01fh,00bh,0e4h,000h,008h,0e4h,008h,008h	; 7a3f  ................
	defb 0e4h,010h,008h,0e4h,018h,008h,0e4h,01ah,008h,0e4h,01ch,008h,0e4h,01fh,008h,0e4h	; 7a4f  ................
	defb 000h,005h,0e4h,008h,005h,0e4h,010h,005h,0e4h,018h,005h,0e4h,01ah,005h,0e4h,01ch	; 7a5f  ................
	defb 005h,0e4h,01fh,005h,0ffh	; 7a6f

; ----------------------------------------------------------------------
; DATOS pista_7A74: pista de la partitura (sonido 27 canal 3, sonido 28 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7a74..0x7ae5  (113 bytes)
DATA_pista_7A74:
	defb 0feh,002h,0f8h,025h,0e2h,001h,056h,000h,046h,000h,039h,000h,029h,000h,019h,000h	; 7a74  ...%..V.F.9.)...
	defb 0c6h,000h,0b6h,000h,0a9h,000h,099h,000h,089h,000h,0f8h,01ch,0b5h,000h,0b6h,000h	; 7a84  ................
	defb 0b7h,000h,0b8h,000h,0b9h,000h,0bah,000h,0bah,080h,0bbh,000h,0bbh,080h,0bch,000h	; 7a94  ................
	defb 0bch,080h,0bdh,000h,0bdh,080h,0beh,000h,075h,000h,076h,000h,077h,000h,078h,000h	; 7aa4  ........u.v.w.x.
	defb 079h,000h,07ah,000h,07ah,080h,07bh,000h,07bh,080h,07ch,000h,07ch,080h,07dh,000h	; 7ab4  y.z.z.{.{.|.|.}.
	defb 07dh,080h,07eh,000h,035h,000h,036h,000h,037h,000h,038h,000h,039h,000h,03ah,000h	; 7ac4  }.~.5.6.7.8.9.:.
	defb 03ah,080h,03bh,000h,02bh,080h,02ch,000h,01ch,080h,01dh,000h,00dh,080h,00eh,000h	; 7ad4  :.;.+.,.........
	defb 0ffh	; 7ae4

; ----------------------------------------------------------------------
; DATOS pista_7AE5: pista de la partitura (sonido 29 canal 2, sonido 30 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7ae5..0x7b52  (109 bytes)
DATA_pista_7AE5:
	defb 0feh,002h,0e0h,002h,0eeh,003h,0e2h,001h,071h,01eh,071h,01fh,071h,020h,071h,021h	; 7ae5  ........q.q.q q!
	defb 071h,022h,071h,023h,070h,090h,070h,091h,070h,092h,070h,093h,070h,092h,010h,011h	; 7af5  q"q#p.p.p.p.p...
	defb 051h,01eh,051h,01fh,051h,020h,051h,021h,051h,022h,051h,023h,050h,090h,050h,091h	; 7b05  Q.Q.Q Q!Q"Q#P.P.
	defb 050h,092h,050h,093h,050h,092h,010h,011h,041h,01eh,041h,01fh,041h,020h,041h,021h	; 7b15  P.P.P...A.A.A A!
	defb 041h,022h,041h,023h,040h,090h,040h,091h,040h,092h,040h,093h,040h,092h,010h,011h	; 7b25  A"A#@.@.@.@.@...
	defb 031h,01eh,031h,01fh,031h,020h,031h,021h,031h,022h,031h,023h,030h,090h,030h,091h	; 7b35  1.1.1 1!1"1#0.0.
	defb 030h,092h,030h,093h,030h,092h,010h,011h,0fbh,002h,0ebh,07ah,0ffh	; 7b45  0.0.0......z.

; ----------------------------------------------------------------------
; DATOS pista_7B52: pista de la partitura (sonido 29 canal 3, sonido 30 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7b52..0x7bbd  (107 bytes)
DATA_pista_7B52:
	defb 0feh,002h,0f8h,025h,0e2h,001h,081h,01eh,091h,01fh,0a1h,020h,0b1h,021h,0c1h,022h	; 7b52  ...%....... .!."
	defb 0c1h,023h,0b0h,090h,0a0h,091h,090h,092h,080h,093h,080h,092h,010h,011h,051h,01eh	; 7b62  .#............Q.
	defb 051h,01fh,051h,020h,051h,021h,051h,022h,051h,023h,050h,090h,050h,091h,050h,092h	; 7b72  Q.Q Q!Q"Q#P.P.P.
	defb 050h,093h,050h,092h,010h,011h,031h,01eh,031h,01fh,031h,020h,031h,021h,031h,022h	; 7b82  P.P...1.1.1 1!1"
	defb 031h,023h,030h,090h,030h,091h,030h,092h,030h,093h,030h,092h,010h,011h,011h,01eh	; 7b92  1#0.0.0.0.0.....
	defb 011h,01fh,011h,020h,011h,021h,011h,022h,011h,023h,010h,090h,010h,091h,010h,092h	; 7ba2  ... .!.".#......
	defb 010h,093h,010h,092h,010h,011h,0fbh,002h,056h,07bh,0ffh	; 7bb2  ........V{.

; ----------------------------------------------------------------------
; DATOS pista_7BBD: pista de la partitura (sonido 31 canal 2, sonido 32 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7bbd..0x7c22  (101 bytes)
DATA_pista_7BBD:
	defb 0feh,002h,0eeh,004h,0e0h,001h,0e2h,001h,081h,073h,081h,060h,081h,043h,081h,034h	; 7bbd  .........s.`.C.4
	defb 081h,030h,081h,020h,081h,01ch,000h,000h,0fbh,002h,0c3h,07bh,071h,073h,071h,060h	; 7bcd  .0. .......{qsq`
	defb 071h,043h,071h,034h,071h,030h,071h,020h,071h,01ch,000h,000h,061h,073h,061h,060h	; 7bdd  qCq4q0q q...asa`
	defb 061h,043h,061h,034h,061h,030h,061h,020h,061h,01ch,000h,000h,051h,073h,051h,060h	; 7bed  aCa4a0a a...QsQ`
	defb 051h,023h,051h,034h,041h,030h,041h,020h,041h,01ch,000h,000h,031h,073h,031h,060h	; 7bfd  Q#Q4A0A A...1s1`
	defb 031h,023h,031h,034h,021h,030h,021h,020h,021h,01ch,000h,000h,0fbh,002h,009h,07ch	; 7c0d  1#14!0! !......|
	defb 0fch,002h,0c3h,07bh,0ffh	; 7c1d

; ----------------------------------------------------------------------
; DATOS pista_7C22: pista de la partitura (sonido 31 canal 3, sonido 32 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7c22..0x7c85  (99 bytes)
DATA_pista_7C22:
	defb 0feh,002h,0f8h,00dh,0e2h,001h,0b1h,073h,0c1h,060h,0b1h,043h,0a1h,034h,0a1h,030h	; 7c22  .......s.`.C.4.0
	defb 091h,020h,091h,01ch,000h,000h,0fbh,002h,028h,07ch,081h,073h,081h,060h,081h,043h	; 7c32  . ......(|.s.`.C
	defb 071h,034h,071h,030h,071h,020h,061h,01ch,000h,000h,061h,073h,061h,060h,051h,043h	; 7c42  q4q0q a...asa`QC
	defb 051h,034h,051h,030h,041h,020h,041h,01ch,000h,000h,041h,073h,031h,060h,031h,023h	; 7c52  Q4Q0A A...As1`1#
	defb 031h,034h,031h,030h,031h,020h,031h,01ch,000h,000h,021h,073h,021h,060h,021h,023h	; 7c62  14101 1...!s!`!#
	defb 021h,034h,021h,030h,021h,020h,021h,01ch,000h,000h,0fbh,002h,06ch,07ch,0fch,002h	; 7c72  !4!0! !.....l|..
	defb 028h,07ch,0ffh	; 7c82

; ----------------------------------------------------------------------
; DATOS pista_7C85: pista de la partitura (sonido 33 canal 2, sonido 34 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7c85..0x7d1c  (151 bytes)
DATA_pista_7C85:
	defb 0feh,002h,0e3h,001h,0e4h,01fh,0c0h,0c7h,0c1h,000h,0c1h,040h,0c1h,090h,0e2h,001h	; 7c85  ...........@....
	defb 0c8h,000h,0e3h,001h,0e4h,018h,0c1h,0f4h,0c2h,071h,0c3h,00dh,0e4h,01fh,0c3h,0d0h	; 7c95  .........q......
	defb 0c4h,0c4h,0fbh,002h,089h,07ch,0a0h,0c7h,0a1h,000h,0a1h,040h,0a1h,090h,0e2h,001h	; 7ca5  .....|.....@....
	defb 0a8h,000h,0e3h,001h,0e4h,018h,0a1h,0f4h,0a2h,071h,0a3h,00dh,0e4h,01fh,0a3h,0d0h	; 7cb5  .........q......
	defb 0a4h,0c4h,080h,0c7h,081h,000h,081h,040h,081h,090h,0e2h,001h,088h,000h,0e3h,001h	; 7cc5  .......@........
	defb 0e4h,018h,081h,0f4h,082h,071h,083h,00dh,0e4h,01fh,081h,040h,084h,0c4h,060h,0c7h	; 7cd5  .....q.....@..`.
	defb 061h,000h,061h,040h,061h,090h,0e2h,001h,068h,000h,0e3h,001h,0e4h,018h,061h,0f4h	; 7ce5  a.a@a...h.....a.
	defb 062h,071h,063h,00dh,0e4h,01fh,061h,040h,064h,0c4h,040h,0c7h,041h,000h,041h,040h	; 7cf5  bqc...a@d.@.A.A@
	defb 041h,090h,0e2h,001h,048h,000h,0e3h,001h,0e4h,018h,041h,0f4h,042h,071h,043h,00dh	; 7d05  A...H.....A.BqC.
	defb 0e4h,01fh,041h,040h,044h,0c4h,0ffh	; 7d15

; ----------------------------------------------------------------------
; DATOS pista_7D1C: pista de la partitura (sonido 33 canal 3, sonido 34 canal
;   4); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir
;   0x7d1c..0x7d7f  (99 bytes)
DATA_pista_7D1C:
	defb 0feh,002h,0f8h,028h,0e2h,001h,0a0h,0c7h,0c1h,000h,0c2h,040h,0c3h,090h,0c4h,0f4h	; 7d1c  ...(.......@....
	defb 0c6h,071h,0c7h,00dh,0c8h,0d0h,0cah,0c4h,0fbh,003h,022h,07dh,080h,0c7h,081h,000h	; 7d2c  .q........"}....
	defb 082h,040h,083h,090h,084h,0f4h,086h,071h,087h,00dh,088h,0d0h,08ah,0c4h,050h,0c7h	; 7d3c  .@.....q......P.
	defb 051h,000h,053h,090h,054h,0f4h,056h,071h,057h,00dh,058h,0d0h,05ah,0c4h,030h,0c7h	; 7d4c  Q.S.T.VqW.X.Z.0.
	defb 031h,000h,032h,040h,033h,090h,034h,0f4h,036h,071h,037h,00dh,038h,0d0h,03ah,0c4h	; 7d5c  1.2@3.4.6q7.8.:.
	defb 010h,0c7h,011h,000h,012h,040h,013h,090h,014h,0f4h,016h,071h,017h,00dh,018h,0d0h	; 7d6c  .....@.....q....
	defb 01ah,0c4h,0ffh	; 7d7c

; ----------------------------------------------------------------------
; DATOS pista_7D7F: pista de la partitura (sonido 35 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7d7f..0x7dbe  (63 bytes)
DATA_pista_7D7F:
	defb 0feh,002h,0e2h,001h,090h,010h,060h,018h,0e3h,001h,0e4h,000h,0c0h,017h,0b0h,008h	; 7d7f  ......`.........
	defb 090h,009h,080h,00ah,0e2h,001h,070h,010h,050h,018h,0e3h,001h,0e4h,000h,090h,017h	; 7d8f  ......p.P.......
	defb 070h,008h,060h,009h,050h,00ah,000h,000h,000h,000h,050h,017h,050h,008h,050h,009h	; 7d9f  p.`.P.....P.P.P.
	defb 050h,00ah,000h,000h,000h,000h,040h,017h,040h,008h,040h,009h,040h,00ah,0ffh	; 7daf  P.....@.@.@.@..

; ----------------------------------------------------------------------
; DATOS pista_7DBE: pista de la partitura (sonido 36 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7dbe..0x7dbf  (1 bytes)
DATA_pista_7DBE:
	defb 0ffh	; 7dbe

; ----------------------------------------------------------------------
; DATOS pista_7DBF: pista de la partitura (sonido 37 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7dbf..0x7df4  (53 bytes)
DATA_pista_7DBF:
	defb 0feh,002h,0eeh,002h,0e0h,002h,0e2h,001h,072h,010h,071h,07eh,071h,008h,070h,0c0h	; 7dbf  ........r.q~q.p.
	defb 060h,084h,060h,064h,060h,05eh,062h,010h,061h,07eh,061h,008h,060h,0c0h,050h,084h	; 7dcf  `.`d`^b.a~a.`.P.
	defb 050h,064h,050h,05eh,000h,011h,032h,010h,031h,07eh,021h,008h,020h,0c0h,010h,084h	; 7ddf  PdP^..2.1~!. ...
	defb 010h,064h,000h,05eh,0ffh	; 7def

; ----------------------------------------------------------------------
; DATOS pista_7DF4: pista de la partitura (sonido 37 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7df4..0x7e29  (53 bytes)
DATA_pista_7DF4:
	defb 0feh,002h,0f8h,023h,0e2h,001h,0a2h,010h,0b1h,07eh,0c1h,008h,0b0h,0c0h,080h,084h	; 7df4  ...#.....~......
	defb 070h,064h,060h,05eh,0f8h,015h,0a2h,010h,0b1h,07eh,0c1h,008h,0b0h,0c0h,080h,084h	; 7e04  pd`^.....~......
	defb 070h,064h,060h,05eh,000h,011h,032h,010h,031h,07eh,021h,008h,020h,0c0h,010h,084h	; 7e14  pd`^..2.1~!. ...
	defb 010h,064h,000h,05eh,0ffh	; 7e24

; ----------------------------------------------------------------------
; DATOS pista_7E29: pista de la partitura (sonido 38 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e29..0x7e62  (57 bytes)
DATA_pista_7E29:
	defb 0feh,002h,0e0h,002h,0eeh,002h,0e2h,002h,072h,010h,071h,07eh,081h,008h,080h,0c0h	; 7e29  ........r.q~....
	defb 070h,084h,000h,011h,052h,010h,051h,07eh,051h,008h,050h,0c0h,000h,011h,040h,084h	; 7e39  p...R.Q~Q.P...@.
	defb 000h,011h,042h,010h,041h,07eh,041h,008h,030h,0c0h,030h,084h,000h,011h,032h,010h	; 7e49  ..B.A~A.0.0...2.
	defb 021h,07eh,021h,008h,010h,0c0h,010h,084h,0ffh	; 7e59  !~!......

; ----------------------------------------------------------------------
; DATOS pista_7E62: pista de la partitura (sonido 38 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e62..0x7e97  (53 bytes)
DATA_pista_7E62:
	defb 0feh,002h,0f8h,01dh,0e2h,002h,0a2h,010h,0a1h,07eh,0c1h,008h,0b0h,0c0h,0a0h,084h	; 7e62  .........~......
	defb 000h,011h,042h,010h,041h,07eh,031h,008h,030h,0c0h,020h,084h,000h,011h,032h,010h	; 7e72  ..B.A~1.0. ...2.
	defb 031h,07eh,021h,008h,020h,0c0h,020h,084h,000h,011h,012h,010h,011h,07eh,011h,008h	; 7e82  1~!. . ......~..
	defb 000h,0c0h,000h,084h,0ffh	; 7e92

; ----------------------------------------------------------------------
; DATOS pista_7E97: pista de la partitura (sonido 39 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e97..0x7e98  (1 bytes)
DATA_pista_7E97:
	defb 0ffh	; 7e97

; ----------------------------------------------------------------------
; DATOS pista_7E98: pista de la partitura (sonido 39 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e98..0x7e99  (1 bytes)
DATA_pista_7E98:
	defb 0ffh	; 7e98

; ----------------------------------------------------------------------
; DATOS pista_7E99: pista de la partitura (sonido 40 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e99..0x7e9a  (1 bytes)
DATA_pista_7E99:
	defb 0ffh	; 7e99

; ----------------------------------------------------------------------
; DATOS pista_7E9A: pista de la partitura (sonido 40 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e9a..0x7e9b  (1 bytes)
DATA_pista_7E9A:
	defb 0ffh	; 7e9a

; ----------------------------------------------------------------------
; DATOS pista_7E9B: pista de la partitura (sonido 40 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e9b..0x7e9c  (1 bytes)
DATA_pista_7E9B:
	defb 0ffh	; 7e9b

; ----------------------------------------------------------------------
; DATOS pista_7E9C: pista de la partitura (sonido 40 canal 3); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e9c..0x7e9d  (1 bytes)
DATA_pista_7E9C:
	defb 0ffh	; 7e9c

; ----------------------------------------------------------------------
; DATOS pista_7E9D: pista de la partitura (sonido 40 canal 4); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e9d..0x7e9e  (1 bytes)
DATA_pista_7E9D:
	defb 0ffh	; 7e9d

; ----------------------------------------------------------------------
; DATOS pista_7E9E: pista de la partitura (sonido 40 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e9e..0x7e9f  (1 bytes)
DATA_pista_7E9E:
	defb 0ffh	; 7e9e

; ----------------------------------------------------------------------
; DATOS pista_7E9F: pista de la partitura (sonido 40 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7e9f..0x7ea0  (1 bytes)
DATA_pista_7E9F:
	defb 0ffh	; 7e9f

; ----------------------------------------------------------------------
; DATOS pista_7EA0: pista de la partitura (sonido 40 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7ea0..0x7ea1  (1 bytes)
DATA_pista_7EA0:
	defb 0ffh	; 7ea0

; ----------------------------------------------------------------------
; DATOS pista_7EA1: pista de la partitura (sonido 41 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7ea1..0x7eb8  (23 bytes)
DATA_pista_7EA1:
	defb 0feh,002h,0f9h,0a7h,07eh,0ffh,0e2h,006h,000h,000h,081h,000h,071h,000h,061h,000h	; 7ea1  ....~.......q.a.
	defb 051h,000h,041h,000h,031h,000h,0fah	; 7eb1

; ----------------------------------------------------------------------
; DATOS pista_7EB8: pista de la partitura (sonido 41 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7eb8..0x7ec0  (8 bytes)
DATA_pista_7EB8:
	defb 0feh,002h,0eeh,002h,0f9h,0a7h,07eh,0ffh	; 7eb8  ......~.

; ----------------------------------------------------------------------
; DATOS pista_7EC0: pista de la partitura (sonido 41 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7ec0..0x7ec8  (8 bytes)
DATA_pista_7EC0:
	defb 0feh,002h,0eeh,004h,0f9h,0a7h,07eh,0ffh	; 7ec0  ......~.

; ----------------------------------------------------------------------
; DATOS pista_7EC8: pista de la partitura (sonido 41 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7ec8..0x7ef1  (41 bytes)
DATA_pista_7EC8:
	defb 0feh,002h,0eeh,003h,0f8h,00dh,0f9h,0d2h,07eh,0ffh,0e2h,003h,0c1h,000h,0c1h,000h	; 7ec8  ........~.......
	defb 0b1h,000h,0a1h,000h,091h,000h,081h,000h,071h,000h,061h,000h,051h,000h,0e2h,005h	; 7ed8  ........q.a.Q...
	defb 041h,000h,031h,000h,021h,000h,010h,000h,0fah	; 7ee8  A.1.!....

; ----------------------------------------------------------------------
; DATOS pista_7EF1: pista de la partitura (sonido 41 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7ef1..0x7ef9  (8 bytes)
DATA_pista_7EF1:
	defb 0feh,002h,0f8h,012h,0f9h,0d2h,07eh,0ffh	; 7ef1  ......~.

; ----------------------------------------------------------------------
; DATOS pista_7EF9: pista de la partitura (sonido 41 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7ef9..0x7f01  (8 bytes)
DATA_pista_7EF9:
	defb 0feh,002h,0eeh,002h,0f9h,0d2h,07eh,0ffh	; 7ef9  ......~.

; ----------------------------------------------------------------------
; DATOS pista_7F01: pista de la partitura (sonido 42 canal 0); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f01..0x7f1a  (25 bytes)
DATA_pista_7F01:
	defb 0feh,002h,0f9h,007h,07fh,0ffh,0e2h,00ah,000h,000h,070h,080h,060h,080h,050h,080h	; 7f01  ..........p.`.P.
	defb 040h,080h,0e2h,00eh,030h,080h,020h,080h,0fah	; 7f11  @...0. ..

; ----------------------------------------------------------------------
; DATOS pista_7F1A: pista de la partitura (sonido 42 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f1a..0x7f22  (8 bytes)
DATA_pista_7F1A:
	defb 0feh,002h,0eeh,001h,0f9h,007h,07fh,0ffh	; 7f1a  ........

; ----------------------------------------------------------------------
; DATOS pista_7F22: pista de la partitura (sonido 42 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f22..0x7f2a  (8 bytes)
DATA_pista_7F22:
	defb 0feh,002h,0eeh,002h,0f9h,007h,07fh,0ffh	; 7f22  ........

; ----------------------------------------------------------------------
; DATOS pista_7F2A: pista de la partitura (sonido 42 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f2a..0x7f53  (41 bytes)
DATA_pista_7F2A:
	defb 0feh,002h,0f8h,00ch,0eeh,002h,0f9h,034h,07fh,0ffh,0e2h,005h,0c0h,080h,0c0h,080h	; 7f2a  .......4........
	defb 0b0h,080h,0a0h,080h,090h,080h,080h,080h,070h,080h,060h,080h,050h,080h,0e2h,007h	; 7f3a  ........p.`.P...
	defb 040h,080h,030h,080h,020h,080h,010h,080h,0fah	; 7f4a  @.0. ....

; ----------------------------------------------------------------------
; DATOS pista_7F53: pista de la partitura (sonido 42 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f53..0x7f5b  (8 bytes)
DATA_pista_7F53:
	defb 0feh,002h,0f8h,013h,0f9h,034h,07fh,0ffh	; 7f53  .....4..

; ----------------------------------------------------------------------
; DATOS pista_7F5B: pista de la partitura (sonido 42 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f5b..0x7f63  (8 bytes)
DATA_pista_7F5B:
	defb 0feh,002h,0eeh,001h,0f9h,034h,07fh,0ffh	; 7f5b  .....4..

; ----------------------------------------------------------------------
; DATOS pista_7F63: pista de la partitura (sonido 43 canal 1); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f63..0x7f64  (1 bytes)
DATA_pista_7F63:
	defb 0ffh	; 7f63

; ----------------------------------------------------------------------
; DATOS pista_7F64: pista de la partitura (sonido 43 canal 2); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f64..0x7f65  (1 bytes)
DATA_pista_7F64:
	defb 0ffh	; 7f64

; ----------------------------------------------------------------------
; DATOS pista_7F65: pista de la partitura (sonido 43 canal 6); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f65..0x7f6d  (8 bytes)
DATA_pista_7F65:
	defb 0feh,002h,0f8h,005h,0f9h,07ah,080h,0ffh	; 7f65  .....z..

; ----------------------------------------------------------------------
; DATOS pista_7F6D: pista de la partitura (sonido 43 canal 5); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f6d..0x7f77  (10 bytes)
DATA_pista_7F6D:
	defb 0feh,002h,0f8h,005h,0e0h,001h,0f9h,07ah,080h,0ffh	; 7f6d  .......z..

; ----------------------------------------------------------------------
; DATOS pista_7F77: pista de la partitura (sonido 43 canal 7); hasta donde
;   empieza la pista siguiente: el final exacto lo dira el lector de la
;   partitura, por escribir
;   0x7f77..0x7f78  (1 bytes)
DATA_pista_7F77:
	defb 0ffh	; 7f77

; ----------------------------------------------------------------------
; DATOS pista_7F78: pista de la partitura (sonido 43 canal 0, sonido 44 canal
;   2); hasta donde empieza la pista siguiente: el final exacto lo dira el
;   lector de la partitura, por escribir (sigue en la pagina siguiente)
;   0x7f78..0x8000  (136 bytes)
DATA_pista_7F78:
	defb 0feh,002h,0e2h,001h,0c7h,000h,0c8h,000h,0e3h,001h,0e4h,01fh,0c0h,0c7h,0c1h,000h	; 7f78  ................
	defb 0c1h,040h,0c1h,090h,0e2h,001h,0c8h,000h,0e3h,001h,0e4h,018h,0c1h,0f4h,0c2h,071h	; 7f88  .@.............q
	defb 0c3h,00dh,0e4h,01fh,0c3h,0d0h,0c4h,0c4h,0e2h,004h,0c5h,000h,0c6h,000h,0e0h,002h	; 7f98  ................
	defb 0e3h,004h,0e4h,01fh,0c1h,0c7h,0c2h,000h,0e3h,004h,0c3h,040h,0c2h,090h,0e3h,001h	; 7fa8  ...........@....
	defb 0c8h,000h,0e4h,018h,0c2h,0f4h,0c3h,071h,0c4h,00dh,0e4h,01fh,0c5h,0d9h,0c7h,000h	; 7fb8  .......q........
	defb 0fbh,004h,0b0h,07fh,0e3h,004h,0a3h,040h,0a2h,090h,0e3h,001h,0a8h,000h,0e4h,018h	; 7fc8  .......@........
	defb 0a2h,0f4h,0a3h,071h,0a4h,00dh,0e4h,01fh,0a5h,0d9h,0a7h,000h,0fbh,002h,0cch,07fh	; 7fd8  ...q............
	defb 0e3h,004h,083h,040h,082h,090h,0e3h,001h,088h,000h,0e4h,018h,082h,0f4h,083h,071h	; 7fe8  ...@...........q
	defb 084h,00dh,0e4h,01fh,085h,0d9h,087h,000h	; 7ff8  ........
