@echo off
cls
title Vim Bootloader
set vimbootanswer=111
echo [Auto answer in 2 sec]
echo.
echo Options (Default[A]):
echo UTF-8	--ON
echo ~file	--ON
echo =MORE=	--OFF
echo.

:: choice Y:1 N:2

choice /t 2 /d y /c yna /n /m "UTF-8 support ON?	[Y/n]"
if %errorlevel%==1 set /a vimbootanswer=%vimbootanswer%+100
if %errorlevel%==3 set vimbootanswer=221&goto :end

choice /t 2 /d y /c yna /n /m "KEEP .un~ .vim~ .swp?	[Y/n]"
if %errorlevel%==1 set /a vimbootanswer=%vimbootanswer%+10
if %errorlevel%==3 set vimbootanswer=221&goto :end

choice /t 2 /d n /c yna /n /m "==== MORE ==== ?	[y/N]"
if %errorlevel%==1 set /a vimbootanswer=%vimbootanswer%+1
if %errorlevel%==3 set vimbootanswer=221&goto :end

powershell exit
::That stupid pwsh was just for a suitable delay.
:end
exit %vimbootanswer%