{ pkgs, rdkafka-src }:

pkgs.stdenv.mkDerivation {
  name = "rdkafka";
  src = rdkafka-src;

  nativeBuildInputs = with pkgs; [ pkgconfig ];
  buildInputs = with pkgs; [ zlib perl python openssl which ];

  NIX_CFLAGS_COMPILE = "-Wno-error=strict-overflow";

  postPatch = ''
    patchShebangs .
  '';

  meta = with pkgs.lib; {
    description = "librdkafka - Apache Kafka C/C++ client library";
    homepage = https://github.com/edenhill/librdkafka;
    license = licenses.bsd2;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ krisajenkins ];
  };
}
