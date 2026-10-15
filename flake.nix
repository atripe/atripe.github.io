{
  description = "atripe — a small portal for Coptic";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.stdenvNoCC.mkDerivation {
          pname = "atripe";
          version = "0.1.0";
          src = ./.;
          nativeBuildInputs = [
            pkgs.pandoc
            pkgs.zola
          ];
          buildPhase = ''
            pandoc lua bib/render.lua
            zola build --output-dir $out
          '';
          dontInstall = true;
        };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            pkgs.pandoc
            pkgs.zola
          ];
          shellHook = ''
            echo "atripe — 'zola serve' to preview (no --base-url, it breaks the CSS)"
            echo "         'pandoc lua bib/render.lua' after changing a references.bib"
          '';
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-tree);
    };
}
