
set nocompatible showcmd showmode

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Add vundle plugins here
Plugin 'editorconfig/editorconfig-vim'
Plugin 'dag/vim-fish'
Plugin 'leafgarland/typescript-vim'
Plugin 'harenome/vim-mipssyntax'

call vundle#end()

filetype plugin indent on

set autoread laststatus=1

set ruler number relativenumber
set timeoutlen=300

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

" Quick-save
nmap <leader>w :w<CR>
nmap <leader>; :buffers<CR>

" Sane splits
set splitright splitbelow

" Decent Wildmenu
set wildmenu wildmode=list:longest
set wildignore=.hg,.svm,*~,*.png,*.jpg,*.gif,*.swp,*.hi,*.o
