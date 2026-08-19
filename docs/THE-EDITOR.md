# The track editor

F-1 Spirit stores its 21 tracks as lists of pieces, and those lists can be
rewritten. The editor is an HTML page that reads the ROM, draws each track the
way the game draws it and lets you change it: double-click to open, no network
needed, and it downloads the patched ROM.

    python3 tools/haz_editor.py f1spirit.rom
    tools/editor/circuitos.html

The page is generated with the ROM and the data inside it (about 800 KB), so
once built it works on its own.

## What you see

**The track**, in the middle, as a vertical strip: each 32 × 12 tile band is
one piece of the sequence, with the start line at the bottom. Below the last
one comes the first piece of the next lap, dimmed, with the seam marked.

**The minimap**, top left, in screen coordinates: the game's marker lives in
the top right corner of the screen, and that is where it is drawn. Each leg is
coloured by the direction its pieces take —red for left, green for right, cyan
for straight— and the red dot marks the piece you are editing.

**The panel**, with the race, the tables it uses, the byte budget and the
warnings.

## How to edit

Click a band of the track, or reach it with the arrow keys, and change it:

| key | what it does |
|---|---|
| `↑` `↓` | move up and down the track (it wraps around at the end) |
| `←` `→` | steer the track one column left or right |
| `+` `−` | change the piece |
| `Del` | delete the piece |
| `Home` `End` | jump to the start line or to the end of the lap |

The panel buttons do the same, and add inserting a copy before or after,
moving up and down, undo (200 steps) and reverting the whole race.

**Steering is what makes the track wind.** The shift is added modulo 8 to the
column used to read each piece's row of metatiles, and it accumulates from one
piece to the next: that is why `0x47` (one column left) and `0x41` (one right)
are the two most used values in the ROM. Mind what it does *not* do: it rotates
the row rather than translating it, so the track never wanders off screen, and
it does not touch the car —only the three instructions that paint the row ever
read that accumulator—.

## The three thirds

In SCREEN 2 the pattern table is three banks, one per third of the screen, and
the game loads **different drawings under the same index** in the top one and
the bottom one: that is how the track gets its depth. The third selector picks
which bank is used; "all three" splits them as they appear on screen.

## The minimap

It is separate data: 21 byte paths in page 6, each byte two signed nibbles that
move the marker. Its **shape does not come from the sequence** —change the
shifts and nothing moves here, nor in the game— but its **length is tied to
it**: across all 21 races,

    steps = pieces / 2 + 1

that is, one step every two pieces. Hence the warning in the panel as soon as
you add or remove pieces: the path is left describing something else.

Tick *edit the path* and the minimap moves to a larger panel where its points
can be dragged. Moving one only changes the two legs touching it, so the sum of
the deltas stays put and **the path still closes**, as all 21 in the ROM do. If
a leg will not fit in a single step (nibbles reach ±7), the point does not move.

## The budget

Both areas are full in the original ROM:

| area | where | size | free |
|---|---|---|---|
| the 21 sequences | p07 0x602A–0x7747 | 5917 B | 0 |
| the 21 minimap paths | p06 0xB22E–0xB805 | 1495 B | 0 |

Other data starts right behind each one, so they cannot grow: **to add a piece
you must remove another**, here or in a different race. Making a track one step
longer costs 1 byte of path and 4 of sequence. The panel gauge keeps count and,
if you go over, the export buttons switch off.

## Exporting

- **Patched ROM**: the whole ROM with your changes, ready for the emulator.
- **.json patch**: only what you touched. Applied by

      python3 tools/parchea_circuitos.py f1spirit.rom patch.json out.rom
      python3 tools/parchea_minimapas.py f1spirit.rom patch.json out.rom

Both tools lay the sequences or the paths out back to back from the start of
their area and rebuild the pointer table, which is exactly what the editor
does. With no changes they return the ROM unchanged, and the project's tests
check it —including one that runs the page's own JavaScript and compares its
output byte for byte against the tools—.

## Not losing your work

Every change is saved in the browser by itself and comes back when you reopen
the page —the label under the buttons says so—. Even so, **the real backup is
the file**:

- **⬇ proyecto .json** downloads what you have touched (tracks and paths).
- **⬆ abrir .json** loads it back, here or on another machine.
- **empezar de cero** throws the changes away and returns to the original ROM.

Browser storage may not persist when the page is opened from disk, depending on
which one you use; the `.json` does not depend on that. It is the same file that
`parchea_circuitos.py` and `parchea_minimapas.py` apply.

## Sharing it

The editor in the repository has the ROM inside it, so **it cannot be shared**:
that would mean sharing the game. That is what the portable build is for:

    python3 tools/haz_editor.py f1spirit.rom --portable
    tools/editor/circuitos_portable.html

It is 43 KB and holds nothing from the cartridge: on opening it asks you to load
your own ROM and pulls the tracks, the graphics and the minimaps out of it in
the browser, with nothing uploaded anywhere. That is `tools/editor/lector.js`,
which repeats what `tools/exporta_circuitos.py` does; a node test checks that
both say exactly the same thing.

## What it does not do yet

Edit the pieces themselves (the 3 × 8 metatile grid). When it does, it will
have to warn about something: piece tables are shared between races —fifteen of
them use the 112-piece one— so touching one changes several tracks at once.
