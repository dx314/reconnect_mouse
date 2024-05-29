#!/bin/bash

# Check if the script is being run with root permissions
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with root permissions. Please run it with sudo or as root."
  exit 1
fi

# Set the script name and path
SCRIPT_NAME="listen_unlock"
SCRIPT_PATH="$(pwd)/$SCRIPT_NAME.sh"

# Set the systemd service file path
SERVICE_FILE="/etc/systemd/system/reconnect_bluetooth_mouse.service"

# Stop and disable the existing service if it exists
if systemctl list-unit-files | grep -q "reconnect_bluetooth_mouse.service"; then
  systemctl stop reconnect_bluetooth_mouse.service
  systemctl disable reconnect_bluetooth_mouse.service
fi

# Create the systemd service file
cat > "$SERVICE_FILE" <<EOL
[Unit]
Description=Reconnect Bluetooth Mouse Service
After=bluetooth.target

[Service]
ExecStart=$SCRIPT_PATH
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOL

# Make the script executable
chmod +x "$SCRIPT_PATH"

# Reload systemd daemon
systemctl daemon-reload

# Enable the service to start on boot
systemctl enable reconnect_bluetooth_mouse.service

# Start the service
systemctl start reconnect_bluetooth_mouse.service

echo "Installation complete. The Reconnect Bluetooth Mouse service has been installed and started."

# Display the status of the service
systemctl status reconnect_bluetooth_mouse.service
