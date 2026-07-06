# MAN'S NOT HOT — Windows Edition

A double-clickable Windows terminal gag. Launch it and it:

1. Plays the bundled **`mansnothot.mp3`** from 0:00 in your default media player
   — no browser, no ad. (Falls back to the YouTube video if the mp3 is missing.)
2. Opens a fresh, styled (red-on-black) Command Prompt window that prints the
   "sauce" bar lyric line-by-line **in time with the audio**, then drops the beat
   — a flat-out ~28s scroll of zig-zagging beatbox lines — and settles at a live
   prompt.

A from-scratch Windows analog of the macOS/Linux `mansnothot.sh` gag — not a
port. Pure batch: no installs, no admin, no PowerShell, no execution-policy
changes.

## Run it

Double-click **`mansnothot.bat`**. That's the whole interface.

Keep all the files **in the same folder** — the launcher opens the show by
pointing at `banner.bat` next to it, and plays the first `.mp3` it finds beside
it. (To make it launchable from your desktop: right-click `mansnothot.bat` →
**Send to → Desktop (create shortcut)**.)

## Get it onto a Windows PC

No `git` needed — download the folder as a ZIP:

- **Direct link:**
  `https://github.com/eg-ethan/MansNotHot/archive/refs/heads/claude/mansnothot-windows-q4tr45.zip`
- **Or** on the repo page: **Code ▸ Download ZIP** (make sure the branch selector
  shows `claude/mansnothot-windows-q4tr45`).

Extract it, open the folder, and double-click `mansnothot.bat`. If you have `git`,
`git clone https://github.com/eg-ethan/MansNotHot.git` works too.

## What's inside

| File | Role |
| --- | --- |
| `mansnothot.bat` | **Launcher.** Starts the song, opens the show window, and keeps it in front of the player. |
| `banner.bat` | **The show.** The audio-synced lyric burst + the ~28s beat finale. |
| `mansnothot.mp3` | **The song** (~35s clip). Played from 0:00 by the launcher. |
| `LICENSE` | MIT for the scripts. (The mp3 is **not** covered — see *Credits & licensing*.) |

## How it works

- **Launcher** starts playback, opens a **new** window with
  `start "MAN'S NOT HOT" cmd /k "…banner.bat"` (`cmd /k`, not `/c`, is what leaves
  you at a live prompt instead of slamming the window shut), then runs a tiny
  `wscript.exe` focus guard so the terminal stays in front of the player.
- **Phase 1: the lyric burst.** A short wait (the sync knob — see *Timing*), then
  the "sauce" bar delivered call → echo, verbatim:

  | Call | Echo |
  | --- | --- |
  | The sauce | flexin' |
  | No ketchup | none |
  | Just sauce | saucy |
  | Raw sauce | ah |
  | Yo, boom, ah | — |

- **Phase 2 (~7.3s → ~35s): the beat drops.** A flat-out scroll of six beatbox
  line variants for **28 seconds** — the variants zig-zag their indentation
  (right, then back left) with mixed lengths and case, which reads far faster and
  more chaotic than a fixed two-line wall — then a live prompt. 7.3s + 28s ≈ the
  35s clip.

### Timing

The lyric lines are timed to **vocal onsets measured from `mansnothot.mp3`
itself** (waveform analysis of the clip):

| Time in clip | Line | | Time in clip | Line |
| --- | --- | --- | --- | --- |
| 0.00s | The sauce | | 3.92s | saucy |
| 1.09s | flexin' | | 4.65s | Raw sauce |
| 1.81s | No ketchup | | 5.36s | ah |
| 2.52s | none | | 6.06s | Yo, boom, ah |
| 3.23s | Just sauce | | ~7.3s | *the beat drops* |

Each `ping -n 1 -w <ms> 192.0.2.1` in `banner.bat` reproduces those gaps (minus
~30ms apiece for ping-spawn overhead). **The one sync knob** is the first `-w`
(currently `1200`, calibrated by ear on the target machine): it absorbs however
long your media player takes to launch and start playing. If the printed lyrics
run ahead of the audio, raise it; if they lag, lower it. The final gap before the
beat (`-w 2110`) is the second knob, tuned so the scroll lands on the drop.

The **beat finale is bounded by the wall clock, not a line count**, so it runs a
true 28 seconds on any machine regardless of scroll speed. Knobs in `banner.bat`:

- **Duration:** the `2800` in the loop is centiseconds — `2800` = 28.00s.
- **Speed:** it pings only every 90th line (`geq 90`), so the scroll runs near
  the console's max render speed. More pings (lower number) = slower; fewer =
  faster.

## Playback

The launcher plays the **first `.mp3` next to it** in the default media player
from 0:00 — no browser, no ad:

```bat
for %%F in ("%~dp0*.mp3") do if not defined AUDIO set "AUDIO=%%~fF"
if defined AUDIO ( start "" "%AUDIO%" ) else ( start "" "https://www.youtube.com/watch?v=avYhvAZxgQc&t=0s" )
```

`mansnothot.mp3` ships here, so out of the box it plays that. Drop in a different
`.mp3` (or rename yours) and it plays instead. With no `.mp3` in the folder, it
falls back to the YouTube video in your browser.

## Requirements

- Stock Windows 10 or 11. Nothing to install.
- A default app for `.mp3` (any stock Windows media player), or a browser for the
  YouTube fallback.
- **No** "Run as Administrator", **no** PowerShell, **no** execution-policy
  changes. Pure batch (plus stock `wscript.exe` for the focus guard).

## Troubleshooting

- **Lyrics run ahead of / behind the audio.** Adjust the first `-w` in
  `banner.bat` (the sync knob): raise it if lyrics lead the audio, lower it if
  they lag. ~300 ≈ 300ms.
- **The beat scroll starts early / late.** Adjust the final `-w 2110` before the
  beat loop only — this moves the beat without touching the lyric timing.
- **Terminal opens behind the media player.** The `wscript.exe` focus guard
  usually prevents this; if your player is slow to open, increase the loop count
  in the focus VBScript (the `For i = 1 To 24`) so it guards for longer.
- **Windows SmartScreen warns about the `.bat`.** Expected for a downloaded
  script — click **More info → Run anyway**. The scripts are plain text; read
  them first if you like.
- **It opens the browser instead of playing the mp3.** There's no `.mp3` in the
  folder (or it didn't extract next to the `.bat` files). Put one there.

## Notes / not included

- **Terminal stays in front.** The launcher writes a small VBScript to `%TEMP%`
  and runs it with stock `wscript.exe` (built into every Windows 10/11 — no
  install, no PowerShell, no execution policy). It re-activates the "MAN'S NOT
  HOT" window every 250ms for ~6s so the media player opening underneath can't
  end up on top of the show.
- **Second monitor.** Placing the player on a specific display isn't possible in
  pure batch (needs PowerShell/native window APIs, ruled out here).
- **Out of scope:** cross-platform packaging.

## Credits & licensing

- **Scripts** (`mansnothot.bat`, `banner.bat`): MIT — see `LICENSE`. Do what you
  like.
- **The song.** `mansnothot.mp3` is a clip of *Man's Not Hot* by **Big Shaq
  (Michael Dapaah)** — © its rights holders. It is **not** covered by the MIT
  license and is included here only as a personal demo. If you publish or share
  this project, don't redistribute the audio: delete `mansnothot.mp3` and let each
  user drop in their own copy (the launcher auto-detects any `.mp3` in the
  folder), or point the fallback at the official video.
