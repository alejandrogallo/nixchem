{ stdenv, lib, autoconf, automake, fetchFromGitHub, scalapack, openblas, openmpi
, ctf, git, gfortran, eigen, yaml-cpp, libint, boost, writeText }:

stdenv.mkDerivation rec {
  pname = "sisi4s";
  version = "0.5.0";
  enableParallelBuilding = true;
  src = fetchFromGitHub {
    owner = "alejandrogallo";
    repo = pname;
    rev = "28e2cf2e4ed2f57cc418d32bbb1a0bbf15257e38";
    sha256 = "sha256-njNalN7ODBA0mHadXOnxLNjb6NdUUYgQYa5QHpoJs0k";
  };
  nativeBuildInputs = [ ];
  buildInputs =
    [ scalapack gfortran openblas openmpi git autoconf automake boost ];
  doCheck = false;
  configurePhase = ''
    autoreconf -vif
    sed -i /Uccsdt/d src/Makefile.am
    mkdir build
    cd build
    ../configure --prefix=$out \
        --with-ctf=${ctf} \
        --with-libint=${libint} \
        --with-yamlcpp=${yaml-cpp} \
        --with-eigen=${eigen}
  '';

  installPhase = ''
    make install INSTALL_DIR=$out
  '';

  meta = with lib; {
    homepage = "https://github.com/alejandrogallo/sisi4s";
    description = "A quantum chemistry package for coupled cluster";
  };
}
