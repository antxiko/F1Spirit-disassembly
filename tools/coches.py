#!/usr/bin/env python3
"""Lector de los COCHES de F-1 Spirit: la cadena de tablas que va desde lo que
el jugador elige en la pantalla de eleccion hasta las curvas de par del motor
que la carrera consulta en cada vuelta. Recorre la ROM como lo hace el codigo,
lo comprueba cruzando unas tablas con otras, y respalda las directivas D de
p02, p03 y p09.

La cadena (src/p01.notes y src/p02.notes):

  - Cada coche son CINCO bytes en RAM, en E297 (jugador 1) o E357 (jugador 2)
    (p01 0x67F0 BLOQUE_ELECCION). PARAMETROS_COCHE (p02 0x8943) los lee de
    IX-0x29 y los reparte:
        byte 0 -> (ix+74) MOTOR
        byte 1 -> (ix+18) CARROCERIA
        byte 2 -> (ix+77)
        byte 3 -> (ix+76)  (indice de la tabla_volante de p02 0x9291)
        byte 4 -> (ix+75) = byte & 0x7F; si tiene el bit 7, (ix+70) = 1

  - La ELECCION son seis pasos (E251 = 0..5) y en cada uno el jugador mueve el
    cursor por una lista de valores (E27E = columna). p01 0x676C
    (FILA_TABLA_BC45) toma de p03 0xBC45 la palabra (E251) de la fila
    (E25B) = categoria -el bloque es de 6 palabras, 12 bytes, por categoria- y
    p01 0x674E lee de esa lista el byte (E27E); la lista acaba en 0xFF (p01
    0x659D deshace el movimiento cuando lo encuentra).
      * El paso 0 elige un coche ENTERO: p01 0x6568 (COPIA_5_BYTES_COCHE) copia
        los cinco bytes de la entrada elegida de la tabla p03 0xBBEB.
      * Los pasos 1..5 escriben el byte (E251)-1 de esos cinco (p01 0x6480).

  - Con el MOTOR, PAR_MOTOR (p02 0x9C18) consulta la curva de par:
        HL = 0xB72E + motor*16 + (revoluciones_alto & 0xF8) >> 3
    con la pagina 9 mapeada en 0xA000 (`ld a,9 / call 0x4457`, y vuelve a
    1/2/3 con 0x43FE). Si el indice de columna llega a 16 devuelve 0xFF. Cada
    fila son 16 bytes: la curva sube y baja, y donde vale 0 se acaban las
    revoluciones: TOPE_REVS_BUCLE (p02 0x89BA) prueba C = 1..0x20, entra con
    A = 4*C (o sea columna C>>1) y guarda (ix+72) = 4*C+1 con el primer C que
    da 0. Los cinco bytes que sobran de cada fila son relleno (0xFF, y 0xFE o
    0x00 en dos filas).

  - Y por CARROCERIA, p02 0x898E: color de sprite en la tabla p02 0x88D7 y otro
    byte en la p02 0x88E9; por MOTOR, la palabra de la tabla p02 0x88FB.

  - Mientras se elige, cada valor ensena su FICHA (dibujo + texto). p01 0x6431
    lee el valor de la lista, hace `inc a` para ver si es el 0xFF del final -y
    NO lo deshace-, asi que PINTA_FICHA (p01 0x6611) recibe el valor + 1 y las
    dos rutinas que buscan la ficha hacen `dec a / and 0x7F`: el indice es el
    valor tal cual.
      * el DIBUJO (p01 0x6644 GRAFICO_FICHA): tabla p01 0x67C3 -> una tabla de
        punteros por paso (en la pagina 3, que es lo que hay en 0xA000 cuando
        se lee) -> un flujo RLE de 8 columnas que p01 0x6657 descomprime con la
        pagina 9 en 0xA000 (`ld a,8 / call 0x4447`).
      * el TEXTO (p01 0x67A2 TEXTO_FICHA): tabla p01 0x67B7 -> otra tabla de
        punteros en la pagina 3 -> un texto de los que ya lee tools/textos.py
        en la pagina 9.

Lo que se comprueba (y hace salir con 1 si no cuadra):
  - las 18 entradas de 5 bytes de 0xBBEB acaban justo donde empieza 0xBC45;
  - las 36 palabras de 0xBC45 apuntan dentro de la pagina 3, sus listas acaban
    en 0xFF y la ultima acaba justo donde empieza la tabla ya conocida 0xBD03;
  - los valores elegibles del paso 0 son exactamente 0..17 (las 18 entradas de
    0xBBEB) y los del paso 1, 0..35 (las 36 palabras de 0x88FB): seis motores y
    tres coches por categoria, sin repetirse ninguno;
  - los del paso 2 son 0..17 (las 18 entradas de 0x88D7 y 0x88E9) y los del
    paso 4 caben en la tabla_volante (9 bloques);
  - el motor y la carroceria de las 18 entradas de 0xBBEB estan en rango;
  - cada una de las 36 curvas de par tiene su 0 y el bucle de p02 0x89BA
    encuentra el tope antes de C = 0x20.

Uso:
    coches.py <rom>               informe
    coches.py <rom> --bloques     una linea por bloque: pNN ini fin nombre
    coches.py <rom> --notas       directivas D/F sugeridas
Sale con 1 si algo no cuadra.
"""
import sys

import textos
from paginas import TAM_PAGINA, N_PAGINAS

ROM = b""
AVISOS = []

TABLA_COCHES = 0xBBEB      # p03: 18 coches predefinidos de 5 bytes (p01 0x6568)
TABLA_ELECCION = 0xBC45    # p03: 6 categorias x 6 palabras (p01 0x676C)
FIN_ELECCION = 0xBD03      # p03: donde empieza la tabla_BD03, ya declarada
TABLA_PAR = 0xB72E         # p09: filas de 16 bytes por motor (p02 0x9C18)
ANCHO_PAR = 16
COL_PAR_MAX = 16           # p02 0x9C2A: `cp 0x10` -> 0xFF
TABLA_COLOR = 0x88D7       # p02: un color de sprite por carroceria
TABLA_88E9 = 0x88E9        # p02: un byte por carroceria -> (ix-21)
TABLA_MOTOR = 0x88FB       # p02: una palabra por motor -> (ix-20,-1F)
N_CATEGORIAS = 6
N_PASOS = 6
N_MOTORES_CAT = 6          # motores elegibles en cada categoria (paso 1)
N_VOLANTE = 9              # p02 0x9291 tabla_volante: 9 bloques por (ix+76)
TABLA_GRAFICOS_FICHA = 0x67C3   # p01: 6 punteros (E251) a tablas de la pagina 3
TABLA_TEXTOS_FICHA = 0x67B7     # p01: 6 punteros (E251) a tablas de la pagina 3
ANCHO_FICHA = 8            # columnas del dibujo de la ficha (p01 0x665D: `ld a,8`)
FIN_TABLAS_FICHA = 0xBBA3  # p03: donde empiezan los bloques de cursor de 4 bytes
FIN_TABLAS_TEXTO = 0xBDD5  # p03: 9 entradas tambien en la ultima tabla de texto
ZONA_FICHAS = (0xB024, 0xB72E)  # p09: los flujos RLE de los dibujos
# Que categoria es cada valor de (E25B). El menu las ensena en OTRO orden
# -STOCK RACE, RALLY, F3 RACE, F3000 RACE, ENDURANCE RACE en la columna de la
# izquierda y F1 RACE SELECT (ROUND 1-16) a la derecha: captura del juego que
# mando el usuario, 2026-08-19- y la tabla p01 0x6135 traduce la opcion del
# menu a esta numeracion: [1, 0, 3, 4, 2].
CATEGORIAS = ["RALLY", "STOCK", "ENDURANCE", "F3", "F3000", "F1"]


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


def lista_valores(addr):
    """Los valores de una lista de eleccion (grupo 1/2/3, pagina 3), hasta 0xFF."""
    vals, a = [], addr
    while True:
        v = leer(1, a)
        if v == 0xFF:
            return vals, a + 1
        vals.append(v)
        a += 1
        if len(vals) > 64:
            raise ValueError("lista de eleccion en %#06x sin 0xFF" % addr)


def tope_revoluciones(fila):
    """El bucle p02 0x89BA sobre una fila: devuelve (ix+72) o None si no lo halla."""
    for c in range(1, 0x21):
        col = ((4 * c) & 0xF8) >> 3
        v = 0xFF if col >= COL_PAR_MAX else fila[col]
        if v == 0:
            return 4 * c + 1
    return None


def tablas_ficha(base, elecciones, tope, que):
    """Las 6 tablas de punteros de la pagina 3 (una por paso), con su tamano.

    El numero de entradas que USA cada paso es el valor elegible mas alto + 1
    (el indice es el propio valor); el tamano de la tabla en la ROM es lo que
    hay hasta la siguiente, y la ultima llega hasta `tope`.
    """
    punteros = [palabra(1, base + 2 * p) for p in range(N_PASOS)]
    usadas = {}
    for p in range(N_PASOS):
        alto = max(v & 0x7F for c in range(N_CATEGORIAS) for v in elecciones[(c, p)][1])
        usadas[punteros[p]] = max(usadas.get(punteros[p], 0), alto + 1)
    orden = sorted(set(punteros))
    tablas = []
    for i, t in enumerate(orden):
        fin = orden[i + 1] if i + 1 < len(orden) else tope
        n = (fin - t) // 2
        if n < usadas[t]:
            raise ValueError("la tabla de %s %#06x tiene %d entradas y los pasos %s usan %d"
                             % (que, t, n, [p for p in range(N_PASOS) if punteros[p] == t], usadas[t]))
        pasos = [p for p in range(N_PASOS) if punteros[p] == t]
        tablas.append((t, fin, n, usadas[t], pasos))
    return punteros, tablas


def lee_fichas(elecciones):
    """Las tablas de ficha de la pagina 3 y los flujos RLE de los dibujos (p09)."""
    textos.ROM = ROM
    _, tg = tablas_ficha(TABLA_GRAFICOS_FICHA, elecciones, FIN_TABLAS_FICHA, "dibujos")
    _, tt = tablas_ficha(TABLA_TEXTOS_FICHA, elecciones, FIN_TABLAS_TEXTO, "textos")

    # los dibujos: un flujo RLE de 8 columnas por entrada usada
    flujos = {}
    for t, _, _, usadas, pasos in tg:
        for i in range(usadas):
            ptr = palabra(1, t + 2 * i)
            if not ZONA_FICHAS[0] <= ptr < ZONA_FICHAS[1]:
                raise ValueError("la entrada %d de la tabla de dibujos %#06x apunta a %#06x, fuera de %#06x-%#06x"
                                 % (i, t, ptr, ZONA_FICHAS[0], ZONA_FICHAS[1]))
            filas, fin, n = textos.rle_ram(7, ptr, ANCHO_FICHA)
            flujos[ptr] = (fin, len(filas), n, "el paso %s" % "/".join(str(p) for p in pasos))
    # y los huecos que quedan entre ellos tienen que ser mas flujos iguales
    a, huerfanos = ZONA_FICHAS[0], 0
    while a < ZONA_FICHAS[1]:
        if a in flujos:
            a = flujos[a][0]
            continue
        filas, fin, n = textos.rle_ram(7, a, ANCHO_FICHA)
        if fin > ZONA_FICHAS[1]:
            raise ValueError("el flujo de %#06x se sale de la zona de fichas (acaba en %#06x)" % (a, fin))
        flujos[a] = (fin, len(filas), n, "sin llamador visto")
        huerfanos += 1
        a = fin
    if a != ZONA_FICHAS[1]:
        raise ValueError("los flujos de fichas acaban en %#06x y la zona llega a %#06x" % (a, ZONA_FICHAS[1]))

    # los textos: los que ya lee tools/textos.py en la pagina 9
    cadenas, ini_t, fin_t = textos.lee_textos()
    empiezan = set(c[0] for c in cadenas)
    for t, _, _, usadas, pasos in tt:
        for i in range(usadas):
            ptr = palabra(1, t + 2 * i)
            if ptr not in empiezan:
                raise ValueError("la entrada %d de la tabla de textos %#06x apunta a %#06x, que no es el principio de ningun texto de p09 (%#06x-%#06x)"
                                 % (i, t, ptr, ini_t, fin_t))
    return tg, tt, flujos, huerfanos


def lee_todo():
    # --- los 18 coches predefinidos ---
    coches = []
    a = TABLA_COCHES
    while a < TABLA_ELECCION:
        coches.append(tuple(leer(1, a + i) for i in range(5)))
        a += 5
    if a != TABLA_ELECCION:
        raise ValueError("los coches de %#06x no acaban en %#06x sino en %#06x"
                         % (TABLA_COCHES, TABLA_ELECCION, a))

    # --- la tabla de eleccion: 6 categorias x 6 pasos ---
    elecciones = {}
    fin_listas = TABLA_ELECCION + N_CATEGORIAS * N_PASOS * 2
    ultima = fin_listas
    for c in range(N_CATEGORIAS):
        for p in range(N_PASOS):
            ptr = palabra(1, TABLA_ELECCION + c * N_PASOS * 2 + p * 2)
            if not fin_listas <= ptr < FIN_ELECCION:
                raise ValueError("la lista (categoria %d, paso %d) apunta a %#06x, fuera de %#06x-%#06x"
                                 % (c, p, ptr, fin_listas, FIN_ELECCION))
            vals, fin = lista_valores(ptr)
            elecciones[(c, p)] = (ptr, vals)
            ultima = max(ultima, fin)
    if ultima != FIN_ELECCION:
        raise ValueError("las listas de eleccion acaban en %#06x y no en %#06x (tabla_BD03)"
                         % (ultima, FIN_ELECCION))

    # --- las curvas de par: una fila de 16 bytes por motor ---
    motores = sorted(set(v for (c, p), (_, vals) in elecciones.items() if p == 1 for v in vals))
    n_motores = max(motores) + 1
    filas = []
    a = TABLA_PAR
    while True:
        fila = [leer(7, a + i) for i in range(ANCHO_PAR)]
        relleno = set(fila[11:ANCHO_PAR])
        if fila[10] != 0 or len(relleno) != 1:
            break
        filas.append(fila)
        a += ANCHO_PAR
        if a + ANCHO_PAR > 0xC000:
            break
    if len(filas) < n_motores:
        raise ValueError("la tabla de par tiene %d filas con forma de curva y hacen falta %d"
                         % (len(filas), n_motores))
    for m in range(n_motores):
        if tope_revoluciones(filas[m]) is None:
            raise ValueError("la curva del motor %d (%#06x) no tiene 0: el bucle de p02 0x89BA no acaba"
                             % (m, TABLA_PAR + m * ANCHO_PAR))

    # --- las tablas por carroceria y por motor de la pagina 2 ---
    carrocerias = sorted(set(v for (c, p), (_, vals) in elecciones.items() if p == 2 for v in vals))
    n_carrocerias = max(carrocerias) + 1
    if TABLA_88E9 - TABLA_COLOR != n_carrocerias:
        raise ValueError("la tabla de color %#06x mide %d y hay %d carrocerias"
                         % (TABLA_COLOR, TABLA_88E9 - TABLA_COLOR, n_carrocerias))
    if TABLA_MOTOR - TABLA_88E9 != n_carrocerias:
        raise ValueError("la tabla %#06x mide %d y hay %d carrocerias"
                         % (TABLA_88E9, TABLA_MOTOR - TABLA_88E9, n_carrocerias))

    # --- las comprobaciones cruzadas ---
    if sorted(set(v for (c, p), (_, vals) in elecciones.items() if p == 0 for v in vals)) != list(range(len(coches))):
        raise ValueError("los coches elegibles no son 0..%d" % (len(coches) - 1))
    if motores != list(range(n_motores)):
        raise ValueError("los motores elegibles no son 0..%d" % (n_motores - 1))
    if carrocerias != list(range(n_carrocerias)):
        raise ValueError("las carrocerias elegibles no son 0..%d" % (n_carrocerias - 1))
    for p, n in ((0, len(coches)), (1, n_motores), (2, n_carrocerias)):
        vistos = [v for (c, q), (_, vals) in elecciones.items() if q == p for v in vals]
        if len(vistos) != len(set(vistos)):
            raise ValueError("el paso %d repite valores entre categorias" % p)
    for c in range(N_CATEGORIAS):
        if len(elecciones[(c, 1)][1]) != N_MOTORES_CAT:
            raise ValueError("la categoria %d ofrece %d motores y no %d"
                             % (c, len(elecciones[(c, 1)][1]), N_MOTORES_CAT))
    for (c, p), (_, vals) in sorted(elecciones.items()):
        if p == 4 and max(vals) >= N_VOLANTE:
            raise ValueError("el paso 4 de la categoria %d elige %d y la tabla_volante tiene %d bloques"
                             % (c, max(vals), N_VOLANTE))
    for i, co in enumerate(coches):
        if co[0] >= n_motores:
            raise ValueError("el coche %d tiene el motor %d y solo hay %d" % (i, co[0], n_motores))
        if co[1] >= n_carrocerias:
            raise ValueError("el coche %d tiene la carroceria %d y solo hay %d" % (i, co[1], n_carrocerias))
    tg, tt, flujos, huerfanos = lee_fichas(elecciones)
    return coches, elecciones, filas, n_motores, n_carrocerias, tg, tt, flujos, huerfanos


def bloques(coches, elecciones, filas, n_motores, n_carrocerias, tg, tt, flujos, huerfanos):
    """(pagina, ini, fin, nombre, anchura, texto) de cada tabla de la cadena."""
    bl = []
    altos = [palabra(1, TABLA_MOTOR + 2 * m) >> 8 for m in range(n_motores)]
    # cuidado: el grupo de motores n NO es la categoria n (los motores 0..5 son
    # los de la categoria 2). Cada categoria se lleva los suyos del paso 1.
    por_cat = ", ".join("%s %02X" % (CATEGORIAS[c], altos[min(elecciones[(c, 1)][1])])
                        for c in range(N_CATEGORIAS))
    bl.append((2, TABLA_COLOR, TABLA_88E9, "tabla_color_carroceria",
               str(n_carrocerias),
               "un color de sprite por carroceria (%d): (ix+0F) en p02 0x898E; las %d salen de los pasos 2 de la tabla de eleccion p03 0xBC45"
               % (n_carrocerias, n_carrocerias)))
    bl.append((2, TABLA_88E9, TABLA_MOTOR, "tabla_88e9",
               str(n_carrocerias),
               "un byte por carroceria (%d) -> (ix-21) en p02 0x89AA" % n_carrocerias))
    bl.append((2, TABLA_MOTOR, TABLA_MOTOR + 2 * n_motores, "tabla_motor",
               "w%d" % N_MOTORES_CAT,
               "una palabra por motor (%d) -> (ix-20,-1F) en p02 0x899B; los %d motores son los valores del paso 1 de p03 0xBC45, %d por categoria, y los de cada categoria comparten el byte alto (%s)"
               % (n_motores, n_motores, N_MOTORES_CAT, por_cat)))
    bl.append((3, TABLA_COCHES, TABLA_ELECCION, "tabla_coches",
               "5", "%d coches predefinidos de 5 bytes (motor, carroceria, (ix+77), (ix+76), (ix+75)|bit7); p01 0x6568 copia a E297/E357 el que se elige en el paso 0"
               % len(coches)))
    bl.append((3, TABLA_ELECCION, TABLA_ELECCION + N_CATEGORIAS * N_PASOS * 2, "tabla_eleccion",
               "w%d" % N_PASOS,
               "%d categorias (E25B) x %d punteros (E251) a las listas de valores de abajo; p01 0x676C"
               % (N_CATEGORIAS, N_PASOS)))
    # las listas de valores: varias categorias comparten la misma, y van seguidas
    listas = {}
    for (c, p), (ptr, vals) in sorted(elecciones.items()):
        listas.setdefault(ptr, (vals, []))[1].append((c, p))
    siguiente = TABLA_ELECCION + N_CATEGORIAS * N_PASOS * 2
    for ptr in sorted(listas):
        vals, duenos = listas[ptr]
        if ptr != siguiente:
            AVISOS.append("la lista %#06x no va pegada a la anterior (%#06x)" % (ptr, siguiente))
        siguiente = ptr + len(vals) + 1
        pasos = sorted(set(p for _, p in duenos))
        cats = sorted(set(c for c, _ in duenos))
        bl.append((3, ptr, siguiente, "valores_%04x" % ptr, str(len(vals) + 1),
                   "%d valores y 0xFF: %s; los elige el paso %s de %s"
                   % (len(vals), " ".join("%02X" % v for v in vals),
                      "/".join(str(p) for p in pasos),
                      "la categoria %d (%s)" % (cats[0], CATEGORIAS[cats[0]]) if len(cats) == 1
                      else "las categorias " + ", ".join("%d %s" % (c, CATEGORIAS[c]) for c in cats))))
    bl.append((9, TABLA_PAR, TABLA_PAR + n_motores * ANCHO_PAR, "tabla_par_motor",
               str(ANCHO_PAR), "una curva de par por motor (%d filas de %d bytes): p02 0x9C18 lee la columna (revoluciones & 0xF8) >> 3, y donde vale 0 esta el tope de revoluciones que busca p02 0x89BA"
               % (n_motores, ANCHO_PAR)))
    sobran = len(filas) - n_motores
    if sobran > 0:
        bl.append((9, TABLA_PAR + n_motores * ANCHO_PAR, TABLA_PAR + len(filas) * ANCHO_PAR,
                   "tabla_par_sobrante", str(ANCHO_PAR),
                   "%d filas mas con la misma forma que las de arriba y repetidas de ellas; ningun motor las alcanza (el indice no pasa de %d)"
                   % (sobran, n_motores - 1)))
    for tabla, que, quien in ((tg, "dibujos", "p01 0x6644, y p01 0x6657 lo descomprime con la pagina 9 en 0xA000"),
                              (tt, "textos", "p01 0x67A2; los textos son los de la pagina 9 que lee tools/textos.py")):
        for t, fin, n, usadas, pasos in tabla:
            extra = "" if n == usadas else " (las %d ultimas repiten las primeras y ningun valor las alcanza)" % (n - usadas)
            bl.append((3, t, fin, "ficha_%s_%04x" % (que, t), "w1",
                       "%d punteros a %s de ficha, %d en uso: el paso %s de la eleccion, indexado por el valor%s; %s"
                       % (n, que[:-1] if que.endswith("s") else que, usadas,
                          "/".join(str(p) for p in pasos), extra, quien)))
    for ini in sorted(flujos):
        fin, nfilas, nbytes, quien = flujos[ini]
        bl.append((9, ini, fin, "ficha_rle_%04x" % ini, "16",
                   "dibujo de ficha comprimido (RLE_A_BUFFER de p01 0x637A, %d columnas): %d filas, %d bytes al descomprimir; lo apunta %s"
                   % (ANCHO_FICHA, nfilas, nbytes, quien)))
    return sorted(bl, key=lambda b: (b[0], b[1]))


def main(argv):
    global ROM
    if len(argv) < 2:
        sys.exit(__doc__)
    ROM = open(argv[1], "rb").read()
    modo = argv[2] if len(argv) > 2 else ""
    try:
        coches, elecciones, filas, n_motores, n_carrocerias, tg, tt, flujos, huerfanos = lee_todo()
        bl = bloques(coches, elecciones, filas, n_motores, n_carrocerias, tg, tt, flujos, huerfanos)
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
        print("%d coches predefinidos en %#06x-%#06x (5 bytes)" % (len(coches), TABLA_COCHES, TABLA_ELECCION))
        for i, co in enumerate(coches):
            print("  coche %2d: motor %2d carroceria %2d  (ix+77) %d  (ix+76) %d  (ix+75) %02X"
                  % (i, co[0], co[1], co[2], co[3], co[4]))
        print("%d categorias x %d pasos de eleccion (%#06x):" % (N_CATEGORIAS, N_PASOS, TABLA_ELECCION))
        for c in range(N_CATEGORIAS):
            for p in range(N_PASOS):
                ptr, vals = elecciones[(c, p)]
                print("  categoria %d %-9s paso %d -> %#06x: %s" % (c, CATEGORIAS[c], p, ptr, " ".join("%02X" % v for v in vals)))
        print("%d curvas de par en %#06x (+%d filas repetidas que nadie alcanza):"
              % (n_motores, TABLA_PAR, len(filas) - n_motores))
        for m in range(n_motores):
            f = filas[m]
            print("  motor %2d %#06x: %s | tope (ix+72) = %d"
                  % (m, TABLA_PAR + m * ANCHO_PAR,
                     " ".join("%02X" % v for v in f[:11]), tope_revoluciones(f)))
        print("%d carrocerias (tablas p02 %#06x y %#06x)" % (n_carrocerias, TABLA_COLOR, TABLA_88E9))
        print("fichas: %d tablas de dibujo y %d de texto en la pagina 3; %d flujos RLE en %#06x-%#06x (%d sin llamador visto)"
              % (len(tg), len(tt), len(flujos), ZONA_FICHAS[0], ZONA_FICHAS[1], huerfanos))
        for t, fin, n, usadas, pasos in tg + tt:
            print("  tabla %#06x-%#06x: %d entradas (%d en uso), paso %s"
                  % (t, fin, n, usadas, "/".join(str(p) for p in pasos)))
        tot = {}
        for p, ini, fin, _, _, _ in bl:
            tot[p] = tot.get(p, 0) + fin - ini
        for p in sorted(tot):
            print("p%02d: %d bytes identificados" % (p, tot[p]))
    for av in AVISOS:
        print("AVISO:", av)
    return 1 if AVISOS else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
