#{stdenv, fetchurl, libX11, libXinerama, libXft, patches ? []}:
with import <nixpkgs> {};
#{stdenv, patches ? []}:

let
  name = "dwmblocks-6.2-luke";
  patches = [];
in
stdenv.mkDerivation {
  inherit name;

  src = ./.;

  #buildInputs = [ libX11 libXinerama libXft ];
  buildInputs = [ xorg.libX11 ];

  prePatch = ''sed -i "s@/usr/local@$out@" Makefile'';

  # Allow users set their own list of patches
  inherit patches;

  buildPhase = " make ";

  meta = {
    homepage = "https://github.com/lukesmithxyz/dwmblocks";
    description = "Modular status bar for dwm written in C (modified by Luke Smith)";
    license = stdenv.lib.licenses.mit;
    platforms = with stdenv.lib.platforms; all;
  };
}
