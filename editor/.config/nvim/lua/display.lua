local opt = vim.opt

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
    nbsp = '¬',
    extends = '»',
    precedes = '«',
    trail = '•',
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
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
