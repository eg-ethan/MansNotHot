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

rem --- Style the window: custom title + green-on-black. Plain, no ASCII art. --
title MAN'S NOT HOT
mode con: cols=100 lines=30 >nul 2>&1
color 0A
cls

rem === Phase 1: the "sauce" bar. Call -> echo, delivered as a quick burst. ====
rem Wait 1.5s after the window opens before the first line, so the lyrics don't
rem start until the video has begun playing. (192.0.2.1 is non-routable, so the
rem ping just waits ~1500ms.) This lyric section runs ~7s in total.
ping -n 1 -w 1500 192.0.2.1 >nul 2>&1
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

rem === Phase 2: the beat drops -- fast scroll for exactly ~28 seconds. ========
rem Two alternating lines at ~3x the earlier speed (pings every 3rd line instead
rem of every line, with a shorter wait). The run length is bounded by the WALL
rem CLOCK, not a line count, so it lasts 28s on any machine no matter how fast it
rem scrolls.
rem   Duration knob: the 2800 below is centiseconds (2800 = 28.00s).
rem   Speed knob: ping every Nth line / the -w value -- fewer pings + lower -w
rem               = faster scroll; more pings + higher -w = slower.
echo(
setlocal EnableDelayedExpansion
call :now _t0
set "flip=0"
set "tick=0"
:beat_loop
if "!flip!"=="0" (
    echo skrrrahh  pap  pap  ka-ka-ka
    set "flip=1"
) else (
    echo skidiki-pap-pap  and-a-pu-pu-pudrrrr-boom
    set "flip=0"
)
set /a "tick+=1"
if !tick! geq 3 (
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
