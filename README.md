# Reconnect Bluetooth Mouse Service

This repository provides scripts to automatically reconnect a Bluetooth mouse upon unlocking your computer. It includes installation, uninstallation, and monitoring scripts using `systemd` for service management.

## Files

- `reconnect_mouse.sh`: Script to attempt to reconnect the Bluetooth mouse.
- `listen_unlock.sh`: Script to listen for unlock events and trigger the reconnect script.
- `install.sh`: Script to install the service.
- `uninstall.sh`: Script to uninstall the service.
- `find_mousies.sh`: List your Bluetooth mouse devices.

## Finding Your Known Bluetooth Mice

To find Bluetooth mice that have been previously connected to your computer and are known by your system, you can use the `find_mousies.sh` script. This script will list all paired Bluetooth devices and filter for mice.

### How to Use the Script

1. **Ensure the Script Exists**: Make sure you have the script saved as `find_mousies.sh`.

2. **Make the Script Executable**:
   '''
   chmod +x find_mousies.sh
   '''

3. **Run the Script**:
   '''
   sudo ./find_mousies.sh
   '''

## Setting the Device

If you need to change the Bluetooth device, you can modify the `DEVICE_NAME` variable in the `reconnect_mouse.sh` script.

## Installation

1. **Clone the Repository and install the script to systemd**:

   ```sh
   git clone https://github.com/yourusername/reconnect-bluetooth-mouse.git
   cd reconnect-bluetooth-mouse
   sudo ./install.sh
   ```

   This script will create and enable a systemd service that listens for unlock events and attempts to reconnect your Bluetooth mouse.

## Uninstallation

1. **Run the Uninstall Script with Root Permissions**:

   ```sh
   sudo ./uninstall.sh
   ```

   This script will stop and disable the systemd service, and remove the service file.

## Systemd Service Configuration

The systemd service is named `reconnect_bluetooth_mouse` and is configured to restart automatically if it fails. It runs the `listen_unlock.sh` script on system startup.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to submit issues or pull requests. All contributions welcome.

## Acknowledgements

This project is inspired by my PC not reconnecting my Bluetooth mouse upon wake / unlock in Fedora 40.

NOTE: This was hurriedly made for Fedora 40 and barely tested. Use at your own risk.

---

**Note**: Replace `/path/to/` with the actual path where your scripts are located.

---

**Contact**: If you have any questions or need further assistance, please open an issue.
