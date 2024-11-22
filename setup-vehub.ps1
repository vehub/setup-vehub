# Exit on error
$ErrorActionPreference = "Stop"

# Add the static feed to Chocolatey sources
choco source add --name="veHub" --source="https://packages.vehub.vector.com/nuget/index.json" --priority=1

# Install veHub CLI using Chocolatey
Write-Host "Installing veHub CLI..."
choco install vehub -y

# Verify installation
if (Get-Command vehub -ErrorAction SilentlyContinue) {
    $path = (Get-Command vehub).Path
    Write-Host "veHub CLI installed successfully at $path"
} else {
    Write-Host "veHub CLI installation failed!"
    exit 1
}
