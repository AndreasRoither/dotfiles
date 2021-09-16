cd ~ && mkdir temp && cd temp
git clone https://github.com/vinceliuice/Tela-icon-theme.git && cd Tela-icon-theme && ./install.sh && cd ..
git clone https://github.com/vinceliuice/Orchis-theme.git && cd Orchis-theme && ./install.sh && cd ..
git clone https://github.com/vinceliuice/grub2-themes.git && cd grub2-themes && sudo ./install.sh -b -t tela
cd ~ && rm -rf temp
