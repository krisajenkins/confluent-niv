{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "confluent-cli";
  version = "2.28.1";
  src = pkgs.fetchurl {
    url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/confluent-cli/archives/${version}/confluent_v${version}_darwin_amd64.tar.gz";
    sha256 = "1mvg1z2hkims7x0zwsnhwf46dzgly97ci2gd8hd0730l9v4cig4n";
  };

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D confluent $out/bin/
  '';
}
