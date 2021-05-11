{ pkgs, ccloud }:

pkgs.stdenv.mkDerivation {
  name = "confluent-cloud-cli";
  src = ccloud;

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D ccloud $out/bin/
  '';
}
