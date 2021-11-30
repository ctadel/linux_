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

set hidden
set nocompatible
set path+=$PWD/**

"Custom undo file.
set nobackup
set noswapfile
set undodir=~/.vim/undodir
set undofile
" set nowritebackup

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
set ttyfast
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
:set list lcs=tab:\|\ 


if has('nvim') 
    call plug#begin('~/.vim/plugged')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'drewtempelmeyer/palenight.vim'
        Plug 'vim-airline/vim-airline'
        Plug 'akinsho/toggleterm.nvim'
    call plug#end()

    "coc configurations 
    " use <tab> for trigger completion and navigate to the next complete item
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <Tab>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<Tab>" :
          \ coc#refresh()

    "palenight configurations
    set background=dark
    colorscheme palenight
    let g:lightline = { 'colorscheme': 'palenight' }
    let g:airline_theme = "palenight"
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let g:palenight_terminal_italics=1
    let g:palenight_color_overrides = {
    \    'black': { 'gui': '#000000', "cterm": "0", "cterm16": "0" },
    \}

    set mouse=a
    nnoremap <silent><c-_> <Cmd>exe v:count1 . "ToggleTerm"<CR>
endif

if !empty(glob("~/.vim/plugged/fzf.vim"))
    call plug#begin()
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    call plug#end()

    "Map Ctrl + / to fzf search for all files in current directory.
    nnoremap  :Files<cr>
    "nnoremap  :FZF -m --prompt ~/ --expect=ctrl-v,ctrl-x,ctrl-t --no-height<CR>

    "Map Ctrl + \ to fzf search for git files in current directory.
    nnoremap  :GFiles?<cr>
    "nnoremap  :FZF -m --prompt ~/ 'gitfiles?> ' --expect=ctrl-v,ctrl-x,ctrl-t --no-height<CR>
endif

function! Nun()
    let cb = @%
    let line_no = line(".")
    if cb == ''
        let cmd = "rm ~/.vim/undodir/*"
        let op = system(cmd)
    else
        vsp new                            "creating new temporary buffer 
        wincmd l                           "switching to new buffer
        wq                                 "closing main buffer
        let cmd = "rm ~/.vim/undodir/*"
        let op = system(cmd)                "performing CLEAN operation
        execute "vsp".cb
        wincmd l                           "opened and now switching to main buffer
        q!                                 "closing the temporary 'new' buffer
        silent execute ":".line_no
    endif
endfunction
"
"nnoremap <silent> <leader>nun :call Nun()<CR><C-g>:echo "Deleted undo files.."<CR>
:command! Clear :call Nun()


" GIT EDITS
function! GitWindow()
    "tabnew
    let cwd = getcwd()
    let cmd = "bash ~/.vim/scripts/gs_symln.sh " . cwd
    let op = system(cmd)
    e ~/tmp/git_files
endfunction
nnoremap <leader>/ :call GitWindow()<cr> 

" Quick Escape
inoremap jk <Esc>cal cursor(line('.'),virtcol('.'))<cr>
"inoremap kj <Esc>cal cursor(line('.'),virtcol('.'))<cr>

"Quick movements
inoremap II <Esc>I
inoremap AA <Esc>A
"inoremap OO <Esc>O
"inoremap oo <Esc>o

if !has('nvim')
    inoremap OM <Esc>O
else
    inoremap  <Esc>O
endif

nnoremap OO O<Esc>
"nnoremap oo o<Esc>

nnoremap j gj
nnoremap k gk

nnoremap <space> :noh<cr><C-g>

"TAB OPERATIONS HERE 
nnoremap <C-a>      :tabprevious<CR>
nnoremap <C-d>      :tabnext<CR>
nnoremap <C-t>      :tabnew<CR>
"inoremap <C-a>      <Esc>:tabprevious<CR>i
"inoremap <C-d>      <Esc>:tabnext<CR>i
"inoremap <C-t>      <Esc>:tabnew<CR>

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

function! CloseBuffer()
    let cb = @%
    if cb != ''
        :bdelete
    else
        :q
    endif
endfunction

nnoremap <C-w>      :call CloseBuffer()<CR>:echo "Buffer closed.."<cr>
"inoremap <C-w>      <Esc>:q<CR>

nnoremap <C-s>      :w<CR>:echo "File Saved.."<CR>
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

