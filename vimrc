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
set nowrap
set nocursorline


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
nnoremap <silent> <leader>nun :call Nun()<CR><C-g>:echo "Deleted undo files.."<CR>


inoremap jk <Esc>   
inoremap kj <Esc>   


" GIT EDITS
function! GitWindow()
    "tabnew
    let cwd = getcwd()
    let cmd = "bash ~/.vim/scripts/gs_symln.sh " . cwd
    let op = system(cmd)
    e ~/tmp/git_files
endfunction
nnoremap <leader>/ :call GitWindow()<cr> 


"Quick movements
inoremap II <Esc>I
inoremap AA <Esc>A
"inoremap OO <Esc>O
"inoremap oo <Esc>o
inoremap OM <Esc>O

nnoremap OO O<Esc>
nnoremap oo o<Esc>

nnoremap j gj
nnoremap k gk

nnoremap <space> :noh<cr><C-g>

"TAB OPERATIONS HERE 
nnoremap <C-a>      :tabprevious<CR>
nnoremap <C-d>      :tabnext<CR>
nnoremap <C-t>      :tabnew<CR>
inoremap <C-a>      <Esc>:tabprevious<CR>i
inoremap <C-d>      <Esc>:tabnext<CR>i
inoremap <C-t>      <Esc>:tabnew<CR>

nnoremap <C-w>      :bdelete<CR>
"inoremap <C-w>      <Esc>:q<CR>

nnoremap <C-s>      :w<CR>:echo "File Saved.."<CR>
"inoremap <C-s>      <Esc>:w<CR>:echo "File Saved.."<CR>a

"Windows operations here
nnoremap <leader>a  :wincmd h<CR>
nnoremap <leader>d  :wincmd l<CR>
nnoremap <leader>w  :wincmd k<CR>
nnoremap <leader>s  :wincmd j<CR>
nnoremap <silent> <leader>+ :vertical resize +10<CR>
nnoremap <silent> <leader>- :vertical resize -10<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>ps :Rg<SPACE>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:echo $MYVIMRC "sourced.."<CR>

" nnoremap <leader>/ :noh<cr>
" nnoremap <tab> %
" vnoremap <tab> %

"Visual mode movements
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap <space> <esc>

vnoremap <leader>cp :s!^!# !<CR>:nohlsearch<CR>
vnoremap <leader>cm :s!^!%# !<CR>:nohlsearch<CR>
vnoremap <leader>cj :s!^!// !<CR>:nohlsearch<CR>
nnoremap <leader>cp :s!^!# !<CR>:nohlsearch<CR>
nnoremap <leader>cm :s!^!%# !<CR>:nohlsearch<CR>
nnoremap <leader>cj :s!^!// !<CR>:nohlsearch<CR>

"nnoremap <leader>w :w!<CR> 
nnoremap <leader>ft vatzf
nnoremap <leader>fB va{zf
nnoremap <leader>fb va(zf

nnoremap N Nzz
nnoremap n nzz

"Command mode remaps
cnoremap jk <C-u><esc><C-g>

"highlight current line
"set cul
"hi CursorLine term=none cterm=none ctermbg=195


"=================================================================
"=====| Search for a file under the cursor |======================
"=================================================================
" Find file in current directory and edit it.

function! Find()

 let searched_str = FindFile()
 let search_file = searched_str[0]
 let search_text = searched_str[1]
 if(empty(search_file))
    echo "-:!! ... NO FILES FOUND TO OPEN !!:- 1111" 
    return
 endif

"echo search_file search_text
"return

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "searching processing starts from here
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let cmd = "find $PWD 2>/dev/null 
    \ | grep -E '".search_file."' 
    \ | grep -vP '\.(obj|swp)$' 
    \ | perl -ne 'print \"$.\\t$_\"'"

    let l:list=system(cmd)
    let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
    if l:num < 1
        echo "-:!! ".search_file." NOT FOUND !!:-" 
        return
    elseif l:num != 1
        echo l:list
        let l:input=input("Which ? (Enter=nothing)\n")
        if strlen(l:input)==0
          return
        elseif strlen(substitute(l:input, "[0-9]", "", "g"))>0
          echo "-:!! NOT A NUMBER !!:-" 
          return
        elseif l:input<1 || l:input>l:num
          echo "-:!! OUT OF RANGE !!:-" 
          return
        endif
        let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
    else
        let l:line=l:list
    endif
    let l:line=substitute(l:line, "^[^\t]*\t", "", "")

    if(!empty(search_text))
        let l:line = '+\/\\(' . search_text .  '\\)\\\C ' . l:line
    endif
"    echo l:line

    " executing command to open searched file
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    try
    echo "This is me.."
    execute ':tabnew ' . l:line  
    catch 'Pattern not found'
        let search_text= substitute(search_text,'^.*[+]','','g')
        echo "-:!! ". search_text . " NOT FOUND !!:-" 
    catch 'No write since last change'
        echo "-:!! PLEASE SAVE YOUR FILE FIRST !!:-" 
    endtry

endfunction

function! FindFile()
    let search_file = ''
    let search_text = ''
    let cfile = expand('<cfile>')

    if(!empty(matchstr(cfile,'^\w\=/\w\+$\|\(\.\(html\|js\|css\)\)$')))
        "removing http of https with host name if exists
       let search_file = substitute(cfile,'^http\(s\)\?://.\{-}/','/','g')
       if(!empty(matchstr(cfile,'\.\(js\|css\)$')))
           let search_file = cfile 
           \ . "|" .  substitute(cfile,'\.\(js\|css\)$','-raw.\1','g')
           \ . "|" .  substitute(cfile,'\.\(js\|css\)$','_raw.\1','g')
       endif
    elseif(!empty(matchstr(cfile,'\w\+::\w\+')))

       let cfile = substitute(cfile,'^.\{-}\(\w\+\(::\w\+\)\+\).*$','\1,NO_TEXT','g')
       let cfile = substitute(cfile,'\C^\(.*\)::\([-_A-Z0-9]\+\),NO_TEXT$','\1,\2','g')
       let cfile = substitute(cfile,'\C^\(.*\)::\([a-z][-_a-zA-Z0-9]\+\),NO_TEXT$','\1,
       \sub\\\\s\\\\+\2','g')
       let [search_file,search_text] = split(cfile,',') 
       let search_file = '/' . substitute(search_file,'::','/','g') . '.pm'
       if(search_text == 'NO_TEXT')
          let search_text = ''
       endif

    elseif(!empty(matchstr(cfile,'^\$\w\+')))
       let variable = cfile
       let list = matchlist(cfile,'\$.*\$\w')
       " handling for the case  like ($profile,$lead,$valid,$posted,$lead_user);
       if(!empty(matchstr(cfile,'\$.*\$\w')))
           let variable = '$' . expand('<cword>')
       endif

       let variable = substitute(variable,'^[$]\{-}\|\W\+','','g')
       let current_line = getline(".")

       execute "silent normal! ma"
       while(1)
           if(variable =~ 'b2bglobal')
                let variable = expand('<cWORD>')
                let variable = substitute(variable,'^.\{-}\(\$b2bglobal{.\{-}}\).*$','\1','g')

                if has_key(s:well_defined_modules_hash, variable)
                    let search_file = s:well_defined_modules_hash[variable] 
                else
                    let list = matchlist(getline("."), variable . '\s\{-}=\s\{-}\(\$[_-a-zA-Z0-9}{]\+\)')
                    if(!empty(list))
                        let old_variable = variable
                        let variable = list[1]
                        if(old_variable != variable)
                            continue
                        endif
                    endif

                endif

                break
           endif

           "cheking module name first
           let list = matchlist(getline("."), variable . '\s\{-}=.\{-}\(\w\+\(::\w\+\)\+\).*$')
           if(!empty(list))
               let cfile = list[1]
               let cfile = substitute(cfile,'^.\{-}\(\w\+\(::\w\+\)\+\).*$','\1,NO_TEXT','g')
               let cfile = substitute(cfile,'\C^\(.*\)::\([-_A-Z0-9]\+\),NO_TEXT$','\1,\2','g')
               let cfile = substitute(cfile,'\C^\(.*\)::\([a-z][-_a-zA-Z0-9]\+\),NO_TEXT$',
               \ '\1,sub\\\\s\\\\+\2','g')
               let [search_file,search_text] = split(cfile,',') 
               if(search_text == 'NO_TEXT')
                  let search_text = ''
               endif

               break
           endif


           "checking well known variable
           let list = matchlist(getline("."), variable . '\s\{-}=\s\{-}\(\$[_a-zA-Z0-9}{]\+\).*$')
           if(!empty(list))
                let old_variable = variable
                let variable = list[1]

                if(variable =~ 'b2bglobal')
                    if has_key(s:well_defined_modules_hash, variable)
                        let search_file = s:well_defined_modules_hash[variable] 
                    endif
                    break
                endif

                if(old_variable != variable)
                    continue
                endif
           endif
           

           try
           execute "silent normal! gg/^[^#]*" . variable . "\\s*\=\<cr>"
           catch 'Pattern not found'
               break
           endtry

           if(current_line == getline("."))
               break
           endif

           let current_line = getline(".")

           echo "I am out of control. Please handle me"

       endwhile
       execute "silent normal! `a"

       if(!empty(search_file))
           let search_file = '/' . substitute(search_file,'::','/','g') . '.pm'
       endif

    endif

    return [search_file, search_text]

endfunction
"=================================================================
nnoremap gf :call Find()<cr>
"=================================================================
"command! -nargs=0 Find :call Find("<args>")



"=================================================================
"=====| Encapsulate a WORD beteen symbols |======================
"=================================================================
let s:symbol_map = {
    \   '[': '[]', ']': '[]',
    \   '{': '{}', '}': '{}',
    \   '(': '()', ')': '()',
    \}

function! BlockWord() 
   let l:sym=nr2char(getchar())
   try 
   let sym = s:symbol_map[l:sym]
   catch 'Key.*not.*Dictionary'
          let sym = l:sym. l:sym 
   endtry
   execute "silent normal! ciw" . sym . "\<ESC>P"
endfunction
"=================================================================
noremap <silent> <leader><leader> :call BlockWord()<cr>
"=================================================================


"=================================================================
"=====| Comment Lines using comment symbol |======================
"=================================================================
let s:comment_map = {
    \   "c": '//', "cpp": '//', "java": '//', "javascript": '//', "php": '//',
    \   "python": '#', "ruby": '#', "sh": '#', "fstab": '#', "conf": '#', 
    \   "profile": '#', "bashrc": '#', "bash_profile": '#', "perl": '#',
    \   "vim": '"',
    \ }

let s:comment_symbol= {"%": '%#', "/": '//' }

let g:comment_sym = ''
function! CommentLines() 
    if getline('.') =~ '^\s*\([#"]\|%#\|//\)'
"        uncomment
        execute 'silent s!^\(\s*\)\(["#]\|%#\|//\)!\1!g'
    else

       if has_key(s:comment_map, &filetype)
          let g:comment_sym = s:comment_map[&filetype]
      elseif &filetype == "mason"
            execute "silent normal! ma"
            execute "silent normal! ?\\(<%\\|<script\\|</script>\\)\<cr>ll"
            let block_name = expand('<cWORD>')
            execute "silent normal! 'a"

            let g:comment_sym = '%#'
            if block_name == "<%perl>" || block_name == "<%args>" || block_name == "<%attr>"
                    let g:comment_sym = '#'
            elseif block_name == "<%doc>"
                    let g:comment_sym = '%'
            elseif block_name =~ "<script"
                    let g:comment_sym = '//'
            endif
       endif

       if(empty(g:comment_sym))
           let char = getchar()
           let g:comment_sym= char == 13 ? '%#' : nr2char(char)
       endif

       if has_key(s:comment_symbol, g:comment_sym)
           let sym = s:comment_symbol[g:comment_sym]
       else
           let sym = g:comment_sym
       endif

       execute "silent normal! :s!^!". sym . "!\<CR>"

       if(line(".") == a:lastline)
           let g:comment_sym=''
       endif
   endif
endfunction
"=================================================================
nnoremap <silent> <leader>cc :call CommentLines()<cr>
vnoremap <silent> <leader>cc :call CommentLines()<cr>
"=================================================================
