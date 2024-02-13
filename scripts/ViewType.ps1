param (
    [string]$type = '.txt'
)

# Use $PSScriptRoot to specify the folder where the script runs
$dir = $PSScriptRoot

# Use Get-ChildItem to search a folder and subfolders
$files = Get-ChildItem -Path $dir -Recurse -Filter "*$type"

# Display full paths to all files with a specific extension
$files | ForEach-Object {
    Write-Output $_.FullName
}

# View the number of files found
Write-Output ("Number of files found: " + $files.Count)

# Calculate and display the total volume of files
$sum = ($files | Measure-Object -Property Length -Sum).Sum / 1MB
Write-Output ("The combined file size is: {0:N2} MB" -f $sum)
