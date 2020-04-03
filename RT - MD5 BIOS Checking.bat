@echo off
:: ROM BIOS MD5 processing script - 

:: Notes in header here
:: Break this into per system or one large monolith?

call conf/bios-checksums.bat

:: declare the folder the BIOS files are in
:: Default will be %rpibios% in config.bat

:: read in the files into an array
:: first instinct - for /r %%G in (*.bin) do set filename=%%~G
set rpibios="\\10.0.0.20\bios"

setlocal enableDelayedExpansion
set ID=0

for /r %rpibios% %%G in (*.bin, *.zip) do (
    echo %%G
    set fn[!ID!]=%%G
    set /A ID+=1
)

echo !fn[%ID%]!
for /l %%y in (1,1,%ID%) do (
    echo !fn[!!ID!!]!
    echo %%y
)

:: match files to names of defined files

:: test for CRC32 and MD5 and compare

:: CertUtil -hashfile <path to file> MD5

:: output results