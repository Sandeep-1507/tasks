{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/06278c77b5d162e62df170fec307e83f1812d94b.tar.gz") {} }:

pkgs.stdenv.mkDerivation {
  pname = "xrescat";
  version = "v1.0";
  
  src = pkgs.fetchFromGitHub {
    owner = "regolith-linux";
    repo = "xrescat";
    rev = "e8e261441682244112b2020e2ad102768e6ba3fd";
    sha256 = "0mMcoNNkaFO6O0F8HjIA8Q8MtfSHLeXY9cGkVd83Vls=";
  };
  
  buildInputs = [
pkgs.gnumake
    pkgs.gcc
    pkgs.gdb
    pkgs.xorg.libX11.dev
    pkgs.SDL2.dev
  ];
  buildPhase= ''
  make
  '';
  installPhase= ''
  make install DESTDIR=$out
  '';
}

