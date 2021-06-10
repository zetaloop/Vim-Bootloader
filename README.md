## Vim-Bootloader
A simple pre-configuration prompt window displayed every time you start vim.

<img src="https://cdn.jsdelivr.net/gh/ZetaSp/Vim-Bootloader@main/to150.png">

### Installation
 - Copy vimboot.cmd next to vimrc, under $VIM.
 - Add the following pattern to your vimrc.
```
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
```
 - Finished.
### Usage
(for example using 211 as DefaultAnswer)
 - Open vim
 - N Disable UTF-8 when running some vim scripts in ASCII or else.
 - Y Enable annoying additional files when not editing a simple file for only once.
 - Y Enable ====MORE==== when running some huge scripts.
 - A = YNN (Default choice)
