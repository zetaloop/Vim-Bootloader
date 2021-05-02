# Vim-Bootloader
A simple pre-configuration prompt window displayed every time you start vim.

### Installation
 - Copy vimboot.cmd next to vimrc, under $VIM.
 - Add the following pattern to your vimrc.
```
" Vim User-Config Bootloader
silent exec '!cmd /c '.$VIM.'\vimboot.cmd'
let Vimbootanswer=v:shell_error[0]

" UTF-8
if v:shell_error[0]==2
	set encoding=utf-8
	set termencoding=utf-8
	set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
	" language messages zh_CN.utf-8    "<--- Add if looking for a full Chinese version. Otherwise plz keep commented.
	" reload the menu can solve the messy codes.
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif

" ~Files
if v:shell_error[1]==1
	set noundofile
	set nobackup
	set noswapfile
endif

" ==MORE==
if v:shell_error[1]==1
	set nomore
endif
```
 - Finished.
