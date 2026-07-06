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

rem --- Open a NEW Command Prompt window and run the show. cmd /k (not /c) keeps
rem     it open at a live prompt after the sequence finishes. Doubled quotes keep
rem     it working even if the folder path contains spaces. --------------------
start "MAN'S NOT HOT" cmd /k ""%~dp0banner.bat""

rem Launcher's job is done; it exits without touching any pre-existing shell.
exit /b 0
