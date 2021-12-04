"GUI MODE
    set mouse=n         "Can control mouse in NORMAL mode but in CLI based window when in INSERT mode..

"-------------------------------------------------- NVIM-TREE --------------------------------------------------"
"NVIM TREE CONFIGURATIONS

lua<<EOF
    require'nvim-tree'.setup {
      disable_netrw       = false,
      hijack_netrw        = true,
      open_on_setup       = true,
      ignore_ft_on_setup  = {},
      auto_close          = false,
      open_on_tab         = true,
      hijack_cursor       = true,
      update_cwd          = true,
      update_to_buf_dir   = {
        enable = true,
        auto_open = true,
      },
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
        height = 30,
        hide_root_folder = false,
        side = 'left',
        auto_resize = true,
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
    nnoremap <C-n> :NvimTreeFocus<CR>
    nnoremap <leader>n :NvimTreeToggle<CR>

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

            indicator_icon = '▎',
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

nnoremap <C-w>      :bdelete<CR>:NvimTreeClose<CR>:NvimTreeOpen<CR>:wincmd l<CR>


"-------------------------------------------------- ONEHALF-DARK --------------------------------------------------"

"THEME
    let g:lightline = { 'colorscheme': 'onehalfdark' }
    colorscheme onehalfdark

"-------------------------------------------------- TOGGLE-TERM --------------------------------------------------"

"TOGGLE TERM
    autocmd TermEnter term://*toggleterm#*
          \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

    nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>


"---------------------------------------------- CONQUER OF COMPLETION ----------------------------------------------"
    
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



"---------------------------------------------- AIRLINE ----------------------------------------------"

"AIRLINE CUSTOMIZATION
    let g:airline_powerline_fonts = 1
    let g:airline_section_y = ''
    au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%', 'maxlinenr', ' :%3v'])

