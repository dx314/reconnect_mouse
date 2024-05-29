# Reconnect Bluetooth Mouse Service

This repository provides scripts to automatically reconnect a Bluetooth mouse upon unlocking your computer. It includes installation, uninstallation, and monitoring scripts using `systemd` for service management.

## Files

- `reconnect_mouse.sh`: Script to attempt to reconnect the Bluetooth mouse.
- `listen_unlock.sh`: Script to listen for unlock events and trigger the reconnect script.
- `install.sh`: Script to install the service.
- `uninstall.sh`: Script to uninstall the service.

## Setting the Device

If you need to change the Bluetooth device, you can modify the `DEVICE_NAME` variable in the `reconnect_mouse.sh` script.

1. Open the `reconnect_mouse.sh` script in a text editor:

   ```sh
   nano reconnect_mouse.sh
   ```

2. Locate the following line:

   ```sh
   DEVICE_NAME="MM731 Hybrid Mouse"
   ```

3. Change the value of `DEVICE_NAME` to match your Bluetooth mouse's name. For example:

   ```sh
   DEVICE_NAME="Your Bluetooth Mouse Name"
   ```

4. Save the file and exit the editor.

## Installation

1. **Clone the Repository**:

   ```sh
   git clone https://github.com/yourusername/reconnect-bluetooth-mouse.git
   cd reconnect-bluetooth-mouse
   ```

2. **Run the Install Script**:

   ```sh
   sudo ./install.sh
   ```

   This script will create and enable a systemd service that listens for unlock events and attempts to reconnect your Bluetooth mouse.

## Uninstallation

1. **Run the Uninstall Script with Root Permissions**:

   ```sh
   sudo ./uninstall.sh
   ```

   This script will stop and disable the systemd service, and remove the service file.

## Usage

### `reconnect_mouse.sh`

This script handles the logic for reconnecting the Bluetooth mouse. It continuously checks if the mouse is connected and attempts to reconnect it if it is not.

### `listen_unlock.sh`

This script listens for unlock events using `gdbus` and triggers the `reconnect_mouse.sh` script when an unlock event is detected.

### `install.sh`

This script installs the systemd service to run `listen_unlock.sh` on system startup and manages the service lifecycle.

### `uninstall.sh`

This script removes the systemd service installed by `install.sh`.

## Systemd Service Configuration

The systemd service is named `reconnect_bluetooth_mouse` and is configured to restart automatically if it fails. It runs the `listen_unlock.sh` script on system startup.

### Example systemd Service File

```ini
[Unit]
Description=Reconnect Bluetooth Mouse Service
After=bluetooth.target

[Service]
ExecStart=/path/to/listen_unlock.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to submit issues or pull requests. Contributions are welcome!

## Acknowledgements

This project is inspired by my PC not reconnecting my Bluetooth mouse upon wake / unlock.

## Note

This was hurriedly made for Fedora 40 and barely tested. Use at your own risk.

---

**Note**: Replace `/path/to/` with the actual path where your scripts are located.

---

**Contact**: If you have any questions or need further assistance, please open an issue.
