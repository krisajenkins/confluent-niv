{ pkgs ? import <nixpkgs> { } }:

let
  jdk = pkgs.openjdk;
in
rec {

  confluent = pkgs.callPackage ./confluent.nix { };

  ccloud = pkgs.callPackage ./ccloud.nix { };

  rdkafka = pkgs.callPackage ./rdkafka.nix { };
}
