@echo off

:: how to use - call config.bat in header

::global

set rpi=R:
set rpiip=10.0.0.20
set rpiusername="Username (default is 'pi')"
set rpipassword="Password (default is 'raspberry')"
set rpibios="%rpiip%\bios"
set "PATH=%PATH%;C:\Program Files\7-Zip\"

:: conf\header.bat
set version=0.1a
set headertitle="You forgot to set this"
set headerdesc="hey, doofus - set this in your file"
set headerlog="This will probably be %%log%%, but check."

:: PCECD-APE-to-WAV.bat
set "p="

:: bios - CUE to CHD.bat
:: set rpibios="R:\bios"

:: DC-CUE-or-GDI-to-CHD.bat
set rpidc="\\%rpiip%\roms\dreamcast"

:: PSX-CUE-to-CHD.bat
set rpipce="\\%rpiip%\roms\pcengine"

:: PSX-CUE-to-CHD.bat
set rpipsx="\\%rpiip%\roms\psx"

:: SEGACD-CHD-CONVERTER.bat
set rpisegacd="\\%rpiip%\roms\segacd"

::End of import, turn echo back on
@echo on