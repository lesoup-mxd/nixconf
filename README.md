# NixOS first setup utility

## Description

Minimalistic first setup utility for NixOS. This script will install the necessary packages based on the user's input and update the system.

Obviously requires NixOS and an internet connection.

## Usage

```bash
curl -L https://raw.githubusercontent.com/lesoup-mxd/nixconf/main/init.sh
chmod +x init.sh
./init.sh
```

## If you need to set up an internet connection

```bash

ip a
wpa_passphrase <SSID> <password> > /etc/wpa_supplicant.conf
wpa_supplicant -B -i <interface> -c /etc/wpa_supplicant.conf

```
