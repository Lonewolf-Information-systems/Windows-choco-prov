# Windows-choco-prov
##Windows Provisioning Powered By Chocolatey.org.
other: own custom packages... 

Tools REQ:  NTLITE , RUFUS , easy to use Batch Scripts / powershell scripts Windows 10/2016 else Windows 8 /Windows 7.
 also One can also USE puppet. ie https://github.com/rismoney/puppet-baremetal-windows for sysprep. etc.. for PXEboot and bake image for Corp Lan use... if you like. 
 
 https://social.technet.microsoft.com/Forums/windows/en-US/bd12e5a9-7a01-418a-bc10-8503a5dcf04c/running-a-script-immediatly-after-wds-deployment?forum=w7itproinstall  , smaller image , use choco scripts to deploy packages...
 
 ###A: Deploy by USB NTLITE & Post install  Kick-off Script.. 
 
 ###B: PXE boot and WDS , or simular. 

## To Do write a recursive CMD runer Script with folder blockers or not .. that recursively dose Batch.. 
IE some packages you may not want..  ie Game_Devops , I care Little for this myself.  but the Stepson needs it yet dosent know it... 
Dont care to have to keep up on them...  so I can simply Make a seperate Game-dev-Desinger-deploy.cmd to hook his on his boxes but deploy all other packages as part of a standard image. 
### IT Shoptoys Ie pdqdeploy , spiceworks , etc to own IT-admintoools-provision.cmd 

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
((https://chocolatey.org/packages))

so for each package a simple cmd sure it's tiresome to make least once... however I can make sure many computers end NTLITE with a light wieght LWIS corp image, and go get the apps, with less fuss. 
however each package has a cmd , and if it fails, makes it easier to fix. 

cd into say Office , do CMD's , Next CD into browser/s do CMD's , etc." Modularity is main Goal 


##### add package of XML to MS Schedular templates , for Easy Small Biz mainiance 
Weekly Choco upgrade all ... just add your Admin Creds.. , no to low touch mainitnce of SMB users and or Household 
its the Weekend Should You need to Fix Spouces PC? or Kids PC's becuase, "How do I upgrade firefox" , Meh make It done and solved...
 

  also dose the same via usb and alot of hacks , however easy of understanding for most users is hidden lots of adds BS  , also requres the nupkg files downloaded, collected foldered and many could grow stale... fast. 
  www.easy2boot.com/add-payload-files/windows-install-isos/sdi-choco/chocbox/
  
