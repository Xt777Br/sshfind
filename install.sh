#!/bin/bash

# Set the URL of the script
URL="https://raw.githubusercontent.com/Xt777Br/sshfind/main/sshfind"

# Ask the user for installation type
echo "Choose installation type:"
echo "1) Install globally (/usr/local/bin/) (requires sudo)"
echo "2) Install for current user (~/.local/bin/)"
read -p "Enter choice (1 or 2): " choice

if [[ "$choice" == "1" ]]; then
    DEST="/usr/local/bin/sshfind"
    echo "Installing globally... (requires sudo)"
    sudo curl -o "$DEST" "$URL" && sudo chmod +x "$DEST"
elif [[ "$choice" == "2" ]]; then
    DEST="$HOME/.local/bin/sshfind"
    mkdir -p "$HOME/.local/bin"
    curl -o "$DEST" "$URL" && chmod +x "$DEST"
    echo "Adding ~/.local/bin to PATH if not already added..."
    if ! grep -q "export PATH=\$HOME/.local/bin:\$PATH" "$HOME/.bashrc"; then
        echo "export PATH=\$HOME/.local/bin:\$PATH" >> "$HOME/.bashrc"
    fi
    echo "Installation complete. Restart your terminal or run 'source ~/.bashrc' to use sshfind."
else
    echo "Invalid choice. Exiting."
    exit 1
fi

if command -v arp-scan &> /dev/null; then
    sudo setcap cap_net_raw+ep "$(which arp-scan)"
else
    echo "arp-scan not found. Please install it to use sshfind."
    exit 1
fi

echo "Installation complete. You can now run 'sshfind'."
