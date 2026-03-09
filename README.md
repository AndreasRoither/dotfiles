<p align="center">
  <!--<img src="doc/og-default.jpg" alt="Tea" width="500"  />-->
  <br />
  <strong>dotfiles</strong>
</p>

# About

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

Targets Arch Linux (CachyOS) with KDE Plasma, zsh + Oh My Zsh + Starship, and a full dev toolchain (Go, Rust, Node, Python, Docker etc).

## Quick Start

**One-liner for a fresh machine:**

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply AndreasRoither/dotfiles
```

**If chezmoi is already installed:**

```bash
chezmoi init --apply https://github.com/AndreasRoither/dotfiles.git
```

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
