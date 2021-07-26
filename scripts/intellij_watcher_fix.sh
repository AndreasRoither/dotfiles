#!/usr/bin/env bash

echo "[*] Setting up intellij file watch fix"
conf_path="/etc/sysctl.d/idea.conf"

if [ -e $conf_path ]; then
  echo "File $conf_path already exists!"
else
  echo >> $conf_path
  sudo sysctl -p --system
fi