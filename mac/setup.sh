#!/usr/bin/env bash

set -Eeuo pipefail

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
if [[ "${DOTFILES_SKIP_BREW:-0}" == "1" ]]; then
  echo "==> Skipping Homebrew package installation (DOTFILES_SKIP_BREW=1)"
else
  "$DOTFILES_DIR/mac/brew.sh"
fi

# 3. Symlink dotfiles
echo ""
echo "==> Linking dotfiles..."
ln -sf "$DOTFILES_DIR/.vimrc" ~/.vimrc
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES_DIR/nvim/init.lua" ~/.config/nvim/init.lua
mkdir -p ~/.config/ghostty
ln -sf "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/config

# 4. Install dev tools (uv, Claude Code, Codex, OpenCode, Pi, Headroom, RTK, …)
echo ""
"$DOTFILES_DIR/mac/devtools.sh"

# 5. Install ai launcher
echo ""
echo "==> Installing ai launcher..."
mkdir -p "$HOME/.local/bin"
cp "$DOTFILES_DIR/mac/ai-launcher.sh" "$HOME/.local/bin/ai"
chmod +x "$HOME/.local/bin/ai"

echo ""
echo "=== ✅ Done! Close and reopen Ghostty. Native mode is active. ==="
