# The cartridge

## A 128 KB MegaROM

F-1 Spirit is not a 16 KB cartridge like the 1984 Konami titles. It is
**131,072 bytes**, sixteen 8 KB pages that the Z80 cannot see at once: the
cartridge carries its own circuit, the **Konami mapper with SCC**, and the
program keeps asking it to place the page it needs in each window.

There are four windows, and every page has a fixed one, the one its number
gives it:

| pages | Z80 window |
|---|---|
| 0 | 0x4000 (always mapped) |
| 1, 4, 7, 10, 13 | 0x6000 |
| 2, 5, 8, 11, 14 | 0x8000 |
| 3, 6, 9, 12, 15 | 0xA000 |

**Page 0 is the only fixed one**: it holds the header, the interrupt, the bank
switching routines, the joystick reading and everything the other pages need
within reach at all times. The rest take turns.

That each page has only one possible window is not a convention of this
disassembly: it is what the hardware does, and the project checks it on every
build. `make sanity` walks every place where the program asks for a page to be
mapped and verifies the destination matches the window it belongs to.

## The header

```
4000  41 42        "AB", a cartridge signature
4002  E4 40        INIT = 0x40E4
4004  00 00 00 00 00 00   STATEMENT, DEVICE and TEXT at zero
400A  00 x6        padding
4010  43 44 07 52 FF      "CD" 07 "R" FF, Konami's signature
4015  C3 2E BE     jp 0xBE2E
```

The BIOS sees the "AB" at 0x4000, maps the cartridge and jumps to INIT. From
there the program never returns: **INIT installs a jump to 0x4018 in the H.KEYI hook
and sits in an endless two-byte loop**. The whole game runs inside the interrupt, just like the
1984 Konami cartridges.

RAM runs from 0xE000 to 0xF0FF —INIT clears all of it— with the stack at
0xF0F0, and F0F1, F0F2 and F0F3 hold the **mapper shadow**: which page is in
each window. It is needed because the interrupt can fire at any moment and has
to be able to leave the mapping exactly as it found it.

## The interrupt, with two locks and a brake

The interrupt does the sound and calls the game logic. The problem is that
**the logic can take longer than one frame**, and the bank switching routines
end in `ei`, so the interrupt fires again while the logic is still running.
Hence three mechanisms:

- **bit 1 of E1C5**: an interrupt is already inside another one, the outer one
  leaves without touching anything.
- **bit 0 of E1C5**: the logic is in progress; the interrupt does its sound
  work and leaves, so the sound never stops even if the game chokes.
- **F0FC**: counts interrupts. In the demo and in the race the logic does not
  take a step until there are **three**, and taking it resets the count.

That last one is a fixed clock: the race advances one step every three
interrupts no matter how long the code takes.

## The screen

SCREEN 2, with the eight registers written by 0x4317 from the table at 0x4328:

| register | value | what it says |
|---|---|---|
| R0 | 0x02 | graphics mode 2 |
| R1 | 0xE2 | 16 K, screen and interrupt on, 16 × 16 sprites |
| R2 | 0x0E | name table at 0x3800 |
| R3 | 0x7F | colour table at 0x0000 |
| R4 | 0x07 | pattern table at 0x2000 |
| R5 | 0x76 | sprite attributes at 0x3B00 |
| R6 | 0x03 | sprite patterns at 0x1800 |
| R7 | 0xE4 | ink 14 on background 4 |

In SCREEN 2 the screen is split into three eight-row thirds and each third has
its own 256 patterns. The cartridge's tile loader loads all three at once: a
list record carries three bits —one per third— and the same drawing is
decompressed as many times as thirds are asked for.

The name table is not written directly. The game keeps **two 1 KB buffers in
RAM**, one per player (0xE400 and 0xEC00), which are 32 × 32 circular maps: the
track is painted there and then dumped to VRAM. Being circular is what lets the
scroll move nothing at all: only the row it starts reading from changes.

## The sound

Two chips at once: the machine's **PSG** and the cartridge's own **SCC**, which
adds five more channels with programmable waveforms. The player lives in page 13
and runs once per interrupt.

Writing to the SCC is not free: you have to map page 0x3F at 0x8000, write, and
put page 2 back. That is why the player does not write the fifteen values of the
five channels on every interrupt: it **compares them with a copy** it keeps in
RAM and only sends the chip the ones that changed.
