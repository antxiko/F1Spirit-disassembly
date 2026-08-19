#!/usr/bin/env python3
"""La regla pagina -> direccion del MegaROM, compartida por todas las herramientas.

F-1 Spirit es un cartucho de 128 KB con el mapper Konami SCC: 16 paginas de
8 KB que el codigo va metiendo en las cuatro ranuras de 0x4000-0xBFFF
escribiendo el numero de pagina en 0x5000, 0x7000, 0x9000 y 0xB000.

Lo que dice la ROM (tools/reconocimiento.py lo vuelve a medir):
  - NADIE escribe en 0x5000: la pagina 0 queda fija en 0x4000-0x5FFF.
  - Las rutinas de banco de la pagina 0 (0x43FE, 0x441B, 0x4447, 0x4457) y
    todos sus llamadores ponen siempre la pagina 3k+1 en 0x6000, la 3k+2 en
    0x8000 y la 3k+3 en 0xA000 (k = 0..4). Es decir, cada pagina tiene UNA
    sola direccion donde se ejecuta, y es esta:

        pagina 0            -> 0x4000
        paginas 1,4,7,10,13 -> 0x6000
        paginas 2,5,8,11,14 -> 0x8000
        paginas 3,6,9,12,15 -> 0xA000

  Si alguna vez aparece una pagina mapeada en otra ranura, esta regla deja de
  valer para ESA pagina y habra que partirla en dos modulos.

Uso como programa:
    paginas.py org <n>               imprime el org de la pagina n
    paginas.py lista                 imprime "n org" para las 16
    paginas.py corta <rom> <dir>     escribe <dir>/pNN.bin con cada pagina
"""
import os
import sys

TAM_PAGINA = 0x2000
N_PAGINAS = 16


def org(p):
    """Direccion en la que se ejecuta la pagina p."""
    if p == 0:
        return 0x4000
    return 0x6000 + ((p - 1) % 3) * TAM_PAGINA


def nombre(p):
    """Nombre del modulo de la pagina p: p00..p15."""
    return "p%02d" % p


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    if argv[1] == "org":
        print("%#06x" % org(int(argv[2], 10)))
    elif argv[1] == "lista":
        for p in range(N_PAGINAS):
            print("%d %#06x" % (p, org(p)))
    elif argv[1] == "corta":
        rom, dst = argv[2], argv[3]
        d = open(rom, "rb").read()
        if len(d) != TAM_PAGINA * N_PAGINAS:
            sys.exit("la ROM mide %d bytes y no %d" % (len(d), TAM_PAGINA * N_PAGINAS))
        os.makedirs(dst, exist_ok=True)
        for p in range(N_PAGINAS):
            with open(os.path.join(dst, nombre(p) + ".bin"), "wb") as f:
                f.write(d[p * TAM_PAGINA:(p + 1) * TAM_PAGINA])
        print("16 paginas de %d bytes en %s/" % (TAM_PAGINA, dst))
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
