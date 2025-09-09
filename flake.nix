{
  description = "A Typst project that uses Typst packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs@{
      nixpkgs,
      typix,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs) lib;

        typixLib = typix.lib.${system};

        src = typixLib.cleanTypstSource ./.;
        commonArgs = {
          typstSource = "main.typ";

          fontPaths = [
            # Add paths to fonts here
            "${pkgs.libertinus}/share/fonts/opentype"
            "${pkgs.iosevka}/share/fonts/truetype"
            "${pkgs.lxgw-wenkai}/share/fonts/truetype"
          ];

          virtualPaths = [
            # Add paths that must be locally accessible to typst here
            {
              dest = "fonts/libertinus";
              src = "${pkgs.libertinus}/share/fonts/opentype";
            }
            {
              dest = "fonts/iosevka";
              src = "${pkgs.iosevka}/share/fonts/truetype";
            }
            {
              dest = "fonts/lxgw-wenkai";
              src = "${pkgs.lxgw-wenkai}/share/fonts/truetype";
            }
          ];
        };

        unstable_typstPackages = [
          {
            name = "physica";
            version = "0.9.5";
            hash = "sha256-tJOa6emrJO7I5SRaTmL0w8w1Bwo8di/F/F72XMJ47pM=";
          }
        ];

        mkTypstArtifacts = import (nix/mkTypstArtifacts.nix);

        name = "lecture-notes";
        artifacts = mkTypstArtifacts {
          inherit name;
          inherit typixLib flake-utils;
          inherit commonArgs src unstable_typstPackages;
        };

      in
      {
        checks = artifacts.drvs;
        apps = artifacts.apps // {
          default = artifacts.apps."watch-${name}";
        };
      }
    );
}
