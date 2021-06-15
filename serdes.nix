{ pkgs, fetchFromGitHub, rdkafka, avro-c, jansson, curl, perl }:

pkgs.stdenv.mkDerivation rec {
  name = "serdes";

  version = "v6.2.0";

  nativeBuildInputs = [ rdkafka avro-c jansson curl ];
  buildInputs = [ perl ];

  src = fetchFromGitHub {
    owner = "confluentinc";
    repo = "libserdes";
    rev = version;
    sha256 = "194ras18xw5fcnjgg1isnb24ydx9040ndciniwcbdb7w7wd901gc";
  };
}
