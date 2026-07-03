# MAN'S NOT HOT — Windows Edition

A double-clickable Windows terminal gag. Launch it and it:

1. Starts the song at **0:27** in your default browser — Big Shaq,
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

## Playback — starting at 0:27

The launcher opens the song at 0:27 in your default browser:

```
start "" "https://www.youtube.com/watch?v=3M_5oYU-IsU&t=27s"
```

YouTube's `&t=27s` seeks to 0:27 and autoplays — the only way to start at an
exact timestamp with **no installs and no local audio file**.

**The trade-offs (forced by "no installs, no local file"):**

- **Ads.** YouTube may show a pre-roll ad. Nothing in a `start` call can stop
  that — it's only fully ad-free on YouTube **Premium** or with an ad-blocking
  browser/DNS. (This is the cost of needing an exact 0:27 start with zero setup;
  the ad-free option — Spotify — can't seek to 0:27 at all.)
- **No auto-stop at 1:02.** A YouTube watch page can't be told to stop after 35s,
  so the clip keeps playing after the ~35s show ends. Just close the tab.

**Ad-free alternative (from 0:00).** If you'd rather have guaranteed no-ad
playback and can live without the 0:27 start, `mansnothot.bat` has a commented
line to use the Spotify app instead:

```
start "" "spotify:track:2Bwf6O9mGL8RvfM1UYYqQ0"
```

A `spotify:` URI always starts at 0:00 (no seek), so this can't hit 0:27 — it's
purely the ad-free-vs-exact-timestamp trade.

## Requirements

- Stock Windows 10 or 11. Nothing to install.
- A default browser (for the YouTube path) or the Spotify app (for the commented
  alternative).
- **No** "Run as Administrator", **no** PowerShell, **no** execution-policy
  changes. Pure batch.

## Notes / not included

- **Second monitor.** Placing the browser on a specific display isn't possible in
  pure batch (needs PowerShell/native window APIs, ruled out here).
- **Out of scope (v1):** cross-platform packaging.
