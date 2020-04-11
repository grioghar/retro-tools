:: @echo off
:: ROM BIOS MD5 processing script - 

:: Notes in header here
:: Break this into per system or one large monolith?

call conf\bios-checksums.bat

:: declare the folder the BIOS files are in
:: Default will be %rpibios% in config.bat

:: read in the files into an array
:: first instinct - for /r %%G in (*.bin) do set filename=%%~G
set rpibios="\\10.0.0.20\bios"

setlocal enableDelayedExpansion

for /r %rpibios% %%f in (*.*) do (
    :outerspace
    for /f %%B in ('crc32.exe "%%f"') do (
        
        set crc32value=%%B
        set len=4
        set i=0

        :test
        if !i! equ !len! goto outerspace 
        
        for /f "usebackq delims==. tokens=1-3" %%j in (`set bios[!i!]`) do (
	        set bios=%%l
            echo !crc32value!

            if /I !bios!==!crc32value! (
                echo "%%f" !crc32value!
            )
            
            echo !i!
            set /a i+=1
            goto test
        )
    )
)
:: helloacm.com batch programming tutorials
:: create arrays of structures in batch

:: 4/2/20 - this is a good start - the loop below will extract the data out of the variable at the '.', then name it. 
:: need to incorporate this into the loop about that is pulling all the files and running the CRC against it. %%B is the 
:: variable I need to compare against the values coming %bios.crc32% and/or %bios.MD5%

:: May need to rethink how I store the variables in conf/bios-checksums - instead of multiple arrays, just one large array with an output 
:: of what matches and what doesn't. Let the script just cycle through all the variables and determine what is good and what isn't. Test
:: on the CRC32 value and name the bios file we find. This will allow the bios files to be identified if the the CRC32 is different than
:: expected. 

