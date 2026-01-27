require('display')
require('keybinds')
require('configs')

if not vim.g.vscode then
    require('plugins')
end


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

