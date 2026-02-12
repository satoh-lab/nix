{ pkgs, secrets, ... }:
{
  imports = [
    ./bash.nix
  ];

  home.packages = with pkgs; [
    krabby
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BUN_INSTALL = "$HOME/link/.bun";
    BUN_INSTALL_CACHE_DIR = "$HOME/link/.cache/bun";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$BUN_INSTALL/bin"
  ];

  # warn: force to overwrite existing files
  home.file.".bashrc".force = true;
  home.file.".profile".force = true;

  programs = {
    # A cross-shell prompt
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    # A command-line fuzzy finder
    fzf = {
      enable = true;
      fileWidgetCommand = "fd --strip-cwd-prefix";
      changeDirWidgetCommand = "fd --type d";
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    # A smarter cd command
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    # A modern replacement for ls
    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    bat.enable = true;

    # A modern replacement for screen/tmux
    zellij.enable = true;
  };
}
