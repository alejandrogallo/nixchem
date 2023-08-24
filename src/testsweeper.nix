{ stdenv, lib, fetchFromGitHub, cmake, mpi, blaspp, lapackpp, writeText
, gfortran }:

stdenv.mkDerivation rec {

  pname = "testsweeper";
  version = "x.x.x";
  enableParallelBuilding = true;
  buildInputs = [ cmake gfortran mpi blaspp lapackpp ];
  src = fetchFromGitHub {
    owner = "icl-utk-edu";
    repo = pname;
    rev = "e4f4826c81bd98738e97a2fee96d85a814c74272";
    sha256 = "sha256-X/e+gswcHfbBZfJKL8oA5V4LwfnVQ8prCIo7EQbMiY8=";
  };

}

