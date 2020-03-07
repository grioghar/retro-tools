@echo off
REM PC Engine CD ROMs can come with .cue/.iso/.ape files instead of the .wav files expected in the .cue files
REM This reads the PC Engine CD folder passed to it at command line, scans through all the folders, converting the .ape files to .wav
REM Later versions of this will also delete the .ape files, though it will give a choice.

set version=0.1a
set "p="

::SETLOCAL ENABLEDELAYEDEXPANSION

:main 
	cls
	echo ---------------------------------------------
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
	
	