
set nocompatible showmode

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Tells vim to respect .editorconfig files
" Plugin 'editorconfig/editorconfig-vim'

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

set autowrite laststatus=1
set number relativenumber
set timeoutlen=300

" Color stuff
set synmaxcol=500
highlight clear Identifier
highlight PMenu ctermbg=240
set colorcolumn=100
set nowrap

set listchars=nbsp:¬,extends:»,precedes:«,trail:•,tab:> 

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
set si

" Searching details
set showmatch ignorecase smartcase

" Spelling in LaTeX and markdown
set spelllang=en_us
autocmd FileType tex,markdown,gitcommit setlocal spell

" Sane splits
set splitright splitbelow

" Decent Wildmenu
set wildmode=list:longest
set wildignore=.hg,.svm,*~,*.png,*.jpg,*.gif,*.swp,*.hi,*.o

" Use ninja if a ninja.build file exists
if !empty(globpath('.', 'build.ninja'))
    set makeprg=ninja
endif
