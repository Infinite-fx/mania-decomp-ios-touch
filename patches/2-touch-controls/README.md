# Patch 2 — touch controls

Context-aware on-screen controls: only what you can use right now is on screen.
**Requires [patch 1](../1-ios-widescreen)** (apply it first).

## Layout

| Where | Control |
| --- | --- |
| Lower left | D-pad: 8 directions, fixed position, generous touch area |
| Right half of the screen | Jump: the whole half works, the drawn button is just a guide |
| Above-right of jump | Context button (Y): gold star = Super (airborne, 50 rings, 7 emeralds), cyan arrows = Encore character swap (dimmed while a swap isn't possible) |
| Top right | Pause, replaced by Skip while a cutscene can be skipped |

- Special stages: D-pad + jump. Mean Bean: D-pad + two rotate buttons. Pinball: left/right half of the screen are the flippers.
- Menus use the game's own touch support; taps that don't hit a control go to the game.
- A gamepad press hides the overlay, touching the screen brings it back.

## How it works

- `RSDK/Input/Touch/TouchInputDevice.cpp` is a new input device: it reads fingers from SDL, maps them to controller buttons, forwards the remaining touches to the game and draws the overlay with `SDL_RenderGeometry` at native resolution.
- The game reports what is possible right now through `SonicMania/MobileTouchHints.h` (small hooks in `Player.c`, `UFO_Player.c`, `BSS_Player.c`, `PuyoBean.c`, `PBL_Player.c`, `CutsceneSeq.c`, `PauseMenu.c`), enabled only with `MANIA_MOBILE_TOUCH=1` (set by the iOS build). Other platforms are unaffected.

## Apply

```sh
./apply.sh /path/to/Sonic-Mania-Decompilation
```

## Bugs & suggestions

A button shows up when it shouldn't (or doesn't when it should), something is hard to press, or you have an idea for the layout or style? Please open an [issue in this repository](../../../issues), not in the decompilation repositories. Screenshots help a lot.
