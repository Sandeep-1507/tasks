{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/06278c77b5d162e62df170fec307e83f1812d94b.tar.gz") {}}:

pkgs.stdenv.mkDerivation {
  pname = "remontoire";
  version = "v1.0";

  src = pkgs.fetchFromGitHub {
    owner = "regolith-linux";
    repo = "remontoire";
    rev = "master";
    sha256 = "Cb6tzTGZdQA9oA04DO/xLBw5F+FRj5BM2Aa62YWGmZA=";
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
    pkgs.tracker
    pkgs.gtk3
    pkgs.libgee
    pkgs.gobject-introspection
  ];
  
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share
    cp src/remontoire $out/share 
    cp ../data/org.regolith-linux.remontoire.gschema.xml $out/share
    glib-compile-schemas $out/share/ 
    makeWrapper $out/share/remontoire $out/bin/remontoire --set GSETTINGS_SCHEMA_DIR $out/share
  '';
}
