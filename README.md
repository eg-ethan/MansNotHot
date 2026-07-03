# MAN'S NOT HOT — Windows Edition

A double-clickable Windows terminal gag. Launch it and it:

1. Starts the song in the Spotify desktop app — Big Shaq, *Man's Not Hot*.
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
| `mansnothot.bat` | **Launcher.** Opens the song in the Spotify app, then spawns a new styled Command Prompt window running `banner.bat`. |
| `banner.bat` | **The show.** The lyric burst + the paced real-command sequence, in that new window. |

## How it works

- **Launcher** fires one `start "" "spotify:track:…"` (the Spotify URI launches
  the app and plays the track), then opens a **new** window with
  `start "MAN'S NOT HOT" cmd /k "…banner.bat"`. `cmd /k` (not `/c`) is what leaves
  you at a live prompt at the end instead of slamming the window shut.
- **Phase 1 (0s → ~7.5s):** the "sauce" bar, delivered call → echo, verbatim
  (an opening burst — not lip-synced to the audio; see *Notes* below):

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

- Stock Windows 10 or 11. Nothing to install for the script itself.
- The **Spotify desktop app** installed and signed in (that's the "player").
  Guaranteed ad-free playback needs Spotify **Premium** — on the free tier
  Spotify can still slip in the occasional audio ad.
- **No** "Run as Administrator", **no** PowerShell, **no** execution-policy
  changes. Pure batch.

## Notes / not included

- **Why Spotify, not YouTube.** YouTube-in-a-browser can throw a pre-roll ad,
  and nothing in a plain `start` call can *guarantee* it won't — an ad shoves the
  song (and the timing) back. The Spotify app plays the exact track directly, so
  it's used instead. The old YouTube URL is kept as a comment in `mansnothot.bat`
  if you'd rather switch back.
- **Lyric sync.** The on-screen "sauce" burst is **not** lip-synced to the audio.
  In the full Spotify track the sauce bar lands mid-song, and a `spotify:` URI
  can't seek to a timestamp — so the terminal plays its ~35s bit over the song's
  intro. (Lip-sync only worked with the specific YouTube upload that *opened* on
  the sauce bar; keeping the ad off meant giving that up.)
- **Second monitor.** Placing the app/player on a specific display isn't possible
  in pure batch (it needs PowerShell/native window APIs, which the pure-batch
  requirement rules out), so playback just lands wherever Spotify opens.
- **Out of scope (v1):** cross-platform packaging, and local-file audio
  integration.
