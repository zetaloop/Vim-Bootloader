## Vim-Bootloader
A simple pre-configuration prompt window displayed every time you start vim.

<img src="https://cdn.jsdelivr.net/gh/ZetaSp/Vim-Bootloader@main/to.png">

### Installation
 - Copy vimboot.cmd next to vimrc, under $VIM.
 - Add the following pattern to your vimrc.
```
" Vim User-Config Bootloader
silent exec '!cmd /c '.$VIM.'\vimboot.cmd'
let Vimbootanswer=v:shell_error

" UTF-8
if Vimbootanswer[0]==2
	set encoding=utf-8
	set termencoding=utf-8
	set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
	" language messages zh_CN.utf-8    "<--- For a full Zh-cn version. Otherwise plz keep commented.
	" reload the menu can solve the messy codes.
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif

" ~Files
if Vimbootanswer[1]==2
	set undofile
	set backup
	set swapfile
else
	set noundofile
	set nobackup
	set noswapfile
endif

" ==MORE==
if Vimbootanswer[2]==2
	set more
else
	set nomore
endif

" Errorclose
if len(Vimbootanswer)!=3
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
 - A = YNN (Default Choice)
