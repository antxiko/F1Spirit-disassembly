// Ejecuta con node el JS del editor PORTABLE (tools/editor/circuitos_portable.html),
// que no lleva la ROM ni sus datos dentro. Comprueba dos cosas: que su lector
// saca de la ROM lo mismo que tools/exporta_circuitos.py, y que sin tocar nada
// la ROM que exporta es identica a la original.
//
//   node tests/arnes_portable.js <portable.js> <rom> [circuitos.json]
const fs=require('fs'), crypto=require('crypto');
const ctx=new Proxy({},{get:(t,k)=> k==='createImageData'
  ? (w,h)=>({data:new Uint8ClampedArray(w*h*4),width:w,height:h}) : ()=>{} , set:()=>true});
const elems={};
function elem(id){ if(elems[id])return elems[id];
  const o={id,value:"",textContent:"",innerHTML:"",hidden:false,disabled:false,checked:false,
           style:{},className:"",width:256,height:96,max:0,options:{length:0},files:[],
           firstElementChild:{style:{}},addEventListener(){},appendChild(){},click(){},getContext:()=>ctx};
  return elems[id]=new Proxy(o,{get:(t,k)=>k in t?t[k]:undefined,set:(t,k,v)=>{t[k]=v;return true}}); }
globalThis.document={getElementById:elem,createElement:()=>elem("_t"+Math.random()),
                     querySelector:s=>elem("_q"+s),addEventListener(){}};
globalThis.atob=b=>Buffer.from(b,'base64').toString('binary');
globalThis.btoa=b=>Buffer.from(b,'binary').toString('base64');
globalThis.alert=m=>console.log("ALERT:",m);
globalThis.URL={createObjectURL:()=>"blob:",revokeObjectURL(){}};
globalThis.Blob=function(){}; globalThis.FileReader=function(){};
require(require('path').resolve(process.argv[2]));
const p=globalThis.__p, rom=fs.readFileSync(process.argv[3]);
const datos=p.leeROM(new Uint8Array(rom));
p.pon(datos, rom.toString('base64')); p.arranca();
const sha=b=>crypto.createHash('sha256').update(Buffer.from(b)).digest('hex');
console.log("carreras leidas de la ROM:", datos.carreras.length);
let mal = 0;
if (process.argv[4]) {
  const py = JSON.parse(fs.readFileSync(process.argv[4], 'utf8'));
  const cmp = (a, b, q) => { if (JSON.stringify(a) !== JSON.stringify(b)) {
      mal++; console.log("DISTINTO en " + q); } };
  for (let i = 0; i < 21; i++) {
    for (const k of ["i","nombre","categoria","secuencia","fin","pagina","pares","piezas","metatiles","tiles"])
      cmp(datos.carreras[i][k], py.carreras[i][k], "carrera " + i + "." + k);
    cmp(datos.minimapas[i], py.minimapas[i], "minimapa " + i);
  }
  for (const k of Object.keys(datos.piezas)) cmp(datos.piezas[k].datos, py.piezas[k].datos, "piezas " + k);
  for (const k of Object.keys(datos.metatiles)) cmp(datos.metatiles[k].datos, py.metatiles[k].datos, "metatiles " + k);
  for (const k of Object.keys(datos.tiles)) cmp(datos.tiles[k], py.tiles[k], "tiles " + k);
  console.log(mal ? mal + " diferencias con exporta_circuitos.py"
                  : "ok: el lector JS saca lo mismo que exporta_circuitos.py");
}
console.log(sha(rom)===sha(p.romParcheada())
  ? "OK: el portable lee la ROM y su exportacion sale IDENTICA"
  : "MAL: el portable corrompe la ROM");
if (sha(rom) !== sha(p.romParcheada())) mal++;
process.exit(mal ? 1 : 0);
