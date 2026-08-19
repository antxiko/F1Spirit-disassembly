#!/usr/bin/env python3
"""Lector de los CIRCUITOS de F-1 Spirit: recorre desde la ROM la cadena que
el codigo de la pagina 0 sigue para pintar la pista, comprueba que cuadra y
dice que bytes de que pagina ocupa cada tabla. Respalda las directivas D de
p07, p10, p11 y p12.

La cadena (src/p00.notes, 0x5530 PREPARA_CIRCUITO y 0x564C PINTA_FILA_PISTA):
  - Por carrera (E25C) = 0..20, tres punteros:
      (E257) = p07[0x6000 + 2i]   la SECUENCIA del circuito (se lee con 7/8/9)
      (E259) = p12[0xAFA2 + 2i]   la tabla de PIEZAS (se lee con A/B/C: p10)
      (E253) = p12[0xAF78 + 2i]   la tabla de METATILES (con A/B/C: p10-p12)
  - SECUENCIA: pares (pieza, flags); pieza 0xFF = fin de vuelta (0x56D7
    vuelve al principio y suma una vuelta en (ix-2)). flags: si bit 6, los
    bits 0..5 se suman al desplazamiento de columna (ix-0x19) modulo 8 con el
    que se lee la fila de la pieza (0x5683-0x568A).
  - PIEZA: 24 bytes = 3 filas x 8 indices de metatile (0x5699-0x56AF: pieza*24
    + fila*8, fila = ((ix+0x45) & 0x0C) >> 2). Una fila de pieza son 8 metatiles
    = 32 tiles = la pantalla entera de ancho; la pieza, 12 filas de tiles.
  - METATILE: 16 bytes = 4 filas x 4 tiles (0x56B6-0x56C7: fila (ix+0x45)&3
    invertida, *4; 0x5705 PINTA_8_METATILES copia 4 tiles por metatile con ldi
    a la fila del buffer de nombres E400/EC00, leyendo los 8 indices de la
    fila de la pieza en orden rotado desde la columna (ix-0x19)).
  Los tamanos de las tablas de piezas y metatiles no los dice ningun byte: se
  deducen del indice maximo que usa cada carrera (y se comprueba que cada tabla
  acaba donde empieza la siguiente).
  - Ademas, 0x5730 (PINTA_ESCENA_FIJA) pinta con el mismo motor una escena de
    3 piezas (secuencia fija 0x574F de la pagina 0: piezas 0, 1, 2) con una
    tabla de piezas y otra de metatiles propias: 0x5778 usa p10 0x7D88/0x7E38 y
    0x578A usa p10 0x7DD0/0x7E18. Son las que llenan el hueco entre la tabla de
    piezas D y la de metatiles A.

  - Y por carrera, la lista de OBJETOS DE LA PISTA: 0x5F5D (con 7/8/9) toma de
    la tabla p08 0x9B20 (21 palabras por (E25C)) un registro [n][n x 3 bytes]
    -> (E275) = n, (E273) = los registros; 0x5E6C los recorre durante la
    carrera por (ix+0x57): palabra (posicion en la pista: los 12 bits altos, y
    el tipo en los 4 bajos) y un byte. Los 21 van seguidos de p08 0x9B4A a p09
    0xA6DE.

Uso:
    circuitos.py <rom>               informe
    circuitos.py <rom> --bloques     una linea por bloque: pNN ini fin nombre
    circuitos.py <rom> --notas       directivas D/F sugeridas
Sale con 1 si algo no cuadra.
"""
import sys
from collections import defaultdict

from paginas import org, TAM_PAGINA, N_PAGINAS

ROM = b""
N_CARRERAS = 21
TABLA_SECUENCIAS = 0x6000     # p07, con 7/8/9
TABLA_PIEZAS = 0xAFA2         # p12, con A/B/C
TABLA_METATILES = 0xAF78      # p12, con A/B/C
ESCENAS = [                    # (piezas, metatiles, quien): PINTA_ESCENA_FIJA
    (0x7D88, 0x7E38, "p00 0x5778"),
    (0x7DD0, 0x7E18, "p00 0x578A"),
]
SECUENCIA_FIJA = (0, 1, 2)    # p00 0x574F: las tres piezas de una escena
TABLA_OBJETOS = 0x9B20        # p08, con 7/8/9: 21 punteros a [n][n x 3 bytes]
# Que carrera es cada indice de (E25C). p01 0x611B: E25C = E25B para las cinco
# categorias y 5 + (E29D) para la F1. Los nombres, de la captura del menu que
# mando el usuario (2026-08-19) y del texto del ranking de p09 0xAB74.
TABLA_MAPA = 0x7753           # p01 (con 1/2/3): 21 entradas de dos palabras
FIN_MAPAS = 0xB805            # p06: donde acaban los caminos (empiezan los rotulos)
CATEGORIAS = ["RALLY", "STOCK", "ENDURANCE", "F3", "F3000"]


def nombre_carrera(i):
    if i < len(CATEGORIAS):
        return CATEGORIAS[i]
    return "F1 ROUND %d" % (i - len(CATEGORIAS) + 1)

AVISOS = []


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


def secuencia(addr):
    """Pares (pieza, flags) desde addr (grupo 7) hasta la pieza 0xFF."""
    pares, a = [], addr
    while True:
        pieza = leer(7, a)
        if pieza == 0xFF:
            return pares, a + 1
        pares.append((pieza, leer(7, a + 1)))
        a += 2
        if len(pares) > 1024:
            raise ValueError("secuencia en %#06x sin fin" % addr)


def signo4(n):
    return n - 16 if n >= 8 else n


def minimapas():
    """Los 21 caminos del minimapa: (indice, inicio, ini, fin, pasos, cierra).

    p01 0x7753 da, por carrera, la posicion inicial del marcador (E2BA) y el
    puntero al camino; cada byte del camino son dos nibbles CON SIGNO que se
    suman a esa posicion (p01 0x7827 AVANZA_MARCADOR_1J). Los caminos van
    seguidos en la pagina 6 y el ultimo acaba donde empiezan los rotulos.
    LA COMPROBACION que los valida: un circuito se cierra, o sea que la suma de
    todos los deltas de un camino tiene que ser cero en los dos ejes.
    """
    ptrs = [palabra(1, TABLA_MAPA + 4 * i + 2) for i in range(N_CARRERAS)]
    pos = [palabra(1, TABLA_MAPA + 4 * i) for i in range(N_CARRERAS)]
    orden = sorted(range(N_CARRERAS), key=lambda k: ptrs[k])
    out = []
    for n, k in enumerate(orden):
        fin = ptrs[orden[n + 1]] if n + 1 < len(orden) else FIN_MAPAS
        if fin <= ptrs[k]:
            raise ValueError("el camino de la carrera %d (%#06x) no va antes del siguiente" % (k, ptrs[k]))
        pasos = [leer(4, ptrs[k] + j) for j in range(fin - ptrs[k])]
        sx = sum(signo4(b >> 4) for b in pasos)
        sy = sum(signo4(b & 15) for b in pasos)
        if (sx, sy) != (0, 0):
            AVISOS.append("el minimapa de la carrera %d no cierra: los deltas suman (%d, %d)" % (k, sx, sy))
        out.append((k, pos[k], ptrs[k], fin, len(pasos), (sx, sy) == (0, 0)))
    return sorted(out)


def lee_todo():
    carreras = []
    for i in range(N_CARRERAS):
        sec = palabra(7, TABLA_SECUENCIAS + 2 * i)
        piezas = palabra(10, TABLA_PIEZAS + 2 * i)
        meta = palabra(10, TABLA_METATILES + 2 * i)
        pares, fin = secuencia(sec)
        carreras.append(dict(i=i, sec=sec, fin_sec=fin, piezas=piezas, meta=meta, pares=pares))
    # tablas de piezas: por direccion, el indice maximo entre las carreras que la usan
    tablas_piezas = defaultdict(int)
    usan_piezas = defaultdict(list)
    for c in carreras:
        m = max(p for p, f in c["pares"])
        tablas_piezas[c["piezas"]] = max(tablas_piezas[c["piezas"]], m)
        usan_piezas[c["piezas"]].append(c["i"])
    # metatiles: por tabla, el indice maximo entre las piezas que usan esas carreras
    tablas_meta = defaultdict(int)
    usan_meta = defaultdict(list)
    tiles_max = 0
    for c in carreras:
        ids = {p for p, f in c["pares"]}
        mm = 0
        for p in ids:
            for k in range(24):
                mm = max(mm, leer(10, c["piezas"] + 24 * p + k))
        tablas_meta[c["meta"]] = max(tablas_meta[c["meta"]], mm)
        usan_meta[c["meta"]].append(c["i"])
        c["max_pieza"] = max(ids)
        c["max_meta"] = mm
    for mt, mm in tablas_meta.items():
        for m in range(mm + 1):
            for k in range(16):
                tiles_max = max(tiles_max, leer(10, mt + 16 * m + k))
    # las escenas fijas: 3 piezas y los metatiles que esas piezas usan
    for piezas, meta, quien in ESCENAS:
        mm = 0
        for p in SECUENCIA_FIJA:
            for k in range(24):
                mm = max(mm, leer(10, piezas + 24 * p + k))
        tablas_piezas[piezas] = max(tablas_piezas[piezas], max(SECUENCIA_FIJA))
        usan_piezas[piezas].append(quien)
        tablas_meta[meta] = max(tablas_meta[meta], mm)
        usan_meta[meta].append(quien)
    # objetos de la pista: 21 registros [n][3n], seguidos
    objetos = []
    for i in range(N_CARRERAS):
        r = palabra(7, TABLA_OBJETOS + 2 * i)
        n = leer(7, r)
        objetos.append((r, r + 1 + 3 * n, n, i))
    objetos.sort()
    for k in range(len(objetos) - 1):
        if objetos[k][1] != objetos[k + 1][0]:
            AVISOS.append("los objetos de la carrera %d acaban en %#06x y los siguientes empiezan en %#06x" % (objetos[k][3], objetos[k][1], objetos[k + 1][0]))
    if objetos[0][0] != TABLA_OBJETOS + 2 * N_CARRERAS:
        AVISOS.append("la tabla de objetos acaba en %#06x y el primer registro esta en %#06x" % (TABLA_OBJETOS + 2 * N_CARRERAS, objetos[0][0]))
    return carreras, dict(tablas_piezas), dict(usan_piezas), dict(tablas_meta), dict(usan_meta), tiles_max, objetos


def bloques(carreras, tp, up, tm, um, objetos):
    out = []   # (pagina, ini, fin, nombre, anchura, texto)
    for i, pos, ini, fin, n, cierra in minimapas():
        # grupo 4 (mapeo 4/5/6): con el son las mismas direcciones con las que
        # los lee minimapas(), y 0xB22E-0xB805 cae en la pagina 6
        out.append((4, ini, fin, "minimapa_%02d" % i, 16,
                    "camino del minimapa de la carrera %d (%s): %d pasos, cada byte dos nibbles con signo (0x784E: el ALTO a la x del marcador, el BAJO a la y) que p01 0x7827 va sumando desde (x=%d, y=%d); los deltas suman cero en los dos ejes, o sea el trazado cierra"
                    % (i, nombre_carrera(i), n, pos >> 8, pos & 0xFF)))
    out.append((7, TABLA_OBJETOS, TABLA_OBJETOS + 2 * N_CARRERAS, "tabla_objetos_pista", "w1",
                "21 punteros (por la carrera (E25C)) a la lista de objetos de la pista de cada circuito; la lee 0x5F5D con 7/8/9"))
    for r, fin, n, i in objetos:
        out.append((7, r, fin, "objetos_pista_%02d" % i, "1,3",
                    "objetos de la pista de la carrera %d (%s): %d registros de 3 bytes (palabra = posicion en la pista en los 12 bits altos y tipo en los 4 bajos; y un byte), precedidos de la cuenta; los recorre 0x5E6C por (ix+0x57)" % (i, nombre_carrera(i), n)))
    # p07: la tabla de 21 punteros y las 21 secuencias, que van seguidas
    out.append((7, TABLA_SECUENCIAS, TABLA_SECUENCIAS + 2 * N_CARRERAS, "tabla_circuitos", "w1",
                "21 punteros (por la carrera (E25C)) a la secuencia de cada circuito"))
    secs = sorted(carreras, key=lambda c: c["sec"])
    for k, c in enumerate(secs):
        sig = secs[k + 1]["sec"] if k + 1 < len(secs) else None
        if sig is not None and c["fin_sec"] != sig:
            AVISOS.append("la secuencia de la carrera %d acaba en %#06x y la siguiente empieza en %#06x" % (c["i"], c["fin_sec"], sig))
        vueltas = sum(1 for p, f in c["pares"] if f & 0x40)
        out.append((7, c["sec"], c["fin_sec"], "circuito_%02d" % c["i"], 2,
                    "secuencia del circuito de la carrera %d (%s): %d pares (pieza, flags) y 0xFF; piezas hasta la %d, %d con desplazamiento de columna (bit 6)"
                    % (c["i"], nombre_carrera(c["i"]), len(c["pares"]), c["max_pieza"], vueltas)))
    # p10: tablas de piezas, ordenadas, cada una hasta la siguiente
    escenas_p = {pz: q for pz, _, q in ESCENAS}
    escenas_m = {mt: q for _, mt, q in ESCENAS}
    ini_p = sorted(tp)
    letra = 0
    for k, a in enumerate(ini_p):
        n = tp[a] + 1
        fin = a + 24 * n
        sig = ini_p[k + 1] if k + 1 < len(ini_p) else None
        # la ultima tabla de piezas acaba donde empieza la primera de metatiles
        if sig is None:
            sig = min(tm)
        if fin != sig:
            AVISOS.append("tabla de piezas %#06x: %d piezas acaban en %#06x pero lo siguiente empieza en %#06x" % (a, n, fin, sig))
        if a in escenas_p:
            out.append((10, a, fin, "piezas_escena", 8,
                        "las 3 piezas (24 B = 3 filas x 8 metatiles) de la escena fija que pinta %s" % escenas_p[a]))
        else:
            out.append((10, a, fin, "piezas_%c" % chr(ord("A") + letra), 8,
                        "tabla de piezas %c: %d piezas de 24 B (3 filas x 8 metatiles); la usan las carreras %s"
                        % (chr(ord("A") + letra), n, ",".join(str(i) for i in up[a]))))
            letra += 1
    # metatiles: idem (pueden cruzar de pagina: p10 -> p11 -> p12)
    ini_m = sorted(tm)
    letra = 0
    for k, a in enumerate(ini_m):
        n = tm[a] + 1
        fin = a + 16 * n
        sig = ini_m[k + 1] if k + 1 < len(ini_m) else TABLA_METATILES
        if a in escenas_m:
            texto = "los %d metatiles (16 B = 4 filas x 4 tiles) de la escena fija que pinta %s" % (n, escenas_m[a])
            nombre = "metatiles_escena"
        else:
            texto = ("tabla de metatiles %c: %d metatiles de 16 B (4 filas x 4 tiles); la usan las carreras %s"
                     % (chr(ord("A") + letra), n, ",".join(str(i) for i in um[a])))
            nombre = "metatiles_%c" % chr(ord("A") + letra)
            letra += 1
        if fin != sig:
            if fin < sig and (sig - fin) % 16 == 0 and sig - fin <= 16 * 8:
                texto += "; los %d ultimos no los usa ninguna carrera" % ((sig - fin) // 16)
                texto = texto.replace("%d metatiles de 16 B" % n, "%d metatiles de 16 B" % ((sig - a) // 16))
                fin = sig
            else:
                AVISOS.append("tabla de metatiles %#06x: %d metatiles acaban en %#06x y lo siguiente empieza en %#06x" % (a, n, fin, sig))
        out.append((10, a, fin, nombre, 16, texto))
    out.append((10, TABLA_METATILES, TABLA_METATILES + 2 * N_CARRERAS, "tabla_metatiles", "w1",
                "21 punteros (por (E25C)) a la tabla de metatiles de cada carrera"))
    out.append((10, TABLA_PIEZAS, TABLA_PIEZAS + 2 * N_CARRERAS, "tabla_piezas", "w1",
                "21 punteros (por (E25C)) a la tabla de piezas de cada carrera"))
    # partir por paginas
    res = []
    for grupo, ini, fin, nombre, anch, texto in out:
        a = ini
        while a < fin:
            p = pagina_de(grupo, a)
            corte = min(fin, org(p) + TAM_PAGINA)
            if corte <= a:   # grupo mal puesto: sin esto el while no avanza
                raise ValueError("el bloque %s (%#06x-%#06x, grupo %d) no cae "
                                 "en la pagina %d (org %#06x)" % (nombre, ini, fin, grupo, p, org(p)))
            res.append((p, a, corte, nombre, anch, texto + (" (sigue en la pagina siguiente)" if corte < fin else "")))
            a = corte
    return sorted(res)


def main(argv):
    global ROM
    if len(argv) < 2:
        sys.exit(__doc__)
    ROM = open(argv[1], "rb").read()
    modo = argv[2] if len(argv) > 2 else ""
    try:
        carreras, tp, up, tm, um, tiles_max, objetos = lee_todo()
        bl = bloques(carreras, tp, up, tm, um, objetos)
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
    else:
        for c in carreras:
            print("carrera %2d %-12s: secuencia %#06x-%#06x (%3d piezas, max %3d) piezas %#06x metatiles %#06x (max %3d)"
                  % (c["i"], nombre_carrera(c["i"]), c["sec"], c["fin_sec"], len(c["pares"]), c["max_pieza"], c["piezas"], c["meta"], c["max_meta"]))
        for a in sorted(tp):
            print("tabla de piezas %#06x: %d piezas, carreras %s" % (a, tp[a] + 1, up[a]))
        for a in sorted(tm):
            print("tabla de metatiles %#06x: %d metatiles, carreras %s" % (a, tm[a] + 1, um[a]))
        print("indice de tile mas alto en los metatiles: %d" % tiles_max)
        print("objetos de la pista: %d registros en %#06x-%#06x (p08 -> p09)" % (sum(n for _, _, n, _ in objetos), objetos[0][0], objetos[-1][1]))
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
