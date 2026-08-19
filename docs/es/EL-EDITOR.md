# El editor de circuitos

F-1 Spirit guarda sus 21 circuitos como listas de piezas, y esas listas se
pueden reescribir. El editor es una página HTML que lee la ROM, pinta cada
circuito como lo pinta el juego y deja cambiarlo: se abre con doble clic, no
necesita conexión y descarga la ROM ya parcheada.

    python3 tools/haz_editor.py f1spirit.rom
    tools/editor/circuitos.html

La página se genera con la ROM y los datos dentro (unos 800 KB), así que una
vez creada funciona sola.

## Lo que se ve

**La pista**, en el centro, como una tira vertical: cada franja de 32 × 12
tiles es una pieza de la secuencia, con la salida abajo. Debajo de la última
va la primera de la vuelta siguiente, atenuada y con la costura marcada.

**El minimapa**, arriba a la izquierda, en sus coordenadas de pantalla: el
marcador del juego vive en la esquina superior derecha, y ahí se dibuja. Cada
tramo se colorea con la dirección que llevan sus piezas —rojo a la izquierda,
verde a la derecha, cian recto— y el punto rojo marca dónde estás editando.

**El panel**, con la carrera, las tablas que usa, el presupuesto de bytes y los
avisos.

## Cómo se edita

Se pincha una franja de la pista, o se llega a ella con las flechas, y se
cambia:

| tecla | qué hace |
|---|---|
| `↑` `↓` | avanzar y retroceder por el circuito (da la vuelta al llegar al final) |
| `←` `→` | girar la pista una columna a la izquierda o a la derecha |
| `+` `−` | cambiar la pieza |
| `Supr` | borrar la pieza |
| `Inicio` `Fin` | ir a la salida o al final de la vuelta |

Los botones del panel hacen lo mismo, y añaden insertar una copia antes o
después, subir, bajar, deshacer (200 pasos) y revertir la carrera entera.

**Girar es lo que hace serpentear la pista.** El desplazamiento se suma módulo
8 a la columna con la que se lee la fila de metatiles de cada pieza, y se
acumula de una a la siguiente: por eso `0x47` (una columna a la izquierda) y
`0x41` (una a la derecha) son los dos valores más usados de la ROM. Ojo con lo
que *no* hace: rota la fila en vez de trasladarla, así que la pista nunca se va
fuera de la pantalla, y no toca al coche —el acumulador sólo lo leen las tres
instrucciones que pintan la fila—.

## Los tres tercios

En SCREEN 2 la tabla de patrones son tres bancos, uno por cada tercio de la
pantalla, y el juego carga **dibujos distintos con el mismo índice** en el de
arriba y en el de abajo: así consigue la profundidad de la pista. El selector
de tercio elige con cuál se pinta; "los tres" reparte como se ve en pantalla.

## El minimapa

Es un dato aparte: 21 caminos de bytes en la página 6, cada byte dos nibbles
con signo que mueven el marcador. Su **forma no sale de la secuencia** —si
cambias los desplazamientos, aquí no se mueve nada, ni en el editor ni en el
juego—, pero su **longitud sí está atada**: en las 21 carreras se cumple

    pasos = piezas / 2 + 1

o sea un paso cada dos piezas. Por eso el panel avisa en cuanto añades o quitas
piezas: el camino se queda contando otra cosa.

Marcando *editar el trazado* el minimapa salta a un panel grande y se pueden
arrastrar sus puntos. Al mover uno sólo cambian los dos tramos que lo tocan, de
modo que la suma de los desplazamientos no varía y **el trazado sigue
cerrando**, como cierran los 21 de la ROM. Si un tramo no cabe en un paso
(los nibbles llegan a ±7), el punto no se mueve.

## El presupuesto

Las dos zonas están llenas en la ROM original:

| zona | dónde | tamaño | libre |
|---|---|---|---|
| las 21 secuencias | p07 0x602A–0x7747 | 5917 B | 0 |
| los 21 caminos del minimapa | p06 0xB22E–0xB805 | 1495 B | 0 |

Detrás de cada una empiezan otros datos, así que no pueden crecer: **para
añadir una pieza hay que quitar otra**, aquí o en otra carrera. Alargar un
circuito un paso cuesta 1 byte de camino y 4 de secuencia. El medidor del panel
lo lleva al día y, si te pasas, los botones de exportar se apagan.

## Exportar

- **ROM parcheada**: la ROM entera con tus cambios, lista para el emulador.
- **Parche .json**: sólo lo que has tocado. Lo aplican

      python3 tools/parchea_circuitos.py f1spirit.rom parche.json salida.rom
      python3 tools/parchea_minimapas.py f1spirit.rom parche.json salida.rom

Las dos herramientas recolocan las secuencias o los caminos seguidos desde el
principio de su zona y regeneran la tabla de punteros, que es exactamente lo
que hace el editor. Sin cambios devuelven la ROM idéntica, y eso lo comprueban
los tests del proyecto —incluido uno que ejecuta el JavaScript de la propia
página y compara su salida byte a byte con la de las herramientas—.

## No perder el trabajo

Cada cambio se guarda solo en el navegador, y al volver a abrir la página se
recupera —lo dice el rótulo de debajo de los botones—. Aun así, **la copia de
seguridad de verdad es el fichero**:

- **⬇ proyecto .json** baja lo que has tocado (pistas y trazados).
- **⬆ abrir .json** lo vuelve a cargar, aquí o en otro ordenador.
- **empezar de cero** tira los cambios y vuelve a la ROM original.

El guardado del navegador puede no persistir al abrir la página desde el disco,
según cuál uses; el `.json` no depende de eso. Ese mismo fichero es el que
aplican `parchea_circuitos.py` y `parchea_minimapas.py`.

## Repartirlo

El editor del repositorio lleva la ROM dentro, así que **no se puede repartir**:
sería repartir el juego. Para eso está la versión portable:

    python3 tools/haz_editor.py f1spirit.rom --portable
    tools/editor/circuitos_portable.html

Son 43 KB y no contienen nada del cartucho: al abrirla pide que cargues tu
propia ROM y saca de ella los circuitos, los gráficos y los minimapas en el
navegador, sin subir nada a ningún sitio. Lo hace `tools/editor/lector.js`, que
repite lo que hace `tools/exporta_circuitos.py`; que los dos dicen exactamente
lo mismo lo comprueba un test con node.

## Lo que todavía no hace

Editar las piezas por dentro (la rejilla de 3 × 8 metatiles). Cuando lo haga
habrá que avisar de algo: las tablas de piezas se comparten entre carreras —la
de 112 piezas la usan quince—, así que tocar una cambia varios circuitos a la
vez.
