#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../util/utils.sh"


mkdir temp && cd temp
gum spin --spinner dot --title "Installing Tela Theme..." -- git clone https://github.com/vinceliuice/Tela-icon-theme.git && cd tela-icon-theme && ./install.sh && cd ..
gum spin --spinner dot --title "Installing Orchis Theme..." -- git clone https://github.com/vinceliuice/Orchis-theme.git && cd orchis-theme && ./install.sh && cd ..
gum spin --spinner dot --title "Installing themes Theme..." -- git clone https://github.com/vinceliuice/grub2-themes.git && cd grub2-themes && sudo ./install.sh -b -t tela
cd .. && rm -rf temp
