# Description: Merge branches and update the system configuration
#
# Made by: Lesoup-mxd ( https://github.com/lesoup-mxd )


# Check if the directory is a Git repository
if! git rev-parse --is-inside-work-tree &>/dev/null; then
    # Initialize a new Git repository in /etc/nixos
    cd /etc/nixos
    git clone https://github.com/lesoup-mxd/nixconf.git /etc/nixos
fi

# List all branches
echo "Available branches:"
git branch -a

# Prompt the user to enter the names of the branches they want to merge
echo "Enter the names of the branches you want to merge, separated by spaces:"
read -r -p "> " branches

# Split the input into an array
IFS=' ' read -ra BRANCHES <<< "$branches"

# Merge each selected branch into the current branch
for branch in "${BRANCHES[@]}"; do
    echo "Merging $branch..."
    git merge $branch
done

echo "Merges completed."

# Display the status of the repository
git status

# Prompt the user to update the system configuration
echo "Do you want to update the system now? (y/n)"
read -r -p "> " response

# Check the user's response
if [ -z "$response" = "y" || "$response" = "Y" || "$response" = "yes"]
    # Update the system configuration
    echo "Updating the package list..."
    sudo nix-channel --update &> /dev/null
    sudo nixos-rebuild switch --upgrade
else
    echo "System branch not updated."
    echo "Run 'sudo nixos-rebuild switch --upgrade' to update the system configuration."
fi

echo "Stage 2/2 completed."