let
  # TODO: use this from the documentation
  madness-tags = {
    rev = "3d585293f0094588778dbd3bec24b65e7bbe6a5d";
    hash = "llll";
  };
  btas-tag = {
    rev = "3c91f086090390930bba62c6512c4e74a5520e76";
    hash = "lalalala";
  };

in { stdenv, lib, autoconf, automake, fetchFromGitHub, cmake, boost, writeText
, madness, BTAS, eigen }:
stdenv.mkDerivation rec {

  pname = "tiledarray";
  version = "0.5.0";
  enableParallelBuilding = true;
  buildInputs = [ boost cmake eigen BTAS madness ];
  src = fetchFromGitHub {
    owner = "ValeevGroup";
    repo = pname;
    rev = "efba9d1ea6e772ecf767ecdb26cf85ba07cff7b4";
    sha256 = "sha256-jQW8K+0KrhFbIxZ5CLy7Zqc1uSST/wSSXQcVVUod6Ew=";
  };
}

