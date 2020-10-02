#!/usr/bin/env bash

GNOME="GNOME"
KDE="KDE"

mkdir ~/.tempApp
cd ~/.tempApp

echo "[*] Installing Browsers..."
sudo pacman -S --needed --noconfirm firefox chromium

echo "[*] Installing tools..."
sudo pacman -S --needed --noconfirm \
    base-devel \
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
    qbittorrent \
    hub \
    docker \
    docker-compose


if [ $XDG_CURRENT_DESKTOP == $GNOME ]; then
    echo "[*] Gnome environment detected"
    sudo pacman -S -S --needed --noconfirm \
        gnome-tweaks

elif [ $XDG_CURRENT_DESKTOP == $KDE ]; then
    echo "[*] KDE environment detected"
fi

echo "[*] Installing snapd..."
pamac install snapd
sudo systemctl enable --now snapd.socket
sudo snap install authy --beta
sudo snap install code --classic
sudo snap install gnome-calendar
sudo snap install ao

echo "[*] Installing yay"
# setting default answer
yay --save --answerclean 1 --answerdiff None
sudo git clone https://aur.archlinux.org/yay.git && sudo chown -R $USER yay && cd yay && makepkg -si --noconfirm --neededqq && cd ..

echo "[*] Adding required spotify keys"
gpg --keyserver pool.sks-keyservers.net --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
gpg --keyserver pool.sks-keyservers.net --recv-keys 2EBF997C15BDA244B6EBF5D84773BD5E130D1D45

echo "[*] Installing from aur"
yay -S --noconfirm --nodiffmenu q\
    insync \
    spotify \
    yuzu-git \
    jetbrains-toolbox \
    nordvpn-bin \
    vlc \
    duf \
    postman-bin

echo "[*] Setting up nordvpn"
if command -v nordvpn &> /dev/null
then
    systemctl enable nordvpnd.service
    systemctl start nordvpnd.service
    nordvpn set technology nordlynx
else
    echo "\t[-] Nordvpn was not found"
fi


cd ~
sudo rm -rf ~/.tempApp

sudo pacman -Syu
