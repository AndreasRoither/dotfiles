#!/usr/bin/env bash
mkdir ~/.tempApp
cd ~/.tempApp

echo "Installing Browsers..."
sudo pacman -S --needed --noconfirm firefox chromium

echo "Installing tools..."
sudo pacman -S --needed --noconfirm \
    npm \
    nodejs \
    python \
    python-pip \
    thunderbird \
    tilda \
    lutris \
    keepassxc \
    gamemode \
    htop \
    qbittorrent

sudo pacman -S --needed --noconfirm docker docker-compose

echo "Installing snapd..."
pamac install snapd
sudo systemctl enable --now snapd.socket
sudo snap install authy --beta
sudo snap install code --classic
sudo snap install gnome-calendar
sudo snap install ao

echo "Installing yay"
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd ~/.tempApp

echo "Installing from aur"
yay -S --noconfirm insync \
    spotify \
    yuzu-git \
    jetbrains-toolbox \
    postman \
    nordvpn-bin

echo "Setting up nordvpn"
systemctl enable nordvpnd.service
systemctl start nordvpnd.service
nordvpn set technology nordlynx

rm -rf ~/.tempApp

sudo pacman -Syu