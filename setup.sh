#!/usr/bin/env bash

declare -r GITHUB_REPOSITORY="AndreasRoither/dotfiles"
declare -r DOTFILES_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"

declare dotfilesDirectory="$HOME/git/dotfiles"

declare -r CONFIG="install.conf.yaml"
declare -r DOTBOT_DIR="dotbot"
declare -r DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare skipQuestions=false

# ----------------------------------------------------------------------
# | Helper Functions                                                   |
# ----------------------------------------------------------------------

get_os() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
  Linux*) os=Linux ;;
  Darwin*) os=Mac ;;
  CYGWIN*) os=Cygwin ;;
  MINGW*) os=MinGw ;;
  *) os="UNKNOWN:${unameOut}" ;;
  esac

  if [ $os == "Linux" ]; then
    distro=$(lsb_release -si)
  fi
}

indent() { sed 's/^/    /'; }

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

  get_os

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Load utils

  if [ -x "src/util/utils.sh" ]; then
    . "src/util/utils.sh" || exit 1
  else
    echo "Error loading utils."
    exit 1
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  print_in_purple "\n • Dotfiles install starting\n"

  ask_for_sudo

  # Make sure gum is installed
  if ! cmd_exists "gum"; then
    if [ "$os" == "MinGw" ]; then
      print_in_blue "\tInstalling gum\n"
      start microsoft-edge:https://github.com/charmbracelet/gum/releases/download/v0.6.0/gum_0.6.0_Windows_x86_64.zip
      echo "Waiting for you to install gum manually"
      echo "Press any key if complete..."
      read -n 1 -s

    elif [ "$os" == "Linux" ]; then
      if [ "$distro" == "Ubuntu" ] || [ "$distro" == "Pop" ]; then
        echo 'deb [trusted=yes] https://repo.charm.sh/apt/ /' | sudo tee /etc/apt/sources.list.d/charm.list && sudo apt update && sudo apt install gum
      elif [ "$os" == "ManjaroLinux" ]; then
        pacman -S gum
      fi
    fi
  fi

  # update dotbot
  gum spin --spinner dot --title "Updating dotbot" -- git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive && git submodule update --init --recursive "${DOTBOT_DIR}"

  print_in_purple "\n • Starting dotbot...\n\n"
  # start dotbot actions
  "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}" | indent

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  skip_questions "$@" &&
    skipQuestions=true

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  print_in_purple "\n • Pre setup for install scripts\n\n"
  gum confirm "Create directories?" && bash ./src/preferences/create_directories.sh

  print_in_purple "\n • Looking for install scripts\n\n"

  if [ "$os" == "MinGw" ]; then
    print_in_blue "\tInstalling windows dependencies\n"
    bash ./src/os/windows/dep-win10-winget.sh

  elif [ "$os" == "Linux" ]; then

    # auto fix dual boot time sync
    timedatectl set-local-rtc 1

    if [ ! -d "src/os/${distro}" ]; then
      print_error "Could not find installation files for '${distro}'."
      exit 1
    fi

    bash ./src/os/${distro}/setup.sh

  else
    print_error "${os} currently not supported."
    exit 1
  fi
}

main "$@"

exit 0
