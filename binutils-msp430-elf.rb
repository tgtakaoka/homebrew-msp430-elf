class BinutilsMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.bz2"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.34.tar.bz2"
  sha256 "89f010078b6cf69c23c27897d686055ab89b198dddf819efb0a4f2c38a0b36e6"
  version "2.34-50"
  revision 2

  patch :p0 do
    url "https://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/9_3_1_2/export/msp430-gcc-9.3.1.11-source-patches.tar.bz2"
    sha256 "ec6472b034e11e8cfdeb3934b218e5bafbb7a03f3afc0e76536bd9c42653525b"
    apply "binutils-2_34.patch"
  end

  def install
    target = "msp430-elf"
    mkdir "build" do
      system "../configure",
        "--target=#{target}",
        "--program-prefix=#{target}-",
        "--prefix=#{prefix}",
        "--enable-languages=c,c++",
        "--disable-nls",
        "--enable-inifini-array",
        "--disable-sim",
        "--disable-gdb",
        "--disable-werror",
        "--with-system-zlib"
      system "make"
      system "make", "install"
    end

    # Remove unnecessary files.
    info.rmtree

    # Create symlink to no-prefix binaries as bin/target
    bin.install_symlink prefix/target/"bin" => target

    # Create empty place holders for gcc-msp430-elf
    target_lib = HOMEBREW_PREFIX/"lib/#{target}/lib"
    target_include = HOMEBREW_PREFIX/"include/#{target}/include"
    target_lib.mkpath
    target_include.mkpath
    # Move target/lib to lib/target/lib
    (lib/target).install prefix/target/"lib"
    # Create symlink for msp430-elf-ld to see linker scripts from
    # headers-msp430-elf.
    (prefix/target).install_symlink target_lib
  end
end
