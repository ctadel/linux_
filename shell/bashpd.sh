################################################
#
##          __              .___     .__      ##
##    _____/  |______     __| _/____ |  |     ##
##  _/ ___\   __\__  \   / __ |/ __ \|  |     ##
##  \  \___|  |  / __ \_/ /_/ \  ___/|  |__   ##
##   \___  >__| (____  /\____ |\___  >____/   ##
##       \/          \/      \/    \/         ##
################################################

red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
normal=$(tput sgr0)
COLORTERM="truecolor"

export PAGER=more
export EDITOR=vi

declare -A repository_map

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar) unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip) unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace) unace x ./"$n"      ;;
            *.zpaq)      zpaq x ./"$n"      ;;
            *.arc)       arc e ./"$n"       ;;
            *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                              extract $n.iso && \rm -f $n ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# Directory settings
alias ..='cd ..'
alias l='ls -ltrah'

dotSlash=""
for i in 1 2 3 4
do
    dotSlash=${dotSlash}'../';
    baseName=".${i}"
    alias $baseName="cd ${dotSlash}"
done

function fn (){
   local keyword=$1
   shift
   local args="$*"
   if [[ $args ]]
   then
       args="$(sed 's/ / |grep -i /g' <<<$args)"
       local CMD="/usr/bin/find -iname $keyword |grep -i $args"
       eval $CMD
       return 0;
   fi
   local CMD="/usr/bin/find -iname $keyword"
   eval $CMD
}

alias kill9='kill -9 %'

#Python
alias pym='python manage.py'
alias pymr='python manage.py runserver 0.0.0.0:8000'


########################################| GIT SETTINGS START |########################################

alias 'gs'='git status'
alias 'gss'='git status -s'
alias 'gg'='git grep'
alias 'ggl'='git grep -l'
alias 'ggi'='git grep -i'
alias 'ggil'='git grep -il'
alias 'gb'='git branch'
alias 'go'='git checkout'
alias 'goa'='git checkout .'
alias 'gc'='git commit'
alias 'ga'='git add'
alias 'gaa'='git add --all .'
alias 'gai'='git add -i'
alias 'gp'='git pull'
alias 'gst'='git stash'
alias 'gstl'='git stash list'
alias 'gf'='git fetch'
alias 'gd'='git diff'
alias 'gdc'='git diff --cached'
alias 'gl'='git log --graph --decorate'
alias 'glo'='git log --oneline --graph --decorate'
alias 'grl'='git reflog'
alias 'gcp'='git cherry-pick'
alias 'gw'='git worktree'
alias 'gr'='git reset'
alias 'grh'='git reset HEAD'
alias 'gxf'='git clean -f'
alias 'ggpull'='git pull origin $(git_current_branch)'
alias 'ggpush'='git push origin $(git_current_branch)'


# TIG Shortcuts
if [ -x "$(command -v tig)" ]; then
  alias gl='tig'
  alias gs='tig status'
  alias gb='tig refs'
  alias gsl='tig stash'
fi

########################################| GIT SETTINGS END |########################################


alias pubip='curl ifconfig.co'

alias lo='libreoffice'

if [ -d ~/gitlib/linux_ ]; then 
    alias lin_="cd ~/gitlib/linux_"
    export LIN_="/home/$USER/gitlib/linux_"
fi

#incognito command
alias pvt='history -d $((HISTCMD-1)) && '

function pingx(){
    if [ -z $1 ];then 
        echo "Pinging google.com"
        ping google.com | awk 'BEGIN{ORS="\t"}{print substr($8,6,10)}'
    else
        echo "Pinging $1"
        ping $1 | awk 'BEGIN{ORS="\t"}{print substr($8,6,10)}'
    fi
}

if [ -f  /usr/bin/nvim ]; then
  alias vi='nvim'
fi

if [ -f  /home/prajwal/.local/bin/lvim ]; then
  alias vi='/home/prajwal/.local/bin/lvim'
fi

if [ -f /usr/bin/fzf ] && [ -f $HOME/usr/f ]; then
  alias f='${HOME}/usr/f'
  alias f='echo -n $(fzf -e) | copy'
fi

if [ -f /usr/bin/xsel ] || [ -f ~/usr/bin/xsel ]; then
  alias copy='xsel -b'
fi

if [ -f  /usr/bin/psql ]; then
    alias psql="psql -h localhost -U postgres"
    alias tipsql="psql -h192.168.1.208 -dtradein_clients -Utradein  --set PROMPT1='%[%033[0;36m%]%(LOCAL) %[%033[0m%]%/%R%# '"
    alias rpsql="psql -h34.93.71.99 -dtradein_clients -Utradein_dev --set PROMPT1='%[%033[0;31m%]%(REMOTE) %[%033[0m%]%/%R%# '"
    alias redshift="psql -h group2.353591720586.ap-south-1.redshift-serverless.amazonaws.com -p 5439 -U admin -d dev"
fi
# include .server_settings if it exists
if [ -f $HOME/.server_settings ]; then
    . $HOME/.server_settings
fi

alias notify="notify-send 'Process Completed' 'Please have a look in the terminal' -u 'normal' && /home/prajwal/.local/bin/alert"

function got() {
    # Handle flags
    local new_branch=false
    local migrate=false
    local branch_name=""
    while [ $# -gt 0 ]; do
      case $1 in
        --new|-n)
          new_branch=true
          ;;
        --migrate|-m)
          migrate=true
          ;;
        -nm|-mn)
          new_branch=true
          migrate=true
          ;;
        *)
          branch_name="$1"
          ;;
      esac
      shift
    done

    # Check if current directory is inside a Git repository
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        echo "Error: Not a Git repository" >&2
        return 1
    fi

    repo_path=$(git worktree list | awk 'NR==1{print $1}')

    # Check if branch name argument is provided
    if [[ -n "$branch_name" ]]; then
        # Get list of worktrees
        local worktree_list=$(git worktree list)

        # Loop through worktrees to find branch
        local branch_dir=""
        while read -r line; do
            local dir=$(echo "$line" | awk '{print $1}')
            local commit=$(echo "$line" | awk '{print $2}')
            local branch=$(echo "$line" | awk '{print $3}')
            if [[ "$branch" == "[$branch_name]" ]]; then
                branch_dir="$dir"
                break
            fi
        done <<< "$worktree_list"

        # Check if branch directory is found
        if [[ -z "$branch_dir" ]]; then
            if [[ "$new_branch" == true ]]; then
                # Create new worktree
                git worktree add "$repo_path/$branch_name" "$branch_name"
                branch_dir=$(git worktree list | awk "/\[$branch_name\]/{print \$1}")
            else
                echo "Error: Branch directory not found for branch $branch_name" >&2
                return 1
            fi
        fi

        # Move changes to new branch directory if --migrate flag is provided
        if [[ -n "$branch_name" ]]; then
          if [[ "$migrate" == true ]]; then
              # Check if there are any changes to stash
              zip -qo changes.zip $(gs -s | awk 'ORS=" " {print $2}')
              mv changes.zip $branch_dir
          else
            $migrate = false
          fi
        fi

        # Change to branch directory
        cd "$branch_dir"
        if [[ "$migrate" == true ]]; then
          unzip -qo changes.zip
          rm changes.zip
        fi

    else
        # No branch name argument provided, list worktrees
        git worktree list
    fi
}
# Autocomplete branch names
_got_branch_names() {
  local branches="$(git worktree list | awk 'NR > 1 {gsub(/[][]/, "", $3); print $3}')"
  COMPREPLY=($(compgen -W "$branches" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _got_branch_names got

################# ZSHRC ###############

# Check if the current shell is zsh
if [[ $(ps -p $$ | awk '{print $4}' | tail -n 1) == "zsh" ]]; then
  # Plugins currently using
  #plugins=(git zsh-syntax-highlighting zsh-autosuggestions docker)

  bindkey '^ ' autosuggest-accept

  # Edit line in vim with ctrl-backspace:
  autoload edit-command-line; zle -N edit-command-line
  bindkey '' edit-command-line

  bindkey '' backward-kill-word
  bindkey '<C-Del>' kill-word

  bindkey "" backward-word

  export EDITOR="lvim"
  export VISUAL="lvim"
fi


################# LF #################

# this is the wrapper function to the lf to support of change directory
# only cd's if enter key is pressed
lfcd() {
  tmp="$(mktemp)"
  export LF_UPDATE_DIRECTORY=$tmp

  command lf "$@"

  last_directory=$(<"$tmp")
  if [[ -d "$last_directory" && "$last_directory" != "$(pwd)" ]]; then
      cd "$last_directory"
  fi

  rm "$tmp"
}

alias lf="lfcd"

if [ -f $HOME/.config/lf/lficons.sh ]; then
    . $HOME/.config/lf/lficons.sh
fi


################# YAZI #################
function ya() {
  tmp="$(mktemp)"
  export YAZI_UPDATE_DIRECTORY=$tmp

	command yazi "$@"
  last_directory=$(<"$tmp")
  if [[ -d "$last_directory" && "$last_directory" != "$(pwd)" ]]; then
      cd "$last_directory"
  fi
}

################ DEACTIVATE ALL ENVS ################
deactivate_all_envs() {
  if [[ ! -z "$PYENV_VERSION" ]]; then
    pyenv deactivate
  fi

  if [[ ! -z "$CONDA_PREFIX" ]]; then
    while [[ ! -z "$CONDA_PREFIX" ]]; do
      conda deactivate
    done
  fi

  if [[ ! -z "$VIRTUAL_ENV" ]]; then
    deactivate
  fi
}



############### Feature Branches ##############
function features(){
    if [[ -z "$1" ]]; then
        repo=$(basename "$(git rev-parse --show-toplevel)" 2>/dev/null)
        if [[ -z $repo ]]; then
            repo='all'
        fi
    else
      repo=$1
    fi

    if [[ $repo == 'all' ]]; then
        compgen -v | grep -E '^FB_' | while read -r var; do
            eval echo $"$var"
            echo "\n"
        done
        return
    fi

    repo_varname="FB_${repository_map["$repo"]:=$repo}"

    if [ -v $repo_varname ]; then
        eval echo $"$repo_varname"
    else
        echo "Variable FB_$repo_varname is not defined"
    fi
  }




############### Evaluate Math ##############
function math(){
    if [ $1 ]; then
      python -c 'import math; print('$1')'
    fi
  }

alias icat="kitty icat"

# Check if ~/usr/bin directory exists and add to PATH if not already present
if [ -d "$HOME/usr/bin" ] && [[ ":$PATH:" != *":$HOME/usr/bin:"* ]]; then
    export PATH="$HOME/usr/bin:$PATH"
fi

# Check if ~/.local/bin directory exists and add to PATH if not already present
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

#################### YAZI : Update Directory ####################

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


clear
