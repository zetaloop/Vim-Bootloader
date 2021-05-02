" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Remap a few keys for Windows behavior
source $VIMRUNTIME/mswin.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" 设置缓存区文件修改不保存时切换，临时保留在内存（交换文件？）
set hidden

" 开启绝对行号
set number

" 高亮当前行列
set cursorline
set cursorcolumn

" Vim-Plug
call plug#begin('~/.vim/plugged')
Plug 'cormacrelf/vim-colors-github'
Plug 'itchyny/lightline.vim'
call plug#end()

" 配色
colorscheme github
let g:lightline = { 'colorscheme': 'github' }
set background=light

" Vim User-Config Bootloader
silent exec '!cmd /c '.$VIM.'\vimboot.cmd'
let Vimbootanswer=v:shell_error

" UTF-8
if Vimbootanswer[0]==2
	set encoding=utf-8
	set termencoding=utf-8
	set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
	language messages zh_CN.utf-8    "<--- For a full Zh-cn version. Otherwise plz keep commented.
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
