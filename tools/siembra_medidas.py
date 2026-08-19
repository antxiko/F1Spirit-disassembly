#!/usr/bin/env python3
"""Vuelca a los .entries lo que midio tools/omsx_bancos.tcl.

Lee work/omsx/bancos.log (lineas "pNN:ORIG -> DEST  pagina P  t=..."), agrupa
por pagina de destino y anade a src/pPP.entries las direcciones DEST que aun
no esten sembradas, con su origen y la marca "(medido)". Tambien escribe
work/omsx/externos.txt -la lista que lee omsx_bancos.tcl- a partir de los
trace.json, para la siguiente vuelta.

Uso: siembra_medidas.py <dir_work> <dir_src> [--solo-lista]
     --solo-lista: solo regenera externos.txt, no toca los .entries
"""
import json
import os
import re
import sys

from paginas import nombre, N_PAGINAS


def sembradas(src, p):
    out = set()
    ruta = os.path.join(src, nombre(p) + ".entries")
    if os.path.exists(ruta):
        for ln in open(ruta, encoding="utf-8"):
            m = re.match(r"\s*0x([0-9A-Fa-f]{4})", ln)
            if m:
                out.add(int(m.group(1), 16))
    return out


def escribe_lista(work):
    filas = set()
    for p in range(N_PAGINAS):
        ruta = os.path.join(work, nombre(p) + ".trace.json")
        if not os.path.exists(ruta):
            continue
        for a, b in json.load(open(ruta)).get("externos", []):
            if 0x4000 <= b < 0xC000:
                filas.add((p, a, b))
    os.makedirs(os.path.join(work, "omsx"), exist_ok=True)
    with open(os.path.join(work, "omsx", "externos.txt"), "w") as f:
        for p, a, b in sorted(filas):
            f.write("%d %04X %04X\n" % (p, a, b))
    print("%d llamadas fuera de pagina en work/omsx/externos.txt" % len(filas))


def main(work, src, *resto):
    escribe_lista(work)
    if "--solo-lista" in resto:
        return 0
    log = os.path.join(work, "omsx", "bancos.log")
    if not os.path.exists(log):
        print("no hay %s: corre antes tools/omsx_bancos.tcl" % log)
        return 1
    med = {}
    desp = {}   # destinos de tablas de despachador: lineas "DESP pNN:ENTRADA -> DEST  pagina P"
    for ln in open(log):
        m = re.match(r"(DESP )?p(\d+):([0-9A-F]{4}) -> ([0-9A-F]{4})\s+pagina (\d+)", ln)
        if m:
            po, a, b, pd = int(m.group(2)), int(m.group(3), 16), int(m.group(4), 16), int(m.group(5))
            (desp if m.group(1) else med).setdefault(pd, {}).setdefault(b, set()).add((po, a))
    cab_med = ("\n# --- Llamadas desde otras paginas MEDIDAS en el emulador (hecho-verificado):\n"
               "# tools/omsx_bancos.tcl -> work/omsx/bancos.log. Punto de ruptura en cada\n"
               "# origen y lectura del depurable 'romblocks' de openMSX en el destino: en\n"
               "# esa direccion estaba mapeada ESTA pagina.\n")
    cab_desp = ("\n# --- Destinos de tablas de despachador (`call 0x40DA` + tabla) MEDIDOS en el\n"
                "# emulador (hecho-verificado): bp en el `jp (hl)` de 0x40E3; HL = destino,\n"
                "# DE-1 = la entrada de la tabla que lo apuntaba; romblocks en el destino = ESTA pagina.\n")
    for fuente, cab, marca, que in ((med, cab_med, "desde %s (medido)", "semillas nuevas"),
                                    (desp, cab_desp, "entrada de tabla %s (medido, despachador)", "destinos de despachador nuevos")):
        for pd in sorted(fuente):
            ya = sembradas(src, pd)
            # Lo que el trazado de esa pagina ya alcanza por si solo tampoco hace falta sembrarlo
            ruta = os.path.join(work, nombre(pd) + ".trace.json")
            if os.path.exists(ruta):
                ya |= set(json.load(open(ruta)).get("entries", []))
            nuevas = [b for b in sorted(fuente[pd]) if b not in ya]
            if not nuevas:
                continue
            with open(os.path.join(src, nombre(pd) + ".entries"), "a", encoding="utf-8") as f:
                f.write(cab)
                for b in nuevas:
                    orig = " ".join("p%02d:%04X" % (po, a) for po, a in sorted(fuente[pd][b]))
                    f.write(("0x%04X   # " + marca + "\n") % (b, orig))
            print("%s: %d %s: %s" % (nombre(pd), len(nuevas), que, " ".join("%04X" % b for b in nuevas)))
    print("OJO: antes de retrazar, `python3 tools/despachadores.py work src` y declarar las tablas nuevas en .nocode")
    return 0


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
