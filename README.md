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

    MSP430-GCC 6_1_1_0 (msp430-gcc-7.3.2.154-source-patches)
      binutils-msp430-elf-2.26-11_3
      gcc-msp430-elf-7.3.2-154_4
      newlib-2.4.0
      gdb-msp430-8.1-11_2
    msp430-gcc-support-files-1.207
      headers-msp430-elf-1.207_2

[Homebrew]: https://brew.sh/
[TI MSP430-GCC]: http://www.ti.com/tool/MSP430-GCC-OPENSOURCE
