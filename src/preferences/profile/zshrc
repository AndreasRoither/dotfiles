# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/andreas/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    golang
    docker
    vscode
    dotenv
    zsh-autosuggestions
    zsh-syntax-highlighting
    sudo
    copydir
    dirhistory
    history
    git-auto-fetch
    git-prompt
    gitignore
    yarn
    zsh-interactive-cd
)

source $ZSH/oh-my-zsh.sh


# ----------------------
# general setup
# ----------------------
# aliases
if [ -f ~/.aliases ]; then
. ~/.aliases
fi

# start ssh and gpg
if [ -f ~/.ssh_gpg_agent ]; then
. ~/.ssh_gpg_agent
fi

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

# Shorten directory names
# hash -d onedrive=/home/$USER/Insync/andi.roither@hotmail.de/OneDrive

# https://blog.meain.io/2019/automatically-ls-after-cd/
# So, zsh lets you run some functions after running anything that will change directory. The commands that are run are listed in this variable 
# called chpwd_functions and you can add more to the list.
# So what we do here in the code is create a function(list_all in our case) which just does an ls and add it to the list of commands 
# that will be run after a change in directory happens.
# There is just some check happening to make sure that the function is not already in the list before we add it. That is what that if condition does.

# unset the cd function defined in bashrc
unset -f cd

function list_all() {
  emulate -L zsh
  ls
}
if [[ ${chpwd_functions[(r)list_all]} != "list_all" ]];then
  chpwd_functions=(${chpwd_functions[@]} "list_all")
fi