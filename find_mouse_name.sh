#!/bin/bash

# Function to list known Bluetooth devices and filter for mice
list_known_mice() {
    echo "Known Bluetooth mice:"

    # List all paired devices and process each line
    bluetoothctl devices | while read -r line; do
        DEVICE_MAC=$(echo "$line" | awk '{print $2}')
        DEVICE_NAME=$(echo "$line" | cut -d ' ' -f 3-)

        # Get the device info and filter for mice
        if bluetoothctl info "$DEVICE_MAC" | grep -i "input-mouse" > /dev/null; then
            echo "Device: $DEVICE_NAME, MAC: $DEVICE_MAC"
        fi
    done
}

# Run the function
list_known_mice
