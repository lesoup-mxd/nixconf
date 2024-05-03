#!/run/current-system/sw/bin/bash

# Merge multiple branches of a Git repository into the current branch in /etc/nixos

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Stage 1/2 : Adding nixpkgs channels"


# Get the OS name and version
version=$(grep '^VERSION_ID' /etc/os-release | cut -d '=' -f 2)

# Define the nixpkgs channel URL and name
channel_url="https://nixos.org/channels/nixos-$version"
channel_name="nixos                     "

# Check if the channel is already added
if ! nix-channel --list | grep -q "$channel_name"; then
    # Add the channel if it's not already added
    nix-channel --add "$channel_url" "$channel_name"
fi
channel_url="https://nixos.org/channels/nixpkgs-unstable"
channel_name="nixpkgs-unstable"

# Check if the channel is already added
if ! nix-channel --list | grep -q "$channel_name"; then
    # Add the channel if it's not already added
    nix-channel --add "$channel_url" "$channel_name"
fi

# Update the channels
nix-channel --update


# Download the script
curl -L https://raw.githubusercontent.com/lesoup-mxd/nixconf/main/stage_2.sh -o ./stage_2.sh

# Make the script executable
chmod +x ./stage_2.sh

# Execute the script within nix-shell
echo "Stage 1/2 completed."
echo "Executing stage 2/2 : Merging branches and updating the system configuration"
nix-shell -p git --command "sudo ./stage_2.sh"

