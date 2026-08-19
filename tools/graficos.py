#!/usr/bin/env python3
"""Lector de los DATOS GRAFICOS de F-1 Spirit: los recorre desde la ROM igual
que lo hace el codigo de la pagina 0, comprueba que cuadran y dice que bytes
de que pagina ocupa cada cosa. Es la herramienta que respalda las directivas
D de las paginas de datos: nada se declara en los .notes que este programa
no haya parseado y verificado.

Lo que lee (las rutinas estan en src/p00.notes con estos nombres):

  1. El CARGADOR DE TILES (0x4CCD, CARGA_LISTA_TILES). HL apunta a una lista de
     registros de 6 bytes en la pagina 4 (el cargador mapea 4/5/6):
       [0] flags: bit7/6/5 = el RLE va al tercio 0x0000/0x0800/0x1000 de la
           pantalla (se repite en cada tercio marcado); bits 2..1 = grupo de
           paginas que mapea para leer los bytes (00 -> 4/5/6, 01 -> 7/8/9,
           10 -> A/B/C, 11 -> D/E/F); bit4 = espejo horizontal de los
           patrones; bit3 = volteo vertical (patrones y colores).
       [1] tile inicial; [2..3] patrones comprimidos; [4..5] colores comprimidos.
     Si (flags & 0xF0) == 0x10 no es un registro sino una ORDEN (despachador
     0x4E34 por flags & 3): 0x10 = copia 16 bytes a E263 (17 B); 0x11/15/19/1D
     = palabra a E276+0/2/4/6 (3 B); 0x13 = sublista (puntero, 3 B); 0x17 =
     recurso N de la TABLA DE 85 RECURSOS de p04 0x6000 (5 bytes: flags,
     patrones, colores; el tile lo da la orden) cargado por 0x4E9F (3 B).
     Fin de lista: 0x00.
     El RLE (0x4D64, RLE_TILES): 00 fin; 01..7F repetir el byte siguiente N
     veces; 80 nada; 81..FF copiar N&0x7F bytes. Se acumula de 8 en 8 (un tile)
     y por eso cada bloque descomprime a un multiplo de 8, y patrones y
     colores del mismo registro descomprimen al MISMO numero de bytes.

  2. El CARGADOR DE SPRITES (0x4F1A, CARGA_LISTA_SPRITES). HL apunta a pares
     (recurso, patron) terminados en 0xFF; el recurso es un registro de 6
     bytes de la TABLA DE 34 RECURSOS DE SPRITES de p04 0x7505: [0] clase
     (indice en EB40 donde se apunta el patron asignado), [1] tipo: 0 = RLE
     (el de 0x4862, RLE_A_VRAM: 0x80 = seguir en el puntero que viene) a
     0x1800+patron*8, 1/FF = nada, 2 = copia [4..5] bytes tal cual (LDIRVM),
     [2..3] origen.

  3. Los FOTOGRAMAS DE LOS COCHES (0x46A8): 64 bytes cada uno (2 sprites de
     16x16), en juegos consecutivos desde p04 0x7731; las tablas de p04 0x7431
     (21 palabras) y 0x745B (19 palabras) dan el juego de cada tipo de coche
     (ix+0x18), y 0x8A71/0x8BF1 de p05 son los fotogramas con el bit 7 del
     numero (segun E25B < 3 o no). 0x75D1: 6 parejas de tiles (16 bytes)
     para 0x2670/0x2680.

  4. Las tablas de listas: p04 0x61A9 (42 punteros por (E25C), dos de 21),
     p00 0x4C37 (6 por (E25B)), p02 0x927E (6 por (E25B)), p03 0xBD03 (6 por
     (E251); la entrada 0 es otra tabla de 6 por (E25B) en p03 0xBD0F y la 2
     otra en p04 0x6F95), p04 0x7481 (18 palabras = 6 x 3 por (E25B)).

Uso:
    graficos.py <rom>                informe: que se ha leido y que cuadra
    graficos.py <rom> --bloques      una linea por bloque: pNN ini fin nombre
    graficos.py <rom> --notas        las directivas D/F sugeridas, por pagina
    graficos.py <rom> --huecos       lo que queda sin explicar en p04-p12,p14,p15
Sale con 1 si algo no cuadra (un RLE que no termina, longitudes distintas...).
"""
import sys
from collections import defaultdict

from paginas import org, TAM_PAGINA, N_PAGINAS

ROM = b""
AVISOS = []      # lo que no cuadra: el programa sale con 1
NOTAS = []       # rarezas del propio juego que no son errores de lectura
SIN_COLORES = []


def leer(grupo, addr):
    """Byte en la direccion Z80 `addr` con el grupo `grupo` (pagina en 0x6000)."""
    return ROM[abs_(grupo, addr)]


def abs_(grupo, addr):
    if addr < 0x4000 or addr >= 0xC000:
        raise ValueError("direccion %#06x fuera del cartucho" % addr)
    if addr < 0x6000:
        return addr - 0x4000
    p = grupo + (addr - 0x6000) // TAM_PAGINA
    if p >= N_PAGINAS:
        raise ValueError("pagina %d no existe (grupo %d, %#06x)" % (p, grupo, addr))
    return p * TAM_PAGINA + (addr - 0x6000) % TAM_PAGINA


def pagina_de(grupo, addr):
    return abs_(grupo, addr) // TAM_PAGINA


def palabra(grupo, addr):
    return leer(grupo, addr) | (leer(grupo, addr + 1) << 8)


def rle_tiles(grupo, addr, tope=0x10000):
    """El RLE de 0x4D64. Devuelve (bytes que produce, direccion siguiente)."""
    a, n = addr, 0
    while True:
        c = leer(grupo, a)
        a += 1
        if c == 0:
            return n, a
        if c & 0x80:
            k = c & 0x7F
            a += k
            n += k
        else:
            a += 1
            n += c
        if n > tope or a - addr > tope:
            raise ValueError("RLE en %#06x (grupo %d) no termina" % (addr, grupo))


def rle_vram(grupo, addr, tope=0x10000):
    """El RLE de 0x4862 (RLE_A_VRAM): como el otro pero 0x80 = seguir en el
    puntero que viene. Devuelve (bytes, [(ini, fin), ...] de los trozos)."""
    a, n, trozos, ini = addr, 0, [], addr
    while True:
        c = leer(grupo, a)
        a += 1
        if c == 0:
            trozos.append((ini, a))
            return n, trozos
        if c == 0x80:
            nuevo = palabra(grupo, a)
            trozos.append((ini, a + 2))
            a = ini = nuevo
            continue
        if c & 0x80:
            k = c & 0x7F
            a += k
            n += k
        else:
            a += 1
            n += c
        if n > tope:
            raise ValueError("RLE (vram) en %#06x no termina" % addr)


class Bloques:
    """Los rangos identificados, por pagina, con su nombre y anchura."""

    def __init__(self):
        self.b = defaultdict(dict)   # pagina -> ini -> (fin, nombre, anchura, texto)
        self.refs = defaultdict(set)

    def anade(self, grupo, ini, fin, nombre, anchura, texto="", ref=None):
        if fin <= ini:
            return
        p = pagina_de(grupo, ini)
        pf = pagina_de(grupo, fin - 1)
        o = org(p)
        if pf != p:
            # parte en dos: lo que cae en esta pagina y lo que sigue en la otra
            corte = o + TAM_PAGINA
            self.anade(grupo, ini, corte, nombre, anchura, texto, ref)
            self.anade(grupo, corte, fin, nombre, anchura, texto, ref)
            return
        prev = self.b[p].get(ini)
        if prev and (prev[0] != fin or prev[1] != nombre):
            if prev[0] < fin:
                self.b[p][ini] = (fin, nombre, anchura, texto)
        else:
            self.b[p][ini] = (fin, nombre, anchura, texto)
        if ref:
            self.refs[(p, ini)].add(ref)

    def ordenados(self, p):
        return sorted(self.b[p].items())

    def solapes(self):
        out = []
        for p in sorted(self.b):
            max_fin, quien = None, None
            for ini, (fin, nombre, _, _) in self.ordenados(p):
                if max_fin is not None and ini < max_fin:
                    out.append((p, quien, "%#06x-%#06x %s" % (ini, fin, nombre)))
                if max_fin is None or fin > max_fin:
                    max_fin, quien = fin, "%#06x-%#06x %s" % (ini, fin, nombre)
        return out

    def normaliza(self):
        """Dos listas que comparten la cola (una entra por la mitad de la otra
        y las dos acaban en el mismo sitio) se parten en tramos disjuntos."""
        for p in sorted(self.b):
            items = self.ordenados(p)
            for k in range(len(items) - 1):
                ini, (fin, nombre, anch, texto) = items[k]
                ini2, (fin2, nombre2, _, _) = items[k + 1]
                if ini2 < fin and fin2 == fin and nombre.startswith("lista_") and nombre2.startswith("lista_"):
                    self.b[p][ini] = (ini2, nombre, anch, texto + "; sigue en la lista de %#06x" % ini2)
                    items = self.ordenados(p)

    def cubierto(self, p):
        cub = bytearray(TAM_PAGINA)
        o = org(p)
        for ini, (fin, _, _, _) in self.ordenados(p):
            for i in range(ini - o, fin - o):
                cub[i] = 1
        return cub


B = Bloques()
TABLA85 = 0x6000
TABLA85_N = 85
TABLA_LISTAS = 0x61A9
TABLA_LISTAS_N = 42
TABLA_SPRITES = 0x7505
TABLA_SPRITES_N = 34
FOTOGRAMAS = 0x7731       # donde empiezan los juegos de fotogramas de coche
FIN_FOTOGRAMAS = 0x8D71   # donde empiezan los 8 sprites sueltos (recursos 18..25);
                          # se comprueba en cierra_fotogramas()
COPIAS_FOTOGRAMAS = []    # recursos de sprites (tipo 2) que copian fotogramas

# listas del cargador de tiles alcanzadas directamente desde el codigo, con
# quien las llama (por que son raices)
RAICES_TILES = {
    0x61FD: "p00 0x4BCE/0x4BE3",
    0x620A: "p00 0x59D3, p01 0x634E",
    0x6BBD: "p00 0x4C19/0x4C5E",
    0x6C7C: "p00 0x4C1F/0x4C67, p01 0x6348",
    0x6C36: "p00 0x4C31/0x4C84",
    0x6D34: "p00 0x5CDB",
    0x6D6B: "p01 0x6342",
    0x6E0D: "p01 0x6781",
    0x6CD1: "p01 0x6815",
    0x6E06: "p01 0x6D25",
    0x6DEA: "p01 0x7CDC",
    0x6DB5: "p02 0x823B/0x8367",
    0x6DBC: "p02 0x8241",
    0x6DAE: "p02 0x8264",
    0x6D00: "p02 0x9272",
    0x6DC3: "p02 0x82CF (por 0x8390 -> 0x4C93)",
    0x6DD6: "p02 0x829E (por 0x8390 -> 0x4C93)",
    0x6DE3: "p02 0x82E9 (por 0x8390 -> 0x4C93)",
}
# listas del cargador de sprites alcanzadas directamente desde el codigo
RAICES_SPRITES = {
    0x74A5: "p00 0x4ECA",
    0x74EC: "p00 0x4F8B",
    0x74F2: "p00 0x5961",
    0x74EF: "p01 0x6354",
    0x7502: "p02 0x8247",
    0x74F5: "ningun llamador en el codigo trazado (es la unica lista que pide los recursos 27-32, los fotogramas sueltos)",
}

listas_tiles = {}       # addr -> registros
recursos_tiles = {}     # (grupo, pat, col) -> (tiles, bytes)
usados85 = defaultdict(set)
listas_sprites = {}
usados_sprites = defaultdict(set)


def carga_registro(flags, tile, ppat, pcol, donde, via):
    """Un registro del cargador de tiles: comprueba y apunta sus dos RLE."""
    grupo = 4 + 3 * ((flags >> 1) & 3)
    tercios = [t for t, bit in ((0x0000, 7), (0x0800, 6), (0x1000, 5)) if flags & (1 << bit)]
    n_pat, fin_pat = rle_tiles(grupo, ppat)
    n_col, fin_col = rle_tiles(grupo, pcol)
    if n_col == 0:
        SIN_COLORES.append(donde)      # un RLE vacio (p08 0x827F): solo patrones
    elif n_pat != n_col:
        NOTAS.append("registro en %s: patrones %d bytes y colores %d (%#06x/%#06x grupo %d)"
                     % (donde, n_pat, n_col, ppat, pcol, grupo))
    if n_pat % 8 or n_col % 8:
        AVISOS.append("registro en %s: %d/%d bytes no es multiplo de 8" % (donde, n_pat, n_col))
    if not tercios:
        AVISOS.append("registro en %s: sin tercio (flags %#04x): no carga nada" % (donde, flags))
    recursos_tiles[(grupo, ppat, pcol)] = (n_pat // 8, n_pat, tile, flags)
    quien = via if via.startswith("tabla85") else via.replace("lista ", "lista ")
    if tile < 0:
        desc_t = "(recurso de la tabla de 85 que ninguna lista pide)"
    else:
        desc_t = "%d tiles desde el %d" % (n_pat // 8, tile)
    B.anade(grupo, ppat, fin_pat, "rle_pat_%04X" % ppat, 16,
            "patrones RLE: %s (%s)" % (desc_t, quien), via)
    B.anade(grupo, pcol, fin_col, "rle_col_%04X" % pcol, 16,
            "colores RLE: %s (%s)" % (("vacio: solo patrones" if n_col == 0 else "%d tiles desde el %d" % (n_col // 8, tile)) if tile >= 0 else desc_t, quien), via)
    return grupo, n_pat


def lista_tiles(addr, via, grupo=4, profundidad=0):
    if addr in listas_tiles:
        B.refs[(pagina_de(grupo, addr), addr)].add(via)
        return
    if profundidad > 8:
        raise ValueError("sublistas demasiado anidadas en %#06x" % addr)
    regs = []
    a = addr
    while True:
        f = leer(grupo, a)
        if f == 0:
            regs.append(("fin", a))
            a += 1
            break
        if (f & 0xF0) == 0x10:
            k = f & 3
            if k == 0:
                regs.append(("orden_E263", a))
                a += 17
            elif k == 1:
                regs.append(("orden_E276+%d" % ((f >> 1) & 6), a, palabra(grupo, a + 1)))
                a += 3
            elif k == 2:
                raise ValueError("orden 0x12 en %#06x: el codigo no avanza (bucle infinito)" % a)
            else:
                if f & 4:
                    idx, tile = leer(grupo, a + 1), leer(grupo, a + 2)
                    if idx >= TABLA85_N:
                        raise ValueError("recurso %d fuera de la tabla de 85 en %#06x" % (idx, a))
                    regs.append(("recurso85", a, idx, tile))
                    usados85[idx].add(addr)
                    e = TABLA85 + 5 * idx
                    carga_registro(leer(4, e), tile, palabra(4, e + 1), palabra(4, e + 3),
                                   "tabla85[%d] (tile %d desde %#06x)" % (idx, tile, a),
                                   "tabla85[%d]" % idx)
                else:
                    sub = palabra(grupo, a + 1)
                    regs.append(("sublista", a, sub))
                    lista_tiles(sub, "sublista de %#06x" % addr, grupo, profundidad + 1)
                a += 3
            continue
        tile, ppat, pcol = leer(grupo, a + 1), palabra(grupo, a + 2), palabra(grupo, a + 4)
        g, n = carga_registro(f, tile, ppat, pcol, "lista %#06x+%d" % (addr, a - addr), "lista %#06x" % addr)
        regs.append(("registro", a, f, tile, ppat, pcol, g, n))
        a += 6
        if a - addr > 0x1000:
            raise ValueError("lista %#06x sin fin" % addr)
    listas_tiles[addr] = regs
    n_regs = sum(1 for r in regs if r[0] == "registro")
    anchos = []
    for r in regs:
        anchos.append({"registro": 6, "fin": 1, "orden_E263": 17, "sublista": 3, "recurso85": 3}.get(r[0], 3))
    tiles = [(r[3], r[3] + r[7] // 8 - 1) for r in regs if r[0] == "registro"]
    resumen = ("tiles %d-%d" % (min(t[0] for t in tiles), max(t[1] for t in tiles))) if tiles else "sin registros propios"
    B.anade(grupo, addr, a, "lista_%04X" % addr, ",".join(str(x) for x in anchos),
            "lista del cargador de tiles (0x4CCD): %d registros de 6 B%s, %s; la usa %s"
            % (n_regs, (" y %d ordenes" % (len(regs) - 1 - n_regs)) if len(regs) - 1 - n_regs else "", resumen, via), via)


def lista_sprites(addr, via, grupo=4):
    if addr in listas_sprites:
        B.refs[(pagina_de(grupo, addr), addr)].add(via)
        return
    pares = []
    a = addr
    while True:
        idx = leer(grupo, a)
        if idx == 0xFF:
            a += 1
            break
        patron = leer(grupo, a + 1)
        if idx >= TABLA_SPRITES_N:
            raise ValueError("recurso de sprite %d fuera de la tabla de 34 (%#06x)" % (idx, a))
        pares.append((idx, patron))
        usados_sprites[idx].add(addr)
        recurso_sprite(idx, patron, "lista %#06x" % addr)
        a += 2
    listas_sprites[addr] = pares
    B.anade(grupo, addr, a, "sprites_%04X" % addr, 2,
            "lista del cargador de sprites (0x4F1A): %d pares (recurso, patron) y 0xFF; la usa %s" % (len(pares), via), via)


recursos_sprites = {}


def recurso_sprite(idx, patron, via):
    e = TABLA_SPRITES + 6 * idx
    clase, tipo, ptr, n = leer(4, e), leer(4, e + 1), palabra(4, e + 2), palabra(4, e + 4)
    if tipo == 0:
        nb, trozos = rle_vram(4, ptr)
        if nb % 32:
            AVISOS.append("recurso de sprite %d: el RLE de %#06x da %d bytes (no son sprites enteros)" % (idx, ptr, nb))
        for ini, fin in trozos:
            B.anade(4, ini, fin, "rle_sprites_%04X" % ini, 16,
                    "patrones de sprites RLE (0x4862): %d sprites de 16x16; recurso %d de la tabla 0x7505" % (nb // 32, idx), via)
        recursos_sprites[idx] = (clase, tipo, ptr, nb)
    elif tipo >= 2 and tipo != 0xFF:
        if n % 32:
            AVISOS.append("recurso de sprite %d: copia de %d bytes (no son sprites enteros)" % (idx, n))
        # las copias tal cual que caen en la zona de fotogramas SON fotogramas
        # (juegos enteros, o un fotograma suelto): se declaran con los juegos
        if FOTOGRAMAS <= ptr < FIN_FOTOGRAMAS:
            if (ptr - FOTOGRAMAS) % 64 or n % 64:
                AVISOS.append("recurso de sprite %d: %#06x/%d bytes no son fotogramas enteros" % (idx, ptr, n))
            COPIAS_FOTOGRAMAS.append((idx, ptr, n))
        else:
            B.anade(4, ptr, ptr + n, "sprite_%04X" % ptr, 16,
                    "patrones de sprites tal cual: %d de 16x16 (32 B); recurso %d de la tabla 0x7505" % (n // 32, idx), via)
        recursos_sprites[idx] = (clase, tipo, ptr, n)
    else:
        recursos_sprites[idx] = (clase, tipo, ptr, 0)


def tabla_de_listas(grupo, addr, n, via, que):
    """n palabras en (grupo, addr), cada una una lista de tiles."""
    for i in range(n):
        w = palabra(grupo, addr + 2 * i)
        lista_tiles(w, "%s[%d]" % (que, i))
    B.anade(grupo, addr, addr + 2 * n, que, "w1", "%d punteros a listas del cargador de tiles; %s" % (n, via), via)


def recorre():
    # 1. listas de tiles: raices directas y tablas
    for a, via in sorted(RAICES_TILES.items()):
        lista_tiles(a, via)
    tabla_de_listas(4, TABLA_LISTAS, TABLA_LISTAS_N, "indexada por la carrera (E25C) desde CARGA_TILES_CIRCUITO (p00 0x4BDA/0x4BF8); dos juegos de 21: las entradas 21-41 entran por la mitad de las listas de las 0-20", "tabla_61A9")
    tabla_de_listas(1, 0x4C37, 6, "por (E25B) desde CARGA_TILES_PANEL (p00 0x4C25/0x4C70)", "tabla_4C37")
    tabla_de_listas(1, 0x927E, 6, "por (E25B) desde p02 0x9266", "tabla_927E")
    # p03 0xBD03 por (E251): con E251 = 0 o 2 el codigo (p01 0x6793/0x6797)
    # indexa OTRA VEZ por (E25B): esas dos entradas son la misma tabla 0xBD0F
    subtablas = set()
    for i in range(6):
        w = palabra(1, 0xBD03 + 2 * i)
        if i in (0, 2):
            if w not in subtablas:
                tabla_de_listas(1, w, 6, "por (E25B) desde las entradas 0 y 2 de la tabla 0xBD03 (p01 0x6799)", "tabla_%04X" % w)
                subtablas.add(w)
        else:
            lista_tiles(w, "tabla_BD03[%d]" % i)
    B.anade(1, 0xBD03, 0xBD0F, "tabla_BD03", "w1", "6 punteros por (E251) a listas del cargador de tiles (las entradas 0 y 2 apuntan a la tabla 0xBD0F, que se indexa otra vez por (E25B)); p01 0x6787", "p01 0x6787")
    # la tabla de 85 recursos entera (los no alcanzados se apuntan)
    for idx in range(TABLA85_N):
        if idx not in usados85:
            e = TABLA85 + 5 * idx
            carga_registro(leer(4, e), -1, palabra(4, e + 1), palabra(4, e + 3),
                           "tabla85[%d] (sin lista que lo pida)" % idx, "tabla85[%d]" % idx)
    B.anade(4, TABLA85, TABLA85 + 5 * TABLA85_N, "tabla_recursos_tiles", 5,
            "85 recursos de tiles de 5 B (flags, patrones, colores) que las listas piden con la orden 0x17 (CARGA_RECURSO_85, 0x4E9F), y el tile lo dice la orden", "0x4E9F")
    # 2. sprites
    for a, via in sorted(RAICES_SPRITES.items()):
        lista_sprites(a, via)
    for i in range(18):
        lista_sprites(palabra(4, 0x7481 + 2 * i), "tabla_7481[%d]" % i)
    B.anade(4, 0x7481, 0x7481 + 36, "tabla_listas_sprites", "w3", "18 punteros a listas del cargador de sprites, 3 por categoria (E25B); CARGA_SPRITES_CARRERA (0x4EDC) lee el primero de cada tres", "p00 0x4EDC")
    for idx in range(TABLA_SPRITES_N):
        if idx not in usados_sprites:
            recurso_sprite(idx, 0, "tabla_sprites[%d] (sin lista)" % idx)
    B.anade(4, TABLA_SPRITES, TABLA_SPRITES + 6 * TABLA_SPRITES_N, "tabla_recursos_sprites", 6,
            "34 recursos de sprites de 6 B (clase en EB40, tipo 0 = RLE / 2 = copia / 1 y FF = nada, origen, longitud) para CARGA_RECURSO_SPRITE (0x4F28)", "0x4F28")
    # 3. fotogramas de los coches: los juegos empiezan donde apuntan las
    # tablas (y los recursos de sprites que los copian enteros); cada juego
    # llega hasta el siguiente
    juegos = {}
    for base, n, que in ((0x7431, 21, "tabla_7431"), (0x745B, 19, "tabla_745B")):
        for i in range(n):
            w = palabra(4, base + 2 * i)
            if w:
                juegos.setdefault(w, set()).add("%s[%d]" % (que, i))
        B.anade(4, base, base + 2 * n, que, "w1", "%d punteros al juego de fotogramas de cada tipo de coche (ix+0x18), para %s" % (n, "FOTOGRAMA_COCHE (0x46C5)" if base == 0x7431 else "FOTOGRAMA_COCHE_40 (0x4744)"), "p00 0x46C5/0x4744")
    juegos.setdefault(0x8A71, set()).add("0x46F5 (E25B<3)")
    juegos.setdefault(0x8BF1, set()).add("0x46EE (E25B>=3)")
    for idx, ptr, n in COPIAS_FOTOGRAMAS:
        if n > 64:
            juegos.setdefault(ptr, set()).add("recurso_sprite[%d]" % idx)
    B.anade(4, 0x75D1, 0x7631, "tiles_coche", 16, "6 parejas de tiles (16 B) que TILES_COCHE (0x4701) copia a los patrones 0x2670/0x2680 segun (ix-3) = 1..6", "p00 0x470D")
    return juegos


def cierra_fotogramas(juegos):
    """Declara cada juego de fotogramas de 0x7731 a 0x8D71 y comprueba que los
    limites cuadran con las copias de los recursos de sprites."""
    inicios = sorted(juegos)
    for j in inicios:
        if (j - FOTOGRAMAS) % 64:
            AVISOS.append("juego de fotogramas %#06x no alineado a 64 bytes desde %#06x" % (j, FOTOGRAMAS))
        if not (FOTOGRAMAS <= j < FIN_FOTOGRAMAS):
            AVISOS.append("juego de fotogramas %#06x fuera de %#06x-%#06x" % (j, FOTOGRAMAS, FIN_FOTOGRAMAS))
    if inicios[0] != FOTOGRAMAS:
        AVISOS.append("el primer juego no empieza en %#06x sino en %#06x" % (FOTOGRAMAS, inicios[0]))
    # el primer bloque identificado detras de la zona tiene que ser justo 0x8D71
    detras = [ini for ini in B.b[5] if ini >= FOTOGRAMAS]
    if not detras or min(detras) != FIN_FOTOGRAMAS:
        AVISOS.append("detras de los fotogramas lo primero identificado esta en %s, no en %#06x"
                      % (("%#06x" % min(detras)) if detras else "nada", FIN_FOTOGRAMAS))
    for k, j in enumerate(inicios):
        fin = inicios[k + 1] if k + 1 < len(inicios) else FIN_FOTOGRAMAS
        n = (fin - j) // 64
        # las copias que empiezan aqui no pueden pasarse del juego
        for idx, ptr, nb in COPIAS_FOTOGRAMAS:
            if ptr == j and ptr + nb > fin:
                AVISOS.append("el recurso de sprite %d copia %d bytes desde %#06x y el juego acaba en %#06x" % (idx, nb, ptr, fin))
            if j < ptr < fin and nb != 64:
                AVISOS.append("el recurso de sprite %d (%#06x, %d B) cae dentro del juego %#06x-%#06x" % (idx, ptr, nb, j, fin))
        B.anade(4, j, fin, "fotogramas_%04X" % j, 16,
                "juego de %d fotogramas de coche (64 B = 2 sprites de 16x16, media fila = 16 B); lo usan %s" % (n, ", ".join(sorted(juegos[j]))),
                "tablas 0x7431/0x745B")
    return FIN_FOTOGRAMAS


def informe(juegos, fin_fot):
    print("CARGADOR DE TILES: %d listas, %d registros, %d recursos RLE distintos, %d de la tabla de 85 usados"
          % (len(listas_tiles), sum(1 for r in listas_tiles.values() for x in r if x[0] == "registro"),
             len(recursos_tiles), len(usados85)))
    tot = sum(v[1] for v in recursos_tiles.values())
    print("  tiles descomprimidos en total: %d (%d bytes)" % (sum(v[0] for v in recursos_tiles.values()), tot))
    print("CARGADOR DE SPRITES: %d listas, %d recursos usados de 34" % (len(listas_sprites), len(usados_sprites)))
    for idx in sorted(recursos_sprites):
        clase, tipo, ptr, n = recursos_sprites[idx]
        print("  recurso %2d: clase %2d tipo %02x origen %#06x %d bytes %s" % (
            idx, clase, tipo, ptr, n, "" if idx in usados_sprites else "(ninguna lista lo pide)"))
    print("FOTOGRAMAS: %d juegos, zona %#06x-%#06x (%d fotogramas de 64 B)" % (len(juegos), FOTOGRAMAS, fin_fot, (fin_fot - FOTOGRAMAS) // 64))
    ini = sorted(juegos)
    for k, j in enumerate(ini):
        fin = ini[k + 1] if k + 1 < len(ini) else fin_fot
        print("  juego %#06x: %2d fotogramas; %s" % (j, (fin - j) // 64, ", ".join(sorted(juegos[j]))))
    print("REGISTROS SOLO PATRONES (colores = RLE vacio): %d" % len(SIN_COLORES))
    for nt in NOTAS:
        print("NOTA:", nt)
    for p in sorted(B.b):
        cub = B.cubierto(p)
        print("p%02d: %d bloques, %d bytes identificados" % (p, len(B.b[p]), sum(cub)))
    for s in B.solapes():
        print("SOLAPE p%02d: %s con %s" % s)
    for av in AVISOS:
        print("AVISO:", av)


def bloques_fusionados(p):
    """Bloques contiguos del mismo nombre, fundidos (para las notas)."""
    out = []
    for ini, (fin, nombre, anch, texto) in B.ordenados(p):
        if out and out[-1][1] == ini and out[-1][2] == nombre and out[-1][3] == anch:
            out[-1] = (out[-1][0], fin, nombre, anch, out[-1][4] + 1)
        else:
            out.append((ini, fin, nombre, anch, 1))
    return out


def main(argv):
    global ROM
    if len(argv) < 2:
        sys.exit(__doc__)
    ROM = open(argv[1], "rb").read()
    modo = argv[2] if len(argv) > 2 else ""
    try:
        juegos = recorre()
        fin_fot = cierra_fotogramas(juegos)
        B.normaliza()
    except ValueError as e:
        print("ERROR:", e)
        return 1
    if modo == "--bloques":
        for p in sorted(B.b):
            for ini, (fin, nombre, anch, texto) in B.ordenados(p):
                print("p%02d %#06x %#06x %s" % (p, ini, fin, nombre))
    elif modo == "--notas":
        for p in sorted(B.b):
            print("# --- p%02d ---" % p)
            for ini, fin, nombre, anch, n in bloques_fusionados(p):
                texto = B.b[p][ini][3]
                print("D %#06x %#06x %s %s%s" % (ini, fin, nombre, texto, (" (x%d)" % n) if n > 1 else ""))
                print("F %#06x %s" % (ini, anch))
    elif modo == "--huecos":
        for p in list(range(4, 13)) + [14, 15]:
            cub = B.cubierto(p)
            o = org(p)
            ini = None
            for i in range(TAM_PAGINA + 1):
                v = cub[i] if i < TAM_PAGINA else 1
                if not v and ini is None:
                    ini = i
                elif v and ini is not None:
                    print("p%02d %#06x %#06x (%d bytes) sin identificar" % (p, o + ini, o + i, i - ini))
                    ini = None
    else:
        informe(juegos, fin_fot)
    if AVISOS or B.solapes():
        for av in AVISOS:
            print("AVISO:", av, file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
