
set runtimepath+=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

Plugin 'neovim/nvim-lspconfig'
lua << EOF
local lsp = require('lspconfig')

lsp.clangd.setup{}
lsp.cmake.setup{}
lsp.rls.setup{}
EOF

set omnifunc=v:lua.vim.lsp.omnifunc
