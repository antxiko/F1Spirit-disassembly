#!/usr/bin/env python3
"""Los "call seguido de tabla" (0x40DA) de cada pagina, y si su tabla esta protegida.

El despachador de Konami (0x40DA en la pagina 0: `pop hl / add a,a / hl+=a /
jp (hl)`) lleva la tabla de palabras JUSTO DETRAS del call. Un trazador que
siga de largo se la come como instrucciones y, peor, sigue desde ahi: es la
contaminacion mas facil de este cartucho. Este programa busca `CD DA 40` (y
`CD CB 4A`: 0x4ACB es la misma idea con exx y ex af,af', vista en p01 0x7C46) en
cada pagina, estima el tamano de la tabla (hasta su destino mas bajo dentro
de la pagina, el criterio de la serie) y dice si el call esta en codigo
trazado y si la tabla esta ya en el .nocode. Lo que salga como "TRAZADO y
SIN nocode" hay que declararlo ANTES del siguiente retrazado: la tabla en el
.nocode y sus destinos en el .entries (tambien los que caen fuera de la
pagina, que habra que medir).

Uso: despachadores.py <dir_work> <dir_src> [pNN ...]
"""
import json
import os
import re
import sys

from paginas import org, nombre, N_PAGINAS, TAM_PAGINA


def main(work, src, *cuales):
    pags = [int(c[1:]) for c in cuales] if cuales else list(range(N_PAGINAS))
    avisos = 0
    for p in pags:
        d = open(os.path.join(work, nombre(p) + ".bin"), "rb").read()
        o = org(p)
        code = set()
        ruta = os.path.join(work, nombre(p) + ".trace.json")
        if os.path.exists(ruta):
            for k, a, b in json.load(open(ruta))["blocks"]:
                if k == "c":
                    code.update(range(a, b))
        nc = set()
        rnc = os.path.join(src, nombre(p) + ".nocode")
        if os.path.exists(rnc):
            nc = {int(m.group(1), 16) for m in re.finditer(r"^0x([0-9A-Fa-f]{4})", open(rnc).read(), re.M)}
        for i in range(len(d) - 2):
            if d[i] == 0xCD and ((d[i + 1] == 0xDA and d[i + 2] == 0x40) or (d[i + 1] == 0xCB and d[i + 2] == 0x4A)):
                a = o + i
                tab = a + 3
                ws = [d[i + 3 + 2 * k] | (d[i + 4 + 2 * k] << 8) for k in range(64) if i + 4 + 2 * k < len(d)]
                cand = [w for w in ws if tab <= w < o + TAM_PAGINA]
                n = (min(cand) - tab) // 2 if cand else 0
                trazado = a in code
                protegida = tab in nc
                fuera = sorted({w for w in ws[:n] if not (o <= w < o + TAM_PAGINA)})
                estado = "TRAZADO" if trazado else "no trazado"
                estado += ", tabla en nocode" if protegida else ", SIN nocode"
                if trazado and not protegida:
                    estado += "  <-- DECLARAR YA"
                    avisos += 1
                print("%s call 40DA en %04X (%s): tabla %04X..%04X, %d palabras%s" % (
                    nombre(p), a, estado, tab, tab + 2 * n - 1, n,
                    ("; %d destinos fuera de la pagina: %s" % (len(fuera), " ".join("%04X" % w for w in fuera))) if fuera else ""))
                if not protegida:
                    print("    nocode: 0x%04X 0x%04X   tabla de %d palabras del despachador (call 0x40DA en 0x%04X)" % (tab, tab + 2 * n, n, a))
                    for w in sorted(set(ws[:n])):
                        if o <= w < o + TAM_PAGINA:
                            idx = [k for k, x in enumerate(ws[:n]) if x == w]
                            print("    entries: 0x%04X   # entrada%s %s de la tabla de 0x%04X" % (
                                w, "s" if len(idx) > 1 else "", ", ".join(map(str, idx)), tab))
    if avisos:
        print("\n%d despachadores trazados con la tabla SIN proteger: el trazado esta contaminado" % avisos)
        return 1
    print("\nOK: ningun despachador trazado con la tabla sin proteger")
    return 0


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
