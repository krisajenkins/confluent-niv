{ pkgs ? import <nixpkgs> { } }:

{
  confluent = pkgs.callPackage ./confluent.nix {
    jdk = pkgs.openjdk;
  };

  ccloud = pkgs.callPackage ./ccloud.nix { };

  rdkafka = pkgs.callPackage ./rdkafka.nix { };
}
