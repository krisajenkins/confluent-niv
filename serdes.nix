{ pkgs, rdkafka, serdes-src }:

pkgs.stdenv.mkDerivation {
  name = "serdes";
  src = serdes-src;

  nativeBuildInputs = with pkgs; [ rdkafka avro-c jansson curl ];
  buildInputs = with pkgs; [ perl ];
}
