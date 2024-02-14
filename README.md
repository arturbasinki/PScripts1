# PScripts1

Powershell utility scripts. To install all at once, execute this script in PS:

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/arturbasinki/PScripts1/main/install.ps1'))
```

## view-type.ps1

Shows all files with specified extension in current directory and its subdirectories.
usage:

```terminal
PS > view-type -type '.jpg'
```

## delete-type.ps1

Deletes all files with specified extension in current directory and its subdirectories.
usage:

```terminal
PS > delete-type -type '.log'
```
