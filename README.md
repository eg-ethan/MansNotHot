# MAN'S NOT HOT — Windows Edition

A double-clickable Windows terminal gag. Launch it and it:

1. Plays the bundled **`mansnothot.mp3`** from 0:00 in your default media player
   — no browser, no ad. (Falls back to the YouTube video if the mp3 is missing.)
2. Opens a fresh, styled (red-on-black) Command Prompt window that waits ~5s,
   prints the "sauce" bar lyric as a quick burst, then drops the beat — a
   very fast scroll of two long alternating lines for ~28s (≈ the 35s song
   window) — and settles at a live prompt.

A from-scratch Windows analog of the macOS/Linux `mansnothot.sh` gag — not a
port.

## Run it

Double-click **`mansnothot.bat`**. That's the whole interface.

Keep `mansnothot.bat` and `banner.bat` in the **same folder** — the launcher
opens the show window by pointing at `banner.bat` next to it. A desktop shortcut
to `mansnothot.bat` works fine too.

## What's inside

| File | Role |
| --- | --- |
| `mansnothot.bat` | **Launcher.** Starts the song (see *Playback* below), then spawns a new styled Command Prompt window running `banner.bat`. |
| `banner.bat` | **The show.** The lyric burst + the ~28s beat finale, in that new window. |
| `mansnothot.mp3` | **The song** (~35s clip). Played from 0:00 by the launcher. |

## How it works

- **Launcher** starts playback (see *Playback* below), then opens a **new**
  window with `start "MAN'S NOT HOT" cmd /k "…banner.bat"`. `cmd /k` (not `/c`)
  is what leaves you at a live prompt at the end instead of slamming the window
  shut.
- **Phase 1: the lyric burst.** A 5s wait (so the song has started), then the
  "sauce" bar delivered call → echo, verbatim:

  | Call | Echo |
  | --- | --- |
  | The sauce | flexin' |
  | No ketchup | none |
  | Just sauce | saucy |
  | Raw sauce | ah |
  | Yo, boom, ah | — |

- **Phase 2 (~7s → ~35s): the beat drops.** A very fast scroll of two long
  alternating beatbox lines for **28 seconds**, then a live prompt. 7s + 28s ≈
  the 35s song window.

### Timing

The lyric burst uses `ping` as a metronome: `ping -n 1 127.0.0.1` is an instant
beat, `ping -n N` (N > 1) waits ~N−1 seconds, and the leading `ping -n 1 -w 5000`
(line 25 of `banner.bat`) is the 5s pre-roll before the first line.

The **beat finale is bounded by the wall clock, not a line count**, so it runs a
true 28 seconds on any machine regardless of scroll speed. Knobs in `banner.bat`:

- **Duration:** the `2800` in the loop is centiseconds — `2800` = 28.00s.
- **Speed:** it pings only every 30th line (`geq 30`) — ~10× faster than the
  earlier every-3rd-line pace. More pings (lower number) = slower; fewer = faster.

## Playback

The launcher looks for the **first `.mp3` next to it** and plays it in the
default media player from 0:00 — no browser, no ad:

```
for %%F in ("%~dp0*.mp3") do if not defined AUDIO set "AUDIO=%%~fF"
if defined AUDIO ( start "" "%AUDIO%" ) else ( start "" "https://www.youtube.com/watch?v=avYhvAZxgQc&t=0s" )
```

`mansnothot.mp3` ships in the repo, so out of the box it plays that. Drop in a
different `.mp3` (or rename yours) and it'll play instead. If there's no `.mp3`
in the folder at all, it falls back to the YouTube video in your browser.

## Requirements

- Stock Windows 10 or 11. Nothing to install.
- A default app for `.mp3` (any stock Windows media player), or a browser for the
  YouTube fallback.
- **No** "Run as Administrator", **no** PowerShell, **no** execution-policy
  changes. Pure batch.

## Notes / not included

- **Second monitor.** Placing the browser on a specific display isn't possible in
  pure batch (needs PowerShell/native window APIs, ruled out here).
- **Out of scope (v1):** cross-platform packaging.
