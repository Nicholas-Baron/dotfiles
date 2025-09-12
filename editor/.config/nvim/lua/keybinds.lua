local kset = vim.keymap.set

-- Use ';' to mean ':' (start of command)
kset('n', ';', ':')

-- Toggle Spellcheck (F5 b/c rarely needed)
kset('n', '<F5>', ':setlocal spell!<CR>')

-- Leader is '\'
vim.g.mapleader = '\\'
-- TODO: test out different local leader
vim.g.maplocalleader = '\\'

local leader_map = {
    r = ':registers<CR>',
    m = ':marks<CR>',
    w = ':wa<CR>',
    h = ':noh<CR>',
    [';'] = ':buffers<CR>',
    l = ':Explore<CR>',
    t = ':terminal<CR>',
    [','] = ':set invlist<CR>',
    f = ':lua vim.lsp.buf.format{ timeout_ms = 5000 }<CR>',
}

for key, command in pairs(leader_map) do
    kset('n', '<leader>' .. key, command, { noremap = true })
end

kset('n', 'gre', "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true })

-- access buffers with leader and num
for x = 1, 9 do
    kset('n', '<leader>' .. x, ':buffer ' .. x .. '<CR>')
    kset('n', '<leader>s' .. x, ':sbuffer ' .. x .. '<CR>')
    kset('n', '<leader>v' .. x, ':vnew<CR>:buffer ' .. x .. '<CR>')
end


-- Center the search results after jumping
for _, key in ipairs { 'n', 'N', '*', '#', 'g*' } do
    kset('n', '<silent>' .. key, key .. 'zz')
end
