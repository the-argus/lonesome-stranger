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
    pkgs = genSystems (system: import nixpkgs {inherit system;});
  in {
    packages = genSystems (system: rec {
      # the actual class documentation pdf
      class = pkgs.${system}.callPackage ./nix/pdf.nix {};
      dungeonsheets = pkgs.${system}.callPackage ./nix/dungeonsheets.nix {};
      default = class;
    });

    devShell = genSystems (system: {
      packages = with pkgs.${system}; [
        (python310.withPackages
          (_: [pkgs.${system}.callPackage ./nix/dungeonsheets.nix] {}))
      ];
    });
  };
}
