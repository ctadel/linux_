#! /bin/bash
clear
export LIN_=$HOME/gitlib/linux_
let sudo=0
if [ $1 ];then
    if [ $1 == 'please' ];then 
        echo -e "Alight! I'm gonna try!\n"
        let sudo=1
    fi
fi

function make_link(){
    if [ $sudo -eq 1 ]; then
        local options="-sf"
    else
        local options="-s"
    fi
    local LIN_="$HOME/gitlib/linux_"
    local cmd="ln $options $LIN_/$1 $2 > /dev/null 2>&1"
    eval $cmd
}

echo -e -n "Syncronize \e[6;34mlinux_ \e[0mconfigurations to $USER's server?"
read -p "(yes/*): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]];then
    #ln -s $force $LIN_/vimrc.vim ~/.vimrc
    make_link 'vimrc.vim' '~/.vimrc'
    if [ $? == 0 ];then
        echo -e "\t\e[6;32m\u2714\e[0m Vimrc configurations "
    else
        echo -e "\t\e[6;31m\u274c\e[0m Vimrc configurations "
    fi

    make_link 'bashpd' '~/.bashpd'
    if [ $? == 0 ];then
        echo -e "\t\e[6;32m\u2714\e[0m Bashpd configurations "
    else
        echo -e "\t\e[6;31m\u274c\e[0m Bashpd configurations "
    fi

    if [ -x "$(command -v psql)" ]; then
        make_link 'psqlrc' '~/.psqlrc'
        if [ $? == 0 ];then
            echo -e "\t\e[6;32m\u2714\e[0m PSQL configurations "
        else
            echo -e "\t\e[6;31m\u274c\e[0m PSQL configurations "
        fi
    fi

    if [ -x "$(command -v nvim)" ]; then
        if ! [ -d  ~/.config/nvim ]; then
            mkdir -p ~/.config/nvim
        fi
        make_link 'vimrc.vim' '~/.config/nvim/init.vim'
        if [ $? == 0 ];then
            echo -e "\t\e[6;32m\u2714\e[0m Neovim configurations "
        else
            echo -e "\t\e[6;31m\u274c\e[0m Neovim configurations "
        fi
    fi

    if [ -x "$(command -v lvim)" ]; then
        make_link 'lvim.lua' '~/.config/lvim/config.lua'
        if [ $? == 0 ];then
            echo -e "\t\e[6;32m\u2714\e[0m Lunarvim configurations "
        else
            echo -e "\t\e[6;31m\u274c\e[0m Lunarvim configurations "
        fi
    fi

    if [ -x "$(command -v lf)" ]; then
        make_link 'lfrc' '~/.config/lf/lfrc'
        if [ $? == 0 ];then
            echo -e "\t\e[6;32m\u2714\e[0m LF configurations "
        else
            echo -e "\t\e[6;31m\u274c\e[0m LF configurations "
        fi
    fi

    if [ -x "$(command -v tig)" ]; then
        make_link 'tigrc' '~/.tigrc'
        if [ $? == 0 ];then
            echo -e "\t\e[6;32m\u2714\e[0m Tig configurations "
        else
            echo -e "\t\e[6;31m\u274c\e[0m Tig configurations "
        fi
    fi

    if [ -x "$(command -v fzf)" ]; then
      unalias f
      make_link 'fzf_script.sh' "${HOME}/usr/f"
        if [ $? == 0 ];then
            echo -e "\t\e[6;32m\u2714\e[0m Fzf script added to ${HOME}/usr/f "
        else
            echo -e "\t\e[6;31m\u274c\e[0m Error in linking fzf script (maybe use sudo)"
        fi
    fi

    if [ -x "$(command -v byobu)" ]; then
        make_link 'byoburc' '~/.byobu/status'
        if [ $? == 0 ];then
            echo -e "\t\e[6;32m\u2714\e[0m Byobu configurations "
        else
            echo -e "\t\e[6;31m\u274c\e[0m Byobu configurations "
        fi
    fi

    read -p "Sync inutrc?(yes/*): " confirm2
    if [[ $confirm2 == [yY] || $confirm2 == [yY][eE][sS] ]];then
        make_link 'inputrc' '~/.inputrc'
        if [ $? == 0 ];then
            echo -e "\t\e[6;32m\u2714\e[0m Inputrc (readline) configurations "
        else
            echo -e "\t\e[6;31m\u274c\e[0m Inputrc (readline) configurations "
        fi
    fi
else
    echo -e "Operation canceled by user.."
fi

