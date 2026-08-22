# Getting started

## What you need

`pasmo` and `z80dasm` to assemble and disassemble, and Python 3 for the tools.
Nothing else.

The cartridge does not travel with this repository: put your own, named
`f1spirit.rom`, in the root of the project. It is exactly 131072 bytes, with
this sha256:

    3b9afd12b29680abb655f05d24e0970954c38e48c5ccb24227d6c710474396a7

With any other dump the listing will not assemble back. `make comprueba` says so
in one line.

## What is different from a 16 KB cartridge

This is a 128 KB MegaROM with a Konami SCC mapper: sixteen 8 KB pages, each with
its fixed window in the Z80 map. The disassembly treats every page as an
independent module —its own `org`, its own trace, its own notes and its own
listing— and `make verify` reassembles all sixteen and **concatenates** them:
the whole ROM has to come out, byte for byte.

## The commands

```sh
make          # traces, generates the sixteen listings and checks everything
make verify   # assembles the sixteen pages and compares the whole ROM
make sanity   # what reassembling cannot catch
make test     # the 31 tests on the listings, which do not need the cartridge
make externos # the calls each page makes outside itself
make web      # these pages
```

`make` chains the first four. If all is well, the line that matters is this one:

```
  ensamblado : 131072 bytes  3b9afd12...74396a7
  original   : 131072 bytes  3b9afd12...74396a7
OK: la ROM entera reproducible byte a byte
```

## What `make sanity` checks

Reassembling proves the bytes are the same, but not that they were read
correctly: data read as code produces exactly the same binary. Hence a second
round of checks:

- that the **page → window rule** holds at every place where the program asks
  for a page to be mapped;
- that no byte declared as data comes out as code;
- that no dispatcher is traced with its table unprotected;
- that no declared entry point falls inside a data range;
- and that **not one byte of the cartridge is left unassigned** across the
  sixteen pages.

## What is in each folder

| | |
|---|---|
| `src/f1spirit_pNN.asm` | the commented listings, generated; never edited by hand |
| `src/pNN.notes` | each page's annotations: labels, comments, headers and data ranges, anchored to addresses |
| `src/pNN.entries` | the entry points the trace cannot deduce, each with its justification |
| `src/pNN.nocode` | the ranges the tracer must not read as code |
| `tools/` | the tracer, the listing generator, the checks, the track editor and the drawing tools |
| `tests/` | 31 tests on the listings, the annotations and the site |
| `docs/` | this site and the track editor |
| `work/` | whatever `make` leaves along the way |

## How to read the listings

Every line carries its address at the end, in the window where that page runs.
The comments do not live in the `.asm` —which is regenerated— but in the
matching `.notes`, anchored to addresses, so that they survive a re-trace.

Calls between pages come out as bare addresses (`call 04b28h`) because a page's
listing does not know what is in the others. To find out where each one goes,
`make externos` groups them by destination.
