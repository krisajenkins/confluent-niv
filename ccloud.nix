{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "confluent-cloud-cli";
  src = pkgs.fetchurl {
    url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/ccloud-cli/archives/latest/ccloud_latest_darwin_amd64.tar.gz";
    sha256 = "0zpdyz1aa2xgcrn4465wjlj8h4ylbh8p237dc7hap0nl97y05shf";
  };

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D ccloud $out/bin/
  '';
}
