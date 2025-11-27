<#
  setup_github_secrets.ps1

  Interactive PowerShell script to create the repository secrets required by
  the CD workflow using the GitHub CLI (`gh`). Run this locally while
  authenticated with `gh auth login`.

  Secrets created:
    - REGISTRY_HOST
    - REGISTRY_PATH
    - REGISTRY_USERNAME
    - REGISTRY_TOKEN
    - KUBECONFIG (base64-encoded kubeconfig)

  Usage (PowerShell):
    Open a PowerShell prompt where you have `gh` and `git` available and run:
      ./scripts/setup_github_secrets.ps1

  Notes:
    - The script will detect the repo from the `origin` remote.
    - `gh` must be authenticated and have repo:admin (or repo) permission for setting secrets.
    - Kubeconfig will be base64-encoded before sending to GitHub as required by the workflow.
#>

function Abort($msg) {
    Write-Error $msg
    exit 1
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Abort "The GitHub CLI 'gh' is not installed or not available in PATH. Install and authenticate (gh auth login) and re-run."
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Abort "'git' is not installed or not available in PATH."
}

# Get repo owner/name from git remote
$origin = git remote get-url origin 2>$null
if (-not $origin) { Abort "No 'origin' remote found. Ensure you're in the repo and origin is configured." }

# Normalize origin into owner/repo
if ($origin -match "[:/]([^/]+/[^/.]+)(\.git)?$") {
    $repo = $matches[1]
} else {
    Abort "Could not parse origin remote url: $origin"
}

Write-Host "Repository detected: $repo" -ForegroundColor Cyan

$defaults = @{
    REGISTRY_HOST = 'docker.io'
    REGISTRY_PATH = ''
    KUBECONFIG_PATH = "$env:USERPROFILE\.kube\config"
}

$REGISTRY_HOST = Read-Host "Registry host (e.g. docker.io or ghcr.io) [${defaults.REGISTRY_HOST}]"
if (-not $REGISTRY_HOST) { $REGISTRY_HOST = $defaults.REGISTRY_HOST }

$REGISTRY_PATH = Read-Host "Registry path (your username or org on the registry) (required)"
if (-not $REGISTRY_PATH) { Abort "REGISTRY_PATH is required (your registry username/org)." }

$REGISTRY_USERNAME = Read-Host "Registry username (for login)"
if (-not $REGISTRY_USERNAME) { Abort "REGISTRY_USERNAME is required." }

Write-Host "Enter registry token/password (will be hidden)" -ForegroundColor Yellow
$REGISTRY_TOKEN = Read-Host -AsSecureString "Registry token" | ConvertFrom-SecureString
if (-not $REGISTRY_TOKEN) { Abort "REGISTRY_TOKEN is required." }

$KUBECONFIG_PATH = Read-Host "Path to kubeconfig file [${defaults.KUBECONFIG_PATH}]"
if (-not $KUBECONFIG_PATH) { $KUBECONFIG_PATH = $defaults.KUBECONFIG_PATH }
if (-not (Test-Path $KUBECONFIG_PATH)) { Abort "kubeconfig not found at: $KUBECONFIG_PATH" }

# Read and base64-encode kubeconfig
$kubeRaw = Get-Content -Raw -Path $KUBECONFIG_PATH -ErrorAction Stop
$kubeBytes = [System.Text.Encoding]::UTF8.GetBytes($kubeRaw)
$kubeBase64 = [Convert]::ToBase64String($kubeBytes)

Write-Host "About to create the following secrets in repo: $repo" -ForegroundColor Green
Write-Host " - REGISTRY_HOST" -ForegroundColor Gray
Write-Host " - REGISTRY_PATH" -ForegroundColor Gray
Write-Host " - REGISTRY_USERNAME" -ForegroundColor Gray
Write-Host " - REGISTRY_TOKEN" -ForegroundColor Gray
Write-Host " - KUBECONFIG" -ForegroundColor Gray

if (-not (Read-Host "Continue and apply these secrets to the repository? (y/N)").ToLower().StartsWith('y')) {
    Write-Host "Aborted by user." -ForegroundColor Yellow
    exit 0
}

function ghSetSecret($name, $value) {
    Write-Host "Setting secret: $name" -NoNewline
    $proc = gh secret set $name --body $value --repo $repo 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host " -> FAILED" -ForegroundColor Red
        Write-Host $proc
        Abort "Failed to set secret $name"
    } else {
        Write-Host " -> OK" -ForegroundColor Green
    }
}

ghSetSecret -name 'REGISTRY_HOST' -value $REGISTRY_HOST
ghSetSecret -name 'REGISTRY_PATH' -value $REGISTRY_PATH
ghSetSecret -name 'REGISTRY_USERNAME' -value $REGISTRY_USERNAME

# REGISTRY_TOKEN was converted from securestring; convert back safely
$secure = ConvertTo-SecureString $REGISTRY_TOKEN
$plainToken = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure))
ghSetSecret -name 'REGISTRY_TOKEN' -value $plainToken

ghSetSecret -name 'KUBECONFIG' -value $kubeBase64

Write-Host "All secrets set successfully." -ForegroundColor Green
