{ pkgs ? import <nixpkgs> { } }:

let
  jdk = pkgs.openjdk;
in
rec {

  confluent = pkgs.callPackage ./confluent.nix {
    inherit jdk;
  };

  ccloud = pkgs.callPackage ./ccloud.nix {
    inherit pkgs;
    inherit (sources) ccloud;
  };

  rdkafka = pkgs.callPackage ./rdkafka.nix { };
};
