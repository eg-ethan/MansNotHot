@echo off
rem ===========================================================================
rem  MAN'S NOT HOT -- Windows Edition  ::  launcher
rem
rem  Double-click this file. That's the whole interface.
rem    1. Opens the song in your default browser (Big Shaq -- Man's Not Hot),
rem       playing from 0:00.
rem    2. Opens a NEW, styled Command Prompt window that runs the show
rem       (banner.bat): a 1.5s beat before the lyrics, the lyric burst, the
rem       labelled real commands, then the fast beat finale, then a live prompt.
rem
rem  Pure batch: no PowerShell, no admin, no installs, no local files. The only
rem  network touch is the single start call that opens the video.
rem ===========================================================================

rem --- Start the song from 0:00 in the default browser (explicit &t=0s seek). --
start "" "https://www.youtube.com/watch?v=avYhvAZxgQc&t=0s"

rem --- Ad-free alternative via the Spotify app (plays a different master, also
rem     from 0:00). To use it, comment out the YouTube line above and uncomment
rem     this one:
rem start "" "spotify:track:2Bwf6O9mGL8RvfM1UYYqQ0"

rem --- Open a NEW Command Prompt window and run the show. cmd /k (not /c) keeps
rem     it open at a live prompt after the sequence finishes. Doubled quotes keep
rem     it working even if the folder path contains spaces. --------------------
start "MAN'S NOT HOT" cmd /k ""%~dp0banner.bat""

rem Launcher's job is done; it exits without touching any pre-existing shell.
exit /b 0
