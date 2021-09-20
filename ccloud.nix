{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "confluent-cloud-cli";
  version = "1.39.1";
  src = pkgs.fetchurl {
    url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/ccloud-cli/archives/${version}/ccloud_v${version}_darwin_amd64.tar.gz";
    sha256 = "1p06r36f2yfy6pb86pafc49w56c4lfan4gg2ghngpfv7ji6x5hll";
  };

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D ccloud $out/bin/
  '';
}
