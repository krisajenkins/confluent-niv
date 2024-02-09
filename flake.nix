{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    utils.url = "github:numtide/flake-utils";

    rdkafka-src = {
      url = "github:edenhill/librdkafka?ref=v2.3.0";
      # url = "github:edenhill/librdkafka?ref=v2.2.0";
      flake = false;
    };

    libserdes-src = {
      url = "github:confluentinc/libserdes?ref=v6.2.4";
      flake = false;
    };

    kcat-src = {
      url = "github:edenhill/kcat?ref=1.7.1";
      flake = false;
    };

    # TODO This shouldn't be pinned to darwin.
    # https://docs.confluent.io/confluent-cli/current/release-notes.html
    confluent-cli-src = {
      url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/confluent-cli/archives/3.48.1/confluent_3.48.1_darwin_amd64.tar.gz";
      flake = false;
    };

    confluent-platform-src = {
      url = "http://packages.confluent.io/archive/7.5/confluent-7.5.3.tar.gz";
      flake = false;
    };

    kafka-connector-http-source = {
      url = "file+https://github.com/castorm/kafka-connect-http/releases/download/v0.8.11/castorm-kafka-connect-http-0.8.11.zip";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , utils
    , rdkafka-src
    , libserdes-src
    , kcat-src
    , confluent-cli-src
    , confluent-platform-src
    , kafka-connector-http-source
    }:
    utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      rdkafka = import ./rdkafka.nix {
        inherit pkgs rdkafka-src;
      };

      libserdes = import ./libserdes.nix {
        inherit pkgs rdkafka libserdes-src;
      };

      kcat = import ./kcat.nix {
        inherit pkgs rdkafka libserdes kcat-src;
      };

      confluent-cli = import ./confluent-cli.nix {
        inherit pkgs confluent-cli-src;
      };

      confluent-platform = import ./confluent-platform.nix {
        inherit pkgs confluent-platform-src kafka-connector-http-source;
      };
    in
    {
      packages = rec {
        inherit rdkafka libserdes kcat;
        inherit confluent-platform confluent-cli;
      };

      devShell = with pkgs; mkShell {
        buildInputs = [
          kcat
          confluent-platform
          confluent-cli
        ];
      };
    });
}
