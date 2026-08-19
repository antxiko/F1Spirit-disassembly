#!/usr/bin/env python3
"""Lector de los TEXTOS y de las PANTALLAS COMPRIMIDAS de F-1 Spirit.

Dos formatos, los dos de la pagina 1:

  1. TEXTOS (p01 0x691B COPIA_TEXTO / 0x6929): bytes que se copian tal cual al
     buffer EC02 mientras sean < 0x60 (0x20-0x5E es ASCII: la fuente va en los
     tiles 0x20-0x5E; 0x00-0x1F son otros tiles y marcas de posicion), 0x5F =
     fin, y 0x60-0xFF = MACRO: se expande la entrada (byte - 0x60) de la TABLA
     DE 148 PUNTEROS de p09 0xA6DE (0x6943; anidable hasta 10 niveles). Es una
     compresion por diccionario: "VALVE", "TURBO", "CHARGER"... se escriben
     una vez. Los textos viven en la pagina 9 y se leen con la 9 en 0xA000
     (p01 0x62D4, p02 0x837B: `ld a,9 / call MAPEA_A_EN_A000`).

  2. PANTALLAS (p01 0x637A RLE_A_RAM / 0x637F): un flujo que se descomprime
     en un buffer de RAM de 32 bytes por fila con una anchura C' (A al entrar
     por 0x637A; por 0x637F el flujo empieza con la palabra del destino):
       00 fin; 01..7F copiar n bytes; 80..E0 repetir el byte siguiente n&0x7F
       veces (0x80 = 256); E1..F0 n-0xE0 bytes ASCENDENTES desde el siguiente;
       F1..FF n-0xF0 bytes DESCENDENTES desde el siguiente.
     Al completar C' columnas salta a la fila siguiente (HL += 32 - C').

Raices (de donde las lee el codigo, con que pagina mapeada):
  - tabla de textos p09 0xA6DE (148 palabras) y las cadenas que siguen
  - p09 0xAC0F (p01 0x62D9) y p09 0xAFCF (p02 0x8380): textos sueltos
  - pantallas: p08 0x8280 (p00 0x5CFF, 8/9, ancho 32), p06 0xA3B4 (p00 0x5F9B,
    5/6, forma 0x637F), tabla p06 0xBC6D de 21 punteros por (E25C) (p01 0x61B5
    y 0x75F3, 5/6, ancho 11), p15 0xB6FC y 0xB737 (tabla p01 0x68D9, E/F, ancho 8)

Uso: textos.py <rom> [--bloques | --notas | --textos]
"""
import sys
from collections import defaultdict

from paginas import org, TAM_PAGINA, N_PAGINAS

ROM = b""
AVISOS = []
TABLA_TEXTOS = 0xA6DE
TABLA_TEXTOS_N = 148
TEXTOS_SUELTOS = {0xAC0F: "p01 0x62D9", 0xAFCF: "p02 0x8380"}
PANTALLAS = [   # (grupo, direccion, ancho, quien, forma)
    (7, 0x8280, 32, "p00 0x5CFF (con 8/9): al buffer E4A0", "637A"),
    (4, 0xA3B4, 32, "p00 0x5F9B (con 5/6)", "637F"),
    # El panel de la carrera (el HUD), p01 0x75A4 con la pagina 9 en 0xA000
    # (0x7599: `ld a,9 / call 0x4457` ... `jp 0x43FE`): con dos jugadores dos
    # trozos de 16 columnas, con uno solo uno de 14.
    (7, 0xB9DE, 14, "p01 0x75D7 (con 9): el HUD de un jugador, en la columna 18 del buffer E400", "637A"),
    (7, 0xBAA5, 16, "p01 0x75B8 (con 9): el HUD de arriba con dos jugadores", "637A"),
    (7, 0xBAC0, 16, "p01 0x75C6 (con 9): el HUD de abajo con dos jugadores", "637A"),
]
TABLA_PANTALLAS = (4, 0xBC6D, 21, 11, "p01 0x61B5/0x75F3 (con 5/6), por (E25C): al buffer E423")
TABLA_68D9 = (13, 0x68D9, "p01 0x68AC (con E/F), por (E25E): pantallas de 8 de ancho")


def abs_(grupo, addr):
    if addr < 0x6000 or addr >= 0xC000:
        raise ValueError("direccion %#06x fuera de 0x6000-0xBFFF" % addr)
    p = grupo + (addr - 0x6000) // TAM_PAGINA
    if p >= N_PAGINAS:
        raise ValueError("pagina %d no existe" % p)
    return p * TAM_PAGINA + (addr - 0x6000) % TAM_PAGINA


def leer(grupo, addr):
    return ROM[abs_(grupo, addr)]


def palabra(grupo, addr):
    return leer(grupo, addr) | (leer(grupo, addr + 1) << 8)


def pagina_de(grupo, addr):
    return abs_(grupo, addr) // TAM_PAGINA


# ---------------------------------------------------------------- textos
tabla = []


def texto_crudo(addr):
    """Los bytes de un texto hasta el 0x5F (sin incluirlo) y la direccion siguiente."""
    s, a = bytearray(), addr
    while True:
        b = leer(7, a)
        a += 1
        if b == 0x5F:
            return bytes(s), a
        s.append(b)
        if len(s) > 200:
            raise ValueError("texto en %#06x sin fin" % addr)


def expande(s, nivel=0):
    out = ""
    for b in s:
        if 0x20 <= b < 0x5F:
            out += chr(b)
        elif b >= 0x60:
            k = b - 0x60
            if k >= len(tabla) or nivel > 10:
                out += "{%02X}" % b
            else:
                sub, _ = texto_crudo(tabla[k])
                out += expande(sub, nivel + 1)
        elif b == 0x01:
            out += " "
        else:
            out += "{%02X}" % b
    return out


def legible(s):
    t = expande(s)
    if not t:
        return 0.0
    return sum(1 for c in t if c.isalnum() or c in " .:-/@") / len(t)


def lee_textos():
    global tabla
    tabla = [palabra(7, TABLA_TEXTOS + 2 * i) for i in range(TABLA_TEXTOS_N)]
    ini_cadenas = min(tabla)
    if ini_cadenas != TABLA_TEXTOS + 2 * TABLA_TEXTOS_N:
        AVISOS.append("la tabla de textos acaba en %#06x y la primera cadena esta en %#06x" % (TABLA_TEXTOS + 2 * TABLA_TEXTOS_N, ini_cadenas))
    # las cadenas van seguidas desde la primera; se leen mientras sean legibles
    cadenas, a = [], ini_cadenas
    while True:
        try:
            s, fin = texto_crudo(a)
        except ValueError:
            break
        if len(s) > 120 or (len(s) > 3 and legible(s) < 0.5):
            break
        cadenas.append((a, fin, s))
        a = fin
    fin_cadenas = a
    for i, t in enumerate(tabla):
        if not (ini_cadenas <= t < fin_cadenas):
            AVISOS.append("la entrada %d de la tabla de textos apunta a %#06x, fuera de las cadenas" % (i, t))
    sueltos = []
    for t, quien in TEXTOS_SUELTOS.items():
        if not (ini_cadenas <= t < fin_cadenas):
            AVISOS.append("el texto suelto %#06x (%s) no esta en la zona de cadenas %#06x-%#06x" % (t, quien, ini_cadenas, fin_cadenas))
        sueltos.append(t)
    return cadenas, ini_cadenas, fin_cadenas


# ---------------------------------------------------------------- pantallas
def rle_ram(grupo, addr, ancho):
    """Descomprime el flujo de 0x637A. Devuelve (filas de bytes, direccion siguiente, bytes producidos)."""
    a, n, col, filas, fila = addr, 0, 0, [], []

    def mete(b):
        nonlocal col, fila
        fila.append(b)
        col += 1
        if col == ancho:
            filas.append(fila)
            fila, col = [], 0

    while True:
        c = leer(grupo, a)
        a += 1
        if c == 0:
            if fila:
                filas.append(fila)
            return filas, a, n
        if c < 0x80:
            for _ in range(c):
                mete(leer(grupo, a))
                a += 1
            n += c
        elif c <= 0xE0:
            k = c & 0x7F or 256
            b = leer(grupo, a)
            a += 1
            for _ in range(k):
                mete(b)
            n += k
        elif c <= 0xF0:
            k = c - 0xE0
            b = leer(grupo, a)
            a += 1
            for i in range(k):
                mete((b + i) & 0xFF)
            n += k
        else:
            k = c - 0xF0
            b = leer(grupo, a)
            a += 1
            for i in range(k):
                mete((b - i) & 0xFF)
            n += k
        if n > 0x1000:
            raise ValueError("flujo en %#06x no termina" % addr)


def lee_pantallas():
    out = []   # (grupo, ini, fin, ancho, destino, quien, filas)
    for grupo, addr, ancho, quien, forma in PANTALLAS:
        if forma == "637F":
            dest = palabra(grupo, addr)
            filas, fin, n = rle_ram(grupo, addr + 2, ancho)
        else:
            dest = None
            filas, fin, n = rle_ram(grupo, addr, ancho)
        out.append((grupo, addr, fin, ancho, dest, quien, filas))
    g, t, nt, ancho, quien = TABLA_PANTALLAS
    ptrs = [palabra(g, t + 2 * i) for i in range(nt)]
    for i, p in enumerate(sorted(set(ptrs))):
        filas, fin, n = rle_ram(g, p, ancho)
        out.append((g, p, fin, ancho, None, "tabla 0xBC6D[%s]" % ",".join(str(k) for k, q in enumerate(ptrs) if q == p), filas))
    g, t, quien = TABLA_68D9
    entradas, a = [], t
    while leer(1, a) != 0xFF:
        dest = palabra(1, a)
        src = palabra(1, a + 2)
        entradas.append((dest, src))
        a += 4
    for src in sorted(set(s for d, s in entradas)):
        filas, fin, n = rle_ram(g, src, 8)
        out.append((g, src, fin, 8, None, "tabla p01 0x68D9 (entradas %s)" % ",".join(str(k) for k, (d, s) in enumerate(entradas) if s == src), filas))
    return out, ptrs, entradas


def bloques(cadenas, ini_c, fin_c, pantallas, ptrs, entradas):
    bl = []
    bl.append((9, TABLA_TEXTOS, TABLA_TEXTOS + 2 * TABLA_TEXTOS_N, "tabla_textos", "w1",
               "148 punteros a los textos de abajo: la entrada n es la MACRO 0x60+n que COPIA_TEXTO (p01 0x6943) expande dentro de otros textos; p01 0x6950"))
    bl.append((9, ini_c, fin_c, "textos", 16,
               "%d textos terminados en 0x5F (ASCII en 0x20-0x5E, macros 0x60-0xFF de la tabla 0xA6DE, tiles y posiciones por debajo de 0x20): fichas de los coches, menus, RESULT, THE MEMORIAL OF FORMULA-1..." % len(cadenas)))
    for grupo, ini, fin, ancho, dest, quien, filas in pantallas:
        p = pagina_de(grupo, ini)
        texto = "pantalla comprimida para RLE_A_RAM (p01 0x637A): %d filas de %d tiles%s; %s" % (
            len(filas), ancho, (", destino %#06x en la cabecera" % dest) if dest else "", quien)
        bl.append((p, ini, fin, "pantalla_%04X" % ini, 16, texto))
    g, t, nt, ancho, quien = TABLA_PANTALLAS
    bl.append((pagina_de(g, t), t, t + 2 * nt, "tabla_pantallas_BC6D", "w1", "21 punteros a pantallas comprimidas de 11 de ancho; %s" % quien))
    bl.append((1, 0x68D9, 0x68D9 + 4 * len(entradas) + 1, "tabla_68D9", "w2", "%d parejas (destino en el buffer, flujo en p15) y 0xFF: las pantallas de 8 de ancho que pinta 0x68AC por (E25E)" % len(entradas)))
    # partir por paginas
    res = []
    for p, ini, fin, nombre, anch, texto in bl:
        a = ini
        while a < fin:
            corte = min(fin, org(p) + TAM_PAGINA)
            res.append((p, a, corte, nombre, anch, texto + (" (sigue en la pagina siguiente)" if corte < fin else "")))
            a = corte
            p += 1
    return sorted(res)


def main(argv):
    global ROM
    if len(argv) < 2:
        sys.exit(__doc__)
    ROM = open(argv[1], "rb").read()
    modo = argv[2] if len(argv) > 2 else ""
    try:
        cadenas, ini_c, fin_c = lee_textos()
        pantallas, ptrs, entradas = lee_pantallas()
        bl = bloques(cadenas, ini_c, fin_c, pantallas, ptrs, entradas)
    except ValueError as e:
        print("ERROR:", e)
        return 1
    if modo == "--bloques":
        for p, ini, fin, nombre, _, _ in bl:
            print("p%02d %#06x %#06x %s" % (p, ini, fin, nombre))
    elif modo == "--notas":
        pag = None
        for p, ini, fin, nombre, anch, texto in bl:
            if p != pag:
                print("# --- p%02d ---" % p)
                pag = p
            print("D %#06x %#06x %s %s" % (ini, fin, nombre, texto))
            print("F %#06x %s" % (ini, anch))
    elif modo == "--textos":
        for i, t in enumerate(tabla):
            s, _ = texto_crudo(t)
            print("macro %02X (%3d) %#06x: %s" % (0x60 + i, i, t, expande(s)))
        print()
        for a, fin, s in cadenas:
            print("%#06x: %s" % (a, expande(s)))
        for grupo, ini, fin, ancho, dest, quien, filas in pantallas:
            print("pantalla %#06x (grupo %d, %d filas x %d) %s" % (ini, grupo, len(filas), ancho, quien))
            for f in filas:
                print("   " + " ".join("%02X" % b for b in f))
    else:
        print("TEXTOS: tabla de %d punteros en %#06x; %d cadenas en %#06x-%#06x (%d bytes)" % (
            TABLA_TEXTOS_N, TABLA_TEXTOS, len(cadenas), ini_c, fin_c, fin_c - ini_c))
        for grupo, ini, fin, ancho, dest, quien, filas in pantallas:
            print("PANTALLA %#06x-%#06x (p%02d): %d filas x %d%s; %s" % (
                ini, fin, pagina_de(grupo, ini), len(filas), ancho, (" dest %#06x" % dest) if dest else "", quien))
        print("tabla 0xBC6D:", " ".join("%#06x" % p for p in ptrs))
        print("tabla 0x68D9:", " ".join("%#06x<-%#06x" % (d, s) for d, s in entradas))
        tot = defaultdict(int)
        for p, ini, fin, _, _, _ in bl:
            tot[p] += fin - ini
        for p in sorted(tot):
            print("p%02d: %d bytes identificados" % (p, tot[p]))
    for av in AVISOS:
        print("AVISO:", av)
    return 1 if AVISOS else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
