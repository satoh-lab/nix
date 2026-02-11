alias s := switch
alias c := clean

switch:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ -d .git ]]; then
        git add .
    fi
    if command -v home-manager >/dev/null 2>&1; then
        home-manager switch --flake .
    else
        nix run nixpkgs#home-manager -- switch --flake .
    fi

clean:
    #!/usr/bin/env bash
    home-manager expire-generations "-7 days"
    nix-collect-garbage -d