#!/usr/bin/env python3
"""Reconocimiento de la ROM: cabecera, mapper y SCC. Y la comprobacion de que la
regla pagina -> org de tools/paginas.py la cumplen todos los llamadores.

Lo que mide, sobre los bytes de la ROM y sin ejecutar nada:
  1. La cabecera "AB" y el INIT de la pagina 0 (y si alguna otra pagina la lleva).
  2. Todas las escrituras `ld (nn),a` a los registros del mapper Konami SCC
     (0x5000, 0x7000, 0x9000, 0xB000), con la pagina y la direccion de
     ejecucion de cada una.
  3. Los llamadores de las cuatro rutinas de banco de la pagina 0 y el valor
     de A que les pasan (el `ld a,N` inmediatamente anterior). Con eso se
     comprueba la regla: la pagina N va a la ranura que le toca por N mod 3.
  4. Las escrituras al SCC (pagina 0x3F en 0x8000-0x9FFF, registros en
     0x9800-0x98FF).

Codigo de salida 1 si algun llamador contradice la regla, o si la cabecera
no es la esperada. Uso: reconocimiento.py <rom>
"""
import sys

from paginas import org, TAM_PAGINA, N_PAGINAS

MAPPER = (0x5000, 0x7000, 0x9000, 0xB000)
# Rutinas de banco de la pagina 0 y que ranuras tocan (ranura 1 = 0x6000,
# 2 = 0x8000, 3 = 0xA000). "A" es el valor que reciben en el acumulador.
#   0x43FE  1/2/3 fijas en 0x6000/0x8000/0xA000
#   0x441B  A, A+1, A+2 en 0x6000/0x8000/0xA000
#   0x4447  A en 0x8000 y A+1 en 0xA000
#   0x4457  A en 0xA000
RUTINAS = {0x441B: ((1, 0), (2, 1), (3, 2)),
           0x4447: ((2, 0), (3, 1)),
           0x4457: ((3, 0),)}
ATAJOS = {0x4418: 4, 0x4433: 1, 0x4438: 7, 0x443D: 0xA, 0x4442: 0xD}
RANURA = {1: 0x6000, 2: 0x8000, 3: 0xA000}


def direccion(i):
    """(pagina, direccion de ejecucion) del offset i de la ROM."""
    p = i // TAM_PAGINA
    return p, org(p) + (i % TAM_PAGINA)


def main(rom):
    d = open(rom, "rb").read()
    fallos = 0
    print("ROM: %d bytes, %d paginas de %d" % (len(d), len(d) // TAM_PAGINA, TAM_PAGINA))

    # 1. cabecera
    init = d[2] | (d[3] << 8)
    print("cabecera: %s INIT=%#06x STATEMENT=%#06x DEVICE=%#06x TEXT=%#06x" % (
        d[0:2], init, d[4] | (d[5] << 8), d[6] | (d[7] << 8), d[8] | (d[9] << 8)))
    if d[0:2] != b"AB":
        print("  FALLO: la pagina 0 no empieza por AB")
        fallos += 1
    for p in range(1, N_PAGINAS):
        if d[p * TAM_PAGINA:p * TAM_PAGINA + 2] == b"AB":
            print("  (la pagina %d tambien lleva AB)" % p)

    # 2. escrituras al mapper
    print("\nescrituras `ld (nn),a` al mapper:")
    for reg in MAPPER:
        sitios = [i for i in range(len(d) - 2)
                  if d[i] == 0x32 and d[i + 1] == (reg & 0xFF) and d[i + 2] == (reg >> 8)]
        por_pag = {}
        for i in sitios:
            p, a = direccion(i)
            por_pag.setdefault(p, []).append(a)
        print("  %#06x: %2d sitios  %s" % (reg, len(sitios), "  ".join(
            "pag %d: %s" % (p, " ".join("%04X" % a for a in l)) for p, l in sorted(por_pag.items()))))
        if reg == 0x5000 and sitios:
            print("  OJO: alguien escribe en 0x5000; la pagina 0 ya no es fija")
            fallos += 1

    # 3. llamadores de las rutinas de banco y la regla
    print("\nllamadores de las rutinas de banco (valor de A por el `ld a,N` anterior):")
    for rut, ranuras in sorted(RUTINAS.items()):
        for i in range(len(d) - 2):
            if d[i] in (0xCD, 0xC3) and d[i + 1] == (rut & 0xFF) and d[i + 2] == (rut >> 8):
                p, a = direccion(i)
                if d[i - 2] == 0x3E:              # ld a,N justo antes
                    A = d[i - 1]
                    veredicto = []
                    for ranura, delta in ranuras:
                        pag = A + delta
                        ok = pag < N_PAGINAS and org(pag) == RANURA[ranura]
                        veredicto.append("pag %X->%#06x %s" % (pag, RANURA[ranura], "ok" if ok else "CONTRADICE"))
                        if not ok:
                            fallos += 1
                    print("  %04X (pag %2d) call %04X A=%#04x  %s" % (a, p, rut, A, ", ".join(veredicto)))
                else:
                    print("  %04X (pag %2d) call %04X A=?  (A calculado: %s)" % (
                        a, p, rut, d[i - 6:i].hex(" ")))
    for atajo, A in sorted(ATAJOS.items()):
        n = sum(1 for i in range(len(d) - 2)
                if d[i] in (0xCD, 0xC3) and d[i + 1] == (atajo & 0xFF) and d[i + 2] == (atajo >> 8))
        ok = all(org(A + k) == RANURA[k + 1] for k in range(3))
        print("  atajo %04X (A=%#04x -> %X/%X/%X en 6000/8000/A000) %d llamadores  %s" % (
            atajo, A, A, A + 1, A + 2, n, "ok" if ok else "CONTRADICE"))
        if not ok:
            fallos += 1

    # 4. SCC
    print("\nSCC (pagina 0x3F en 0x8000-0x9FFF):")
    for i in range(len(d) - 4):
        if d[i] == 0x3E and d[i + 1] == 0x3F and d[i + 2] == 0x32 and d[i + 3] == 0x00 and d[i + 4] == 0x90:
            p, a = direccion(i)
            print("  %04X (pag %2d): ld a,3Fh / ld (9000h),a" % (a, p))
    for i in range(len(d) - 2):
        if d[i] in (0x11, 0x21, 0x32) and d[i + 2] == 0x98:
            a16 = d[i + 1] | 0x9800
            if d[i] == 0x32 or (a16 & 0x1F) == 0:
                p, a = direccion(i)
                print("  %04X (pag %2d): %s %#06x" % (a, p, {0x11: "ld de,", 0x21: "ld hl,", 0x32: "ld (nn),a"}[d[i]], a16))

    print()
    if fallos:
        print("FALLO: %d contradicciones con la regla pagina -> org" % fallos)
        return 1
    print("OK: la regla pagina -> org de tools/paginas.py la cumplen todos los llamadores")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1]))
