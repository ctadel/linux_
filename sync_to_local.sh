#! /bin/bash
export LIN_=$HOME/gitlib/linux_
read -p "Syncronize linux_ files to local server?(yes/*): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]];then
    ln -sf $LIN_/vimrc ~/.vimrc
    ln -sf $LIN_/bashpd ~/.bashpd
    ln -sf $LIN_/inputrc ~/.inputrc
    ln -sf $LIN_/psqlrc ~/.psqlrc
    if [ -f  /usr/bin/nvim ]; then
        if ! [ -d  ~/.config/nvim ]; then
            mkdir -p ~/.config/nvim
        fi
        ln -sf $LIN_/vimrc ~/.config/nvim/init.vim
    fi
    printf "${green}Sync'd linux_ files to local Server.${normal}\n"
else
    printf "Operation canceled by user.."
fi

