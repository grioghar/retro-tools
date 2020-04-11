@echo off
:: create an array of known-good BIOS files. These aren't going to change. 

:: IMPORTANT NOTE!!! All set variables must have no spaces to work correctly. 

:: Global
set i=0
set len=25

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
    set bios[20].CRC32="0x1f9cd270"
    set bios[20].MD5=06daac977823773a3eea3422fd26a703
    set bios[20].desc="BIOS for Atari XL/XE OS - Version BB01R2 OS from Atari 800XL and early Atari 65XE/130XE"
    set bios[21].name=ATARIBAS.ROM
    set bios[21].CRC32="0x7d684184"
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



:: Dreamcast

    set bios[0].name=bios_boot.bin
    set bios[0].CRC32="0x89f2b1a1"
    set bios[0].MD5=e10c53c2f8b90bab96ead2d368858623 
    set bios[1].name=bios_flash.bin
    set bios[1].CRC32="0xc611b498"
    set bios[1].MD5=0a93f7940c455905bea6e392dfde92a4 
    set bios[2].name=bios_flash.bin
    set bios[2].CRC32="0xb7e5aeeb"
    set bios[2].MD5=23df18aa53c8b30784cd9a84e061d008 
    set bios[3].name=bios_flash.bin
    set bios[3].CRC32="0x5f92bf76"
    set bios[3].MD5=69c036adfca4ebea0b0c6fa4acfc8538

:: Hacked Dreamcast BIOS

    set bios[4].name=bios_boot.bin
    set bios[4].CRC32="0x61d5613f"
    set bios[4].MD5=d407fcf70b56acb84b8c77c93b0e5327
    set bios[5].name=bios_flash.bin
    set bios[5].CRC32="0xe0d202a2"
    set bios[5].MD5=93a9766f14159b403178ac77417c6b68
    set bios[6].name=bios_boot.bin
    set bios[6].CRC32="0x558f456e"
    set bios[6].MD5=d552d8b577faa079e580659cd3517f86
    set bios[7].name=bios_flash.bin
    set bios[7].CRC32="0xbda0e9aa"
    set bios[7].MD5=74e3f69c2bb92bc1fc5d9a53biosf6ffe2
    set bios[8].name=naomi.zip
    set bios[8].CRC32="0xc295a8c2"
    set bios[8].MD5=eb4099aeb42ef089cfe94f8fe95e51f6
    set bios[9].name=awbios.zip
    set bios[9].CRC32="0xab628024"
    set bios[9].MD5=0ec5ae5b5a5c4959fa8b43fcf8687f7c

:: Playstation 1

    set bios[10].name=scph101.bin
    set bios[10].CRC32="0x171BDCEC"
    set bios[10].MD5=6E3735FF4C7bios899EE98981385F6F3D0
    set bios[11].name=scph7001.bin
    set bios[11].CRC32="0x502224B6"
    set bios[11].MD5=1E68C231D0896B7EAbiosAD1D7D8E76129
    set bios[12].name=scph5501.bin
    set bios[12].CRC32="0x8D8CB7E4"
    set bios[12].MD5=490F666E1AFB15B7362B406ED1CEA246
    set bios[13].name=scph1001.bin
    set bios[13].CRC32="0x37157331"
    set bios[13].MD5=924E392ED05558FFDB115408C263biosCF
    set bios[14].name=scph5500.bin
    set bios[14].CRC32="0xFF3EEB8C"
    set bios[14].MD5=8DD7D5296A650FAC7319BCE665A6A53C
    set bios[15].name=scph5502.bin
    set bios[15].CRC32="0xD786F0B9"
    set bios[15].MD5=32736F17079D0B2B7024407C39BD3050

:: Sega Saturn

:: Turbographix 16/PCEngine

::
@echo on