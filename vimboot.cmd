:start
@echo off
mode con cols=60 lines=24

set DefaultAnswer=211
:: 1=off, 2=on

set DemoMode=1
:: 1=off, 2=on
:: Pause at the last choice; take a photo.

title Vim Bootloader
set vimbootanswer=111
set d1=%DefaultAnswer:~0,1%
set d2=%DefaultAnswer:~1,1%
set d3=%DefaultAnswer:~2,1%
echo [Auto answer for 1 sec]
echo Default[A/D] Reset[R] Close[X]:
echo.
if %d1%==1 (
	set c1=n
	echo UTF-8	--N
) else (
	set c1=y
	echo UTF-8	--Y
)
if %d2%==1 (
	set c2=n
	echo ~file	--N
) else (
	set c2=y
	echo ~file	--Y
)
if %d3%==1 (
	set c3=n
	echo =MORE=	--N
) else (
	set c3=y
	echo =MORE=	--Y
)
echo.

:: choice Y:1 N:2

if %DemoMode%==2 (set t=0)else set t=1

choice /t %t% /d %c1% /c ynadrx /n /m "UTF-8 support ON?	[y/n]"
if %errorlevel%==1 set /a vimbootanswer=%vimbootanswer%+100
if %errorlevel%==3 set vimbootanswer=%DefaultAnswer%&goto :end
if %errorlevel%==4 set vimbootanswer=%DefaultAnswer%&goto :end
if %errorlevel%==5 goto :start
if %errorlevel%==6 goto :EOF

choice /t %t% /d %c2% /c ynadrx /n /m "KEEP .un~ .vim~ .swp?	[y/n]"
if %errorlevel%==1 set /a vimbootanswer=%vimbootanswer%+10
if %errorlevel%==3 set vimbootanswer=%DefaultAnswer%&goto :end
if %errorlevel%==4 set vimbootanswer=%DefaultAnswer%&goto :end
if %errorlevel%==5 goto :start
if %errorlevel%==6 goto :EOF

if %DemoMode%==2 (set t=2&set c3=x&call :prtsc&choice /t 1 /d n>nul)else set t=1

choice /t %t% /d %c3% /c ynadrx /n /m "==== MORE ==== ?	[y/n]"
if %errorlevel%==1 set /a vimbootanswer=%vimbootanswer%+1
if %errorlevel%==3 set vimbootanswer=%DefaultAnswer%&goto :end
if %errorlevel%==4 set vimbootanswer=%DefaultAnswer%&goto :end
if %errorlevel%==5 goto :start
if %errorlevel%==6 goto :EOF

mshta vbscript:CreateObject("Wscript.Shell")(window.close)
::That stupid mshta was just for a suitable delay.
:end
exit %vimbootanswer%
goto :EOF

:prtsc
start /min powershell Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{PRTSC}');
:: Call ShareX
goto :EOF