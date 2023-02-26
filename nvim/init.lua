require("cchillen")

-- Packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end


require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true})
        end,
    }

    -- LSP & Autocompletion
    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- LSP Status Updates
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',

            -- LSP Source for nvim-cmp
            'hrsh7th/cmp-nvim-lsp',

            -- Snippets
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
        },
    }

    -- Git
    use 'tpope/vim-fugitive'

    -- FZF
    use {
        'junegunn/fzf',
        run = ":call fzf#install()",
        'junegunn/fzf.vim',
    }

    -- Visual
    use 'navarasu/onedark.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
    local has_plugins, plugins = pcall(require, 'custom.plugins')
    if has_plugins then
        plugins(use)
    end

    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

-- Line Numbers & signcolumn
vim.opt.number = true
vim.opt.signcolumn = "yes"

-- Make Terminal Vim-like
--vim.cmd [[ab term split|terminal<CR>]]

vim.api.nvim_create_augroup("TermSettings", {clear = true})
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = "*",
    command = "startinsert | setlocal nonumber signcolumn=no",
    group = TermSettings
})

-- Highlight current line only when window is active.
vim.opt.cursorline = true

local cursorGrp = vim.api.nvim_create_augroup("CursorLine", {clear = true })
vim.api.nvim_create_autocmd(
{ "InsertLeave", "WinEnter" },
{ pattern = "*", command = "set cursorline", group = cursorGrp }
)
vim.api.nvim_create_autocmd(
{ "InsertEnter", "WinLeave" },
{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- Display trailing whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '»·', trail = '·', nbsp = '␣' }

-- Smart Splits
vim.o.splitbelow = true
vim.o.splitright = true

-- WSL Yank Support
vim.api.nvim_exec([[
let s:clip = '/mnt/c/Windows/System32/clip.exe' " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
    endif
    ]], false)

    -- 4 Space Tabs
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.smarttab = true

    -- Mouse Scroll (including tmux)
    vim.o.mouse = 'a'

    -- Blinking Cursor
    vim.opt.guicursor:append({
        "a:blinkwait700-blinkoff400-blinkon250",
    })

    -- Search
    vim.opt.hlsearch = false
    vim.opt.incsearch = true
    vim.opt.ignorecase = true
    vim.opt.smartcase = true

    -- Ignore
    vim.opt.wildignore:append { '*.o', '*.a', '__pycache__', '*.pyc', 'node_modules' }

    -- Decrease update time
    vim.opt.updatetime = 500

    -- Scrolloff
    vim.opt.scrolloff = 5

    -- Backup
    vim.opt.backup = true
    vim.opt.backupdir = vim.env.HOME ..'/.nvim/backup'
    vim.opt.directory= vim.env.HOME .. '/.nvim/tmp'

