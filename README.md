# Mania Decomp — iOS port & touch controls

An **unofficial** patch set for the [Sonic Mania decompilation](https://github.com/RSDKModding/Sonic-Mania-Decompilation) that adds:

- an **iOS build** (iPhone / iPad, SDL2, CMake + Xcode, built in GitHub Actions — no Mac needed);
- **context-aware on-screen touch controls**;
- fixes for widescreen phones.

> [!IMPORTANT]
> **This repository contains no game assets and never will.**
> The decompilation only runs with `Data.rsdk` from **your own, legally purchased copy** of Sonic Mania (Steam / Epic Games Store / etc.).
> Please support the official release. Do not use this project to pirate the game.
>
> Not affiliated with or endorsed by SEGA, Sonic Team, Christian Whitehead, Headcannon, PagodaWest Games or Evening Star.
> *Sonic Mania* and *Sonic the Hedgehog* are trademarks of SEGA.

## Credits

The decompilation is **not** my work. All credit for it goes to its authors:

| Project | Authors |
| --- | --- |
| [Sonic Mania Decompilation](https://github.com/RSDKModding/Sonic-Mania-Decompilation) | Rubberduckycooly, RMGRich and contributors |
| [RSDKv5(U) Decompilation](https://github.com/RSDKModding/RSDKv5-Decompilation) | Rubberduckycooly and chuliRMG, and contributors |
| Original RSDK (Retro Engine) | Evening Star |
| [SDL2](https://www.libsdl.org/) | SDL contributors |

What this repository adds on top: the iOS platform files, the touch controls, and the small game-side hooks/fixes listed below.

## Features

### Touch controls

Classic layout, nothing on screen that you can't use right now:

| Where | What |
| --- | --- |
| Lower left | **D-pad** (8 directions, fixed position, generous touch area) |
| Right half of the screen | **Jump** — the whole half works, the drawn button is just a guide |
| Above-right of jump | **Context button** (Y): gold star = **Super** (shown while airborne with 50 rings + 7 emeralds), cyan arrows = **Encore character swap** (dimmed while a swap isn't possible) |
| Top right | **Pause**, replaced by **Skip** while a cutscene can be skipped |

- Special stages (UFO, Blue Spheres) get D-pad + jump, Mean Bean gets D-pad + two rotate buttons, the pinball stage uses the left/right halves of the screen as flippers.
- Menus keep the game's own native touch support (taps that don't hit a control are passed to the game).
- Connect a gamepad (MFi / Xbox / PlayStation) and the overlay fades out; touch the screen and it comes back.
- Dark, minimal style; controls dim slightly when you're not touching the screen.

### iOS specifics

- Fullscreen landscape, game width follows the screen's aspect ratio (e.g. 520×240 on a 19.5:9 iPhone — square pixels, no side bars).
- Never narrower than the original 424 px: 4:3 iPads get the original width with bars above and below.
- Saves and settings live in the app's *Documents* folder (visible in the Files app).
- `Data.rsdk` is looked up in *Documents* first, then inside the app bundle.
- Sound plays even with the silent switch on.

### Fixes

- **Heavy Shinobi (Press Garden Zone)**: its arena was sized from the screen width, so on screens wider than 424 px the boss could leave the arena. The arena now keeps its original size.
- The iOS accelerometer is no longer exposed as a "gamepad" (it used to steal player 1, leaving touch input on the sidekick).

## Building

### Option A — GitHub Actions (no Mac needed)

1. Fork this repository.
2. Go to **Actions → Build iOS → Run workflow** (or just push a commit).
3. Download the `ManiaTouch-unsigned-noassets` artifact.

The workflow clones the decompilation at a pinned commit, applies the patches and builds an **unsigned** `.ipa` **without any game data**.
As required by the RSDKv5 decompilation license, it is built with `RETRO_DISABLE_PLUS=ON`.

### Option B — on a Mac

```sh
git clone https://github.com/RSDKModding/Sonic-Mania-Decompilation
cd Sonic-Mania-Decompilation
git checkout 9dc699428420d752af9767bdb13f585ee0881bc0
git submodule update --init --recursive
cd ..
./apply.sh Sonic-Mania-Decompilation
```

Then follow the same steps as in [`.github/workflows/build-ios.yml`](.github/workflows/build-ios.yml) (SDL2 + libogg + libtheora sources, `cmake -G Xcode -DCMAKE_SYSTEM_NAME=iOS -DGAME_STATIC=ON ...`, `xcodebuild`).

Tested against Sonic-Mania-Decompilation `9dc6994` (v1.1.1) with RSDKv5 `bd59396`.

## Adding your game data

Take `Data.rsdk` from the install folder of **your own** copy of the game, then either:

- **put it inside the app** before signing: unzip the `.ipa`, copy `Data.rsdk` into `Payload/RSDKv5U.app/`, zip it back; or
- **use the Files app**: install the app, launch it once, then copy `Data.rsdk` to *On My iPhone → Sonic Mania* and relaunch.

Never share an `.ipa` that contains `Data.rsdk`.

## Installing

Sign and install the `.ipa` with any sideloading tool that works with a free Apple ID (for example [Impactor](https://github.com/khcrysalis/Impactor) or [iloader](https://github.com/nab138/iloader) — both run on Linux, Windows and macOS).
With a free Apple ID the signature has to be renewed every 7 days. Enable *Developer Mode* on iOS 16+.

## License

This is a derivative of the decompilations, so it follows **their** licenses — see [`LICENSES/`](LICENSES/):

- [Sonic Mania Decompilation Source Code License v1](LICENSES/SONIC-MANIA-DECOMPILATION-LICENSE.md)
- [RSDKv5(U) Decompilation Source Code License v2.1](LICENSES/RSDKv5-DECOMPILATION-LICENSE.md)

In short: **non-commercial use only**, credit the original authors, **no game assets**, and any pre-built executable must have the **Plus DLC disabled by default**.

---

## Кратко по-русски

Неофициальный набор патчей к [декомпиляции Sonic Mania](https://github.com/RSDKModding/Sonic-Mania-Decompilation): сборка под iOS и сенсорное управление (крестовина, прыжок, контекстная кнопка суперформы и смены персонажа, пауза или пропуск сцены), а также фиксы для широких экранов.

- Декомпиляция — работа её авторов (Rubberduckycooly, chuliRMG, Evening Star и другие), ссылки выше.
- **Файлов игры здесь нет.** Нужен `Data.rsdk` из **своей купленной** копии игры.
- Сборка в GitHub Actions идёт без Mac, с отключённым Plus, как требует лицензия.
- Только некоммерческое использование.
