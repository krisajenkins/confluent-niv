{ pkgs, confluent-cli-src }:

pkgs.stdenv.mkDerivation {
  name = "confluent-cli";
  src = confluent-cli-src;

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D confluent $out/bin/
  '';
}
