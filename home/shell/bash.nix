{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    historySize = 10000;
    historyFileSize = 100000;
    historyFile = "$HOME/.bash_history";
    historyControl = [
      "ignoreboth"  # ignorespace + ignoredups
      "erasedups"
    ];
    historyIgnore = [ "ls" "l" "lt" "cd" "pwd" "exit" "clear" "history" ];

    shellAliases = {
      l  = "eza -lah --icons=auto";
      lt = "eza --tree --level=2 --icons=auto";
      cat = "bat --style=plain --paging=never";
      opencode = "bun $(which opencode)";
      codex = "bun $(which codex)";
    };

    initExtra = ''
      if [[ $- == *i* ]]; then
        export LANGUAGE=en
        
        # Load Home Manager session variables in interactive shells (VSCode etc.)
        if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
          source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
        fi

        # Append instead of overwrite
        shopt -s histappend
        # Add timestamps to history
        export HISTTIMEFORMAT="%F %T  "
        # Multi-terminal safe sync (FAST)
        __history_sync() {
          builtin history -a   # append new lines
          builtin history -n   # read new lines
        }

        PROMPT_COMMAND="__history_sync''${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

        # Typo fixing
        shopt -s cdspell
        # Enter dir directly without cd
        shopt -s autocd

        if [ -d "$HOME/.config/bash/completions" ]; then
          for f in "$HOME/.config/bash/completions"/*.bash; do
            source "$f"
          done
        fi

        if [[ -f ${pkgs.blesh}/share/blesh/ble.sh ]]; then
          source ${pkgs.blesh}/share/blesh/ble.sh
        fi

        command -v krabby >/dev/null 2>&1 && krabby random 1-3 | tail -n +2
      fi
    '';
  };

  # ============================================================
  # blesh config (goes into ~/.blerc)
  # ============================================================
  home.file.".blerc".text = ''
    bleopt complete_auto_delay=300
    bleopt prompt_eol_mark=' '
    bleopt exec_errexit_mark=
    bleopt exec_exit_mark=

    # Catppuccin Mocha inspired theme for ble.sh
    ble-face command_alias='fg=#a6e3a1,italic'
    ble-face command_builtin='fg=#a6e3a1,italic'
    ble-face command_function='fg=#a6e3a1,italic'
    ble-face command_file='fg=#a6e3a1,italic'
    ble-face command_keyword='fg=#a6e3a1,italic'
    ble-face argument_option='fg=#fab387'
    ble-face command_directory='fg=#89b4fa'
    ble-face filename_directory='fg=#89b4fa,underline'
    ble-face filename_executable='fg=#a6e3a1,bold'
    ble-face syntax_comment='fg=#585b70,italic'
    ble-face syntax_quotation='fg=#f9e2af'
    ble-face syntax_varname='fg=#f5e0dc'
    ble-face syntax_param_expansion='fg=#f38ba8'
    ble-face syntax_command='fg=#b4befe'
    ble-face syntax_error='fg=#eba0ac'
    ble-face syntax_delimiter='fg=#f38ba8'
    ble-face syntax_history_expansion='fg=#cba6f7,italic'
    ble-face auto_complete='fg=#9399b2,italic'
    ble-face region='bg=#45475a'

    # Fish-like abbrs
    ble-sabbrev cd=z
    ble-sabbrev g=git
    ble-sabbrev j=just
  '';

  home.file.".config/bash/completions/ssh-fzf.bash".text = ''
    _fzf_complete_ssh() {
      # No config → fallback to normal completion
      [[ -f ~/.ssh/config ]] || return

      _fzf_complete --prompt="ssh> " -- "$@" < <(
        awk '/^Host / && !/\*/ {for(i=2;i<=NF;i++) print $i}' ~/.ssh/config
      )
    }

    complete -F _fzf_complete_ssh -o default -o bashdefault ssh
  '';
}