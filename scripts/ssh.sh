#!/usr/bin/env bash
ssh-keygen -t rsa -b 4096 -C "andi.roither@protonmail.com" && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub