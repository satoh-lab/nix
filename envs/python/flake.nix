{
  description = "Python Dev Env";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.python312
            pkgs.uv
          ];
          shellHook = ''
            echo "$(uv --version)"
            echo "$(python --version)"
            # python的某些包依赖C++标准库，需要手动链接
            export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
          '';
        };
      }
    );
}
