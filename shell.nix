{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    nativeBuildInputs = [
	pkgs.gnumake
	pkgs.gcc
	pkgs.python3
    ];

    shellHook = ''
	echo "Entered C Injection Engine v2 nix shell"
	echo

# Sanity check
	echo "Tools available:"
	echo "  make               -> $(which make)"
	echo "  gcc                -> $(which gcc)"
	echo "  python3            -> $(which python3)"
	'';
}
