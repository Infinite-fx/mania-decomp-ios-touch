# Patch 1 — iOS & widescreen

Builds the Sonic Mania decompilation for iPhone / iPad and makes it use the whole wide screen.
Works on its own (gamepad / keyboard) and is the base for [patch 2 (touch controls)](../2-touch-controls).

## What it changes

| Area | Change |
| --- | --- |
| Screen | Game width follows the screen's aspect ratio (e.g. 520×240 on a 19.5:9 iPhone): fullscreen, square pixels, no side bars. Never narrower than the original 424 px, so 4:3 iPads keep the original width with bars above/below. |
| Boss fix | **Heavy Shinobi (Press Garden Zone)**: the arena was sized from the screen width, so on screens wider than 424 px the boss could leave the arena and the end-of-act capsule became visible. The arena now keeps its original size. |
| iOS window | Landscape only, fullscreen, home indicator dimmed, sound plays with the silent switch on. |
| Input | The iOS accelerometer is no longer exposed as a joystick (it used to take player 1). |
| Files | Saves / settings in the app's *Documents* folder (visible in the Files app). `Data.rsdk` is read from *Documents* first, then from the app bundle. |
| Build | New `platforms/iOS.cmake` (CMake + Xcode generator, static SDL2, game linked statically), `Info.plist`, original app icons. |

Files: `sonic-mania.patch` (game: `HeavyShinobi.c`) and `rsdkv5.patch` (engine: `SDL2RenderDevice.cpp`, `Reader.cpp`, `UserStorage.cpp`, `cocoaHelpers`, `platforms/iOS*`).

## Apply

```sh
./apply.sh /path/to/Sonic-Mania-Decompilation --no-touch
```

## Bugs & suggestions

Something looks wrong on your screen size, another boss arena breaks on a wide screen, or you have an idea? Please open an [issue in this repository](../../../issues), not in the decompilation repositories. Mention your device model and iOS version.
