#!/usr/bin/env bash
set -e

echo "deb [trusted=yes] https://packages.vehub.vector.com/apt generic vehub" > /etc/apt/sources.list.d/vehub.list
apt-get update
apt-get install -y vehub

# Verify installation
if command -v vehub &> /dev/null
then
    echo "veHub CLI installed successfully at $(command -v vehub)"
else
    echo "veHub CLI installation failed!"
    exit 1
fi
