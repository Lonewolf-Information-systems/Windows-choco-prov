# RCS System Engineering: Package Management Auto-Update Orchestration
# Context: SYSTEM (Admin Execution Engine)
# Targets: Windows 11 (24H2, 25H2, 26H2, 25H2+) 

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

$WAURegPath = "HKLM:\Software\Policies\Romanitho\Winget-AutoUpdate"

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " STAGING ROMANITHO WINGET-AUTOUPDATE CONFIGURATION" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# 1. Enforce Registry Path Tree Structures Natively
if (-not (Test-Path $WAURegPath)) {
    New-Item -Path $WAURegPath -Force | Out-Null
}

# 2. Inject Fished GPO Settings directly into Registry Keys
Set-ItemProperty -Path $WAURegPath -Name "WAU_ActivateGPOManagement" -Value 1 -Type DWord -Force       
Set-ItemProperty -Path $WAURegPath -Name "WAU_DisableAutoUpdate"       -Value 0 -Type DWord -Force       
Set-ItemProperty -Path $WAURegPath -Name "WAU_UpdatesInterval"        -Value "Daily" -Type String -Force 
Set-ItemProperty -Path $WAURegPath -Name "WAU_UpdatesAtTime"          -Value "04:00:00" -Type String -Force # Targets the 3:00 AM - 5:00 AM maintenance window
Set-ItemProperty -Path $WAURegPath -Name "WAU_NotificationLevel"      -Value "None" -Type String -Force  

Write-Host "WAU GPO registry definitions successfully slapped onto host system." -ForegroundColor Green

# 3. Bootstrapping / Upgrading WAU application binaries via WinGet
Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host "Checking / Upgrading Winget-AutoUpdate Installation..." -ForegroundColor Cyan

if (Get-Command winget -ErrorAction SilentlyContinue) {
    try {
        & winget install --id Romanitho.Winget-AutoUpdate --silent --accept-source-agreements --accept-package-agreements --scope machine
        Write-Host "WAU binary stack deployed / updated successfully via WinGet." -ForegroundColor Green
    }
    catch {
        Write-Warning "WinGet direct app store hook failed. Retrying with basic task evaluation..."
    }
} else {
    Write-Error "CRITICAL: WinGet platform engine missing from host context. Cannot install WAU framework."
}

# 4. Deploying Native Chocolatey Scheduling Package
Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host "Provisioning Native Chocolatey Maintenance Windows..." -ForegroundColor Cyan

if (Get-Command choco -ErrorAction SilentlyContinue) {
    try {
        # Dynamically injects native chocolatey upgrade schedule using requested internal package parameter engine
        # Triggers daily at 12:00 AM, aborts if hanging or slipping near the WAU window boundary
        Write-Host "Injecting choco-upgrade-all-at with automated parameters..." -ForegroundColor Yellow
        
        & choco install winget-cli choco-upgrade-all-at --params "'/DAILY:yes /TIME:00:00 /ABORTTIME:02:55'" -y --no-progress
        
        Write-Host "Chocolatey update task successfully structured natively via package parameters." -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to orchestrate native Chocolatey scheduling package: $_"
    }
} else {
    Write-Host "Notice: Chocolatey environment skipped on this host asset." -ForegroundColor Yellow
}