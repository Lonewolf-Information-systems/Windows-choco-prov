@echo off 
choco upgrade chocolatey choco install chocolatey-core.extension  chocolateypackageupdater chocolatey-windowsupdate.extension  -y

choco upgrade all -y

REM upgrade firefox  chome etc, all packages managed by chocolatey or upgradable 

rem choco upgrade all --except="'skype,conemu'"  , rejects on packages needing a version.

rem can add to task Schedualer on users pc like wife's/son's/etc pc , were packages like never get much updating. , 
rem so that they actually will. 