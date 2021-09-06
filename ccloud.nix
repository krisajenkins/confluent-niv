{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "confluent-cloud-cli";
  version = "1.39.0";
  src = pkgs.fetchurl {
    url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/ccloud-cli/archives/${version}/ccloud_v${version}_darwin_amd64.tar.gz";
    sha256 = "0jqpmnx3izl4gv02zpx03z6ayi3cb5if4rnyl1374yaclx44k1gd";
  };

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D ccloud $out/bin/
  '';
}
