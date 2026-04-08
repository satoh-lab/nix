{ pkgs, ... }:
{
  # warn: force to overwrite existing files
  home.file.".bashrc".force = true;
  home.file.".profile".force = true;

  programs.bash = {
    enable = true;
    initExtra = ''
      # if it is interactive shell and fish exists, auto launch fish
      if command -v fish &> /dev/null && [[ -z "$FISH_VERSION" ]]; then
        exec fish
      fi
    '';
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      cd = "z";
      g = "git";
      j = "just";
    };
    shellAliases = {
      l = "eza -lah";
      lt = "eza --tree --level=2";
      cat = "bat -p --paging=never";
      opencode = "bunx opencode";
      codex = "bunx codex";
      agent-browser = "bunx agent-browser";
    };
    interactiveShellInit = ''
      set -gx LANGUAGE en

      zoxide init fish | source
      set -g fish_features no-expand-full qmark-noglob stderr-nocaret

      fish_config theme choose "catppuccin-mocha"
    '';
    plugins = with pkgs.fishPlugins; [
      {
        name = "puffer";
        src = puffer.src;
      }
      {
        name = "done";
        src = done.src;
      }
    ];
    functions = {
      fish_greeting = ''
        # print pokemons
        command -q krabby && krabby random 1-3 | tail -n +2

        # set italics
        for var in fish_color_command fish_color_quote
          set color (string match -r '^[^-].*' -- $$var)[1]
          set -U $var $color --italics
          set -e $var
        end
      '';
    };
  };
}
