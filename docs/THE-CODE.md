# The code

## What is in each page

Of the sixteen pages, six carry code and ten are data:

| page | what it is |
|---|---|
| 0 | fixed at 0x4000: header, interrupt, mapper, joysticks, tile loader, track, pits, title screen |
| 1 | menus, car cards, ranking, HUD, starting grid, password |
| 2 | car physics, states, engine sound, objects, ending |
| 3 | the rivals: grid, overtakes, collisions, types |
| 4 | tile and sprite lists |
| 5, 7, 10, 11, 14 | graphics and metatiles |
| 6, 8, 9, 12 | drawings, texts and tables |
| 13 | the sound player |
| 15 | title-screen streams and one recorded game |

The disassembly produces **one listing per page**, each with its own `org`, and
`make verify` reassembles all sixteen and concatenates them: the whole ROM has
to come out, byte for byte.

## The track

Each circuit's track is a **sequence of pieces**. Each entry in the sequence is
two bytes —the piece number and some flags— and a 0xFF closes the lap.

A piece is **24 bytes**: three rows of eight metatiles. Each metatile is 4 × 4
tiles, i.e. 16 bytes, so a piece is twelve tile rows tall and takes the full
width of the screen.

The position along the track is a **32-bit counter that goes down** —the track
comes towards the player— and every 0x800 is one eight-pixel row. After twelve
rows the piece runs out and the next one begins.

Two details that show up on reading the code:

- the metatile row is read **backwards** (3 minus the row), because the drawing
  moves down while the track moves up;
- the column the metatile row starts being read from **wraps modulo 8**, and
  that is what makes the track drift sideways: bit 6 of the piece's second byte
  says there is a shift and the low six say how much.

The signs and roadside props are not part of the pieces' drawing: they live in
a separate per-circuit list, ordered by position, three bytes per entry —the
piece in the top twelve bits, the row in the low four, and the drawing—. Because
it is ordered, a single index that moves forward and never back is enough.

## The tile loader

Nothing is copied to VRAM as-is. All the graphics go through a loader that walks
lists in page 4. A list record is **six bytes**:

```
flags | tile | pointer to the patterns | pointer to the colours
```

and the flags say where the drawing comes from and what to do with it:

| bits | what they say |
|---|---|
| 2-1 | page group where the drawing lives: 4, 7, 0x0A or 0x0D |
| 3 | flip the tile vertically |
| 4 | mirror it horizontally |
| 5, 6, 7 | which screen thirds it goes to |

On the other side of the pointers there are no loose bytes: there is an **RLE
decompressed straight into VRAM**, eight bytes at a time, with the working tile
in RAM. The codes are 00 ends, 01-7F repeats the next byte n times, 80 does
nothing and 81-FF copies n bytes verbatim. Mirroring and flipping happen there,
with the tile already assembled and before letting it go: they come for free.

Besides records, a list can carry **orders**:

| order | what it does |
|---|---|
| 0x10 | copies the 16 bytes behind it into a variable |
| 0x11, 0x15, 0x19, 0x1D | write a word into one of four slots |
| 0x12 | nothing (and without advancing the pointer: no list uses it) |
| 0x13 | nests one list inside another |
| 0x17 | loads a resource from the table of 85 |

And there is a row mode: loading **one pixel row of each tile at a time**, with
a wait in between, makes the drawing appear top to bottom instead of all at
once. That is the panel's entrance effect.

## The sprites

Attributes are not written directly: there is a RAM copy of 32 sprites × 4 bytes
dumped to the VDP on every repaint. On odd frames it is dumped **backwards**,
from 29 to 0, with the last two apart: that is the priority rotation that makes
the sprites beyond the four-per-line limit flicker instead of vanish.

Each car is two sprites in the same place: the pattern and the pattern plus
four, in different colours. On a TMS9918 that is how you get a two-ink figure.

The car's frame comes from the angle, split into sixteen sectors. From F3
upwards the cars carry five extra frames —the wheels turning— and the lower
categories do not: those cars never show them.

## The rivals

Each player has five rivals, 0x38-byte records, and **each one is served one
frame in eight**: its turn is written in its own record, so the five never fall
on the same frame.

A rival looks at the track ahead —at 0xE8 and at 0x98 pixels— reading three
cells of the row, and gets two things from it: whether a corner is coming, and
where there is room. If a corner is coming, one of three lists is subtracted
from its base speed, from the gentlest braking to the hardest.

Car-to-car collisions are resolved as a half-elastic impact: each car's new
speed is the average of the two, plus or minus a quarter of the difference along
the long axis and an eighth along the short one.

On the grid player 1 starts **third** and player 2 **fourth**, but the
classification is longer than the six cars you can see: the number of cars that
are ahead unseen in that race is added to the grid slot — 20 in the first race.
That is why you start 23rd.

## The sound

The page 13 player runs once per interrupt and serves two chips: the machine's
PSG and the cartridge's SCC.

From the PSG it writes the three channels with their period and volume, the
noise period, the three envelope registers and the mixer. From the SCC, the five
channels, their 32-byte waveforms and its own mixer.

The expensive part of the SCC is reaching it: map page 0x3F at 0x8000, write,
put page 2 back. That is why the player keeps a **RAM copy of the fifteen
values** and compares them one by one; only the changed ones are flagged and
only those get written. It is fifteen near-identical seven-instruction blocks,
written out by hand with no loop: longer, but with no index arithmetic.

The effects in the scores are software envelopes: two volume phases, a
four-stage vibrato and a note slide, all written into the score itself as
orders.
