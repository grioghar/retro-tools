Foreword - 

I am extremely excited to bring to the retropie community my project, retro-tools. I stand on the shoulders of those who came before
as any good software iterations come. 

This is my first attempt at a software/script project, so please, if you're analyzing the code, have some forgiveness. I'm not naturally 
a programmer.

About - 

retro-tools came about from need of managing the large amounts of files one collects when building a retropie. I was trying to keep my 
Playstation 1 roms straight, and needed a way to convert them and test if I had the files already. 

I also found myself curious about the BIOS files I had installed, and whether these were legitimate, or otherwise. 

retro-tools grew out of that. 

Requirements -

Currently, this requires Windows to run. There is also the expectation that the optional package enabling SMB on the retropie is installed, and 
logged in as the 'pi' user. This has not been tested any other way. 

How To Use - 

First, go into conf/config.bat and set your variables. This should be fairly obvious. Be sure to save after the variables are set. 
Next, go into bin/ and run RT-Retrieve-Tools.bat. This will grab all the .exes needed for retro-tools to run

--- RT-BIOS-CHECKER.bat --- 
requires no extra command-line switches. This will use conf/bios-checksums.bat to determine if the BIOS files on your retropie are
valid per the official retropie's Github pages. If you have a BIOS file you know is correct, please, send me the contents of your 
logs/RT-BIOS-CHECKER.bat-*.log files with a note on what is correct. 

--- DC-CUE-or-GDI-to-CHD.bat "<ROM location folder>" ---
Append the folder location for the compressed/uncompressed Dreamcast ROMs. The script first tests the location of the ROMs on the retropie to check
if the .chd file already exists. If so, it will announce on the console, and write to the logs/DC-CUE-or-GDI-to-CHD.bat-*.log file. 
If the .chd does not exist on the retropie, the script will iterate through the folders, unzip if necessary, then compress the .cue or .gdi file and all supporting files into a single .chd file. Then it is copied over to the retropie, logged to the log file, and moves to the next file. 

--- Ad Infinitum ---
This is the same for PCECD-CUE-to-CHD.bat, PSX-CUE-to-CHD.bat, and SEGACD-CHD-CONVERTER.bat

--- PCECD-APE-to-WAV.bat ---
This is a special situation I found necessary for the PC Engine CD/TurboGraphix CD-ROM files. The ROMs came with the .cue and .bin files, but where the .cue files had
.WAV files declared for use, someone had converted these into .APE files. This undoes this, and makes the ROMs both now playable, and compressable to .chd. 

--- License ---
If this breaks everything in your house, sets your car on fire, or kicks your dog, I am in no way responsible. Use at your own risk. 

Consider this under a GPL 3.0 License. I'll look deeper into whether I want that in the future.

--- TODO ---
Lots. I plan on making a wizard to set all the config data, and run the retrievals, etc. I also plan on merging all the files into one and making the whole thing menu-driven. This is the first release, so it only gets better from here. 
