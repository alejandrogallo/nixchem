{ stdenv, lib, autoconf, automake, fetchFromGitHub, openblas, lapack, cmake
, boost, writeText, blaspp, lapackpp }:

let

  patch = writeText "patch" ''
    @@ -20,16 +20,9 @@ if (DEFINED PROJECT_BINARY_DIR)
     else ()
       set(VG_CMAKE_KIT_PREFIX_DIR CMAKE_CURRENT_BINARY_DIR)
     endif()
    -FetchContent_Declare(
    -        vg_cmake_kit
    -        QUIET
    -        GIT_REPOSITORY      https://github.com/ValeevGroup/kit-cmake.git
    -        SOURCE_DIR ''${''${VG_CMAKE_KIT_PREFIX_DIR}}/cmake/vg
    -        BINARY_DIR ''${''${VG_CMAKE_KIT_PREFIX_DIR}}/cmake/vg-build
    -        SUBBUILD_DIR ''${''${VG_CMAKE_KIT_PREFIX_DIR}}/cmake/vg-subbuild
    -)
    -FetchContent_MakeAvailable(vg_cmake_kit)
    -list(APPEND CMAKE_MODULE_PATH "''${vg_cmake_kit_SOURCE_DIR}/modules")
    +set(vg_cmake_kit_SOURCE_DIR "${kit-cmake-src}")
    +list(APPEND CMAKE_MODULE_PATH "${kit-cmake-src}/modules")
    +FetchContent_Declare(linalg-cmake-modules SOURCE_DIR "${linalg-cmake-modules}")

     ###############################################################################
     # Announce ourselves

  '';

  kit-cmake-src = fetchFromGitHub {
    owner = "ValeevGroup";
    repo = "kit-cmake";
    rev = "869953d7c122535963af1949ebb854680b6849a3";
    sha256 = "sha256-NbEP/NkXMRs1z5AB3ycXUAoiK9q4aZ0S3itSbWpNfB0=";
  };

  linalg-cmake-modules = fetchFromGitHub {
    owner = "wavefunction91";
    repo = "linalg-cmake-modules";
    rev = "28ceaa9738f14935aa544289fa2fe4c4cc955d0e";
    sha256 = "sha256-EGPubUYlZjgJRnUdtgCG+aKcmkpQk1m9N3VVYMgIwic=";
  };

in stdenv.mkDerivation rec {
  pname = "BTAS";
  version = "0.5.0";
  enableParallelBuilding = true;
  src = fetchFromGitHub {
    owner = "ValeevGroup";
    repo = pname;
    rev = "33d22182c52c3c51099f17a8957872a5fd6a32e5";
    sha256 = "sha256-E08M0uYSkyIRRJH0xTt2lKf+T/pPlEFdrRen+SQqnd0=";
  };
  buildInputs = [ boost openblas lapack cmake blaspp lapackpp ];
  doCheck = false;
  configurePhase = ''
    mkdir build
    patch -u CMakeLists.txt -i ${patch}
    #cat CMakeLists.txt
    cd build
    echo ${linalg-cmake-modules}
    mkdir -p _deps/linalg-cmake-modules-src/
    cp -r ${linalg-cmake-modules} _deps/linalg-cmake-modules-src/
    cmake ../ -DCMAKE_INSTALL_PREFIX=$out
  '';

  meta = with lib; {
    homepage = "https://github.com/ValeevGroup/BTAS";
    description = "Something something";
  };
}
