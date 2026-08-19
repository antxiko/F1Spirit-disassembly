/* Lee de la ROM, dentro del navegador, lo mismo que tools/exporta_circuitos.py
   escribe en work/circuitos.json. Es lo que permite repartir el editor sin
   llevarse nada del cartucho dentro: quien lo abra pone su propia ROM.

   La equivalencia con la herramienta de python no se deja a la fe:
   tests/test_listado.py ejecuta este fichero con node sobre la misma ROM y
   compara el resultado con el JSON de exporta_circuitos.py.

   Vocabulario, igual que en las herramientas: "grupo" es la pagina que esta
   mapeada en 0x6000, y de ahi salen las de 0x8000 y 0xA000. */

function leeROM(rom) {
  const TAM = 0x2000, NPAG = 16;

  const abs = (g, a) => {
    if (a < 0x6000 || a >= 0xC000) throw new Error("direccion " + a.toString(16) + " fuera de 0x6000-0xBFFF");
    const p = g + ((a - 0x6000) >> 13);
    if (p >= NPAG) throw new Error("la pagina " + p + " no existe");
    return p * TAM + ((a - 0x6000) & 0x1FFF);
  };
  const leer = (g, a) => rom[abs(g, a)];
  const palabra = (g, a) => leer(g, a) | (leer(g, a + 1) << 8);

  /* El RLE del cargador (p00 0x4D64): 0 termina; bit 7 puesto = copiar los k
     bytes siguientes; si no, repetir el byte que viene c veces. */
  function rle(g, addr) {
    const out = []; let a = addr;
    for (;;) {
      const c = leer(g, a++);
      if (c === 0) return out;
      if (c & 0x80) { for (let i = 0; i < (c & 0x7F); i++) out.push(leer(g, a + i)); a += c & 0x7F; }
      else { const b = leer(g, a++); for (let i = 0; i < c; i++) out.push(b); }
      if (out.length > 0x2000) throw new Error("RLE sin fin en " + addr.toString(16));
    }
  }

  /* Una lista del cargador de tiles: registros de 6 bytes, y unas cuantas
     ordenes 0x1x que no cargan por puntero. Los bits 7/6/5 de los flags dicen
     a que TERCIO de la pantalla va el tile (ahi esta la profundidad de la
     pista: el mismo indice lleva dibujos distintos arriba y abajo). */
  const TABLA85 = 0x6000, TABLA85_N = 85;
  function recorreLista(addr, g) {
    const regs = []; let a = addr;
    for (;;) {
      const f = leer(g, a);
      if (f === 0) return regs;
      if ((f & 0xF0) === 0x10) {
        const k = f & 3;
        if (k === 0) { a += 17; }
        else if (k === 1) { a += 3; }
        else if (k === 3 && (f & 4)) {
          const idx = leer(g, a + 1), tile = leer(g, a + 2);
          if (idx >= TABLA85_N) throw new Error("recurso " + idx + " fuera de la tabla de 85");
          const e = TABLA85 + 5 * idx;
          const g2 = 4 + 3 * ((leer(4, e) >> 1) & 3);
          regs.push([tercios(leer(4, e)), tile, rle(g2, palabra(4, e + 1)), rle(g2, palabra(4, e + 3))]);
          a += 3;
        } else if (k === 3) { regs.push(...recorreLista(palabra(g, a + 1), g)); a += 3; }
        else { a += 3; }
        continue;
      }
      const tile = leer(g, a + 1), pp = palabra(g, a + 2), pc = palabra(g, a + 4);
      const g2 = 4 + 3 * ((f >> 1) & 3);
      regs.push([tercios(f), tile, rle(g2, pp), rle(g2, pc)]);
      a += 6;
      if (a - addr > 0x1000) throw new Error("lista sin fin en " + addr.toString(16));
    }
  }
  const tercios = f => [[0, 0x80], [1, 0x40], [2, 0x20]].filter(([, b]) => f & b).map(([t]) => t);

  const hex2 = v => v.toString(16).padStart(2, "0");
  function juegoDeTiles(lista) {
    const juego = [[], [], []].map(() => new Array(256).fill(null));
    for (const l of [0x6DB5, 0x6DBC, 0x6D00, 0x61FD, lista]) {
      for (const [ters, tile, pat, col] of recorreLista(l, 4)) {
        const n = pat.length >> 3;
        for (let k = 0; k < n; k++) {
          const t = (tile + k) & 0xFF;
          const p = pat.slice(k * 8, k * 8 + 8);
          const c = col.length >= (k + 1) * 8 ? col.slice(k * 8, k * 8 + 8) : new Array(8).fill(0xF0);
          for (const ter of ters)
            juego[ter][t] = {pat: p.map(hex2).join(""), col: c.map(hex2).join("")};
        }
      }
    }
    return juego;
  }

  // ------------------------------------------------------------------ datos
  const N = 21;
  const CATEGORIAS = ["RALLY", "STOCK", "ENDURANCE", "F3", "F3000", "F1"];
  const nombre = i => i < 5 ? CATEGORIAS[i] : "F1 ROUND " + (i - 4);

  const carreras = [];
  for (let i = 0; i < N; i++) {
    const sec = palabra(7, 0x6000 + 2 * i);
    const pares = []; let a = sec;
    for (;;) {
      const p = leer(7, a);
      if (p === 0xFF) break;
      pares.push([p, leer(7, a + 1)]); a += 2;
      if (a - sec > 0x1000) throw new Error("secuencia sin fin en " + sec.toString(16));
    }
    carreras.push({i: i, nombre: nombre(i), categoria: i < 5 ? i : 5,
                   secuencia: "0x" + sec.toString(16), fin: "0x" + (a + 1).toString(16),
                   pagina: 7 + ((sec - 0x6000) >> 13), pares: pares,
                   piezas: "0x" + palabra(10, 0xAFA2 + 2 * i).toString(16),
                   metatiles: "0x" + palabra(10, 0xAF78 + 2 * i).toString(16),
                   tiles: "0x" + palabra(4, 0x61A9 + 2 * i).toString(16)});
  }

  /* El tamano de las tablas no lo dice ningun byte: es el indice mayor que usa
     cada carrera, igual que en circuitos.py. */
  const piezas = {}, metatiles = {};
  for (const c of carreras) {
    const dirP = parseInt(c.piezas, 16), dirM = parseInt(c.metatiles, 16);
    const maxP = Math.max(...c.pares.map(p => p[0]));
    piezas[c.piezas] = piezas[c.piezas] || {n: 0, usan: [], datos: null};
    piezas[c.piezas].n = Math.max(piezas[c.piezas].n, maxP + 1);
    piezas[c.piezas].usan.push(c.i);
    let maxM = 0;
    for (const p of new Set(c.pares.map(q => q[0])))
      for (let k = 0; k < 24; k++) maxM = Math.max(maxM, leer(10, dirP + 24 * p + k));
    metatiles[c.metatiles] = metatiles[c.metatiles] || {n: 0, usan: [], datos: null};
    metatiles[c.metatiles].n = Math.max(metatiles[c.metatiles].n, maxM + 1);
    metatiles[c.metatiles].usan.push(c.i);
  }
  for (const k of Object.keys(piezas)) {
    const d = parseInt(k, 16), t = [];
    for (let p = 0; p < piezas[k].n; p++) {
      const fila = [];
      for (let j = 0; j < 24; j++) fila.push(leer(10, d + 24 * p + j));
      t.push(fila);
    }
    piezas[k].datos = t;
  }
  for (const k of Object.keys(metatiles)) {
    const d = parseInt(k, 16), t = [];
    for (let m = 0; m < metatiles[k].n; m++) {
      const fila = [];
      for (let j = 0; j < 16; j++) fila.push(leer(10, d + 16 * m + j));
      t.push(fila);
    }
    metatiles[k].datos = t;
  }

  const tiles = {};
  for (const c of carreras) if (!tiles[c.tiles]) tiles[c.tiles] = juegoDeTiles(parseInt(c.tiles, 16));

  /* Los minimapas: tabla p01 0x7753 (posicion inicial y puntero) y los 21
     caminos seguidos en p06 hasta donde empiezan los rotulos. Cada byte, dos
     nibbles con signo: el alto a la x, el bajo a la y. */
  const s4 = v => v >= 8 ? v - 16 : v;
  const ptrs = [], pos = [];
  for (let i = 0; i < N; i++) { pos.push(palabra(1, 0x7753 + 4 * i)); ptrs.push(palabra(1, 0x7753 + 4 * i + 2)); }
  const orden = [...ptrs.keys()].sort((a, b) => ptrs[a] - ptrs[b]);
  const minimapas = new Array(N);
  orden.forEach((k, n) => {
    const fin = n + 1 < orden.length ? ptrs[orden[n + 1]] : 0xB805;
    const pasos = [];
    for (let j = 0; j < fin - ptrs[k]; j++) {
      const b = leer(4, ptrs[k] + j);
      pasos.push([s4(b >> 4), s4(b & 15)]);
    }
    minimapas[k] = {i: k, inicio: [pos[k] >> 8, pos[k] & 0xFF],
                    camino: "0x" + ptrs[k].toString(16), fin: "0x" + fin.toString(16), pasos: pasos};
  });

  return {
    rom: "f1spirit.rom", categorias: CATEGORIAS, carreras: carreras,
    piezas: piezas, metatiles: metatiles, tiles: tiles, minimapas: minimapas,
    zona: {tabla: 0x6000, ini: 0x602A, fin: 0x7747, pagina: 7, org: 0x6000},
    zona_mapa: {tabla: 0x7753, tabla_pagina: 1, tabla_org: 0x6000,
                ini: 0xB22E, fin: 0xB805, pagina: 6, org: 0xA000},
  };
}

if (typeof module !== "undefined") module.exports = {leeROM};
