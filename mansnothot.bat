@echo off
setlocal EnableExtensions
rem ===========================================================================
rem  MAN'S NOT HOT -- Windows Edition  ::  launcher
rem
rem  Double-click this file. That's the whole interface.
rem    1. Plays the song from 0:00. Preferred: an .mp3 sitting in THIS folder,
rem       opened in the default media player (no browser, no ad). Falls back to
rem       the video in your default browser if no .mp3 is present.
rem    2. Opens a NEW, styled Command Prompt window that runs the show
rem       (banner.bat): the lyric burst timed to the mp3, then the beat finale,
rem       then a live prompt.
rem    3. Keeps the terminal IN FRONT of the media player: a tiny VBScript
rem       (stock Windows wscript.exe -- no install, no PowerShell, no execution
rem       policy) re-activates the "MAN'S NOT HOT" window every 250ms for the
rem       first ~6s, so the player can't sit on top of the show.
rem ===========================================================================

rem --- Look for an .mp3 next to this script (first one wins). -----------------
set "AUDIO="
for %%F in ("%~dp0*.mp3") do if not defined AUDIO set "AUDIO=%%~fF"

rem --- Start playback. ---------------------------------------------------------
if defined AUDIO (
    start "" "%AUDIO%"
) else (
    start "" "https://www.youtube.com/watch?v=avYhvAZxgQc&t=0s"
)

rem --- Open the show window immediately (the mp3's vocals start at ~0:00, so the
rem     terminal must exist right away; banner.bat handles the fine timing). ----
start "MAN'S NOT HOT" cmd /k ""%~dp0banner.bat""

rem --- Focus guard: for ~6s, keep pulling the show window to the front so the
rem     media player that's opening underneath can't end up on top of it. -------
set "VBS=%TEMP%\mnh-focus.vbs"
> "%VBS%" echo Set sh = CreateObject("WScript.Shell")
>>"%VBS%" echo For i = 1 To 24
>>"%VBS%" echo sh.AppActivate "MAN'S NOT HOT"
>>"%VBS%" echo WScript.Sleep 250
>>"%VBS%" echo Next
start "" wscript //nologo "%VBS%"

rem Launcher's job is done; it exits without touching any pre-existing shell.
exit /b 0
