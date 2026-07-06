@echo off
rem ===========================================================================
rem  banner.bat  ::  the "show"
rem  Runs inside the new window the launcher opens (via cmd /k).
rem
rem  Phase 1  (0s -> ~7s):   the "sauce" bar lyric burst -- call/echo pairs,
rem                          verbatim from Big Shaq's Man's Not Hot.
rem  Phase 2  (~7s -> ~35s): the beat drops -- a fast scroll of two alternating
rem                          lines for ~28 seconds, then a live prompt.
rem                          7s + 28s ~= the 35s song window.
rem
rem  Timing note: ping -n 1 is an instant beat; ping -n N (N>1) waits ~N-1s.
rem ===========================================================================

rem --- Style the window: custom title + red-on-black. Plain, no ASCII art. ----
title MAN'S NOT HOT
mode con: cols=100 lines=30 >nul 2>&1
color 0C
cls

rem === Phase 1: the "sauce" bar. Call -> echo, delivered as a quick burst. ====
rem Wait ~2s here before the first line. The launcher already waited ~3s for the
rem player to open, so that's ~5s total from song start to the first lyric. (Tune
rem this to shift the lyrics; 192.0.2.1 is non-routable, so it just waits ~2000ms.)
ping -n 1 -w 2000 192.0.2.1 >nul 2>&1
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
rem +500ms of extra space before the second half of the bar (Raw sauce onward)
rem so it lines up with the song.
ping -n 1 -w 500 192.0.2.1 >nul 2>&1
echo Raw sauce
ping -n 1 127.0.0.1 >nul
echo ah
ping -n 2 127.0.0.1 >nul
echo Yo, boom, ah
ping -n 1 127.0.0.1 >nul

rem === Phase 2: the beat drops -- fast scroll for exactly ~28 seconds. ========
rem Two long alternating lines blasted very fast (pings only every 30th line, so
rem ~10x faster than the earlier every-3rd-line pace). The run length is bounded
rem by the WALL CLOCK, not a line count, so it lasts 28s on any machine no matter
rem how fast it scrolls.
rem   Duration knob: the 2800 below is centiseconds (2800 = 28.00s).
rem   Speed knob: how often it pings (the "geq 30" below) + the -w value --
rem               fewer pings + lower -w = faster scroll; more pings = slower.
echo(
setlocal EnableDelayedExpansion
call :now _t0
set "flip=0"
set "tick=0"
:beat_loop
if "!flip!"=="0" (
    echo skrrrahh-pap-pap-ka-ka-ka  skibiki-pap-pap-and-a-pu-pu-pudrrrr-boom  skya  du-du-ku-ku-dun-dun
    set "flip=1"
) else (
    echo poom-poom  BOOM  skrrrahhhh  ka-ka-ka-ka  brap-brap-brrra  man's-not-hot  the-ting-goes-SKRRRAHH
    set "flip=0"
)
set /a "tick+=1"
if !tick! geq 30 (
    ping -n 1 -w 10 192.0.2.1 >nul 2>&1
    set "tick=0"
    call :now _tn
    set /a "_el=_tn-_t0"
    if !_el! lss 0 set /a "_el+=360000"
    if !_el! geq 2800 goto :beat_done
)
goto :beat_loop
:beat_done
endlocal

echo(
echo the show's done, but man's still not hot. skrrrahh.
echo(
rem cmd /k (from the launcher) keeps this window at a live prompt from here.
goto :eof

rem --- :now  ->  return time-of-day (this hour) in centiseconds via named var.
rem     Uses MM:SS.CC from %TIME% (ignoring the hour, which cancels in the
rem     elapsed subtraction); the 1xx-100 trick avoids octal on values like 08/09.
:now
setlocal
for /f "tokens=1-4 delims=:., " %%a in ("%TIME%") do set /a "cs=((1%%b-100)*60+(1%%c-100))*100+(1%%d-100)"
endlocal & set "%~1=%cs%"
exit /b
