{ stdenv, lib, fetchFromGitHub, cmake, blt, camp }:

stdenv.mkDerivation rec {

  pname = "umpire";
  version = "0.5.0";
  enableParallelBuilding = true;
  buildInputs = [ cmake blt ];
  src = fetchFromGitHub {
    owner = "LLNL";
    repo = pname;
    rev = "df4f4c972386b4eb9ad36979320e441c4c7e7d68";
    sha256 = "sha256-p9gKzUdr3lVY3BMnxC0Klc7l3WYn9gBpSWvsU3JvlYs=";
  };

  cmakeFlags = [ "-DBLT_SOURCE_DIR=${blt}" "-Dcamp_DIR=${camp}" ];

}

