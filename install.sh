#!/bin/bash

# Check if the script is being run with root permissions
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with root permissions. Please run it with sudo or as root."
  exit 1
fi

# Set the script name and path
SCRIPT_NAME="reconnect_mouse"
SCRIPT_PATH="$(pwd)/$SCRIPT_NAME.sh"

# Set the systemd service file path
SERVICE_FILE="/etc/systemd/system/$SCRIPT_NAME.service"

# Create the systemd service file
cat > "$SERVICE_FILE" <<EOL
[Unit]
Description=Reconnect Mouse Service
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
systemctl enable "$SCRIPT_NAME.service"

# Start the service
systemctl start "$SCRIPT_NAME.service"

echo "Installation complete. The $SCRIPT_NAME service has been installed and started."

systemctl status reconnect_mouse.service