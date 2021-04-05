class GdbMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://ftp.gnu.org/gnu/gdb/gdb-9.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/gdb/gdb-9.1.tar.xz"
  sha256 "699e0ec832fdd2f21c8266171ea5bf44024bd05164fdf064e4d10cc4cf0d1737"
  version "9.1-50"
  revision 2

  patch :p0 do
    url "https://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/9_3_1_1/export/msp430-gcc-9.3.1.11-source-patches.tar.bz2"
    sha256 "ec6472b034e11e8cfdeb3934b218e5bafbb7a03f3afc0e76536bd9c42653525b"
    apply "gdb-9.1-release.patch"
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
        "--disable-binutils",
        "--disable-gas",
        "--disable-ld",
        "--disable-gprof",
        "--disable-etc",
        "--without-mpfr",
        "--without-lzma",
        "--with-python=no",
        "--with-system-zlib"
      system "make"
      system "make", "install"

      (share/"gdb").rmtree
      include.rmtree
      info.rmtree
    end
  end
end
