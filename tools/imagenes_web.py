#!/usr/bin/env python3
"""Dibuja las imagenes de la web repitiendo lo que hace el cartucho.

Aqui no hay capturas de pantalla ni ilustraciones traidas de fuera: los
circuitos se pintan siguiendo la misma cadena que sigue el juego (secuencia ->
piezas -> metatiles -> tiles, con los tres bancos de patrones de SCREEN 2) y
los minimapas integrando sus caminos de nibbles con signo. Si un rango
estuviera mal etiquetado, saldria ruido.

Uso: imagenes_web.py <rom> <directorio>
"""
import os
import struct
import sys
import zlib

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import circuitos                                                # noqa: E402
import exporta_circuitos as E                                   # noqa: E402

# la paleta del TMS9918 que usa openMSX; el 0 es transparente y se pinta negro
PAL = ["000000", "000000", "3EB849", "74D07D", "5955E0", "8076F1", "B95E51",
       "65DBEF", "DB6559", "FF897D", "CCC35E", "DED087", "3AA241", "B766B5",
       "CCCCCC", "FFFFFF"]
RGB = [tuple(int(h[i:i + 2], 16) for i in (0, 2, 4)) for h in PAL]


def png(ruta, w, h, pix):
    raw = b"".join(b"\x00" + bytes(pix[y * w * 3:(y + 1) * w * 3]) for y in range(h))
    def ch(t, d):
        return struct.pack(">I", len(d)) + t + d + struct.pack(">I", zlib.crc32(t + d))
    open(ruta, "wb").write(
        b"\x89PNG\r\n\x1a\n"
        + ch(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 2, 0, 0, 0))
        + ch(b"IDAT", zlib.compress(raw, 9)) + ch(b"IEND", b""))


def punto(pix, w, x, y, c, e=1):
    for dy in range(e):
        for dx in range(e):
            o = ((y * e + dy) * w + x * e + dx) * 3
            if 0 <= o < len(pix) - 2:
                pix[o], pix[o + 1], pix[o + 2] = c


def tile_en(pix, w, x0, y0, tile, e=1):
    """Un tile del VDP: 8 bytes de patron y 8 de color, dos colores por linea."""
    for f in range(8):
        pat, col = tile[0][f], tile[1][f]
        fg, bg = col >> 4, col & 15
        for b in range(8):
            punto(pix, w, x0 + b, y0 + f, RGB[fg if pat & (0x80 >> b) else bg], e)


def circuito(rom, ci, piezas_n, ruta, e=1):
    """Un trozo de circuito, como lo pinta p00 0x564C: la fila j de pantalla sale
    del metatile (col + j) & 7, y dentro del metatile la fila va invertida."""
    circuitos.ROM = E.ROM = rom
    carreras, tp, up, tm, um, _, _ = circuitos.lee_todo()
    c = carreras[ci]
    lista = E.palabra(4, E.TABLA_LISTAS_PISTA + 2 * ci)
    juego = E.juego_de_tiles(lista)
    pares = c["pares"][:piezas_n]
    W, H = 256, len(pares) * 96
    pix = bytearray(W * H * 3 * e * e)
    col = 0
    for k, (ip, flags) in enumerate(pares):
        if flags & 0x40:
            col = (col + (flags & 0x3F)) & 7
        ybase = (len(pares) - 1 - k) * 96          # la salida, abajo
        for fr in range(12):
            fm, dentro = 2 - (fr >> 2), fr & 3
            for j in range(8):
                im = circuitos.leer(10, c["piezas"] + 24 * ip + fm * 8 + ((col + j) & 7))
                for t in range(4):
                    it = circuitos.leer(10, c["meta"] + 16 * im + dentro * 4 + t)
                    y = ybase + fr * 8
                    ter = min(2, (y // 8) // 8 % 3)   # el banco que tocaria en pantalla
                    tl = juego[ter][it] or juego[2][it] or juego[0][it]
                    if tl:
                        tile_en(pix, W * e, (j * 4 + t) * 8, y, tl, e)
    png(ruta, W * e, H * e, pix)
    return W * e, H * e


def minimapas(rom, ruta, cols=7, e=2):
    """Los 21 trazados, integrando cada camino desde su posicion inicial."""
    circuitos.ROM = rom
    ms = circuitos.minimapas()
    cw, chh = 110, 60
    W, H = cols * cw, ((len(ms) + cols - 1) // cols) * chh
    pix = bytearray(W * H * 3 * e * e)
    for n, (i, pos, ini, fin, npasos, cierra) in enumerate(ms):
        ox, oy = (n % cols) * cw, (n // cols) * chh
        x, y = pos >> 8, pos & 0xFF
        pts = [(x, y)]
        for j in range(fin - ini):
            b = circuitos.leer(4, ini + j)
            x += circuitos.signo4(b >> 4)
            y += circuitos.signo4(b & 15)
            pts.append((x, y))
        mx, my = min(p[0] for p in pts), min(p[1] for p in pts)
        for k in range(len(pts)):
            x0, y0 = pts[k][0] - mx + ox + 4, pts[k][1] - my + oy + 6
            x1, y1 = pts[(k + 1) % len(pts)][0] - mx + ox + 4, pts[(k + 1) % len(pts)][1] - my + oy + 6
            pasos = max(abs(x1 - x0), abs(y1 - y0)) or 1
            for s in range(pasos + 1):          # segmento, punto a punto
                punto(pix, W * e, x0 + (x1 - x0) * s // pasos,
                      y0 + (y1 - y0) * s // pasos, RGB[7], e)
        punto(pix, W * e, pts[0][0] - mx + ox + 4, pts[0][1] - my + oy + 6, RGB[10], e)
    png(ruta, W * e, H * e, pix)
    return W * e, H * e


def main(argv):
    if len(argv) < 3:
        sys.exit(__doc__)
    rom = open(argv[1], "rb").read()
    d = argv[2]
    os.makedirs(d, exist_ok=True)
    hechas = []
    for ci, n, nombre in ((0, 3, "circuito_rally"), (9, 3, "circuito_f1")):
        w, h = circuito(rom, ci, n, os.path.join(d, nombre + ".png"))
        hechas.append((nombre, w, h))
    w, h = minimapas(rom, os.path.join(d, "minimapas.png"))
    hechas.append(("minimapas", w, h))
    for nombre, w, h in hechas:
        print("  %-16s %4d x %4d" % (nombre + ".png", w, h))
    print("%d imagenes en %s" % (len(hechas), d))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
