REM for /r %%i in (*.cue, *.gdi) do chdman.exe createcd -i "%%i" -o "%%~ni.chd" --force
REMtimeout /t 10

for /r %1 %%z IN (*.7z, *.zip) DO ( 
	7z x "%%z" -o%1
	FOR /r %%i IN (*.cue, *.gdi) DO (
		if exist "R:\psx\%%~ni.chd" (
		rem file exists
		) else (
		chdman.exe createcd -i "%%i" -o "%%~ni.chd" --force
	    move /y "%%~ni.chd" R:\psx
		)
	)	
)
