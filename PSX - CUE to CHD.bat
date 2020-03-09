@echo off
REM for /r %%i in (*.cue, *.gdi) do chdman.exe createcd -i "%%i" -o "%%~ni.chd" --force
REM timeout /t 10

call config.bat
set rompath=%1

:: Handle compressed files
for /r %1 %%z in (*.7z, *.zip, *.rar) DO ( 
	if exist "%rpi%\%%~nz.chd" (
		echo  %%~nz.chd exists on %rpi%
		) else (
		7z x -y "%%z" -o%1
		chdman.exe createcd -i "%rompath:"=%\%%~nz.cue" -o "%rompath:"=%\%%~nz.chd" --force
		echo Copying %%~nz.chd to %rpi%  
		move /y "%rompath:"=%\%%~nz.chd" %rpi%
			
		del "%rompath:"=%\%%~nz.cue"
		del "%rompath:"=%\%%~nz.bin"
		)
	)

:: Handle uncompressed files
for /r %1 %%z in (*.cue, *.iso) DO (
	if exist "%rpi%\%%~nz.chd" (
		 %%~nz.chd exists on %rpi%
		) else (
		chdman.exe createcd -i "%rompath:"=%\%%~nz.cue" -o "%rompath:"=%\%%~nz.chd" --force
		echo Copying %%~nz.chd to %rpi%  
		move /y "%rompath:"=%\%%~nz.chd" %rpi%
		)
	)