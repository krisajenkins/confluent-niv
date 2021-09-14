{ pkgs ? import <nixpkgs> { } }:

let
  serdes = pkgs.callPackage ./serdes.nix { };

in
{
  inherit serdes;

  confluent = pkgs.callPackage ./confluent.nix {
    jdk = pkgs.openjdk;
  };

  ccloud = pkgs.callPackage ./ccloud.nix { };

  rdkafka = pkgs.callPackage ./rdkafka.nix { };

  kcat = pkgs.callPackage ./kcat.nix {
    inherit serdes;
  };
}
