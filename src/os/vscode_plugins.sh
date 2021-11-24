#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../util/utils.sh"

# execute command
# -------------------
# curl -s https://raw.githubusercontent.com/AndreasRoither/dotfiles/master/scripts/vscode-plugins.sh | /bin/bash

# list current extensions with: code --list-extensions

# Visual Studio Code :: Package list
pkglist=(
aaron-bond.better-comments
abusaidm.html-snippets
austin.code-gnu-global
christian-kohler.npm-intellisense
christian-kohler.path-intellisense
DavidAnson.vscode-markdownlint
dbaeumer.vscode-eslint
eamodio.gitlens
ecmel.vscode-html-css
esbenp.prettier-vscode
firefox-devtools.vscode-firefox-debug
GitHub.copilot
GitHub.vscode-pull-request-github
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
ms-vscode-remote.remote-containers
ms-vscode-remote.remote-ssh
ms-vscode-remote.remote-ssh-edit
ms-vscode-remote.remote-wsl
ms-vscode.cpptools
ms-vscode.powershell
msjsdiag.vscode-react-native
mtxr.sqltools
mtxr.sqltools-driver-pg
pranaygp.vscode-css-peek
redhat.java
redhat.vscode-commons
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

print_in_purple "\n • Installing VSCode Plugins..\n"

for i in ${pkglist[@]}; do
  ./src/util/spinner.sh code --install-extension $i
done
