## Install

### Single-user installation (recommended)

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
```

> Run `. ~/.nix-profile/etc/profile.d/nix.sh` to enable nix in bash immediately.

Enable experimental features:

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

### Apply flakes

NOTE: backup your `.bashrc` & `.profile` first, `home-manager` will take charge of these files.

Inside this directory, run

```bash
nix run nixpkgs#home-manager -- switch --flake .
```

After the first run, `home-manager` CLI will be installed.
From now on, use

```bash
home-manager switch --flake .
```

> Whenever you update your flake, you must stage your changes before `home-manager switch`.
> Run this command first: `git add .`.

## Develop

- All develop environment templates are located in `envs`.
- Copy the template files (`.envrc` & `flake.nix`) for the corresponding language to the project's root directory.
- Run `direnv allow`.
- Entering the directory will automatically activate the development environment.

### Python

- Run `uv init --bare` to create `pyproject.toml`.
- Run `uv add <packge-names>` to add dependencies.
- If `requirements.txt` exists, use add --req  `uv add --requirements requirements.txt`.

### Node.js

- Run `pnpm add <package-names>` to add dependencies.
- Run `pnpm i` to install dependencies.
