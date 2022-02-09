{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "confluent-cloud-cli";
  version = "2.2.0";
  src = pkgs.fetchurl {
    url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/confluent-cli/archives/${version}/confluent_v${version}_darwin_amd64.tar.gz";
    sha256 = "0s71y4zw2anjk3iih6jng1n2jrccrpjhl9rj9b7qp8i958h1qhrm";
  };

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D confluent $out/bin/
  '';
}
