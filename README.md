# GeoSNIFF v2

**GeoSNIFF** is an advanced IP address tracking tool developed by **WizSafe Technologies**. It provides accurate geographical and network information of any IP address with a fast and colorful interface.

## Features

- Track IP geolocation (City, Region, Country)
- Get ISP, Postal Code, Coordinates & Timezone
- Fast response using ipinfo.io API
- Auto-log results in `logs.txt`
- Works on Termux & Linux

## Installation

```bash
git clone https://github.com/WizSafe/GeoSNIFF.git
cd GeoSNIFF
chmod +x GeoSNIFF.sh
bash GeoSNIFF.sh

#Example Usage

$ bash GeoSNIFF.sh
[+] Enter IP Address to track:
> 8.8.8.8

[+] IP Details:
    ➤ City: Mountain View
    ➤ Region: California
    ➤ Country: US
    ➤ Organization: Google LLC
    ➤ Location: 37.3860,-122.0840
    ➤ Timezone: America/Los_Angeles
    ➤ Postal Code: 94035

[+] Logs saved to: logs.txt

#Developer

WizSafe Technologies
