#!/usr/bin/env bash

# Ask for input
ask() {
  # http://djm.me/ask
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question
    read -p "$1 [$prompt] " REPLY

    # Default?
    if [ -z "$REPLY" ]; then
       REPLY=$default
    fi

    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

distro=`lsb_release -si`
path="./scripts/applications/dep-${distro}.sh"
if [ ! -f "$path" ]; then
  echo "Could not find file with dependencies for distro ${distro}. Aborting."
  echo -e "\t ${path}"
  exit 2
fi

ask "Install packages?" Y && bash ${path}
ask "Setup ssh?" Y && bash ./scripts./ssh.sh

figlet "... and we're back!" | lolcat

exit 0