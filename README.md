# dotfiles — macOS M1 setup (2026)

## Quick start on a new Mac

```bash
git clone <this-repo> ~/.dotfiles
~/.dotfiles/mac/setup.sh
```

Then close and reopen Ghostty.

## What's inside

| File | Purpose |
|---|---|
| `mac/setup.sh` | Installs Homebrew → packages → symlinks |
| `mac/brew.sh` | CLI tools + GUI apps (neovim, tmux, ghostty, zed, etc.) |
| `.tmux.conf` | Tmux config with resurrect + continuum (auto-save tabs) |
| `ghostty/config` | Ghostty: auto-starts tmux, Ctrl+Tab maps to tmux |
| `nvim/init.lua` | Neovim config (ported from .vimrc) |
| `.vimrc` | Kept for compatibility |

## Terminal tabs: how it works

Ghostty auto-starts `tmux new-session -A -s main` at every launch.

**tmux-resurrect** saves your full session (tabs, panes, working directories, running programs).  
**tmux-continuum** auto-saves every 5 minutes and auto-restores on startup.

So when you close Ghostty and reopen it, **all your tabs are back exactly as you left them**.

### First time use

1. Open Ghostty → tmux starts with 1 default tab
2. Create tabs: `Ctrl+b c`
3. Save immediately: `Ctrl+b Ctrl+s`
4. Close Ghostty and reopen → **all tabs restored**

After the first save, continuum auto-saves every 5 min. Just open Ghostty and your session is restored.

### Tab switching

| Keys | Action |
|---|---|
| `Ctrl+Tab` | Next tab (maps to tmux) |
| `Ctrl+Shift+Tab` | Previous tab (maps to tmux) |
| `Ctrl+b 0` through `Ctrl+b 9` | Jump to tab by number |
| `Ctrl+b p` / `Ctrl+b n` | Previous / next tab |
| `Ctrl+b ,` | Rename current tab |

### Tab management

| Keys | Action |
|---|---|
| `Ctrl+b c` | Create new tab |
| `Ctrl+b %` | Split pane vertically |
| `Ctrl+b "` | Split pane horizontally |
| `Ctrl+b arrows` | Navigate between panes |
| `Ctrl+b d` | Detach (session keeps running) |
| `Ctrl+b ?` | Show all keybindings (q to quit) |

### Saving and restoring

| Keys | Action |
|---|---|
| `Ctrl+b Ctrl+s` | Save session now |
| `Ctrl+b Ctrl+r` | Restore last save |

Continuum also auto-saves every 5 minutes automatically.

### Tab naming

Tabs appear as "zsh" by default. Rename them with `Ctrl+b ,` so you know what's in each one.

## Installed packages

**CLI:** wget, tree, neovim, grep, openssh, git, git-lfs, the_silver_searcher, tmux  
**GUI:** Ghostty, Zed
