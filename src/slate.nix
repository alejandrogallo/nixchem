{ stdenv, lib, fetchFromGitHub, cmake, mpi, blaspp, lapackpp, writeText
, openblas, gfortran, testsweeper, scalapack }:

stdenv.mkDerivation rec {

  pname = "slate";
  version = "x.x.x";
  enableParallelBuilding = true;
  buildInputs =
    [ cmake gfortran mpi blaspp lapackpp testsweeper openblas scalapack ];
  src = fetchFromGitHub {
    owner = "icl-utk-edu";
    repo = pname;
    rev = "ca96ede0515e28396bd22a2ca426eb6ab7d667d6";
    sha256 = "sha256-Mv6G+xIDvyPgRBATeGjdfCwAXQMbKCkiusWr0OCMFKs";
  };
  CXXFLAGS = [ "-DSLATE_HAVE_MT_BCAST" ];

}

