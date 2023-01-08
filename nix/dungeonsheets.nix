{
  buildPythonPackage,
  fetchFromGitHub,
  lib,
  ...
}:
buildPythonPackage {
  pname = "dungeonsheets";
  version = "0.15.0-master";
  src = fetchFromGitHub {
    owner = "canismarko";
    repo = "dungeon-sheets";
    rev = "33bffa806df356c779b8306243e48362e0e43433";
    sha256 = lib.fakeSha256;
  };
}
