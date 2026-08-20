# F-1 Spirit - The Way to Formula 1 (Konami, 1987, MSX1) — desensamblado

El MegaROM de carreras de Konami (RC-752, 128 KB, mapper Konami SCC —el
`KonamiSCC` de openMSX—, chip de sonido SCC), desmontado pagina a pagina. **En marcha**: el arranque, la
interrupcion, el mapper, la lectura de mandos y el reproductor de sonido ya
estan trazados; el resto de la ROM esta acotado como pendiente.

## Que es esto

La ROM son 16 paginas de 8 KB. La pagina 0 queda fija en 0x4000-0x5FFF; las
otras quince el juego las va metiendo en 0x6000, 0x8000 y 0xA000 escribiendo
en 0x7000, 0x9000 y 0xB000, siempre en la ranura que les toca por su numero
(`tools/paginas.py`). Por eso aqui no hay UN listado sino DIECISEIS,
`src/f1spirit_p00.asm` a `src/f1spirit_p15.asm`, cada uno con el `org` de la
ranura donde se ejecuta. Concatenados en orden dan la ROM entera.

INIT (0x40E4) instala `jp 0x4018` en el gancho H.KEYI y se queda en un `jr $`:
el juego entero corre dentro de la interrupcion, que mapea la pagina 13 (el
sonido, PSG + SCC) en cada fotograma y luego restaura los bancos que habia.

## Como se reensambla

Hace falta la ROM en la raiz como `f1spirit.rom` (131072 bytes, sha256
`3b9afd12...96a7`; no se distribuye), `make`, `pasmo`, `z80dasm`, `python3`
y `shasum`. En esta maquina:

    export PATH="/c/msys64/usr/bin:/c/Users/Antxiko/AppData/Local/Programs/pasmo:$PATH"
    make comprueba   # el sha256 de la ROM
    make reconoce    # cabecera, mapper, SCC y la regla pagina -> org
    make listado     # traza cada pagina y genera los 16 listados
    make verify      # 16 x pasmo y la concatenacion contra la ROM
    make sanity      # datos leidos como codigo, entradas en datos, presupuesto
    make test        # tests/test_listado.py
    make externos    # llamadas fuera de pagina pendientes de resolver

Y para resolver en el emulador que pagina hay mapeada en cada llamada fuera
de pagina (openMSX detecta solo el mapper; 90 s de demo resolvieron 52):

    openmsx -machine Philips_VG_8020 -cart f1spirit.rom -script tools/omsx_bancos.tcl

`make verify` tiene que acabar en `OK: la ROM entera reproducible byte a byte`.

## Estado

| | |
|---|---|
| bytes de codigo trazado | 30.658 (23,4 %) |
| bytes de datos identificados por herramienta o a mano | 100.414 (76,6 %) |
| de esos, todavia marcados `pendiente_de_trazar` | 3.067 (2,3 %) |
| bytes sin asignar | **0** |
| explicado de verdad | **97,7 %** |
| paginas con codigo | 0, 1, 2, 3, 13, 15 (la 1 y la 2, comentadas enteras) |
| paginas de datos identificadas al 100 % | 5, 7, 10, 11, 14 |

Las notas de cada pagina estan en `src/pNN.notes`; las semillas del trazador,
con su justificacion, en `src/pNN.entries`. El detalle de lo hecho y lo que
falta, en `.forja/handoff.md`.

## Las herramientas

Las de la serie (`z80trace.py`, `mkasm.py`, `presupuesto.py`,
`check_datos_como_codigo.py`, `check_entradas.py`, `check_trace.py`), mas
las que pide un MegaROM: `paginas.py` (la regla pagina -> org y el cortador),
`reconocimiento.py` (mapper y SCC), `externos.py` (llamadas fuera de pagina),
`huecos.py` (los marcadores de lo pendiente), `despachadores.py` (los "call
seguido de tabla"), `siembra_medidas.py` (de las medidas del emulador a los
.entries) y los arneses de openMSX `omsx_arranque.tcl`, `omsx_bancos.tcl` y
`omsx_fuerza_estados.tcl`.

Y los LECTORES DE DATOS, que son lo que distingue a este proyecto: en un
MegaROM de 128 KB el 77 % son datos, y cada bloque se identifica recorriendo
la ROM igual que lo hace el codigo, con una herramienta que comprueba que
cuadra y sale con 1 si no: `graficos.py` (el cargador de tiles, el de sprites
y los fotogramas de los coches), `circuitos.py` (secuencias, piezas,
metatiles y objetos de la pista), `textos.py` (los textos con su diccionario
de macros y las pantallas comprimidas) y `sonido.py` (cabeceras, envolventes,
formas de onda del SCC y pistas). `vuelca_bloques.py` mete lo que dicen en
los `.notes`, y un test vigila que notas y herramientas digan lo mismo.
