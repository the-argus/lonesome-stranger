{
  python310Packages,
  fetchFromGitHub,
  # freetype,
  ...
}:
python310Packages.buildPythonPackage {
  pname = "dungeonsheets";
  version = "0.15.0-master";

  propagatedBuildInputs = with python310Packages; [
    sphinx
    pdfrw
    npyscreen
    jinja2
    reportlab
    certifi
    fdfgen
    EBookLib
    pillow
  ];

  src = fetchFromGitHub {
    owner = "canismarko";
    repo = "dungeon-sheets";
    rev = "33bffa806df356c779b8306243e48362e0e43433";
    sha256 = "sha256-+8or4a+LTAJq662SyAyQebgY6qafQRxBaUvS9BFjTMQ=";
  };
}
