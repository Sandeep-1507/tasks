{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/06278c77b5d162e62df170fec307e83f1812d94b.tar.gz") {}}:

pkgs.stdenv.mkDerivation {
  pname = "ilia";
  version = "v1.0";

  src = pkgs.fetchFromGitHub {
    owner = "regolith-linux";
    repo = "lago";
    rev = "ubuntu/jammy";
    sha256 = "KeaCRZET2n16XYYRCgxalQ5Z3dLssku+fxW1rubjzmM=";
  };

buildInputs = [
    pkgs.ninja
    pkgs.meson
    pkgs.makeWrapper
  ];

 propagatedBuildInputs = [
    pkgs.glib
    pkgs.vala
    pkgs.pkg-config
    pkgs.json-glib
    pkgs.gobject-introspection
  ];
  
  installPhase = ''
    mkdir -p $out/bin
    cp src/lago $out/bin
    
  '';
}
