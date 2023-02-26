-- Easy split navigation (Normal & Terminal Modes)
vim.keymap.set({'n', 't'}, "<C-J>", "<C-W><C-J>")
vim.keymap.set({'n', 't'}, "<C-K>", "<C-W><C-K>")
vim.keymap.set({'n', 't'}, "<C-L>", "<C-W><C-L>")
vim.keymap.set({'n', 't'}, "<C-H>", "<C-W><C-H>")

-- Visual Studio Backspace Behavior
vim.keymap.set('c', "<C-BS>", "<c-w>")
vim.keymap.set('i', "<C-BS>", "<c-w>")

-- Keep yanked text when pasting in visual mode
vim.keymap.set('v', "p", [["_dP]])
