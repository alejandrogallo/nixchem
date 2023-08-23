{ stdenv, lib, fetchFromGitHub, scalapack, openblas, openmpi, ctf, git, gfortran
, yaml-cpp, writeText }:
let

  nix-config = writeText "nix-config.mk" ''
    include Cc4s.mk

    # compiler and linker
    CXX = mpicxx

    # general and language options (for preprocessing, compiling and linking)
    CXXFLAGS += \
    -fopenmp -std=c++11 \
    -Wall -pedantic --all-warnings -fmax-errors=3 \
    -Wno-vla \
    -Wno-int-in-bool-context

    # optimization options (only for compiling and linking)
    CXXFLAGS += -Ofast -march=native -fno-lto -I${ctf}/include -I${yaml-cpp}/include

    LDFLAGS += \
    -L${gfortran.cc}/lib -lgfortran -lquadmath \
    -L${yaml-cpp}/lib -lyaml-cpp -L${ctf}/lib -lctf -lscalapack -lblas
  '';

in stdenv.mkDerivation rec {
  pname = "cc4s";
  version = "1.0.0";
  enableParallelBuilding = true;
  src = fetchFromGitHub {
    owner = "cc4s";
    repo = pname;
    rev = "a9240bb8ac3e22fff60f45dba0976aaa0c723bdd";
    sha256 = "sha256-u8wXawWV1hn+YfcmS6qLzAkW8LdSNayJod3hyvkUibc=";
  };
  # nativeBuildInputs = [ breakpointHook ];
  buildInputs = [ scalapack gfortran openblas openmpi git ];
  doCheck = false;
  configurePhase = ''
    cp ${nix-config} etc/config/nix-config.mk
  '';
  buildPhase = ''
    make extern CONFIG=nix-config
    make CONFIG=nix-config
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp build/nix-config/bin/Cc4s $out/bin
  '';

  meta = with lib; {
    homepage = "https://github.com/cc4s/cc4s";
    description = "A quantum chemistry package for coupled cluster";
  };
}
