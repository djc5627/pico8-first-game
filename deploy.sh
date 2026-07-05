#!/bin/bash

# --- CONFIGURATION ---
USER="onion"
HOST="192.168.1.180"
PORT="22"                                # Default SFTP port is 22
LOCAL_FILE="./firstgame.p8.png"     # File on your local machine
REMOTE_DIR="/mnt/SDCARD/Roms/PICO/mine"      # Target folder on the SFTP server

# --- EXECUTION ---
echo "Starting SFTP transfer..."

# Run SFTP in batch mode (-b) using standard input redirection (<<EOF)
sftp -P "$PORT" "$USER@$HOST" <<EOF
  cd "$REMOTE_DIR"
  put "$LOCAL_FILE"
  bye
EOF

# Check exit status of the SFTP command
if [ $? -eq 0 ]; then
    echo "File transferred successfully!"
else
    echo "SFTP transfer failed."
    exit 1
fi