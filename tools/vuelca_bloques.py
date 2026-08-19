#!/usr/bin/env python3
"""Vuelca a las notas de cada pagina los bloques que identifican las herramientas
de lectura de datos (graficos.py, circuitos.py, textos.py, sonido.py), cada una en su
seccion delimitada, que se reescribe entera cada vez (como hace huecos.py con
los marcadores pendientes). Lo que este fuera de las secciones se respeta.

Las D de esas secciones no se escriben de oido: las herramientas recorren la
ROM como lo hace el codigo y comprueban que cuadra, y tests/test_listado.py
(TestDatosContraHerramientas) vigila que las notas y las herramientas digan lo
mismo. Para corregir un nombre o una descripcion se toca la herramienta y se
vuelve a volcar, no la nota.

Uso: vuelca_bloques.py <rom> <dir_src>        (y luego huecos.py)
"""
import os
import re
import subprocess
import sys

HERRAMIENTAS = [
    ("graficos.py", [
        "los recorre desde la ROM como hace el cargador de la pagina 0 y los",
        "verifica: RLE que termina, patrones y colores de la misma longitud,",
        "alineacion de los fotogramas"]),
    ("circuitos.py", [
        "la cadena secuencia -> piezas -> metatiles de la pagina 0 y los objetos",
        "de la pista, recorridos desde la ROM; los tamanos de las tablas salen del",
        "indice maximo que usa cada carrera y cada tabla acaba donde empieza la",
        "siguiente"]),
    ("textos.py", [
        "los textos (ASCII + macros de la tabla 0xA6DE) y las pantallas",
        "comprimidas (RLE_A_RAM de p01 0x637A), leidos desde la ROM"]),
    ("sonido.py", [
        "las cabeceras de los 70 sonidos, las envolventes, las formas de onda del",
        "SCC y el COMIENZO de cada pista; el final de cada pista es donde empieza",
        "la siguiente, no lo dice ningun byte: falta el lector de la partitura"]),
    ("coches.py", [
        "la cadena de la eleccion de coche: los coches predefinidos, las listas",
        "de valores por categoria y paso, las tablas por carroceria y motor y las",
        "curvas de par, cruzadas unas con otras (los valores elegibles tienen que",
        "ser exactamente los indices que las tablas admiten)"]),
]
PENDIENTE = "# --- PENDIENTE DE TRAZAR"


def seccion(h, lineas_banner, cuerpo):
    out = ["# --- BLOQUES IDENTIFICADOS POR tools/%s (%s" % (h, lineas_banner[0])]
    for ln in lineas_banner[1:]:
        out.append("# " + ln)
    out[-1] += "). No editar a mano: ---"
    out.append("# --- los reescribe tools/vuelca_bloques.py ---")
    out += cuerpo
    out.append("# --- fin de los bloques de %s ---" % h)
    return out


def main(rom, src):
    aqui = os.path.dirname(os.path.abspath(__file__))
    por_pagina = {}
    for h, banner in HERRAMIENTAS:
        out = subprocess.run([sys.executable, os.path.join(aqui, h), rom, "--notas"],
                             capture_output=True, text=True)
        if out.returncode != 0:
            sys.exit("%s sale con %d:\n%s%s" % (h, out.returncode, out.stdout[-1500:], out.stderr[-1500:]))
        cur = None
        for ln in out.stdout.splitlines():
            m = re.match(r"# --- p(\d\d) ---", ln)
            if m:
                cur = int(m.group(1))
                continue
            if cur is not None and (ln.startswith("D ") or ln.startswith("F ")):
                por_pagina.setdefault(cur, {}).setdefault(h, []).append(ln)
    for p in sorted(por_pagina):
        if p == 0:
            continue   # las de la pagina 0 se escriben a mano junto al codigo
        ruta = os.path.join(src, "p%02d.notes" % p)
        t = open(ruta, encoding="utf-8").read().splitlines()
        # quitar las secciones anteriores de cualquier herramienta
        nuevas, dentro = [], False
        for ln in t:
            if ln.startswith("# --- BLOQUES IDENTIFICADOS POR tools/"):
                dentro = True
                continue
            if dentro and ln.startswith("# --- fin de los bloques de "):
                dentro = False
                continue
            if dentro:
                continue
            nuevas.append(ln)
        # quitar lineas en blanco sobrantes justo antes de la seccion pendiente
        bloque = []
        for h, banner in HERRAMIENTAS:
            if h in por_pagina[p]:
                bloque += [""] + seccion(h, banner, por_pagina[p][h])
        try:
            i = next(k for k, ln in enumerate(nuevas) if ln.startswith(PENDIENTE))
        except StopIteration:
            i = len(nuevas)
        while i > 0 and not nuevas[i - 1].strip():
            i -= 1
        nuevas = nuevas[:i] + bloque + [""] + nuevas[i:]
        open(ruta, "w", encoding="utf-8").write("\n".join(nuevas).rstrip("\n") + "\n")
        print("p%02d: %s" % (p, ", ".join("%s %d" % (h, len(v) // 2) for h, v in por_pagina[p].items())))


if __name__ == "__main__":
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    main(sys.argv[1], sys.argv[2])
