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
# Fix HOME_DIR placeholder in ghostty config
sed -i '' "s|HOME_DIR|$HOME|" ~/.config/ghostty/config 2>/dev/null || true

# 4. Install tmux plugins (TPM + resurrect + continuum)
echo ""
echo "==> Installing tmux plugins..."
TPM_DIR="$HOME/.tmux/plugins"
mkdir -p "$TPM_DIR"
git clone https://github.com/tmux-plugins/tpm "$TPM_DIR/tpm" 2>/dev/null || true
git clone https://github.com/tmux-plugins/tmux-resurrect "$TPM_DIR/tmux-resurrect" 2>/dev/null || true
git clone https://github.com/tmux-plugins/tmux-continuum "$TPM_DIR/tmux-continuum" 2>/dev/null || true
echo "  → ✓ Done"

# 5. Install tmux scripts (status daemon + notification tester)
echo ""
echo "==> Installing tmux scripts..."
install -m 755 "$DOTFILES_DIR/.tmux/status-daemon.sh" "$HOME/.tmux/status-daemon.sh"
install -m 755 "$DOTFILES_DIR/.tmux/notify-test.sh" "$HOME/.tmux/notify-test.sh"
echo "  → ✓ Done"

# 6. Install tmux-attach-or-create helper (used by Ghostty to attach to persistent tmux server)
echo ""
echo "==> Installing tmux-attach-or-create helper..."
mkdir -p "$HOME/.local/bin"
install -m 755 "$DOTFILES_DIR/bin/tmux-attach-or-create" "$HOME/.local/bin/tmux-attach-or-create"
echo "  → ✓ $HOME/.local/bin/tmux-attach-or-create"

# 7. Create tmux-resurrect save directory
echo ""
echo "==> Creating tmux-resurrect save directory..."
mkdir -p "$HOME/.tmux/resurrect"
echo "  → ✓ $HOME/.tmux/resurrect"

# 7. Install launchd plist for persistent tmux server (survives Ghostty crash)
echo ""
echo "==> Installing launchd plist for tmux persistence..."
cp "$DOTFILES_DIR/mac/com.mitchellh.ghostty.tmux.plist" "$HOME/Library/LaunchAgents/com.mitchellh.ghostty.tmux.plist"
launchctl load "$HOME/Library/LaunchAgents/com.mitchellh.ghostty.tmux.plist" 2>/dev/null || true
echo "  → ✓ tmux server will persist independently of Ghostty"

# 8. Enable tmux zsh hooks (long command notification)
echo ""
echo "==> Adding tmux zsh hooks to ~/.zshrc..."
for hook in notify-long-cmd.zsh; do
  if ! grep -q "$hook" ~/.zshrc 2>/dev/null; then
    printf '\n# Tmux: %s\nsource "%s/zsh/%s"\n' "$hook" "$DOTFILES_DIR" "$hook" >> ~/.zshrc
    echo "  → ✓ Added $hook"
  else
    echo "  → $hook already present"
  fi
done

echo ""
echo "=== ✅ Done! Close and reopen Ghostty. ==="
