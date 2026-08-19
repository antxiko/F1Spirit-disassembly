#!/usr/bin/env python3
"""Las llamadas y saltos que cada pagina hace FUERA de si misma.

En un MegaROM trazado pagina a pagina, el trazador no puede seguir un `call
0x6000` que sale de la pagina 0: en 0x6000 puede estar la pagina 1, la 4, la
7, la 10 o la 13, segun lo que el codigo haya escrito antes en 0x7000. Este
programa recoge esas llamadas de los trazados (z80trace las guarda como
"externos": origen y destino), las agrupa por destino, dice en que paginas
PODRIA estar ese destino y si alguna ya lo tiene sembrado.

No siembra nada solo. Resolver cada una exige saber que pagina estaba mapeada
en ese momento -lo dice el `ld a,N / call rutina_de_banco` anterior, o hay que
medirlo en el emulador-, y esa justificacion va escrita en el .entries.

Uso: externos.py <dir_work> <dir_src> [--solo-sin-resolver]
"""
import json
import os
import re
import sys

from paginas import org, nombre, N_PAGINAS, TAM_PAGINA

BIOS_TOPE = 0x4000
RAM_BASE = 0xC000


def paginas_en(addr):
    """Las paginas que el mapper puede poner en la ranura de esa direccion."""
    return [p for p in range(N_PAGINAS) if org(p) <= addr < org(p) + TAM_PAGINA]


def sembradas(src, p):
    out = set()
    ruta = os.path.join(src, nombre(p) + ".entries")
    if not os.path.exists(ruta):
        return out
    for ln in open(ruta, encoding="utf-8"):
        m = re.match(r"\s*0x([0-9A-Fa-f]{4})", ln)
        if m:
            out.add(int(m.group(1), 16))
    return out


def main(work, src, *resto):
    solo_sin = "--solo-sin-resolver" in resto
    por_destino = {}
    for p in range(N_PAGINAS):
        ruta = os.path.join(work, nombre(p) + ".trace.json")
        if not os.path.exists(ruta):
            continue
        for a, b in json.load(open(ruta)).get("externos", []):
            por_destino.setdefault(b, []).append((p, a))

    # "Resuelto" = sembrado en el .entries de una candidata, o ya alcanzado
    # por su trazado (el trazador lo marco como entrada por si solo).
    semb = {p: sembradas(src, p) for p in range(N_PAGINAS)}
    for p in range(N_PAGINAS):
        ruta = os.path.join(work, nombre(p) + ".trace.json")
        if os.path.exists(ruta):
            semb[p].update(json.load(open(ruta)).get("entries", []))
    bios = {b: v for b, v in por_destino.items() if b < BIOS_TOPE}
    ram = {b: v for b, v in por_destino.items() if b >= RAM_BASE}
    rom = {b: v for b, v in por_destino.items() if BIOS_TOPE <= b < RAM_BASE}

    print("destinos fuera de su pagina: %d (BIOS %d, RAM %d, otras paginas %d)" % (
        len(por_destino), len(bios), len(ram), len(rom)))
    if ram:
        print("\nA RAM (codigo copiado a memoria o gancho; hay que mirarlo):")
        for b in sorted(ram):
            print("  %04X  <- %s" % (b, " ".join("%s:%04X" % (nombre(p), a) for p, a in ram[b][:8])))

    print("\nA otras paginas, por destino (candidatas: las paginas cuya ranura es esa):")
    n_sin = 0
    for b in sorted(rom):
        cands = paginas_en(b)
        ya = [p for p in cands if b in semb[p]]
        if solo_sin and ya:
            continue
        if not ya:
            n_sin += 1
        origenes = sorted(set(rom[b]))
        print("  %04X  candidatas %-16s %s  <- %s%s" % (
            b, "/".join(nombre(p) for p in cands),
            ("resuelta en " + "/".join(nombre(p) for p in ya)) if ya else "SIN RESOLVER",
            " ".join("%s:%04X" % (nombre(p), a) for p, a in origenes[:6]),
            " ..." if len(origenes) > 6 else ""))
    print("\n%d destinos en otras paginas sin resolver" % n_sin)
    return 0


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
