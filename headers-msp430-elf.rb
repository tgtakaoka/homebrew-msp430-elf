class HeadersMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/exports/msp430-gcc-support-files-1.207.zip"
  sha256 "38f61940c6fe09e92ed9fc25124bd1705500d6f0db4af494fa5470de53a67570"
  revision 2

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
