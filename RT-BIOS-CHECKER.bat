@echo off

REM Set the headertitle, headerdesc (description), and the headerlog (which should be the filename)
REM These variables are passed to log.bat for creating log files & header.bat for the header to each file
call conf\config.bat
call conf\bios-checksums.bat
@echo off

set headertitle="BIOS Checker"
set headerdesc="Checks CRC32/MD5 of BIOS files"
set headerlog=%0

call conf\log.bat
call conf\header.bat 


echo retro-tools v.%version% %headertitle% - %DATE%-%TIME%: > %log%

setlocal enableDelayedExpansion

for /r %rpibios% %%f in (*.*) do (
    bin\crc32.exe "%%f" -noformat > %TEMP%\crc.txt
    set /p crc32value=<%TEMP%\crc.txt
    REM set crc32value="!crc32value!"
    bin\md5.exe "%%f" -noformat > %TEMP%\md5.txt
    set /p md5value=<%TEMP%\md5.txt

    set file=%%~nf%%~xf
    set filename=%%~nf

    echo "File: !file!"
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
            set _description=!desc%i%:,=.!
            set description=!_description!

            REM Something is amiss here. Trying to use the periods in the variables get swallowed up in the delimiter. Fuck.

            if !%%k%i%!==!crc32value! (
                echo ------------------------------------------------------------------------------------------------------------------------------
                echo Match found: Filename: !file! - Reference name: !name!.!extension! -^> !crc32! ^<- !md5! 
                echo Description: !description!
                echo %DATE% %TIME% - [INFO] - Filename: !file! - Reference name: !name!.!extension! -^> !crc32! ^<- !md5! - !description! >> %log%
                echo ------------------------------------------------------------------------------------------------------------------------------
                set /a x=1
            )
            if not !x!==1 if /I !%%k%i%!==!md5value! (
                echo ------------------------------------------------------------------------------------------------------------------------------ 
                echo Match found: Filename: !file! - Reference name: !name!.!extension! - !crc32! -^> !md5! ^<- 
                echo Description: !description!
                echo %DATE% %TIME% - [INFO] - Filename: !file! - Reference name: !name!.!extension! - !crc32! -^> !md5! ^<- !description! >> %log%
                echo ------------------------------------------------------------------------------------------------------------------------------
                set /a x=2
            ) 
            if not !x!==2 if not !x!==1 if /I !%%k%i%!==!filename! (
                echo ------------------------------------------------------------------------------------------------------------------------------ 
                echo Match found: Filename: !file! - Reference name: ^>!name!.!extension! ^<- !crc32! - !md5!
                echo Description: !description!
                echo ------------------------------------------------------------------------------------------------------------------------------
                echo %DATE% %TIME% - [WARN] - Filename: !file! - Reference name: -^> !name!.!extension! ^<- !crc32! - !md5! - !description! >> %log%
                echo %DATE% %TIME% - [WARN] - File name match found only. Unable to match CRC32 or MD5. Verify integrity of file. >> %log%
                echo %DATE% %TIME% - [WARN] - If file is correct/working, please email these three WARN lines to thegrio at gmail dot com >> %log%
                )
        )
    set /a i+=1
    set /a x=0
    goto readbioschecksums
    ) else ( set /a i=0)