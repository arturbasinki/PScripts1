param (
    [string]$type = '.txt'
)

# Użyj $PSScriptRoot do określenia folderu, w którym skrypt jest uruchamiany
$dir = $PSScriptRoot

# Użyj Get-ChildItem do przeszukania folderu i podfolderów
$files = Get-ChildItem -Path $dir -Recurse -Filter "*$type"

# Wyświetl pełne ścieżki do wszystkich plików o określonym rozszerzeniu
$files | ForEach-Object {
    Write-Output $_.FullName
}

# Wyświetl liczbę znalezionych plików
Write-Output ("Number of files found: " + $files.Count)

# Oblicz i wyświetl łączną objętość plików
$sum = ($files | Measure-Object -Property Length -Sum).Sum / 1MB
Write-Output ("The combined file size is: {0:N2} MB" -f $sum)