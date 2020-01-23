
set nocompatible showcmd showmode

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Add vundle plugins here
Plugin 'editorconfig/editorconfig-vim'

call vundle#end()

filetype plugin indent on

set autoread laststatus=1

set ruler number

" Color stuff
set t_Co=256
syntax on
set background=dark
set colorcolumn=100

" The correct tab size
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Indent 'helpers'
set ai si

" set cursorline
" set foldmethod=indent

" Searching details
set showmatch incsearch hlsearch ignorecase smartcase

