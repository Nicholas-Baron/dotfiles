-- Load lazy in
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

function lsp_config()
    vim.g.coq_settings = {
         ['display.pum.fast_close'] = false,
         auto_start = true,
    }

    local lsp = require('lspconfig')
    local coq = require('coq')
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      --Enable completion triggered by <c-x><c-o>
      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap=true, silent=true }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
      buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)
    end

    local servers = {'clangd', 'cmake', 'texlab', 'pylsp', 'hls', 'rust_analyzer'}
    for _, server in ipairs(servers) do
        lsp[server].setup(
            coq.lsp_ensure_capabilities{
                on_attach=on_attach,
                flags={
                    debounce_text_changes=100,
                }
            }
        )
    end
end

-- Look into ray-x/lsp_signature.nvim
-- Look into hrsh7th/nvim-cmp 
-- Look into junegunn/fzf.vim
local plugins = {
    'khaveesh/vim-fish-syntax',
    'cespare/vim-toml',
    'leafgarland/typescript-vim',
    'harenome/vim-mipssyntax',
    'neovim/nvim-lspconfig',
    'jremmen/vim-ripgrep',
    'rhysd/vim-clang-format',
    'tpope/vim-fugitive',
    'ryanoasis/vim-devicons',
    {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        dependencies = { 'neovim/nvim-lspconfig' },
        config = lsp_config
    },
    {
        'rust-lang/rust.vim',
        ft = { 'rust' },
        config = function()
            vim.g.rustfmt_autosave = 1
            vim.g.rustfmt_emit_files = 1
            vim.g.rustfmt_fail_silently = 0
        end
    },
    {
        'preservim/nerdtree',
        config = function()
            vim.g.NERDTreeMinimalUI = 1
            vim.g.NERDTreeHighlightCursorline = 0
            -- Start NERDTree when Vim is started without file arguments.
            -- Allows leave the cursor in the other window
            -- autocmd StdinReadPre * let s:std_in=1
            -- autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTreeVCS | wincmd p | endif
            -- 
            -- " Close the tab if NERDTree is the only window remaining in it.
            -- autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
            -- 
            -- " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
            -- autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            --     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
        end
    },
    {
        'preservim/vim-markdown',
        ft = { 'markdown' },
        dependencies = { 'godlygeek/tabular' },
        config = function()
            -- never ever fold!
            vim.g.vim_markdown_folding_disabled = 1
            -- support front-matter in .md files
            vim.g.vim_markdown_frontmatter = 1
            -- 'o' on a list item should insert at same level
            vim.g.vim_markdown_new_list_item_indent = 0
            -- don't add bullets when wrapping:
            -- https://github.com/preservim/vim-markdown/issues/232
            vim.g.vim_markdown_auto_insert_bullets = 0
        end
    }
}

require("lazy").setup(plugins)
