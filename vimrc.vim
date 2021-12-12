" ################################################ "
" ##          __              .___     .__      ## "
" ##    _____/  |______     __| _/____ |  |     ## "
" ##  _/ ___\   __\__  \   / __ |/ __ \|  |     ## "
" ##  \  \___|  |  / __ \_/ /_/ \  ___/|  |__   ## "
" ##   \___  >__| (____  /\____ |\___  >____/   ## "
" ##       \/          \/      \/    \/         ## "
" ##  ---------------------- Prajwal Dev ----   ## "
" ##                                            ## "
" ################################################ "

filetype plugin on

let mapleader = ","

"--------------------------------------------------SET PROPS--------------------------------------------------"
set hidden
set nocompatible
set path+=$PWD/**

set ttyfast
set relativenumber
set number
" iskeyword to set a character as a part of key
"set iskeyword+=\:
set isfname+=:
set modelines=0
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set encoding=utf-8
set scrolloff=8
set autoindent
set showcmd
set wildmenu
set wildmode=list:longest,full
set backspace=indent,eol,start
set laststatus=2
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch
set wrap
set nocursorline
set updatetime=300
set timeoutlen=500
set clipboard=unnamedplus


"Custom undo file.
set nobackup
set noswapfile
set undodir=~/.vim/undodir/
set undofile
" set nowritebackup

"--------------------------------------------------PLUGINS--------------------------------------------------"
if has('nvim') 
    set undodir=~/.config/nvim/undodir/
    set termguicolors
    set signcolumn=yes

    call plug#begin('~/.config/nvim/autoload')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'lukas-reineke/indent-blankline.nvim'
        Plug 'vim-airline/vim-airline'
        Plug 'akinsho/toggleterm.nvim'
    	Plug 'junegunn/fzf'
    	Plug 'junegunn/fzf.vim'
        Plug 'sonph/onehalf', { 'rtp': 'vim' }
        Plug 'kyazdani42/nvim-web-devicons' " for file icons
        Plug 'kyazdani42/nvim-tree.lua'
        Plug 'akinsho/bufferline.nvim'
        Plug 'mhinz/vim-startify'
        Plug 'jiangmiao/auto-pairs'
        Plug 'APZelos/blamer.nvim'
    call plug#end()
    try
        source ~/gitlib/linux_/plugins.vim
    catch
        "No plugin file to source :(
    endtry
else
    call plug#begin()
        Plug 'bling/vim-bufferline'
        Plug 'mhinz/vim-startify'
        Plug 'lukas-reineke/indent-blankline.nvim'
        Plug 'vim-airline/vim-airline'
        Plug 'sonph/onehalf', { 'rtp': 'vim' }
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
        Plug 'jiangmiao/auto-pairs'
    call plug#end()
endif

"---------------------------------------------FILE TYPE CONFIG------------------------------------------------"
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType css setlocal shiftwidth=4 tabstop=4
autocmd FileType vim setlocal shiftwidth=4 tabstop=4
autocmd FileType conf setlocal shiftwidth=4 tabstop=4

"--------------------------------------------------FUNCTIONS--------------------------------------------------"
"Function to Clear History traces or in simple words deletes undo files
function! <SID>ForgetUndo()
    let old_undolevels = &undolevels
    set undolevels=-1
    exe "normal a \<BS>\<Esc>"
    let &undolevels = old_undolevels
    unlet old_undolevels
endfunction

function! CloseBuffer()
    let cb = @%
    if cb != ''
        :bdelete
    else
        :q
    endif
endfunction

" GIT EDITS
function! GitWindow()
    "tabnew
    let cwd = getcwd()
    let cmd = "bash ~/.vim/scripts/gs_symln.sh " . cwd
    let op = system(cmd)
    e ~/tmp/git_files
endfunction


"--------------------------------------------------ALIASES--------------------------------------------------"
" Quick Escape
inoremap jk <Esc>cal cursor(line('.'),virtcol('.'))<cr>
"inoremap kj <Esc>cal cursor(line('.'),virtcol('.'))<cr>

"Quick movements
"inoremap II <Esc>I
"inoremap AA <Esc>A
"inoremap OO <Esc>O
"inoremap oo <Esc>o

nnoremap OO o<Esc>
"nnoremap oo o<Esc>

nnoremap j gj
nnoremap k gk

nnoremap <space> :noh<cr><C-g>

nnoremap <leader>/ :call GitWindow()<cr> 

command -nargs=0 ClearUndo call <SID>ForgetUndo()

"TAB OPERATIONS HERE     @@@@@@ USING BUFFERS NOW @@@@@@
nnoremap <leader>,      :tabprevious<CR>
nnoremap <leader>.      :tabnext<CR>
nnoremap <leader>t      :tabnew<CR>

" BUFFER OPERATIONS
nnoremap <C-a>      :bprevious<CR>
nnoremap <C-d>      :bnext<CR>

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv
nnoremap < <<
nnoremap > >>


"nnoremap <C-s>      :w<CR>:echo "File Saved.."<CR>
"inoremap <C-s>      <Esc>:w<CR>:echo "File Saved.."<CR>a

"Windows operations here
nnoremap <leader>a  :wincmd h<CR>
nnoremap <leader>d  :wincmd l<CR>
nnoremap <leader>w  :wincmd k<CR>
nnoremap <leader>s  :wincmd j<CR>
nnoremap <leader>ps :Lex<cr> :vertical resize 30<CR>
nnoremap <leader>pg :Rg<SPACE>

nnoremap <leader>gf :wincmd gf<cr>
nnoremap <leader>pp :set paste!<cr> 
nnoremap <leader>nn :set nu! <bar> :set rnu!<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:echo $MYVIMRC "sourced.."<CR>

"Visual mode movements
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap <space> <esc>

nnoremap N Nzz
nnoremap n nzz

"Command mode remaps
cnoremap jk <C-u><esc><C-g>

"Plugin Configurations
"THEME
let g:lightline = { 'colorscheme': 'onehalfdark' }
colorscheme onehalfdark

"FZF
nnoremap  :Files<cr>
nnoremap  :GFiles?<cr>

"Powerline
let g:airline_powerline_fonts = 1
let g:airline_section_y = ''
au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%', 'maxlinenr', ' :%3v'])
