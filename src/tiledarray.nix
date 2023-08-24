{ stdenv, lib, autoconf, automake, fetchFromGitHub, cmake, boost, writeText
, madness, BTAS, eigen, breakpointHook, umpire, blaspp, kit-cmake
, linalg-cmake-modules, openblas }:

let
  # TODO: use this from the documentation
  madness-tags = {
    rev = "3d585293f0094588778dbd3bec24b65e7bbe6a5d";
    hash = "llll";
  };
  btas-tag = {
    rev = "3c91f086090390930bba62c6512c4e74a5520e76";
    hash = "lalalala";
  };

  patch = writeText "patch" ''
    @@ -56,17 +56,10 @@
     else ()
       set(VG_CMAKE_KIT_PREFIX_DIR CMAKE_CURRENT_BINARY_DIR)
     endif()
    -FetchContent_Declare(
    -    vg_cmake_kit
    -    QUIET
    -    GIT_REPOSITORY      https://github.com/ValeevGroup/kit-cmake.git
    -    GIT_TAG             ''${TA_TRACKED_VGCMAKEKIT_TAG}
    -    SOURCE_DIR ''${''${VG_CMAKE_KIT_PREFIX_DIR}}/cmake/vg
    -    BINARY_DIR ''${''${VG_CMAKE_KIT_PREFIX_DIR}}/cmake/vg-build
    -    SUBBUILD_DIR ''${''${VG_CMAKE_KIT_PREFIX_DIR}}/cmake/vg-subbuild
    -)
    -FetchContent_MakeAvailable(vg_cmake_kit)
    -list(APPEND CMAKE_MODULE_PATH "''${vg_cmake_kit_SOURCE_DIR}/modules")
    +set(vg_cmake_kit_SOURCE_DIR "${kit-cmake}")
    +list(APPEND CMAKE_MODULE_PATH "''${vg_cmake_kit_SOURCE_DIR}/modules")
    +FetchContent_Declare(linalg-cmake-modules SOURCE_DIR "${linalg-cmake-modules}")
    +

     # Declare ourselves ============================================================
     project(TiledArray
    @@ -333,7 +325,9 @@
     endif(ENABLE_WFN91_LINALG_DISCOVERY_KIT)
     # BTAS does a better job of building and checking Boost since it uses Boost::serialization
     # it also memorized the location of its config for use from install tree
    -include(''${PROJECT_SOURCE_DIR}/cmake/modules/FindOrFetchBTAS.cmake)
    +#include(''${PROJECT_SOURCE_DIR}/cmake/modules/FindOrFetchBTAS.cmake)
    +find_package_regimport(blaspp 1.0.0 QUIET CONFIG)
    +#find_package_regimport(BTAS 1.0.0 QUIET CONFIG)
     include(''${PROJECT_SOURCE_DIR}/cmake/modules/FindOrFetchBoost.cmake)
     if(ENABLE_SCALAPACK)
       include(external/scalapackpp.cmake)

  '';

in stdenv.mkDerivation rec {

  pname = "tiledarray";
  version = "0.5.0";
  enableParallelBuilding = true;
  buildInputs =
    [ boost cmake eigen BTAS madness umpire openblas blaspp kit-cmake ];
  src = fetchFromGitHub {
    owner = "ValeevGroup";
    repo = pname;
    rev = "efba9d1ea6e772ecf767ecdb26cf85ba07cff7b4";
    sha256 = "sha256-jQW8K+0KrhFbIxZ5CLy7Zqc1uSST/wSSXQcVVUod6Ew=";
  };
  configurePhase = ''
    mkdir build
    patch -u CMakeLists.txt -i ${patch}
    cd build
    mkdir -p _deps/linalg-cmake-modules-src/
    cmake ../ -DCMAKE_INSTALL_PREFIX=$out \
      -DENABLE_WFN91_LINALG_DISCOVERY_KIT=YES \
      -DCMAKE_BUILD_TYPE=Release
  '';
}

