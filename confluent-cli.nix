{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "confluent-cli";
  version = "2.8.0";
  src = pkgs.fetchurl {
    url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/confluent-cli/archives/${version}/confluent_v${version}_darwin_amd64.tar.gz";
    sha256 = "0ij3m85x0phsmj8kxcnxhxgwha5pvpamqc0qkhfl3dwgdwjcpsqk";
  };

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D confluent $out/bin/
  '';
}
