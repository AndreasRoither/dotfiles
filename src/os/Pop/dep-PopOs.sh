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

# obs studio
sudo add-apt-repository ppa:obsproject/obs-studio
# kdenlive
sudo add-apt-repository ppa:kdenlive/kdenlive-stable
# syncthing
sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

install_package "Utility" "zsh curl shellcheck xclip fzf tilda steam lutris python3-pip snapd obs-studio vlc krita kdenlive gnome-tweaks ubuntu-restricted-extras"
pip3 install protonup
flatpak install flathub com.usebottles.bottles
sudo snap install authy
install_package "Development" "cmake build-essential git"
curl https://sh.rustup.rs -sSf | sh
curl -sS https://starship.rs/install.sh | sh
gum spin --spinner dot --title "Installing Bat" -- cargo install --locked bat
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && install_package "nodejs" "nodejs" && sudo npm install --global yarn --force

print_in_purple "\n • Docker\n\n"
if ! cmd_exists "docker"; then
    install_package "docker" "ca-certificates gnupg lsb-release"
    # keys
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu && $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

    # install
    sudo apt-get update
    install_package "docker stuff" "docker-ce docker-ce-cli containerd.io docker-compose-plugin"

    # user
    sudo usermod -aG docker $USER || error "Failed to add user to the Docker usergroup."
    print_in_blue "Remember to logoff/reboot for the changes to take effect."
else
    print_in_blue "Already installed."
fi
