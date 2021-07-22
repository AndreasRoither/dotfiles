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
kiteco.kite
mechatroner.rainbow-csv
mikestead.dotenv
ms-azuretools.vscode-docker
ms-dotnettools.csharp
ms-python.python
ms-toolsai.jupyter
ms-vscode-remote.remote-ssh
ms-vscode-remote.remote-ssh-edit
ms-vscode-remote.remote-wsl
ms-vscode.cpptools
ms-vscode.powershell
msjsdiag.vscode-react-native
mtxr.sqltools
pranaygp.vscode-css-peek
redhat.java
redhat.vscode-yaml
streetsidesoftware.code-spell-checker
VisualStudioExptTeam.vscodeintellicode
vscjava.vscode-java-debug
vscjava.vscode-java-dependency
vscjava.vscode-java-pack
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
