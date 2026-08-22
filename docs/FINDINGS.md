# Findings

What turned up while reading the cartridge instruction by instruction.
Everything here is measured against the binary; where something is a hypothesis,
it says so.

## The clock is made for 60 Hz

The arithmetic has three parts: the clock goes up one per logic step, the
interrupt takes a step every **three**, and the on-screen clock divides by
**20** to get seconds. 3 × 20 = 60.

On an NTSC machine the clock is exact. On a PAL one, with 50 interrupts per
second, that gives 16.67 steps, so the clock shows **five seconds for every six
real ones**. It is the clock that counts wrong, not the game that runs slow: the
three-interrupts-per-step split keeps the race advancing at the same relative
pace either way.

## The replay branch is disabled by an `scf`

The car's normal state starts like this:

```
8C70  B7        or a          ; clears the carry
8C71  37        scf           ; and sets it again
8C72  D2 D3 89  jp nc,0x89D3  ; ...so this jump is NEVER taken
```

Those are the bytes, checked in the ROM. The `scf` always leaves the carry set,
so the `jp nc` never jumps. And with it falls the routine at 0x89D3, the one
that would make the car follow the recorded object during the replay: **its two
bytes D3 89 appear exactly once in the cartridge's 128 KB**, and it is that
jump's operand.

The replay still works —it has its own path elsewhere— but that particular
branch is dead.

## A ladder of divisions that was eating a factor of eight

Page 0 has a ladder of eight `sra h / rr l` pairs in a row followed by a `ret`.
Each entry point divides by two as many times as it has pairs ahead of it:
entering at 0x4A76 is eight (÷256), at 0x4A7E six (÷64), at 0x4A86 four (÷16)
and at 0x4A8A three (÷8).

While reading them it turned out the note on the car's braking said "vy -= vy/8"
citing 0x4A7E, and **0x4A7E divides by 64**. That is six pairs, not three; the
bytes are `CB 2C CB 1D` repeated. The car's drag is eight times gentler than
what was written.

Another one came out of it: the third `sbc hl,de` of the drag code (0x9934) is
the only one of the three **without an or a in front**, so it swallows the
carry left by the ladder's last `rr l` and subtracts one extra from the speed
whenever the bit that fell off the bottom was a one.

## The rivals cost you places two ways

While you are **stopped in the pits**, every rival that crosses the screen adds
one place to your position, up to a cap of 99. The gap between cars is drawn at
random: in category 0 the addend is 30 and in the others 5, so in RALLY they go
past far less often.

And a rival that **crosses the finish line** after you also adds one place, with
the same cap. Each rival collects it only once: it is marked with a bit in its
own flags.

## The roadside prop lands in the middle of the gap

The signs at the edge are not placed where the list says: the list says which
row they go in, and the code finds them a spot. It walks ten positions along the
row, three columns apart, looking for **five consecutive cells** whose tile is
background, and plants the prop in the middle of the gap.

With one curiosity: of the four cells it checks besides the first one, if the
one that fails is the **fourth**, the gap is accepted anyway. In practice only
the first three count.

## Eight doors with no caller

Page 0 has eight routine entry points whose two bytes **do not appear once in
the 128 KB** —neither as a `call` operand nor inside a jump table— and which are
not reached by falling through from the instruction before: 0x4A55, 0x4A76,
0x4A97, 0x4B48, 0x4BA3, 0x4C8C, 0x4C9A and 0x4CAF.

With 0x4B48 everything hanging off it falls too: the whole rectangle copier is
dead code.

## One instruction that straddles a page boundary

At 0x7FFF, the last byte of page 1, there is a `sub` (0xD6). Its operand is the
first byte of page 2 (0xD4), and the routine carries on at 0x8001. It is **the
only instruction in the cartridge that crosses a page boundary**, and it works
because the two windows are contiguous in the Z80's map.

There is more code that leaves its page —the routine at 0x5FD7 ends up jumping
to 0x6057 and 0x60F3, already in page 1— but those are jumps: legal, because
page 0 is fixed, even if the listing cannot follow them.

## The credits are in plain text

In page 2, at 0x848A, there is a text stream with the full credits, neither
enciphered nor compressed:

> STAFF — PROGRAM: T.ADACHI, M.OZAWA, R.SAGISAKA — GRAPHIC: H.MAKITANI,
> T.SHIMIZU, B.KINOSHITA — SOUND: K.UEHARA, M.SASAKI, M.FURUKAWA

## Two sibling slips in the cartridge

Both are the same oversight, and both make a second pass repeat player 1's work
instead of doing player 2's.

- At p03 0xA779 the bytes are `FD 21 28 E9 FD 21 80 E3`, that is `ld iy,0E928h`
  followed by `ld iy,0E380h`: the first load does nothing, because the next one
  overwrites it. Going by the pattern of the two instructions above, the prefix
  should have been DD —`ld ix`— and not FD.
- At p02 0x8025 the rival setup calls the same routine twice, once per car, but
  **IY is not changed in between**: it stays on car 1. An `ld iy,0E380h` is
  missing.

That the load is overwritten is read off the bytes; what was meant instead is
inference. Neither shows while playing: in p02, the only thing that reads what
that second pass would leave is a routine that redoes the calculation right
before, every time.

## The axis the notes call "x" is the vertical one

Each car's record has two coordinates, and the disassembly had been calling them
x and y. Reading the sprite writer shows the first one is what ends up in the
**Y byte of the attribute**, which on the TMS9918 is the vertical one. The rival
entry confirms it: the slow one comes in at 0 —top of the screen, ahead of you—
and the fast one at 0xB7 —bottom, behind you—.

So the game's "x" is the along-the-track axis, which on screen runs vertically.

## Only one of the three ending sprites rises

The ending scene has three sprites moving at once. All three advance to the
right, but only the first one rises: the loop shifts the value one bit before
subtracting it, so the second gets half and the third a quarter, and both are
zero.
