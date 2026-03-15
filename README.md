# dotfiles

Minimal personal dotfiles for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

This setup is focused on:
- Node.js development
- Neovim
- tmux
- iTerm2 as terminal

## Fresh macOS setup

### 1. Xcode Command Line Tools

```bash
xcode-select --install
```

### 2. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. Brew packages

```bash
brew install stow neovim tmux asdf direnv jq ripgrep reattach-to-user-namespace
brew install --cask iterm2
```

| Package | What it does |
|---------|-------------|
| `stow` | Symlink manager for dotfiles |
| `neovim` | Neovim editor |
| `tmux` | Terminal multiplexer |
| `asdf` | Runtime manager (Node.js) |
| `direnv` | Per-directory environment variables |
| `jq` | JSON processor for shell scripts |
| `ripgrep` | Fast project search (used by nvim tools) |
| `reattach-to-user-namespace` | macOS clipboard integration for tmux |
| `iterm2` | Terminal emulator used by this setup |

### 4. Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 5. Node.js via asdf

```bash
asdf plugin add nodejs
asdf install nodejs
asdf set -u nodejs latest
```

### 6. Clone and install dotfiles

```bash
mkdir -p ~/Documents/code
git clone <your-fork-url> ~/Documents/code/dotfiles
cd ~/Documents/code/dotfiles
make deps
make install
source ~/.zshrc
```

### 7. Neovim first run

Open `nvim`. Plugin manager will install configured plugins on first launch.

## iTerm2 setup

The repo now tracks iTerm2 preferences in [`iterm2/.config/iterm2/com.googlecode.iterm2.plist`](iterm2/.config/iterm2/com.googlecode.iterm2.plist), inside a directory-level symlink at `~/.config/iterm2/`.

After `make install` or `make stow-iterm2`, enable the custom folder once in iTerm2:

1. Open iTerm2 → Settings → Preferences
2. Enable `Load preferences from a custom folder or URL`
3. Set the folder to `~/.config/iterm2`
4. Restart iTerm2

Tracked defaults include:
- Report Terminal Type: `xterm-256color`
- Left Option key: `Esc+`
- Right Option key: `Esc+`
- Current profile appearance, fonts, and colors

This keeps tmux, zsh, and Neovim Meta/Alt mappings consistent on macOS.

## Usage

```bash
make help           # Show all commands
make deps           # Check dependencies
make check          # Verify symlinks
make status         # Show stow package status
make restow         # Re-stow all packages
make stow-zsh       # Stow a single package
make unstow-zsh     # Unstow a single package
make lint           # Check for hardcoded paths
```

## Packages

| Package | What it manages |
|---------|----------------|
| `zsh` | `.zshenv`, `.zprofile`, `.zshrc`, `.profile` |
| `git` | `.gitconfig`, `.gitignore_global` |
| `tmux` | `.tmux.conf` |
| `tool-versions` | `.tool-versions` (asdf defaults) |
| `nvim` | `.config/nvim/` |
| `direnv` | `.config/direnv/direnv.toml` |
| `iterm2` | `.config/iterm2/` |
