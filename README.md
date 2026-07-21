# dotfiles — macOS M1

```bash
git clone <this-repo> ~/.dotfiles && ~/.dotfiles/mac/setup.sh
```

Close and reopen Ghostty.

---

## What you get

**Ghostty** auto-starts `tmux`. All tabs persist across restarts (tmux-resurrect + continuum, auto-save every 5min).

| Key | Action |
|---|---|
| `Cmd+T` | New tab |
| `Cmd+W` | Close tab |
| `Alt+←/→` | Prev / next tab |
| `Alt+1`–`9` | Jump to tab |
| `Ctrl+b Ctrl+s` | Save session |
| `Ctrl+b Ctrl+r` | Restore session |
| `Ctrl+b d` | Detach |
| `Ctrl+b ?` | All keybindings |

Tabs auto-rename to the current folder name on `cd`.

## Live status bar

```
CPU 12%  GPU 5%  RAM 45%  DSK 32%
```

Updated every 3s, top-right corner.

## Notifications

When a command rings the bell (or runs >10s), macOS shows a **popup via Ghostty icon**, the **dock icon bounces**, and the **tmux tab turns red** until you visit it.

Test it: `~/.tmux/notify-test.sh`

## Installed

**CLI:** wget, tree, neovim, grep, openssh, git, git-lfs, the_silver_searcher, tmux  
**GUI:** Ghostty, Zed
