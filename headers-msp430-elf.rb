class HeadersMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/9_3_1_1/export/msp430-gcc-support-files-1.211.zip"
  sha256 "07589fb72192d47adf3b5f7e25271e8834a82ebc404e26c678044be29c026351"
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
