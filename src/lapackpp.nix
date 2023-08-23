{ stdenv, lib, fetchFromGitHub, cmake, writeText, python3, openblas, blaspp }:

stdenv.mkDerivation rec {

  pname = "lapackpp";
  version = "0.5.0";
  enableParallelBuilding = true;
  # TODO: change openblas to some lapack implementation
  # I just put this here so that it compiles
  buildInputs = [ cmake python3 openblas blaspp ];
  src = fetchFromGitHub {
    owner = "icl-utk-edu";
    repo = pname;
    rev = "d56e2d7e7a2b5610b31b5ab3b2e4d7ad105e3dc1";
    sha256 = "sha256-QibYZmd97/BrEIAfN7VQcezdB1ZW1VXoM5cm8HPqUS0=";
  };

}
