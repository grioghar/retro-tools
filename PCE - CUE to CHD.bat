REM for /r %%i in (*.ape) do ren "%%i" "%%.wav"
REM forfiles /S /M *.wav /C "cmd /c del @file @fname.wav"
REM for /r %%i in (*.cue, *.gdi) do chdman.exe createcd -i "%%i" -o "%%~ni.chd"
REM  timeout /t 10

FOR /r %%i IN (*.cue, *.gdi) DO (
  chdman.exe createcd -i "%%i" -o "%%~ni.chd" --force
  move /y "%%~ni.chd" R:\pcengine

)