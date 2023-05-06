#!/bin/bash

# Define the file path
DOCKSAL_ENV_FILE="$HOME/.docksal/docksal.env"

# Check if the file exists
if [[ -f "$DOCKSAL_ENV_FILE" ]]; then
    # Make a backup of the original file
    cp "$DOCKSAL_ENV_FILE" "$DOCKSAL_ENV_FILE.bak"

    # Replace the DOCKSAL_DNS_DOMAIN value
    sed -i 's/DOCKSAL_DNS_DOMAIN="docksal.site"/DOCKSAL_DNS_DOMAIN="docksal"/g' "$DOCKSAL_ENV_FILE"

    echo "DOCKSAL_DNS_DOMAIN value updated in $DOCKSAL_ENV_FILE."
else
    echo "File $DOCKSAL_ENV_FILE not found. Please ensure it exists."
fi
