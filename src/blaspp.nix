{ stdenv, lib, fetchFromGitHub, cmake, writeText, python3, openblas }:

stdenv.mkDerivation rec {

  pname = "blaspp";
  version = "1.0.0";
  enableParallelBuilding = true;
  buildInputs = [ cmake python3 openblas ];
  src = fetchFromGitHub {
    owner = "icl-utk-edu";
    repo = pname;
    rev = "0e87dc25ba0eae405fe6757a6d735ffbd6026585";
    sha256 = "sha256-sm18bvi/VFRXGRd/qnUdtT0fORBXlFUanVFDWK+mUn0=";
  };

}

