#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  cat <<'EOF'
Usage:
  ai [--headroom] [--rtk] <agent> [agent arguments...]

Agents:
  claude
  codex / codex-team
  opencode
  pi

Examples:
  ai claude
  ai --headroom claude
  ai --rtk codex
  ai --headroom --rtk opencode
  ai codex-team
  ai --headroom --rtk claude -- --model sonnet
EOF
}

use_headroom=0
use_rtk=0

while (($#)); do
  case "$1" in
    --headroom|-H)
      use_headroom=1
      shift
      ;;
    --rtk|-R)
      use_rtk=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      printf 'Unknown launcher option: %s\n\n' "$1" >&2
      usage >&2
      exit 2
      ;;
    *)
      break
      ;;
  esac
done

(($# >= 1)) || {
  usage >&2
  exit 2
}

agent="$1"
shift

case "$agent" in
  claude|codex|codex-team|opencode|pi)
    ;;
  *)
    printf 'Unsupported agent: %s\n' "$agent" >&2
    exit 2
    ;;
esac

command -v "$agent" >/dev/null 2>&1 || {
  printf 'Command not found: %s\n' "$agent" >&2
  exit 127
}

if ((use_headroom)); then
  command -v headroom >/dev/null 2>&1 || {
    echo 'Headroom is not installed.' >&2
    exit 127
  }

  if ((use_rtk)); then
    command -v rtk >/dev/null 2>&1 || {
      echo 'RTK is not installed.' >&2
      exit 127
    }

    export HEADROOM_CONTEXT_TOOL=rtk
  else
    export HEADROOM_CONTEXT_TOOL=none
  fi

  exec headroom wrap "$agent" -- "$@"
fi

if ((use_rtk)); then
  echo "RTK without Headroom requires agent-side integration."
  echo "To keep it strictly opt-in use:"
  echo "  ai --headroom --rtk $agent"
  exit 2
fi

exec "$agent" "$@"
