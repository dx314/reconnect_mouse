#!/bin/bash

# Check if the script is being run with root permissions
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with root permissions. Please run it with sudo or as root."
  exit 1
fi

SERVICE_NAME="reconnect_bluetooth_mouse"

# Function to uninstall a service
uninstall_service() {
  SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

  # Stop the service if it exists
  if systemctl list-unit-files | grep -q "$SERVICE_NAME.service"; then
    echo "Stopping and disabling the service: $SERVICE_NAME"
    sudo systemctl stop "$SERVICE_NAME.service"
    sudo systemctl disable "$SERVICE_NAME.service"
    sudo rm "$SERVICE_FILE"
    sudo systemctl daemon-reload
    echo "Service $SERVICE_NAME has been removed."
  else
    echo "Service $SERVICE_NAME does not exist."
  fi
}

# Uninstall the service
uninstall_service
# Uninstall the new listen_unlock service (optional, uncomment if needed)
# uninstall_service "reconnect_bluetooth_mouse"

echo "Uninstallation complete."
