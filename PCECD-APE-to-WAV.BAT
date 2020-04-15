@echo off
REM How to run - PCE - APE to WAV.BAT Root directory of PCE CD folders
REM PC Engine CD ROMs can come with .cue/.iso/.ape files instead of the .wav files expected in the .cue files
REM This reads the PC Engine CD folder passed to it at command line, scans through all the folders, converting the .ape files to .wav
REM Later versions of this will also delete the .ape files, though it will give a choice.

call conf\config.bat
@echo off

set headertitle="PC Engine/TurboGraphix 16 .ape -> .wav"
set headerdesc="Converts .ape files to .wav for later conversion to .chd"
set headerlog=%0

call conf\log.bat
echo retro-tools v.%version% %headertitle% - %DATE%-%TIME%: > %log%

call conf\header.bat 
setlocal enabledelayedexpansion

:main 

	echo -- ROMs location - [%1]
	set /p p=-- ^(c^)onvert, ^(d^)elete .wavs, or e^(x^)it: 

	if "%p%" == "d" (
		set roms=%1
		goto deletethewavs
		)
	if "%p%" == "x" (
		set "s="
		goto :EOF
		)
	if "%p%" == "c" ( 
		set roms=%1
		goto dothedancefandango	
	) 
	
:dothedancefandango 
	for /r %roms% %%i in (*.ape) do (
		if exist "%%~dpi%%~ni.wav" (
		echo %%~dpi%%~ni.wav exists.
		echo %DATE% %TIME% - [INFO] - %%~dpi%%~ni.wav exists. > %log%
	) else (
		echo Converting %%~dpi%%~ni.wav...
		echo %DATE% %TIME% - [INFO] - Converting %%~dpi%%~ni.wav... > %log%
		bin\ffmpeg.exe -hide_banner -loglevel panic -y -i "%%i" "%%~dpi%%~ni.wav" > %log%
		set /a counter += 1
		echo !counter! files converted.
		)
	)
	echo Converted %counter% files!
	echo %DATE% %TIME% - [INFO] - Converted %counter% files! > %log%
	echo Press any key to go to main menu.
	pause
	goto main
	
:deletethewavs
	for /r %roms% %%i in (*.ape) do (
		if exist "%%~dpi%%~ni.wav" (
			del "%%~dpi%%~ni.wav"
			echo Deleted %%~dpi%%~ni.wav...
			echo %DATE% %TIME% - [INFO] - Deleted %%~dpi%%~ni.wav... > %log%
			set /a counter += 1
			echo !counter! files deleted.
			echo %DATE% %TIME% - [INFO] - !counter! files deleted. > %log%
		) else ( echo Checking %%~dpi... )
	)
	echo Converted %counter% files!
	echo %DATE% %TIME% - [INFO] - Converted %counter% files! > %log%

	echo Press any key to go to main menu.
	pause
	goto main