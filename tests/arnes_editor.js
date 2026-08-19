// Ejecuta el JS del editor (tools/editor/circuitos.html) FUERA del navegador,
// con un DOM minimo, y comprueba que su exportacion de la ROM coincide con la
// original cuando no se ha tocado nada, y con tools/parchea_circuitos.py
// cuando si. Asi el HTML generado no puede pudrirse sin que salte un test.
//
//   node tests/arnes_editor.js <editor.js> <rom> [salida_editada.rom]
//
// Sale con 0 si todo cuadra, con 1 si no.
const fs = require('fs'), crypto = require('crypto');

const ctx = new Proxy({}, {get: (t, k) => {
  if (k === 'createImageData')
    return (w, h) => ({data: new Uint8ClampedArray(w * h * 4), width: w, height: h});
  return () => {};
}, set: () => true});

const elems = {};
function elem(id) {
  if (elems[id]) return elems[id];
  const o = {id, value: "", textContent: "", innerHTML: "", hidden: false,
             disabled: false, checked: false, style: {}, className: "",
             width: 256, height: 96, max: 0, options: {length: 0},
             firstElementChild: {style: {}},
             addEventListener() {}, appendChild() {}, click() {}, getContext: () => ctx};
  return elems[id] = new Proxy(o, {get: (t, k) => k in t ? t[k] : undefined,
                                   set: (t, k, v) => { t[k] = v; return true; }});
}
globalThis.document = {
  getElementById: elem,
  createElement: () => elem("_t" + Math.random()),
  querySelector: s => elem("_q" + s),
  addEventListener() {},
};
globalThis.atob = b => Buffer.from(b, 'base64').toString('binary');
globalThis.alert = m => console.log("ALERT:", m);
globalThis.URL = {createObjectURL: () => "blob:", revokeObjectURL() {}};
globalThis.Blob = function () {};

require(require('path').resolve(process.argv[2]));
const t = globalThis.__t;
if (!t) { console.log("el script no exporta __t"); process.exit(1); }

const sha = b => crypto.createHash('sha256').update(Buffer.from(b)).digest('hex');
const orig = fs.readFileSync(process.argv[3]);
let mal = 0;

if (sha(orig) !== sha(t.romParcheada())) {
  console.log("MAL: sin tocar nada, la ROM exportada no es la original");
  mal = 1;
} else {
  console.log("ok: sin cambios la ROM sale identica");
}

// con un cambio (quitar la ultima pieza de la carrera 0), para cotejar con python
if (process.argv[4]) {
  t.editado[0] = t.DATOS.carreras[0].pares.slice(0, -1).map(p => p.slice());
  fs.writeFileSync(process.argv[4], Buffer.from(t.romParcheada()));
  console.log("ok: escrita la ROM con una pieza menos en la carrera 0");
}
process.exit(mal);
