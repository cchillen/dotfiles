" Basics
set nocompatible
set ttyfast

" Allow plugins
filetype plugin indent on

" We edit code here. Syntax highlighting and line numbers.
syntax on
set number

" Highlight current line only when window is active.
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Display trailing whitespace.
set list listchars=tab:»·,trail:·,nbsp:·

" Backup and Temporary Files
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/tmp/

" Encodings
set fileencoding=utf-8
set encoding=utf-8

" Smart Splits
set splitbelow
set splitright

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" Easy split navigation. (Normal & Terminal Modes)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

" Intuitive backspace key
set backspace=indent,eol,start

" 4 space tabs
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" HTML
autocmd Filetype html
  \ setlocal tabstop=4
  \ softtabstop=0
  \ expandtab
  \ shiftwidth=4
  \ smarttab

" Python PEP 8 tab and line settings.
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

" Plugins
call plug#begin()

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ALE
Plug 'dense-analysis/ale'

" Theme
Plug 'joshdick/onedark.vim'

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'

" Python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'nvie/vim-flake8', { 'for': 'python' }

" CoffeeScript
Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Git
Plug 'tpope/vim-fugitive'

call plug#end()

" Plugin Dependent Settings
colorscheme onedark
let g:onedark_terminal_italics = 1
let g:airline_theme='onedark'

" ALE Settings
let g:ale_linters = {
            \  'rust': ['rls'],
            \ }
let g:ale_rust_rls_toolchain = 'stable'

let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }

let g:ale_completion_enabled = 1

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" VIM mouse scroll (including tmux)
set mouse=n

" Set cursor by mode

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"Cursor settings:

"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
