#!/usr/bin/env bash

#!/bin/bash

# execute command
# -------------------
# curl -s https://raw.githubusercontent.com/AndreasRoither/dotfiles/master/scripts/vscode-plugins.sh | /bin/bash

# list current extensions with: code --list-extensions

# Visual Studio Code :: Package list
pkglist=(
aaron-bond.better-comments
abusaidm.html-snippets
AnthonyJGatlin.vscode-cypher-query-language-tools
austin.code-gnu-global
christian-kohler.path-intellisense
DavidAnson.vscode-markdownlint
dbaeumer.vscode-eslint
eamodio.gitlens
ecmel.vscode-html-css
Equinusocio.vsc-community-material-theme
Equinusocio.vsc-material-theme
equinusocio.vsc-material-theme-icons
esbenp.prettier-vscode
firefox-devtools.vscode-firefox-debug
golang.go
GrapeCity.gc-excelviewer
Gruntfuggly.todo-tree
James-Yu.latex-workshop
jpoissonnier.vscode-styled-components
mechatroner.rainbow-csv
mikestead.dotenv
ms-azuretools.vscode-docker
ms-dotnettools.csharp
ms-python.python
ms-python.vscode-pylance
ms-toolsai.jupyter
ms-vscode-remote.remote-ssh
ms-vscode-remote.remote-ssh-edit
ms-vscode-remote.remote-wsl
ms-vscode.cpptools
ms-vscode.powershell
msjsdiag.vscode-react-native
PKief.material-icon-theme
platformio.platformio-ide
pranaygp.vscode-css-peek
redhat.java
redhat.vscode-yaml
ronaldosena.arduino-snippets
rust-lang.rust
streetsidesoftware.code-spell-checker
VisualStudioExptTeam.vscodeintellicode
vsciot-vscode.vscode-arduino
vscjava.vscode-java-debug
vscjava.vscode-java-dependency
vscjava.vscode-java-pack
vscjava.vscode-java-test
vscjava.vscode-maven
vscode-icons-team.vscode-icons
vscodevim.vim
wayou.vscode-todo-highlight
xabikos.JavaScriptSnippets
yzane.markdown-pdf
yzhang.markdown-all-in-one
Zignd.html-css-class-completion
)

echo "[*] Installing VSCode Plugins.."

for i in ${pkglist[@]}; do
  code --install-extension $i
done
