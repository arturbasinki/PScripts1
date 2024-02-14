# PScripts1

Powershell utility scripts, to install all at once, execute this script in PS:

iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/arturbasinki/PScripts1/main/install.ps1'))

To use scripts at every new terminal session:

1. Create folder for scripts in a location of your choice. For example, you can create C:\YourScripts.
2. Then open your PowerShell profile. You can do this by typing $PROFILE in the PowerShell console. If the profile file does not exist, you can create it by typing New-Item -path $PROFILE -type file -force.
3. Open the profile file in a text editor, such as Notepad.
4. Add the following line to the end of the profile file:
   $env:Path += ";C:\YourScripts"
   Replace C:\YourScript.ps1 with the path to your script found with pwd.
5. Save and close the profile file.
6. You could also add alias to use scripts as module, to do that, add:
   Set-Alias view-type view-type.ps1
   .
   .
   .

## ViewType.ps1

usage: .\ViewType.ps1 -type '.jpg'

## DeleteType.ps1

usage: .\DeleteType.ps1 -type '.log'
