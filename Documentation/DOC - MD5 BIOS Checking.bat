Noteable links - 
https://helloacm.com/how-to-use-array-in-windows-batch-programming/
https://stackoverflow.com/questions/24234994/batch-script-create-dynamic-variable-names-or-array-in-for-loop



@echo off

:: 4/10/20 - Alright. So here's how it works - 
:: This file reads in both the config/config.bat file. You have to get the variables there; specific this to this? The rpibios is necessary to be set
:: The next file that is read is the config/bios.checksums.bat - In it is every BIOS value sets I have copied from the RPI wiki. As of writing this
:: I have the Dreamcast, hacked Dreamcast, and PSX BIOSes in the file. 
:: 
:: This is extremely inefficient, as it looks at the array entry, then runs through all the BIOS file against that entry. 
:: Get a match? Good. Print it with the name of the file
:: Not get a match? Move to the next CRC32 value in the array and run through the whole of the files again.
:: Given I can't figure out a way out of the loop without starting the whole process over, I have to resort to doing it this way,
:: though I know it's not the most efficient. 
::
:: I would like to ultimately change to recursing through the files, then through the array of CRC/MD5 values, and matching against those. I believe that would be faster 
:: than running the crc32.exe on every file 15 times. 
::
:: Maybe in version .2. 

:: helloacm.com batch programming tutorials
:: create arrays of structures in batch

:: 4/2/20 - this is a good start - the loop below will extract the data out of the variable at the '.', then name it. 
:: need to incorporate this into the loop about that is pulling all the files and running the CRC against it. %%B is the 
:: variable I need to compare against the values coming %bios.crc32% and/or %bios.MD5%

:: May need to rethink how I store the variables in conf/bios-checksums - instead of multiple arrays, just one large array with an output 
:: of what matches and what doesn't. Let the script just cycle through all the variables and determine what is good and what isn't. Test
:: on the CRC32 value and name the bios file we find. This will allow the bios files to be identified if the the CRC32 is different than
:: expected. 

:: ROM BIOS MD5 processing script - 

:: Notes in header here
:: Break this into per system or one large monolith?

call conf\config.bat
call conf\bios-checksums.bat

@echo off

:: declare the folder the BIOS files are in
:: Default will be %rpibios% in config.bat


setlocal enableDelayedExpansion

:getarray
:: The value 'len' is how many array entries there are. This is set in the bios-checksum file.
:: if the value of i equals the value of the variable 'len,' 
:: shut the program down. As of the original creation of this file, I have fifteen entries, though
:: 'len' will be significantly more. 
if %i% equ %len% goto :eof
:: read in the values from the array in bios-checksum.bat
for /F "usebackq delims==. tokens=1-3" %%j in (`set bios[!i!]`) do (
:: for delimiter equals a period, import in the three parts of the 
:: pseudo-array I conjured up in the bios-checksum.bat file
:: Work through the 'set bios number' array, and break it into parts
:: set j, k, and l the three different chunks of the array, and make them usable
:: here. Set k, then a number, the value stored in the quote array, as l
    set %%k!i!=%%l

:: Get the files here. For a file in the rpibios directory that has an extension of star,
:: set an array of values based on running crc32.exe against the file that gets pulled in
    for /r %rpibios% %%f in (*.*) do (
        for /f %%B in ('crc32.exe "%%f"') do (
:: When you get that CRC32 result, set these two values -
            set crc32value="%%B"
            set filelocation="%%f"

:: Now, compared the CRC32 values stored in the bios-checksums array against the 
:: output of running crc32.exe against the files in the rpibios folder            
            if /I !%%k%i%!==!crc32value! (
::if these values as strings match up, print them in the terminal 
            echo !filelocation! !crc32value!
            )
        )
    )
)
::increment the value of i plus one, so now the value goes up one 
set /a i+=1
:: go back to the start.
goto getarray



