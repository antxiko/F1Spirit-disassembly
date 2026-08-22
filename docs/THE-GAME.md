# The game

## Six categories and twenty-one races

The menu offers six categories. The game numbers them in one order and the menu
shows them in another, and that is what the five-byte table at p01 0x6135 is
for:

| value of E25B | category |
|---|---|
| 0 | RALLY |
| 1 | STOCK |
| 2 | ENDURANCE |
| 3 | F3 |
| 4 | F3000 |
| 5 | F1 |

Races run from 0 to 20. The first five are the lower categories; from 5 onwards
they are the **sixteen Formula 1 Grands Prix**, and the race number is 5 plus
the chosen GP. The names are in the cartridge: BRAZIL, SAN MARINO, BELGIUM,
MONACO, U.S.A., FRANCE, GREAT BRITAIN, WEST GERMANY, HUNGARY, AUSTRIA, ITALY,
PORTUGAL, SPAIN, MEXICO, JAPAN and AUSTRALIA.

How many laps a race has depends on the category: **three or four**, from the
table at p02 0x91DB.

## What points unlock

You cannot pick everything from the start. The category screen keeps adding
options as points come in, and the thresholds are written as a ladder of
comparisons:

- at **0x0C** points two more options appear,
- at **0x19**, one more,
- and from there a ladder of eight thresholds —0x21, 0x30, 0x41, 0x54, 0x69,
  0x80, 0x99 and 0xB4— each opening **two Grands Prix**, plus one more past the
  last: sixteen in all.

It is enough for **one of the two players** to reach the threshold.

## The car is built piece by piece

Before racing you choose a car, and there are two ways: take one of the
eighteen presets —five bytes, ready made— or build it in five steps: engine,
body, two more parts and gearbox. Those five bytes are then translated into the
numbers the car actually races with:

- the **engine** gives the top speed and the torque table;
- the **body** gives the sprite colour and, multiplied by four, **how much the
  tyres take** before blowing;
- the **gearbox** gives the ratios: how much the engine revs per unit of speed,
  and how hard it pushes in each gear.

There are four gears, 0 to 3, and the change can be manual or automatic —bit 7
of the fifth byte of the car says which—. In automatic it decides every 30
frames: below 32 revs it shifts down and above 56 it shifts up.

## Driving

The steering is not a switch: it is a **ramp**. While the direction is held, a
counter climbs by two up to 16, and the turn per frame comes out of a table
crossing three things: the tyres chosen, the speed and the ramp step you are on.
Let go and the car straightens itself.

Speed becomes movement through the sine and cosine of the angle, so the car goes
where the nose points, not where the stick points. And every category brakes
differently while turning: speed loses a 256th, half of that or a quarter,
depending on the category — and category 5 loses nothing.

Going off the tarmac costs a **32nd of the speed per frame**. The edge of the
track bounces you back: half the sideways speed is added to the other axis, the
angle is corrected by eight degrees and the sideways speed is inverted and
halved. If the hit is hard —in RALLY, 3 or more— it is not a bounce: it is a
crash.

## The tyres

The four tyres live in four bits, and each blown one does something different:

| bit | what happens |
|---|---|
| 0 | the steering freezes one frame in four |
| 1 | the car tugs at random above a certain speed |
| 2 | accelerating counts half |
| 3 | braking counts half |

They blow in two ways: by **wear**, when the counter reaches four times the body
byte, and 90 frames after a **crash**. Which of the four blows is drawn from an
eight-entry table, each tyre twice, so all four are equally likely.

## The pit stop

With a single player, entering the pits changes the state of the whole game and
you get a separate scene. Two mechanics —two six-byte records— climb from the
bottom two pixels at a time, with eight poses and four sprites each: they are
16 × 32 pixel figures in two inks, made of two overlaid sprite pairs.

While you refuel, **the rivals overtake you**: three records that come down
eight pixels at a time, and each one that crosses the middle of the screen adds
one place to your position, up to a cap of 99. The gap between cars is drawn at
random, and in category 0 they are far rarer.

The stop can be cut short with the button; down refuels. And when you leave, the
tank is full and all four tyres are sound.

## The clock runs slow on PAL

The clock is 24 bits and goes up one per logic step. The interrupt takes a step
every three, and the on-screen clock divides by 20 to get seconds: **3 × 20 =
60**. The arithmetic is made for a 60 Hz machine.

On a PAL machine, with 50 interrupts per second, that gives 16.67 steps, so the
clock shows **five seconds for every six real ones**. It is not that the game
runs slower: it is the clock that counts wrong.

What you read on screen is minutes, seconds and hundredths. The hundredths come
from multiplying the remainder by 100 and dividing by 2 — that is, the game
works in twentieths of a second, and its thousandths always end in 0 or 5.

## The password

The saved game is a code of letters. Inside it is 21 values —what you achieved
in each of the 21 races, clipped to one nibble each—, two check values (the XOR
of all of them and their sum) and, in front, **a nibble taken from the Z80's R
register**, the memory refresh counter, which is the closest thing to a die
within reach.

The 24 symbols are enciphered with a stream of nibbles taken **from the ROM
itself**: the bytes of page 0 from 0x5000 onwards, starting wherever the random
nibble says. Only then are they turned into letters by adding 0x41.

There are also **six special passwords**, each with its code sitting right
behind it:

| password | what it does |
|---|---|
| `MAXPOINT` | stops checking the thresholds: everything unlocked |
| ` UJM3EDC` | starts with a space, and the letters are two keyboard columns |
| `MITAIYOENDDEMO` | jumps to the ending sequence |
| `HYPEROFF` | sets the variable that puts the pit mechanics to work |
| `ESCON` / `ESCOFF` | turn on and off the permission to cut the replay short |

## The demo plays itself

The demo is not a recorded film: it is **the game running with the joystick
wired to a recording**. The recorder writes down pairs of (frames, mask) every
time the input changes, and the player feeds them in where the joystick port
would normally be.

There are five recordings and only the first one lives in RAM: that is why the
recorder gives up if the pointer leaves 0xC000-0xDEFF.
