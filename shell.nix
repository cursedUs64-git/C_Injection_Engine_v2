{ pkgs ? import <nixpkgs> {} }:

let
# Patched mips-linux-gnu-binutils derivation
mipsBinutils = pkgs.stdenv.mkDerivation rec {
    pname = "mips-linux-gnu-binutils";
    version = "2.45";

    src = pkgs.fetchurl {
	url = "https://mirrors.hopbox.net/gnu/binutils/binutils-${version}.tar.xz";
	sha256 = "c50c0e7f9cb188980e2cc97e4537626b1672441815587f1eab69d2a1bfbef5d2";
    };

    nativeBuildInputs = [ pkgs.gcc pkgs.gnumake42 pkgs.texinfo ];
    buildInputs = [ pkgs.libelf ];

    configureFlags = [
	"--target=mips-linux-gnu"
	    "--prefix=$out"
	    "--with-sysroot=/usr/mips-linux-gnu"
	    "--with-gnu-as"
	    "--with-gnu-ld"
	    "--enable-64-bit-bfd"
	    "--enable-multilib"
	    "--enable-plugins"
	    "--disable-gold"
	    "--disable-nls"
	    "--disable-shared"
	    "--disable-werror"
    ];

    postPatch = ''
# patch libtool to skip "only absolute run-paths are allowed"
	find . -name "libtool" -type f -exec sed -i '/only absolute run-paths are allowed/d' {} +
	'';

    configurePhase = ''
	./configure ${pkgs.lib.concatStringsSep " " configureFlags}
    '';

    buildPhase = "make -j$(nproc)";
    installPhase = "make install";

    meta = with pkgs.lib; {
	description = "GNU Binutils for MIPS cross-compilation (patched libtool)";
	homepage = "http://www.gnu.org/software/binutils/";
	license = licenses.gpl3Plus;
	platforms = platforms.linux;
    };
};
in

pkgs.mkShell {
    nativeBuildInputs = [
	pkgs.gnumake
	    pkgs.gcc
	    pkgs.python3
	    mipsBinutils
    ];

    shellHook = ''
	echo "Entered C Injection Engine v2 nix shell"
	echo

# --------------------------------------------------
# Add cross-binutils to PATH
# --------------------------------------------------
	export PATH="${mipsBinutils}/bin:$PATH"

# Sanity check
	echo "Tools available:"
	echo "  make               -> $(which make)"
	echo "  gcc                -> $(which gcc)"
	echo "  python3            -> $(which python3)"
	echo "  mips-linux-gnu-ld  -> $(which mips-linux-gnu-ld)"
	echo "  mips-linux-gnu-as  -> $(which mips-linux-gnu-as)"
	'';
}
