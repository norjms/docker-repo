#!/bin/bash
set -euo pipefail

DIR="/mnt/container/appfs/qbittorrent"
OWNER_UID=1000
OWNER_GID=3000
PERMS=0774

# Check if directory exists
if [ ! -d "$DIR" ]; then
    echo "Directory $DIR does not exist. Exiting."
    exit 1
fi

# Check and fix ownership recursively if needed
if find "$DIR" ! -user $OWNER_UID -o ! -group $OWNER_GID | grep -q .; then
    echo "Fixing ownership to $OWNER_UID:$OWNER_GID recursively in $DIR"
    chown -R $OWNER_UID:$OWNER_GID "$DIR"
else
    echo "Ownership is correct."
fi

# Check and fix permissions recursively if needed
if find "$DIR" ! -perm $PERMS | grep -q .; then
    echo "Fixing permissions to $PERMS recursively in $DIR"
    chmod -R $PERMS "$DIR"
else
    echo "Permissions are correct."
fi
