{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # the profile added by Nix Installer
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
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
      opencode = "bunx opencode";
      codex = "bunx codex";
      agent-browser = "bunx agent-browser";
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
