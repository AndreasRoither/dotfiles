#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

local sshKeyFileName="$HOME/.ssh/id_rsa"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# If there is already a file with that
# name, generate another, unique, file name.

if [ -f "$sshKeyFileName" ]; then
    sshKeyFileName="$(mktemp -u "$HOME/.ssh/github_XXXXX")"
else 
    ssh-keygen -t rsa -b 4096 -C "andi.roither@protonmail.com" && eval "$(ssh-agent -s)" && ssh-add $HOME/.ssh/id_rsa
fi
cat ${sshKeyFileName}.pub

