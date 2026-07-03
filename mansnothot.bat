@echo off
setlocal EnableExtensions
rem ===========================================================================
rem  MAN'S NOT HOT -- Windows Edition  ::  launcher
rem
rem  Double-click this file. That's the whole interface.
rem    1. Starts the song at the right spot (0:27, for 35s -> 0:27..1:02).
rem    2. Opens a NEW, styled Command Prompt window that runs the show
rem       (banner.bat) and settles at a live prompt after ~35s.
rem
rem  About "start at 0:27 for 35s":
rem    A Spotify spotify: URI CANNOT seek -- it always starts a track at 0:00,
rem    and nothing in batch can stop it after 35s. So to hit the exact window we
rem    play a LOCAL audio file through a seeking player (VLC or ffplay), which
rem    starts at 0:27, auto-stops at 1:02, and never shows an ad. If neither the
rem    file nor a player is present, we fall back to opening the exact Spotify
rem    track (which just plays from 0:00).
rem ===========================================================================

rem --- The exact segment: start at 27s, play for 35s (so 27s -> 62s). ---------
set "START_SEC=27"
set "DUR_SEC=35"
set /a "STOP_SEC=START_SEC + DUR_SEC"

rem --- Local audio file: drop your own copy named mansnothot.<ext> next to this
rem     script (mp3/m4a/wav/flac/opus/ogg) to get the exact, ad-free window. ----
set "AUDIO="
for %%E in (mp3 m4a wav flac opus ogg) do if not defined AUDIO if exist "%~dp0mansnothot.%%E" set "AUDIO=%~dp0mansnothot.%%E"

rem --- Your exact Spotify track (zero-setup fallback; can't seek to 0:27). -----
set "SPOTIFY_URI=spotify:track:2Bwf6O9mGL8RvfM1UYYqQ0"

rem --- Find a seeking player: VLC first (usual install spots + PATH), then
rem     ffmpeg's ffplay on PATH. --------------------------------------------------
set "VLC="
if exist "%ProgramFiles%\VideoLAN\VLC\vlc.exe" set "VLC=%ProgramFiles%\VideoLAN\VLC\vlc.exe"
if not defined VLC if exist "%ProgramFiles(x86)%\VideoLAN\VLC\vlc.exe" set "VLC=%ProgramFiles(x86)%\VideoLAN\VLC\vlc.exe"
if not defined VLC for %%V in (vlc.exe) do if not defined VLC if exist "%%~$PATH:V" set "VLC=%%~$PATH:V"

set "FFPLAY="
for %%F in (ffplay.exe) do if not defined FFPLAY if exist "%%~$PATH:F" set "FFPLAY=%%~$PATH:F"

rem --- Start playback the best way available. ---------------------------------
if defined AUDIO if defined VLC (
    rem VLC, headless, exact window, quits itself at 1:02.
    start "" /b "%VLC%" -I dummy --no-video --play-and-exit --start-time=%START_SEC% --stop-time=%STOP_SEC% "%AUDIO%"
    goto :show
)
if defined AUDIO if defined FFPLAY (
    rem ffplay, no window, seek to 27s, play 35s, then auto-exit.
    start "" /b "%FFPLAY%" -nodisp -autoexit -ss %START_SEC% -t %DUR_SEC% "%AUDIO%"
    goto :show
)

rem Fallback: open the exact Spotify track. NOTE: starts at 0:00 (URI can't seek).
start "" "%SPOTIFY_URI%"

:show
rem --- Open a NEW Command Prompt window and run the show. cmd /k (not /c) keeps
rem     it open at a live prompt after the ~35s sequence finishes. ---------------
start "MAN'S NOT HOT" cmd /k ""%~dp0banner.bat""

rem Launcher's job is done; it exits without touching any pre-existing shell.
exit /b 0
