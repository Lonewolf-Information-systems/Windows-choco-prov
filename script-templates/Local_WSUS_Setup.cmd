:: https Setup 
:: Lonewolf Information Systems Services Genric Template 
:: 
set winUp = "\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate" /v "WUServer" /d "http://10.0.0.7:8531" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate" /v "WUStatusServer" /d "http://10.0.0.7:8531" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate" /V "ElevateNonAdmins" /t REG_DWORD /d 1 /f

set AU = "\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 5 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" /v "ScheduledInstallDay" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" /v "ScheduledInstallTime" /t REG_DWORD /d 3 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" /v "NoAUShutdownOption" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" /v "LastWaitTimeout" /d "0" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU" /v "DetectionStartTime" /d "0" /f

net stop wuauserv
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v LastWaitTimeout /f
REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v DetectionStartTime /f
Reg Delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v NextDetectionTime /f
net start wuauserv
wuauclt  /showwindowsupdate /updatenow