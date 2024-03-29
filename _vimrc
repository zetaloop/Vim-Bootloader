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



" Vim User-Config Bootloader
let Vimboot_Title='VIM_'.rand().rand()			" The windows title must start with a letter, otherwise it cannot be activated.
execute('set titlestring='.Vimboot_Title)
silent exec '!'.$VIM.'\vimboot.cmd '.Vimboot_Title
let Vimboot_Answer=v:shell_error
call timer_start(0,{-> execute('set titlestring=')})	" Unactivated vim window caused some delay. So it just works.
" UTF-8
if Vimboot_Answer[0]==2
	set encoding=utf-8
	set termencoding=cp936
	language messages zh_CN.utf-8    "<--- For a full Zh-cn version. Otherwise plz keep commented.
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



" File Encodings
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

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

" LightLine 状态栏常开
set laststatus=2

" 配色
colorscheme github
let g:lightline = { 'colorscheme': 'github' }
set background=light

" 取消自动修末尾换行
set nofixeol


