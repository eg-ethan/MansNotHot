# MAN'S NOT HOT — Windows Edition

A double-clickable Windows terminal gag. Launch it and it:

1. Starts the song at **0:27 for 35 seconds** (0:27 → 1:02) — Big Shaq,
   *Man's Not Hot*.
2. Opens a fresh, styled Command Prompt window that prints the "sauce" bar
   lyric as a quick burst, then runs a short sequence of **real** system
   commands wearing jokey labels — pacing itself to run for roughly the length
   of the song (~35s) and settling at a live prompt at the end.

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
| `banner.bat` | **The show.** The lyric burst + the paced real-command sequence, in that new window. |

## How it works

- **Launcher** starts playback (see *Playback* below), then opens a **new**
  window with `start "MAN'S NOT HOT" cmd /k "…banner.bat"`. `cmd /k` (not `/c`)
  is what leaves you at a live prompt at the end instead of slamming the window
  shut.
- **Phase 1 (0s → ~7.5s):** the "sauce" bar, delivered call → echo, verbatim:

  | Call | Echo |
  | --- | --- |
  | The sauce | flexin' |
  | No ketchup | none |
  | Just sauce | saucy |
  | Raw sauce | ah |
  | Yo, boom, ah | — |

- **Phase 2 (~7.5s → ~35s):** real commands, each under a jokey label, paced
  with `ping` so output stays steady rather than bursting then idling:

  | Label | Real command |
  | --- | --- |
  | reading the OS off man's fitted | `systeminfo \| findstr … "OS Name"/"OS Version"` |
  | locating man on the network | `ipconfig \| findstr /i "IPv4"` |
  | checking man's drip (CPU edition) | `wmic cpu get name` (falls back to `%PROCESSOR_IDENTIFIER%` on Win11 24H2+ where `wmic` is gone) |
  | scanning the endz for ting | `dir "%USERPROFILE%\Desktop"` |

### Timing

`ping -n 1 127.0.0.1` is an instant beat; `ping -n N` (N > 1) waits ~N−1 seconds.
Those `-n` values in `banner.bat` are the tuning knob: `systeminfo` and `wmic`
runtimes vary by machine, so after one test run on your target you can nudge the
`ping -n` numbers up or down to keep the sequence landing near the ~35s mark.

## Playback — start at 0:27, play 35s

The launcher tries three ways, in order, and uses the first that works:

1. **Local file + VLC** — if a `mansnothot.<ext>` file (mp3/m4a/wav/flac/opus/ogg)
   sits next to the script *and* VLC is installed, it plays headless with
   `-I dummy --play-and-exit --start-time=27 --stop-time=62`. Exact 0:27 → 1:02
   window, ad-free, auto-stops. **This is the only way to actually start at 0:27.**
2. **Local file + ffplay** — same file, via ffmpeg's `ffplay -ss 27 -t 35 -autoexit
   -nodisp`. Same exact window.
3. **Spotify fallback** — if there's no local file or seeking player, it opens the
   exact Spotify track `spotify:track:2Bwf6O9mGL8RvfM1UYYqQ0`. **This one starts at
   0:00** — a `spotify:` URI has no seek/position support and can't be stopped from
   batch, so the 0:27 start and 35s auto-stop don't apply on this path.

To get the exact segment: drop your own copy of the song next to the script as
`mansnothot.mp3` (or `.m4a`, etc.) and have [VLC](https://www.videolan.org/) or
ffmpeg installed. (No audio file ships here — bring your own.)

## Requirements

- Stock Windows 10 or 11.
- For the **exact 0:27 → 1:02 window:** VLC or ffmpeg installed, plus a local
  `mansnothot.<ext>` audio file beside the script. Otherwise it falls back to the
  Spotify app (which must be installed + signed in) playing from 0:00.
- **No** "Run as Administrator", **no** PowerShell, **no** execution-policy
  changes. Pure batch.

## Notes / not included

- **Why not just YouTube/Spotify for the exact segment?** YouTube-in-a-browser can
  throw an unskippable pre-roll ad (nothing in a `start` call can guarantee
  otherwise), and a `spotify:` URI can't seek to 0:27 or stop after 35s. A local
  file through a seeking player is the only batch-only way to hit an exact window
  ad-free — hence the order above.
- **Second monitor.** Placing the player on a specific display isn't possible in
  pure batch (needs PowerShell/native window APIs, ruled out here).
- **Out of scope (v1):** cross-platform packaging.
