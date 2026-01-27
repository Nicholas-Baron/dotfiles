
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
opt.shell = '/bin/bash'
opt.spelllang = { 'en_us', 'pl' }

opt.completeopt = "menuone,noselect,noinsert"

opt.sidescroll = 10

if vim.fn.globpath('.', 'build.ninja') ~= '' then
    opt.makeprg = 'ninja'
end

