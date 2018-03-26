# Windows-choco-prov
##Windows Provisioning Powered By Chocolatey.org.
other: own custom packages... 

Tools REQ:  NTLITE , RUFUS , easy to use Batch Scripts / powershell scripts Windows 10/2016 else Windows 8 /Windows 7.
 also One can also USE puppet. ie https://github.com/rismoney/puppet-baremetal-windows for sysprep. etc.. for PXEboot and bake image for Corp Lan use... 

## To Do write a recursive Script with folder blockers or not .. that recursively dose Batch.. 
IE some packages you may not want..  ie Game_Devops , I care Little for this myself.  but the Stepson needs it yet dosent know it... 
Dont care to have to keep up on them... 

Simple Package Catagories  by folder , simple CMD files per package..

On First boot Fetch this repo via github coadload... IE zipfile , unpack to.. via powershell , install chocolatey. 
((https://chocolatey.org/install))
Batch:
<code>@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin" </code>

####  fire up provsion-me.cmd  to invoke cmd's in folders to install a typicall business tools , toys etc. 
choco install %package-name%  -y , in package-name.cmd's ie firefox , chrome etc...   
choco install googlechrome -y , installs chrome Enterprise..  
(googlechrome.cmd has the logic of choco install googlechrome) 
I have made a Choco-installer.cmd before ... 200 billion miles long... and fuggly...
#### Enter Modularity

so for each package a simple cmd sure it's tiresome to make least once... however I can make sure many computers end NTLITE with a light wieght LWIS corp image, and go get the apps, with less fuss. 
however each package has a cmd , and if it fails, makes it easier to fix. 

cd into say Office , do CMD's , Next CD into browser/s do CMD's , etc." Modularity is main Goal 


##### add package of XML to MS Schedular templates , for Easy Small Biz mainiance 
Weekly Choco upgrade all ... just add your Admin Creds.. 
 

  also dose the same however easy of understanding for most users , also requres the nupkg files downloaded. 
  www.easy2boot.com/add-payload-files/windows-install-isos/sdi-choco/chocbox/
  
