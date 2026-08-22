# El cartucho

## Un MegaROM de 128 KB

F-1 Spirit no es un cartucho de 16 KB como los Konami de 1984. Son **131.072
bytes**, dieciséis páginas de 8 KB que el Z80 no puede ver a la vez: el
cartucho lleva su propio circuito, el **mapper Konami con SCC**, y el programa
va pidiéndole que ponga en cada ventana la página que necesita.

Las ventanas son cuatro y cada página tiene la suya fija, la que le corresponde
por su número:

| páginas | ventana del Z80 |
|---|---|
| 0 | 0x4000 (siempre puesta) |
| 1, 4, 7, 10, 13 | 0x6000 |
| 2, 5, 8, 11, 14 | 0x8000 |
| 3, 6, 9, 12, 15 | 0xA000 |

La **página 0 es la única fija**: ahí viven la cabecera, la interrupción, las
rutinas de cambio de banco, la lectura de mandos y todo lo que las demás
páginas necesitan tener siempre a mano. El resto se van turnando.

Que cada página tenga una sola ventana posible no es una convención del
desensamblado: es lo que hace el hardware, y el proyecto lo comprueba en cada
compilación. `make sanity` recorre todos los sitios donde el programa manda
mapear una página y verifica que el destino cuadra con la ventana que le toca.

## La cabecera

```
4000  41 42        "AB", la firma de un cartucho
4002  E4 40        INIT = 0x40E4
4004  00 00 00 00 00 00   STATEMENT, DEVICE y TEXT a cero
400A  00 x6        relleno
4010  43 44 07 52 FF      "CD" 07 "R" FF, la firma de Konami
4015  C3 2E BE     jp 0xBE2E
```

La BIOS ve el "AB" en 0x4000, mapea el cartucho y salta a INIT. De ahí el
programa no vuelve: **INIT instala un salto a 0x4018 en el gancho H.KEYI y se queda
en un bucle de dos bytes**. El juego entero corre dentro de la interrupción, igual que en
los Konami de 1984.

La RAM va de 0xE000 a 0xF0FF —INIT la borra entera— con la pila en 0xF0F0, y
en F0F1, F0F2 y F0F3 vive la **sombra del mapper**: qué página hay puesta en
cada ventana. Hace falta porque la interrupción entra en cualquier momento y
tiene que poder devolver el mapeo tal como se lo encontró.

## La interrupción, con dos candados y un freno

La interrupción hace el sonido y llama a la lógica del juego. El problema es
que **la lógica puede tardar más de un fotograma**, y las rutinas de cambio de
banco acaban en `ei`, así que la interrupción vuelve a entrar mientras la
lógica sigue corriendo. De ahí tres mecanismos:

- **bit 1 de E1C5**: ya hay una interrupción dentro de otra, la de fuera se va
  sin tocar nada.
- **bit 0 de E1C5**: la lógica está en curso; la interrupción hace su parte de
  sonido y se va, de modo que el sonido nunca se para aunque el juego se
  atragante.
- **F0FC**: cuenta interrupciones. En la demo y en la carrera la lógica no da
  un paso hasta que haya **tres**, y al darlo pone la cuenta a cero.

Eso último es un reloj fijo: la carrera avanza a un paso de cada tres
interrupciones pase lo que pase con lo que tarde el código.

## La pantalla

SCREEN 2, con los ocho registros que escribe 0x4317 desde la tabla de 0x4328:

| registro | valor | qué dice |
|---|---|---|
| R0 | 0x02 | modo gráfico 2 |
| R1 | 0xE2 | 16 K, pantalla e interrupción encendidas, sprites de 16 × 16 |
| R2 | 0x0E | tabla de nombres en 0x3800 |
| R3 | 0x7F | tabla de color en 0x0000 |
| R4 | 0x07 | tabla de patrones en 0x2000 |
| R5 | 0x76 | atributos de sprite en 0x3B00 |
| R6 | 0x03 | patrones de sprite en 0x1800 |
| R7 | 0xE4 | tinta 14 sobre fondo 4 |

En SCREEN 2 la pantalla está partida en tres tercios de ocho filas y cada
tercio tiene sus propios 256 patrones. El cargador de tiles del cartucho carga
en los tres a la vez: el registro de una lista trae tres bits —uno por tercio—
y el mismo dibujo se descomprime tantas veces como tercios pida.

La tabla de nombres no se escribe directa. El juego lleva **dos buffers de 1 KB
en RAM**, uno por jugador (0xE400 y 0xEC00), que son mapas circulares de 32 × 32
casillas: la pista se pinta ahí y se vuelca a la VRAM. Que sean circulares es lo
que permite que el scroll no tenga que mover nada: solo cambia por qué fila se
empieza a leer.

## El sonido

Dos aparatos a la vez: el **PSG** de la máquina y el **SCC** del propio
cartucho, que da cinco canales más con forma de onda programable. El
reproductor vive en la página 13 y corre una vez por interrupción.

Escribir en el SCC no es gratis: hay que mapear la página 0x3F en 0x8000,
escribir, y devolver la 2. Por eso el reproductor no escribe los quince valores
de los cinco canales en cada interrupción: los **compara con una copia** que
guarda en RAM y solo manda al chip los que han cambiado.
