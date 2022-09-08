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
install_package "fzf" "fzf"
install_package "fonts-powerline" "fonts-powerline"

print_in_purple "\n • Nodejs\n\n"
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
install_package "nodejs" "nodejs"

print_in_purple "\n • Yarn\n\n"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && install_package yarn

print_in_purple "\n • Rust\n\n"
curl https://sh.rustup.rs -sSf | sh
print_in_purple "\n • Starship\n\n"
cargo install starship --locked