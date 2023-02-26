require("cchillen.remap")

local augroup = vim.api.nvim_create_augroup('cchillen_cmds', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'help', 'man'},
    group = augroup,
    desc = 'Use q t close the window',
    command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup,
    desc = 'Highlight on yank',
    callback = function(_)
        vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
    end
})
