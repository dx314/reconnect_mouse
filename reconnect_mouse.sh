#!/bin/bash

DEVICE_NAME="MM731 Hybrid Mouse"
RECONNECT_INTERVAL=10

function get_device_mac() {
    bluetoothctl devices | grep "$DEVICE_NAME" | awk '{print $2}'
}

function is_device_connected() {
    bluetoothctl info "$1" | grep -q "Connected: yes"
}

function reconnect_device() {
    echo "Attempting to reconnect to $DEVICE_NAME ($1)..."
    bluetoothctl connect "$1"
}

function main() {
    echo "Starting Bluetooth reconnect script..."
    DEVICE_MAC=$(get_device_mac)

    if [ -z "$DEVICE_MAC" ]; then
        echo "Device $DEVICE_NAME not found. Exiting."
        exit 1
    else
        echo "Device $DEVICE_NAME found with MAC address $DEVICE_MAC."
    fi

    while true; do
        if ! is_device_connected "$DEVICE_MAC"; then
            echo "$DEVICE_NAME is not connected. Trying to reconnect..."
            reconnect_device "$DEVICE_MAC"
            echo "Waiting for 5 seconds to allow reconnection..."
            sleep 5 # Give it some time to reconnect
        else
            echo "$DEVICE_NAME is now connected. Exiting script."
            return 0
        fi
    done
}

main
