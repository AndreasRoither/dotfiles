#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
    . "../../util/utils.sh"

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
    dpkg -s "$1" &>/dev/null
}

print_in_purple "\n • Utility\n\n"

install_package "zsh" "zsh"
install_package "cURL" "curl"
install_package "ShellCheck" "shellcheck"
install_package "xclip" "xclip"
install_package "fzf" "fzf"
install_package "fonts-powerline" "fonts-powerline"
install_package "bat" "bat"

print_in_purple "\n • Development\n\n"

install_package "Build Essential" "build-essential" # Install tools for compiling/building software from source.
install_package "Git" "git"
curl https://sh.rustup.rs -sSf | sh
gum spin --spinner dot --title "Installing starship" -- cargo install starship --locked
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash - && install_package "nodejs" "nodejs"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && sudo apt update && install_package "yarn" "yarn"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null && sudo apt update && sudo apt install gh -y

print_in_purple "\n • Docker\n\n"
if ! cmd_exists "docker"; then
    curl -sSL https://get.docker.com | sh || error "Failed to install Docker."
    sudo usermod -aG docker $USER || error "Failed to add user to the Docker usergroup."
    print_in_blue "Remember to logoff/reboot for the changes to take effect."
else
    print_in_blue "Already installed."
fi
