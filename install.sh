#!/bin/bash
# install.sh: Download and install the cpustop80 script from GitHub

# Define variables
SCRIPT_URL="https://raw.githubusercontent.com/QKing-Official/cpustop80/main/cpustop80"
INSTALL_DIR="/usr/local/bin/cpustop80"
SCRIPT_NAME="cpustop80"
SYSTEMD_SERVICE_NAME="cpustop80.service"

# Download the cpustop80 script using curl
echo "Downloading cpustop80 script from GitHub..."
curl -sSL "$SCRIPT_URL" -o "$INSTALL_DIR"

# Check if the script was downloaded successfully
if [ ! -f "$INSTALL_DIR" ]; then
    echo "Error: Failed to download the cpustop80 script."
    exit 1
fi

# Make the script executable
echo "Making the cpustop80 script executable..."
sudo chmod +x "$INSTALL_DIR"

# Optionally, create a systemd service to run the script at startup (if systemd is available)
if [ -d "/etc/systemd/system" ]; then
    echo "Creating systemd service..."
    # Create a systemd service file
    cat << EOF | sudo tee /etc/systemd/system/$SYSTEMD_SERVICE_NAME
[Unit]
Description=cpustop80 Script

[Service]
ExecStart=$INSTALL_DIR
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

    # Reload systemd daemon and enable the service to start on boot
    sudo systemctl daemon-reload
    sudo systemctl enable $SYSTEMD_SERVICE_NAME
    sudo systemctl start $SYSTEMD_SERVICE_NAME

    echo "Systemd service created and started."
else
    echo "Systemd not found. You can manually run the script with:"
    echo "sudo $INSTALL_DIR"
fi

echo "Installation complete. cpustop80 script is installed and ready."
