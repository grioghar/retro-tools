@echo off

:: how to use - call config.bat in header

::global
set rpi=R:\
set rpiip="IP Address of Raspberry Pie"
set rpiusername="Username (default is 'pi')"
set rpipassword="Password (default is 'raspberry')"
set "PATH=%PATH%;C:\Program Files\7-Zip\"
set version=0.1a

:: PCECD-APE-to-WAV.bat
set "p="

:: PSX - CUE to CHD.bat
set rpipsx=R:\psx