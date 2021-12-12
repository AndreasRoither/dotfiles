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

    if [ -d ~/.oh-my-zsh ]; then
        print_warning "Zsh directory already exists."
    else 
        sudo git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && chsh -s $(which zsh) \
            && sudo git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions \
            && sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    fi

    ask_for_confirmation "Install spaceship theme?"
    if answer_is_yes; then
        sudo git clone https://github.com/spaceship-prompt/spaceship-prompt.git ~/.oh-my-zsh/themes/spaceship-prompt --depth=1 \
            && sudo ln -s ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/themes/spaceship.zsh-theme
        sed -i --follow-symlinks 's|ZSH_THEME="agnoster"|ZSH_THEME="spaceship"|g;' ~/.zshrc
    fi

    ask_for_confirmation "Install powerlevel10k theme?"
    if answer_is_yes; then
        sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
        sed -i --follow-symlinks 's|ZSH_THEME="agnoster"|ZSH_THEME="powerlevel10k/powerlevel10k"|g;' ~/.zshrc
        # needs ZSH_THEME="powerlevel10k/powerlevel10k" in .zshrc
    fi
fi

print_success "Done installing."