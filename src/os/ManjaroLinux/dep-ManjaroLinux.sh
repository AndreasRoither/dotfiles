#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../util/utils.sh"

mkdir ~/.tempApp
cd ~/.tempApp

print_in_purple "   [*] Installing Browsers...\n"
sudo pacman -S --needed --noconfirm firefox chromium

print_in_purple "   [*] Installing tools...\n"
sudo pacman -S --needed --noconfirm \
    base-devel \
    npm \
    yarn \
    nodejs \
    python \
    python-pip \
    thunderbird \
    tilda \
    lutris \
    keepassxc \
    gamemode \
    htop \
    qbittorrent \
    github-cli \
    docker \
    docker-compose \
    fzf \
    duf \
    tlp \
    tlpui \
    neofetch \
    conky \
    appimagelauncher

print_in_purple "   [*] Installing snapd dep...\n"
sudo ln -s /var/lib/snapd/snap /snap # for code
sudo snap install authy --beta
sudo snap install code --classic
sudo snap install ao

if [ $XDG_CURRENT_DESKTOP == "GNOME" ]; then
    print_in_purple "   [*] Gnome environment detected\n"
    sudo pacman -S -S --needed --noconfirm \
        gnome-tweaks
    sudo snap install gnome-calendar

    # Fix gnome intellij shortcut conflicts
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"
    gsettings set org.gnome.shell.extensions.screenshot-window-sizer cycle-screenshot-sizes "['']"
fi

print_in_purple "   [*] Installing yay\n"
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd ..

print_in_purple "   [*] Installing from aur\n"
yay -S --noconfirm --nodiffmenu q\
    insync \
    spotify \
    yuzu-git \
    jetbrains-toolbox \
    nordvpn-bin \
    postman-bin

print_in_purple "   [*] Setting up nordvpn\n"
if command -v nordvpn &> /dev/null
then
    sudo systemctl enable nordvpnd.service
    sudo systemctl start nordvpnd.service
    sudo usermod -aG nordvpn $USER
    sudo nordvpn set technology nordlynx
else
    print_in_purple "   [-] Nordvpn was not found\n"
fi

print_in_purple "   [*] Setting up docker\n"
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo groupadd docker
sudo usermod -aG docker $USER

cd ~
sudo rm -rf ~/.tempApp

sudo pacman -Syu
