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
  echo "Could not find file with dependencies for distro ${distro}."
  echo -e "\t ${path}"
fi

ask "Dual boot windows time fix?" > && sudo timedatectl set-local-rtc 1 && sudo hwclock --systohc --localtime
# adding user to sudoers
ask "Add user to sudo?" Y && sudo usermod -aG wheel $USER && sudo usermod -aG sudo $USER
ask "Install packages?" Y && bash ${path}
ask "Setup ssh?" Y && bash ./scripts./ssh.sh
ask "Setup zsh?" Y && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && chsh -s $(which zsh)
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


exit 0