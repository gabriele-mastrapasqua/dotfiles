# dotfiles

My minimal macOS Apple Silicon setup for terminal work: Ghostty, tmux,
Neovim, and a few useful automations to keep everything in context.

## ✨ Features

- **Ghostty** automatically starts a persistent tmux session named `main`.
- **tmux-resurrect + tmux-continuum** save the session every 5 minutes and
  restore it after a restart.
- tmux windows are automatically named after the current directory.
- A top status bar shows **CPU, GPU, RAM, and disk usage**, refreshed every
  3 seconds.
- macOS notifications when a command rings the bell or runs for more than 10
  seconds.
- Minimal Neovim setup with line numbers, incremental search, intuitive splits,
  4-space indentation, and Markdown wrapping.
- tmux mouse support and True Color enabled.

## 🚀 Installation

> Designed for macOS with Homebrew installed at `/opt/homebrew`.

```bash
git clone https://github.com/gabriele-mastrapasqua/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./mac/setup.sh
```

The setup script installs Homebrew if needed, installs the tools and apps,
creates symlinks for the configuration files, installs the tmux plugins, and
adds the zsh hooks to `~/.zshrc`.

When it is done, close and reopen Ghostty.

## 📦 What gets installed

**CLI tools**

`wget` · `tree` · `neovim` · `grep` · `openssh` · `git` · `git-lfs` ·
`the_silver_searcher` · `tmux`

**Apps**

`Ghostty` · `Zed`

The setup also aliases `vim` and `vi` to `nvim`.

## ⌨️ Custom tmux keybinds

The tmux prefix remains the default: **`Ctrl+b`**.

### Windows

| Shortcut | Action |
| --- | --- |
| `Cmd+t` | Open a new window in the current directory |
| `Ctrl+t` | Open a new window in the current directory |
| `Cmd+w` | Close the current window |
| `Ctrl+Tab` | Next window |
| `Ctrl+Shift+Tab` | Previous window |
| `Alt+←` / `Alt+→` | Previous / next window |
| `Alt+1` … `Alt+9` | Jump to the selected window |

### Sessions

| Shortcut | Action |
| --- | --- |
| `Ctrl+b c` | Open a new window |
| `Ctrl+b Ctrl+s` | Save the session immediately |
| `Ctrl+b Ctrl+r` | Restore the session |
| `Ctrl+b d` | Detach from the session |
| `Ctrl+b ?` | Show all keybinds |

## 🔔 Notifications

To test notifications from inside a tmux window:

```bash
~/.tmux/notify-test.sh
```

If nothing appears, enable notifications for Ghostty in **System Settings →
Notifications**.

## 📁 Structure

```text
ghostty/    Ghostty configuration
mac/        installation and Homebrew scripts
nvim/       Neovim configuration
zsh/        window naming and long-command notification hooks
.tmux.conf  tmux configuration
```

## 🔄 Updating

```bash
cd ~/.dotfiles
git pull
./mac/setup.sh
```
