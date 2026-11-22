$ErrorActionPreference = 'Stop'

$managedProfile = "$HOME/.config/powershell/profile.ps1"
if (-not (Test-Path -LiteralPath $managedProfile -PathType Leaf)) { return }

$profilePath = $PROFILE.CurrentUserAllHosts
$loadProfile = 'if (Test-Path -LiteralPath "$HOME/.config/powershell/profile.ps1" -PathType Leaf) { . "$HOME/.config/powershell/profile.ps1" }'

if (Test-Path -LiteralPath $profilePath) {
    if ((Get-Content -LiteralPath $profilePath) -cnotcontains $loadProfile) {
        Add-Content -LiteralPath $profilePath -Value '', $loadProfile
    }
} else {
    New-Item -ItemType Directory -Path (Split-Path -Parent $profilePath) -Force | Out-Null
    Set-Content -LiteralPath $profilePath -Value $loadProfile
}
