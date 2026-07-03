@echo off
rem ===========================================================================
rem  MAN'S NOT HOT -- Windows Edition  ::  launcher
rem
rem  Double-click this file. That's the whole interface.
rem    1. Starts the song in your default browser at 0:27 (Big Shaq -- Man's Not
rem       Hot), via a YouTube link with a start-time parameter.
rem    2. Opens a NEW, styled Command Prompt window that runs the show
rem       (banner.bat) and settles at a live prompt after ~35s.
rem
rem  Why YouTube (and the trade-off):
rem    You wanted "start at 0:27" with NO installs and NO local audio file. The
rem    only zero-setup way to begin at an exact timestamp is a YouTube watch URL
rem    with &t=27s -- it seeks to 0:27 and autoplays in the default browser.
rem    Cost: YouTube may show a pre-roll ad (skippable, or gone entirely on
rem    YouTube Premium / an ad-blocking browser or DNS), and the watch page has
rem    no way to auto-stop at 1:02 -- the clip just keeps playing after the ~35s
rem    show ends. (A spotify: URI can't do 0:27 at all -- it always starts a
rem    track at 0:00 -- so it can't meet this requirement. It's kept below as a
rem    commented, ad-free-but-from-0:00 alternative.)
rem ===========================================================================

rem --- Start the song at 0:27. The URL is quoted so the & doesn't break parsing.
start "" "https://www.youtube.com/watch?v=3M_5oYU-IsU&t=27s"

rem --- Ad-free alternative (plays from 0:00, cannot seek to 0:27). To use it,
rem     comment out the YouTube line above and uncomment this one:
rem start "" "spotify:track:2Bwf6O9mGL8RvfM1UYYqQ0"

rem --- Open a NEW Command Prompt window and run the show. cmd /k (not /c) keeps
rem     it open at a live prompt after the ~35s sequence finishes. Doubled quotes
rem     keep it working even if the folder path contains spaces. -----------------
start "MAN'S NOT HOT" cmd /k ""%~dp0banner.bat""

rem Launcher's job is done; it exits without touching any pre-existing shell.
exit /b 0
