{ lib
, stdenv
, cmake
, clang-tools_16
, gtest
, lldb_16
, mold
, ninja
, spdlog
, valgrind
, enableTests ? true
}:

stdenv.mkDerivation {
  name = "CppTemplApp";

  # good source filtering is important for caching of builds.
  # It's easier when subprojects have their own distinct subfolders.
  src = lib.sourceByRegex ./. [
    "^app.*"
    "^cmake.*"
    "^src.*"
    "^tests.*"
    "CMakeLists.txt"
  ];

  # Distinguishing between native build inputs (runnable on the host
  # at compile time) and normal build inputs (runnable on target
  # platform at run time) is important for cross compilation.
  nativeBuildInputs = [
    cmake
    clang-tools_16
    lldb_16
    mold
    ninja
    valgrind
  ];
  buildInputs = [
    spdlog
  ];
  checkInputs = [
    gtest
  ];

  doCheck = enableTests;
  cmakeFlags = lib.optional (!enableTests) "-DTESTING=off";
}
