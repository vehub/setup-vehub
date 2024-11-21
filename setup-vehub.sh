#!/usr/bin/env bash
set -e

wget -O - https://packages.vehub.vector.com/apt/vector-pkg.key | sudo gpg --dearmor -o /usr/share/keyrings/vector-pkg.gpg && \
echo "deb [signed-by=/usr/share/keyrings/vector-pkg.gpg] https://packages.vehub.vector.com/apt generic vehub" | sudo tee /etc/apt/sources.list.d/vehub.list

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
