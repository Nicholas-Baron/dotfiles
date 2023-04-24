
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

" Use ripgrep in vim
Plugin 'jremmen/vim-ripgrep'

" File sidebar
Plugin 'preservim/nerdtree'

" git integration
Plugin 'tpope/vim-fugitive'

" Add pretty nerdtree icons
Plugin 'ryanoasis/vim-devicons'

call vundle#end()

filetype plugin indent on

set autoread autowrite laststatus=1
set nojoinspaces
set ruler number relativenumber
set timeoutlen=300
set encoding=utf-8

" Color stuff
syntax on
set synmaxcol=500
set background=dark
highlight clear Identifier
highlight PMenu ctermbg=240
set colorcolumn=100
set nowrap

set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" Cool netrw setup
let g:netrw_banner = 0
let g:netrw_liststyle = 3

let NERDTreeMinimalUI=1
let g:NERDTreeHighlightCursorline = 0
" Start NERDTree when Vim is started without file arguments.
" Allows leave the cursor in the other window
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTreeVCS | wincmd p | endif
" 
" " Close the tab if NERDTree is the only window remaining in it.
" autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" 
" " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

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

" Spelling in LaTeX and markdown
set spelllang=en_us
autocmd FileType tex,markdown,gitcommit setlocal spell
" Toggle Spellcheck (F5 b/c rarely needed)
noremap <F5> :setlocal spell!<CR>

" Leader is '\'

" Show registers
nnoremap <leader>r :registers<CR>
" Show marks
nnoremap <leader>m :marks<CR>

if !has('nvim')
    " Formatting in C++
    autocmd FileType c,cpp,cuda nnoremap <buffer><leader>f :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,cuda vnoremap <buffer><leader>f :ClangFormat<CR>
    " Formatting in Rust
    autocmd FileType rust nnoremap <buffer><leader>f :<C-u>RustFmt<CR>
    autocmd FileType rust vnoremap <buffer><leader>f :RustFmt<CR>
end

" Formatting in Python
" Use system-installed python black
if !has('nvim') && executable('black')
    autocmd FileType python nnoremap <buffer><leader>f :<C-u>w<CR>:!black %<CR>:e<CR>
    autocmd FileType python vnoremap <buffer><leader>f :w<CR>:!black %<CR>:e<CR>
end

" Buffers 1-9 can be accessed with \num
for x in [ 1, 2, 3, 4, 5, 6, 7, 8, 9, ]
    execute 'nnoremap <leader>'.x ':buf' x '<CR>'
    execute 'nnoremap <leader>s'.x ':sbuffer' x '<CR>'
    execute 'nnoremap <leader>v'.x ':vnew<CR>:buffer' x '<CR>'
endfor

" ; = : in normal mode
nnoremap ; :
" Quick-save
nnoremap <leader>w :wa<CR>
" Remove highlighting from searches fast
nnoremap <leader>h :noh<CR>
" Show loaded buffers
nnoremap <leader>; :buffers<CR>
" File explorer
nnoremap <leader>l :Explore<CR>
" Open a bottom terminal
nnoremap <leader>t :terminal<CR>
" Show or hide invisible characters
nnoremap <leader>, :set invlist<CR>

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

" Use ninja if a ninja.build file exists
if !empty(globpath('.', 'build.ninja'))
    set makeprg=ninja
endif

" Manpages
runtime ftplugin/man.vim
