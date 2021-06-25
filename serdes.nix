{ pkgs, rdkafka, avro-c, jansson, curl, perl }:

pkgs.stdenv.mkDerivation rec {
  name = "serdes";

  version = "v6.2.0";

  nativeBuildInputs = [ rdkafka avro-c jansson curl ];
  buildInputs = [ perl ];

  src = builtins.fetchGit {
    url = "https://github.com/confluentinc/libserdes/";
    ref = "refs/tags/${version}";
  };
}
