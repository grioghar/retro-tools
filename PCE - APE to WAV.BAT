@echo off
REM How to run - PCE - APE to WAV.BAT <Root directory of PCE CD folders>
REM PC Engine CD ROMs can come with .cue/.iso/.ape files instead of the .wav files expected in the .cue files
REM This reads the PC Engine CD folder passed to it at command line, scans through all the folders, converting the .ape files to .wav
REM Later versions of this will also delete the .ape files, though it will give a choice.

set version=0.1a
set "p="
setlocal enabledelayedexpansion

set s="%~d0%~p0%~n0%~x0" "%1"
echo %s%
set s="%s%"
echo %s%
if s NEQ "%0 2>&1 | wtee %%~n0.txt" (
	"%~0" %1 2>&1 | wtee "%~n0.txt"
	pause
	)

:main 
	cls
	echo ---------------------------------------------
<<<<<<< Updated upstream
	echo --           retro-tools v.%version%          --
	echo --       PC Engine / TurboGraphix 16       --
	echo --             .APE ^=^> .WAV                --
	echo --               Converter                 --
	set /p p=-- ROM location[%1] or e^(x^)it: 

	if "%p%" == "" ( 
		set roms=%1 
	) else ( 
		set roms=%p% 
	)
	
	goto dothedancefandango

:dothedancefandango 
	for /r %roms% %%i in (*.ape) do ffmpeg.exe -y -i "%%i" "%%~dpi%%~ni.wav"
	goto main	
	
	
=======
	echo --          retro-tools v.%version%          
	echo --       PC Engine / TurboGraphix 16       
	echo --             .APE ^=^> .WAV                
	echo --               Converter                 
	echo -- ROMs location - [%1]
	set /p p=^(c^)onvert, ^(d^)elete .wavs, or e^(x^)it: 

	if "%p%" == "d" (
		goto deletethewavs
		)
	if "%p%" == "x" (
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
		ffmpeg.exe -hide_banner -loglevel panic -y -i "%%i" "%%~dpi%%~ni.wav"
		set /a counter += 1
		echo Converting %%~dpi%%~ni.wav...
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
>>>>>>> Stashed changes
