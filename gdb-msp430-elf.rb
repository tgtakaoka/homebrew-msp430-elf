class GdbMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://ftp.gnu.org/gnu/gdb/gdb-9.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/gdb/gdb-9.1.tar.xz"
  sha256 "699e0ec832fdd2f21c8266171ea5bf44024bd05164fdf064e4d10cc4cf0d1737"
  version "9.1-50"
  revision 1

  patch :p0 do
    url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/9_2_0_0/export/msp430-gcc-9.2.0.50-source-patches.tar.bz2"
    sha256 "0756421396b5806bf3ac07d78a80ab999b82ead71cb3370a601c628f7bf1d3d3"
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
