@echo off
REM for /r %%i in (*.cue, *.gdi) do chdman.exe createcd -i "%%i" -o "%%~ni.chd" --force
REM timeout /t 10
call conf\config.bat
@echo off

set headertitle="PSX .cue to .chd"
set headerdesc="Converts Playstation 1 .cue and .bin files to an easy-to-manage .chd"
set headerlog=%0

call conf\log.bat
echo retro-tools v.%version% %headertitle% - %DATE%-%TIME%: > %log%

call conf\header.bat

setlocal enabledelayedexpansion
set rompath=%1
set "b="

:main
	echo -- ROMs location - [%1]
	set /p p=-- ^(c^)onvert or e^(x^)it: 

	if "%p%" == "x" (
		set "s="
		goto :EOF
		)
	if "%p%" == "c" ( 
		goto dothedancefandango	
	) 

:dothedancefandango
:: Handle compressed files
for /r %1 %%z in (*.7z, *.zip, *.rar) DO ( 
	if exist "%rpipsx%\%%~nz.chd" (
		echo  %%~nz.chd exists on %rpipsx%
		echo  %DATE% %TIME% - [INFO] - %%~nz.chd available >> %log%
		) else (
		7z x -y "%%z" -o%1
		bin\chdman.exe createcd -i "%rompath:"=%\%%~nz.cue" -o "%rompath:"=%\%%~nz.chd" --force
		echo Copying %%~nz.chd to %rpipsx%
		move /y "%rompath:"=%\%%~nz.chd" %rpipsx%
		if exist "%rpipsx%\%%~nz.chd" ( echo %DATE% %TIME% - [INFO] - Copied %%~nz.chd to %rpipsx% >> %log% )
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
		 echo %%~nz.chd exists on %rpipsx%
		 echo %DATE% %TIME% - [INFO] - %%~nz.chd available >> %log%
		) else (
		bin\chdman.exe createcd -i "%rompath:"=%\%%~nz.cue" -o "%rompath:"=%\%%~nz.chd" --force
		echo Copying %%~nz.chd to %rpipsx%  
		move /y "%rompath:"=%\%%~nz.chd" %rpipsx%
		if exist "%rpipsx%\%%~nz.chd" ( echo %DATE% %TIME% - [INFO] - Copied %%~nz.chd to %rpipsx% >> %log% )
		)
	)