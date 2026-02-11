{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = false;
    initExtra = ''
      # the profile added by Nix Installer
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh;
      fi

      if it is interactive shell and fish exists, auto launch fish
      if [[ $- == *i* ]] && command -v fish &> /dev/null && [[ -z "$FISH_VERSION" ]]; then
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
      l = "eza -lah --icons=auto";
      lt = "eza --tree --level=2 --icons=auto";
      opencode = "bun $(which opencode)";
      codex = "bun $(which codex)";
      cat = "bat -p --paging=never";
    };
    shellInit = ''
      zoxide init fish | source
      set -g fish_color_command = blue --italics
      set -g fish_color_quote = yellow --italics
      # only print pokemons on interactive shells
      if status --is-interactive
        set -gx LANGUAGE en
        command -q krabby && krabby random 1-3 | tail -n +2
      end
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
      fish_greeting = "";
      fish_config = "";
    };
  };
}
