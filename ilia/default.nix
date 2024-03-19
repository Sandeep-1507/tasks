{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/06278c77b5d162e62df170fec307e83f1812d94b.tar.gz") {}}:

pkgs.stdenv.mkDerivation {
  pname = "ilia";
  version = "v1.0";

  src = pkgs.fetchFromGitHub {
    owner = "regolith-linux";
    repo = "ilia";
    rev = "ubuntu/jammy";
    sha256 = "4MKVwaepLOaxHFSwiks5InDbKt+B/Q2c97mM5yHz4eU=";
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
    pkgs.gtk3
    pkgs.libgee
    pkgs.json-glib
    pkgs.cairo
    pkgs.pango
    pkgs.tracker
    pkgs.gtk-layer-shell
    pkgs.gobject-introspection
  ];
  
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share
    cp src/ilia $out/share    
    cp ../data/org.regolith-linux.ilia.gschema.xml $out/share
    glib-compile-schemas $out/share/ 
    makeWrapper $out/share/ilia $out/bin/ilia --set GSETTINGS_SCHEMA_DIR $out/share
  '';
}
