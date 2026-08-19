#!/usr/bin/env python3
"""Escribe en la ROM los CAMINOS DEL MINIMAPA editados y regenera sus punteros.
Gemela de parchea_circuitos.py: el editor HTML puede descargar la ROM, pero lo
que comprueban los tests es esta herramienta.

LA ZONA (hecho-verificado 2026-08-19 contra la ROM y las notas):
  - la tabla p01 0x7753 tiene 21 entradas de dos palabras: posicion inicial del
    marcador (y en el byte bajo = E2BA, x en el alto = E2BB) y el puntero al
    camino;
  - los 21 caminos van CONTIGUOS de p06 0xB22E a 0xB805 = 1495 bytes, LLENOS
    (0 libres), y detras empiezan los rotulos: la zona no puede crecer;
  - cada paso es un byte = dos nibbles CON SIGNO (el alto se suma a la x del
    marcador y el bajo a la y: p01 0x7827 y 0x784E). En la ROM se usan -7..7.
  - un trazado tiene que CERRAR: los deltas suman (0, 0) en los dos ejes, como
    cumplen las 21 de la ROM.

OJO A LA OTRA MITAD: en las 21 carreras se cumple `pasos = piezas/2 + 1`, o sea
que cambiar el numero de pasos descuadra la secuencia del circuito (p07). Esta
herramienta avisa, pero no la toca: eso es parchea_circuitos.py.

El parche es {"minimapas": [{"i": 0, "pasos": [[dx, dy], ...],
                             "inicio": [x, y]}]}; lo que no aparezca se copia
de la ROM. Un parche vacio tiene que devolver la ROM identica.

Uso:
    parchea_minimapas.py <rom> <parche.json> <salida.rom>
    parchea_minimapas.py <rom> --nada <salida.rom>      viaje redondo
Sale con 1 si no cabe o si algun dato no es valido.
"""
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import circuitos

TABLA = 0x7753          # p01 (mapeo 1/2/3): 21 entradas de 4 bytes
INI_ZONA = 0xB22E       # p06 (mapeo 4/5/6): donde empieza el primer camino
FIN_ZONA = 0xB805       # donde empiezan los rotulos
N = 21


def off_tabla(addr):
    """Byte de la ROM de addr leida con la pagina 1 en 0x6000."""
    return 1 * 0x2000 + (addr - 0x6000)


def off_camino(addr):
    """Byte de la ROM de addr leida con 4/5/6 (la p06 cae en 0xA000)."""
    return 6 * 0x2000 + (addr - 0xA000)


def nibble(v):
    """Los deltas van en un nibble con signo: -8..7."""
    return v & 0x0F


def lee_caminos(rom):
    """[[i, addr, pasos, inicio]] en el ORDEN EN QUE ESTAN EN LA ROM."""
    circuitos.ROM = rom
    ptrs = [circuitos.palabra(1, TABLA + 4 * i + 2) for i in range(N)]
    pos = [circuitos.palabra(1, TABLA + 4 * i) for i in range(N)]
    orden = sorted(range(N), key=lambda k: ptrs[k])
    fuera = []
    for n, k in enumerate(orden):
        fin = ptrs[orden[n + 1]] if n + 1 < len(orden) else FIN_ZONA
        pasos = []
        for j in range(fin - ptrs[k]):
            b = circuitos.leer(4, ptrs[k] + j)
            pasos.append([circuitos.signo4(b >> 4), circuitos.signo4(b & 15)])
        fuera.append([k, ptrs[k], pasos, [pos[k] >> 8, pos[k] & 0xFF]])
    return fuera


def cierra(pasos):
    return sum(p[0] for p in pasos) == 0 and sum(p[1] for p in pasos) == 0


def parchea(rom, cambios, inicios=None):
    """rom + {i: pasos} (+ {i: [x, y]}) -> rom nueva. ValueError si no cabe."""
    filas = lee_caminos(rom)
    inicios = inicios or {}
    for i, pasos in cambios.items():
        if not 0 <= i < N:
            raise ValueError("la carrera %r no existe" % i)
        for dx, dy in pasos:
            if not -8 <= dx <= 7 or not -8 <= dy <= 7:
                raise ValueError("el paso (%r, %r) de la carrera %d no cabe en "
                                 "dos nibbles con signo (-8..7)" % (dx, dy, i))
        if not cierra(pasos):
            raise ValueError("el trazado de la carrera %d no cierra: los deltas "
                             "suman (%d, %d) y tienen que sumar (0, 0)"
                             % (i, sum(p[0] for p in pasos), sum(p[1] for p in pasos)))
        for fila in filas:
            if fila[0] == i:
                fila[2] = [list(p) for p in pasos]

    total = sum(len(f[2]) for f in filas)
    if total > FIN_ZONA - INI_ZONA:
        raise ValueError("los 21 caminos suman %d bytes y solo caben %d (sobran %d)"
                         % (total, FIN_ZONA - INI_ZONA, total - (FIN_ZONA - INI_ZONA)))

    nueva = bytearray(rom)
    a = INI_ZONA
    for i, _, pasos, inicio in filas:
        x, y = inicios.get(i, inicio)
        nueva[off_tabla(TABLA + 4 * i)] = y & 0xFF          # E2BA = y
        nueva[off_tabla(TABLA + 4 * i) + 1] = x & 0xFF      # E2BB = x
        nueva[off_tabla(TABLA + 4 * i) + 2] = a & 0xFF
        nueva[off_tabla(TABLA + 4 * i) + 3] = a >> 8
        for dx, dy in pasos:
            nueva[off_camino(a)] = (nibble(dx) << 4) | nibble(dy)
            a += 1
    return bytes(nueva), total, a


def main(argv):
    if len(argv) < 4:
        sys.exit(__doc__)
    rom = open(argv[1], "rb").read()
    cambios, inicios = {}, {}
    if argv[2] != "--nada":
        d = json.load(open(argv[2], encoding="utf-8"))
        for m in d.get("minimapas", []):
            cambios[int(m["i"])] = m["pasos"]
            if "inicio" in m:
                inicios[int(m["i"])] = m["inicio"]
    try:
        nueva, total, fin = parchea(rom, cambios, inicios)
    except ValueError as e:
        print("ERROR:", e)
        return 1
    open(argv[3], "wb").write(nueva)
    print("%s: %d caminos tocados, %d de %d bytes usados (%d libres), acaba en %#06x"
          % (argv[3], len(cambios), total, FIN_ZONA - INI_ZONA,
             FIN_ZONA - INI_ZONA - total, fin))
    if nueva == rom:
        print("  la ROM sale IDENTICA a la original")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
