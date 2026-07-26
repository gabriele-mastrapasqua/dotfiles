#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing nvm & Node 23"
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 23
nvm alias default 23
nvm use default

echo "==> Installing uv"
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

echo "==> Installing Claude Code"
if ! command -v claude >/dev/null 2>&1; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

echo "==> Installing Codex CLI"
if ! command -v codex >/dev/null 2>&1; then
  curl -fsSL https://chatgpt.com/codex/install.sh | sh
fi

echo "==> Installing OpenCode"
if ! command -v opencode >/dev/null 2>&1; then
  curl -fsSL https://opencode.ai/install | bash
fi

echo "==> Installing Pi"
if ! command -v pi >/dev/null 2>&1; then
  curl -fsSL https://pi.dev/install.sh | sh
fi

echo "==> Installing Headroom"
if ! command -v headroom >/dev/null 2>&1; then
  uv tool install --python 3.13 "headroom-ai[all]"
fi

echo "==> Installing RTK"
if ! command -v rtk >/dev/null 2>&1; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "ERROR: Homebrew is required to install RTK with the preferred method." >&2
    exit 1
  fi
  brew install rtk
fi
echo "==> Ensuring uv tools are on PATH"
uv tool update-shell

echo
echo "Installed versions:"
for cmd in uv claude codex opencode pi headroom rtk; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf "%-10s %s\n" "$cmd" "$(command -v "$cmd")"
  else
    printf "%-10s MISSING\n" "$cmd"
  fi
done
