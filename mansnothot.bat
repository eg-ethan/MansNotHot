@echo off
setlocal EnableExtensions
rem ===========================================================================
rem  MAN'S NOT HOT -- Windows Edition  ::  launcher
rem
rem  Double-click this file. That's the whole interface.
rem    1. Plays the song from 0:00. Preferred: an .mp3 sitting in THIS folder,
rem       opened in the default media player (no installs, no browser, no ad).
rem       If there's no .mp3 next to the script, it falls back to the video in
rem       your default browser.
rem    2. Opens a NEW, styled Command Prompt window that runs the show
rem       (banner.bat): a pause, the lyric burst, then the fast beat finale,
rem       then a live prompt.
rem
rem  Pure batch: no PowerShell, no admin, no installs.
rem ===========================================================================

rem --- Look for an .mp3 next to this script (first one wins). -----------------
set "AUDIO="
for %%F in ("%~dp0*.mp3") do if not defined AUDIO set "AUDIO=%%~fF"

rem --- Play it in the default player, or fall back to the browser video. ------
if defined AUDIO (
    start "" "%AUDIO%"
) else (
    start "" "https://www.youtube.com/watch?v=avYhvAZxgQc&t=0s"
)

rem --- Let the media player fully open, start playing, and settle its window
rem     FIRST, so the terminal we open next lands IN FRONT of it instead of
rem     behind it. If the player still ends up on top on your machine, raise the
rem     3 here (and trim banner.bat's pre-lyric wait to match, to keep ~5s total
rem     from song start to the first lyric). --------------------------------------
timeout /t 3 /nobreak >nul 2>&1

rem --- Open a NEW Command Prompt window LAST, so it's the foreground window.
rem     cmd /k (not /c) keeps it open at a live prompt after the sequence
rem     finishes. Doubled quotes survive spaces in the folder path. -------------
start "MAN'S NOT HOT" cmd /k ""%~dp0banner.bat""

rem Launcher's job is done; it exits without touching any pre-existing shell.
exit /b 0
