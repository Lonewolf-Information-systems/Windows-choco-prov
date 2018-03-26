$logfolders=("D:\Folder\One","D:\Folder\Two")
$age=(get-date).AddDays(-3)

foreach ($logfolder in $logfolders) {
    Get-ChildItem $logfolder | where-object {$_.LastWriteTime -le $age -AND $_.Attributes -notlike "*Compressed*"} | 
    ForEach-Object {
    compact /C $_.FullName
    }
}