#!/usr/bin/env python3
"""Reescribe en las notas de cada pagina los marcadores de lo que queda sin explicar.

El presupuesto exige que cada byte sea codigo trazado o datos con nombre. En
un MegaROM de 128 KB trazado pagina a pagina, lo que queda por trazar no es
un hueco que se explique en una tarde: son paginas enteras. Este programa
mantiene al dia, en cada src/pNN.notes, una seccion delimitada con rangos D
llamados `pendiente_de_trazar` que cubren EXACTAMENTE los bytes que ni el
trazado marca como codigo ni ningun otro rango D de las notas explica.

Son marcadores, no explicaciones: dicen "esto esta sin hacer" y el avance de
verdad se mide en cuantos bytes quedan dentro de ellos (tests/test_listado.py
vigila que esa cifra solo baje). Todo lo que este fuera de la seccion
delimitada se respeta tal cual.

Uso: huecos.py <dir_work> <dir_src> [pNN ...]     (sin paginas: las 16)
"""
import json
import os
import re
import sys

from paginas import org, nombre, TAM_PAGINA, N_PAGINAS

INI = "# --- PENDIENTE DE TRAZAR (seccion que reescribe tools/huecos.py; no editar a mano) ---"
FIN = "# --- fin de la seccion pendiente ---"


def rangos_d(lineas):
    out = []
    for ln in lineas:
        m = re.match(r"D\s+0x([0-9A-Fa-f]+)\s+0x([0-9A-Fa-f]+)\s+(\S+)", ln)
        if m and m.group(3) != "pendiente_de_trazar":
            out.append((int(m.group(1), 16), int(m.group(2), 16)))
    return out


def huecos_de(work, src, p):
    ORG = org(p)
    cubierto = bytearray(TAM_PAGINA)
    traza = os.path.join(work, nombre(p) + ".trace.json")
    if os.path.exists(traza):
        for tipo, a, b in json.load(open(traza))["blocks"]:
            if tipo == "c":
                for i in range(max(0, a - ORG), min(TAM_PAGINA, b - ORG)):
                    cubierto[i] = 1
    ruta = os.path.join(src, nombre(p) + ".notes")
    lineas = open(ruta, encoding="utf-8").read().splitlines() if os.path.exists(ruta) else []
    for a, b in rangos_d(lineas):
        for i in range(max(0, a - ORG), min(TAM_PAGINA, b - ORG)):
            cubierto[i] = 1
    out, ini = [], None
    for i, v in enumerate(cubierto):
        if not v and ini is None:
            ini = i
        elif v and ini is not None:
            out.append((ORG + ini, ORG + i))
            ini = None
    if ini is not None:
        out.append((ORG + ini, ORG + TAM_PAGINA))
    return lineas, out


def reescribe(work, src, p):
    lineas, hs = huecos_de(work, src, p)
    seccion = [INI]
    for a, b in hs:
        seccion.append("D %#06x %#06x pendiente_de_trazar Sin trazar ni identificar todavia (%d bytes)" % (a, b, b - a))
    seccion.append(FIN)
    # quitar la seccion anterior (y los marcadores sueltos de la version inicial)
    nuevas, dentro = [], False
    for ln in lineas:
        if ln.strip() == INI:
            dentro = True
            continue
        if ln.strip() == FIN:
            dentro = False
            continue
        if dentro:
            continue
        if re.match(r"D\s+0x[0-9A-Fa-f]+\s+0x[0-9A-Fa-f]+\s+pendiente_de_trazar\b", ln):
            continue
        nuevas.append(ln)
    while nuevas and not nuevas[-1].strip():
        nuevas.pop()
    texto = "\n".join(nuevas + [""] + seccion) + "\n"
    open(os.path.join(src, nombre(p) + ".notes"), "w", encoding="utf-8").write(texto)
    return hs


def main(work, src, *cuales):
    pags = [int(c[1:]) for c in cuales] if cuales else list(range(N_PAGINAS))
    total = 0
    for p in pags:
        hs = reescribe(work, src, p)
        n = sum(b - a for a, b in hs)
        total += n
        print("  %s: %2d rangos pendientes, %5d bytes" % (nombre(p), len(hs), n))
    print("  pendiente en total: %d bytes de %d (%.1f %%)" % (
        total, TAM_PAGINA * N_PAGINAS, 100.0 * total / (TAM_PAGINA * N_PAGINAS)))


if __name__ == "__main__":
    main(*sys.argv[1:])
