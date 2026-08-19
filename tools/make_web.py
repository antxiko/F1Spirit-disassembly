#!/usr/bin/env python3
"""Genera la portada de la web, en los dos idiomas.

El diseno es el compartido por la serie (tools/estilo_web.py) y la pagina sale
autocontenida, con las imagenes embebidas como data URI.

Las imagenes no son capturas ni ilustraciones de fuera: tools/imagenes_web.py
pinta los circuitos siguiendo la misma cadena que sigue el cartucho y los
minimapas integrando sus caminos. Si un rango estuviera mal etiquetado,
saldrian a ruido.

Uso: make_web.py <docs/imagenes> <salida.html> <idioma>
"""
import base64
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from estilo_web import ESTILO                                   # noqa: E402

# Las cifras salen de contar sobre el listado, no de escribirlas a ojo:
# 131072 = 30658 + 97347 + 3067, que es lo que imprime tools/presupuesto.py
# descontando de los datos los marcadores de lo que queda por trazar.
CODIGO = 30658
DATOS = 97347
PENDIENTE = 3067
RUTINAS = 964
CIRCUITOS = 21
TOTAL = CODIGO + DATOS + PENDIENTE


def mil(n, idioma):
    return f"{n:,}".replace(",", "." if idioma == "es" else ",")


def pct(idioma):
    v = 100.0 * (CODIGO + DATOS) / TOTAL
    return f"{v:.1f}".replace(".", "," if idioma == "es" else ".") + " %"


def img64(ruta):
    return "data:image/png;base64," + base64.b64encode(open(ruta, "rb").read()).decode()


GALERIA = [
    ("circuito_rally.png",
     "El principio del circuito de RALLY, pintado siguiendo la cadena del "
     "cartucho: la secuencia de piezas, sus metatiles y los tiles de los tres "
     "bancos.",
     "The start of the RALLY track, drawn by following the cartridge's own "
     "chain: the sequence of pieces, their metatiles and the tiles from the "
     "three banks."),
    ("circuito_f1.png",
     "Y el de la quinta carrera del mundial. Cada franja de 32 x 12 tiles es "
     "una pieza de la secuencia.",
     "And the fifth race of the championship. Each 32 x 12 tile band is one "
     "piece of the sequence."),
    ("minimapas.png",
     "Los 21 trazados del minimapa, integrados desde sus caminos de nibbles "
     "con signo. Los 21 cierran: la suma de los desplazamientos es cero en "
     "los dos ejes.",
     "The 21 minimap outlines, integrated from their paths of signed nibbles. "
     "All 21 close: the deltas add up to zero on both axes."),
]

HALLAZGOS = {
    "es": [
        ("La profundidad de la pista son tres dibujos distintos",
         "<p>En SCREEN 2 la tabla de patrones son tres bancos, uno por cada "
         "tercio de la pantalla. F-1 Spirit carga <b>dibujos distintos bajo el "
         "mismo indice</b> en el tercio de arriba y en el de abajo, y de ahi "
         "sale la sensacion de profundidad de la carretera. Los bits 7, 6 y 5 "
         "de los flags del cargador dicen a que tercio va cada tile.</p>"),
        ("Un circuito son cuatro niveles de indireccion",
         "<p>Cada carrera tiene una <b>secuencia</b> de pares (pieza, flags). "
         "Una <b>pieza</b> son 24 bytes: 3 filas de 8 <b>metatiles</b>. Un "
         "metatile son 16 bytes: 4 filas de 4 <b>tiles</b>. Una fila de pieza "
         "ocupa la pantalla de ancho. Los flags no mueven la pista: "
         "<b>rotan</b> la fila de metatiles modulo 8, y esa rotacion, "
         "acumulada de una pieza a la siguiente, es lo que la hace serpentear.</p>"),
        ("Un paso del minimapa son dos piezas de pista",
         "<p>El minimapa no se calcula: son 21 caminos de bytes, dos nibbles "
         "con signo cada uno, que mueven el marcador. Su forma no sale de la "
         "secuencia, pero su longitud si: en las 21 carreras se cumple "
         "<b>pasos = piezas / 2 + 1</b>.</p>"),
        ("Tres partidas grabadas",
         "<p>Hay tres bloques con el mismo formato -pares (mascara de mandos, "
         "cuadros que dura)- que suman 43,6 s, 84 s y 12,5 s. Las mascaras son "
         "combinaciones de los bits de direccion y los dos botones: son "
         "partidas grabadas, lo que el juego se juega solo.</p>"),
    ],
    "en": [
        ("The road's depth is three different drawings",
         "<p>In SCREEN 2 the pattern table is three banks, one per third of "
         "the screen. F-1 Spirit loads <b>different drawings under the same "
         "index</b> in the top third and the bottom one, and that is where the "
         "road's sense of depth comes from. Bits 7, 6 and 5 of the loader's "
         "flags say which third each tile goes to.</p>"),
        ("A track is four levels of indirection",
         "<p>Each race has a <b>sequence</b> of (piece, flags) pairs. A "
         "<b>piece</b> is 24 bytes: 3 rows of 8 <b>metatiles</b>. A metatile is "
         "16 bytes: 4 rows of 4 <b>tiles</b>. One row of a piece fills the "
         "screen's width. The flags do not move the track: they <b>rotate</b> "
         "the row of metatiles modulo 8, and that rotation, accumulated from "
         "one piece to the next, is what makes it wind.</p>"),
        ("One minimap step is two track pieces",
         "<p>The minimap is not computed: it is 21 byte paths, two signed "
         "nibbles each, that move the marker. Its shape does not come from the "
         "sequence, but its length does: across all 21 races, "
         "<b>steps = pieces / 2 + 1</b>.</p>"),
        ("Three recorded games",
         "<p>Three blocks share one format -pairs of (control mask, how many "
         "frames it lasts)- adding up to 43.6 s, 84 s and 12.5 s. The masks are "
         "combinations of the direction bits and the two buttons: they are "
         "recorded games, what the machine plays by itself.</p>"),
    ],
}

TXT = {
    "es": dict(
        titulo="F-1 Spirit (1987) — desensamblado comentado",
        aviso="<b>Aquí no hay ni una captura de pantalla.</b> Los circuitos "
              "están dibujados repitiendo la cadena que sigue el cartucho para "
              "pintarlos, y los minimapas integrando sus caminos. Lo demás —el "
              "listado y las cifras— sale del binario y se reproduce con "
              "<code>make</code>.",
        claim="Un MegaROM de 128 KB de 1987, el primero de la serie con mapper "
              "y chip de sonido SCC. Sus 21 circuitos son listas de piezas que "
              "se pueden reescribir, y hay un editor para hacerlo.",
        ficha=["Konami · <b>1987</b>", "Cartucho <b>RC-752</b>, 128 KB",
               "MSX1 · <b>Konami SCC</b>", "Volcado <b>3b9afd12…</b>"],
        nav=[("#numbers", "Las cifras"), ("#findings", "Hallazgos"),
             ("#screens", "Lo que dibuja")],
        docnav=[("EL-EDITOR.html", "El editor de circuitos"),
                ("../editor.html", "Abrir el editor")],
        otro=("../", "In English"),
        h_num="El juego en cifras", h_find="Lo que aparece al desmontarlo",
        h_scr="Lo que dibuja",
        nota_scr="Ninguna de estas imágenes es una captura: se dibujan desde la "
                 "ROM con <code>tools/imagenes_web.py</code>.",
        pie_leg="La imagen del cartucho no se distribuye: cada cual pone la "
                "suya. F-1 Spirit es de Konami; esto es un estudio del binario.",
        cifras=lambda i: [
            (pct(i), "del binario explicado"),
            (mil(RUTINAS, i), "rutinas identificadas"),
            (str(CIRCUITOS), "circuitos"),
            (mil(CODIGO, i), "bytes de código"),
            (mil(DATOS, i), "bytes de datos"),
            (mil(PENDIENTE, i), "bytes sin identificar"),
        ],
    ),
    "en": dict(
        titulo="F-1 Spirit (1987) — commented disassembly",
        aviso="<b>There is not a single screenshot here.</b> The tracks are "
              "drawn by repeating the chain the cartridge follows to paint "
              "them, and the minimaps by integrating their paths. The rest "
              "—the listing and the numbers— comes out of the binary and is "
              "reproduced with <code>make</code>.",
        claim="A 128 KB MegaROM from 1987, the first in this series with a "
              "mapper and an SCC sound chip. Its 21 tracks are lists of pieces "
              "that can be rewritten, and there is an editor to do it.",
        ficha=["Konami · <b>1987</b>", "Cartridge <b>RC-752</b>, 128 KB",
               "MSX1 · <b>Konami SCC</b>", "Dump <b>3b9afd12…</b>"],
        nav=[("#numbers", "The numbers"), ("#findings", "Findings"),
             ("#screens", "What it draws")],
        docnav=[("THE-EDITOR.html", "The track editor"),
                ("editor.html", "Open the editor")],
        otro=("es/", "En español"),
        h_num="The game in numbers", h_find="What turns up when you take it apart",
        h_scr="What it draws",
        nota_scr="None of these images is a screenshot: they are drawn from the "
                 "ROM by <code>tools/imagenes_web.py</code>.",
        pie_leg="The cartridge image is not distributed: bring your own. "
                "F-1 Spirit belongs to Konami; this is a study of the binary.",
        cifras=lambda i: [
            (pct(i), "of the binary explained"),
            (mil(RUTINAS, i), "routines identified"),
            (str(CIRCUITOS), "tracks"),
            (mil(CODIGO, i), "bytes of code"),
            (mil(DATOS, i), "bytes of data"),
            (mil(PENDIENTE, i), "bytes unidentified"),
        ],
    ),
}


def main(argv):
    if len(argv) < 4:
        print(__doc__)
        return 2
    imgdir, salida, idioma = argv[1:4]
    t = TXT[idioma]

    nav = "".join(f'<a href="{h}">{x}</a>' for h, x in t["nav"])
    nav += "".join(f'<a href="{h}">{x}</a>' for h, x in t["docnav"])
    nav += (f'<a href="{t["otro"][0]}" style="margin-left:auto;color:var(--oro)">'
            f'{t["otro"][1]}</a>')

    cifras = "".join(f'<div class="cifra"><b>{v}</b><span>{e}</span></div>'
                     for v, e in t["cifras"](idioma))
    halls = "".join(f'<div class="hall"><h3>{tit}</h3>{cuerpo}</div>'
                    for tit, cuerpo in HALLAZGOS[idioma])

    imgs, faltan = "", []
    for fich, es, en in GALERIA:
        ruta = os.path.join(imgdir, fich)
        if not os.path.exists(ruta):
            faltan.append(fich)
            continue
        pie = es if idioma == "es" else en
        imgs += (f'<figure><img src="{img64(ruta)}" alt="{pie}">'
                 f'<figcaption>{pie}</figcaption></figure>')
    if faltan:
        print("  (faltan %d imagenes: %s)" % (len(faltan), " ".join(faltan)))

    html = f"""<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>{t['titulo']}</title>
<style>{ESTILO}</style>
<header class="top">
  <h1>F-1 Spirit (1987)</h1>
  <p class="claim">{t['claim']}</p>
  <p class="ficha">{' · '.join(t['ficha'])}</p>
</header>
<p class="ficha" style="border:1px solid var(--oro);padding:.8em 1em;margin:1.5em 0">
{t['aviso']}</p>
<nav>{nav}</nav>
<section id="numbers">
  <h2>{t['h_num']}</h2>
  <div class="cifras">{cifras}</div>
</section>
<section id="findings"><h2>{t['h_find']}</h2>{halls}</section>
<section id="screens">
  <h2>{t['h_scr']}</h2>
  <p class="n">{t['nota_scr']}</p>
  <div class="galeria">{imgs}</div>
</section>
<footer><p>{t['pie_leg']}</p></footer>
"""
    with open(salida, "w", encoding="utf-8") as f:
        f.write(html)
    print("  %s: %d KB (%s)" % (salida, len(html) // 1024, idioma))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
