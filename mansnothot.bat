@echo off
rem ===========================================================================
rem  MAN'S NOT HOT -- Windows Edition  ::  launcher
rem
rem  Double-click this file. That's the whole interface.
rem    1. Starts the song in your default browser (the one start call below).
rem    2. Opens a NEW, styled Command Prompt window that runs the show
rem       (banner.bat) and settles at a live prompt after ~35s.
rem
rem  Pure Windows batch: no PowerShell, no admin, no installs, and no network
rem  access beyond the single start call that opens YouTube.
rem ===========================================================================

rem --- Big Shaq -- Man's Not Hot, straight from the Spotify desktop app.
rem     A spotify: URI launches Spotify and plays the track directly. Going
rem     through the app instead of YouTube-in-a-browser sidesteps the pre-roll
rem     ad that would otherwise shove the whole song (and our timing) back.
rem     Guaranteed ad-free only on Spotify Premium; free tier can still slip in
rem     the occasional audio ad. Requires the Spotify app installed + signed in.
rem     (Old YouTube route, kept for reference: https://youtu.be/avYhvAZxgQc )
start "" "spotify:track:6X5OFBbrsHRsyO1zP7udgr"

rem --- Open a NEW Command Prompt window (not this one) and run the show.
rem     cmd /k -- NOT /c -- so the window stays open at a live prompt once the
rem     ~35s sequence finishes. The doubled quotes keep it working even if the
rem     folder path contains spaces.
start "MAN'S NOT HOT" cmd /k ""%~dp0banner.bat""

rem Launcher's job is done; it exits without touching any pre-existing shell.
exit /b 0
