# This is an example flake.nix for a Switch project based on devkitA64.
# It will work on any devkitPro example with a Makefile out of the box.
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils = { 
      url = "github:numtide/flake-utils";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {self, nixpkgs, flake-utils, ...}:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      packages.amazingmarvin = pkgs.appimageTools.wrapType2 { # or wrapType1
        name = "amazingmarvin";
        src = pkgs.fetchurl {
          url = "https://amazingmarvin.s3.amazonaws.com/Marvin-1.64.4.AppImage";
          hash = "sha256-KfcMLjaFrW4LbIX+kmLRJs0L0Nr7qcpaSE3+QLqyQpk=";
        };
      };
    });
}
