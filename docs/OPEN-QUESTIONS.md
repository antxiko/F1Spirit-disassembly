# Open questions

What is still not settled. It is here so that what is missing can be seen, not
hidden.

## The `jp 0xBE2E` in the header

At 0x4015, right behind Konami's signature, there is a `jp 0xBE2E`. It is an
entry point meant to be called by **another cartridge**, but it is not known who
would jump there nor with which page mapped at 0xA000, so it is not known what
code you would land in either.

## The 504 bytes still untraced

Of the cartridge's 131,072 bytes, **504** are still marked as pending tracing:
0.4 %. It is not that nobody knows what they are —they sit inside identified
blocks— it is that the tracer cannot reach them from any known entry point, so
they cannot be safely declared code.

## Routines with no caller

Besides the eight page-0 doors listed under findings, there is a handful of
routines scattered through the other pages whose bytes never appear as the
target of a jump. Some are clearly leftovers —variants of a routine next door—
but for others it cannot be ruled out that they are reached through a computed
address.

## What exactly some fields of the car record are

The car record is over a hundred bytes long and not all of them are tied to
visible behaviour. The ones used in the arithmetic are clear —position,
velocities, angle, gear, revs, fuel, wear— but there are counters and flags read
in a single place whose purpose could not be stated without watching them run.

## The excess-speed threshold table by terrain

There is a table of sixteen pointers indexed by terrain, and **all sixteen
entries point to the same place**. Either it is redundant, or it was left ready
for a variation that never happened.

## The eight bytes at p02 0x8ECE

Eight bytes (04 01 04 01 02 04 02 01) between two routines with no caller, which
nothing in the cartridge references.

## Konami's hidden mark

Manuel Pazos documented that Konami cartridges hide their RC7xx catalogue number
and the katakana title at the end of the ROM. In this dump it **does not show
up**: the ends of all sixteen pages are either 0xFF padding or graphics data.
Either this cartridge does not carry it, or it is somewhere other than where we
looked.

## What has not been measured in the emulator

A good part of what is written here comes from reading the code, not from
watching it run. The things that have been checked in openMSX are marked as such
in the disassembly notes; the rest is reading, and although it has been gone
over twice, a third pass would keep turning things up. It has happened several
times already.
