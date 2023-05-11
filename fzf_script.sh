#!/bin/bash

# Define function to checkout modified files with git and fzf
function git_checkout_modified_files() {
  git status --porcelain | awk '{print $2}' | fzf --multi --preview 'git diff --color=always {}' | xargs git checkout --
}

# Define function to browse files in Vim with fzf
function browse_files_in_vim() {
  files=$(fzf --multi --preview 'bat --color=always {}' --preview-window right:50%)
  if [ -n "$files" ]; then
    lvim $files
  fi
}

# Define function to browse only modified files in Vim with fzf
function browse_modified_files_in_vim() {
  local files=$(git status --porcelain | awk '{print $2}' | fzf --multi --preview 'git diff --color=always {}' --preview-window 'right:60%')
  if [ -n "$files" ]; then
    lvim $files
  fi
}

# Define function to add files with git and fzf
function git_add_files() {
  git ls-files --modified --exclude-standard | fzf --multi --preview 'git diff --color=always {}' --preview-window right:50% | xargs git add --
}

function copy_files() {
  fzf --multi | xsel -b
}

# Determine which function to run based on argument passed
if [ "$1" = "go" ]; then
  git_checkout_modified_files
elif [ "$1" = "vi" ]; then
  browse_files_in_vim
elif [ "$1" = "vim" ]; then
  browse_modified_files_in_vim
elif [ "$1" = "ga" ]; then
  git_add_files
elif [ "$1" = "cp" ]; then
  copy_files
else
  echo "Invalid argument. Please specify one of: go(git checkout), ga(git add), vi(browse files)"
fi
