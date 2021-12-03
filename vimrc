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

"Custom undo file.
set nobackup
set noswapfile
set undodir=~/.vim/
set undofile
" set nowritebackup

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
set termguicolors
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


"--------------------------------------------------PLUGINS--------------------------------------------------"
if has('nvim') 
    call plug#begin('~/.config/nvim/autoload')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'lukas-reineke/indent-blankline.nvim'
        Plug 'vim-airline/vim-airline'
        Plug 'akinsho/toggleterm.nvim'
    	Plug 'junegunn/fzf'
    	Plug 'junegunn/fzf.vim'
        Plug 'sonph/onehalf', { 'rtp': 'vim' }
    call plug#end()
else
    call plug#begin()
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
    call plug#end()
endif

"-----------------------------------------------CONFIGURATIONS------------------------------------------------"
if has('nvim')
    "GUI MODE
        set mouse=a

    "COC CONFIGURATIONS 
        "Tab for autocompletions
        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~ '\s'
        endfunction

        inoremap <silent><expr> <Tab>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<Tab>" :
              \ coc#refresh()

        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)nnoremap <silent> K :call <SID>show_documentation()<CR>

        " Use K to show documentation in preview window.
        nnoremap <silent> K :call <SID>show_documentation()<CR>
        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          elseif (coc#rpc#ready())
            call CocActionAsync('doHover')
          else
            execute '!' . &keywordprg . " " . expand('<cword>')
          endif
        endfunction       " use <tab> for trigger completion and navigate to the next complete item

    "THEME
        let g:lightline = { 'colorscheme': 'onehalfdark' }
        colorscheme onehalfdark

    "TOGGLE TERM
        autocmd TermEnter term://*toggleterm#*
              \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

        " By applying the mappings this way you can pass a count to your
        " mapping to open a specific window.
        " For example: 2<C-t> will open terminal 2
        nnoremap <silent><c-k> <Cmd>exe v:count1 . "ToggleTerm"<CR>
        lua <<EOF
        function _G.set_terminal_keymaps()
          local opts = {noremap = true}
          vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
EOF

    " FZF CONFIGURATIONS
        command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'options': ['--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
        
        " Hide status line while fzf
        autocmd! FileType fzf set laststatus=0 noshowmode noruler
          \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

        "Git Grep from vim
        command! -bang -nargs=* GGrep
          \ call fzf#vim#grep(
          \   'git grep --line-number -- '.shellescape(<q-args>), 0,
          \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

    "AIRLINE CUSTOMIZATION
        "Enables noice angled view in status bar
        let g:airline_powerline_fonts = 1
        "customize Z section by removies unclear symbols
        let g:airline_section_y = ''
        au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%', 'maxlinenr', ' :%3v'])

else
endif

"--------------------------------------------------FUNCTIONS--------------------------------------------------"
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
inoremap II <Esc>I
inoremap AA <Esc>A
"inoremap OO <Esc>O
"inoremap oo <Esc>o

nnoremap OO O<Esc>
"nnoremap oo o<Esc>

nnoremap j gj
nnoremap k gk

nnoremap <space> :noh<cr><C-g>

nnoremap <leader>/ :call GitWindow()<cr> 

:command! Clear :call Nun()

nnoremap  :Files<cr>
nnoremap  :GFiles?<cr>
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

