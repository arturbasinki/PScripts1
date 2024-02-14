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

# Download scripts
$scripts = Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/arturbasinki/PScripts1/main/scripts/'

# Copy scripts to folder Scripts and add aliases
$scripts | ForEach-Object {
    $destination = Join-Path -Path $scriptsPath -ChildPath $_.Name
    $_ | Copy-Item -Destination $destination

    # Add alias
    $aliasName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    if (!(Get-Alias -Name $aliasName -ErrorAction SilentlyContinue)) {
        Set-Alias -Name $aliasName -Value $destination
    }
}
# Update variable $env:Path in $PROFILE file
$profileContent = Get-Content -Path $PROFILE
if ($profileContent -notcontains "`$env:Path += `";$scriptsPath`"") {
    Add-Content -Path $PROFILE -Value "`$env:Path += `";$scriptsPath`""
}
