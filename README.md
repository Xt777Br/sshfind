# Sshfind

This script is designed to find SSH servers running on a local network using ARP scans and then connect to them via SSH. It is highly configurable and provides options for scanning different network subnets, using different network interfaces, and retrying failed connections. The script also includes the ability to update itself to the latest version and display a user-friendly terminal-based menu for connecting to discovered SSH servers.

## Features

- **Scan local networks**: Automatically scans the local network or a specific subnet for live devices.
- **SSH Connection**: Automatically checks for SSH servers and attempts connections.
- **Network Interface Options**: Allows specification of a custom network interface.
- **Timeout and Retry Options**: Provides configurable connection timeouts and retry attempts for both ARP scans and SSH connections.
- **Interactive Menu**: Displays an interactive menu for choosing and connecting to available SSH servers.
- **Self-update**: The script can update itself to the latest version from a GitHub repository.
- **Customizable Watch Options**: Continuous monitoring mode with configurable retries and intervals.

## Requirements

- `arp-scan`: Used for performing ARP scans.
- `nc` (Netcat): Used for checking whether a specific port is open on an IP.
- `ssh`: Used for making SSH connections.
- A Unix-based system (Linux/Mac).

## Installation

Using **curl**:
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Xt777Br/sshfind/main/install.sh)
```

Using **wget**:
```bash
bash <(wget -qO- https://raw.githubusercontent.com/Xt777Br/sshfind/main/install.sh)
```

## Uninstallation

```bash
sshfind --uninstall
```

## Usage

You can run the script with different options. The script accepts both short and long options.

### Basic Usage

```bash
sshfind [OPTIONS]
```

### Options

| Option                  | Description                                                                 |
|-------------------------|-----------------------------------------------------------------------------|
| `-p, --port PORT`        | Target SSH port (default: 22)                                                |
| `-u, --user USERNAME`    | SSH username for connections                                                |
| `-i, --interface IFACE`  | Network interface to use (e.g., `eth0`)                                     |
| `-t, --timeout SECONDS`  | Port check timeout (default: 3 seconds)                                      |
| `-r, --retries NUM`      | ARP scan retry attempts (default: 1)                                         |
| `-s, --subnet SUBNET`    | Target subnet to scan (e.g., `192.168.1.0/24`)                              |
| `--ssh-timeout SECONDS`  | SSH connection timeout (default: 5 seconds)                                 |
| `-v, --verbose`          | Enable verbose SSH output for debugging                                     |
| `-h, --help`             | Show help message                                                            |
| `--watch`                | Watch mode: Continuously scan for SSH servers (default: off)                |
| `--watch-interval SECS`  | Set the interval between repeated scans (default: 10 seconds)               |
| `--watch-retries NUM`    | Number of retries for the `--watch` mode (default: 1)                       |
| `--update`               | Update the script to the latest version from GitHub                         |
| `--uninstall`               | Uninstall the script                                                      |
| `--keep-menu`            | Keep the SSH connection menu visible after disconnection (default: off)     |

### Examples

1. **Scan the default subnet (local network):**

   ```bash
   sshfind
   ```

2. **Scan a specific subnet for SSH servers on port 2222:**

   ```bash
   sshfind -s 192.168.1.0/24 -p 2222
   ```

3. **Verbose scan with SSH username "admin" and retries set to 3:**

   ```bash
   sshfind -v -u admin -r 3
   ```

4. **Continuous watch mode with a 5-second interval:**

   ```bash
   sshfind --watch --watch-interval 5
   ```

5. **Update the script to the latest version:**

   ```bash
   sshfind --update
   ```

## Functionality

### Scanning for Devices

The script uses the `arp-scan` tool to perform ARP scans on the local network (or a specified subnet). This tool helps identify devices by their IP addresses.

### SSH Connection

After the ARP scan, the script checks each discovered device to see if an SSH service is running on the specified port (default: port 22). If SSH is found, it attempts to connect and provides the option to log in using a specified username.

### Interactive Menu

If multiple SSH servers are found, an interactive menu is displayed where users can navigate through the found servers using the arrow keys, select one to connect to, or exit with `Ctrl+C`.

```bash
$ sshfind
Select an SSH server:<br>
192.168.4.18
192.168.4.9

(Use ↑ ↓ to navigate, Enter to connect, Ctrl+C to quit)
```


### Watch Mode

If the `--watch` option is enabled, the script continuously monitors the network for SSH servers, retrying if no servers are found. You can configure the retry interval and number of retries with the `--watch-interval` and `--watch-retries` options.
```
$ sshfind --watch --watch-interval 15
⠴ Trying in 10 Seconds...
```

## Troubleshooting

- **"Command not found" error**: Ensure that `arp-scan` and `nc` are installed on your system. You can install them using:
  ```bash
  sudo apt-get install arp-scan netcat
  ```

- **SSH connection issues**: Ensure that the SSH servers you are scanning for are accessible and that you have the necessary credentials.

## Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements or bug fixes.

## License

This script is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
