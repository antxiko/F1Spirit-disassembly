#!/usr/bin/env python3
"""Escribe en la ROM las secuencias de circuito editadas y regenera la tabla
de punteros. Es la mitad de confianza del editor HTML: el navegador puede
descargar la ROM parcheada, pero quien manda -y lo que los tests comprueban-
es esta herramienta.

LA ZONA ES CERRADA (comprobado 2026-08-19 contra la ROM y las notas):
  - la tabla de 21 punteros esta en p07 0x6000-0x602A (42 B);
  - las 21 secuencias van CONTIGUAS de 0x602A a 0x7747 = 5917 bytes, en un
    orden que NO es 0..20 (empiezan RALLY, ENDURANCE, F3000, F3, STOCK...);
  - detras de 0x7747 hay graficos (rle_pat_7747), asi que la zona no puede
    crecer: si el total pasa de 5917 bytes, el parche se rechaza.
Cada secuencia son pares (pieza, flags) y un 0xFF final: 2n+1 bytes.

El parche es un JSON {"carreras": [{"i": 0, "pares": [[pieza, flags], ...]}]}
con las carreras que se hayan tocado; las que no aparezcan se copian de la ROM
tal cual. El orden en memoria se conserva (el de la ROM original), asi que un
parche vacio tiene que devolver la ROM identica: eso es lo que comprueba
tests/test_listado.py (TestParcheCircuitos).

Uso:
    parchea_circuitos.py <rom> <parche.json> <salida.rom>
    parchea_circuitos.py <rom> --nada <salida.rom>    viaje redondo, sin tocar
Sale con 1 si el parche no cabe o si algun dato no es valido.
"""
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import circuitos

PAGINA_SEC = 7          # las secuencias se leen con 7/8/9: p07 en 0x6000
TABLA = 0x6000          # 21 punteros
INI_ZONA = 0x602A       # donde empieza la primera secuencia
FIN_ZONA = 0x7747       # donde empiezan los graficos de detras
N = 21


def offset(addr):
    """Byte de la ROM en el que cae addr leida con la pagina 7 en 0x6000."""
    return PAGINA_SEC * 0x2000 + (addr - 0x6000)


def lee_secuencias(rom):
    """[(i, addr, pares)] en el ORDEN EN QUE ESTAN EN LA ROM."""
    circuitos.ROM = rom
    fuera = []
    for i in range(N):
        a = circuitos.palabra(PAGINA_SEC, TABLA + 2 * i)
        pares, _ = circuitos.secuencia(a)
        fuera.append([i, a, pares])
    fuera.sort(key=lambda r: r[1])
    return fuera


def parchea(rom, cambios):
    """rom (bytes) + {i: pares} -> rom nueva. Lanza ValueError si no cabe."""
    filas = lee_secuencias(rom)
    for i, pares in cambios.items():
        if not 0 <= i < N:
            raise ValueError("la carrera %r no existe" % i)
        for p, f in pares:
            if not 0 <= p <= 0xFE or not 0 <= f <= 0xFF:
                raise ValueError("par (%r, %r) fuera de rango en la carrera %d" % (p, f, i))
        for fila in filas:
            if fila[0] == i:
                fila[2] = [list(x) for x in pares]

    total = sum(2 * len(f[2]) + 1 for f in filas)
    if total > FIN_ZONA - INI_ZONA:
        raise ValueError("las 21 secuencias suman %d bytes y solo caben %d "
                         "(sobran %d): quita piezas de alguna"
                         % (total, FIN_ZONA - INI_ZONA, total - (FIN_ZONA - INI_ZONA)))

    nueva = bytearray(rom)
    a = INI_ZONA
    for i, _, pares in filas:
        nueva[offset(TABLA + 2 * i)] = a & 0xFF
        nueva[offset(TABLA + 2 * i) + 1] = a >> 8
        for p, f in pares:
            nueva[offset(a)] = p
            nueva[offset(a) + 1] = f
            a += 2
        nueva[offset(a)] = 0xFF
        a += 1
    return bytes(nueva), total, a


def main(argv):
    if len(argv) < 4:
        sys.exit(__doc__)
    rom = open(argv[1], "rb").read()
    if argv[2] == "--nada":
        cambios = {}
    else:
        d = json.load(open(argv[2], encoding="utf-8"))
        cambios = {int(c["i"]): c["pares"] for c in d.get("carreras", [])}
    try:
        nueva, total, fin = parchea(rom, cambios)
    except ValueError as e:
        print("ERROR:", e)
        return 1
    open(argv[3], "wb").write(nueva)
    print("%s: %d carreras tocadas, %d de %d bytes usados (%d libres), acaba en %#06x"
          % (argv[3], len(cambios), total, FIN_ZONA - INI_ZONA,
             FIN_ZONA - INI_ZONA - total, fin))
    if nueva == rom:
        print("  la ROM sale IDENTICA a la original")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
