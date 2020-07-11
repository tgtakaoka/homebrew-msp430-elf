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

For Linux, the following packages are necessary to compile these formulae.

  * libgmp-dev
  * libmpfr-dev
  * libmpc-dev
  * libisl-dev

Version:

    MSP430-GCC 9_2_0_0 (msp430-gcc-9.2.0.50-source-patches)
      binutils-msp430-elf-2.34-50_1
      gcc-msp430-elf-9.2.0-50_1
      newlib-2.4.0
      gdb-msp430-9.1-50_1
    msp430-gcc-support-files-1.210
      headers-msp430-elf-1.210_1

[Homebrew]: https://brew.sh/
[TI MSP430-GCC]: http://www.ti.com/tool/MSP430-GCC-OPENSOURCE
