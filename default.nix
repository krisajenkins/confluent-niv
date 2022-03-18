{ pkgs ? import <nixpkgs> { } }:

let
  serdes = pkgs.callPackage ./serdes.nix { };

in
rec
{
  inherit serdes;

  confluent-platform = pkgs.callPackage ./confluent-platform.nix {
    jdk = pkgs.openjdk;
  };
  confluent = confluent-platform; # Deprecated alias.

  confluent-cli = pkgs.callPackage ./confluent-cli.nix { };
  ccloud = confluent-cli; # Deprecated alias.

  rdkafka = pkgs.callPackage ./rdkafka.nix { };

  kcat = pkgs.callPackage ./kcat.nix {
    inherit serdes;
  };
}
