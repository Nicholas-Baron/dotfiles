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
        "--branch=stable",
        lazypath,
    }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local obsidian_path = vim.fn.expand('~') .. '/documents/notes'

local plugins = {
    -- Colorscheme
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.cmd([[colorscheme gruvbox]])
        end
    },

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup {}
        end
    },

    -- Syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate'
    },

    -- LSP & Completion
    { 'neovim/nvim-lspconfig', config = false },
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

    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.2.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },

    -- Notes
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

    -- Language support
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
        'preservim/vim-markdown',
        ft = { 'markdown' },
        dependencies = { 'godlygeek/tabular' },
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_new_list_item_indent = 0
            vim.g.vim_markdown_auto_insert_bullets = 0
        end
    },

    -- Syntax & formatting
    'khaveesh/vim-fish-syntax',
    'cespare/vim-toml',
    'leafgarland/typescript-vim',
    'harenome/vim-mipssyntax',
    'jremmen/vim-ripgrep',
    'rhysd/vim-clang-format',
    'tpope/vim-fugitive',
}

require("lazy").setup(plugins)
