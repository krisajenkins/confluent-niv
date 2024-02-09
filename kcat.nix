{ pkgs, rdkafka, libserdes, kcat-src }:

pkgs.stdenv.mkDerivation {
  name = "kcat";
  src = kcat-src;

  nativeBuildInputs = with pkgs; [ pkg-config ];

  buildInputs = with pkgs; [ zlib rdkafka yajl avro-c libserdes which ];

  preConfigure = ''
    patchShebangs ./configure
  '';

  meta = with pkgs.lib; {
    description = "A generic non-JVM producer and consumer for Apache Kafka";
    homepage = "https://github.com/edenhill/kcat";
    license = licenses.bsd2;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ krisajenkins ];
  };
}
