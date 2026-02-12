alias s := switch
alias c := clean
alias u := update

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

update message="update":
    #!/usr/bin/env bash
    set -euo pipefail
    git add .
    if git status --porcelain | grep -q "^[AM]. secrets.toml"; then
        echo "Unstaging secrets.toml..."
        git restore --staged secrets.toml
    fi
    git commit -m "{{message}}"
    git push