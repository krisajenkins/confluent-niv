{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "confluent-cli";
  version = "3.1.1";
  src = pkgs.fetchurl {
    url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/confluent-cli/archives/${version}/confluent_${version}_darwin_amd64.tar.gz";
    sha256 = "0sicg9ar8db4jkwj6b7jkj8m2mbzrkv59cvd6qiyyw2pwmdjid68";
  };

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D confluent $out/bin/
  '';
}
