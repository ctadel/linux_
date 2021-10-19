#! bin/bash
read -p "Syncronize linux_ files to local server?(yes/*): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]];then
    cp vimrc ~/.vimrc
    cp bashpd ~/.bashpd
    cp inputrc ~/.inputrc
    printf "${green}Sync'd linux_ files to local Server.${normal}\n"
else
    printf "Operation canceled by user.."
fi

