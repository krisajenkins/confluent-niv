{ lib, stdenv, pkg-config, zlib, rdkafka, yajl, avro-c, serdes }:

stdenv.mkDerivation rec {
  pname = "kafkacat";

  version = "1.6.0";

  src = builtins.fetchGit {
    url = "https://github.com/edenhill/kafkacat";
    ref = "refs/tags/${version}";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ zlib rdkafka yajl avro-c serdes ];

  preConfigure = ''
    patchShebangs ./configure
  '';

  meta = with lib; {
    description = "A generic non-JVM producer and consumer for Apache Kafka";
    homepage = "https://github.com/edenhill/kafkacat";
    license = licenses.bsd2;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ nyarly ];
  };
}
