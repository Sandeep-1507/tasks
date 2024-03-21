{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/06278c77b5d162e62df170fec307e83f1812d94b.tar.gz") {} }:

pkgs.python311.pkgs.buildPythonApplication {
  pname = "rofication";
  version = "v1.0";
  
  src = pkgs.fetchFromGitHub {
    owner = "regolith-linux";
    repo = "regolith-rofication";
    rev = "ba61e7b58f02304d6ec579d9966b656a5916d698";
    sha256 = "9UKKENrEicQKBWLczQFHmfsa9yxoKTGd+dTDZ/YdkS0=";
  };
  
 propagatedBuildInputs = with pkgs.python311.pkgs; [dbus-python pygobject3];
  
  

  installPhase= ''
  mkdir -p $out/bin
  cp -r ./  $out/bin
  
  
  '';
}
