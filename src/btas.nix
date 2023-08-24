{ stdenv, lib, autoconf, automake, fetchFromGitHub, openblas, lapack, cmake
, boost, writeText, blaspp, lapackpp, kit-cmake, linalg-cmake-modules }:

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
    +set(vg_cmake_kit_SOURCE_DIR "${kit-cmake}")
    +list(APPEND CMAKE_MODULE_PATH "${kit-cmake}/modules")
    +FetchContent_Declare(linalg-cmake-modules SOURCE_DIR "${linalg-cmake-modules}")

     ###############################################################################
     # Announce ourselves

  '';

in stdenv.mkDerivation rec {
  pname = "BTAS";
  version = "0.5.0";
  enableParallelBuilding = true;
  src = fetchFromGitHub {
    owner = "ValeevGroup";
    repo = pname;
    #rev = "33d22182c52c3c51099f17a8957872a5fd6a32e5";
    rev = "3c91f086090390930bba62c6512c4e74a5520e76";
    #sha256 = "sha256-E08M0uYSkyIRRJH0xTt2lKf+T/pPlEFArRen+SQqnd0=";
    sha256 = "sha256-FMKf6CFcD2LiiDBuFfpSMI+mVQlNNiq3J4wb9/kbkQM=";
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
  installPhase = ''
    make install
  '';

  meta = with lib; {
    homepage = "https://github.com/ValeevGroup/BTAS";
    description = "Something something";
  };
}
