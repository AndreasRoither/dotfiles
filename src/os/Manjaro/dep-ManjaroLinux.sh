#!/usr/bin/env bash

mkdir ~/.tempApp
cd ~/.tempApp

print_in_purple "[*] Installing Browsers..."
sudo pacman -S --needed --noconfirm firefox chromium

print_in_purple "[*] Installing tools..."
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
    fzf

print_in_purple "[*] Installing snapd..."
pamac install snapd
sudo systemctl enable --now snapd.socket
sudo snap install authy --beta
sudo snap install code --classic
sudo snap install ao

if [ $XDG_CURRENT_DESKTOP == "GNOME" ]; then
    print_in_purple "[*] Gnome environment detected"
    sudo pacman -S -S --needed --noconfirm \
        gnome-tweaks
    sudo snap install gnome-calendar

    # Fix gnome intellij shortcut conflicts
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['']"
    gsettings set org.gnome.shell.extensions.screenshot-window-sizer cycle-screenshot-sizes "['']"
elif [ $XDG_CURRENT_DESKTOP == "KDE" ]; then
    print_in_purple "[*] KDE environment detected"
fi

print_in_purple "[*] Installing yay"
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd ..

print_in_purple "[*] Installing from aur"
yay -S --noconfirm --nodiffmenu q\
    insync \
    spotify \
    yuzu-git \
    jetbrains-toolbox \
    nordvpn-bin \
    vlc \
    duf \
    postman-bin

print_in_purple "[*] Setting up nordvpn"
if command -v nordvpn &> /dev/null
then
    systemctl enable nordvpnd.service
    systemctl start nordvpnd.service
    sudo usermod -aG nordvpn $USER
    nordvpn set technology nordlynx
else
    print_in_purple "\t[-] Nordvpn was not found"
fi

print_in_purple "[*] Setting up docker"
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo groupadd docker
sudo usermod -aG docker $USER

cd ~
sudo rm -rf ~/.tempApp

sudo pacman -Syu
