{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "confluent-cloud-cli";
  version = "1.25.0";
  src = pkgs.fetchurl {
    url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/ccloud-cli/archives/${version}/ccloud_v${version}_darwin_amd64.tar.gz";
    sha256 = "0306jg36dpccwyy239r2xvw3bvsrnrdc88390g26fhcb0048qmgb";
  };

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/bin/
    install -m755 -D ccloud $out/bin/
  '';
}
