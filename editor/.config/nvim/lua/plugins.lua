local function fs_stat(path)
    if vim.uv then
        return vim.uv.fs_stat(path)
    else
        return vim.loop.fs_stat(path)
    end
end

-- Load lazy in
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not fs_stat(lazypath) then
    local out = vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local function lsp_config()
    local lsp = require('lspconfig')
    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        --Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Mappings.
        local opts = { noremap = true, silent = true }

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
        buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    end

    local servers = {
        'clangd',
        'cmake',
        'hls',
        'lua_ls',
        'pylsp',
        'ruff',
        'rust_analyzer',
        'texlab',
        'zls',
    }

    for _, server in ipairs(servers) do
        lsp[server].setup {
            on_attach = on_attach
        }
    end
end

local obsidian_path = vim.fn.expand('~') .. '/documents/notes'

-- Look into ggandor/leap.nvim
-- Look into notjedi/nvim-rooter.lua
-- Look into folke/trouble.nvim
-- Look into ray-x/lsp_signature.nvim
-- Look into junegunn/fzf.vim
-- Look into ThePrimeagen/harpoon
local plugins = {
    'khaveesh/vim-fish-syntax',
    'cespare/vim-toml',
    'leafgarland/typescript-vim',
    'harenome/vim-mipssyntax',
    'jremmen/vim-ripgrep',
    'rhysd/vim-clang-format',
    'tpope/vim-fugitive',
    'ryanoasis/vim-devicons',
    {
        'neovim/nvim-lspconfig',
        config = lsp_config
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.cmd([[colorscheme gruvbox]])
        end
    },
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'neovim/nvim-lspconfig',
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-buffer",
            'hrsh7th/vim-vsnip',
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm { select = true }
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'calc' },
                    { name = 'buffer' }
                }, {
                    { name = 'path' }
                })
            }

            cmp.setup.cmdline(':', {
                sources = cmp.config.sources { { name = 'path' } }
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'epwalsh/obsidian.nvim',
        version = '*',
        event = {
            'BufReadPre ' .. obsidian_path .. '/Personal Notes/**.md'
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            workspaces = {
                {
                    name = 'personal',
                    path = obsidian_path .. '/Personal Notes'
                }
            }
        }
    },
    {
        'rust-lang/rust.vim',
        ft = 'rust',
        config = function()
            vim.g.rustfmt_autosave = 1
            vim.g.rustfmt_emit_files = 1
            vim.g.rustfmt_fail_silently = 0
        end
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } }
            }
        }
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
