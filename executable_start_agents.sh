#!/usr/bin/env bash

# Alias-based ssh-agent + gpg-agent management for fast terminal startup.
# Works on Linux and Git Bash (Windows). No external deps beyond ssh/gpg.
#
# USAGE:
#   1. Source this file in your shell RC (~/.bashrc or ~/.zshrc):
#        source ~/start_agents.sh
#
#   2. This will:
#      - Define aliases: `start-ssh-agent`, `start-gpg-agent`, `start-agents`
#      - Automatically restore existing agent environment (fast, no process spawn)
#
#   3. Run `start-agents` (or individual aliases) when you need agents running.

SSH_AGENT_ENV_FILE="$HOME/.ssh/agent.env"

# --- Internal helper functions ---

__ssh_agent_env_restore() {
	# Restore SSH agent environment from saved file (fast, no process spawn)
	if [[ -f "$SSH_AGENT_ENV_FILE" ]]; then
		# shellcheck source=/dev/null
		source "$SSH_AGENT_ENV_FILE"
	fi
}

__ssh_agent_is_running() {
	# Check if SSH agent is reachable and usable
	# Returns: 0=running with keys, 1=running without keys, 2=not running
	if [[ -z "$SSH_AUTH_SOCK" ]]; then
		return 2
	fi
	ssh-add -l >/dev/null 2>&1
	return $?
}

__ssh_agent_start() {
	# Start a fresh ssh-agent and persist its environment
	eval "$(ssh-agent -s)" >/dev/null
	mkdir -p "$HOME/.ssh" 2>/dev/null || true
	{
		printf 'export SSH_AUTH_SOCK=%q\n' "$SSH_AUTH_SOCK"
		printf 'export SSH_AGENT_PID=%q\n' "$SSH_AGENT_PID"
	} >| "$SSH_AGENT_ENV_FILE"
	chmod 600 "$SSH_AGENT_ENV_FILE" 2>/dev/null || true
}

# --- Public alias functions ---

start-ssh-agent() {
	# Start or reuse ssh-agent, and optionally add keys
	if ! command -v ssh-add >/dev/null 2>&1; then
		echo "ssh-add not found" >&2
		return 1
	fi

	# Try to restore existing environment first
	__ssh_agent_env_restore

	# Check agent status
	__ssh_agent_is_running
	local agent_status=$?

	case $agent_status in
		0)
			echo "SSH agent already running with keys loaded."
			ssh-add -l
			return 0
			;;
		1)
			echo "SSH agent running but no keys loaded. Adding keys..."
			;;
		2)
			echo "Starting new SSH agent..."
			__ssh_agent_start
			;;
	esac

	# Add default keys if none loaded
	if ! ssh-add -l >/dev/null 2>&1; then
		ssh-add || true
	fi

	echo "SSH agent ready (PID: $SSH_AGENT_PID)"
	ssh-add -l 2>/dev/null || true
}

start-gpg-agent() {
	# Start or reuse gpg-agent
	if ! command -v gpgconf >/dev/null 2>&1; then
		echo "gpgconf not found" >&2
		return 1
	fi

	# Set GPG_TTY for pinentry
	if command -v tty >/dev/null 2>&1; then
		GPG_TTY="$(tty 2>/dev/null || echo /dev/tty)"
		export GPG_TTY
	fi

	# Check if already running
	if gpg-connect-agent --quiet /bye >/dev/null 2>&1; then
		echo "GPG agent already running."
	else
		echo "Starting GPG agent..."
		gpgconf --launch gpg-agent >/dev/null 2>&1
		# Wait briefly for agent to start
		sleep 0.1
		gpg-connect-agent --quiet /bye >/dev/null 2>&1
	fi

	echo "GPG agent ready."
}

start-agents() {
	# Start both SSH and GPG agents
	start-ssh-agent
	echo ""
	start-gpg-agent
}

# --- Auto-restore on source (fast, no process spawn) ---
# Only restore environment variables, don't start agents
__ssh_agent_env_restore

# Set GPG_TTY if available (needed for gpg-agent even when not starting it)
if command -v tty >/dev/null 2>&1; then
	GPG_TTY="$(tty 2>/dev/null || echo /dev/tty)"
	export GPG_TTY
fi
