:: VIM BOOTLOADER by Zetaspace
:: [GitHub.com/ZetaSp] [ideaploter@outlook.com]
:: 1.5.0
:: 2021 Jan 10

:start
@echo off
if test"%1"==test"" title New Vim&gvim& exit

set DefaultAnswer=211
:: 1=off, 2=on

set DemoMode=1
:: 1=off, 2=on
:: Pause at the last choice; take a photo.

mode con cols=60 lines=24
title Vim Bootloader
set vimbootanswer=111
set d1=%DefaultAnswer:~0,1%
set d2=%DefaultAnswer:~1,1%
set d3=%DefaultAnswer:~2,1%
echo TASK: %1
echo.
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
:: That stupid mshta was just for a suitable closing delay.
:end
start /min cmd /c timeout /t 1 /nobreak^>nul^&mshta vbscript:createobject("wscript.shell").appactivate("%1")(window.close)
:: Activate the vim window by luck(1 sec delay, works well in most cases).
:: Solve the problen of hiding windows.
exit %vimbootanswer%
goto :EOF

:prtsc
start /min powershell Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{PRTSC}');
:: Call ShareX
goto :EOF



::=========================
:: Add these to your vimrc
::=========================
" Vim User-Config Bootloader
let Vimboot_Title='VIM_'.rand().rand()			" The windows title must start with a letter, or else it cannot be activated.
execute('set titlestring='.Vimboot_Title)
silent exec '!'.$VIM.'\vimboot.cmd '.Vimboot_Title
let Vimboot_Answer=v:shell_error
call timer_start(0,{-> execute('set titlestring=')})	" Unactivated vim window caused some delay. So it just works.
" UTF-8
if Vimboot_Answer[0]==2
	set encoding=utf-8
	set termencoding=cp936
	" language messages zh_CN.utf-8    "<--- For a full Zh-cn version. Otherwise plz keep commented.
	" reload the menu can solve the messy codes.
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif

" ~Files
if Vimboot_Answer[1]==2
	set undofile
	set backup
	set swapfile
else
	set noundofile
	set nobackup
	set noswapfile
endif

" ==MORE==
if Vimboot_Answer[2]==2
	set more
else
	set nomore
endif

" Errorclose
if len(Vimboot_Answer)!=3
	exit
endif