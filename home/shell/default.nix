{
  imports = [
    ./fish.nix
  ];

  programs = {
    # A cross-shell prompt
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    # The environment switcher
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      # the direnv package automatically gets loaded in Fish
      # enableFishIntegration = true;
    };

    # A command-line fuzzy finder
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    # A smarter cd command
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    # A modern replacement for ls
    eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    bat.enable = true;

    # replacement of htop/nmon
    btop = {
      enable = true;
      settings = {
        theme_background = false; # make btop transparent
      };
    };

    # A modern replacement for screen/tmux
    zellij.enable = true;
  };
}
