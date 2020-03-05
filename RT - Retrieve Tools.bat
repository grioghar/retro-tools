REM using local tools, download chdman, ffmpeg, and anything else needed
REM Download wget using Windows BITSadmin
REM bitsadmin /addfile retro-tools https://eternallybored.org/misc/wget/1.20.3/64/wget.exe wget.exe
REM bitsadmin /SetCredentials thisissomejobname Server BASIC somehttpuser somehttppassword

:: The retro-tools equivalent of using IE to download FF
:: Download wget to use going forward instead of bitsadmin

bitsadmin /create retro-tools
bitsadmin /transfer retro-tools https://eternallybored.org/misc/wget/1.20.3/64/wget.exe %~dp0\wget.exe

@echo off

:: Download 7zip stand-alone
echo "Downloading 7-zip..."
wget.exe https://www.7-zip.org/a/7z1900-x64.exe
echo "Installing 7-zip silently (UAC will still activate)"
start /wait 7z1900-x64.exe /S
:: Set PATH to make 7z referenceable
set PATH=%PATH%;C:\Program Files\7-Zip\

:: Download ffmpeg.zip, then extract it using 7zip CLI
echo "Downloading & extracting ffmpeg..."
wget.exe https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-latest-win64-static.zip
7z e ffmpeg-latest-win64-static.zip -o. ffmpeg.exe -r 

:: Download MAME Windows package and extract just CHDMAN.exe
echo "Downloading & extracting chdman v5 from MAME download..."
wget.exe https://github.com/mamedev/mame/releases/download/mame0219/mame0219b_64bit.exe
7z e mame0219b_64bit.exe -o. chdman.exe -r

:: clean up your mess
echo "Deleting temp files..."
del 7z1900-x64.exe
del ffmpeg-latest-win64-static.zip
del mame0219b_64bit.exe

echo "Done."