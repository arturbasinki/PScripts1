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
$suma = ($files | Measure-Object -Property Length -Sum).Sum / 1MB
Write-Output ("The combined file size is: {0:N2} MB" -f $suma)

# Pytaj użytkownika, czy chce usunąć files
$odpowiedz = Read-Host "Delete files? (yes/no)"
if ($odpowiedz -eq 'yes') {
    $files | Remove-Item -Confirm:$false
    Write-Output ("Number of files deleted: " + $files.Count)
    Write-Output ("The deleted files size is: {0:N2} MB" -f $suma)
}
