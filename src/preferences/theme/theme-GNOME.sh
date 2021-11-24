#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../util/utils.sh"

mkdir temp && cd temp
print_in_blue "\tInstalling Tela\n"
git clone https://github.com/vinceliuice/Tela-icon-theme.git && cd Tela-icon-theme && ./install.sh && cd ..
print_in_blue "\tInstalling Orchid\n"
git clone https://github.com/vinceliuice/Orchis-theme.git && cd Orchis-theme && ./install.sh && cd ..
print_in_blue "\tInstalling Grub2\n"
git clone https://github.com/vinceliuice/grub2-themes.git && cd grub2-themes && sudo ./install.sh -b -t tela
rm -rf temp
