{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.11";
    utils.url = "github:numtide/flake-utils";

    rdkafka-src = {
      url = "github:edenhill/librdkafka?ref=v1.9.2";
      flake = false;
    };

    serdes-src = {
      url = "github:confluentinc/libserdes?ref=v6.2.0";
      flake = false;
    };

    kcat-src = {
      url = "github:edenhill/kcat?ref=1.7.1";
      flake = false;
    };

    # TODO This shouldn't be pinned to darwin.
    confluent-cli-src = {
      url = "https://s3-us-west-2.amazonaws.com/confluent.cloud/confluent-cli/archives/3.1.1/confluent_3.1.1_darwin_amd64.tar.gz";
      flake = false;
    };

    confluent-platform-src = {
      url = "http://packages.confluent.io/archive/7.3/confluent-7.3.1.tar.gz";
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
    , serdes-src
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
    in
    {
      packages = rec {
        rdkafka = import ./rdkafka.nix {
          inherit pkgs rdkafka-src;
        };

        serdes = import ./serdes.nix {
          inherit pkgs rdkafka serdes-src;
        };

        kcat = import ./kcat.nix {
          inherit pkgs rdkafka serdes kcat-src;
        };

        confluent-cli = import ./confluent-cli.nix {
          inherit pkgs confluent-cli-src;
        };

        confluent-platform = import ./confluent-platform.nix {
          inherit pkgs confluent-platform-src kafka-connector-http-source;
        };
      };

      devShell = with pkgs; mkShell {
        buildInputs = [
          kcat
          confluent-cli
          confluent-platform
        ];
      };
    });
}
