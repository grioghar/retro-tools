@echo off
REM for /r %%i in (*.cue, *.gdi) do chdman.exe createcd -i "%%i" -o "%%~ni.chd" --force
REM timeout /t 10

setlocal enabledelayedexpansion
call conf\config.bat
set rompath=%1
set "b="

:: Handle compressed files
for /r %1 %%z in (*.7z, *.zip, *.rar) DO ( 
	if exist "%rpipsx%\%%~nz.chd" (
		echo  %%~nz.chd exists on %rpipsx%
		) else (
		7z x -y "%%z" -o%1
		chdman.exe createcd -i "%rompath:"=%\%%~nz.cue" -o "%rompath:"=%\%%~nz.chd" --force
		echo Copying %%~nz.chd to %rpipsx%
		move /y "%rompath:"=%\%%~nz.chd" %rpipsx%
			for /r %1 %%b in (*.cue, *.bin) DO (
				del %%b
				echo Deleted %%b
				set "b="
			)
		)
	)

:: Handle uncompressed files
for /r %1 %%z in (*.cue, *.iso) DO (
	if exist "%rpipsx%\%%~nz.chd" (
		 %%~nz.chd exists on %rpipsx%
		) else (
		chdman.exe createcd -i "%rompath:"=%\%%~nz.cue" -o "%rompath:"=%\%%~nz.chd" --force
		echo Copying %%~nz.chd to %rpipsx%  
		move /y "%rompath:"=%\%%~nz.chd" %rpipsx%
		)
	)