#!/bin/bash

# GeoSniff - IP Address Tracking Tool

# Clear the screen for full-screen view
clear

# Function to display banner
display_banner() {
echo -e "\e[34m" # Set text color to blue
echo "                                                                                          "
echo "                                                                                          "
echo "                                                                                          "
echo "                                                                                          "
echo "                                     ..::::::::::..                                        "
echo "                               ..::--------::.....:::::-::.                                "
echo "                            .    --------:.-:..     ::---:. ...                           "
echo "                         ..      ..:: .=:-.::-==-:   :=--=--..::.                         "
echo "                      ...::.     .    ...::+=..:++-: :=======---....                      "
echo "                     ..::::      :.    :====--:=++=+=-=+======:::..:::                    "
echo "                   ...::::       .....:===++-..:.:=+++++===-=====-:.:--:                  "
echo "                  ...::::.       ........:==:.......:++++==--:--===. --::                 "
echo "                ....::::.          .:......-.....--==:-=+==---:::---..=.                  "
echo "               ...:::::          ....::--....:::-:-==++++++----:::::--..                  "
echo "               .....:.     ..     .....-:--::::.:==+*+++++++=---:::::::.                  "
echo "              .......       ...........-..-::::-+******+++++++=-:::::::..                 "
echo "             ........     ..... ..........:::-++*********++++++=-::::::.                  "
echo "             .........     ..................=*++****++**++++++++-:::::.                  "
echo "            ................    ...........-+++*+**+++++++*+++++++-:::::.                 "
echo "            ...........:   .......:..::...=+++++=++*********+++++++-:--=-..  .            "
echo "            .........:.::   . ..==+==++++::++++**+***********++++++======:. ...           "
echo "            ...........--:  ...===+=++++++-+=++**+************++++++=++===:....           "
echo "            ...........---.....===+=+=++===-=++++++**********++++++++++====-::.           "
echo "            ...........----. ..:===-..-++++++==+=--+++*++++++**+++++++=====--:            "
echo "            ..:::.:::..------::.::...:+++++++=+++++++++********+++++++====---:            "
echo "             .::::::::-----========--:---=+++++***+******+***+++++++++===-=--             "
echo "              .:::::::-------======-===:.-+++++++==-====--=+*++++++======-=-:             "
echo "              .:::::::--------=====-=====-====+-::-:::::::---:::-++++=-===-:              "
echo "               .:::::::-------==========+++=++-.:::::-::-:-:::::--:::...=-:               "
echo "                .::::-:----------===-===++++++-::::::-:::::::::::......=-:                "
echo "                 .:::-:--------==--=-========:::-:::-::::::::::::.....=-:                 "
echo "                   ::--:-------=====-======+-::::::--:::::::::::.....--.                  "
echo "                    .::-:------======-=======-:::::::::::::::::....:-:                    "
echo "                      .:---------====-=========-:::::::::::::....--:                      "
echo "                        .:----========-===========--:-::::::::.:-:                        "
echo "                           .--=======================::::::::::.                          "
echo "                              .:-===================:::::::..                              "
echo "                                  .:-=====++++++++=-::-:.                                 "
echo "                                       :--=++++++=--:.                                    "
echo "                                                                                          "
echo -e "\e[0m" # Reset color
}

# Function to track IP address details
track_ip() {
    echo -e "\e[1;34m[+] Enter IP Address to track:\e[0m"
    read ip

    echo -e "\e[1;34m[+] Fetching details for:\e[1;32m $ip\e[0m"

    # Get IP information using ipinfo.io API
    response=$(curl -s https://ipinfo.io/$ip)

    # Check if IP information is valid
    if [[ $response == *"error"* ]]; then
        echo -e "\e[1;31m[-] Invalid IP address. Please try again.\e[0m"
        exit 1
    fi

    # Extract information
    city=$(echo $response | jq -r '.city')
    region=$(echo $response | jq -r '.region')
    country=$(echo $response | jq -r '.country')
    org=$(echo $response | jq -r '.org')
    loc=$(echo $response | jq -r '.loc')
    timezone=$(echo $response | jq -r '.timezone')
    postal=$(echo $response | jq -r '.postal')

    # Display IP details with arrows
    echo -e "\e[1;34m[+] IP Details:\e[0m"
    echo -e "\e[1;32m    ➤ City: $city\e[0m"
    echo -e "\e[1;32m    ➤ Region: $region\e[0m"
    echo -e "\e[1;32m    ➤ Country: $country\e[0m"
    echo -e "\e[1;32m    ➤ Organization: $org\e[0m"
    echo -e "\e[1;32m    ➤ Location (Lat, Long): $loc\e[0m"
    echo -e "\e[1;32m    ➤ Timezone: $timezone\e[0m"
    echo -e "\e[1;32m    ➤ Postal Code: $postal\e[0m"

    # Display developer info
    echo -e "\n\e[1;34mDeveloper: WizSafe.org\e[0m"
}

# Main function
main() {
    display_banner
    track_ip
}

# Run the main function
main
