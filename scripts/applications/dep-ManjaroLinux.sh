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

sudo pacman -S --needed --noconfirm docker docker-compose

echo "Installing snapd..."
pamac install snapd
sudo systemctl enable --now snapd.socket
sudo snap install authy --beta
sudo snap install code --classic
sudo snap install gnome-calendar
sudo snap install ao


echo "Installing from aur"
git clone https://aur.archlinux.org/insync.git && cd insync && makepkg -si; cd ~/.tempApp
git clone https://aur.archlinux.org/spotify.git && cd spotify && makepkg -si; cd ~/.tempApp
git clone https://aur.archlinux.org/yuzu-git.git && cd yuzu-git && makepkg -si; cd ~/.tempApp
git clone https://aur.archlinux.org/jetbrains-toolbox.git && cd jetbrains-toolbox && makepkg -si; cd ~/.tempApp
git clone https://aur.archlinux.org/postman.git && cd postman && makepkg -si; cd ~/.tempApp
git clone https://aur.archlinux.org/nordvpn-bin.git cd nordvpn-bin && makepkg -si; cd ~/.tempApp

echo "Setting up nordvpn"
systemctl enable nordvpnd.service
systemctl start nordvpnd.service
nordvpn set technology nordlynx

rm -rf ~/.tempApp

sudo pacman -Syu