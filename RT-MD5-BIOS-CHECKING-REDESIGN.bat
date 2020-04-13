@echo off

call conf\config.bat
call conf\bios-checksums.bat

@echo off


set LOGFILE_DATE=%DATE:~6,4%.%DATE:~3,2%.%DATE:~0,2%
set LOGFILE_TIME=%TIME:~0,2%.%TIME:~3,2%

set /a logcount +=1
if %logcount% == 5 ( set /a logcount=0)
set log="logs\%~n0-%logcount%.log"

echo "retro-tools BIOS Check Log File %LOGFILE_DATE%-%LOGFILE_TIME%:" > %log%
echo -^| name ^|------^| CRC32 ^|--^| MD5 ^|----------------------------^| Description ^|-------------- > %log%

setlocal enableDelayedExpansion

for /r %rpibios% %%f in (*.*) do (
    crc32.exe "%%f" -noformat > crc.txt
    set /p crc32value=<crc.txt
    REM set crc32value="!crc32value!"
    md5.exe "%%f" -noformat > md5.txt
    set /p md5value=<md5.txt

    set filename=%%~nf%%~xf

    echo "File: !filename!"
REM echo "CRC32: !crc32value!" + "MD5: !md5value!"

    call :readbioschecksums
)

:readbioschecksums
    if %i% NEQ %len% (
        for /F "usebackq delims==. tokens=1-3" %%j in (`set bios[!i!]`) do (
            set %%k!i!=%%l
            set name=!name%i%!
            set extension=!ext%i%!
            set crc32=!crc32%i%!
            set md5=!md5%i%!
            set description=!desc%i%!

            REM Something is amiss here. Trying to use the periods in the variables get swallowed up in the delimiter. Fuck.

            if !%%k%i%!==!crc32value! ( 
                echo Logging to %log%: !name!.!extension! - !crc32! - !md5! - !description!
                echo !name!.!extension! -^> !crc32! ^<- !md5! - !description! >> %log%
            ) else (
            if !%%k%i%!==!md5match! ( 
                echo Logging to %log%: !name!.!extension! - !crc32! - !md5! - !description!
                echo !name!.!extension! -^> !crc32! ^<- !md5! - !description! >> %log%
            ) else (
            if /I !%%k%i%!==!filename! ( 
                echo Logging to %log%: !name!.!extension! - !crc32! - !md5! - !description!
                echo !name!.!extension! -^> !crc32! ^<- !md5! - !description! >> %log%
                )))
        )
    set /a i+=1
    goto readbioschecksums
    ) else ( set /a i=0)