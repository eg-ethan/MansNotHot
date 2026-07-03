# MAN'S NOT HOT — Windows Edition

A double-clickable Windows terminal gag. Launch it and it:

1. Starts the song in your default browser — Big Shaq, *Man's Not Hot*.
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
| `mansnothot.bat` | **Launcher.** Opens the YouTube link, then spawns a new styled Command Prompt window running `banner.bat`. |
| `banner.bat` | **The show.** The lyric burst + the paced real-command sequence, in that new window. |

## How it works

- **Launcher** makes exactly one network-touching call — `start "" "<youtube url>"` —
  then opens a **new** window with `start "MAN'S NOT HOT" cmd /k "…banner.bat"`.
  `cmd /k` (not `/c`) is what leaves you at a live prompt at the end instead of
  slamming the window shut.
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

## Requirements

- Stock Windows 10 or 11. Nothing to install.
- **No** "Run as Administrator", **no** PowerShell, **no** execution-policy
  changes. Pure batch.

## Notes / not included

- **Second monitor.** Placing the browser on a specific display isn't possible
  in pure batch (it needs PowerShell/native window APIs, which the pure-batch
  requirement rules out), so the song just opens in the default browser on
  whatever display it lands on.
- **Lyric sync.** The show window currently opens immediately after the video.
  If you want the on-screen lyric burst to line up precisely with the audio, we
  need the timestamp of where the "sauce" bar hits in this specific upload — then
  a matching `timeout` before the window opens will line them up.
- **Out of scope (v1):** cross-platform packaging, and any Spotify/local-file
  audio integration — YouTube in the browser is the "player."
