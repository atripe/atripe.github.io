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
      packages = forAllSystems (
        pkgs:
        let
          # Typst reads TTF and OTF but not WOFF, and the site ships the font
          # as WOFF. WOFF is a wrapped TTF, so unwrap it here rather than
          # committing the same font twice — this also guarantees the sheet
          # and the pages are set from the same file.
          coptic-font = pkgs.runCommand "new-athena-unicode-ttf" {
            nativeBuildInputs = [ (pkgs.python3.withPackages (ps: [ ps.fonttools ])) ];
            woff = ./static/fonts/newathu5_8.woff;
          } ''
            mkdir -p $out
            python3 -c '
            import os
            from fontTools.ttLib import TTFont
            font = TTFont(os.environ["woff"])
            font.flavor = None
            font.save(os.path.join(os.environ["out"], "NewAthenaUnicode.ttf"))
            '
          '';

          cheatsheet = pkgs.stdenvNoCC.mkDerivation {
            pname = "atripe-cheatsheet";
            version = "0.1.0";
            src = ./typst;
            nativeBuildInputs = [ pkgs.typst ];
            buildPhase = ''
              export HOME=$TMPDIR
              typst compile --font-path ${coptic-font} word-division.typ cheatsheet.pdf
            '';
            installPhase = ''
              mkdir -p $out
              cp cheatsheet.pdf $out/
            '';
          };
        in
        {
          inherit coptic-font cheatsheet;

          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "atripe";
            version = "0.1.0";
            src = ./.;
            nativeBuildInputs = [ pkgs.zola ];
            buildPhase = ''
              # The cheat sheet is a colocated asset of the word-division page,
              # so it has to be in place before zola runs.
              cp ${cheatsheet}/cheatsheet.pdf content/word-division/
              chmod +w content/word-division/cheatsheet.pdf
              zola build --output-dir $out
            '';
            dontInstall = true;
          };
        }
      );

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            pkgs.zola
            pkgs.typst
          ];
          shellHook = ''
            echo "atripe — 'zola serve' to preview (no --base-url, it breaks the CSS)"
            echo "         'nix build .#cheatsheet' to regenerate the PDF"
          '';
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-tree);
    };
}
