#!/bin/bash

# Function to gather installed applications
gather_apps() {
    echo "Gathering installed applications..."
    # Get apps from /Applications
    system_apps=$(ls -1 /Applications | sed 's/.app//g')
    # Get apps from user Applications folder
    user_apps=$(ls -1 ~/Applications 2>/dev/null | sed 's/.app//g')
}

# Function to check if Installomator is installed
check_installomator() {
    if [ ! -f "/usr/local/Installomator/Installomator.sh" ]; then
        echo "Installomator not found. Installing..."
        # Download and install Installomator
        curl -L https://github.com/Installomator/Installomator/raw/main/Installomator.sh -o /tmp/Installomator.sh
        sudo mkdir -p /usr/local/Installomator/
        sudo mv /tmp/Installomator.sh /usr/local/Installomator/
        sudo chmod +x /usr/local/Installomator/Installomator.sh
    fi
}

# Function to update applications using Installomator
update_apps() {
    echo "Checking for updates..."
    INSTALLOMATOR="/usr/local/Installomator/Installomator.sh"
    
    # List of common apps supported by Installomator
    SUPPORTED_APPS=(
        "firefox"
        "chrome"
        "vlc"
        "zoom"
        "slack"
        "vscode"
        "brave"
        "dropbox"
    )

    for app in "${SUPPORTED_APPS[@]}"; do
        if echo "$system_apps $user_apps" | grep -q "$app"; then
            echo "Updating $app..."
            sudo "$INSTALLOMATOR" "$app" NOTIFY=all
        fi
    done
}

# Main execution
main() {
    # Check for root privileges
    if [ "$EUID" -ne 0 ]; then
        echo "Please run this script with sudo"
        exit 1
    fi

    check_installomator
    gather_apps
    update_apps
}

main