#!/usr/bin/env python3
"""Comprobaciones sobre los listados generados, las 16 paginas a la vez.

Ninguna necesita el cartucho: se hacen sobre src/f1spirit_pNN.asm y
src/pNN.notes, que van en el repositorio. Lo que vigilan es que el listado
no se degrade sin que nadie se entere: que no desaparezcan comentarios, que
no vuelvan a aparecer bloques de datos sin identificar, que lo pendiente de
trazar solo baje, y que la regla pagina -> org del Makefile sea la de
tools/paginas.py.
"""
import os
import subprocess
import tempfile
import shutil
import re
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
from paginas import org, nombre, N_PAGINAS, TAM_PAGINA  # noqa: E402

# Bytes dentro de marcadores `pendiente_de_trazar` cuando se escribio este
# test. La cifra solo puede bajar: si sube es que se ha perdido trazado o
# alguna explicacion por el camino.
PENDIENTE_MAX = 504


def asm(p):
    with open(os.path.join(RAIZ, "src", "f1spirit_%s.asm" % nombre(p)), encoding="utf-8") as f:
        return f.read()


def notas(p):
    with open(os.path.join(RAIZ, "src", "%s.notes" % nombre(p)), encoding="utf-8") as f:
        return f.read().splitlines()


def directivas(p, clave):
    return [l for l in notas(p) if l.startswith(clave + " ")]


def rangos(p):
    out = []
    for l in directivas(p, "D"):
        c = l.split(None, 4)
        out.append((int(c[1], 0), int(c[2], 0), c[3], c[4] if len(c) > 4 else ""))
    return out


class TestListado(unittest.TestCase):

    def test_hay_un_listado_por_pagina(self):
        for p in range(N_PAGINAS):
            ruta = os.path.join(RAIZ, "src", "f1spirit_%s.asm" % nombre(p))
            self.assertTrue(os.path.exists(ruta), "falta %s" % ruta)

    def test_cada_listado_lleva_el_org_de_su_pagina(self):
        for p in range(N_PAGINAS):
            m = re.search(r"^\torg (0x[0-9a-f]+)", asm(p), re.M)
            self.assertIsNotNone(m, "la pagina %d no tiene org" % p)
            self.assertEqual(int(m.group(1), 16), org(p),
                             "pagina %d: org %s, esperado %#06x" % (p, m.group(1), org(p)))

    def test_la_tabla_de_orgs_del_makefile_es_la_de_paginas_py(self):
        """El Makefile lleva la tabla copiada para no lanzar python 32 veces."""
        mk = open(os.path.join(RAIZ, "Makefile"), encoding="utf-8").read()
        for p in range(N_PAGINAS):
            m = re.search(r"^ORG_%02d\s*=\s*(0x[0-9a-fA-F]+)" % p, mk, re.M)
            self.assertIsNotNone(m, "el Makefile no define ORG_%02d" % p)
            self.assertEqual(int(m.group(1), 16), org(p), "ORG_%02d no coincide" % p)

    def test_ningun_bloque_de_datos_sin_identificar(self):
        """Cada zona de datos tiene que tener nombre (aunque sea un marcador)."""
        for p in range(N_PAGINAS):
            n = asm(p).count("DATOS sin identificar")
            self.assertEqual(n, 0, "pagina %d: %d bloques sin identificar" % (p, n))

    def test_lo_pendiente_de_trazar_solo_baja(self):
        total = 0
        for p in range(N_PAGINAS):
            for a, b, nm, _ in rangos(p):
                if nm == "pendiente_de_trazar":
                    total += b - a
        self.assertLessEqual(total, PENDIENTE_MAX,
                             "hay %d bytes pendientes, antes %d" % (total, PENDIENTE_MAX))

    def test_todas_las_rutinas_con_call_tienen_nombre_en_las_paginas_comentadas(self):
        """Solo se exige en las paginas que ya tienen notas con etiquetas."""
        for p in range(N_PAGINAS):
            if not directivas(p, "L"):
                continue
            sueltas = sorted(set(re.findall(
                r"\bcall (?:n?[zc],|p[oe],|[mp],)?(L_[0-9A-F]{4})", asm(p))))
            # En el arranque aun no se han bautizado todas: se vigila que la
            # cifra no crezca, y se apunta cuantas quedan por pagina.
            self.assertLessEqual(len(sueltas), SUELTAS_MAX.get(p, 0),
                                 "pagina %d: %d rutinas llamadas sin nombre (%s)"
                                 % (p, len(sueltas), " ".join(sueltas[:8])))

    def test_ninguna_etiqueta_declarada_dos_veces(self):
        for p in range(N_PAGINAS):
            nombres = re.findall(r"^([A-Za-z_][\w]*):", asm(p), re.M)
            repetidas = sorted({n for n in nombres if nombres.count(n) > 1})
            self.assertEqual(repetidas, [], "pagina %d: etiquetas repetidas %s"
                             % (p, " ".join(repetidas)))

    def test_ningun_comentario_de_linea_repetido(self):
        for p in range(N_PAGINAS):
            dirs = [l.split()[1].upper() for l in directivas(p, "C")]
            repes = sorted({d for d in dirs if dirs.count(d) > 1})
            self.assertEqual(repes, [], "pagina %d: C repetidos en %s" % (p, " ".join(repes)))

    def test_ninguna_direccion_bautizada_dos_veces(self):
        for p in range(N_PAGINAS):
            dirs = [l.split()[1].upper() for l in directivas(p, "L")]
            repes = sorted({d for d in dirs if dirs.count(d) > 1})
            self.assertEqual(repes, [], "pagina %d: dos nombres para %s" % (p, " ".join(repes)))

    def test_todos_los_comentarios_llegan_al_listado(self):
        for p in range(N_PAGINAS):
            texto = asm(p)
            for l in directivas(p, "C"):
                c = l.split(None, 2)
                self.assertIn(c[2].strip()[:40], texto,
                              "pagina %d: el comentario de %s no esta en el listado" % (p, c[1]))

    def test_todas_las_etiquetas_llegan_al_listado(self):
        for p in range(N_PAGINAS):
            texto = asm(p)
            for l in directivas(p, "L"):
                nm = l.split()[2]
                self.assertRegex(texto, r"(?m)^%s:" % re.escape(nm),
                                 "pagina %d: la etiqueta %s no se define" % (p, nm))

    def test_los_rangos_no_se_solapan(self):
        for p in range(N_PAGINAS):
            rs = sorted(rangos(p))
            for (a, b, n1, _), (c, d, n2, _) in zip(rs, rs[1:]):
                self.assertLessEqual(b, c, "pagina %d: %s (%#06x-%#06x) pisa a %s (%#06x)"
                                     % (p, n1, a, b, n2, c))

    def test_todos_los_rangos_van_al_derecho_y_dentro(self):
        for p in range(N_PAGINAS):
            for a, b, nm, _ in rangos(p):
                self.assertLess(a, b, "pagina %d: %s al reves" % (p, nm))
                self.assertGreaterEqual(a, org(p), "pagina %d: %s empieza antes del org" % (p, nm))
                self.assertLessEqual(b, org(p) + TAM_PAGINA, "pagina %d: %s se sale" % (p, nm))

    def test_todos_los_rangos_estan_explicados(self):
        for p in range(N_PAGINAS):
            for a, b, nm, desc in rangos(p):
                self.assertTrue(desc.strip(), "pagina %d: %s sin explicacion" % (p, nm))

    def test_el_listado_lo_genera_la_herramienta(self):
        for p in range(N_PAGINAS):
            self.assertIn("Generado por tools/mkasm.py", asm(p))

    def test_las_paginas_van_seguidas_en_el_listado(self):
        """Cada pagina son 8192 bytes: el ultimo byte emitido es org+0x1FFF."""
        for p in range(N_PAGINAS):
            # Sin \s: consumiria el salto de linea y leeria el "defb" de la
            # linea siguiente como una direccion (0xDEFB). Y solo las
            # direcciones que pone mkasm (";4bce" al final de la instruccion,
            # "; 4c37  " en los volcados): un comentario que empiece por una
            # palabra de cuatro letras hexadecimales ("; cada fotograma") no
            # es una direccion.
            ultimas = re.findall(r";[ \t]?([0-9a-f]{4})(?=\s{2,}|\s*$)", asm(p), re.M)
            self.assertTrue(ultimas, "pagina %d sin direcciones" % p)
            self.assertLess(max(int(x, 16) for x in ultimas), org(p) + TAM_PAGINA)

    def test_el_listado_no_habla_de_otro_juego(self):
        otros = ("Monkey", "Athletic", "Pitfall", "Antarctic", "Stardust",
                 "Temptations", "Ale Hop", "Colt 36", "Middle Earth")
        for p in range(N_PAGINAS):
            texto = asm(p) + "\n".join(notas(p))
            for o in otros:
                self.assertNotIn(o, texto, "la pagina %d nombra a %s" % (p, o))


def bloques_de(herramienta):
    """Los bloques que dice una herramienta de lectura de datos: [(pagina, ini, fin, nombre)].
    None si no esta la ROM (las herramientas la necesitan)."""
    import subprocess
    rom = os.path.join(RAIZ, "f1spirit.rom")
    if not os.path.exists(rom):
        return None
    out = subprocess.run([sys.executable, os.path.join(RAIZ, "tools", herramienta), rom, "--bloques"],
                         capture_output=True, text=True, cwd=RAIZ)
    if out.returncode != 0:
        raise AssertionError("%s sale con %d: %s %s" % (herramienta, out.returncode, out.stdout[-1500:], out.stderr[-1500:]))
    bl = []
    for ln in out.stdout.splitlines():
        c = ln.split()
        if len(c) == 4 and c[0].startswith("p"):
            bl.append((int(c[0][1:]), int(c[1], 0), int(c[2], 0), c[3]))
    return bl


class TestDatosContraHerramientas(unittest.TestCase):
    """Las D de las paginas de datos no se escriben de oido: cada bloque que
    tools/graficos.py, circuitos.py, textos.py, sonido.py y coches.py leen desde la ROM tiene que estar
    cubierto por un rango D con nombre (no por un marcador pendiente) en las
    notas de su pagina; y ninguna D con nombre puede empezar DENTRO de un
    bloque de la herramienta (serian dos lecturas distintas del mismo byte)."""

    def _comprueba(self, herramienta):
        bl = bloques_de(herramienta)
        if bl is None:
            self.skipTest("sin f1spirit.rom no se puede correr " + herramienta)
        self.assertTrue(bl, herramienta + " no devuelve bloques")
        por_pag = {}
        for p, a, b, nm in bl:
            por_pag.setdefault(p, []).append((a, b, nm))
        for p, lista in por_pag.items():
            ds = [(a, b, nm) for a, b, nm, _ in rangos(p) if nm != "pendiente_de_trazar"]
            for a, b, nm in lista:
                cubre = [d for d in ds if d[0] <= a and b <= d[1]]
                self.assertTrue(cubre, "pagina %d: el bloque %#06x-%#06x (%s) de %s no esta en las notas"
                                % (p, a, b, nm, herramienta))
            for a, b, nm in ds:
                for x, y, hn in lista:
                    self.assertFalse(x < a < y, "pagina %d: la D %s (%#06x) parte el bloque %s %#06x-%#06x de %s"
                                     % (p, nm, a, hn, x, y, herramienta))

    def test_graficos_py_y_las_notas_dicen_lo_mismo(self):
        self._comprueba("graficos.py")

    def test_circuitos_py_y_las_notas_dicen_lo_mismo(self):
        self._comprueba("circuitos.py")

    def test_textos_py_y_las_notas_dicen_lo_mismo(self):
        self._comprueba("textos.py")

    def test_sonido_py_y_las_notas_dicen_lo_mismo(self):
        self._comprueba("sonido.py")

    def test_coches_py_y_las_notas_dicen_lo_mismo(self):
        self._comprueba("coches.py")


# Rutinas llamadas con CALL y aun sin bautizar, por pagina, al escribir este
# test. Solo pueden bajar. p03: 103 el 2026-08-19 (es la logica de carrera,
# por bautizar; antes el tope era 77 y el test estaba rojo a proposito).
SUELTAS_MAX = {0: 104, 13: 12, 3: 103, 15: 0}


class TestParcheCircuitos(unittest.TestCase):
    """tools/parchea_circuitos.py: lo que exporta el editor de circuitos.

    La zona de las 21 secuencias esta LLENA (5917 de 5917 bytes), asi que el
    editor no puede anadir una pieza sin quitar otra; y un parche vacio tiene
    que devolver la ROM identica, o la aritmetica de offsets esta mal.
    """

    @classmethod
    def setUpClass(cls):
        sys.path.insert(0, os.path.join(RAIZ, "tools"))
        import parchea_circuitos
        cls.pc = parchea_circuitos
        cls.rom = open(os.path.join(RAIZ, "f1spirit.rom"), "rb").read()

    def test_sin_cambios_la_rom_sale_identica(self):
        nueva, total, fin = self.pc.parchea(self.rom, {})
        self.assertEqual(nueva, self.rom, "un parche vacio ha cambiado la ROM")
        self.assertEqual(total, self.pc.FIN_ZONA - self.pc.INI_ZONA)
        self.assertEqual(fin, self.pc.FIN_ZONA)

    def test_quitar_una_pieza_deja_un_byte_libre_y_mueve_las_siguientes(self):
        filas = self.pc.lee_secuencias(self.rom)
        i, addr, pares = filas[0]          # la primera en memoria (RALLY)
        nueva, total, fin = self.pc.parchea(self.rom, {i: pares[:-1]})
        self.assertEqual(total, self.pc.FIN_ZONA - self.pc.INI_ZONA - 2)
        # la tabla de punteros de las siguientes se ha recolocado 2 bytes antes
        sig_i = filas[1][0]
        off = self.pc.offset(self.pc.TABLA + 2 * sig_i)
        antes = self.rom[off] | (self.rom[off + 1] << 8)
        ahora = nueva[off] | (nueva[off + 1] << 8)
        self.assertEqual(ahora, antes - 2)

    def test_si_no_cabe_se_rechaza(self):
        filas = self.pc.lee_secuencias(self.rom)
        i, _, pares = filas[0]
        with self.assertRaises(ValueError):
            self.pc.parchea(self.rom, {i: pares + [[0, 0x40]]})


class TestParcheMinimapas(unittest.TestCase):
    """tools/parchea_minimapas.py: los caminos del minimapa (p06 0xB22E-0xB805,
    1495 B LLENOS) y su tabla de punteros p01 0x7753."""

    @classmethod
    def setUpClass(cls):
        sys.path.insert(0, os.path.join(RAIZ, "tools"))
        import parchea_minimapas
        cls.pm = parchea_minimapas
        cls.rom = open(os.path.join(RAIZ, "f1spirit.rom"), "rb").read()

    def test_sin_cambios_la_rom_sale_identica(self):
        nueva, total, fin = self.pm.parchea(self.rom, {})
        self.assertEqual(nueva, self.rom)
        self.assertEqual(total, self.pm.FIN_ZONA - self.pm.INI_ZONA)
        self.assertEqual(fin, self.pm.FIN_ZONA)

    def test_los_21_trazados_cierran(self):
        for i, _, pasos, _ in self.pm.lee_caminos(self.rom):
            self.assertTrue(self.pm.cierra(pasos),
                            "el camino de la carrera %d no cierra" % i)

    def test_un_trazado_que_no_cierra_se_rechaza(self):
        filas = self.pm.lee_caminos(self.rom)
        i, _, pasos, _ = filas[0]
        roto = [p[:] for p in pasos]
        roto[0][0] += 1
        with self.assertRaises(ValueError):
            self.pm.parchea(self.rom, {i: roto})

    def test_mover_un_vertice_conserva_el_cierre_y_los_bytes(self):
        # mover un vertice = tocar los DOS pasos que lo rodean, sin cambiar la suma
        filas = self.pm.lee_caminos(self.rom)
        i, _, pasos, _ = filas[0]
        nuevo = [p[:] for p in pasos]
        if nuevo[0][0] < 7 and nuevo[1][0] > -7:
            nuevo[0][0] += 1
            nuevo[1][0] -= 1
        self.assertTrue(self.pm.cierra(nuevo))
        nueva, total, _ = self.pm.parchea(self.rom, {i: nuevo})
        self.assertEqual(total, self.pm.FIN_ZONA - self.pm.INI_ZONA)
        self.assertNotEqual(nueva, self.rom)


class TestEditorHTML(unittest.TestCase):
    """El editor generado (tools/editor/circuitos.html) se ejecuta con node y
    su exportacion tiene que coincidir con parchea_circuitos.py. Si no hay node
    o no esta generado el HTML, el test se salta."""

    HTML = os.path.join(RAIZ, "tools", "editor", "circuitos.html")

    def setUp(self):
        if not shutil.which("node"):
            self.skipTest("no hay node")
        if not os.path.exists(self.HTML):
            self.skipTest("falta %s (generalo con tools/haz_editor.py)" % self.HTML)

    def test_la_exportacion_del_editor_coincide_con_la_herramienta(self):
        import re
        html = open(self.HTML, encoding="utf-8").read()
        js = re.search(r"<script>(.*)</script>", html, re.S).group(1)
        js += chr(10) + "globalThis.__t = {romParcheada, pares, editado, DATOS};" + chr(10)
        tmp = tempfile.mkdtemp()
        try:
            ruta = os.path.join(tmp, "editor.js")
            open(ruta, "w", encoding="utf-8").write(js)
            editada = os.path.join(tmp, "editada.rom")
            rom = os.path.join(RAIZ, "f1spirit.rom")
            out = subprocess.run(["node", os.path.join(RAIZ, "tests", "arnes_editor.js"),
                                  ruta, rom, editada],
                                 capture_output=True, text=True, cwd=RAIZ)
            self.assertEqual(out.returncode, 0, out.stdout + out.stderr)

            # el mismo cambio por python tiene que dar la misma ROM
            sys.path.insert(0, os.path.join(RAIZ, "tools"))
            import parchea_circuitos as P
            bruto = open(rom, "rb").read()
            pares = next(f[2] for f in P.lee_secuencias(bruto) if f[0] == 0)
            nueva, _, _ = P.parchea(bruto, {0: pares[:-1]})
            self.assertEqual(nueva, open(editada, "rb").read(),
                             "el editor y parchea_circuitos.py escriben ROMs distintas")
        finally:
            shutil.rmtree(tmp, ignore_errors=True)


class TestEditorPortable(unittest.TestCase):
    """El editor PORTABLE (tools/editor/circuitos_portable.html) no lleva la ROM
    ni sus datos dentro: los lee del fichero que le den. Se comprueba que su
    lector saca lo mismo que exporta_circuitos.py y que su exportacion sigue
    devolviendo la ROM intacta."""

    HTML = os.path.join(RAIZ, "tools", "editor", "circuitos_portable.html")

    def setUp(self):
        if not shutil.which("node"):
            self.skipTest("no hay node")
        if not os.path.exists(self.HTML):
            self.skipTest("falta %s (generalo con haz_editor.py --portable)" % self.HTML)

    def test_el_lector_del_portable_coincide_con_la_herramienta(self):
        import re
        html = open(self.HTML, encoding="utf-8").read()
        self.assertNotIn("ROM_B64 = \"", html, "el portable no puede llevar la ROM dentro")
        js = re.search(r"<script>(.*)</script>", html, re.S).group(1)
        js += chr(10) + ("globalThis.__p = {leeROM, romParcheada, arranca, "
                         "pon: (d, b) => { DATOS = d; ROM_B64 = b; }};") + chr(10)
        tmp = tempfile.mkdtemp()
        try:
            ruta = os.path.join(tmp, "port.js")
            open(ruta, "w", encoding="utf-8").write(js)
            json_py = os.path.join(RAIZ, "work", "circuitos.json")
            args = ["node", os.path.join(RAIZ, "tests", "arnes_portable.js"),
                    ruta, os.path.join(RAIZ, "f1spirit.rom")]
            if os.path.exists(json_py):
                args.append(json_py)
            out = subprocess.run(args, capture_output=True, text=True, cwd=RAIZ)
            self.assertEqual(out.returncode, 0, out.stdout + out.stderr)
        finally:
            shutil.rmtree(tmp, ignore_errors=True)


if __name__ == "__main__":
    unittest.main()
