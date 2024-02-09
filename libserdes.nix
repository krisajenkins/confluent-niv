{ pkgs, rdkafka, libserdes-src }:

pkgs.stdenv.mkDerivation {
  name = "libserdes";
  src = libserdes-src;

  nativeBuildInputs = with pkgs; [ rdkafka avro-c jansson curl ];
  buildInputs = with pkgs; [ perl ];
}
