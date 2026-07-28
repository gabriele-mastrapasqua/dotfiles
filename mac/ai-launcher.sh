#!/usr/bin/env bash
set -Eeuo pipefail

VERSION="@VERSION@"

PROXY_PORT="${HEADROOM_PORT:-8787}"
HR_PID=""
CODEX_CONFIG="${CODEX_HOME:-$HOME/.codex}/config.toml"
CODEX_CONFIG_BACKUP=""

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

version() {
  echo "ai $VERSION"
}

cleanup() {
  local ec=$?

  # kill the proxy if we started it
  if [[ -n "$HR_PID" ]] && kill -0 "$HR_PID" 2>/dev/null; then
    kill "$HR_PID" 2>/dev/null || true
    wait "$HR_PID" 2>/dev/null || true
  fi

  # restore codex config if we backed it up
  if [[ -n "$CODEX_CONFIG_BACKUP" ]] && [[ -f "$CODEX_CONFIG_BACKUP" ]]; then
    cp "$CODEX_CONFIG_BACKUP" "$CODEX_CONFIG"
    rm -f "$CODEX_CONFIG_BACKUP"
  fi

  unset OPENAI_BASE_URL
  unset ANTHROPIC_BASE_URL
  unset HEADROOM_CONTEXT_TOOL

  exit "$ec"
}
trap cleanup EXIT INT TERM HUP

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
    --version|-V)
      version
      exit 0
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

# resolve the actual binary and extra args for variant agents
actual_bin="$agent"
extra_args=()
if [[ "$agent" == "codex-team" ]]; then
  actual_bin=codex
  extra_args=(--profile lean-team)
fi

if ((use_headroom)); then
  command -v headroom >/dev/null 2>&1 || {
    echo 'headroom: command not found' >&2
    exit 127
  }

  if ((use_rtk)); then
    command -v rtk >/dev/null 2>&1 || {
      echo 'rtk: command not found' >&2
      exit 127
    }
    export HEADROOM_CONTEXT_TOOL=rtk
  else
    export HEADROOM_CONTEXT_TOOL=none
  fi

  # start proxy in background
  headroom proxy --port "$PROXY_PORT" --mode token --target-ratio 0.4 --intercept-tool-results &
  HR_PID=$!

  # wait for proxy (up to 20s)
  for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
    sleep 1
    if ! kill -0 "$HR_PID" 2>/dev/null; then
      echo "headroom proxy crashed during startup (port $PROXY_PORT)" >&2
      exit 1
    fi
    if curl -sf "http://127.0.0.1:$PROXY_PORT/livez" >/dev/null 2>&1; then
      break
    fi
    if (( i == 20 )); then
      echo "headroom proxy not ready after 20s (port $PROXY_PORT)" >&2
      kill "$HR_PID" 2>/dev/null || true
      exit 1
    fi
  done

  # point the agent at the proxy
  export OPENAI_BASE_URL="http://127.0.0.1:$PROXY_PORT/v1"
  export ANTHROPIC_BASE_URL="http://127.0.0.1:$PROXY_PORT"

  # codex needs --config openai_base_url (env var is not enough)
  if [[ "$actual_bin" == "codex" ]]; then
    extra_args+=(--config "openai_base_url=http://127.0.0.1:$PROXY_PORT/v1")
  fi

  # --- TEMPORARY MCP registration for codex ---
  if [[ "$agent" == codex* ]] && [[ -f "$CODEX_CONFIG" ]]; then
    CODEX_CONFIG_BACKUP="$(mktemp)"
    cp "$CODEX_CONFIG" "$CODEX_CONFIG_BACKUP"

    # add headroom MCP server entries if not already present
    if ! grep -q 'headroom.*mcp.*serve' "$CODEX_CONFIG" 2>/dev/null; then
      cat >>"$CODEX_CONFIG" <<-EOM

# --- Headroom MCP (ai launcher) ---
[mcp_servers.headroom]
command = "$(command -v headroom)"
args = ["mcp", "serve"]
# --- end Headroom MCP ---
EOM
    fi
  fi

  # launch agent (no exec — cleanup needs to run after)
  "$actual_bin" "${extra_args[@]}" "$@"
  ec=$?
  exit "$ec"
fi

if ((use_rtk)); then
  echo "RTK without Headroom requires agent-side integration."
  echo "To keep it strictly opt-in use:"
  echo "  ai --headroom --rtk $agent"
  exit 2
fi

"$actual_bin" "${extra_args[@]}" "$@"
