#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
    . "../../util/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Raspberry Install\n\n"

if gum confirm "Update system?"; then
    sudo apt-get update
    sudo apt-get upgrade
fi

if gum confirm "Setup packages?"; then
    bash dep-Raspbian.sh
fi

if gum confirm "Add user andreas?"; then
    sudo adduser andreas
    sudo adduser andreas sudo
    sudo usermod -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio andreas
    sudo usermod -aG docker andreas
    sudo usermod -aG docker $USER
fi

if gum confirm "Setup zsh?"; then
    sudo git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && sudo chsh -s $(which zsh) &&
        sudo git clone https://github.com/spaceship-prompt/spaceship-prompt.git ~/.oh-my-zsh/themes/spaceship-prompt --depth=1 &&
        sudo ln -s ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/themes/spaceship.zsh-theme &&
        sudo git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions &&
        sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi

print_success "Done installing."
