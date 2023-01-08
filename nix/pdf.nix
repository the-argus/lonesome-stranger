{
  stdenv,
  texlive,
  pandoc,
  python310,
  ...
}:
stdenv.mkDerivation {
  name = "lonesome-stranger-pdf";
  src = ../pdf;

  nativeBuildInputs = [
    texlive.combined.scheme-small
    pandoc
    (python310.withPackages (ps: [ps.weasyprint]))
  ];

  buildPhase = ''
    pandoc class.md -o class.pdf --css class.css --pdf-engine=weasyprint
  '';

  installPhase = ''
    mkdir $out
    mv class.pdf $out/
  '';
}
