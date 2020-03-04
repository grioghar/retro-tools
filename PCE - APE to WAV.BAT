REM PC Engine CD ROMs can come with .cue/.iso/.ape files instead of the .wav files expected in the .cue filesR
REM This reads the PC Engine CD folder, scans through all the folders, converting the .ape files to .wav
REM Later versions of this will also delete the .ape files, though it will give a choice.


:: This line sets the variable of where the folder with the ROMs are. 
set pcenginecdpath="V:\PCE torrent\"
:: Runs FOR loop through every file and sub-folder, looking for .ape file.
:: Converts the .ape file to .wav, leaving the .ape file (for now). 
for /r %pcenginecdpath% %%i in (*.ape) do ffmpeg.exe -y -i "%%i" "%%~ni.wav"

::NOTE - Later versions give option to delete either individual files, or all .ape files after script run.

