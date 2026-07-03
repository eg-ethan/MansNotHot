@echo off
rem ===========================================================================
rem  banner.bat  ::  the "show"
rem  Runs inside the new window the launcher opens (via cmd /k).
rem
rem  Phase 1  (0s  -> ~7.5s):  the "sauce" bar lyric burst -- call/echo pairs,
rem                            verbatim from Big Shaq's Man's Not Hot.
rem  Phase 2  (~7.5s -> ~35s): real system commands wearing jokey labels, paced
rem                            with ping so the output stays steady and the whole
rem                            thing lands around the ~35s song length.
rem
rem  Timing note: ping -n 1 is an instant beat; ping -n N (N>1) waits ~N-1s.
rem  These -n values are the tuning knob -- nudge them after a test run if a
rem  given machine's systeminfo/wmic runs faster or slower than expected.
rem ===========================================================================

rem --- Style the window: custom title + green-on-black. Plain, no ASCII art. --
title MAN'S NOT HOT
mode con: cols=100 lines=30 >nul 2>&1
color 0A
cls

rem === Phase 1: the "sauce" bar. Call -> echo, delivered as a quick burst. ====
echo The sauce
ping -n 1 127.0.0.1 >nul
echo flexin'
ping -n 2 127.0.0.1 >nul
echo No ketchup
ping -n 1 127.0.0.1 >nul
echo none
ping -n 2 127.0.0.1 >nul
echo Just sauce
ping -n 1 127.0.0.1 >nul
echo saucy
ping -n 2 127.0.0.1 >nul
echo Raw sauce
ping -n 1 127.0.0.1 >nul
echo ah
ping -n 2 127.0.0.1 >nul
echo Yo, boom, ah
ping -n 1 127.0.0.1 >nul

rem === Phase 2: real commands with jokey labels, filling ~7.5s -> ~35s. =======
echo(
echo ^>^> reading the OS off man's fitted
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
ping -n 7 127.0.0.1 >nul

echo(
echo ^>^> locating man on the network
ipconfig | findstr /i "IPv4"
ping -n 7 127.0.0.1 >nul

echo(
echo ^>^> checking man's drip (CPU edition)
wmic cpu get name
ping -n 7 127.0.0.1 >nul

echo(
echo ^>^> scanning the endz for ting
dir "%USERPROFILE%\Desktop"
ping -n 6 127.0.0.1 >nul

echo(
echo the show's done, but man's still not hot. skrrrahh.
echo(
rem cmd /k (from the launcher) keeps this window at a live prompt from here.
