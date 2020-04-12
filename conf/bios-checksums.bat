@echo off
:: create an array of known-good BIOS files. These aren't going to change. 

:: IMPORTANT NOTE!!! All set variables must have no spaces to work correctly. 

:: Global
set i=0
set len=73

:: 3DO

    set bios[16].name=panafz10.bin
    set bios[16].CRC32=
    set bios[16].MD5=f47264dd47fe30f73ab3c010015c155b

:: Amiga

    set bios[17].name=kick34005.A500
    set bios[17].CRC32=
    set bios[17].MD5=82a21c1890cae844b3df741f2762d48d
    set bios[17].desc="Amiga 500 - Kickstart v1.3 (Rev. 34.005)"
    set bios[18].name=kick40063.A600
    set bios[18].CRC32=
    set bios[18].MD5=e40a5dfb3d017ba8779faba30cbd1c8e
    set bios[18].desc="Amiga 600 - Kickstart v3.1 (Rev. 40.063)"
    set bios[19].name=kick40068.A1200
    set bios[19].CRC32=
    set bios[19].MD5=646773759326fbac3b2311fd8c8793ee
    set bios[19].desc="Amiga 1200 - Kickstart v3.1 (Rev. 40.068)"

:: ATARI 800/5200

    set bios[20].name=ATARIXL.ROM
    set bios[20].CRC32=0x1f9cd270
    set bios[20].MD5=06daac977823773a3eea3422fd26a703
    set bios[20].desc="BIOS for Atari XL/XE OS - Version BB01R2 OS from Atari 800XL and early Atari 65XE/130XE"
    set bios[21].name=ATARIBAS.ROM
    set bios[21].CRC32=0x7d684184
    set bios[21].MD5=0bac0c6a50104045d902df4503a4c30b
    set bios[21].desc="BIOS for the BASIC interpreter - Basic Rev. C, Atari BASIC from 800XL and all Atari XE/XEGS, also sold on cartridge"
    set bios[22].name=ATARIOSA.ROM
    set bios[22].CRC32=0x72b3fed4
    set bios[22].MD5=eb1f32f5d9f382db1bbfb8d7f9cb343a
    set bios[22].desc="BIOS for Atari 400/800 PAL - OS A from PAL Atari 400/800"
    set bios[23].name=ATARIOSB.ROM
    set bios[23].CRC32=0x3e28a1fe
    set bios[23].MD5=a3e8d617c95d08031fe1b20d541434b2
    set bios[23].desc="BIOS for Atari 400/800 NTSC - PCXFormer hack ROM, based on LINBUG version; a bugfixed NTSC OS B for 400/800"
    set bios[24].name=5200.rom
    set bios[24].CRC32=0x4248d3e3
    set bios[24].MD5=281f20ea4320404ec820fb7ec0693b38
    set bios[24].desc="BIOS for the Atari 5200 - Original (not Rev. A) BIOS from 4-port and early 2-port 5200"

:: ATARI 7800

    set bios[25].name=7800 BIOS (U).rom
    set bios[25].CRC32=
    set bios[25].MD5=
    set bios[25].desc="This BIOS is optional if you want the Atari Logo at the beginning of games. Note: if this BIOS is enabled, PAL ROMs will not work so use it accordingly."

:: ATARI LYNX

    set bios[26].name=lynxboot.img
    set bios[26].CRC32=0x0d973c9d
    set bios[26].MD5=fcd403db69f54290b51035d82f835e7b
    set bios[26].desc="Only for lr-beetle-lynx."

:: COCO (Tandy)

    set bios[27].name=bas13.rom
    set bios[27].CRC32=
    set bios[27].MD5=
    set bios[27].desc="For XRoar."

:: Colecovision

    set bios[28].name=coleco.rom
    set bios[28].CRC32=
    set bios[28].MD5=
    set bios[28].desc="For lr-blueMSX BIOS."

::Dragon

    set bios[28].name=d32.rom
    set bios[28].CRC32=
    set bios[28].MD5=
    set bios[28].desc="For XRoar."

:: Dreamcast

    set bios[0].name=dc_boot.bin
    set bios[0].CRC32=0x89f2b1a1
    set bios[0].MD5=e10c53c2f8b90bab96ead2d368858623 
    set bios[0].desc="Region: World"
    set bios[1].name=dc_flash.bin
    set bios[1].CRC32=0xc611b498
    set bios[1].MD5=0a93f7940c455905bea6e392dfde92a4 
    set bios[1].desc="Region: USA"
    set bios[2].name=dc_flash.bin
    set bios[2].CRC32=0xb7e5aeeb
    set bios[2].MD5=23df18aa53c8b30784cd9a84e061d008 
    set bios[2].desc="Region: Europe"
    set bios[3].name=dc_flash.bin
    set bios[3].CRC32=0x5f92bf76
    set bios[3].MD5=69c036adfca4ebea0b0c6fa4acfc8538
    set bios[3].desc="Region: Japan"

:: Hacked Dreamcast BIOS

    set bios[4].name=dc_boot.bin
    set bios[4].CRC32=0x61d5613f
    set bios[4].MD5=d407fcf70b56acb84b8c77c93b0e5327
    set bios[4].desc="Hack - Region-free"
    set bios[5].name=dc_flash.bin
    set bios[5].CRC32=0xe0d202a2
    set bios[5].MD5=93a9766f14159b403178ac77417c6b68
    set bios[5].desc="Hack - Region-free"
    set bios[6].name=dc_boot.bin
    set bios[6].CRC32=0x558f456e
    set bios[6].MD5=d552d8b577faa079e580659cd3517f86
    set bios[6].desc="atreyu187 Hack - Region-free"
    set bios[7].name=dc_flash.bin
    set bios[7].CRC32=0xbda0e9aa
    set bios[7].MD5=74e3f69c2bb92bc1fc5d9a53biosf6ffe2
    set bios[7].desc="atreyu187 Hack - Region-free"
    set bios[8].name=naomi.zip
    set bios[8].CRC32=0xc295a8c2
    set bios[8].MD5=eb4099aeb42ef089cfe94f8fe95e51f6
    set bios[8].desc="NAOMI BIOS - Region: World"
    set bios[9].name=awbios.zip
    set bios[9].CRC32=0xab628024
    set bios[9].MD5=0ec5ae5b5a5c4959fa8b43fcf8687f7c
    set bios[9].desc="Atomiswave BIOS - Region: World"

    set bios[29].name=dc_flash.bin
    set bios[29].CRC32=
    set bios[29].MD5=2f818338f47701c606ade664a3e16a8a
    set bios[29].desc="Generated from https://retropie.org.uk/forum/post/53941"

:: Famicom

    set bios[31].name=disksys.rom
    set bios[31].CRC32=0x5e607dcf
    set bios[31].MD5=ca30b50f880eb660a320674ed365ef7a
    set bios[31].desc="[BIOS] Family Computer Disk System (Japan) (Rev 1)"

:: Game Boy Advance

    set bios[32].name=gba_bios.bin
    set bios[32].CRC32=0x81977335
    set bios[32].MD5=a860e8c0b6d573d191e4ec7db1b1e4f6
    set bios[32].desc="[BIOS] Game Boy Advance (World).gba"

:: Game Boy/Super Game Boy

    set bios[32].name=gb_bios.bin
    set bios[32].CRC32=0x59C8598E
    set bios[32].MD5=32fbbd84168d3482956eb3c5051637f5
    set bios[32].desc="[BIOS] Nintendo Game Boy Boot ROM (World) (Rev 1).gb. lr-gambatte can load external BIOS for Game Boy (gb_bios.bin)."

    set bios[33].name=sgb_bios.bin
    set bios[33].CRC32=0xEC8A83B9
    set bios[33].MD5=d574d4f9c12f305074798f54c091a8b4
    set bios[33].desc="SGB-CPU (World) (Enhancement Chip).bin. lr-mgba can load external BIOS for Game Boy (gb_bios.bin) and Super Game Boy (sgb_bios.bin)."

:: Game Boy Color

    set bios[34].name=gbc_bios.bin
    set bios[34].CRC32=0x41884E46
    set bios[34].MD5=dbfce9db9deaa2567f6a84fde55f9680
    set bios[34].desc="[BIOS] Nintendo Game Boy Color Boot ROM (World).gbc. lr-mgba can load external BIOS for Game Boy Color(gbc_bios.bin) and Super Game Boy (sgb_bios.bin)."

:: Game Gear

    set bios[30].name=bios.gg
    set bios[30].CRC32=
    set bios[30].MD5=62e761035cb657903761800f4437b8af
    set bios[30].desc="For lr-genesis-plus-gx"

:: Intellivision

    set bios[35].name=exec.bin
    set bios[35].CRC32=
    set bios[35].MD5=62e761035cb657903761800f4437b8af
    set bios[35].desc="Executive ROM. lr-freeintv & jzIntv require two Intellivision BIOS files (exec.bin & grom.bin)"

    set bios[36].name=grom.bin
    set bios[36].CRC32=
    set bios[36].MD5=0cd5946c6473e42e8e4c2137785e427f
    set bios[36].desc="Graphics ROM - 213 predefined character images and some EXEC routines; Tutorvision variant. lr-freeintv  & jzIntv require two Intellivision BIOS files (exec.bin & grom.bin)."

    set bios[37].name=ECS.BIN
    set bios[37].CRC32=
    set bios[37].MD5=2e72a9a2b897d330a35c8b07a6146c52
    set bios[37].desc="Entertainment Computer System (ECS) ROM - additional EXEC routines, the BASIC programming interpreter, and graphics of musical notes"

    set bios[38].name=IVOICE.BIN
    set bios[38].CRC32=
    set bios[38].MD5=2e72a9a2b897d330a35c8b07a6146c52
    set bios[38].desc="Intellivoice RESROM - resident ROM containing common speech words and phrases as well as program instructions"

:: Macintosh 

    set bios[39].name=vMac.ROM
    set bios[39].CRC32=
    set bios[39].MD5=
    set bios[39].desc="vMac.ROM (Macintosh Plus Firmware)"

:: Master System

    set bios[40].name=bios_E.sms
    set bios[40].CRC32=
    set bios[40].MD5=
    set bios[40].desc="Sega Master System: for use in lr-genesis-plus-gx"

    set bios[41].name=bios_U.sms
    set bios[41].CRC32=
    set bios[41].MD5=
    set bios[41].desc="Sega Master System: for use in lr-genesis-plus-gx"

    set bios[42].name=bios_J.sms
    set bios[42].CRC32=
    set bios[42].MD5=
    set bios[42].desc="Sega Master System: for use in lr-genesis-plus-gx"

:: Mega CD/Sega CD

    set bios[43].name=us_scd1_9210.bin
    set bios[43].CRC32=
    set bios[43].MD5=2efd74e3232ff260e371b99f84024f7f
    set bios[43].desc="[BIOS] Sega CD (USA) (v1.10).md - file may be named bios_CD_U.bin"
    set bios[44].name=eu_mcd1_9210.bin
    set bios[44].CRC32=
    set bios[44].MD5=e66fa1dc5820d254611fdcdba0662372
    set bios[44].desc="[BIOS] Mega-CD (Europe) (v1.00).md - file may be named bios_CD_E.bin "
    set bios[45].name=jp_mcd1_9112.bin
    set bios[45].CRC32=
    set bios[45].MD5=bdeb4c47da613946d422d97d98b21cda
    set bios[45].desc="[BIOS] Mega-CD (Asia) (v1.00S).md - file may be named bios_CD_J.bin"

:: Megadrive

    set bios[46].name=bios_MD.bin
    set bios[46].CRC32=
    set bios[46].MD5=
    set bios[46].desc="lr-genesis-plus-gx can load MegaDrive TMSS startup ROM (bootrom)."

:: MSX - reconsider this configuration

:: Nintendo DS


    set bios[47].name=nds_bios_arm7.bin
    set bios[47].CRC32=
    set bios[47].MD5=
    set bios[47].desc="for DraStic: nds_bios7.bin, nds_bios9.bin & nds_firmware.bin"
    set bios[48].name=nds_bios_arm9.bin
    set bios[48].CRC32=
    set bios[48].MD5=
    set bios[48].desc="for DraStic: nds_bios7.bin, nds_bios9.bin & nds_firmware.bin"
    set bios[49].name=nds_firmware.bin
    set bios[49].CRC32=
    set bios[49].MD5=
    set bios[49].desc="for DraStic: nds_bios7.bin, nds_bios9.bin & nds_firmware.bin"
    set bios[50].name=bios7.bin
    set bios[50].CRC32=
    set bios[50].MD5=
    set bios[50].desc="lr-desmume can load BIOS file: bios7.bin, bios9.bin & firmware.bin"
    set bios[51].name=bios9.bin
    set bios[51].CRC32=
    set bios[51].MD5=
    set bios[51].desc="lr-desmume can load BIOS file: bios7.bin, bios9.bin & firmware.bin"
    set bios[52].name=firmware.bin
    set bios[52].CRC32=
    set bios[52].MD5=
    set bios[52].desc="lr-desmume can load BIOS file: bios7.bin, bios9.bin & firmware.bin"

:: Nintendo Entertainment System (NES)

    set bios[53].name=disksys.rom
    set bios[53].CRC32=0x5e607dcf
    set bios[53].MD5=ca30b50f880eb660a320674ed365ef7a
    set bios[53].desc="[BIOS] Family Computer Disk System (Japan) (Rev 1)"

    set bios[54].name=fdsbios.zip
    set bios[54].CRC32=
    set bios[54].MD5=
    set bios[54].desc="zipped file - [BIOS] Family Computer Disk System (Japan) (Rev 1)"

:: PC-8800

    set bios[55].name=N88.ROM
    set bios[55].CRC32=0xA0FC0473
    set bios[55].MD5=
    set bios[55].desc=""
    set bios[56].name=N88SUB.ROM
    set bios[56].CRC32=0x2158D307
    set bios[56].MD5=
    set bios[56].desc=""
    set bios[57].name=N88N.ROM
    set bios[57].CRC32=0x5e607dcf
    set bios[57].MD5=
    set bios[57].desc=""
    set bios[58].name=N88EXT0.ROM
    set bios[58].CRC32=0x710A63EC
    set bios[58].MD5=
    set bios[58].desc=""
    set bios[59].name=N88EXT1.ROM
    set bios[59].CRC32=0xC0BD2AA6
    set bios[59].MD5=
    set bios[59].desc=""
    set bios[60].name=N88EXT2.ROM
    set bios[60].CRC32=0xAF2B6EFA
    set bios[60].MD5=
    set bios[60].desc=""
    set bios[61].name=N88EXT3.ROM
    set bios[61].CRC32=0x7713C519
    set bios[61].MD5=
    set bios[61].desc=""
    set bios[62].name=N88KNJ1.ROM
    set bios[62].CRC32=0x6178BD43
    set bios[62].MD5=
    set bios[62].desc=""
    set bios[63].name=N88KNJ2.ROM
    set bios[63].CRC32=0x154803CC
    set bios[63].MD5=
    set bios[63].desc=""

:: PC-9800

    set bios[64].name=2608_BD.WAV
    set bios[64].CRC32=0xFCB60C01
    set bios[64].MD5=29AAD51CD243C8E449D311D14613F0B1
    set bios[64].desc="for the PC-9800"
    set bios[65].name=2608_HH.WAV
    set bios[65].CRC32=0x7D6D9C4E
    set bios[65].MD5=59A009EE444318BD57D99A19068731E4
    set bios[65].desc="for the PC-9800"
    set bios[66].name=2608_RIM.WAV
    set bios[66].CRC32=0x8518A388
    set bios[66].MD5=943290D1C5C6AE6295BD02BE4411C7C0
    set bios[66].desc="for the PC-9800"
    set bios[67].name=2608_SD.WAV
    set bios[67].CRC32=0xC977FDB8
    set bios[67].MD5=C99156118789B6CBA662C864EBADC62E
    set bios[67].desc="for the PC-9800"
    set bios[68].name=2608_TOM.WAV
    set bios[68].CRC32=0x5E8AB475
    set bios[68].MD5=C321A6835B26AD125B2EB78BE56394A4
    set bios[68].desc="for the PC-9800"
    set bios[69].name=2608_TOP.WAV
    set bios[69].CRC32=0xCEFA9F76
    set bios[69].MD5=9E73FF2345236EBE72F7A937E477F0BD
    set bios[69].desc="for the PC-9800"
    set bios[70].name=BIOS.ROM
    set bios[70].CRC32=0x76AFFD90
    set bios[70].MD5=E246140DEC5124C5E404869A84CAEFCE
    set bios[70].desc="for the PC-9800"
    set bios[71].name=FONT.ROM
    set bios[71].CRC32=0xCD6DFABE
    set bios[71].MD5=2AF6179D7DE4893EA0B705C00E9A98D6
    set bios[71].desc="for the PC-9800"
    set bios[72].name=SOUND.ROM
    set bios[72].CRC32=0xA21EF796
    set bios[72].MD5=CAF90F22197AED6F14C471C21E64658D
    set bios[72].desc="for the PC-9800"
    set bios[73].name=ITF.ROM
    set bios[73].CRC32=0x273E9E88
    set bios[73].MD5=E9FC3890963B12CF15D0A2EEA5815B72
    set bios[73].desc="for the PC-9800"

:: Playstation 1

    set bios[10].name=scph101.bin
    set bios[10].CRC32=0x171BDCEC
    set bios[10].MD5=6E3735FF4C7DC899EE98981385F6F3D0
    set bios[11].name=scph7001.bin
    set bios[11].CRC32=0x502224B6
    set bios[11].MD5=1E68C231D0896B7EADCAD1D7D8E76129
    set bios[12].name=scph5501.bin
    set bios[12].CRC32=0x8D8CB7E4
    set bios[12].MD5=490F666E1AFB15B7362B406ED1CEA246
    set bios[13].name=scph1001.bin
    set bios[13].CRC32=0x37157331
    set bios[13].MD5=924E392ED05558FFDB115408C263DCCF
    set bios[14].name=scph5500.bin
    set bios[14].CRC32=0xFF3EEB8C
    set bios[14].MD5=8DD7D5296A650FAC7319BCE665A6A53C
    set bios[15].name=scph5502.bin
    set bios[15].CRC32=0xD786F0B9
    set bios[15].MD5=32736F17079D0B2B7024407C39BD3050

:: Sega Saturn

:: Turbographix 16/PCEngine

::
@echo on