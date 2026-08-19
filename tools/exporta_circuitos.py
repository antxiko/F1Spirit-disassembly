#!/usr/bin/env python3
"""Saca de la ROM, a un JSON, TODO lo que hace falta para dibujar y editar los
circuitos de F-1 Spirit: las 21 secuencias, las tablas de piezas y de
metatiles, y los tiles (patrones y colores ya descomprimidos) de cada
categoria. Es la parte que necesita conocer el cartucho; con su salida, el
editor HTML no necesita saber nada de la ROM.

De donde sale cada cosa (todo comprobado en src/p00.notes y tools/circuitos.py):
  - la cadena secuencia -> pieza (24 B = 3 filas x 8 metatiles) -> metatile
    (16 B = 4 filas x 4 tiles) la lee tools/circuitos.py, que ademas comprueba
    que cuadra; aqui se reutiliza tal cual.
  - los TILES de la pista los cargan dos listas del cargador de tiles (0x4CCD):
    la comun p04 0x6D00 (p02 0x9272) y una POR CATEGORIA, la que apunta la
    tabla p02 0x927E indexada por (E25B) (p02 0x9266). Cada registro de esas
    listas son 6 bytes: flags, primer tile, puntero a los patrones y puntero a
    los colores, los dos flujos RLE del formato de 0x4D64 (un byte < 0x80
    repite el siguiente esa cantidad de veces; con el bit 7 puesto, copia los
    (c & 0x7F) bytes que vienen; 0 termina). Los bits 1-2 de los flags dicen
    con que grupo de paginas se leen (4 + 3 * ((flags >> 1) & 3)).

Y lo comprueba antes de escribir nada: cada tile que usan los metatiles de una
carrera tiene que estar cargado por las listas de su categoria. Sale con 1 si
falta alguno.

Uso:
    exporta_circuitos.py <rom> [salida.json]     (por defecto work/circuitos.json)
"""
import json
import os
import sys

import circuitos
from graficos import TABLA85, TABLA85_N
from paginas import TAM_PAGINA, N_PAGINAS

ROM = b""
# Las listas de tiles que carga la pagina de la carrera antes de correr:
# p02 0x823B y 0x8241 (preparacion) y p02 0x9272 (la comun de la pista).
LISTAS_COMUNES = (0x6DB5, 0x6DBC, 0x6D00)
TABLA_LISTAS_CAT = 0x927E  # p02: una lista de tiles por categoria (p02 0x9266)
TABLA_LISTAS_PISTA = 0x61A9  # p04: LA de la pista, 21 punteros por carrera (E25C),
                             # tiles 1-205; la lee p00 0x4BCE CARGA_TILES_CIRCUITO
LISTA_COMUN_PISTA = 0x61FD   # p04: la comun de la pista (tiles 206-209)
TABLA_MAPA = 0x7753        # p01: 21 entradas (posicion inicial, camino) del minimapa
INI_MAPAS = 0xB22E         # p06: donde empieza el primer camino
FIN_MAPAS = 0xB805         # p06: donde acaban (ahi empiezan los rotulos de 0xBC6D)
N_CATEGORIAS = 6
CATEGORIAS = ["RALLY", "STOCK", "ENDURANCE", "F3", "F3000", "F1"]
AVISOS = []


def abs_(grupo, addr):
    p = grupo + (addr - 0x6000) // TAM_PAGINA
    if not (0x6000 <= addr < 0xC000) or p >= N_PAGINAS:
        raise ValueError("direccion %#06x fuera de sitio (grupo %d)" % (addr, grupo))
    return p * TAM_PAGINA + (addr - 0x6000) % TAM_PAGINA


def leer(grupo, addr):
    return ROM[abs_(grupo, addr)]


def palabra(grupo, addr):
    return leer(grupo, addr) | (leer(grupo, addr + 1) << 8)


def rle_tiles(grupo, addr):
    """El RLE de 0x4D64, con los bytes que produce."""
    out, a = bytearray(), addr
    while True:
        c = leer(grupo, a)
        a += 1
        if c == 0:
            return bytes(out), a
        if c & 0x80:
            k = c & 0x7F
            for i in range(k):
                out.append(leer(grupo, a + i))
            a += k
        else:
            b = leer(grupo, a)
            a += 1
            out += bytes([b]) * c
        if len(out) > 0x2000:
            raise ValueError("RLE en %#06x (grupo %d) no termina" % (addr, grupo))


def tercios_de(flags):
    """[0,1,2] segun los bits 7/6/5 de los flags del cargador."""
    return [t for t, b in ((0, 0x80), (1, 0x40), (2, 0x20)) if flags & b]


def recorre_lista(addr, grupo=4):
    """Los registros de 6 bytes de una lista del cargador: (tercios, tile, patrones, colores).

    `tercios` son los bits 7/6/5 de los flags: a que tercio de la pantalla
    (0x0000 / 0x0800 / 0x1000 de la tabla de patrones) va el tile, y se repite
    en cada uno que este marcado. F-1 Spirit carga DIBUJOS DISTINTOS con el
    mismo indice en el tercio de arriba y en el de abajo: asi consigue el
    efecto de profundidad de la pista (p00.notes, EL CARGADOR DE TILES).
    """
    regs, a = [], addr
    while True:
        f = leer(grupo, a)
        if f == 0:
            return regs
        if (f & 0xF0) == 0x10:      # ordenes que no cargan tiles por puntero
            k = f & 3
            if k == 0:
                a += 17
            elif k == 1:
                a += 3
            elif k == 3 and f & 4:
                # recurso de la tabla de 85 de p04 0x6000 (5 bytes: flags y los
                # dos punteros), con el primer tile que dice la propia orden
                idx, tile = leer(grupo, a + 1), leer(grupo, a + 2)
                if idx >= TABLA85_N:
                    raise ValueError("recurso %d fuera de la tabla de 85 en %#06x" % (idx, a))
                e = TABLA85 + 5 * idx
                g = 4 + 3 * ((leer(4, e) >> 1) & 3)
                pat, _ = rle_tiles(g, palabra(4, e + 1))
                col, _ = rle_tiles(g, palabra(4, e + 3))
                # el tercio lo dicen los flags DEL RECURSO, no los de la orden
                regs.append((tercios_de(leer(4, e)), tile, pat, col))
                a += 3
            elif k == 3:
                sub = palabra(grupo, a + 1)
                regs += recorre_lista(sub, grupo)
                a += 3
            else:
                AVISOS.append("orden %#04x en la lista %#06x: no se exporta" % (f, addr))
                a += 3
            continue
        tile, ppat, pcol = leer(grupo, a + 1), palabra(grupo, a + 2), palabra(grupo, a + 4)
        g = 4 + 3 * ((f >> 1) & 3)
        pat, _ = rle_tiles(g, ppat)
        col, _ = rle_tiles(g, pcol)
        regs.append((tercios_de(f), tile, pat, col))
        a += 6
        if a - addr > 0x1000:
            raise ValueError("lista %#06x sin fin" % addr)


def juego_de_tiles(lista_pista):
    """[3][256]: los tiles de cada TERCIO de la pantalla (0 arriba, 2 abajo).

    Se cargan las listas comunes, la comun de la pista (0x61FD, tiles 206-209)
    y la de la carrera (tabla p04 0x61A9 por (E25C), tiles 1-205: la pista y
    los decorados). Un registro solo toca los tercios que marcan sus bits
    7/6/5, y AHI ESTA LA PROFUNDIDAD: el mismo indice de tile lleva un dibujo
    distinto en el tercio de arriba (lejos) y en el de abajo (cerca).
    """
    tiles = [[None] * 256 for _ in range(3)]
    for lista in LISTAS_COMUNES + (LISTA_COMUN_PISTA, lista_pista):
        for tercios, tile, pat, col in recorre_lista(lista, 4):
            n = len(pat) // 8
            for k in range(n):
                t = (tile + k) & 0xFF
                p = pat[k * 8:(k + 1) * 8]
                c = col[k * 8:(k + 1) * 8] if len(col) >= (k + 1) * 8 else bytes([0xF0]) * 8
                for tercio in tercios:
                    tiles[tercio][t] = (p, c)
    return tiles


def main(argv):
    global ROM
    if len(argv) < 2:
        sys.exit(__doc__)
    ROM = open(argv[1], "rb").read()
    circuitos.ROM = ROM
    salida = argv[2] if len(argv) > 2 else os.path.join("work", "circuitos.json")

    carreras, tp, up, tm, um, tiles_max, objetos = circuitos.lee_todo()

    # LA LISTA DE TILES ES POR CARRERA, no por categoria: tabla p04 0x61A9
    # (21 punteros por (E25C)), que es la que lee p00 0x4BCE. Varias carreras
    # comparten lista (15 distintas para 21 carreras).
    listas_pista = [palabra(4, TABLA_LISTAS_PISTA + 2 * i) for i in range(len(carreras))]
    juegos = {l: juego_de_tiles(l) for l in sorted(set(listas_pista))}

    # el MINIMAPA de cada carrera: p01 0x7753 da la posicion inicial del
    # marcador y el puntero al camino; cada byte del camino son dos nibbles con
    # signo (el alto suma a la x del marcador, el bajo a la y: p01 0x7827).
    # Los 21 caminos van seguidos, y el ultimo acaba donde empiezan los rotulos.
    mapas, ptrs = [], []
    for i in range(len(carreras)):
        pos = palabra(1, TABLA_MAPA + 4 * i)
        cam = palabra(1, TABLA_MAPA + 4 * i + 2)
        ptrs.append(cam)
        # [x, y]: la palabra es (y en el byte bajo = E2BA, x en el alto = E2BB),
        # que es el orden en que 0x7A26 la mete en el atributo del sprite
        mapas.append({"i": i, "inicio": [pos >> 8, pos & 0xFF], "camino": "%#06x" % cam})
    orden = sorted(range(len(ptrs)), key=lambda k: ptrs[k])
    for n, k in enumerate(orden):
        fin = ptrs[orden[n + 1]] if n + 1 < len(orden) else FIN_MAPAS
        if fin <= ptrs[k]:
            raise ValueError("el camino %#06x no va antes del siguiente (%#06x)" % (ptrs[k], fin))
        mapas[k]["fin"] = "%#06x" % fin
        # [dx, dy] YA CON SIGNO (-8..7), como los deja 0x784E
        mapas[k]["pasos"] = [[circuitos.signo4(b >> 4), circuitos.signo4(b & 15)] for b in
                             (leer(4, ptrs[k] + j) for j in range(fin - ptrs[k]))]
    if min(ptrs) != INI_MAPAS:
        AVISOS.append("el primer camino esta en %#06x y no en %#06x" % (min(ptrs), INI_MAPAS))

    # las tablas de piezas y de metatiles, con sus bytes
    piezas = {}
    for a in sorted(tp):
        n = tp[a] + 1
        piezas["%#06x" % a] = {
            "n": n, "usan": up[a],
            "datos": [[leer(10, a + i * 24 + k) for k in range(24)] for i in range(n)],
        }
    metas = {}
    for a in sorted(tm):
        n = tm[a] + 1
        metas["%#06x" % a] = {
            "n": n, "usan": um[a],
            "datos": [[leer(10, a + i * 16 + k) for k in range(16)] for i in range(n)],
        }

    # COMPROBACION: cada tile que usa una carrera tiene que estar cargado
    faltan, sin_cargar = 0, {}
    for c in carreras:
        cat = c["i"] if c["i"] < 5 else 5
        usados = set()
        for pieza, _ in c["pares"]:
            fila = piezas["%#06x" % c["piezas"]]["datos"][pieza]
            for m in fila:
                usados.update(metas["%#06x" % c["meta"]]["datos"][m])
        juego = juegos[listas_pista[c["i"]]]
        sin = sorted(t for t in usados if all(juego[k][t] is None for k in range(3)))
        sin_cargar.setdefault(c["i"], set()).update(sin)
        if sin:
            faltan += len(sin)
            AVISOS.append("carrera %d (%s): %d tiles que ninguna lista carga: %s"
                          % (c["i"], circuitos.nombre_carrera(c["i"]), len(sin),
                             " ".join("%02X" % t for t in sin[:12])))

    datos = {
        "rom": os.path.basename(argv[1]),
        "categorias": CATEGORIAS,
        "listas_tiles": ["%#06x" % l for l in listas_pista],
        "carreras": [{
            "i": c["i"],
            "nombre": circuitos.nombre_carrera(c["i"]),
            "categoria": c["i"] if c["i"] < 5 else 5,
            "secuencia": "%#06x" % c["sec"],
            "fin": "%#06x" % c["fin_sec"],
            "pagina": 7 + (c["sec"] - 0x6000) // TAM_PAGINA,
            "pares": [[p, f] for p, f in c["pares"]],
            "piezas": "%#06x" % c["piezas"],
            "metatiles": "%#06x" % c["meta"],
            "tiles": "%#06x" % listas_pista[c["i"]],
        } for c in carreras],
        "piezas": piezas,
        "metatiles": metas,
        # por lista de pista, los TRES tercios de la pantalla (0 arriba, 2
        # abajo): el mismo indice lleva dibujos distintos y eso es la
        # profundidad de la pista
        "tiles": {"%#06x" % l: [[None if t is None else {"pat": t[0].hex(), "col": t[1].hex()}
                                 for t in tercio] for tercio in juego]
                  for l, juego in juegos.items()},
        # lo que necesita el editor para escribir en la ROM: las 21 secuencias
        # van contiguas en p07 0x602A-0x7747 (5917 B, LLENOS) y la tabla de
        # punteros esta en 0x6000. Detras de 0x7747 hay graficos: no puede crecer.
        "zona": {"tabla": 0x6000, "ini": 0x602A, "fin": 0x7747,
                 "pagina": 7, "org": 0x6000},
        # y la de los caminos del minimapa: tabla de 21 entradas de 4 B en p01
        # (con 1/2/3) y los caminos contiguos en p06 (con 4/5/6), 1495 B LLENOS
        "zona_mapa": {"tabla": 0x7753, "tabla_pagina": 1, "tabla_org": 0x6000,
                      "ini": 0xB22E, "fin": 0xB805, "pagina": 6, "org": 0xA000},
        "minimapas": mapas,
        # tiles que usan los metatiles y que NINGUNA lista conocida carga: el
        # editor los pinta como huecos. Se cierra con un volcado de VRAM.
        "tiles_sin_cargar": {str(k): sorted(v) for k, v in sin_cargar.items()},
    }
    with open(salida, "w", encoding="utf-8") as f:
        json.dump(datos, f, separators=(",", ":"))
    print("%s: %d carreras, %d tablas de piezas, %d de metatiles, %d juegos de tiles (%d KB)"
          % (salida, len(carreras), len(piezas), len(metas), len(juegos),
             os.path.getsize(salida) // 1024))
    for a in AVISOS:
        print("AVISO:", a)
    return 1 if faltan else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
