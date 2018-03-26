 CLS
 Function Get-FileName($initialDirectory)
{  
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
 Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "All files (*.*)| *.*"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} #end function Get-FileName


 Function  Copy-WsusUpdateToFolder {
 <#
        .Synopsis
            Copying needed updates to the directory using WSUS Api and Microsoft Baseline Security Analyzer (MBSA) with offline bases report
        
        .Description
            Need to run this on WSUS server with higest privileges (Run as Administrator)
            You need to install MBSA run it and try to find something. You can break if you dont have internet connection, 
            download offline catalog (wsusscn2.cab) use link bellow and copy it $Env:UserProfile\Appdata\Local\Microsoft\MBSA\Cache directory
            If you dont have internet connection you need to choose 
            Computer scan -> Select ONLY "Check for security updates" -> Select ONLY "Advanced Update Services options" -> Scan using offline catalog
            After that you need copy result to TXT file and select it in that script
            
            MBSA utility you can download here: https://technet.microsoft.com/en-us/security/cc184924.aspx
            Offline catalog (actual) you can download here: http://go.microsoft.com/fwlink/?LinkId=76054
                        
        .PARAMETER FilePath
            MBSA report in text format

        .PARAMETER DestinationFolder
            Folder for coping update files

        .NOTES
            Name: Copy-WsusUpdateToFolder
            Version: 2.1
            Author: Vector BCO
            DateCreated: 04 Nov 2015

            For Open file (function Get-Filename) used http://blogs.technet.com/b/heyscriptingguy/archive/2009/09/01/hey-scripting-guy-september-1.aspx
            Thanks a for help with MBSA Slava Fedenko
            Thanks a for help with WSUS Api Steven_Lee0510 (MSFT CSG)

        .EXAMPLE
            Copy-WsusUpdateToFolder -FilePath c:\temp\Server1\Server1_MBSA_Report.txt -DestinationFolder c:\temp\Server1\
            
            VERBOSE: 
            Working with update " Security Update for Microsoft .NET Framework 4.5.1 and 4.5.2 on Windows 8.1 and Windows Server 2012 R2 x64-based Systems (KB3032663) "
            Tying copy D:\WSUS\WsusContent\4D\C4CD5911CA50327C0B706E7EC70CD3ABF367E14D.cab to C:\temp\Tgate\windows8.1-kb3032663-x64.cab
            


            Description
            -----------
            Find update by name Security Update for Microsoft .NET Framework 4.5.1 and 4.5.2 on Windows 8.1 and Windows Server 2012 R2 x64-based Systems (KB3032663)
            Copy it from local server cache folder to 
#>

    Param(
        [string]$FilePath,
        [string]$DestinationFolder
    )


    if (($DestinationFolder -eq "") -or ($DestinationFolder -eq $null)){
        $app = new-object -com Shell.Application
        $DestinationFolder = ($app.BrowseForFolder(0, "Select Folder", 0, "C:\")).Self.Path
    }
    
    if (($filepath -eq "") -or ($filepath -eq $null) -or ((Get-Content $filepath | Select-String  -List "\| Missing \|" | Measure-Object).count -lt 1)){
        do {
            $filepath = Get-FileName -initialDirectory $DestinationFolder
            (Get-Content $filepath | Select-String  -List "\| Missing \|" | Measure-Object).count -ge 1
        If ((Get-Content $filepath | Select-String  -List "\| Missing \|" | Measure-Object).count -ge 1){$triger=$true}
            Else {$triger=$False}
            }
   while ($triger -eq $false)
    }
    
    if (($filepath -eq "") -or ($filepath -eq $null) -or ((Get-Content $filepath | Select-String  -List "\| Missing \|" | Measure-Object).count -lt 1)){
        "----- Incorrect file selected"
        break
    }

$Bat = @"
cls
@echo off
for /r %%i in (*.cab) do (
echo Install %%i
start /wait DISM.exe /Online /Add-Package /PackagePath:%%i /Quiet /NoRestart
)
pause
"@

    
    "Total count of needed updates: $((Get-Content $filepath | Select-String  -List "\| Missing \|" | Measure-Object).count)"

    
    $WSUSFilePath = (Get-WsusServer).GetConfiguration().LocalContentCachePath
    $files = @()
    [void][Reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
    $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer()
    Get-Content $filepath | Select-String  -List "\| Missing \|" | foreach {
    $title = $_ -replace "^\s+\| [-a-z0-9]+ \| Missing \|" -replace "\| [a-z]* \|\s*$"
    "`n`rWorking with update `"$title`""
        
    $wsus.SearchUpdates($title) | ForEach-Object {$files += $_.GetInstallableItems().Files | select Name,FileUri}
    
    $files | foreach{
        If (($_.Name -notlike "*.psf") -and ($_.Name -notlike "*express*")) {
            $DestinationFileName = $_.Name
            $LocalFileLocation = $_.FileUri.LocalPath -replace "\/content" -replace "\/","\"
            
            Try{
                "Tying copy $WSUSFilePath$LocalFileLocation to $DestinationFolder\$DestinationFileName"
                Copy-Item "$WSUSFilePath$LocalFileLocation" -Destination "$DestinationFolder\$DestinationFileName" -ErrorAction Stop
                }
            Catch{
                "----- Something going incorrect when you try copy $WSUSFilePath$LocalFileLocation to $DestinationFolder\$DestinationFileName"
                $_.Exception.Message
                }
            }
        }
    
    Clear-Variable Files
    }

#Create Update.bat file in "$DestinationFolder
$Bat | Out-File "$DestinationFolder\InstallUpdates.bat" -Encoding default

Clear-Variable FilePath,DestinationFolder,app,triger,WSUSFilePath,files,wsus,title,DestinationFileName,LocalFileLocation
Remove-Variable FilePath,DestinationFolder,app,triger,WSUSFilePath,files,wsus,title,DestinationFileName,LocalFileLocation
}

help Copy-WsusUpdateToFolder -Full
