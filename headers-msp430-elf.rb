class HeadersMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/8_3_0_0/exports/msp430-gcc-support-files-1.208.zip"
  sha256 "d9fc05de5ff4903ad0784446d1517ba81017c3f4ec3cfa0bab2cf9416084f1fa"
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
