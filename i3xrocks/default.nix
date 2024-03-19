let

  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";

  pkgs = import nixpkgs { config = {}; overlays = []; };

in


pkgs.stdenv.mkDerivation {
pname= "i3xrocks";
version="v1.0";

src= pkgs.fetchFromGitHub{
owner= "regolith-linux";
repo="i3xrocks";
rev="master";
sha256="a8RwSoZElGwqkxnRtn/FeNMzXeS8PnfXhMQpYSuYD0I=";
};

buildInputs=with pkgs; [
    autoconf
    automake   
    gcc
    gdb
nix-bash-completions
pkg-config
gnumake
xcbutilxrm
xorg.xcbutil
  ];

buildPhase = ''
    ./autogen.sh
    ./configure
    make 
  '';

  installPhase = ''
    make install DESTDIR=$out/bin
  '';
  

}
