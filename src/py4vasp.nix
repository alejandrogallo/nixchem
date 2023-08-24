# TODO
{ stdenv, lib, python3Packages, fetchFromGitHub, poetry }:

stdenv.mkDerivation rec {

  pname = "py4vasp";
  version = "x.x.x";
  enableParallelBuilding = true;
  format = "poetry";
  propagatedBuildInputs = with python3Packages; [
    python
    numpy
    h5py
    pandas
    # nglview
    # mrcfile
    # kaleido
    ase
    plotly
    ipython
    pytest
    poetry-core
  ];
  testPhase = ''
    echo testing
  '';
  buildPhase = ''
    poetry install
  '';
  buildInputs = [ poetry ];
  src = fetchFromGitHub {
    owner = "vasp-dev";
    repo = pname;
    rev = "b4f74e32c8951e2e0edc4dadab83c5ceee492f0e";
    sha256 = "sha256-rIxAdSuWvmtqZLx1f5XoH5ApxuquvH3Io9B88O4ur8k=";
  };

}

