#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../util/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple " • Manjaro Install\n\n"

ask_for_confirmation "Add user to sudo?"
if answer_is_yes; then
  sudo usermod -aG wheel $USER && sudo usermod -aG sudo $USER
fi

ask_for_confirmation "Setup packages?"
if answer_is_yes; then
  bash dep-ManjaroLinux.sh
  cd "$(dirname "${BASH_SOURCE[0]}")"
fi

ask_for_confirmation "Setup ssh?"
if answer_is_yes; then
  bash .
fi

ask_for_confirmation "Setup zsh?"
if answer_is_yes; then
  cd "$(dirname "${BASH_SOURCE[0]}")"
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && chsh -s $(which zsh) \
    && sudo git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 \
    && sudo ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" \
    && git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

ask_for_confirmation "Install vscode extensions?"
if answer_is_yes; then
    cd "$(dirname "${BASH_SOURCE[0]}")" && ../../util/spinner.sh bash ../vscode-plugins.sh
fi

ask_for_confirmation "Setup intellij watcher fix?"
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

ask_for_confirmation "Install themes?"
if answer_is_yes; then
  ask "What is your Desktop Environment? (KDE/GNOME)"
  theme="$(get_answer)"
  themePath="../../preferences/theme/theme-${theme}.sh"

  if [ ! -f "$themePath" ]; then
    echo "Could not find file with themes for distro ${distro}."
    echo -e "\t ${path}"
  else
    sudo bash ${themePath}
  fi
fi

print_success "Done installing."