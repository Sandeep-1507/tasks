{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/06278c77b5d162e62df170fec307e83f1812d94b.tar.gz") {}}:

let

  oldnixpkgsCommit = "dd1b7e377f6d77ddee4ab84be11173d3566d6a18";
  newnixpkgsCommit = "18a0b68e42bebce4b75402f586a0cb43da626ce6";


  nixpkgsSrc1 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${oldnixpkgsCommit}.tar.gz";
    sha256 = "158zx28wfxqkv51lwgkbsdp1v3wyijp6crmk3mkvqa0v0619yxiv"; 
  };


  oldpkgs = import nixpkgsSrc1 {};
  nixpkgsSrc2 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${newnixpkgsCommit}.tar.gz";
    sha256 = "158zx28wfxqkv51lwgkbsdp1v3wyijp6crmk3mkvqa0v0619yxiv"; 
  };


  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/06278c77b5d162e62df170fec307e83f1812d94b.tar.gz") {};

in

pkgs.stdenv.mkDerivation {
  pname = "ilia";
  version = "v0.5";

  src = pkgs.fetchFromGitHub {
    owner = "regolith-linux";
    repo = "ilia";
    rev = "ubuntu/jammy";
    sha256 = "03nncqk8b075sxzjfa5azh6pxdqzirm8zj87zr6z6gxmbm6l25vi";
  };

buildInputs = [
    pkgs.ninja
    pkgs.meson
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
    oldpkgs.tracker
    pkgs.gobject-introspection
  ];


  buildPhase = ''
    meson ..
    ninja 
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp src/ilia $out/bin/
  '';
}
