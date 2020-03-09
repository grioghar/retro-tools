@echo off

:: how to use - call config.bat in header

set rpi=R:\psx
set rompath=%1

set rpiip="IP Address of Raspberry Pie"
set rpiusername="Username (default is 'pi')"
set rpipassword="Password (default is 'raspberry')"

set "PATH=%PATH%;C:\Program Files\7-Zip\"
