@echo off

:: how to use - call config.bat in header

::global
set rpi=R:\
set rpiip="IP Address of Raspberry Pie"
set rpiusername="Username (default is 'pi')"
set rpipassword="Password (default is 'raspberry')"
set rpibios="\\10.0.0.20\bios"
set "PATH=%PATH%;C:\Program Files\7-Zip\"
set version=0.1a


:: PCECD-APE-to-WAV.bat
set "p="

:: bios - CUE to CHD.bat
:: set rpibios="R:\bios"

::End of import, turn echo back on
@echo on