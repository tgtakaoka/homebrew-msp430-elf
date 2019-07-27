class BinutilsMsp430Elf < Formula
  homepage "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/index_FDS.html"
  url "https://ftpmirror.gnu.org/binutils/binutils-2.26.tar.bz2"
  sha256 "c2ace41809542f5237afc7e3b8f32bb92bc7bc53c6232a84463c423b0714ecd9"
  version "2.26-11"
  revision 4

  patch :p0 do
    url "http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/8_2_0_0/exports/msp430-gcc-8.2.0.52-source-patches.tar.bz2"
    sha256 "ba01b52163924ee6376abd75be948375fd049fc878e8e5aed67917f5d95ec85b"
    apply "binutils-2_26.patch"
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
        "--disable-debug",
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
