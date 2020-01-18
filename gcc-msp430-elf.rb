class GccMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://ftp.gnu.org/gnu/gcc/gcc-8.3.0/gcc-8.3.0.tar.xz"
  mirror "https://ftpmirror.gnu.org/gcc/gcc-8.3.0/gcc-8.3.0.tar.xz"
  sha256 "64baadfe6cc0f4947a84cb12d7f0dfaf45bb58b7e92461639596c21e02d97d2c"
  version "8.3.0-25"
  revision 1

  depends_on "binutils-msp430-elf"
  depends_on "headers-msp430-elf"
  depends_on "gmp" => :build if OS.mac?
  depends_on "mpfr" => :build if OS.mac?
  depends_on "libmpc" => :build if OS.mac?
  depends_on "isl" => :build if OS.mac?

  patch :p0 do
    url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/8_3_1_0/export/msp430-gcc-8.3.1.25-source-patches.tar.bz2"
    sha256 "a100f09f45c27f2c272718c5f3a90c00e3039fa6560ccc054ad5449d470054fa"
    apply "gcc-8_3_0-release.patch"
  end

  resource "newlib" do
    url "ftp://sourceware.org/pub/newlib/newlib-2.4.0.tar.gz"
    sha256 "545b3d235e350d2c61491df8b9f775b1b972f191380db8f52ec0b1c829c52706"

    patch :p0 do
      url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/8_3_0_0/exports/msp430-gcc-8.3.0.16-source-patches.tar.bz2"
      sha256 "2732abaf76e1da9e224b25d442c2f764c487087603ae1d954d6e980e48f37af7"
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
