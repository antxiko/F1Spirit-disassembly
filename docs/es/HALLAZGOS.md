# Hallazgos

Lo que se ha ido encontrando al leer el cartucho instrucción a instrucción.
Todo lo de aquí está medido sobre el binario; cuando algo es una hipótesis, se
dice.

## El cronómetro está hecho para 60 Hz

La cuenta es de tres piezas: el cronómetro sube uno por paso de lógica, la
interrupción da un paso cada **tres**, y el reloj de pantalla divide por **20**
para sacar los segundos. 3 × 20 = 60.

En una máquina NTSC el reloj va exacto. En una PAL, con 50 interrupciones por
segundo, salen 16,67 pasos, así que el cronómetro marca **cinco segundos por
cada seis reales**. Es el reloj el que cuenta mal, no el juego el que va lento:
el reparto de tres interrupciones por paso hace que la carrera avance siempre al
mismo ritmo relativo.

## La repetición está desactivada por un `scf`

El estado normal del coche empieza así:

```
8C70  B7        or a          ; borra el acarreo
8C71  37        scf           ; y lo vuelve a poner
8C72  D2 D3 89  jp nc,0x89D3  ; ...así que este salto no se toma NUNCA
```

Los bytes son ésos, comprobados en la ROM. El `scf` deja el acarreo puesto
siempre, de modo que el `jp nc` nunca salta. Y con él se cae la rutina de
0x89D3, la que haría que en la repetición el coche copiase lo que hace el objeto
grabado: **sus dos bytes D3 89 aparecen una sola vez en los 128 KB del
cartucho**, y es justo el operando de ese salto.

La repetición sigue funcionando —tiene su propio camino en otro sitio—, pero esa
rama concreta está muerta.

## Una escalera de divisiones que se comía un factor de ocho

En la página 0 hay una escalera de ocho parejas `sra h / rr l` seguidas y un
`ret`. Cada entrada divide por dos tantas veces como parejas le queden por
delante: entrando por 0x4A76 son ocho (÷256), por 0x4A7E seis (÷64), por 0x4A86
cuatro (÷16) y por 0x4A8A tres (÷8).

Al leerlas se vio que la ficha de la frenada del coche decía "vy -= vy/8"
citando 0x4A7E, y **0x4A7E divide por 64**. Son seis parejas, no tres; los bytes
son `CB 2C CB 1D` repetidos. El rozamiento del coche es ocho veces más suave de
lo que estaba escrito.

De paso apareció otra: el tercer `sbc hl,de` del arrastre (0x9934) es el único
de los tres que **no lleva or a delante**, así que se come el acarreo que deja
el último `rr l` de la escalera y le resta un 1 de más a la velocidad siempre que
el bit que salió por abajo valiera uno.

## Los rivales te cuestan puestos de dos maneras

Mientras estás **parado en boxes**, los rivales que cruzan la pantalla te suman
un puesto cada uno, hasta el tope de 99. El hueco entre coche y coche se sortea:
en la categoría 0 el sumando es 30 y en las demás 5, así que en RALLY pasan
mucho más de tarde en tarde.

Y un rival que **cruza la meta** después de ti también te suma un puesto, con el
mismo tope. Cada rival lo cobra una sola vez: se marca con un bit de sus propias
banderas.

## El objeto de pista se planta en el centro del hueco

Los carteles del borde no se colocan donde diga la lista: la lista dice en qué
fila van, y el código les busca sitio. Recorre diez posiciones de la fila, de
tres en tres columnas, buscando **cinco casillas seguidas** cuyo tile sea de
fondo, y planta el objeto en el centro del hueco.

Con una curiosidad: de las cuatro casillas que comprueba además de la primera,
si la que falla es la **cuarta** el hueco se acepta igual. En la práctica solo
mandan las tres primeras.

## Ocho puertas sin llamador

En la página 0 hay ocho entradas de rutina cuyos dos bytes **no aparecen ni una
vez en los 128 KB** —ni como operando de un `call` ni dentro de una tabla de
saltos— y a las que no se llega cayendo desde la instrucción de antes: 0x4A55,
0x4A76, 0x4A97, 0x4B48, 0x4BA3, 0x4C8C, 0x4C9A y 0x4CAF.

Con 0x4B48 se cae además todo lo que cuelga de él: el copiador de rectángulos
entero es código muerto.

## Una instrucción que cruza la frontera de dos páginas

En 0x7FFF, el último byte de la página 1, hay un `sub` (0xD6). Su operando es el
primer byte de la página 2 (0xD4), y la rutina sigue en 0x8001. Es **la única
instrucción del cartucho que cruza una frontera de página**, y funciona porque
las dos ventanas son contiguas en el mapa del Z80.

Hay más código que se sale de su página —la rutina de 0x5FD7 acaba saltando a
0x6057 y a 0x60F3, ya en la página 1—, pero eso son saltos: legales porque la
página 0 está fija, aunque el listado no pueda seguirlos.

## Los créditos están en claro

En la página 2, en 0x848A, hay un flujo de texto con los créditos completos, sin
cifrar ni comprimir:

> STAFF — PROGRAM: T.ADACHI, M.OZAWA, R.SAGISAKA — GRAPHIC: H.MAKITANI,
> T.SHIMIZU, B.KINOSHITA — SOUND: K.UEHARA, M.SASAKI, M.FURUKAWA

## Dos erratas hermanas del cartucho

Las dos son el mismo descuido, y las dos hacen que una segunda pasada repita el
trabajo del jugador 1 en vez de hacer el del 2.

- En p03 0xA779 los bytes son `FD 21 28 E9 FD 21 80 E3`, o sea `ld iy,0E928h`
  seguido de `ld iy,0E380h`: la primera carga no hace nada, porque la siguiente
  la pisa. Por el patrón de las dos instrucciones de arriba, el prefijo tendría
  que ser DD —`ld ix`— y no FD.
- En p02 0x8025, el arranque de los rivales llama dos veces a la misma rutina,
  una por coche, pero **entre las dos no se cambia IY**: se queda en el coche 1.
  Falta un `ld iy,0E380h`.

Que la carga se pisa está leído; que se quería escribir otra cosa es
inferencia. Ninguna de las dos se nota jugando: en p02, el único que lee lo que
esa segunda pasada dejaría es una rutina que vuelve a hacer la cuenta justo
antes cada vez.

## El eje que las notas llaman "x" es el vertical

La ficha de cada coche tiene dos coordenadas y en el desensamblado se venían
llamando x e y. Al leer el pintor de sprites se ve que la primera es la que
acaba en el **byte Y del atributo**, que en el TMS9918 es la vertical. Y lo
confirma la entrada de rivales: el lento entra por 0 —arriba, por delante— y el
rápido por 0xB7 —abajo, por detrás—.

O sea que el "x" del juego es el eje a lo largo de la pista, que en pantalla se
ve en vertical.

## De los tres sprites del final solo sube uno

En la escena final hay tres sprites que se mueven a la vez. Los tres avanzan a la
derecha, pero solo el primero sube: el bucle corre el valor un bit antes de
restarlo, así que al segundo le toca la mitad y al tercero la cuarta parte, y las
dos son cero.
