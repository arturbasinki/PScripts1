# Check if the $PROFILE variable exists
Write-Host "Checking if the \$PROFILE variable exists..."
if (!$PROFILE) {
    $PROFILE = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
}

# Check if the profile file exists
Write-Host "Checking if the profile file exists..."
if (!(Test-Path -Path $PROFILE)) {
    Write-Host "Creating the profile file..."
    New-Item -ItemType File -Path $PROFILE -Force
}

# Check if the Scripts folder exists
Write-Host "Checking if the Scripts folder exists..."
$scriptsPath = Join-Path -Path (Split-Path -Path $PROFILE) -ChildPath 'Scripts'
if (!(Test-Path -Path $scriptsPath)) {
    Write-Host "Creating the Scripts folder..."
    New-Item -ItemType Directory -Path $scriptsPath
}

# List of URLs to the PowerShell scripts
$scriptUrls = @(
    'https://raw.githubusercontent.com/arturbasinki/PScripts1/main/scripts/delete-type.ps1',
    'https://raw.githubusercontent.com/arturbasinki/PScripts1/main/scripts/view-type.ps1'
    # Add more links if needed
)

foreach ($url in $scriptUrls) {
    Write-Host "Downloading the script from $url..."
    # Download the script
    $scriptContent = (New-Object System.Net.WebClient).DownloadString($url)

    # Save the script as a .ps1 file in the Scripts folder
    Write-Host "Saving the script as a .ps1 file in the Scripts folder..."
    $scriptName = [System.IO.Path]::GetFileName($url)
    $destination = Join-Path -Path $scriptsPath -ChildPath $scriptName
    $scriptContent | Out-File -FilePath $destination

    # Add an alias for the script to the profile file
    Write-Host "Adding an alias for the script to the profile file..."
    $aliasName = [System.IO.Path]::GetFileNameWithoutExtension($url)
    $aliasCommand = "Set-Alias -Name $aliasName -Value $destination"
    Add-Content -Path $PROFILE -Value $aliasCommand
}

# Update the $env:Path variable in the profile file
Write-Host "Updating the env variable in the profile file..."
$profileContent = Get-Content -Path $PROFILE
if ($profileContent -notcontains "`$env:Path += `";$scriptsPath`"") {
    Add-Content -Path $PROFILE -Value "`$env:Path += `";$scriptsPath`""
}

Write-Host "The script installation process is complete."