{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "confluent-cloud-cli";
  src = pkgs.fetchurl {
    url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/ccloud-cli/archives/latest/ccloud_latest_darwin_amd64.tar.gz";
    sha256 = "1s0jbbrwx73rbb611k8mmic74qf6grvabpxl4aywwawgpy25kq7q";
  };

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D ccloud $out/bin/
  '';
}
