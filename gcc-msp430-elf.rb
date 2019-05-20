class GccMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz"
  mirror "https://ftpmirror.gnu.org/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz"
  sha256 "832ca6ae04636adbb430e865a1451adf6979ab44ca1c8374f61fba65645ce15c"
  version "7.3.2-154"
  revision 4

  depends_on "binutils-msp430-elf"
  depends_on "headers-msp430-elf"
  depends_on "gmp" => :build if OS.mac?
  depends_on "mpfr" => :build if OS.mac?
  depends_on "libmpc" => :build if OS.mac?
  depends_on "isl" => :build if OS.mac?

  patch :p0 do
    url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/exports/msp430-gcc-7.3.2.154-source-patches.tar.bz2"
    sha256 "a9ae65464771549c7ffd0909a04fe0f783be7d04e5abe23ef191f536b2a3b8b4"
    apply "gcc-7_3_0-release.patch"
  end
  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/homebrew-msp430-elf/master/patches/gcc-7.3.0_osx-apfs.patch"
    sha256 "4e0dc00113592b828115a91d808c00ac0bdc96d01b0d37f14d9332066282496b"
  end

  resource "newlib" do
    url "ftp://sourceware.org/pub/newlib/newlib-2.4.0.tar.gz"
    sha256 "545b3d235e350d2c61491df8b9f775b1b972f191380db8f52ec0b1c829c52706"

    patch :p0 do
      url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/exports/msp430-gcc-7.3.2.154-source-patches.tar.bz2"
      sha256 "a9ae65464771549c7ffd0909a04fe0f783be7d04e5abe23ef191f536b2a3b8b4"
      apply "newlib-2_4_0.patch"
    end
  end

  def install
    target = "msp430-elf"
    # languages = "c,c++"
    languages = "c,c++"

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
        "--enable-languages=#{languages}",
        "--with-system-zlib",
        "--with-as=#{HOMEBREW_PREFIX}/bin/#{target}-as",
        "--with-ld=#{HOMEBREW_PREFIX}/bin/#{target}-ld",
        "--disable-libmudflap",
        "--disable-libgomp",
        "--disable-libssp",
        "--disable-shared",
        "--disable-nls",
        "--with-newlib",
        "--enable-target-optspace",
        "--enable-newlib-nano-formatted-io"
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
