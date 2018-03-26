@echo off
choco install powershell

choco upgrade powershell

rem Windows Management Framework 5.0 includes updates to Windows PowerShell, Windows PowerShell ISE, Windows PowerShell Web rem Services (Management OData IIS Extension), Windows Remote Management (WinRM), Windows Management Instrumentation (WMI), rem the Server Manager WMI provider, and a new feature for 4.0, Windows PowerShell Desired State Configuration (DSC).
rem Windows Management Framework 5.0 includes updates to Windows PowerShell, Windows PowerShell Desired State Configuration rem (DSC), and Windows PowerShell ISE. It also includes OneGet, PowerShellGet, and Network Switch cmdlets
rem Important Product Incompatibility Notes: https://msdn.microsoft.com/en-us/powershell/wmf/5.0/productincompat
rem IMPORTANT NOTES for your Operating System:
rem PowerShell 4 and later requires at least .NET 3.5.1.
rem This package will warn you and exit if it is not installed.
rem It is not automatically installed as a dependency so that you
rem maintain complete control over the .NET version in your build.