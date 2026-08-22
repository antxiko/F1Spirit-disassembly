# El juego

## Seis categorías y veintiuna carreras

El menú reparte seis categorías. El juego las numera en un orden y el menú las
enseña en otro, y para eso existe una tabla de cinco bytes en p01 0x6135:

| valor de E25B | categoría |
|---|---|
| 0 | RALLY |
| 1 | STOCK |
| 2 | ENDURANCE |
| 3 | F3 |
| 4 | F3000 |
| 5 | F1 |

Las carreras van de 0 a 20. Las cinco primeras son las categorías de abajo; de
la 5 en adelante son los **dieciséis Grandes Premios** de F1, y la carrera es
5 más el GP elegido. Los nombres están en el cartucho: BRAZIL, SAN MARINO,
BELGIUM, MONACO, U.S.A., FRANCE, GREAT BRITAIN, WEST GERMANY, HUNGARY, AUSTRIA,
ITALY, PORTUGAL, SPAIN, MEXICO, JAPAN y AUSTRALIA.

Cuántas vueltas tiene cada carrera depende de la categoría: **tres o cuatro**,
de la tabla de p02 0x91DB.

## Lo que se abre con puntos

No se puede elegir todo desde el principio. La pantalla de categorías va
añadiendo opciones según los puntos que se lleven, y los umbrales están
escritos como una escalera de comparaciones:

- con **0x0C** puntos aparecen dos opciones más,
- con **0x19**, una más,
- y a partir de ahí una escalera de ocho umbrales —0x21, 0x30, 0x41, 0x54,
  0x69, 0x80, 0x99 y 0xB4— que van abriendo **dos Grandes Premios cada uno**,
  más uno al pasar el último: dieciséis en total.

Basta con que **uno de los dos jugadores** llegue al umbral para que se abra.

## El coche se monta pieza a pieza

Antes de correr se elige coche, y hay dos maneras: coger uno de los dieciocho
predefinidos —cinco bytes hechos— o montarlo en cinco pasos: motor, carrocería,
dos piezas más y caja de cambios. Esos cinco bytes son los que luego se
traducen a los números con los que el coche corre:

- el **motor** da la velocidad máxima y la tabla de par;
- la **carrocería** da el color del sprite y, multiplicada por cuatro, **lo que
  aguantan los neumáticos** antes de reventar;
- la **caja de cambios** da las relaciones: cuánto sube de vueltas el motor por
  cada unidad de velocidad, y cuánto empuja en cada marcha.

Hay cuatro marchas, de la 0 a la 3, y el cambio puede ser manual o automático
—lo dice el bit 7 del quinto byte del coche—. En automático decide cada 30
fotogramas: por debajo de 32 revoluciones baja y por encima de 56 sube.

## Conducir

El volante no es un interruptor: es una **rampa**. Mientras se mantiene la
dirección, un contador sube de dos en dos hasta 16, y el giro por fotograma
sale de una tabla que cruza tres cosas: los neumáticos elegidos, la velocidad
y el escalón de rampa en que se esté. Al soltar, el coche se endereza solo.

La velocidad se convierte en avance con el seno y el coseno del ángulo, así que
el coche va donde apunta el morro y no donde apunta el mando. Y cada categoría
frena distinto al girar: la velocidad pierde una 256 parte, la mitad de eso o
la cuarta parte según la categoría, y la 5 no pierde nada.

Salirse del asfalto cuesta una **32 parte de la velocidad por fotograma**. El
borde de la pista rebota: la mitad de la velocidad de lado se suma a la otra,
el ángulo se corrige ocho grados y la velocidad de lado se invierte y se parte
por dos. Si el golpe es fuerte —en RALLY, de 3 para arriba—, no es rebote: es
choque.

## Los neumáticos

Los cuatro neumáticos se llevan en cuatro bits, y cada uno roto hace algo
distinto:

| bit | qué pasa |
|---|---|
| 0 | el volante se queda clavado uno de cada cuatro fotogramas |
| 1 | el coche pega tirones al azar a partir de cierta velocidad |
| 2 | acelerar cuesta la mitad |
| 3 | frenar cuesta la mitad |

Revientan de dos maneras: por **desgaste**, cuando el contador llega a cuatro
veces el byte de la carrocería, y a los 90 fotogramas de un **choque**. Cuál de
los cuatro revienta se sortea con una tabla de ocho entradas, cada neumático
dos veces, así que los cuatro salen igual de probables.

## Boxes

Con un solo jugador, entrar en boxes cambia el estado de la partida entera y se
ve una escena aparte. Dos mecánicos —dos fichas de seis bytes— suben desde
abajo de dos en dos píxeles, con ocho poses y cuatro sprites cada uno: son
figuras de 16 × 32 píxeles en dos tintas, hechas con dos parejas de sprites
superpuestas.

Mientras se reposta, **los rivales te adelantan**: tres fichas que bajan de
ocho en ocho píxeles, y cada una que cruza la mitad de la pantalla te suma un
puesto en el marcador, hasta el tope de 99. El hueco entre coche y coche se
sortea, y en la categoría 0 son mucho más raros.

Se puede cortar la parada con el botón; abajo reposta. Y al salir, el
combustible está lleno y los cuatro neumáticos sanos.

## El cronómetro va lento en PAL

El cronómetro es de 24 bits y sube uno por cada paso de lógica. La interrupción
da un paso cada tres, y el reloj de pantalla divide por 20 para sacar los
segundos: **3 × 20 = 60**. La cuenta está hecha para una máquina de 60 Hz.

En una máquina PAL, con 50 interrupciones por segundo, salen 16,67 pasos, así
que el reloj marca **cinco segundos por cada seis reales**. No es que el juego
vaya más despacio: es que el cronómetro cuenta mal.

Lo que se lee en pantalla son minutos, segundos y centésimas. Las centésimas
salen de multiplicar el resto por 100 y dividir por 2, o sea que el juego
trabaja en veinteavos de segundo y sus milésimas acaban siempre en 0 o en 5.

## La contraseña

La partida se guarda en un código de letras. Dentro son 21 valores —lo
conseguido en cada una de las 21 carreras, recortado a un nibble cada uno—, dos
de control (la XOR de todos y la suma) y delante **un nibble sacado del
registro R del Z80**, el contador de refresco de memoria, que es lo más
parecido a un dado que hay a mano.

Los 24 símbolos se cifran con una tirada de nibbles que sale **de la propia
ROM**: los bytes de la página 0 desde 0x5000, empezando por donde diga el
nibble al azar. Y solo entonces se pasan a letras sumándoles 0x41.

Además hay **seis contraseñas especiales**, cada una con su código pegado
detrás:

| contraseña | qué hace |
|---|---|
| `MAXPOINT` | deja de mirar los umbrales: todo abierto |
| ` UJM3EDC` | empieza por un espacio, y las letras son dos columnas del teclado |
| `MITAIYOENDDEMO` | salta a la secuencia final |
| `HYPEROFF` | enciende la variable que en boxes pone a trabajar a los mecánicos |
| `ESCON` / `ESCOFF` | encienden y apagan el permiso para cortar la repetición |

## La demo se juega sola

La demo no es una película grabada: es **el juego corriendo con el mando
enchufado a una grabación**. El grabador apunta parejas de (cuadros, máscara)
cada vez que cambia lo que se pulsa, y el reproductor las va metiendo donde
normalmente estaría el puerto del mando.

Hay cinco grabaciones y solo la primera está en RAM: por eso el grabador se
planta si el puntero se sale de 0xC000-0xDEFF.
