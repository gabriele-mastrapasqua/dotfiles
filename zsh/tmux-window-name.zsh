if [ -n "$TMUX" ]; then
  chpwd() {
    tmux rename-window "${PWD##*/}"
  }
  precmd() {
    tmux rename-window "${PWD##*/}"
  }
fi
