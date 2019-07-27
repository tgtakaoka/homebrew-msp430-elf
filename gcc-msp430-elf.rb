class GccMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://ftp.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.xz"
  mirror "https://ftpmirror.gnu.org/gcc/gcc-8.2.0/gcc-8.2.0.tar.xz"
  sha256 "196c3c04ba2613f893283977e6011b2345d1cd1af9abeac58e916b1aab3e0080"
  version "8.2.0-52"
  revision 1

  depends_on "binutils-msp430-elf"
  depends_on "headers-msp430-elf"
  depends_on "gmp" => :build if OS.mac?
  depends_on "mpfr" => :build if OS.mac?
  depends_on "libmpc" => :build if OS.mac?
  depends_on "isl" => :build if OS.mac?

  patch :p0 do
    url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/8_2_0_0/exports/msp430-gcc-8.2.0.52-source-patches.tar.bz2"
    sha256 "ba01b52163924ee6376abd75be948375fd049fc878e8e5aed67917f5d95ec85b"
    apply "gcc-8_2_0-release.patch"
  end
  patch :p2 do
    url "https://raw.githubusercontent.com/tgtakaoka/homebrew-msp430-elf/master/patches/gcc-7.3.0_graphite_h.patch"
    sha256 "e8b716f765bcc6ecd8cc5b1ac037a0a79fff2a7ba50e804479c010dc2b12b9f3"
  end

  resource "newlib" do
    url "ftp://sourceware.org/pub/newlib/newlib-2.4.0.tar.gz"
    sha256 "545b3d235e350d2c61491df8b9f775b1b972f191380db8f52ec0b1c829c52706"

    patch :p0 do
      url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/8_2_0_0/exports/msp430-gcc-8.2.0.52-source-patches.tar.bz2"
      sha256 "ba01b52163924ee6376abd75be948375fd049fc878e8e5aed67917f5d95ec85b"
      apply "newlib-2_4_0.patch"
    end
  end

  def install
    target = "msp430-elf"

    resource("newlib").stage do
      buildpath.install "newlib"
      buildpath.install "libgloss"
    end

    # gcc must be built outside of the source directory.
    mkdir "build" do
      system "../configure",
        "--target=#{target}",
        "--program-prefix=#{target}-",
        "--prefix=#{prefix}",
        "--enable-languages=c,c++",
        "--disable-nls",
        "--enable-inifini-array",
        "--enable-target-optspace",
        "--enable-newlib-nano-formatted-io",
        "--with-system-zlib",
        "--with-as=#{HOMEBREW_PREFIX}/bin/#{target}-as",
        "--with-ld=#{HOMEBREW_PREFIX}/bin/#{target}-ld"
      system "make"
      system "make", "install"
    end

    # Remove unnecessary files.
    info.rmtree
    man7.rmtree

    # Create symlinks to linker scripts from headers-msp430-elf.
    ldscripts = "#{HOMEBREW_PREFIX}/lib/#{target}/lib/ldscripts"
    (prefix/target/"lib").install_symlink Dir["#{ldscripts}/*.ld"]
  end
end
