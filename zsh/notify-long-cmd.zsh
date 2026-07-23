if [ -n "$TMUX" ]; then
  zmodload zsh/datetime 2>/dev/null

  preexec() {
    cmd_start=$EPOCHSECONDS
    cmd_text=$1
  }

  precmd() {
    local exit_code=$?
    if [ -n "${cmd_start-}" ]; then
      local elapsed=$(( EPOCHSECONDS - cmd_start ))
      if [ "$elapsed" -gt 10 ]; then
        local elapsed_min=$(( elapsed / 60 ))
        local elapsed_sec=$(( elapsed % 60 ))
        printf '\a'
        tmux display-message "done ${elapsed_min}m${elapsed_sec}s (exit ${exit_code})"
        osascript -e "tell application \"Ghostty\" to display notification \"#$(tmux display-message -p '#I'): ${cmd_text} done (${elapsed_min}m${elapsed_sec}s)\" with title \"Tmux\" sound name \"default\"" 2>/dev/null &
      fi
      unset cmd_start cmd_text
    fi
  }
fi
