{ stdenv, lib, fetchFromGitHub, cmake, blt }:

stdenv.mkDerivation rec {

  pname = "camp";
  version = "0.5.0";
  enableParallelBuilding = true;
  buildInputs = [ cmake blt ];
  src = fetchFromGitHub {
    owner = "LLNL";
    repo = pname;
    rev = "ac34c25b722a06b138bc045d38bfa5e8fa3ec9c5";
    sha256 = "sha256-bXIvn88VyYRPqqfYHVFEy4lkgVvEbit5vlflQPdmIbI";
  };

  cmakeFlags = [ "-DBLT_SOURCE_DIR=${blt}" ];
}

