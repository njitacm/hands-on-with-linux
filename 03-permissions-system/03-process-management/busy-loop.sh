#!/bin/bash
# A simple script that runs in a loop — useful for practicing process management.
# It prints a message every 3 seconds until you stop it.

echo "Busy loop started (PID: $$)"
echo "Press Ctrl+C to stop, or use 'kill $$' from another terminal."

count=0
while true; do
    count=$((count + 1))
    echo "[$(date +%H:%M:%S)] Still running... (iteration $count)"
    sleep 3
done
