@echo off
:: create an array of known-good BIOS files. These aren't going to change. 

:: IMPORTANT NOTE!!! All set variables must have no spaces to work correctly.
:: Given how the variable array is handled, in the description, all periods must be replaced with commas.  

:: Global variables
set i=0
set len=101

:: 3DO

    set bios[16].name=panafz10
    set bios[16].ext=bin
    set bios[16].CRC32=C8C8FF89
    set bios[16].MD5=f47264dd47fe30f73ab3c010015c155b
    set bios[16].desc="for 3DO emulator"

:: Amiga

    set bios[17].name=kick34005.A500
    set bios[17].ext=A500
    set bios[17].CRC32=
    set bios[17].MD5=82a21c1890cae844b3df741f2762d48d
    set bios[17].desc="Amiga 500 - Kickstart v1,3 (Rev, 34,005)"
    set bios[18].name=kick40063.A600
    set bios[18].ext=A600
    set bios[18].CRC32=
    set bios[18].MD5=e40a5dfb3d017ba8779faba30cbd1c8e
    set bios[18].desc="Amiga 600 - Kickstart v3,1 (Rev, 40,063)"
    set bios[19].name=kick40068.A1200
    set bios[19].ext=A1200
    set bios[19].CRC32=
    set bios[19].MD5=646773759326fbac3b2311fd8c8793ee
    set bios[19].desc="Amiga 1200 - Kickstart v3,1 (Rev, 40,068)"

:: ATARI 800/5200

    set bios[20].name=ATARIXL.ROM
    set bios[20].ext=ROM
    set bios[20].CRC32=1f9cd270
    set bios[20].MD5=06daac977823773a3eea3422fd26a703
    set bios[20].desc="BIOS for Atari XL/XE OS - Version BB01R2 OS from Atari 80L and early Atari 65XE/13E"
    set bios[21].name=ATARIBAS.ROM
    set bios[21].ext=ROM    
    set bios[21].CRC32=7d684184
    set bios[21].MD5=0bac0c6a50104045d902df4503a4c30b
    set bios[21].desc="BIOS for the BASIC interpreter - Basic Rev, C - Atari BASIC from 80L and all Atari XE/XEGS - also sold on cartridge"
    set bios[22].name=ATARIOSA.ROM
    set bios[22].ext=ROM
    set bios[22].CRC32=72b3fed4
    set bios[22].MD5=eb1f32f5d9f382db1bbfb8d7f9cb343a
    set bios[22].desc="BIOS for Atari 400/800 PAL - OS A from PAL Atari 400/800"
    set bios[23].name=ATARIOSB.ROM
    set bios[23].ext=ROM

    set bios[23].CRC32=3e28a1fe
    set bios[23].MD5=a3e8d617c95d08031fe1b20d541434b2
    set bios[23].desc="BIOS for Atari 400/800 NTSC - PCXFormer hack ROM, based on LINBUG version; a bugfixed NTSC OS B for 400/800"
    set bios[24].name=5200.rom
    set bios[24].ext=rom
    set bios[24].CRC32=4248d3e3
    set bios[24].MD5=281f20ea4320404ec820fb7ec0693b38
    set bios[24].desc="BIOS for the Atari 5200 - Original (not Rev, A) BIOS from 4-port and early 2-port 5200"

:: ATARI 7800

    set bios[25].name=7800 BIOS (U).rom
    set bios[25].ext=rom
    set bios[25].CRC32=
    set bios[25].MD5=
    set bios[25].desc="This BIOS is optional if you want the Atari Logo at the beginning of games, Note: if this BIOS is enabled PAL ROMs will not work so use it accordingly"

:: ATARI LYNX

    set bios[26].name=lynxboot.img
    set bios[26].ext=img
    set bios[26].CRC32=0d973c9d
    set bios[26].MD5=fcd403db69f54290b51035d82f835e7b
    set bios[26].desc="Only for lr-beetle-lynx"

:: COCO (Tandy)

    set bios[27].name=bas13.rom
    set bios[27].ext=rom
    set bios[27].CRC32=
    set bios[27].MD5=
    set bios[27].desc="For XRoar"

:: Colecovision

    set bios[28].name=coleco.rom
    set bios[28].ext=rom
    set bios[28].CRC32=
    set bios[28].MD5=
    set bios[28].desc="For lr-blueMSX BIOS"

::Dragon

    set bios[74].name=d32.rom
    set bios[74].ext=rom
    set bios[74].CRC32=
    set bios[74].MD5=
    set bios[74].desc="For XRoar"

:: Dreamcast

    set bios[0].name=dc_boot.bin
    set bios[0].ext=bin
    set bios[0].CRC32=89F2B1A1
    set bios[0].MD5=e10c53c2f8b90bab96ead2d368858623 
    set bios[0].desc="Dreamcast - Region: World"
    set bios[1].name=dc_flash.bin
    set bios[1].ext=bin
    set bios[1].CRC32=C611B498
    set bios[1].MD5=0a93f7940c455905bea6e392dfde92a4 
    set bios[1].desc="Dreamcast - Region: USA"
    set bios[2].name=dc_flash.bin
    set bios[2].ext=bin
    set bios[2].CRC32=B7E5AEEB
    set bios[2].MD5=23df18aa53c8b30784cd9a84e061d008 
    set bios[2].desc="Dreamcast - Region: Europe"
    set bios[3].name=dc_flash.bin
    set bios[3].ext=bin
    set bios[3].CRC32=5F92BF76
    set bios[3].MD5=69c036adfca4ebea0b0c6fa4acfc8538
    set bios[3].desc="Dreamcast - Region: Japan"

:: Hacked Dreamcast BIOS

    set bios[4].name=dc_boot.bin
    set bios[4].ext=bin
    set bios[4].CRC32=61D5613F
    set bios[4].MD5=d407fcf70b56acb84b8c77c93b0e5327
    set bios[4].desc="Dreamcast - Hack - Region-free"
    set bios[5].name=dc_flash.bin
    set bios[5].ext=bin
    set bios[5].CRC32=E0D202A2
    set bios[5].MD5=93a9766f14159b403178ac77417c6b68
    set bios[5].desc="Dreamcast - Hack - Region-free"
    set bios[6].name=dc_boot.bin
    set bios[6].ext=bin
    set bios[6].CRC32=558F456E
    set bios[6].MD5=d552d8b577faa079e580659cd3517f86
    set bios[6].desc="Dreamcast - atreyu187 Hack - Region-free"
    set bios[7].name=dc_flash.bin
    set bios[7].ext=bin
    set bios[7].CRC32=BDA0E9AA
    set bios[7].MD5=74e3f69c2bb92bc1fc5d9a53biosf6ffe2
    set bios[7].desc="Dreamcast - atreyu187 Hack - Region-free"
    set bios[8].name=naomi.zip
    set bios[8].ext=zip
    set bios[8].CRC32=C295A8C2
    set bios[8].MD5=eb4099aeb42ef089cfe94f8fe95e51f6
    set bios[8].desc="Dreamcast - NAOMI BIOS - Region: World"
    set bios[9].name=awbios.zip
    set bios[9].ext=zip    
    set bios[9].CRC32=AB628024
    set bios[9].MD5=0ec5ae5b5a5c4959fa8b43fcf8687f7c
    set bios[9].desc="Dreamcast - Atomiswave BIOS - Region: World"

    set bios[29].name=dc_flash.bin
    set bios[29].ext=bin
    set bios[29].CRC32=
    set bios[29].MD5=2f818338f47701c606ade664a3e16a8a
    set bios[29].desc="Dreamcast - Generated from https://retropie,org,uk/forum/post/53941"

:: Famicom

    set bios[31].name=disksys.rom
    set bios[31].ext=rom
    set bios[31].CRC32=5e607dcf
    set bios[31].MD5=ca30b50f880eb660a320674ed365ef7a
    set bios[31].desc="Famicom - [BIOS] Family Computer Disk System (Japan) (Rev 1)"

:: Game Boy Advance

    set bios[75].name=gba_bios.bin
    set bios[75].ext=bin
    set bios[75].CRC32=81977335
    set bios[75].MD5=a860e8c0b6d573d191e4ec7db1b1e4f6
    set bios[75].desc="[BIOS] Game Boy Advance (World),gba"

:: Game Boy/Super Game Boy

    set bios[32].name=gb_bios.bin
    set bios[32].ext=bin
    set bios[32].CRC32=59C8598E
    set bios[32].MD5=32fbbd84168d3482956eb3c5051637f5
    set bios[32].desc="[BIOS] Nintendo Game Boy Boot ROM (World) (Rev 1),gb, lr-gambatte can load external BIOS for Game Boy (gb_bios.bin)"

    set bios[33].name=sgb_bios.bin
    set bios[33].ext=bin
    set bios[33].CRC32=EC8A83B9
    set bios[33].MD5=d574d4f9c12f305074798f54c091a8b4
    set bios[33].desc="SGB-CPU (World) (Enhancement Chip).bin. lr-mgba can load external BIOS for Game Boy (gb_bios.bin) and Super Game Boy (sgb_bios,bin)"

:: Game Boy Color

    set bios[34].name=gbc_bios.bin
    set bios[34].ext=bin    
    set bios[34].CRC32=41884E46
    set bios[34].MD5=dbfce9db9deaa2567f6a84fde55f9680
    set bios[34].desc="[BIOS] Nintendo Game Boy Color Boot ROM (World),gbc, lr-mgba can load external BIOS for Game Boy Color(gbc_bios,bin) and Super Game Boy (sgb_bios,bin)"

:: Game Gear

    set bios[30].name=bios.gg
    set bios[30].ext=gg
    set bios[30].CRC32=
    set bios[30].MD5=62e761035cb657903761800f4437b8af
    set bios[30].desc="For lr-genesis-plus-gx"

:: Intellivision

    set bios[35].name=exec.bin
    set bios[35].ext=bin
    set bios[35].CRC32=
    set bios[35].MD5=62e761035cb657903761800f4437b8af
    set bios[35].desc="Executive ROM. lr-freeintv & jzIntv require two Intellivision BIOS files (exec,bin & grom,bin)"

    set bios[36].name=grom.bin
    set bios[36].ext=bin
    set bios[36].CRC32=
    set bios[36].MD5=0cd5946c6473e42e8e4c2137785e427f
    set bios[36].desc="Graphics ROM - 213 predefined character images and some EXEC routines; Tutorvision variant, lr-freeintv  & jzIntv require two Intellivision BIOS files (exec,bin & grom,bin)."

    set bios[37].name=ECS.BIN
    set bios[37].ext=BIN
    set bios[37].CRC32=
    set bios[37].MD5=2e72a9a2b897d330a35c8b07a6146c52
    set bios[37].desc="Entertainment Computer System (ECS) ROM - additional EXEC routines, the BASIC programming interpreter, and graphics of musical notes"

    set bios[38].name=IVOICE.BIN
    set bios[38].ext=BIN    
    set bios[38].CRC32=
    set bios[38].MD5=2e72a9a2b897d330a35c8b07a6146c52
    set bios[38].desc="Intellivoice RESROM - resident ROM containing common speech words and phrases as well as program instructions"

:: Macintosh 

    set bios[39].name=vMac.ROM
    set bios[39].ext=ROM    
    set bios[39].CRC32=
    set bios[39].MD5=
    set bios[39].desc="vMac,ROM (Macintosh Plus Firmware)"

:: Master System

    set bios[40].name=bios_E.sms
    set bios[40].ext=sms    
    set bios[40].CRC32=
    set bios[40].MD5=
    set bios[40].desc="Sega Master System: for use in lr-genesis-plus-gx"

    set bios[41].name=bios_U.sms
    set bios[41].ext=sms
    set bios[41].CRC32=
    set bios[41].MD5=
    set bios[41].desc="Sega Master System: for use in lr-genesis-plus-gx"

    set bios[42].name=bios_J.sms
    set bios[42].ext=sms
    set bios[42].CRC32=
    set bios[42].MD5=
    set bios[42].desc="Sega Master System: for use in lr-genesis-plus-gx"

:: Mega CD/Sega CD

    set bios[43].name=us_scd1_9210.bin
    set bios[43].ext=bin
    set bios[43].CRC32=C6D10268
    set bios[43].MD5=2efd74e3232ff260e371b99f84024f7f
    set bios[43].desc="[BIOS] Sega CD (USA) (v1,10),md - file may be named bios_CD_U,bin"
    set bios[44].name=eu_mcd1_9210.bin
    set bios[44].ext=bin
    set bios[44].CRC32=529AC15A
    set bios[44].MD5=e66fa1dc5820d254611fdcdba0662372
    set bios[44].desc="[BIOS] Mega-CD (Europe) (v1,00),md - file may be named bios_CD_E,bin "
    set bios[45].name=jp_mcd1_9112.bin
    set bios[45].ext=bin
    set bios[45].CRC32=
    set bios[45].MD5=bdeb4c47da613946d422d97d98b21cda
    set bios[45].desc="[BIOS] Mega-CD (Asia) (v1,00S),md - file may be named bios_CD_J,bin"

:: Megadrive

    set bios[46].name=bios_MD.bin
    set bios[46].ext=bin    
    set bios[46].CRC32=
    set bios[46].MD5=
    set bios[46].desc="lr-genesis-plus-gx can load MegaDrive TMSS startup ROM (bootrom)"

:: MSX - reconsider this configuration

:: Nintendo DS

    set bios[47].name=nds_bios_arm7.bin
    set bios[47].ext=bin
    set bios[47].CRC32=
    set bios[47].MD5=
    set bios[47].desc="for DraStic: nds_bios7,bin, nds_bios9,bin & nds_firmware,bin"
    set bios[48].name=nds_bios_arm9.bin
    set bios[48].ext=bin
    set bios[48].CRC32=
    set bios[48].MD5=
    set bios[48].desc="for DraStic: nds_bios7,bin, nds_bios9,bin & nds_firmware,bin"
    set bios[49].name=nds_firmware.bin
    set bios[49].ext=bin   
    set bios[49].CRC32=
    set bios[49].MD5=
    set bios[49].desc="for DraStic: nds_bios7,bin, nds_bios9,bin & nds_firmware,bin"
    set bios[50].name=bios7.bin
    set bios[50].ext=bin
    set bios[50].CRC32=
    set bios[50].MD5=
    set bios[50].desc="lr-desmume can load BIOS file: bios7,bin, bios9,bin & firmware,bin"
    set bios[51].name=bios9.bin
    set bios[51].ext=bin
    set bios[51].CRC32=
    set bios[51].MD5=
    set bios[51].desc="lr-desmume can load BIOS file: bios7,bin, bios9,bin & firmware,bin"
    set bios[52].name=firmware.bin
    set bios[50].ext=bin   
    set bios[52].CRC32=
    set bios[52].MD5=
    set bios[52].desc="lr-desmume can load BIOS file: bios7,bin, bios9,bin & firmware,bin"

:: Nintendo Entertainment System (NES)

    set bios[53].name=disksys.rom
    set bios[53].ext=rom
    set bios[53].CRC32=5e607dcf
    set bios[53].MD5=ca30b50f880eb660a320674ed365ef7a
    set bios[53].desc="[BIOS] Family Computer Disk System (Japan) (Rev 1)"

    set bios[54].name=fdsbios.zip
    set bios[54].ext=zip
    set bios[54].CRC32=
    set bios[54].MD5=
    set bios[54].desc="zipped file - [BIOS] Family Computer Disk System (Japan) (Rev 1)"

:: PC-8800

    set bios[55].name=N88.ROM
    set bios[55].ext=ROM
    set bios[55].CRC32=A0FC0473
    set bios[55].MD5=
    set bios[55].desc=""
    set bios[56].name=N88SUB.ROM
    set bios[56].ext=ROM
    set bios[56].CRC32=2158D307
    set bios[56].MD5=
    set bios[56].desc=""
    set bios[57].name=N88N.ROM
    set bios[57].ext=ROM    
    set bios[57].CRC32=5e607dcf
    set bios[57].MD5=
    set bios[57].desc=""
    set bios[58].name=N88EXT0.ROM
    set bios[58].ext=ROM    
    set bios[58].CRC32=710A63EC
    set bios[58].MD5=
    set bios[58].desc=""
    set bios[59].name=N88EXT1.ROM
    set bios[59].ext=ROM
    set bios[59].CRC32=C0BD2AA6
    set bios[59].MD5=
    set bios[59].desc=""
    set bios[60].name=N88EXT2.ROM
    set bios[60].ext=ROM    
    set bios[60].CRC32=AF2B6EFA
    set bios[60].MD5=
    set bios[60].desc=""
    set bios[61].name=N88EXT3.ROM
    set bios[61].ext=ROM
    set bios[61].CRC32=7713C519
    set bios[61].MD5=
    set bios[61].desc=""
    set bios[62].name=N88KNJ1.ROM
    set bios[62].ext=ROM
    set bios[62].CRC32=6178BD43
    set bios[62].MD5=
    set bios[62].desc=""
    set bios[63].name=N88KNJ2.ROM
    set bios[63].ext=ROM
    set bios[63].CRC32=154803CC
    set bios[63].MD5=
    set bios[63].desc=""

:: PC-9800

    set bios[64].name=2608_BD.WAV
    set bios[64].ext=WAV
    set bios[64].CRC32=FCB60C01
    set bios[64].MD5=29AAD51CD243C8E449D311D14613F0B1
    set bios[64].desc="for the PC-9800"
    set bios[65].name=2608_HH.WAV
    set bios[65].ext=WAV
    set bios[65].CRC32=7D6D9C4E
    set bios[65].MD5=59A009EE444318BD57D99A19068731E4
    set bios[65].desc="for the PC-9800"
    set bios[66].name=2608_RIM.WAV
    set bios[66].ext=WAV
    set bios[66].CRC32=8518A388
    set bios[66].MD5=943290D1C5C6AE6295BD02BE4411C7C0
    set bios[66].desc="for the PC-9800"
    set bios[67].name=2608_SD.WAV
    set bios[67].ext=WAV
    set bios[67].CRC32=C977FDB8
    set bios[67].MD5=C99156118789B6CBA662C864EBADC62E
    set bios[67].desc="for the PC-9800"
    set bios[68].name=2608_TOM.WAV
    set bios[68].ext=WAV
    set bios[68].CRC32=5E8AB475
    set bios[68].MD5=C321A6835B26AD125B2EB78BE56394A4
    set bios[68].desc="for the PC-9800"
    set bios[69].name=2608_TOP.WAV
    set bios[69].ext=WAV
    set bios[69].CRC32=CEFA9F76
    set bios[69].MD5=9E73FF2345236EBE72F7A937E477F0BD
    set bios[69].desc="for the PC-9800"
    set bios[70].name=BIOS.ROM
    set bios[70].ext=ROM
    set bios[70].CRC32=76AFFD90
    set bios[70].MD5=E246140DEC5124C5E404869A84CAEFCE
    set bios[70].desc="for the PC-9800"
    set bios[71].name=FONT.ROM
    set bios[71].ext=ROM
    set bios[71].CRC32=CD6DFABE
    set bios[71].MD5=2AF6179D7DE4893EA0B705C00E9A98D6
    set bios[71].desc="for the PC-9800"
    set bios[72].name=SOUND.ROM
    set bios[72].ext=ROM
    set bios[72].CRC32=A21EF796
    set bios[72].MD5=CAF90F22197AED6F14C471C21E64658D
    set bios[72].desc="for the PC-9800"
    set bios[73].name=ITF.ROM
    set bios[73].ext=ROM
    set bios[73].CRC32=273E9E88
    set bios[73].MD5=E9FC3890963B12CF15D0A2EEA5815B72
    set bios[73].desc="for the PC-9800"

:: PC-Engine\TurboGraphix-16

    set bios[76].name=syscard3.pce
    set bios[76].ext=pce
    set bios[76].CRC32=6D9A73EF
    set bios[76].MD5=38179DF8F4AC870017DB21EBCBF53114
    set bios[76].desc="This is the prefered BIOS for lr-beetle-pce-fast and should play most games - [BIOS] Super CD-ROM System (Japan) (v3,0)"
    set bios[77].name=syscard2.pce
    set bios[77].ext=pce
    set bios[77].CRC32=283B74E0
    set bios[77].MD5=3CDD6614A918616BFC41C862E889DD79
    set bios[77].desc="[BIOS] CD-ROM System (Japan) (v2,1),pce"
    set bios[78].name=syscard2.pce
    set bios[78].ext=pce
    set bios[78].CRC32=52520BC6
    set bios[78].MD5=3A456F0ECCFF039EB5FF045F56EC1C3B
    set bios[78].desc="[BIOS] CD-ROM System (Japan) (v2,0),pce"
    set bios[79].name=syscard1.pce
    set bios[79].ext=pce
    set bios[79].CRC32=3F9F95A4
    set bios[79].MD5=2B7CCB3D86BAA18F6402C176F3065082
    set bios[79].desc="[BIOS] CD-ROM System (Japan) (v1,0),pce"
    set bios[80].name=gexpress.pce
    set bios[80].ext=pce
    set bios[80].CRC32=51A12D90
    set bios[80].MD5=6D2CB14FC3E1F65CEB135633D1694122
    set bios[80].desc="[BIOS] Games Express CD Card (Japan),pce - Required to play four unlicensed games"
    set bios[81].name=gexpress.pce
    set bios[81].ext=pce
    set bios[81].CRC32=9D1E81B8
    set bios[81].MD5=CCF8590E2E7AC4A08BCC1D77EC168917
    set bios[81].desc="[BIOS] Games Express CD Card (Japan) (Alt),pce - Required to play four unlicensed games"
    set bios[82].name=syscard3u.pce
    set bios[82].ext=pce
    set bios[82].CRC32=2B5B75FE
    set bios[82].MD5=0754F903B52E3B3342202BDAFB13EFA5
    set bios[82].desc="[BIOS] TurboGrafx CD Super System Card (USA) (v3,0),pce - Most games work but some Japan games will not"
    set bios[83].name=syscard2u.pce
    set bios[83].ext=pce
    set bios[83].CRC32=FF2A5EC3
    set bios[83].MD5=94279F315E8B52904F65AB3108542AFE
    set bios[83].desc="[BIOS] TurboGrafx CD System Card (USA) (v2,0),pce"

:: Playstation 1

    set bios[10].name=scph101.bin
    set bios[10].ext=bin
    set bios[10].CRC32=171BDCEC
    set bios[10].MD5=6E3735FF4C7DC899EE98981385F6F3D0
    set bios[10].desc="For lr-pcsx-rearmed - psone-45a,bin"
    set bios[11].name=scph7001.bin
    set bios[11].ext=bin
    set bios[11].CRC32=502224B6
    set bios[11].MD5=1E68C231D0896B7EADCAD1D7D8E76129
    set bios[11].desc="For lr-pcsx-rearmed - ps-41a,bin"
    set bios[12].name=scph5501.bin
    set bios[12].ext=bin
    set bios[12].CRC32=8D8CB7E4
    set bios[12].MD5=490F666E1AFB15B7362B406ED1CEA246
    set bios[12].desc="For lr-pcsx-rearmed & lr-beetle-psx - ps-30a,bin"
    set bios[13].name=scph1001.bin
    set bios[13].ext=bin
    set bios[13].CRC32=37157331
    set bios[13].MD5=924E392ED05558FFDB115408C263DCCF
    set bios[13].desc="For PCSX-ReARMed & lr-pcsx-rearmed - Consider renaming scph1001,bin to SCPH1001,BIN instead of having two copies of the same BIOS,"
    set bios[14].name=scph5500.bin
    set bios[14].ext=bin
    set bios[14].CRC32=FF3EEB8C
    set bios[14].MD5=8DD7D5296A650FAC7319BCE665A6A53C
    set bios[14].desc="For lr-beetle-psx - ps-30j"
    set bios[15].name=scph5502.bin
    set bios[15].ext=bin
    set bios[15].CRC32=D786F0B9
    set bios[15].MD5=32736F17079D0B2B7024407C39BD3050
    set bios[15].desc="For lr-beetle-psx - ps-30e"

:: Sega Saturn

    set bios[84].name=saturn_bios.bin
    set bios[84].ext=bin
    set bios[84].CRC32=2aba43c2
    set bios[84].MD5=af5828fdff51384f99b3c4926be27762
    set bios[84].desc="Sega Saturn - for lr-yabause"
    set bios[85].name=sega_101.bin
    set bios[85].ext=bin
    set bios[85].CRC32=224b752c
    set bios[85].MD5=85ec9ca47d8f6807718151cbcca8b964
    set bios[85].desc="Sega Saturn - for lr-beetle-saturn"
    set bios[85].name=mpr-17933.bin
    set bios[85].ext=bin
    set bios[85].CRC32=4AFCF0FA
    set bios[85].MD5=3240872C70984B6CBFDA1586CAB68DBE
    set bios[85].desc="Sega Saturn - for lr-beetle-saturn"    

:: Sharp-X1

    set bios[86].name=IPLROM.X1
    set bios[86].ext=X1
    set bios[86].CRC32=7B28D9DE
    set bios[86].MD5=
    set bios[86].desc="Sharp-X1 (1 of 2)"
    set bios[87].name=IPLROM.X1T
    set bios[87].ext=X1T
    set bios[87].CRC32=2E8B767C
    set bios[87].MD5=
    set bios[87].desc="Sharp-X1 (2 of 2)"

:: Sharp-X68000

    set bios[88].name=iplrom.dat
    set bios[88].ext=dat
    set bios[88].CRC32=72BDF532
    set bios[88].MD5=7FD4CAABAC1D9169E289F0F7BBF71D8E
    set bios[88].desc="Sharp-X68000 - BIOS file"
    set bios[89].name=cgrom.dat
    set bios[89].ext=dat
    set bios[89].CRC32=9F3195F1
    set bios[89].MD5=CB0A5CFCF7247A7EAB74BB2716260269
    set bios[89].desc="Sharp-X68000 - FONT file"
    set bios[90].name=iplrom30.dat
    set bios[90].ext=dat
    set bios[90].CRC32=E8F8FDAD
    set bios[90].MD5=F373003710AB4322642F527F567E020A
    set bios[90].desc="Sharp-X68000 - BIOS file"
    set bios[91].name=iplromco.dat
    set bios[91].ext=dat
    set bios[91].CRC32=6C7EF608
    set bios[91].MD5=CC78D4F4900F622BD6DE1AED7F52592F
    set bios[91].desc="Sharp-X68000 - BIOS file"
    set bios[92].name=iplromxv.dat
    set bios[92].ext=dat
    set bios[92].CRC32=00EEB408
    set bios[92].MD5=0617321DAA182C3F3D6F41FD02FB3275
    set bios[92].desc="Sharp-X68000 - BIOS file"

:: TI-99    
    set bios[93].name=TI-994A.ctg
    set bios[93].ext=ctg
    set bios[93].CRC32=
    set bios[93].MD5=
    set bios[93].desc="TI-99 - file is CASE-SENSITIVE!"

::TRS-80

    set bios[94].name=level2.rom
    set bios[94].ext=rom
    set bios[94].CRC32=
    set bios[94].MD5=
    set bios[94].desc="TRS-80 - BIOS for Model I"
    set bios[95].name=level3.rom
    set bios[95].ext=rom
    set bios[95].CRC32=
    set bios[95].MD5=
    set bios[95].desc="TRS-80 - BIOS for Model III"
    set bios[96].name=level4.rom
    set bios[96].ext=rom
    set bios[96].CRC32=
    set bios[96].MD5=
    set bios[96].desc="TRS-80 - BIOS for Model 4"
    set bios[97].name=level4P.rom
    set bios[97].ext=rom
    set bios[97].CRC32=
    set bios[97].MD5=
    set bios[97].desc="TRS-80 - BIOS for Model 4P"

:: VideoPac/Odyssey-2

    set bios[98].name=o2rom.bin
    set bios[98].ext=bin
    set bios[98].CRC32=
    set bios[98].MD5=
    set bios[98].desc="Videopac / Odyssey 2 G7000 model"
    set bios[99].name=c52.bin
    set bios[99].ext=bin
    set bios[99].CRC32=
    set bios[99].MD5=
    set bios[99].desc="Videopac+ (french) G7000 model"
    set bios[100].name=g7400.bin
    set bios[100].ext=bin
    set bios[100].CRC32=
    set bios[100].MD5=
    set bios[100].desc="Videopac+ (european) G7400 model"
    set bios[101].name=jopac.bin
    set bios[101].ext=bin
    set bios[101].CRC32=
    set bios[101].MD5=
    set bios[101].desc="Videopac+ (french) G7400 model"

@echo on