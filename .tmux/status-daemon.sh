#!/bin/bash
set -euo pipefail

PIDFILE="${TMPDIR:-/tmp}/tmux_status_daemon.pid"
TMPFILE="${TMPDIR:-/tmp}/tmux_status"
SLEEP=3
NCORES=$(sysctl -n hw.ncpu)
MEM_TOTAL=$(sysctl -n hw.memsize)

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
	exit 0
fi
echo $$ > "$PIDFILE"
trap 'rm -f "$PIDFILE"' EXIT

prev=$(ps -A -o cputime= 2>/dev/null | awk -F: '
{
	s = $NF + 60*$(NF-1)
	if (NF >= 3) s += 3600*$(NF-2)
	total += s
}
END {printf "%.6f", total}')

while true; do
	sleep "$SLEEP"

	cur=$(ps -A -o cputime= 2>/dev/null | awk -F: '
	{
		s = $NF + 60*$(NF-1)
		if (NF >= 3) s += 3600*$(NF-2)
		total += s
	}
	END {printf "%.6f", total}')
	delta=$(awk -v c="$cur" -v p="$prev" 'BEGIN {printf "%.6f", c - p}')
	cpu=$(awk -v d="$delta" -v s="$SLEEP" -v n="$NCORES" 'BEGIN {r = d / s / n * 100; printf "%.0f", r}')
	prev="$cur"

	gpu=$(ioreg -rc "IOAccelerator" -l 2>/dev/null | grep -o 'Device Utilization %"=[0-9]*' | grep -o '[0-9]*$' || echo "?")

	ram=$(memory_pressure | grep 'System-wide memory free percentage' | grep -o '[0-9]*' || echo "?")

	used=$(df / | awk 'NR==2{gsub(/[^0-9]/, "", $5); print $5}')
	dsk=$((100 - used))

	printf "CPU %s%%  GPU %s%%  RAM %s%%  DSK %s%%" "$cpu" "$gpu" "$ram" "$dsk" > "$TMPFILE"
done
