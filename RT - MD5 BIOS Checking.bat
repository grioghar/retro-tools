@echo off

call conf\config.bat
call conf\bios-checksums.bat

@echo off

setlocal enableDelayedExpansion

:getarray
if %i% equ %len% goto :eof

for /F "usebackq delims==. tokens=1-3" %%j in (`set bios[!i!]`) do (
    set %%k!i!="%%l"

    for /r %rpibios% %%f in (*.*) do (
        for /f %%B in ('crc32.exe "%%f"') do (
            set crc32value="%%B"
            set filelocation="%%f"
      
            if /I !%%k%i%!==!crc32value! (
            echo !filelocation! !crc32value!
            )
        )
        for /f %%A in ('md5.exe "%%y"') do (
            set md5value="%%A"
            set filelocation="%%y"
      
            if /I !%%k%i%!==!md5value! (
            echo !filelocation! !md5value!
            )
        )

    )
)

set /a i+=1
goto getarray



