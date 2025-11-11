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
    # Simple, fast and user-friendly alternative to find
    fd
    # Handy way to save and run project-specific commands
    # Similar to Makefile .PHONY
    just

    # An extremely fast Python package and project manager
    uv
    # pixi # try pixi as well
  ];

  home.stateVersion = "25.05";
}
