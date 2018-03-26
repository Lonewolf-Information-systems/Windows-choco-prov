REM for Gandolf PE or Windows to go Wim's
REM Last time I killed my Linux EFI on Re-install when wife'y broke my focus... 
REM being a pain to rebuild... EFI but likewise seeing the ext3/4 lesslikely to ooops it.
REM this should hopefully work. //praying it will... 
REM Gandolf-pe with gui + Windows 10 install folder + Ntlite intergrated driveres etc. 
REM Rebuild/Backup /push to network shares.. Windows/Linux files  to backupserver before  re-image.. 


rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 .\ext2fsd.inf
net start ext2fsd