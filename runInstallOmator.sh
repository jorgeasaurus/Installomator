#!/bin/bash

# Simulate running all scripts in order for Installomator with SwiftDialog integration

# Define variables
DIALOG_CMD_FILE="/var/tmp/dialog.log"
DIALOG_TITLE="Installing Google Chrome..."
DIALOG_ICON="/Users/jorgeasaurus/Library/CloudStorage/OneDrive-Personal/Repos/Installomator/MDM/Jamf/chrome.png"  # Replace with actual icon URL
DIALOG_OVERLAY="/Users/jorgeasaurus/Library/CloudStorage/OneDrive-Personal/Repos/Installomator/MDM/Jamf/company.png"  # Replace with actual overlay URL
INSTALLOMATOR_LABEL="googlechromepkg"
NOTIFY="all"
DO_RECON=0

echo "Starting installation simulation..."

# Install SwiftDialog and set icon
echo "Installing SwiftDialog..."
/bin/bash "/Users/jorgeasaurus/Library/CloudStorage/OneDrive-Personal/Repos/Installomator/MDM/Jamf/-0_Install swiftDialog direct.sh" "$DIALOG_ICON" "0"

# Install SwiftDialog icon
echo "Installing SwiftDialog icon..."
/bin/bash "/Users/jorgeasaurus/Library/CloudStorage/OneDrive-Personal/Repos/Installomator/MDM/Jamf/-0_Install icon for swiftDialog.sh" "$DIALOG_ICON" "0"

# Prepare SwiftDialog
echo "Preparing SwiftDialog..."
/bin/bash "/Users/jorgeasaurus/Library/CloudStorage/OneDrive-Personal/Repos/Installomator/MDM/Jamf/00_Prepare_SwiftDialog.sh" "$DIALOG_CMD_FILE" "$DIALOG_TITLE" "$DIALOG_ICON" "$DIALOG_OVERLAY"

# Simulate Installomator.sh
echo "Running Installomator..."
echo "Using label: $INSTALLOMATOR_LABEL"
# Run Installomator with SwiftDialog integration
/bin/bash "/Users/jorgeasaurus/Library/CloudStorage/OneDrive-Personal/Repos/Installomator/Installomator.sh" "$INSTALLOMATOR_LABEL" "DIALOG_CMD_FILE=$DIALOG_CMD_FILE" "NOTIFY=$NOTIFY"
echo "Notification mode: $NOTIFY"

# Simulate download and installation progress
echo "progress: 0" > "$DIALOG_CMD_FILE"
sleep 1
echo "progress: 25" > "$DIALOG_CMD_FILE"
echo "status: Downloading Google Chrome..." > "$DIALOG_CMD_FILE"
sleep 1
echo "progress: 50" > "$DIALOG_CMD_FILE"
echo "status: Installing Google Chrome..." > "$DIALOG_CMD_FILE"
sleep 1
echo "progress: 75" > "$DIALOG_CMD_FILE"
sleep 1
echo "progress: 100" > "$DIALOG_CMD_FILE"

# Clean up with Quit SwiftDialog script
echo "Cleaning up..."
/bin/bash "/Users/jorgeasaurus/Library/CloudStorage/OneDrive-Personal/Repos/Installomator/MDM/Jamf/zz_Quit_SwiftDialog.sh" "$DIALOG_CMD_FILE" "$DO_RECON"

echo "Installation simulation complete!"