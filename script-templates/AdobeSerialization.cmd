@echo off
start /d "path_to_file" AdobeSerialization.exe --tool=VolumeSerialize
 REM del AdobeSerialization.cmd

move AdobeSerialization.cmd AdobeSerialization.cmd.old