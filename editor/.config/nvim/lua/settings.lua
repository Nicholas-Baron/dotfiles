local opt = vim.opt

-- Editor behavior
opt.autowrite = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.splitright = true
opt.splitbelow = true
opt.completeopt = "menuone,noselect,noinsert"
opt.sidescroll = 10

-- The correct tab size
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true

-- Fish doesn't play all that well with others
opt.shell = '/bin/bash'
opt.spelllang = { 'en_us', 'pl' }

if vim.fn.globpath('.', 'build.ninja') ~= '' then
    opt.makeprg = 'ninja'
end

-- Display settings
opt.showmatch = true
opt.showmode = true

opt.synmaxcol = 500
opt.colorcolumn = '100'

opt.wrap = false
opt.linebreak = true
opt.number = true
opt.relativenumber = true

opt.winborder = 'rounded'

opt.listchars = {
    nbsp = '⍽',
    extends = '»',
    precedes = '«',
    trail = '·',
    tab = '> ',
}

opt.timeoutlen = 300

opt.wildmode = 'list:longest'
opt.wildignore = {
    '.hg',
    '.svm',
    '*~',
    '*.png',
    '*.jpg',
    '*.gif',
    '*.swp',
    '*.hi',
    '*.o'
}

-- Cool netrw setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
