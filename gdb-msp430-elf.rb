class GdbMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://ftpmirror.gnu.org/gdb/gdb-8.1.tar.xz"
  sha256 "af61a0263858e69c5dce51eab26662ff3d2ad9aa68da9583e8143b5426be4b34"
  version "8.1-11"
  revision 2

  patch :p0 do
    url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/exports/msp430-gcc-7.3.2.154-source-patches.tar.bz2"
    sha256 "a9ae65464771549c7ffd0909a04fe0f783be7d04e5abe23ef191f536b2a3b8b4"
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
        "--with-system-zlib",
        "--disable-binutils",
        "--disable-gas",
        "--disable-ld",
        "--disable-gprof",
        "--disable-etc",
        "--with-python=no",
        "--disable-nls"
      system "make"
      system "make", "install"

      (share/"gdb").rmtree
      include.rmtree
      info.rmtree
    end
  end
end
