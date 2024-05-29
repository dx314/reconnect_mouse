#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR=$(pwd)

# Path to the reconnect script
RECONNECT_SCRIPT="$SCRIPT_DIR/reconnect_mouse.sh"

while read line
do
    case "$line" in
        *"{'LockedHint': <false>}"*) bash "$RECONNECT_SCRIPT";;
    esac
done < <(gdbus monitor -y -d org.freedesktop.login1)
