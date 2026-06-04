REM Derive the rotation index from existing log files on disk, since logcount
REM is not persisted between separate script invocations.
REM Ensure the logs folder exists before counting/writing.
if not exist logs mkdir logs
REM Count existing logs\<headerlog>-*.log files; next index is count mod 5,
REM giving a 0-4 rotation that advances across runs.
set /a logcount=0
for /f %%F in ('dir /b "logs\%headerlog%-*.log" 2^>nul ^| find /c /v ""') do set /a logcount=%%F %% 5
set log="logs\%headerlog%-%logcount%.log"
