#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../util/utils.sh"


install_package() {

    declare -r EXTRA_ARGUMENTS="$3"
    declare -r PACKAGE="$2"
    declare -r PACKAGE_READABLE_NAME="$1"

    if ! package_is_installed "$PACKAGE"; then
        execute "sudo apt-get install --allow-unauthenticated -qqy $EXTRA_ARGUMENTS $PACKAGE" "$PACKAGE_READABLE_NAME"
        #                                      suppress output ─┘│
        #            assume "yes" as the answer to all prompts ──┘
    else
        print_success "$PACKAGE_READABLE_NAME"
    fi

}

package_is_installed() {
    dpkg -s "$1" &> /dev/null
}

print_in_purple "\n • Build Essentials\n\n"

# Install tools for compiling/building software from source.
install_package "Build Essential" "build-essential"


print_in_purple "\n • Docker\n\n"

if ! cmd_exists "docker"; then
  curl -sSL https://get.docker.com | sh || error "Failed to install Docker." 
  sudo usermod -aG docker $USER || error "Failed to add user to the Docker usergroup."
  print_in_blue "Remember to logoff/reboot for the changes to take effect."
else
  print_in_blue "Already installed."
fi

print_in_purple "\n • Misc\n\n"

install_package "zsh" "zsh"
install_package "Git" "git"
install_package "cURL" "curl"
install_package "ShellCheck" "shellcheck"
install_package "xclip" "xclip"
