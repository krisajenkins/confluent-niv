{ lib, stdenv, zlib, perl, pkgconfig, python, openssl, which }:

stdenv.mkDerivation rec {
  name = "rdkafka";
  version = "v1.9.2";

  src = builtins.fetchGit {
    url = "https://github.com/edenhill/librdkafka";
    ref = "refs/tags/${version}";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ zlib perl python openssl which ];

  NIX_CFLAGS_COMPILE = "-Wno-error=strict-overflow";

  postPatch = ''
    patchShebangs .
  '';

  meta = with lib; {
    description = "librdkafka - Apache Kafka C/C++ client library";
    homepage = https://github.com/edenhill/librdkafka;
    license = licenses.bsd2;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ boothead wkennington ];
  };
}
