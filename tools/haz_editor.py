#!/usr/bin/env python3
"""Genera el visor/editor de circuitos como UN HTML autocontenido.

tools/editor/plantilla.html lleva la interfaz y un marcador `/*DATOS*/` donde
va, incrustado, el JSON que produce tools/exporta_circuitos.py. Se incrusta (y
no se carga con fetch) porque el HTML tiene que abrirse con doble clic desde el
disco, y ahi el navegador prohibe leer ficheros de al lado.

Uso:
    haz_editor.py <rom> [salida.html]      (por defecto tools/editor/circuitos.html)

Sale con 1 si la plantilla no tiene el marcador o si el JSON no se puede leer.
"""
import base64
import json
import os
import subprocess
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
PLANTILLA = os.path.join(AQUI, "editor", "plantilla.html")
MARCADOR = "/*DATOS*/"
MARCADOR_ROM = "/*ROM*/"
MARCADOR_LECTOR = "/*LECTOR*/"
LECTOR = os.path.join(AQUI, "editor", "lector.js")


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    rom = argv[1]
    # --portable: el HTML sale SIN la ROM y sin sus datos, y pide al abrirlo que
    # se cargue una; asi se puede repartir sin repartir el juego. Los datos los
    # saca en el navegador tools/editor/lector.js, que hace lo mismo que
    # exporta_circuitos.py (y un test lo comprueba con node).
    portable = "--portable" in argv
    argv = [a for a in argv if a != "--portable"]
    salida = argv[2] if len(argv) > 2 else os.path.join(
        AQUI, "editor", "circuitos_portable.html" if portable else "circuitos.html")
    tmp = os.path.join("work", "circuitos.json")

    # exporta_circuitos.py sale con 1 mientras haya tiles que ninguna lista
    # carga: es un aviso conocido, no un error, y el visor los pinta en rosa.
    r = subprocess.run([sys.executable, os.path.join(AQUI, "exporta_circuitos.py"), rom, tmp],
                       capture_output=True, text=True)
    avisos = [l for l in r.stdout.splitlines() if l.startswith("AVISO")]
    if not os.path.exists(tmp):
        print(r.stdout[-2000:], r.stderr[-2000:])
        return 1

    datos = open(tmp, encoding="utf-8").read()
    plantilla = open(PLANTILLA, encoding="utf-8").read()
    if MARCADOR not in plantilla:
        print("ERROR: %s no tiene el marcador %s" % (PLANTILLA, MARCADOR))
        return 1

    if portable:
        html = plantilla.replace(MARCADOR, "null").replace(MARCADOR_ROM, "null")
        html = html.replace(MARCADOR_LECTOR, open(LECTOR, encoding="utf-8").read())
        os.makedirs(os.path.dirname(os.path.abspath(salida)), exist_ok=True)
        open(salida, "w", encoding="utf-8", newline=chr(10)).write(html)
        print("%s: %d KB, PORTABLE (sin ROM ni datos dentro: los lee del fichero "
              "que cargue quien lo abra)" % (salida, len(html) // 1024))
        return 0

    html = plantilla.replace(MARCADOR, datos).replace(MARCADOR_LECTOR, "")
    if MARCADOR_ROM in html:
        # la ROM entera en base64 (175 KB): sin ella el editor no puede
        # ofrecer la ROM parcheada, que es lo que se lleva al emulador
        b64 = base64.b64encode(open(rom, "rb").read()).decode("ascii")
        html = html.replace(MARCADOR_ROM, '"%s"' % b64)
    os.makedirs(os.path.dirname(os.path.abspath(salida)), exist_ok=True)
    open(salida, "w", encoding="utf-8", newline="\n").write(html)

    d = json.loads(datos)
    sin_cargar = sorted({t for v in d["tiles_sin_cargar"].values() for t in v})
    print("%s: %d KB, %d carreras, %d tablas de piezas, %d de metatiles"
          % (salida, len(html) // 1024, len(d["carreras"]),
             len(d["piezas"]), len(d["metatiles"])))
    if sin_cargar:
        print("  OJO: %d tiles que ninguna lista de carga explica (se pintan en rosa): %s"
              % (len(sin_cargar), " ".join("%02X" % t for t in sin_cargar[:16]) +
                 (" ..." if len(sin_cargar) > 16 else "")))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
