#!/bin/bash
# A script that simulates CPU work — useful for seeing processes in top/htop.
# Runs for 30 seconds then exits on its own.

echo "CPU eater started (PID: $$) — will run for 30 seconds."

end_time=$((SECONDS + 30))
while [ $SECONDS -lt $end_time ]; do
    : # Do nothing (but do it fast)
done

echo "CPU eater finished."
