{
  description = "A D&D 5e gunslinger class";
  inputs.nixpkgs.url = github:nixos/nixpkgs?ref=nixos-22.11;

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    genSystems = nixpkgs.lib.genAttrs supportedSystems;

    overlays = [
      (_: super: {
        python310Packages =
          super.python310Packages
          // {
            fdfgen = super.python310Packages.buildPythonPackage rec {
              pname = "fdfgen";
              version = "0.16.1";
              src = super.python310Packages.fetchPypi {
                inherit pname version;
                sha256 = "sha256-DtpjtesIEIQ92YQ3d4cC+zlt71EJDOigEYblI04kf44=";
              };
            };
            EBookLib = super.python310Packages.buildPythonPackage rec {
              pname = "EbookLib";
              version = "0.18";
              propagatedBuildInputs = with super.python310Packages; [six lxml];
              src = super.python310Packages.fetchPypi {
                inherit pname version;
                sha256 = "sha256-OFYmQ6e8lNm/VumTC0kn5Ok7XR0JF/aXpkVNtaHBpTM=";
              };
            };
            certifi = super.python310Packages.buildPythonPackage rec {
              pname = "certifi";
              version = "2018.01.18";
              src = super.fetchFromGitHub {
                owner = "certifi";
                repo = "python-certifi";
                rev = version;
                sha256 = "sha256-GKeqJGXOcqqH0PYXlJOSAW9NoKL+BXzA8ZvqC1cMW4A=";
              };
            };
          };
      })
    ];

    pkgs = genSystems (system: import nixpkgs {inherit system overlays;});
  in {
    packages = genSystems (system: rec {
      # the actual class documentation pdf
      class = pkgs.${system}.callPackage ./nix/pdf.nix {};
      dungeonsheets = pkgs.${system}.callPackage ./nix/dungeonsheets.nix {};
      default = class;
    });

    devShell = genSystems (system:
      pkgs.${system}.mkShell {
        packages = with pkgs.${system}; [
          (python310.withPackages
            (_: [(pkgs.${system}.callPackage ./nix/dungeonsheets.nix {})]))
        ];
      });
  };
}
