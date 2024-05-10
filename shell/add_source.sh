#!/bin/bash

code_to_search='[[ ! -f ~/.bashpd ]] || source ~/.bashpd'

file_paths=(
    ~/.zshrc
    ~/.bashrc
)

for file_path in "${file_paths[@]}"; do
    if [ -f "$file_path" ]; then
        if ! grep -qF "$code_to_search" "$file_path"; then
            echo "$code_to_search" >> "$file_path"
            echo "Code added to $file_path"
        else
            echo "Code already exists in $file_path"
        fi
    else
        echo "File $file_path does not exist"
    fi
done
