
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

if [ -f ~/.ssh_gpg_agents ]; then
. ~/.ssh_gpg_agents
fi

. "$HOME/.cargo/env"

