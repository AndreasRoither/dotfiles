#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../util/utils.sh"

# requirements
print_in_blue "\tInstalling Dependencies\n"
sudo pacman -S gtk-engine-murrine gtk-engines
mkdir ~/.themes

print_in_blue "    Installing Themes\n"
print_in_blue "    Installing gtk-theme-collections\n"
sudo git clone https://github.com/addy-dclxvi/gtk-theme-collections ~/themes/gtk-theme-collections 
sudo cp -r -f ~/themes/gtk-theme-collections/* ~/.themes

print_in_blue "    Installing Qogir\n"
sudo git clone https://github.com/vinceliuice/Qogir-theme.git ~/themes/Qogir-theme
sudo ~/themes/Qogir-theme/install.sh

print_in_blue "    Installing Tant-dracula\n"
sudo git clone https://github.com/dracula/gtk.git ~/themes/ant-dracula
sudo cp -r -f ~/themes/ant-dracula ~/.themes

print_in_blue "    Installing Kripton\n"
sudo git clone https://github.com/EliverLara/Kripton ~/themes/Kripton
sudo cp -r -f ~/themes/Kripton ~/.themes

print_in_blue "    Installing Icon Themes\n"
print_in_blue "    Installing kora\n"
sudo git clone https://github.com/bikass/kora.git ~/icons/kora
sudo cp -r -f ~/icons/kora ~/.icons

print_in_blue "    Installing Tela\n"
sudo git clone https://github.com/vinceliuice/Tela-icon-theme.git ~/icons/Tela-icon-theme
sudo ~/icons/Tela-icon-theme/install.sh

print_in_blue "    Installing Flatery\n"
sudo git clone https://github.com/cbrnix/Flatery.git ~/icons/Flatery
sudo ~/icons/Flatery/install.sh

print_in_blue "    Installing Candy\n"
sudo git clone https://github.com/EliverLara/candy-icons.git ~/icons/Candy
sudo cp -r -f ~/icons/Candy ~/.icons


print_in_blue "    Installing Conky Themes\n"
git clone https://github.com/addy-dclxvi/conky-theme-collections ~/.config/conky --depth 1

print_in_blue "    Updating Icon caches\n"
sudo gtk-update-icon-cache ~/.icons/Candy
sudo gtk-update-icon-cache ~/.icons/Candy