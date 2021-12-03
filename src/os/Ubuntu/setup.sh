#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../util/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Ubuntu Install\n\n"

ask_for_confirmation "Update system?"
if answer_is_yes; then
    sudo apt-get update
    sudo apt-get upgrade
fi

ask_for_confirmation "Setup packages?"
if answer_is_yes; then
    bash dep-Ubuntu.sh
fi

ask_for_confirmation "Add user andreas?"
if answer_is_yes; then
    sudo adduser andreas
    sudo adduser andreas sudo
    sudo usermod -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio andreas
    sudo usermod -aG docker andreas
    sudo usermod -aG docker $USER
fi

ask_for_confirmation "Setup zsh?"
if answer_is_yes; then
  sudo git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && chsh -s $(which zsh) \
    && sudo git clone https://github.com/spaceship-prompt/spaceship-prompt.git ~/.oh-my-zsh/themes/spaceship-prompt --depth=1 \
    && sudo ln -s ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/themes/spaceship.zsh-theme \
    && sudo git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions \
    && sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi

print_success "Done installing."