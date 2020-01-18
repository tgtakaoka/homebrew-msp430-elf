homebrew-msp430-elf
===================

The [Homebrew][] formulae of GCC - Open Source Compiler for MSP
Microcontrollers, also known as [TI MSP430-GCC][]. This repository includes
`binutils-msp430-elf`, `headers-msp430-elf`, `gcc-msp430-elf`,
`gdb-msp430-elf`.

To get everything, execute the following commands.

    $ brew tap tgtakaoka/msp430-elf
    $ brew install gcc-msp430-elf gdb-msp430-elf

You may want to install `mspdebug-head` by the following commands.

    $ brew tap tgtakaoka/tinyos-msp430
    $ brew install --HEAD mspdebug-head

Version:

    MSP430-GCC 8_3_1_0 (msp430-gcc-3.2.1.25-source-patches)
      binutils-msp430-elf-2.26-25_1
      gcc-msp430-elf-8.3.0-25_1
      newlib-2.4.0
      gdb-msp430-8.1-16_1
    msp430-gcc-support-files-1.208
      headers-msp430-elf-1.208_1

[Homebrew]: https://brew.sh/
[TI MSP430-GCC]: http://www.ti.com/tool/MSP430-GCC-OPENSOURCE
