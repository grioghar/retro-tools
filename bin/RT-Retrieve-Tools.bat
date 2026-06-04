@echo off
REM using local tools, download chdman, ffmpeg, and anything else needed
REM Download wget using Windows BITSadmin
REM bitsadmin /addfile retro-tools https://eternallybored.org/misc/wget/1.20.3/64/wget.exe wget.exe
REM bitsadmin /SetCredentials thisissomejobname Server BASIC somehttpuser somehttppassword

call ../conf/config.bat

:: The retro-tools equivalent of using IE to download FF
:: Download wget to use going forward instead of bitsadmin

if exist wget.exe (
	echo wget.exe already downloaded
	) else (
		bitsadmin /create retro-tools
		bitsadmin /transfer retro-tools https://eternallybored.org/misc/wget/1.21.4/64/wget.exe %~dp0\wget.exe
		)

:: create the logs folders
mkdir ../logs

:: Download wtee.exe from Google
if exist wtee.exe (
	echo wtee.exe already downloaded
	) else (
		wget.exe https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/wintee/wtee.exe
		)
		
set /a s += 1 
set "logcount="
:: echo %~dp0
for /r %~dp0 %%l in (*.log) do (
	set /a logcount += 1
	)

if %s% == 1 (
	%~0 2>&1 | wtee "logs\%~n0-%logcount%.log"
	) else (
		set "s="
		goto :EOF
		)

:: Download 7zip stand-alone
if exist 7z2409-x64.exe (
	echo 7z2409-x64.exe already downloaded
	) else (
		echo "Downloading 7-zip..."
		wget.exe https://www.7-zip.org/a/7z2409-x64.exe
		echo Installing 7-zip silently ^(UAC will still activate^)
		start /wait 7z2409-x64.exe /S
		)
set "PATH=%PATH%;C:\Program Files\7-Zip\"
:: Download ffmpeg.zip, then extract it using 7zip CLI
if exist ffmpeg.exe (
	echo ffmpeg.exe already downloaded
	) else (
		echo "Downloading & extracting ffmpeg..."
		wget.exe https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip
		7z e ffmpeg-release-essentials.zip -o. ffmpeg.exe -r
		)
		
:: Download MAME Windows package and extract just CHDMAN.exe
if exist chdman.exe (
	echo chdman.exe already downloaded
	) else (
		echo "Downloading & extracting chdman v5 from MAME download..."
		wget.exe https://github.com/mamedev/mame/releases/download/mame0272/mame0272b_64bit.exe
		7z e mame0272b_64bit.exe -o. chdman.exe -r
		)

:: Download 64-bit psftp.exe tp root directory
REM NOTE: crc32.exe/md5.exe come from a flaky, insecure (http) sourceforge mirror.
REM On modern Windows, `certutil -hashfile <file> MD5` is a built-in alternative for MD5
REM (certutil also does SHA, but NOT CRC32, so crc32.exe is still needed here).
REM Also, modern Windows ships `curl.exe` built in, which could replace wget/bitsadmin
REM entirely in a future rewrite of this script.
if exist crc32.exe (
	echo crc32.exe already downloaded
	) else (
		echo "Downloading crc32..."
		wget.exe http://esrg.sourceforge.net/utils_win_up/md5sum/crc32.exe
		)

if exist md5.exe (
	echo md5.exe already downloaded
	) else (
		echo "Downloading md5..."
		wget.exe http://esrg.sourceforge.net/utils_win_up/md5sum/md5.exe
		)

:: Download 64-bit psftp.exe tp root directory
if exist psftp.exe (
	echo psftp.exe already downloaded
	) else (
		echo "Downloading psftp..."
		wget.exe https://the.earth.li/~sgtatham/putty/latest/w64/psftp.exe
		)
		
:: clean up your mess
echo "Deleting temp files..."
del 7z2409-x64.exe
del ffmpeg-release-essentials.zip
del mame0272b_64bit.exe
set "s="
echo "Done."