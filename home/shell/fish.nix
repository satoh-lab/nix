{ pkgs, ... }:
{
  home.packages = with pkgs; [
    krabby
  ];

  # warn: force to overwrite existing files
  home.file.".bashrc".force = true;
  home.file.".profile".force = true;

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        # the profile added by Nix Installer
        if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
          . $HOME/.nix-profile/etc/profile.d/nix.sh;
        fi

        export PATH=$HOME/.local/bin:$PATH

        # if it is interactive shell and fish exists，auto launch fish
        if [[ $- == *i* ]] && command -v fish &> /dev/null && [[ -z "$FISH_VERSION" ]]; then
          exec fish
        fi
      '';
    };

    fish = {
      enable = true;
      shellAbbrs = {
        cd = "z";
        # cat = "bat";
      };
      shellAliases = {
        "ls" = "eza";
        "l" = "eza -lah --icons=auto";
      };
      shellInit = ''
        zoxide init fish | source
        set -g fish_color_command = blue --italics
        set -g fish_color_quote = yellow --italics
        # only print pokemons on interactive shells
        if status --is-interactive
          set -gx LANG en_US.UTF-8
          set -gx LC_ALL en_US.UTF-8
          krabby random 1-3 | tail -n +2
        end
      '';
      plugins = with pkgs.fishPlugins; [
        {
          name = "puffer";
          src = puffer.src;
        }
        {
          name = "pisces";
          src = pisces.src;
        }
      ];
      functions = {
        fish_greeting = "";
        fish_config = "";
      };
    };
  };
}
