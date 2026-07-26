# dotfiles

Minimal macOS Apple Silicon setup for terminal work: Ghostty, Neovim, and a
few useful shell automations.

## Features

- Native Ghostty terminal sessions.
- Ghostty restores tabs, splits, window geometry, and working directories with
  `window-save-state = always`.
- A wider 140-column default window and 15pt font.
- Ghostty bell/tab attention plus a macOS notification after commands running
  for at least 10 seconds.
- Minimal Neovim setup with line numbers, incremental search, intuitive splits,
  4-space indentation, and Markdown wrapping.
- Dev toolchain installer: nvm + Node 23, uv, Claude Code, Codex CLI, OpenCode,
  Pi, Headroom (via uv), RTK.
- `ai` launcher — opt-in wrapping with `--headroom`/`--rtk` for any agent.

## Installation

Designed for macOS with Homebrew installed at `/opt/homebrew`:

```bash
git clone https://github.com/gabriele-mastrapasqua/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./mac/setup.sh
```

The setup script installs the tools and apps and creates the configuration
symlinks. When it is done, close and reopen Ghostty.

Use `DOTFILES_SKIP_BREW=1 ./mac/setup.sh` to apply only configuration changes
when Homebrew and the packages are already installed.

## Packages

`wget` · `tree` · `neovim` · `grep` · `openssh` · `git` · `git-lfs` ·
`the_silver_searcher`

Apps: `Ghostty` · `Zed`.

The setup also aliases `vim` and `vi` to `nvim`.

## Notifications

Ghostty owns the notification path. Its `bell,notify` actions update the
Dock/tab attention state and request a macOS notification after a command runs
for at least 10 seconds:

```bash
sleep 11
```

If nothing appears, enable notifications for Ghostty in **System Settings →
Notifications**, then reload Ghostty with `Cmd+Shift+,` or restart it.

## Session state

Ghostty can remember the terminal layout, tabs, paths, and window geometry, but
it does not preserve live processes after a hard crash. A separate tab-save
script can be added later if that limitation becomes important.

## Structure

```text
ghostty/            Ghostty configuration
mac/                installation scripts
  setup.sh            main entry point (Homebrew, dotfiles, dev tools, ai launcher)
  brew.sh             Homebrew packages and apps
  devtools.sh         AI coding toolchain (nvm, uv, Claude, Codex, OpenCode, Pi, Headroom, RTK)
  ai-launcher.sh      ai wrapper (opt-in headroom/rtk per agent)
nvim/               Neovim configuration
zsh/                shell configuration snippets
```

## AI Launcher

The `ai` command wraps coding agents with optional Headroom and RTK:

```bash
ai claude                          # plain agent
ai codex
ai opencode
ai pi
ai codex-team                      # custom Codex variant — setup at https://github.com/gabriele-mastrapasqua/codex-lean-team

ai -H claude                       # with Headroom only
ai -H codex
ai -H opencode

ai -H -R claude                    # Headroom + RTK
ai -H -R codex
ai -H -R opencode

ai -H -R claude -- --model sonnet  # pass agent flags after --
```

`ai --help` lists all options.

### Analytics & stats

```bash
headroom doctor              # health check
headroom perf                # performance metrics
headroom dashboard           # web dashboard (if available)
headroom stats               # CLI stats summary

rtk gain                     # token savings report
rtk gain --graph             # ASCII chart
rtk gain --history           # historical trend
rtk gain --daily             # per-day breakdown
rtk gain --all --format json # machine-readable export
```

## Updating

```bash
cd ~/.dotfiles
git pull
./mac/setup.sh
```
