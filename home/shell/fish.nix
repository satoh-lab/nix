{ pkgs, ... }:
{
  home.packages = with pkgs; [
    krabby
  ];

  programs = {
    fish = {
      enable = true;
      shellAbbrs = {
        cd = "z";
        # cat = "bat";
        zed = "zeditor";
      };
      shellAliases = {
        "ls" = "eza";
        "l" = "eza -lah --icons=auto";
      };
      shellInit = ''
        zoxide init fish | source
        export PATH="$HOME/.local/bin:$PATH"
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
      };
    };
  };
}
