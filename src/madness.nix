{ stdenv, lib, autoconf, automake, fetchFromGitHub, openblas, cmake, openmpi
, python3 }:
stdenv.mkDerivation rec {
  pname = "madness";
  version = "0.5.0";
  enableParallelBuilding = true;
  src = fetchFromGitHub {
    owner = "m-a-d-n-e-s-s";
    repo = pname;
    rev = "b0dc838233880b58a20dc04b6229223d28918800";
    sha256 = "sha256-fFuTQo+VPrBjrTJ0XvJSz+ztdWibMD9PevMP2LeXdP4=";
  };
  buildInputs = [ openblas openmpi cmake python3 ];
  doCheck = false;
  configurePhase = ''
    mkdir build
    cd build
    cmake ../ -DCMAKE_INSTALL_PREFIX=$out -DENABLE_MPI=ON
  '';

  buildPhase = ''
    make applications
  '';

  meta = with lib; {
    homepage = "https://github.com/m-a-d-n-e-s-s/madness";
    description =
      "Multiresolution Adaptive Numerical Environment for scientific simulation";
  };
}
