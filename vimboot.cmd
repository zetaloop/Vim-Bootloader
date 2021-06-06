:start
@echo off
cls


set DefaultAnswer=211


title Vim Bootloader
set vimbootanswer=111
set d1=%DefaultAnswer:~0,1%
set d2=%DefaultAnswer:~1,1%
set d3=%DefaultAnswer:~2,1%
echo [Auto answer in 1 sec]
echo.
echo Options (All Default[A] Restart[R]):
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

choice /t 1 /d %c1% /c ynar /n /m "UTF-8 support ON?	[y/n]"
if %errorlevel%==1 set /a vimbootanswer=%vimbootanswer%+100
if %errorlevel%==3 set vimbootanswer=%DefaultAnswer%&goto :end
if %errorlevel%==4 goto :start

choice /t 1 /d %c2% /c ynar /n /m "KEEP .un~ .vim~ .swp?	[y/n]"
if %errorlevel%==1 set /a vimbootanswer=%vimbootanswer%+10
if %errorlevel%==3 set vimbootanswer=%DefaultAnswer%&goto :end
if %errorlevel%==4 goto :start

choice /t 1 /d %c3% /c ynar /n /m "==== MORE ==== ?	[y/n]"
if %errorlevel%==1 set /a vimbootanswer=%vimbootanswer%+1
if %errorlevel%==3 set vimbootanswer=%DefaultAnswer%&goto :end
if %errorlevel%==4 goto :start

mshta vbscript:CreateObject("Wscript.Shell")(window.close)
::That stupid mshta was just for a suitable delay.
:end
exit %vimbootanswer%
goto :EOF