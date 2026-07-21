# dotfiles

La mia configurazione essenziale per macOS Apple Silicon: terminale, tmux,
Neovim e qualche automazione utile per lavorare senza perdere il contesto.

## ✨ Features

- **Ghostty** avvia automaticamente una sessione tmux persistente chiamata `main`.
- **tmux-resurrect + tmux-continuum** salvano la sessione ogni 5 minuti e la
  ripristinano al riavvio.
- Finestre tmux nominate automaticamente con la cartella corrente.
- Status bar in alto con utilizzo di **CPU, GPU, RAM e disco**, aggiornata ogni
  3 secondi.
- Notifiche macOS quando un comando emette un bell o dura più di 10 secondi.
- Configurazione Neovim minimale: numeri di riga, ricerca incrementale, split
  intuitivi, indentazione a 4 spazi e wrapping per Markdown.
- Mouse tmux abilitato e supporto True Color.

## 🚀 Installazione

> Pensato per macOS con Homebrew in `/opt/homebrew`.

```bash
git clone https://github.com/gabriele-mastrapasqua/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./mac/setup.sh
```

Lo script installa Homebrew se necessario, installa tool e app, crea i symlink
per le configurazioni, installa i plugin tmux e aggiunge gli hook a `~/.zshrc`.

Alla fine, chiudi e riapri Ghostty.

## 📦 Cosa installa

**CLI**

`wget` · `tree` · `neovim` · `grep` · `openssh` · `git` · `git-lfs` ·
`the_silver_searcher` · `tmux`

**App**

`Ghostty` · `Zed`

In più vengono configurati gli alias `vim` e `vi` per usare `nvim`.

## ⌨️ tmux keybinds

Il prefix tmux resta quello di default: **`Ctrl+b`**.

### Finestre

| Shortcut | Azione |
| --- | --- |
| `Cmd+t` | Nuova finestra nella cartella corrente |
| `Ctrl+t` | Nuova finestra nella cartella corrente |
| `Cmd+w` | Chiude la finestra corrente |
| `Ctrl+Tab` | Finestra successiva |
| `Ctrl+Shift+Tab` | Finestra precedente |
| `Alt+←` / `Alt+→` | Finestra precedente / successiva |
| `Alt+1` … `Alt+9` | Vai alla finestra indicata |

### Sessione

| Shortcut | Azione |
| --- | --- |
| `Ctrl+b c` | Nuova finestra |
| `Ctrl+b Ctrl+s` | Salva la sessione subito |
| `Ctrl+b Ctrl+r` | Ripristina la sessione |
| `Ctrl+b d` | Scollega la sessione |
| `Ctrl+b ?` | Mostra tutti i keybind |

## 🔔 Notifiche

Per provare le notifiche direttamente da una finestra tmux:

```bash
~/.tmux/notify-test.sh
```

Se non compare nulla, abilita le notifiche per Ghostty in **Impostazioni di
Sistema → Notifiche**.

## 📁 Struttura

```text
ghostty/   configurazione Ghostty
mac/       script di installazione e pacchetti Homebrew
nvim/      configurazione Neovim
zsh/       hook per nomi finestre e notifiche dei comandi lunghi
.tmux.conf configurazione tmux
```

## 🔄 Aggiornare

```bash
cd ~/.dotfiles
git pull
./mac/setup.sh
```
