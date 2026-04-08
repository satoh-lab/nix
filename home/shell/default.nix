{ pkgs, ... }:
{
  imports = [
    ./fish.nix
  ];

  home.packages = with pkgs; [
    krabby
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    NPM_CONFIG_PREFIX = "$HOME/link/.npm";
    NPM_CONFIG_CACHE = "$HOME/link/.cache/npm";
    BUN_INSTALL = "$HOME/link/.bun";
    BUN_INSTALL_CACHE_DIR = "$HOME/link/.cache/bun";
    UV_CACHE_DIR = "$HOME/link/.cache/uv";
    UV_TOOL_DIR = "$HOME/link/.local/share/uv/tools";
    UV_PYTHON_INSTALL_DIR = "$HOME/link/.local/share/uv/python";
    HF_HOME = "$HOME/link/.cache/huggingface";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$NPM_CONFIG_PREFIX/bin"
    "$BUN_INSTALL/bin"
  ];

  programs = {
    # A cross-shell prompt
    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    # The environment switcher
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      # the direnv package automatically gets loaded in Fish
      # enableFishIntegration = true;
    };

    # A command-line fuzzy finder
    fzf = {
      enable = true;
      fileWidgetCommand = "fd --strip-cwd-prefix";
      changeDirWidgetCommand = "fd --type d";
      enableFishIntegration = true;
    };

    # A smarter cd command
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    # A modern replacement for ls
    eza = {
      enable = true;
      enableFishIntegration = true;
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    bat.enable = true;

    # A modern replacement for screen/tmux
    zellij.enable = true;
  };
}
