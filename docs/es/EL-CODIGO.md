# El código

## Qué hay en cada página

De las dieciséis páginas, seis llevan código y diez son datos:

| página | qué es |
|---|---|
| 0 | fija en 0x4000: cabecera, interrupción, mapper, mandos, cargador de tiles, pista, boxes, presentación |
| 1 | menús, fichas de coche, ranking, HUD, salida, contraseña |
| 2 | física del coche, estados, sonido del motor, objetos, final |
| 3 | los rivales: parrilla, adelantamientos, choques, tipos |
| 4 | listas de tiles y de sprites |
| 5, 7, 10, 11, 14 | gráficos y metatiles |
| 6, 8, 9, 12 | dibujos, textos y tablas |
| 13 | el reproductor de sonido |
| 15 | flujos de la presentación y una partida grabada |

El desensamblado saca **un listado por página**, cada uno con su `org`, y
`make verify` reensambla las dieciséis y las concatena: tiene que salir la ROM
entera, byte a byte.

## La pista

La pista de cada circuito es una **secuencia de piezas**. Cada entrada de la
secuencia son dos bytes —el número de pieza y unos flags— y un 0xFF cierra la
vuelta.

Una pieza son **24 bytes**: tres filas de ocho metatiles. Cada metatile son 4 × 4
tiles, o sea 16 bytes, así que una pieza mide doce filas de tiles de alto y
ocupa el ancho entero de la pantalla.

La posición en la pista es un contador de **32 bits que baja** —la pista viene
hacia el jugador—, y cada 0x800 es una fila de ocho píxeles. A las doce filas se
agota la pieza y se pasa a la siguiente.

Dos detalles que se ven al leer el código:

- la fila del metatile se lee **al revés** (3 menos la fila), porque el dibujo
  avanza hacia abajo mientras la pista sube;
- la columna por la que se empieza a leer la fila de metatiles **gira módulo
  8**, y eso es lo que hace que la pista se desplace de lado: el bit 6 del
  segundo byte de la pieza dice que hay desplazamiento y los seis de abajo,
  cuánto.

Los carteles y adornos del borde no van en el dibujo de las piezas: van en una
lista aparte por circuito, ordenada por posición, con tres bytes por entrada
—la pieza en los doce bits altos, la fila en los cuatro bajos, y el dibujo—.
Como está ordenada, basta un índice que avanza y no vuelve.

## El cargador de tiles

Nada se copia a la VRAM tal cual. Todos los gráficos pasan por un cargador que
recorre listas de la página 4. Un registro de lista son **seis bytes**:

```
flags | tile | puntero a los patrones | puntero a los colores
```

y los flags dicen de dónde sale el dibujo y qué hacer con él:

| bits | qué dicen |
|---|---|
| 2-1 | grupo de páginas donde está el dibujo: 4, 7, 0x0A o 0x0D |
| 3 | voltear el tile de arriba abajo |
| 4 | espejarlo de izquierda a derecha |
| 5, 6, 7 | a qué tercios de pantalla va |

Al otro lado de los punteros no hay bytes sueltos: hay un **RLE que se
descomprime directamente a la VRAM**, de ocho en ocho bytes, con el tile de paso
en RAM. Los códigos son 00 acaba, 01-7F repite el byte siguiente n veces, 80 no
hace nada y 81-FF copia n bytes tal cual. El espejo y el volteo se hacen ahí,
con el tile ya montado y antes de soltarlo: salen gratis.

Además de registros, una lista puede traer **órdenes**:

| orden | qué hace |
|---|---|
| 0x10 | copia los 16 bytes que van detrás a una variable |
| 0x11, 0x15, 0x19, 0x1D | escriben una palabra en una de cuatro ranuras |
| 0x12 | nada (y sin avanzar el puntero: ninguna lista la usa) |
| 0x13 | mete una lista dentro de otra |
| 0x17 | carga un recurso de la tabla de 85 |

Y hay un modo por filas: cargando **una fila de píxeles de cada tile por vez**,
con una espera en medio, el dibujo aparece de arriba abajo en vez de salir de
golpe. Eso es el efecto de entrada del panel.

## Los sprites

Los atributos no se escriben directos: hay una copia en RAM de 32 sprites × 4
bytes que se vuelca al VDP en cada repintado. En los fotogramas impares se
vuelca **al revés**, del 29 al 0, con los dos últimos aparte: es la rotación de
prioridad que hace parpadear a los sprites que sobran de los cuatro por línea
en vez de borrarlos.

Cada coche son dos sprites en la misma posición: el patrón y el patrón más
cuatro, con colores distintos. En un TMS9918 esa es la manera de tener una
figura de dos tintas.

El fotograma del coche sale del ángulo, repartido en dieciséis sectores. De F3
para arriba los coches llevan cinco fotogramas más —las ruedas girando— y en las
categorías de abajo no: esos coches no las enseñan.

## Los rivales

Cada jugador lleva cinco rivales, fichas de 0x38 bytes, y **cada uno se atiende
un fotograma de cada ocho**: su turno está escrito en su propia ficha, así que
los cinco no caen nunca en el mismo fotograma.

Un rival mira la pista que tiene por delante —a 0xE8 y a 0x98 píxeles— leyendo
tres casillas de la fila, y de ahí saca dos cosas: si viene curva, y por dónde
hay hueco. Si viene curva, a su velocidad base se le resta lo que diga una de
tres listas, de la frenada más suave a la más dura.

Los choques entre coches se reparten como un choque elástico a medias: la
velocidad nueva de cada uno es la media de las dos, más o menos la cuarta parte
de la diferencia por el eje largo y la octava por el corto.

En la parrilla el jugador 1 sale **tercero** y el 2 **cuarto**, pero la
clasificación es más larga que los seis coches que se ven: a la plaza se le suma
el número de coches que en esa carrera van por delante sin verse, que en la
primera son 20. De ahí que se empiece el 23.

## El sonido

El reproductor de la página 13 corre una vez por interrupción y atiende dos
aparatos: el PSG de la máquina y el SCC del cartucho.

Del PSG escribe los tres canales con su periodo y su volumen, el periodo del
ruido, los tres registros de envolvente y el mezclador. Del SCC, los cinco
canales, sus formas de onda de 32 bytes y su propio mezclador.

Lo caro del SCC es llegar a él: hay que mapear la página 0x3F en 0x8000,
escribir y devolver la 2. Por eso el reproductor lleva una **copia en RAM de los
quince valores** y compara uno a uno; solo los que han cambiado se marcan y solo
esos se escriben. Son quince trozos calcados de siete instrucciones, escritos a
mano y sin bucle: más largos, pero sin cuentas de índices.

Los efectos de las partituras son envolventes por software: dos fases de
volumen, un vibrato de cuatro tramos y un deslizamiento de nota, todo escrito en
la propia partitura como órdenes.
