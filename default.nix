{ pkgs ? import <nixpkgs> { } }:

let
  inherit (pkgs.lib) callPackageWith;
  inherit (pkgs.lib) callPackagesWith;
  inherit (pkgs) pythonPackages;
  inherit (pkgs) perlPackages;
  inherit (pkgs) buildPerlPackage;
  callPackage = callPackageWith (pkgs // self.nixchem);
  callPackage_i686 = callPackageWith (pkgs.pkgsi686Linux // self.nixchem);
  callPackages = callPackagesWith (pkgs // self.nixchem);

  self.nixchem = rec {
    openblas = pkgs.openblas.override { blas64 = false; };
    sisi4s = callPackage ./src/sisi4s.nix { };
    cc4s = callPackage ./src/cc4s.nix { };
    ctf = callPackage ./src/ctf.nix { };
    #
    madness = callPackage ./src/madness.nix { };
    tiledarray = callPackage ./src/tiledarray.nix { };
    BTAS = callPackage ./src/btas.nix { };
    blaspp = callPackage ./src/blaspp.nix { };
    lapackpp = callPackage ./src/lapackpp.nix { };
    blt = callPackage ./src/blt.nix { };
    umpire = callPackage ./src/umpire.nix { };
    camp = callPackage ./src/camp.nix { };
    kit-cmake = callPackage ./src/kit-cmake.nix { };
    linalg-cmake-modules = callPackage ./src/linalg-cmake-modules.nix { };
    slate = callPackage ./src/slate.nix { };
    testsweeper = callPackage ./src/testsweeper.nix { };
    #
    xcrysden = callPackage ./src/xcrysden.nix { };
  };

in self.nixchem
