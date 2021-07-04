set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'wellle/tmux-complete.vim'
call vundle#end()
filetype plugin indent on
syntax on
set number
set mouse=a
set backspace=indent,eol,start
set laststatus=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
colorscheme Tomorrow-Night-Bright
