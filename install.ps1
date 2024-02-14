# Check if $PROFILE exists
if (!$PROFILE) {
    $PROFILE = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
}

# Check if file $PROFILE exists
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

# Check if folder Scripts exists
$scriptsPath = Join-Path -Path (Split-Path -Path $PROFILE) -ChildPath 'Scripts'
if (!(Test-Path -Path $scriptsPath)) {
    New-Item -ItemType Directory -Path $scriptsPath
}

# URL list of scripts to download
$scriptUrls = @(
    'https://raw.githubusercontent.com/arturbasinki/PScripts1/main/scripts/delete-type.ps1',
    'https://raw.githubusercontent.com/arturbasinki/PScripts1/main/scripts/view-type.ps1'
    # Add more links if needed
)

foreach ($url in $scriptUrls) {
    # Download script
    $scriptContent = (New-Object System.Net.WebClient).DownloadString($url)

    # Write script as .ps1 in Scripts directory
    $scriptName = [System.IO.Path]::GetFileName($url)
    $destination = Join-Path -Path $scriptsPath -ChildPath $scriptName
    $scriptContent | Out-File -FilePath $destination

    # Create alias
    $aliasName = [System.IO.Path]::GetFileNameWithoutExtension($url)
    if (!(Get-Alias -Name $aliasName -ErrorAction SilentlyContinue)) {
        Set-Alias -Name $aliasName -Value $destination
    }
}

# Update variable $env:Path in $PROFILE file
$profileContent = Get-Content -Path $PROFILE
if ($profileContent -notcontains "`$env:Path += `";$scriptsPath`"") {
    Add-Content -Path $PROFILE -Value "`$env:Path += `";$scriptsPath`""
}