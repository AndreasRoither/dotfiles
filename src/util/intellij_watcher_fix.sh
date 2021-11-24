#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

conf_path="/etc/sysctl.d/idea.conf"

if [ -e $conf_path ]; then
  print_in_red "File $conf_path already exists!"
else
  echo >> $conf_path
  sudo sysctl -p --system
fi