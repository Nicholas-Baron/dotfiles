
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
" Toggle Spellcheck (F5 b/c rarely needed)
noremap <F5> :setlocal spell! spelllang=en_us<CR>

" Leader is '\'

" Show registers
nnoremap <leader>r :registers<CR>
" Show marks
nnoremap <leader>m :marks<CR>

" Formatting in C++
autocmd FileType c,cpp nnoremap <buffer><leader>f :<C-u>ClangFormat<CR>
autocmd FileType c,cpp vnoremap <buffer><leader>f :ClangFormat<CR>
" Formatting in Rust
autocmd FileType rust nnoremap <buffer><leader>f :<C-u>RustFmt<CR>
autocmd FileType rust vnoremap <buffer><leader>f :RustFmt<CR>

" Quick-save
nnoremap <leader>w :wa<CR>
" Remove highlighting from searches fast
nnoremap <leader>h :noh<CR>
" Show loaded buffers
nnoremap <leader>; :buffers<CR>
" File explorer
nnoremap <leader>l :Explore<CR>
" Vsplit to other file fast
nnoremap <leader>v :vnew<CR>:Explore<CR>
" Split to other file fast
nnoremap <leader>s :new<CR>:Explore<CR>
" Open a bottom terminal
nnoremap <leader>t :terminal<CR>

" Sane splits
set splitright splitbelow

" Decent Wildmenu
set wildmenu wildmode=list:longest
set wildignore=.hg,.svm,*~,*.png,*.jpg,*.gif,*.swp,*.hi,*.o

" Center search results after jumping to them
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Manpages
runtime ftplugin/man.vim
