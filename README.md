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
| `.tmux.conf` | Tmux config with resurrect + continuum, bell notifications, status bar |
| `.tmux/status-daemon.sh` | Background daemon: CPU, GPU, RAM, Disk % in tmux status bar |
| `.tmux/notify-test.sh` | Tester for tmux bell → macOS notification pipeline |
| `ghostty/config` | Ghostty: auto-starts tmux, remaps Cmd+T/W, Ctrl+Tab |
| `zsh/tmux-window-name.zsh` | Zsh hooks to auto-rename tabs to current folder |
| `zsh/notify-long-cmd.zsh` | Zsh hooks: bell + macOS notification on commands >10s |
| `nvim/init.lua` | Neovim config (ported from .vimrc) |
| `.vimrc` | Kept for compatibility |

## Terminal tabs: how it works

Ghostty auto-starts `tmux new-session -A -s main` at every launch.

**tmux-resurrect** saves your full session (tabs, panes, working directories, running programs).  
**tmux-continuum** auto-saves every 5 minutes and auto-restores on startup.

So when you close Ghostty and reopen it, **all your tabs are back exactly as you left them**.

### First time use

1. Open Ghostty → tmux starts with 1 default tab
2. Create tabs: `Cmd+T` (or `Ctrl+b c`)
3. Save immediately: `Ctrl+b Ctrl+s`
4. Close Ghostty and reopen → **all tabs restored**

After the first save, continuum auto-saves every 5 min. Just open Ghostty and your session is restored.

### macOS keybindings (Ghostty → tmux)

These override Ghostty's default actions and send commands directly to tmux:

| macOS key | Effect |
|---|---|
| `Cmd+T` | New tmux tab (instead of Ghostty tab) |
| `Cmd+W` | Close current tmux tab/window (instead of closing Ghostty) |
| `Ctrl+Tab` | Next tmux tab |
| `Ctrl+Shift+Tab` | Previous tmux tab |

### Tmux keybindings (prefix = Ctrl+B)

| Keys | Action |
|---|---|
| `Ctrl+b c` | Create new tab |
| `Ctrl+b 0`–`9` | Jump to tab by number |
| `Ctrl+b p` / `Ctrl+b n` | Previous / next tab |
| `Ctrl+b ,` | Rename current tab |
| `Ctrl+b %` | Split pane vertically |
| `Ctrl+b "` | Split pane horizontally |
| `Ctrl+b arrows` | Navigate between panes |
| `Ctrl+b d` | Detach (session keeps running in background) |
| `Ctrl+b ?` | Show all keybindings (q to quit) |

### Alternative tab switching (no prefix)

| Keys | Action |
|---|---|
| `Alt+←` / `Alt+→` | Previous / next tab |
| `Alt+1` – `Alt+9` | Jump to tab by number |

### Saving and restoring

| Keys | Action |
|---|---|
| `Ctrl+b Ctrl+s` | Save session now |
| `Ctrl+b Ctrl+r` | Restore last save |

Continuum also auto-saves every 5 minutes automatically.

### Tab naming

Tabs show the **last folder name** of your current working directory (e.g. `dotfiles`, `keyra`).  
The name updates **instantly** when you `cd` to another folder.

Powered by `zsh/tmux-window-name.zsh` (installed via setup.sh).

### System stats in status bar

The top-right corner of the tmux status bar shows live system usage:

```
CPU 12%  GPU 5%  RAM 45%  DSK 32%
```

Updated every 3s by `~/.tmux/status-daemon.sh` (background process launched by tmux).

### Notifications (bell → macOS popup)

When a process rings the terminal bell, tmux triggers:

1. **macOS notification** popup via Ghostty icon (top-right)
2. **Ghostty icon bounce** in the dock
3. **Tab turns red** in the status bar until you switch to it

The red tab indicator uses Catppuccin red (`#f38ba8`) — so you can see which tab has pending output at a glance.

Test it with `~/.tmux/notify-test.sh`.

### Auto-notify on long commands

`zsh/notify-long-cmd.zsh` rings the bell automatically when any command runs longer than **10 seconds** (e.g. build, test, deploy, opencode, claude code, install).

No per-command config needed — every long-running CLI tool gets the same treatment.

## Installed packages

**CLI:** wget, tree, neovim, grep, openssh, git, git-lfs, the_silver_searcher, tmux  
**GUI:** Ghostty, Zed
