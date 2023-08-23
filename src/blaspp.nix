{ stdenv, lib, fetchFromGitHub, cmake, writeText, python3, openblas }:

stdenv.mkDerivation rec {

  pname = "blaspp";
  version = "0.5.0";
  enableParallelBuilding = true;
  buildInputs = [ cmake python3 openblas ];
  src = fetchFromGitHub {
    owner = "icl-utk-edu";
    repo = pname;
    rev = "c06a72b7e77708f56c6bb1149421c076537c1ecc";
    sha256 = "sha256-0sM8WO7NBjWWB39H7kxCeyZloGwHfaGJHUG51Jb+a8k=";
  };

}

