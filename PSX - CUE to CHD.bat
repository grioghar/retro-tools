@echo off
REM for /r %%i in (*.cue, *.gdi) do chdman.exe createcd -i "%%i" -o "%%~ni.chd" --force
REM timeout /t 10

set "PATH=%PATH%;C:\Program Files\7-Zip\"
set rpie=R:\psx
set rompath=%1

::set rompath=%rompath:"=%
for /r %1 %%z in (*.7z, *.zip, *.rar) DO ( 
	if exist "%rpie%\%%~nz.chd" (
		rem file exists
		) else (
		7z x -y "%%z" -o%1
		chdman.exe createcd -i "%rompath:"=%\%%~nz.cue" -o "%rompath:"=%\%%~nz.chd" --force
		echo Copying %%~nz.chd to %rpie%  
		move /y "%rompath:"=%\%%~nz.chd" %rpie%
			
		del "%rompath:"=%\%%~nz.cue"
		del "%rompath:"=%\%%~nz.bin"
		)
	)

