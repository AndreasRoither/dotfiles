#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../../util/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple " • Manjaro Install\n\n"

if gum confirm "Add user to sudo?"; then
  sudo usermod -aG wheel $USER
  if [ $(getent group sudo) ]; then
    sudo usermod -aG sudo $USER
  else
    print_in_blue "   sudo group does not exist\n"
  fi
fi

if gum confirm "Set pamac mirror to Germany,Austria,France,Switzerland?"; then
  sudo pacman-mirrors --country Germany,Austria,France,Switzerland && sudo pacman -Syyu
fi

if gum confirm "Enable TRIM for SSD?"; then
  sudo systemctl enable fstrim.timer
  sudo systemctl start fstrim.timer
fi

if gum confirm "Install Flatpak?"; then
  gum spin --spinner dot --title "Installing flatpak" -- pamac install flatpak libpamac-flatpak-plugin --noconfirm
fi

if gum confirm "Install Snap?"; then
  gum spin --spinner dot --title "Installing flatpak" -- pamac install snapd libpamac-snap-plugin --noconfirm
  sudo systemctl enable --now snapd.socket
fi

if gum confirm "Setup packages?"; then
  bash dep-ManjaroLinux.sh
  cd "$(dirname "${BASH_SOURCE[0]}")"
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
    sudo git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && chsh -s $(which zsh) && sudo chsh -s $(which zsh) &&
      sudo git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions &&
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

if gum confirm "Windows dual boot time fix?"; then
  sudo timedatectl set-local-rtc 1 && sudo hwclock --systohc --localtime
fi

if gum confirm "Setup intellij watcher fix?"; then
  sudo bash ../../util/intellij_watcher_fix.sh
fi

if gum confirm "Copy window shortcuts?"; then
  cp shortcuts.kksrc ~/.config/
fi

if gum confirm "Install themes?"; then
  theme=$(gum choose "KDE" "GNOME" "XFCE")
  themePath="../../preferences/theme/theme-${theme}.sh"

  if [ ! -f "$themePath" ]; then
    echo "Could not find file with themes for distro ${distro} and theme ${theme}.\n"
    echo -e "\t ${path}"
  else
    bash ${themePath}
  fi
fi

print_success "Done installing."
if gum confirm "Reboot now?"; then
  sudo reboot -h
fi
