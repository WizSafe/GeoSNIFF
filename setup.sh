#!/bin/bash

# GeoSNIFF Setup Script

# Function to install required packages
install_packages() {
    echo -e "\e[1;34m[+] Updating package list...\e[0m"
    pkg update -y

    echo -e "\e[1;34m[+] Installing required packages...\e[0m"

    # Install curl and jq if not already installed
    pkg install curl jq -y

    # Verify installation
    if [[ $(command -v curl) && $(command -v jq) ]]; then
        echo -e "\e[1;32m[+] All required packages are installed successfully.\e[0m"
    else
        echo -e "\e[1;31m[-] Package installation failed. Please try again.\e[0m"
        exit 1
    fi
}

# Function to set execution permissions for the GeoSNIFF tool
set_permissions() {
    echo -e "\e[1;34m[+] Setting execution permissions for GeoSNIFF tool...\e[0m"

    # Make the main script executable
    chmod +x geosniff.sh

    # Verify if the script is executable
    if [[ -x "geosniff.sh" ]]; then
        echo -e "\e[1;32m[+] GeoSNIFF tool is now executable.\e[0m"
    else
        echo -e "\e[1;31m[-] Failed to set execution permissions. Please try again.\e[0m"
        exit 1
    fi
}

# Main function
main() {
    install_packages
    set_permissions
    echo -e "\e[1;34m[+] Setup complete. You can now run the tool using './geosniff.sh'.\e[0m"
}

# Run the main function
main
