class HeadersMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/9_3_1_2/export/msp430-gcc-support-files-1.212.zip"
  sha256 "3b1a39f10a344dfefb767e60ac35becef4c065013be86993195b138a5fb0b8d6"
  revision 1

  def install
    target = "msp430-elf"

    # Install GCC support files to prefix/gcc-support-files
    target_dir = prefix/"gcc-support-files"
    target_dir.install Dir[buildpath/"*"]
    targets = target_dir/"include"
    target_lib = lib/target/"lib"
    target_include = include/target/"include"

    # Create symlinks to linker scripts.
    (target_lib/"ldscripts").install_symlink Dir[targets/"*.ld"]

    # Create symlinks to headers and devices.csv
    target_include.install_symlink Dir[targets/"*.csv", targets/"*.h"]
  end
end
