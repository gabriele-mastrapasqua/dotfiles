#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== 🍏 macOS M1 Setup ==="
echo ""

# 1. Install Homebrew
echo "==> Installing Homebrew..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "  ✓ Homebrew già installato"
fi

# 2. Install packages & apps
"$DOTFILES_DIR/mac/brew.sh"

# 3. Symlink dotfiles
echo ""
echo "==> Linking dotfiles..."
ln -sf "$DOTFILES_DIR/.vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES_DIR/nvim/init.lua" ~/.config/nvim/init.lua
mkdir -p ~/.config/ghostty
ln -sf "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/config

# 4. Install tmux plugins (TPM + resurrect + continuum)
echo ""
echo "==> Installing tmux plugins..."
TPM_DIR="$HOME/.tmux/plugins"
mkdir -p "$TPM_DIR"
git clone https://github.com/tmux-plugins/tpm "$TPM_DIR/tpm" 2>/dev/null || true
git clone https://github.com/tmux-plugins/tmux-resurrect "$TPM_DIR/tmux-resurrect" 2>/dev/null || true
git clone https://github.com/tmux-plugins/tmux-continuum "$TPM_DIR/tmux-continuum" 2>/dev/null || true
echo "  → ✓ Done"

# 5. Enable tmux auto-rename on folder change (zsh hook)
echo ""
echo "==> Adding tmux auto-rename hook to ~/.zshrc..."
if ! grep -q 'tmux-window-name.zsh' ~/.zshrc 2>/dev/null; then
  printf '\n# Tmux: auto-rename tab to current folder\nsource "%s/zsh/tmux-window-name.zsh"\n' "$DOTFILES_DIR" >> ~/.zshrc
  echo "  → ✓ Added"
else
  echo "  → Already present"
fi

echo ""
echo "=== ✅ Done! Close and reopen Ghostty. ==="
