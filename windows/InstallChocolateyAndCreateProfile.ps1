# Specify the file path
$filePath = "C:\Users\lloyd\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

# Specify the file content
$fileContent = @'
$ENV:STARSHIP_DISTRO = "🪟TLJ "
Invoke-Expression (&starship init powershell)

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
'@

# Check if Chocolatey is installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    # Install Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Check if the directory exists, if not create it
$dirPath = Split-Path -Path $filePath -Parent
if (!(Test-Path -Path $dirPath)) {
    New-Item -ItemType Directory -Force -Path $dirPath
}

# Create the file and write the content
Set-Content -Path $filePath -Value $fileContent

choco install microsoft-edge-insider-dev -y
choco install microsoft-teams.install -y
choco install python3 -y
choco install 7zip.install -y
choco install vlc -y
choco install git.install -y
choco install nodejs.install  -y
choco install curl  -y
choco install amd-ryzen-chipset -y
choco install powertoys -y
choco install vscode-insiders.install  -y
choco install f.lux.install -y
choco install docker-desktop -y
choco install starship -y
choco install php -y
