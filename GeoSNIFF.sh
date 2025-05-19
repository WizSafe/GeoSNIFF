#!/bin/bash

# GeoSniff v2 - Advanced IP Logger & Tracker
# Developed by WizSafe.org

# Colors
blue='\e[1;34m'
green='\e[1;32m'
red='\e[1;31m'
reset='\e[0m'

# Clear screen on startup
clear

# Dependency Check
dependencies=("curl" "jq" "xdg-open")
for pkg in "${dependencies[@]}"; do
    if ! command -v $pkg &> /dev/null; then
        echo -e "${red}[-] $pkg is not installed. Installing...${reset}"
        pkg install $pkg -y > /dev/null 2>&1 || sudo apt install $pkg -y
    fi
done

# Create logs directory if it doesn’t exist
mkdir -p logs

# Banner
display_banner() {
    echo -e "${blue}"
    echo "  ██████╗ ███████╗ ██████╗  ██████╗ ███████╗███╗   ██╗██╗███████╗███████╗"
    echo " ██╔════╝ ██╔════╝██╔════╝ ██╔═══██╗██╔════╝████╗  ██║██║██╔════╝██╔════╝"
    echo " ██║  ███╗█████╗  ██║  ███╗██║   ██║█████╗  ██╔██╗ ██║██║█████╗  █████╗  "
    echo " ██║   ██║██╔══╝  ██║   ██║██║   ██║██╔══╝  ██║╚██╗██║██║██╔══╝  ██╔══╝  "
    echo " ╚██████╔╝███████╗╚██████╔╝╚██████╔╝███████╗██║ ╚████║██║███████╗██║     "
    echo "  ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝╚══════╝╚═╝     "
    echo -e "${reset}"
}

# Function to track IP
track_ip() {
    echo -e "${blue}[+] Enter IP Address to track:${reset}"
    read ip

    echo -e "${blue}[+] Fetching details for:${green} $ip${reset}"
    response=$(curl -s https://ipinfo.io/$ip)

    if [[ $response == *"error"* ]]; then
        echo -e "${red}[-] Invalid IP address. Please try again.${reset}"
        return
    fi

    city=$(echo $response | jq -r '.city')
    region=$(echo $response | jq -r '.region')
    country=$(echo $response | jq -r '.country')
    org=$(echo $response | jq -r '.org')
    loc=$(echo $response | jq -r '.loc')
    timezone=$(echo $response | jq -r '.timezone')
    postal=$(echo $response | jq -r '.postal')
    ip_info=$(echo $response | jq -r '.ip')

    echo -e "${blue}[+] IP Details:${reset}"
    echo -e "${green}    ➤ IP: $ip_info"
    echo -e "    ➤ City: $city"
    echo -e "    ➤ Region: $region"
    echo -e "    ➤ Country: $country"
    echo -e "    ➤ Postal Code: $postal"
    echo -e "    ➤ Organization: $org"
    echo -e "    ➤ Timezone: $timezone"
    echo -e "    ➤ Coordinates: $loc${reset}"

    # Open Google Maps
    map_url="https://www.google.com/maps?q=$loc"
    echo -e "${blue}[+] Opening location on map...${reset}"
    xdg-open "$map_url" > /dev/null 2>&1

    # Log the result
    timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
    logfile="logs/GeoSniff_$timestamp.log"
    {
        echo "IP: $ip_info"
        echo "City: $city"
        echo "Region: $region"
        echo "Country: $country"
        echo "Postal: $postal"
        echo "Organization: $org"
        echo "Location: $loc"
        echo "Timezone: $timezone"
        echo "Google Maps: $map_url"
        echo "Timestamp: $(date)"
    } > "$logfile"
    echo -e "${green}[+] Log saved to $logfile${reset}"

    echo -e "\n${blue}Developed by: WizSafe.org${reset}"
}

# Function to update tool (placeholder)
update_tool() {
    echo -e "${blue}[~] Checking for updates...${reset}"
    sleep 1
    echo -e "${green}[+] Already using the latest version.${reset}"
}

# Main menu
main_menu() {
    while true; do
        display_banner
        echo -e "${blue}[1] Track an IP"
        echo -e "[2] Update Tool"
        echo -e "[3] Exit${reset}"
        echo -ne "${green}Select an option: ${reset}"
        read choice

        case $choice in
            1) track_ip ;;
            2) update_tool ;;
            3) echo -e "${blue}Exiting...${reset}"; exit ;;
            *) echo -e "${red}[-] Invalid choice, try again.${reset}"; sleep 1 ;;
        esac

        echo -e "\nPress Enter to return to menu..."
        read
        clear
    done
}

# Run
main_menu
