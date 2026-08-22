# Empezar

## Lo que hace falta

`pasmo` y `z80dasm` para ensamblar y desensamblar, y Python 3 para las
herramientas. Nada más.

El cartucho no viaja con este repositorio: hay que poner el propio, con el
nombre `f1spirit.rom` en la raíz del proyecto. Son 131072 bytes exactos, con
este sha256:

    3b9afd12b29680abb655f05d24e0970954c38e48c5ccb24227d6c710474396a7

Con cualquier otro volcado el listado no vuelve a ensamblar. `make comprueba` lo
dice en una línea.

## Lo que cambia respecto a un cartucho de 16 KB

Esto es un MegaROM de 128 KB con mapper Konami SCC: dieciséis páginas de 8 KB,
cada una con su ventana fija en el mapa del Z80. El desensamblado trata cada
página como un módulo independiente —su propio `org`, su propio trazado, sus
propias notas y su propio listado— y `make verify` reensambla las dieciséis y
las **concatena**: tiene que salir la ROM entera, byte a byte.

## Los comandos

```sh
make          # traza, genera los dieciséis listados y lo comprueba todo
make verify   # ensambla las dieciséis páginas y compara la ROM entera
make sanity   # lo que el reensamblado no puede cazar
make test     # los 31 tests sobre los listados, que no necesitan el cartucho
make externos # las llamadas que cada página hace fuera de sí misma
make web      # estas páginas
```

`make` encadena los cuatro primeros. Si todo va bien, la línea que importa es
ésta:

```
  ensamblado : 131072 bytes  3b9afd12...74396a7
  original   : 131072 bytes  3b9afd12...74396a7
OK: la ROM entera reproducible byte a byte
```

## Qué comprueba `make sanity`

El reensamblado demuestra que los bytes son los mismos, pero no que se hayan
leído bien: unos datos leídos como código dan exactamente el mismo binario. Por
eso hay una segunda tanda de comprobaciones:

- que **la regla página → ventana** la cumplen todos los sitios donde el
  programa manda mapear una página;
- que ningún byte declarado como datos sale como código;
- que ningún despachador está trazado con su tabla sin proteger;
- que ningún punto de entrada declarado cae dentro de una zona de datos;
- y que **no queda ni un byte del cartucho sin asignar** en las dieciséis
  páginas.

## Qué hay en cada carpeta

| | |
|---|---|
| `src/f1spirit_pNN.asm` | los listados comentados, generados; nunca se editan a mano |
| `src/pNN.notes` | las anotaciones de cada página: etiquetas, comentarios, cabeceras y rangos de datos, ancladas a direcciones |
| `src/pNN.entries` | los puntos de entrada que el trazado no puede deducir, cada uno con su justificación |
| `src/pNN.nocode` | las zonas que el trazador no debe leer como código |
| `tools/` | el trazador, el generador de listados, las comprobaciones, el editor de circuitos y las herramientas de dibujo |
| `tests/` | 31 tests sobre los listados, las anotaciones y la web |
| `docs/` | esta web y el editor de circuitos |
| `work/` | lo que `make` va dejando por el camino |

## Cómo leer los listados

Cada línea lleva su dirección al final, en la ventana donde esa página se
ejecuta. Los comentarios no están en el `.asm` —que se regenera— sino en el
`.notes` correspondiente, anclados a dirección, de modo que sobreviven a un
retrazado.

Las llamadas entre páginas salen como direcciones sin nombre (`call 04b28h`)
porque el listado de una página no sabe qué hay en las otras. Para saber a dónde
va cada una, `make externos` las agrupa por destino.
