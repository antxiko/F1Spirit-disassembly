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
import graficos as G          # los lectores de paginas y de RLE  # noqa: E402

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


def pantalla_del_titulo(rom):
    """MONTA_PRESENTACION (p00 0x5CB5), paso por paso, sobre una VRAM de mentira.

    Es la pantalla que el juego enseña al arrancar, y de ella sale el rótulo.
    Los pasos son los suyos: los tiles 16 a 58 desde p15 0xB777, la lista de
    tiles de 0x6D34 -que mezcla registros de seis bytes y ordenes 0x17 que
    tiran de la tabla de 85 recursos-, los colores de los 256 tiles a cero, el
    dibujo descomprimido de p08 0x8280 con el RLE de buffer de p01 0x637A -el
    de las series crecientes y decrecientes- y, al final, los colores que deja
    el desvanecido de 0x5E4A cuando termina.
    """
    G.ROM = rom
    v = bytearray(0x4000)

    def rle_vram(grupo, addr, dest):
        """RLE_A_VRAM (p00 0x4862): 0x00 acaba y 0x80 sigue en otro origen."""
        a, wr = addr, dest & 0x3FFF
        while True:
            c = G.leer(grupo, a)
            a += 1
            if c == 0:
                return a
            if c == 0x80:
                a = G.palabra(grupo, a)
                continue
            if c & 0x80:
                k = c & 0x7F
                for i in range(k):
                    v[(wr + i) & 0x3FFF] = G.leer(grupo, a + i)
                a += k
                wr += k
            else:
                val = G.leer(grupo, a)
                a += 1
                for i in range(c):
                    v[(wr + i) & 0x3FFF] = val
                wr += c

    def llena3(dest, n, val):
        for t in range(3):
            for i in range(n):
                v[(dest + t * 0x800 + i) & 0x3FFF] = val

    def registro(flags, tile, ppat, pcol):
        grupo = 4 + 3 * ((flags >> 1) & 3)
        for t, bit in ((0, 7), (0x800, 6), (0x1000, 5)):
            if flags & (1 << bit):
                rle_vram(grupo, ppat, 0x2000 + t + tile * 8)
                if G.rle_tiles(grupo, pcol)[0]:
                    rle_vram(grupo, pcol, t + tile * 8)

    llena3(0x0080, 0x158, 0xF0)                   # 0x5CD8 TILES_16_58_F0
    for t in range(3):                            # sus patrones, en los tres
        rle_vram(13, 0xB777, 0x2080 + t * 0x800)  # tercios (MAPEA_D_E_F)
    a = 0x6D34                                    # 0x5CDB CARGA_LISTA_TILES
    while True:
        f = G.leer(4, a)
        if f == 0:
            break
        if (f & 0xF0) == 0x10:                    # una orden, no un registro
            if f & 4:                             # 0x17: recurso de la tabla 85
                idx, tile = G.leer(4, a + 1), G.leer(4, a + 2)
                e = G.TABLA85 + 5 * idx
                registro(G.leer(4, e), tile, G.palabra(4, e + 1),
                         G.palabra(4, e + 3))
            a += 3
            continue
        registro(f, G.leer(4, a + 1), G.palabra(4, a + 2), G.palabra(4, a + 4))
        a += 6
    llena3(0x0000, 0x800, 0x00)                   # 0x5CE1 y 0x5CEF
    llena3(0x20FF, 8, 0x00)

    # El buffer de nombres: 0xFF por fuera -el marco- y cero por dentro, y
    # encima el dibujo, que entra por 0xE4A0, o sea por la fila 5.
    buf = bytearray(b"\xff" * 0x2FF + b"\x00")
    for i in range(0x29F):
        buf[0x20 + i] = 0
    estado = {"col": 0, "wr": 0xA0}

    def paso():
        estado["wr"] += 1
        estado["col"] += 1
        if estado["col"] == 0x20:                 # el ancho que pasa el llamador
            estado["col"] = 0

    a = 0x8280                                    # p08, o sea grupo 7
    while True:
        c = G.leer(7, a)
        if c == 0:
            break
        a += 1
        n = c & 0x7F
        if n == c:                                # bit alto claro: copia o salto
            if n == 0:
                a = G.palabra(7, a)
                continue
            for _ in range(n):
                buf[estado["wr"]] = G.leer(7, a)
                a += 1
                paso()
        elif c < 0xE1:                            # 0x81..0xE0: repetir
            val = G.leer(7, a)
            a += 1
            for _ in range(n):
                buf[estado["wr"]] = val
                paso()
        else:                                     # 0xE1 arriba: series
            k = c - 0xE1
            t = G.leer(7, a)
            a += 1
            sube = k < 0x10
            for _ in range((k if sube else k - 0x10) + 1):
                buf[estado["wr"]] = t & 0xFF
                paso()
                t += 1 if sube else -1
    v[0x3800:0x3B00] = buf

    a = 0x5E4A                                    # los colores del desvanecido
    while True:
        fin, color, ini = (G.leer(1, a), G.leer(1, a + 1), G.leer(1, a + 2))
        if fin == 0:
            break
        for tile in range(ini, fin + 1):
            for t in range(3):
                for j in range(8):
                    v[(t * 0x800 + tile * 8 + j) & 0x3FFF] = color
        a += 3
    return v


def pinta_vram(v, f0, f1, c0, c1, e=2):
    """Las casillas [f0,f1]x[c0,c1] como las lee el VDP en SCREEN 2."""
    w, h = (c1 - c0 + 1) * 8 * e, (f1 - f0 + 1) * 8 * e
    pix = bytearray(w * h * 3)
    for f in range(f0, f1 + 1):
        ter = (f // 8) * 0x800
        for c in range(c0, c1 + 1):
            n = v[0x3800 + f * 32 + c]
            for y in range(8):
                pat, col = v[0x2000 + ter + n * 8 + y], v[ter + n * 8 + y]
                tinta, fondo = RGB[col >> 4], RGB[col & 15]
                for x in range(8):
                    cc = tinta if pat & (0x80 >> x) else fondo
                    for dy in range(e):
                        b = ((((f - f0) * 8 + y) * e + dy) * w
                             + ((c - c0) * 8 + x) * e) * 3
                        for dx in range(e):
                            pix[b + dx * 3:b + dx * 3 + 3] = bytes(cc)
    return w, h, pix


def marco_del_dibujo(v):
    """Las esquinas de lo que el dibujo escribe: el marco de 0xFF que rodea el
    buffer no cuenta, ni las casillas vacias. Sale el rotulo y nada mas."""
    o = [(f, c) for f in range(24) for c in range(32)
         if 0 < v[0x3800 + f * 32 + c] < 0xFF]
    return (min(f for f, _ in o), max(f for f, _ in o),
            min(c for _, c in o), max(c for _, c in o))


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
    v = pantalla_del_titulo(rom)
    png(os.path.join(d, "titulo.png"), *pinta_vram(v, 0, 23, 0, 31))
    hechas.append(("titulo", 512, 384))
    f0, f1, c0, c1 = marco_del_dibujo(v)
    w, h, pix = pinta_vram(v, f0, f1, c0, c1, e=3)
    png(os.path.join(d, "rotulo.png"), w, h, pix)
    hechas.append(("rotulo", w, h))
    for nombre, w, h in hechas:
        print("  %-16s %4d x %4d" % (nombre + ".png", w, h))
    print("%d imagenes en %s" % (len(hechas), d))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
