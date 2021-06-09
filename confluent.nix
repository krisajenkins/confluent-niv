{ stdenv
, lib
, fetchurl
, jdk
, makeWrapper
, bash
, ps
, gnused
}:

stdenv.mkDerivation rec {
  pname = "confluent-platform";
  version = "6.2.0";

  src = fetchurl {
    url = "http://packages.confluent.io/archive/${lib.versions.majorMinor version}/confluent-${version}.tar.gz";
    sha256 = "0s0s5zrppzhlwrmp9ky39mmmwhl659nxm4zbl6l7l4ap9lzdz5q5";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ jdk bash ps ];

  dontFixup = true;

  installPhase = ''
    mkdir -p $out
    cp -R * $out

    rm -rf $out/bin/windows

    # Customise and fix the configuration.
    substituteInPlace $out/etc/kafka/server.properties \
      --replace "#advertised.listeners=PLAINTEXT://your.host.name:9092" \
                 "advertised.listeners=PLAINTEXT://localhost:9092"

    echo >> $out/etc/ksqldb/ksql-server.properties
    echo 'ksql.streams.replication.factor = 1' >> $out/etc/ksqldb/ksql-server.properties

    substituteInPlace $out/etc/ksqldb/ksql-server.properties \
      --replace "# ksql.schema.registry.url=http://localhost:8081" \
                  "ksql.schema.registry.url=http://localhost:8081"

    patchShebangs $out/bin

    # allow us the specify logging directory using env
    substituteInPlace $out/bin/kafka-run-class \
      --replace 'LOG_DIR="$base_dir/logs"' 'LOG_DIR="$KAFKA_LOG_DIR"'

    substituteInPlace $out/bin/ksql-run-class \
      --replace 'LOG_DIR="$base_dir/logs"' 'LOG_DIR="$KAFKA_LOG_DIR"'

    for p in $out/bin\/*; do
      wrapProgram $p \
        --set KAFKA_LOG_DIR "/tmp/apache-kafka-logs"
    done

    $out/bin/confluent-hub install confluentinc/kafka-connect-aws-lambda:1.1.1 --no-prompt
  '';

  meta = with lib; {
    homepage = "https://www.confluent.io/";
    description = "Confluent event streaming platform based on Apache Kafka";
    license = licenses.asl20;
    maintainers = [ maintainers.offline ];
    platforms = platforms.unix;
  };
}
