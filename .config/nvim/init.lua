require('display')
require('keybinds')
require('plugins')

local opt = vim.opt

opt.autowrite = true
-- opt.statusline = 1

-- The correct tab size
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true

opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

-- Fish doesn't play all that well with others
opt.shell='/bin/bash'
opt.spelllang = { 'en_us', 'pl' }

-- Spelling in LaTeX, markdown, and git commits
vim.api.nvim_create_autocmd("FileType", {
    pattern = 'tex,markdown,gitcommit',
    callback = function()
        vim.opt_local.spell = true
    end
})

-- Do not write to orig or pacnew files
vim.api.nvim_create_autocmd('BufRead', {
    pattern = '*.pacnew',
    command = 'set readonly'
})
vim.api.nvim_create_autocmd('BufRead', {
    pattern = '*.orig',
    command = 'set readonly'
})

if vim.fn.globpath('.', 'build.ninja') ~= '' then
    opt.makeprg = 'ninja'
end

vim.opt.completeopt="menuone,noselect,noinsert"
