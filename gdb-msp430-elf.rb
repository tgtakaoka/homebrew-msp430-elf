class GdbMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://ftpmirror.gnu.org/gdb/gdb-8.1.tar.xz"
  sha256 "af61a0263858e69c5dce51eab26662ff3d2ad9aa68da9583e8143b5426be4b34"
  version "8.1-16"
  revision 1

  patch :p0 do
    url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/8_3_0_0/exports/msp430-gcc-8.3.0.16-source-patches.tar.bz2"
    sha256 "2732abaf76e1da9e224b25d442c2f764c487087603ae1d954d6e980e48f37af7"
    apply "gdb-8.1-release.patch"
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
