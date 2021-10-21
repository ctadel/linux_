#! /bin/bash

if [ ! $1 ];then
    echo "must pass git repo"
else
    cd $1
    files=$(''git status | awk 'BEGIN{ORS=" "} /modified:/ {print $2}' '')
    rm -rf ~/tmp/git_files && mkdir ~/tmp/git_files && cd ~/tmp/git_files
    for file in $files
    do
        p="$1/$file"
        #path=$( echo ${p%/*} )
        file=$( echo ${p##*/} )
        echo "$p" "$file" | xargs ln -s
    done
    cd $1
fi
