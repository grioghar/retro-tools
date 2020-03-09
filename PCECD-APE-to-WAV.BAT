@echo off
REM How to run - PCE - APE to WAV.BAT Root directory of PCE CD folders
REM PC Engine CD ROMs can come with .cue/.iso/.ape files instead of the .wav files expected in the .cue files
REM This reads the PC Engine CD folder passed to it at command line, scans through all the folders, converting the .ape files to .wav
REM Later versions of this will also delete the .ape files, though it will give a choice.

set version=0.1a
set "p="
setlocal enabledelayedexpansion

set /a s += 1 
set /a logcount += 0
for /r %~dp0 %%l in (*.log) do (
	set /a logcount += 1
	)

if %s% == 1 (
<<<<<<< Updated upstream
	%~0 %1 2>&1 | wtee "%~n0 - %logcount%.log"
=======
	%~0 %1 2>&1 | wtee "logs\%~n0 %logcount%.log"
>>>>>>> Stashed changes
		)
	
:main 
	
	cls
	echo ---------------------------------------------
	echo --          retro-tools v.%version%          
	echo --       PC Engine / TurboGraphix 16       
	echo --             .APE ^=^> .WAV                
	echo --               Converter                 
	echo -- ROMs location - [%1]
	set /p p=^(c^)onvert, ^(d^)elete .wavs, or e^(x^)it: 

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
	) else (
		echo Converting %%~dpi%%~ni.wav...
		ffmpeg.exe -hide_banner -loglevel panic -y -i "%%i" "%%~dpi%%~ni.wav"
		set /a counter += 1
		echo !counter! files converted.
		)
	)
	echo Converted %counter% files!
	echo Press any key to go to main menu.
	pause
	goto main
	
:deletethewavs
	for /r %roms% %%i in (*.ape) do (
		if exist "%%~dpi%%~ni.wav" (
			del "%%~dpi%%~ni.wav"
			echo Deleting %%~dpi%%~ni.wav...
			set /a counter += 1
			echo !counter! files deleted.
		) else ( echo Checking %%~dpi... )
	)
	echo Converted %counter% files!
	echo Press any key to go to main menu.
	pause
	goto main