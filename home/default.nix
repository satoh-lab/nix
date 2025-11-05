{ pkgs, username, useremail, ... }:
{
  imports = [
    ./shell
    ./archive.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  programs.home-manager.enable = true;

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings.user = {
        name = "${username}";
        email = "${useremail}";
      };
    };
  };

  home.packages = with pkgs; [
    fastfetchMinimal
  ];

  home.stateVersion = "25.05";
}
