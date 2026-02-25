<p align="center">
  <!--<img src="doc/og-default.jpg" alt="Tea" width="500"  />-->
  <br />
  <strong>dotfiles</strong>
</p>

# About

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

Targets Arch Linux (CachyOS) with KDE Plasma, zsh + Oh My Zsh + Starship, and a full dev toolchain (Go, Rust, Node, Python, Docker).

## Quick Start

**One-liner for a fresh machine:**

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply AndreasRoither/dotfiles
```

**If chezmoi is already installed:**

```bash
chezmoi init --apply https://github.com/AndreasRoither/dotfiles.git
```

On first run, chezmoi will prompt for:
- **Name** — git user name
- **Email** — git email
- **Signing key** — SSH signing key path
- **Hostname** — machine identifier (used in Alacritty window title)
- **Editor** — preferred editor command (e.g. `code --wait`)

## What's Managed

| File | Description |
|------|-------------|
| `~/.aliases` | Shell aliases (ls, git, docker, go, arch, etc.) |
| `~/.zshrc` | Zsh config with Oh My Zsh, plugins, path setup |
| `~/.bashrc` | Bash config with nvm, cargo, zoxide |
| `~/.bash_profile` | Bash profile |
| `~/.gitconfig` | Git config with aliases, signing and custom settings |
| `~/.gitignore_global` | Global gitignore |
| `~/start_agents.sh` | SSH & GPG agent management |
| `~/docker-compose.yml` | PostgreSQL + pgAdmin dev stack |
| `~/.local/bin/generate-ssh-key` | Interactive ed25519 SSH key gen script |
| `~/.config/alacritty/alacritty.toml` | Alacritty terminal settings|

## Scripts

Scripts run automatically during `chezmoi apply`:

1. **Bootstrap** (`run_once`) — Installs paru AUR helper if missing
2. **Packages** (`run_onchange`) — Interactive package group installer, re-runs when `packages.yaml` changes
3. **Shell setup** (`run_once`) — Installs Oh My Zsh + plugins, sets zsh as default shell
4. **Node.js setup** (`run_once`) — Installs nvm, Node.js LTS, and pnpm
5. **Zed** (`run_once`) — Installs Zed editor via official script

## Adding New Dotfiles

```bash
# Add a file to chezmoi management
chezmoi add ~/.config/some/config

# Edit a managed file
chezmoi edit ~/.config/some/config

# Preview changes before applying
chezmoi diff

# Apply changes
chezmoi apply
```

## Day-to-Day Usage

```bash
# Pull latest and apply
chezmoi update

# See what would change
chezmoi diff

# Edit chezmoi source directly
chezmoi cd

# Re-run apply (scripts only re-run per their prefix rules)
chezmoi apply
```

---

<div align="center">
    Built With ❤️ and Tea 🍵
</div>
