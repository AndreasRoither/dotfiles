#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../util/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple " • Manjaro Install\n\n"



ask_for_confirmation "Add user to sudo?"
if answer_is_yes; then
    sudo usermod -aG wheel $USER
    if [ $(getent group sudo) ]; then
        sudo usermod -aG sudo $USER
    else
      print_in_blue "   sudo group does not exist\n"
    fi
fi

ask_for_confirmation "Set pamac mirror to Germany,Austria,France,Switzerland?"
if answer_is_yes; then
  sudo pacman-mirrors --country Germany,Austria,France,Switzerland && sudo pacman -Syyu
fi

ask_for_confirmation "Enable TRIM for SSD?"
if answer_is_yes; then
  sudo systemctl enable fstrim.timer
  sudo systemctl start fstrim.timer
fi

ask_for_confirmation "Install Flatpak?"
if answer_is_yes; then
  pamac install flatpak libpamac-flatpak-plugin 
fi

ask_for_confirmation "Install Snap?"
if answer_is_yes; then
  pamac install snapd libpamac-snap-plugin
  sudo systemctl enable --now snapd.socket 
fi

ask_for_confirmation "Setup packages?"
if answer_is_yes; then
  bash dep-ManjaroLinux.sh
  cd "$(dirname "${BASH_SOURCE[0]}")"
fi

#ask_for_confirmation "Setup ssh?"
#if answer_is_yes; then
  # TODO: Add ssh auto configuration
#fi

ask_for_confirmation "Setup zsh?"
if answer_is_yes; then

    if [ -d ~/.oh-my-zsh ]; then
        print_warning "Zsh directory already exists."
    else 
        sudo git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && chsh -s $(which zsh) && sudo chsh -s $(which zsh) \
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

ask_for_confirmation "Windows dual boot time fix?"
if answer_is_yes; then
    sudo timedatectl set-local-rtc 1 && sudo hwclock --systohc --localtime
fi

ask_for_confirmation "Setup intellij watcher fix?"
if answer_is_yes; then
    sudo bash ../../util/intellij_watcher_fix.sh
fi

ask_for_confirmation "Copy window shortcuts?"
if answer_is_yes; then
    cp shortcuts.kksrc ~/.config/
fi
y
ask_for_confirmation "Install themes?"
if answer_is_yes; then
  ask "What is your Desktop Environment? (KDE/GNOME/XFCE) "
  theme="$(get_answer)"
  themePath="../../preferences/theme/theme-${theme}.sh"

  if [ ! -f "$themePath" ]; then
    echo "Could not find file with themes for distro ${distro}.\n"
    echo -e "\t ${path}"
  else
    bash ${themePath}
  fi
fi

print_success "Done installing."
ask_for_confirmation "Reboot now?"
if answer_is_yes; then
  sudo reboot -h
fi