
set nocompatible showcmd showmode

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Tells vim to respect .editorconfig files
Plugin 'editorconfig/editorconfig-vim'

" Vim understands fish script
Plugin 'dag/vim-fish'

" Vim understands Typescript
Plugin 'leafgarland/typescript-vim'

" Vim understands MIPS
Plugin 'harenome/vim-mipssyntax'

" Vim can format C and C++
Plugin 'rhysd/vim-clang-format'

" Useful tools for Rust
Plugin 'rust-lang/rust.vim'

call vundle#end()

filetype plugin indent on

set autoread laststatus=1

set ruler number relativenumber
set timeoutlen=300
set encoding=utf-8

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

" Spelling in LaTeX
autocmd FileType tex setlocal spell spelllang=en_us

" Leader is '\'

" Formatting in C++
autocmd FileType c,cpp nnoremap <buffer><leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp vnoremap <buffer><leader>cf :ClangFormat<CR>

" Quick-save
nmap <leader>w :w<CR>
" Show loaded buffers
nmap <leader>; :buffers<CR>
" File explorer
nmap <leader>l :Explore<CR>
" Vsplit to other file fast
nmap <leader>v :vsplit<CR>:Explore<CR>
" Split to other file fast
nmap <leader>s :split<CR>:Explore<CR>

" Sane splits
set splitright splitbelow

" Decent Wildmenu
set wildmenu wildmode=list:longest
set wildignore=.hg,.svm,*~,*.png,*.jpg,*.gif,*.swp,*.hi,*.o

" Manpages
runtime ftplugin/man.vim
