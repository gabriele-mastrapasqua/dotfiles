#!/usr/bin/env bash

set -euo pipefail

echo "🍺 Updating Homebrew..."
brew update
brew upgrade || true   # ignore cask sudo errors (e.g. session-manager-plugin)

echo "📦 Installing CLI tools..."
brew install wget
brew install tree
brew install neovim
brew install grep
brew install openssh
brew install git
brew install git-lfs
brew install the_silver_searcher
brew install tmux

echo "🖥️ Installing GUI apps (casks)..."
brew install --cask ghostty
brew install --cask zed

echo "🔗 Aliasing vim/vi to nvim..."
if command -v nvim &>/dev/null; then
  if ! grep -q 'alias vim=nvim' ~/.zshrc 2>/dev/null; then
    {
      echo ''
      echo '# Alias vim/vi to neovim'
      echo 'alias vim=nvim'
      echo 'alias vi=nvim'
    } >>~/.zshrc
    echo '  → Added aliases to ~/.zshrc (restart shell or source ~/.zshrc)'
  else
    echo '  → Aliases already present in ~/.zshrc'
  fi
fi

echo "🧹 Cleaning up..."
brew cleanup

echo ""
echo "✅ Done! Restart your shell or run: source ~/.zshrc"
