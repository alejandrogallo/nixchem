{ stdenv, lib, fetchFromGitHub, scalapack, openblas, openmpi }:
stdenv.mkDerivation rec {
  pname = "ctf";
  version = "0.7.0";
  enableParallelBuilding = true;
  src = fetchFromGitHub {
    owner = "cc4s";
    repo = pname;
    rev = "53ae5daad851bf3b198ebe1fa761c13b12291116";
    sha256 = "sha256-M6E+SjKTmvf2I0I9y6AAMMwL9hdPSiSCwkCLlCaI3+E=";
  };
  buildInputs = [ scalapack openblas openmpi ];
  doCheck = false;
  configurePhase = ''
    bash \
      configure \
      --install-dir=$out \
      CXX="mpic++ -std=c++11" \
      LD_LIBS="-L${openblas}/lib -lopenblas -L${scalapack}/lib -lscalapack"
  '';

  installPhase = ''
    mkdir -p $out/include $out/src $out/lib
    make install INSTALL_DIR=$out
    cp -r $src/include $out/
    cp -r $src/src $out/
    cp -r lib $out/
  '';

  meta = with lib; {
    homepage = "https://github.com/cyclops-community/ctf";
    description = "Cyclops tensor framework";
  };
}
