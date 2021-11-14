#! /bin/bash
export LIN_="/home/$USER/gitlib/linux_"
read -p "Syncronize linux_ files to local server?(yes/*): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]];then
    ln -sf $LIN_/vimrc ~/.vimrc
    ln -sf $LIN_/bashpd ~/.bashpd
    ln -sf $LIN_/inputrc ~/.inputrc
    ln -sf $LIN_/psqlrc ~/.psqlrc
    printf "${green}Sync'd linux_ files to local Server.${normal}\n"
else
    printf "Operation canceled by user.."
fi

