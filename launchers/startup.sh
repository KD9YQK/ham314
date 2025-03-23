#!/bin/bash

handle_signal() {
    exit 0
}
# Trap the shutdown signal, so the shutdown sequence can run.
trap handle_signal SIGTERM

# Initial setup
echo "Direwolf has not been started." > /tmp/direwolf.log
echo "Pat Email has not been started." > /tmp/pat.log
echo 'Unknown\nNoFix\nNoFix' > /tmp/loc.dat

# Loop until a shutdown is called.
while true
do
    sleep 30
    python3 gps.py > /tmp/loc.dat
done
