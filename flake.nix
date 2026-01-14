{
  description = "Ubuntu Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{
    nixpkgs,
    home-manager,
    ...
  }: let
    username = "<your-user-name>";
    useremail = "<your-user-email>";
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    specialArgs = { inherit username useremail; };
  in {
    homeConfigurations = {
      "${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = inputs // specialArgs;
        modules = [
          ./home
        ];
      };
    };
  };
}
