#!/usr/bin/env python3
"""Lector de los DATOS DEL SONIDO de F-1 Spirit (paginas 13, 14 y 15, que el
driver de la pagina 13 lee con D/E/F mapeadas: p13 en 0x6000, p14 en 0x8000,
p15 en 0xA000).

Lo que lee (las rutinas estan en src/p13.notes):
  - La TABLA DE SONIDOS p13 0x6120: 70 punteros (sonidos 1..70; SONIDO_ORDEN
    0x6019 indexa 0x611E + 2A) a las CABECERAS de 0x61AC-0x6422. Cabecera
    (0x602E-0x60C1): [mascara de canales: bit 7 = canal 0 (E001) ... bit 0 =
    canal 7 (E135)] [prioridad, una para todos] y, por cada canal de la
    mascara, la palabra de su PISTA. SONIDO_ORDEN copia 18 bytes (el maximo:
    2 + 8 canales x 2) a E162.
  - La TABLA DE ENVOLVENTES p13 0x6E23: 10 punteros (0x65E4, por A*2) a
    secuencias terminadas en 0xFF (0x6E37-0x6F04).
  - La TABLA DE FORMAS DE ONDA p13 0x6F04: 69 punteros (0x6A20, por A*2) a
    formas de onda del SCC de 32 bytes (0x6F8E-0x730E); SCC_COPIA_ONDA las
    sube a 0x9800/20/40/60.
  - Las PISTAS: 169 direcciones distintas (239 canales de 70 sonidos), desde
    p13 0x7370 hasta p15 0xA5DE, justo antes del codigo de p15 (0xA5DF). El
    FINAL de cada pista no lo dice ningun byte: aqui cada una llega hasta donde
    empieza la siguiente (y la ultima, hasta 0xA5DF). Eso no distingue una
    pista de una frase que solo se alcanza desde dentro de otra: lo dira un
    lector de la partitura (las 31 ordenes de 0x6868), que esta por escribir.

Uso: sonido.py <rom> [--bloques | --notas]
"""
import sys
from collections import defaultdict

from paginas import org, TAM_PAGINA, N_PAGINAS

ROM = b""
AVISOS = []
TABLA_SONIDOS = 0x611E      # + 2*A, A = 1..70
N_SONIDOS = 70
CABECERAS = (0x61AC, 0x6422)
TABLA_ENVOLVENTES = (0x6E23, 10)
TABLA_ONDAS = (0x6F04, 69)
FIN_PISTAS = 0xA5DF          # donde empieza el codigo de p15
CANALES = [0xE001, 0xE02D, 0xE059, 0xE085, 0xE0B1, 0xE0DD, 0xE109, 0xE135]


def abs_(addr):
    if addr < 0x6000 or addr >= 0xC000:
        raise ValueError("direccion %#06x fuera de 0x6000-0xBFFF" % addr)
    p = 13 + (addr - 0x6000) // TAM_PAGINA
    return p * TAM_PAGINA + (addr - 0x6000) % TAM_PAGINA


def leer(addr):
    return ROM[abs_(addr)]


def palabra(addr):
    return leer(addr) | (leer(addr + 1) << 8)


def pagina_de(addr):
    return abs_(addr) // TAM_PAGINA


def lee():
    sonidos = []
    for n in range(1, N_SONIDOS + 1):
        h = palabra(TABLA_SONIDOS + 2 * n)
        if not (CABECERAS[0] <= h < CABECERAS[1]):
            AVISOS.append("la cabecera del sonido %d esta en %#06x, fuera de %#06x-%#06x" % (n, h, *CABECERAS))
        mask, prio = leer(h), leer(h + 1)
        canales = [k for k in range(8) if mask & (0x80 >> k)]
        pistas = [palabra(h + 2 + 2 * i) for i in range(len(canales))]
        sonidos.append((n, h, mask, prio, canales, pistas))
    # envolventes
    te, ne = TABLA_ENVOLVENTES
    env = [palabra(te + 2 * i) for i in range(ne)]
    if env[0] != te + 2 * ne:
        AVISOS.append("la tabla de envolventes acaba en %#06x y la primera envolvente esta en %#06x" % (te + 2 * ne, env[0]))
    envs = []
    for i, e in enumerate(env):
        a = e
        while leer(a) != 0xFF:
            a += 1
            if a - e > 64:
                raise ValueError("la envolvente %d (%#06x) no acaba en 0xFF" % (i, e))
        envs.append((e, a + 1, i))
    envs.sort()
    for k in range(len(envs) - 1):
        if envs[k][1] != envs[k + 1][0]:
            AVISOS.append("la envolvente %d acaba en %#06x y la siguiente empieza en %#06x" % (envs[k][2], envs[k][1], envs[k + 1][0]))
    to_, no = TABLA_ONDAS
    ondas = [palabra(to_ + 2 * i) for i in range(no)]
    ini_ondas = min(ondas)
    if ini_ondas != to_ + 2 * no:
        AVISOS.append("la tabla de ondas acaba en %#06x y la primera onda esta en %#06x" % (to_ + 2 * no, ini_ondas))
    for i, o in enumerate(ondas):
        if (o - ini_ondas) % 32:
            AVISOS.append("la onda de la entrada %d (%#06x) no esta alineada a 32 bytes" % (i, o))
    fin_ondas = max(ondas) + 32
    if envs[-1][1] != to_:
        AVISOS.append("la ultima envolvente acaba en %#06x y la tabla de ondas empieza en %#06x" % (envs[-1][1], to_))
    # pistas
    pistas = defaultdict(list)   # direccion -> [(sonido, canal)]
    for n, h, mask, prio, canales, ptrs in sonidos:
        for c, pt in zip(canales, ptrs):
            if not (fin_ondas <= pt < FIN_PISTAS):
                AVISOS.append("la pista del sonido %d canal %d (%#06x) cae fuera de %#06x-%#06x" % (n, c, pt, fin_ondas, FIN_PISTAS))
            pistas[pt].append((n, c))
    return sonidos, envs, ondas, ini_ondas, fin_ondas, pistas


def bloques(sonidos, envs, ondas, ini_ondas, fin_ondas, pistas):
    bl = []
    te, ne = TABLA_ENVOLVENTES
    to_, no = TABLA_ONDAS
    bl.append((te, te + 2 * ne, "tabla_envolventes", "w1", "10 punteros (0x65E4, por el numero de envolvente x 2) a las envolventes de abajo"))
    for e, fin, i in envs:
        bl.append((e, fin, "envolvente_%d" % i, 16, "envolvente %d: %d bytes y 0xFF al final; la recorre 0x65F5 byte a byte ((ix+17,18) es el puntero)" % (i, fin - e - 1)))
    bl.append((to_, to_ + 2 * no, "tabla_ondas", "w1", "69 punteros (0x6A20, por el numero de instrumento x 2) a las 28 formas de onda del SCC de abajo"))
    bl.append((ini_ondas, fin_ondas, "ondas_scc", 32, "28 formas de onda del SCC de 32 bytes (una por fila): SCC_COPIA_ONDA las sube a 0x9800/20/40/60 cuando la pista cambia de instrumento"))
    ini = sorted(pistas)
    for k, a in enumerate(ini):
        fin = ini[k + 1] if k + 1 < len(ini) else FIN_PISTAS
        quien = ", ".join("sonido %d canal %d" % (n, c) for n, c in sorted(pistas[a]))
        bl.append((a, fin, "pista_%04X" % a, 16,
                   "pista de la partitura (%s); hasta donde empieza la pista siguiente: el final exacto lo dira el lector de la partitura, por escribir" % quien))
    # partir por paginas
    res = []
    for ini_, fin, nombre, anch, texto in bl:
        a = ini_
        while a < fin:
            p = pagina_de(a)
            corte = min(fin, org(p) + TAM_PAGINA)
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
        sonidos, envs, ondas, ini_ondas, fin_ondas, pistas = lee()
        bl = bloques(sonidos, envs, ondas, ini_ondas, fin_ondas, pistas)
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
        for n, h, mask, prio, canales, ptrs in sonidos:
            print("sonido %2d: cabecera %#06x mascara %02X prioridad %3d canales %s pistas %s" % (
                n, h, mask, prio, canales, " ".join("%#06x" % p for p in ptrs)))
        print("envolventes: %s" % " ".join("%#06x-%#06x" % (e, f) for e, f, i in envs))
        print("ondas: %d entradas, %d formas de onda en %#06x-%#06x" % (len(ondas), (fin_ondas - ini_ondas) // 32, ini_ondas, fin_ondas))
        print("pistas: %d distintas de %d canales, %#06x-%#06x" % (len(pistas), sum(len(v) for v in pistas.values()), min(pistas), FIN_PISTAS))
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
