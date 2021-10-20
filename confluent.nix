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
    rm -rf bin/windows

    # Customise and fix the configuration.
    substituteInPlace etc/kafka/server.properties \
      --replace "#advertised.listeners=PLAINTEXT://your.host.name:9092" \
                 "advertised.listeners=PLAINTEXT://localhost:9092" \
      --replace "log.retention.hours=168" \
                "log.retention.hours=-1"

    echo >> etc/ksqldb/ksql-server.properties
    echo 'ksql.streams.replication.factor = 1' >> etc/ksqldb/ksql-server.properties

    substituteInPlace etc/ksqldb/ksql-server.properties \
      --replace "# ksql.schema.registry.url=http://localhost:8081" \
                  "ksql.schema.registry.url=http://localhost:8081"

    patchShebangs bin

    # allow us the specify logging directory using env
    substituteInPlace bin/kafka-run-class \
      --replace 'LOG_DIR="$base_dir/logs"' 'LOG_DIR="$KAFKA_LOG_DIR"'

    substituteInPlace bin/ksql-run-class \
      --replace 'LOG_DIR="$base_dir/logs"' 'LOG_DIR="$KAFKA_LOG_DIR"'

    for p in bin\/*; do
      wrapProgram $p \
        --set KAFKA_LOG_DIR "/tmp/apache-kafka-logs"
    done

    bin/confluent-hub install --no-prompt confluentinc/kafka-connect-aws-lambda:1.1.2
    bin/confluent-hub install --no-prompt jcustenborder/kafka-connect-spooldir:2.0.62

    mkdir -p $out
    cp -R * $out
  '';

  meta = with lib; {
    homepage = "https://www.confluent.io/";
    description = "Confluent event streaming platform based on Apache Kafka";
    license = licenses.asl20;
    maintainers = [ maintainers.offline ];
    platforms = platforms.unix;
  };
}
