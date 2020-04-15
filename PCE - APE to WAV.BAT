@echo off
REM PC Engine CD ROMs can come with .cue/.iso/.ape files instead of the .wav files expected in the .cue files
REM This reads the PC Engine CD folder passed to it at command line, scans through all the folders, converting the .ape files to .wav
REM Later versions of this will also delete the .ape files, though it will give a choice.

call conf\config.bat

::SETLOCAL ENABLEDELAYEDEXPANSION

:main 
	cls
	echo ---------------------------------------------
	echo --           retro-tools v.%version%          --
	echo --       PC Engine / TurboGraphix 16       --
	echo --             .APE ^=^> .WAV                --
	echo --               Converter                 --
	echo -- ROMs location - %1 
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
		echo "file exists"
	) else (
		bin\ffmpeg.exe -y -i "%%i" "%%~dpi%%~ni.wav"
		)
	)

	goto main
	
:deletethewavs
	for /r %roms% %%i in (*.ape) do (
		if exist "%%~dpi%%~ni.wav" (
			del "%%~dpi%%~ni.wav"
			echo "Deleting %%~dpi%%~ni.wav..."
			timeout 1
	) else ( echo "Checking %%~dpi..." )
	)
	
	goto main
	
	