{ lib, stdenv, pkg-config, zlib, rdkafka, yajl, avro-c, serdes, which }:

stdenv.mkDerivation rec {
  pname = "kcat";
  version = "1.7.1";

  src = builtins.fetchGit {
    url = "https://github.com/edenhill/kcat";
    ref = "refs/tags/${version}";
    rev = "f2236ae5d985b9f31631b076df24ca6c33542e61";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ zlib rdkafka yajl avro-c serdes which ];

  preConfigure = ''
    patchShebangs ./configure
  '';

  meta = with lib; {
    description = "A generic non-JVM producer and consumer for Apache Kafka";
    homepage = "https://github.com/edenhill/kcat";
    license = licenses.bsd2;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ nyarly ];
  };
}
