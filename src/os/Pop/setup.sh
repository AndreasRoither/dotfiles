#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
    . "../../util/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! cmd_exists "nala"; then
    if gum confirm "Setup nala?"; then
        echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
        wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg >/dev/null

        if gum confirm "Ubuntu 22.04 / Debian Sid and newer?"; then
            sudo apt update && sudo apt install nala
        else
            sudo apt update && sudo apt install nala-legacy
        fi

        print_in_purple "\n • Updating\n\n"
        sudo nala fetch
        sudo nala update && sudo nala upgrade
    else
        print_in_purple "\n • Updating\n\n"
        sudo apt-get update
        sudo apt-get upgrade
    fi
fi

if gum confirm "Setup packages?"; then
    bash dep-PopOS.sh
fi

if ! id -u "andreas" >/dev/null 2>&1; then
    if gum confirm "Add user andreas?"; then
        sudo adduser $USER
        sudo adduser $USER sudo
        sudo usermod -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio andreas
    fi
fi

if gum confirm "Add user to docker?"; then
    sudo usermod -aG docker $USER
fi

if gum confirm "Setup gpg?"; then
    gpg --full-generate-key
    gpg --list-secret-keys --keyid-format=long | grep sec | grep -o -P '(?<=/)[A-Z0-9]*' | gpg --armor --export

    print_in_blue "Setting git gpg key"
    git config --global user.signingkey $(gpg --list-secret-keys --keyid-format=long | grep sec | grep -o -P '(?<=/)[A-Z0-9]*')
fi

if gum confirm "Fix ssh permissions?"; then
    sudo chmod 700 ~/.ssh/
    sudo chmod 600 ~/.ssh/*
    sudo chown -R ${USER} ~/.ssh/
    sudo chgrp -R ${USER} ~/.ssh/
fi

if gum confirm "Setup zsh?"; then

    if [ -d ~/.oh-my-zsh ]; then
        print_warning "Zsh directory already exists."
    else
        sudo git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && chsh -s $(which zsh) &&
            sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions &&
            sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    fi

    if gum confirm "Install spaceship theme?"; then
        sudo git clone https://github.com/spaceship-prompt/spaceship-prompt.git ~/.oh-my-zsh/themes/spaceship-prompt --depth=1 &&
            sudo ln -s ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/themes/spaceship.zsh-theme
        sed -i --follow-symlinks 's|ZSH_THEME="agnoster"|ZSH_THEME="spaceship"|g;' ~/.zshrc
    fi

    if gum confirm "Install powerlevel10k theme?"; then
        sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
        sed -i --follow-symlinks 's|ZSH_THEME="agnoster"|ZSH_THEME="powerlevel10k/powerlevel10k"|g;' ~/.zshrc
        # needs ZSH_THEME="powerlevel10k/powerlevel10k" in .zshrc
    fi
fi

print_success "Done installing."
