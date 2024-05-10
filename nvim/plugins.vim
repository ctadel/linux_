"GUI MODE
    set mouse=a         "n -> Can control mouse in NORMAL mode but in CLI based window when in INSERT mode..

"-------------------------------------------------- NVIM-TREE --------------------------------------------------"
"NVIM TREE CONFIGURATIONS

lua<<EOF
    require'nvim-tree'.setup {
      disable_netrw       = false,
      hijack_netrw        = true,
      hijack_cursor       = true,
      update_cwd          = true,
      diagnostics = {
        enable = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        }
      },
      update_focused_file = {
        enable      = true,
        update_cwd  = true,
        ignore_list = {}
      },
      system_open = {
        cmd  = nil,
        args = {}
      },
      filters = {
        dotfiles = false,
        custom = {}
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 500,
      },
      view = {
        width = 30,
        hide_root_folder = false,
        side = 'left',
        mappings = {
          custom_only = false,
          list = {}
        },
        number = false,
        relativenumber = false
      },
      trash = {
        cmd = "trash",
        require_confirm = true
      }
    }
    require'nvim-web-devicons'.setup {
     -- your personnal icons can go here (to override)
     -- DevIcon will be appended to `name`
     override = {
      zsh = {
        icon = "",
        color = "#428850",
        name = "Zsh"
      }
     };
     -- globally enable default icons (default to false)
     -- will get overriden by `get_icons` option
     default = true;
    }
EOF

    nnoremap <F10> :NvimTreeClose<CR>
    nnoremap <silent><C-w>     :bdelete<CR>:NvimTreeClose<CR>:NvimTreeOpen<CR>:wincmd l<CR>

    let @y = 0                      " Register NvimTree as Unfocused in default
    function! FocusUnfocus()
        let focus_status = @y
        if focus_status == 1
            let @y = 0
            wincmd l
        else
            let @y = 1
            NvimTreeFocus
        endif
    endfunction
    nnoremap <silent><C-n>     :call FocusUnfocus()<CR>

    highlight NvimTreeFolderIcon guibg=blue



"-------------------------------------------------- BUFFERLINE --------------------------------------------------"

"BUFFERLINE CONFIGURATIONS
    lua<<EOF
        require('bufferline').setup {
          options = {
            close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
            right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
            left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
            middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',

            name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
              -- remove extension from markdown files for example
              if buf.name:match('%.md') then
                return vim.fn.fnamemodify(buf.name, ':t:r')
              end
            end,

            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            tab_size = 18,
            diagnostics = "coc",
            diagnostics_update_in_insert = false,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
              return "("..count..")"
            end,

            offsets = {{filetype = "NvimTree", text = "File Explorer" , text_align = "center"}},
            show_buffer_icons = true, -- disable filetype icons for buffers
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist

            separator_style = "slant",
            enforce_regular_tabs = false,
            always_show_bufferline =false,
            sort_by = 'id',
          }
        }
EOF

"-------------------------------------------------- ONEHALF-DARK --------------------------------------------------"

"THEME
    let g:lightline = { 'colorscheme': 'onehalfdark' }
    colorscheme onehalfdark

"-------------------------------------------------- TOGGLE-TERM --------------------------------------------------"

"TOGGLE TERM
lua<<EOF
require("toggleterm").setup{}
EOF
    autocmd TermEnter term://*toggleterm#*
        \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

    nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

    nnoremap <F5> :TermExec cmd="python3 %"<CR>

"---------------------------------------------- CONQUER OF COMPLETION ----------------------------------------------"

" "COC CONFIGURATIONS

"     inoremap <silent><expr> <TAB>
"           \ coc#pum#visible() ? coc#pum#next(1):
"           \ CheckBackspace() ? "\<Tab>" :
"           \ coc#refresh()
"     inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

"     " Make <CR> to accept selected completion item or notify coc.nvim to format
"     " <C-g>u breaks current undo, please make your own choice.
"     inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                                   \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"     function! CheckBackspace() abort
"       let col = col('.') - 1
"       return !col || getline('.')[col - 1]  =~# '\s'
"     endfunction

"     " Use <c-space> to trigger completion.
"     if has('nvim')
"       inoremap <silent><expr> <c-space> coc#refresh()
"     else
"       inoremap <silent><expr> <c-@> coc#refresh()
"     endif

"     " Use `[g` and `]g` to navigate diagnostics
"     " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"     nmap <silent> [g <Plug>(coc-diagnostic-prev)
"     nmap <silent> ]g <Plug>(coc-diagnostic-next)

"     " GoTo code navigation.
"     nmap <silent> gd <Plug>(coc-definition)
"     nmap <silent> gy <Plug>(coc-type-definition)
"     nmap <silent> gi <Plug>(coc-implementation)
"     nmap <silent> gr <Plug>(coc-references)

"     " Use K to show documentation in preview window.
"     nnoremap <silent> K :call ShowDocumentation()<CR>

"     function! ShowDocumentation()
"       if CocAction('hasProvider', 'hover')
"         call CocActionAsync('doHover')
"       else
"         call feedkeys('K', 'in')
"       endif
"     endfunction

"     " Highlight the symbol and its references when holding the cursor.
"     autocmd CursorHold * silent call CocActionAsync('highlight')

"     " Symbol renaming.
"     nmap <leader>rn <Plug>(coc-rename)

"     " Formatting selected code.
"     xmap <leader>f  <Plug>(coc-format-selected)
"     nmap <leader>f  <Plug>(coc-format-selected)

"     augroup mygroup
"       autocmd!
"       " Setup formatexpr specified filetype(s).
"       autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"       " Update signature help on jump placeholder.
"       autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"     augroup end

"     " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"     "nmap <silent> <TAB> <Plug>(coc-range-select)
"     "xmap <silent> <TAB> <Plug>(coc-range-select)
"     "xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

"---------------------------------------------- FUZZY FILE FINDER ----------------------------------------------"

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

    nnoremap <C-g> :GGrep<CR>
    nnoremap  :Files<cr>
    nnoremap  :GFiles?<cr>


"---------------------------------------------- AIRLINE ----------------------------------------------"

"AIRLINE CUSTOMIZATION
    let g:airline_powerline_fonts = 1
    let g:airline_section_y = ''
    au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%', 'maxlinenr', ' :%3v'])



"---------------------------------------------- STARTIFY ----------------------------------------------"
    let g:startify_padding_left = 3
    let g:startify_custom_header = [
                \ ' ################################################',
                \ ' ##          __              .___     .__      ##',
                \ ' ##    _____/  |______     __| _/____ |  |     ##',
                \ ' ##  _/ ___\   __\__  \   / __ |/ __ \|  |     ##',
                \ ' ##  \  \___|  |  / __ \_/ /_/ \  ___/|  |__   ##',
                \ ' ##   \___  >__| (____  /\____ |\___  >____/   ##',
                \ ' ##       \/          \/      \/    \/         ##',
                \ ' ##                                            ##',
                \ ' ################################################',
                \ ]


"---------------------------------------------- GIT BLAMER ----------------------------------------------"
let g:blamer_enabled = 1
let g:blamer_show_in_insert_modes = 0
let g:blamer_show_in_visual_modes = 0
let g:blamer_delay = 500
let g:blamer_relative_time = 1


"------------------------------------------ SESSION PERSISTANCE ------------------------------------------"
lua << EOF
  require("persistence").setup {
  }
EOF

"------------------------------------------ TRAILING WHITE SPACE ------------------------------------------"
let g:better_whitespace_guicolor='Maroon'
