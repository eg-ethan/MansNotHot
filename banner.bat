@echo off
rem ===========================================================================
rem  banner.bat  ::  the "show"
rem  Runs inside the new window the launcher opens (via cmd /k).
rem
rem  Phase 1  (0s -> ~7.3s): the "sauce" bar lyric burst -- call/echo pairs,
rem                          verbatim, each line timed to the vocal onsets
rem                          measured from the bundled mansnothot.mp3.
rem  Phase 2  (~7.3s -> ~35s): the beat drops -- a fast scroll of two alternating
rem                          lines for ~28 seconds, then a live prompt.
rem                          7.3s + 28s ~= the 35.1s clip.
rem
rem  Timing note: ping -n 1 -w <ms> 192.0.2.1 (non-routable) waits ~<ms> ms.
rem ===========================================================================

rem --- Style the window: custom title + red-on-black. Plain, no ASCII art. ----
title MAN'S NOT HOT
mode con: cols=100 lines=30 >nul 2>&1
color 0C
cls

rem === Phase 1: the "sauce" bar, timed to the bundled mp3. =====================
rem Vocal onsets measured from mansnothot.mp3 (audio-relative seconds):
rem   0.00 The sauce   1.09 flexin'    1.81 No ketchup   2.52 none
rem   3.23 Just sauce  3.92 saucy      4.65 Raw sauce    5.36 ah
rem   6.06 Yo, boom, ah    ~7.3 the beat drops
rem The -w gaps below are those onsets minus ~30ms each for ping-spawn overhead.
rem
rem THE ONE SYNC KNOB is the first -w (1200): it covers the time your media
rem player takes to launch and start playing. (Calibrated on the target machine:
rem 3500 was ~2s late, 1500 was ~300ms late.) If the printed lyrics run AHEAD of
rem the audio, raise it; if they LAG behind, lower it.
ping -n 1 -w 1200 192.0.2.1 >nul 2>&1
echo The sauce
ping -n 1 -w 1060 192.0.2.1 >nul 2>&1
echo flexin'
ping -n 1 -w 690 192.0.2.1 >nul 2>&1
echo No ketchup
ping -n 1 -w 680 192.0.2.1 >nul 2>&1
echo none
ping -n 1 -w 680 192.0.2.1 >nul 2>&1
echo Just sauce
ping -n 1 -w 660 192.0.2.1 >nul 2>&1
echo saucy
ping -n 1 -w 700 192.0.2.1 >nul 2>&1
echo Raw sauce
ping -n 1 -w 680 192.0.2.1 >nul 2>&1
echo ah
ping -n 1 -w 670 192.0.2.1 >nul 2>&1
echo Yo, boom, ah
rem Final gap before the beat: 1210 from the mp3 onsets, +900 calibrated on the
rem target machine (raise if the beat scroll starts early, lower if late).
ping -n 1 -w 2110 192.0.2.1 >nul 2>&1

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
