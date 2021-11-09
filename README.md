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

    $ brew tap tgtakaoka/mspdebug-mspds
    $ brew install --HEAD mspdebug-head

For Linux, the following packages are necessary to compile these formulae.

  * `libgmp-dev`
  * `libmpfr-dev`
  * `libmpc-dev`
  * `libisl-dev`
  * `zlib1g-dev`
  * `texinfo`

Version:

```
  MSP430-GCC-OPENSOURCE9.3.1.2
    MSP430-GCC 9.3.1.11
      binutils-msp430-elf-2.34-50_2
      gcc-msp430-elf-9.3.1-11_1
      newlib-2.4.0
      gdb-msp430-9.1-50_2
    msp430-gcc-support-files-1.212
      headers-msp430-elf-1.212_1
```

[Homebrew]: https://brew.sh/
[TI MSP430-GCC]: http://www.ti.com/tool/MSP430-GCC-OPENSOURCE
