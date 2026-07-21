#!/bin/bash
# Tmux notification tester
set -e

echo "== Tmux Notification Test =="
echo ""

if [ -z "$TMUX" ]; then
    echo "Not running inside tmux. Run this from a tmux pane."
    exit 1
fi

WINDOW=$(tmux display-message -p '#I:#W')

echo "1. Ringing bell (should trigger 'Tmux Bell' notification)..."
sleep 0.5
printf '\a'
sleep 1

echo "2. Sending direct macOS notification..."
osascript -e "display notification \"Test from window $WINDOW\" with title \"Tmux Notification Test\""
sleep 0.5

echo ""
echo "Done. If both notifications appeared, everything works."
echo ""
echo "If nothing appeared, check:"
echo "  - Ghostty: Settings > Terminal > Notifications > enable Bell"
echo "  - macOS: System Settings > Notifications > Ghostty > Allow Notifications"
echo "  - Notification Centre (three-finger swipe left on trackpad)"
echo ""
echo "To see pending bell indicators on tmux tabs, make sure"
echo "window-status-bell-style is set in .tmux.conf"
