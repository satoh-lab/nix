## Install

### Multi-user installation (recommended)

> Skip this step if `nix store info` already works.

```bash
NIX_BUILD_GROUP_ID=40000 NIX_FIRST_BUILD_UID=40001 sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

> The default `GID=30000` is occupied on our servers, use `40000` instead.

Enable experimental features:

```bash
echo 'experimental-features = nix-command flakes auto-allocate-uids
auto-allocate-uids = true' | sudo tee -a /etc/nix/nix.conf
```

### Apply flakes

NOTES:
- Backup your `.bashrc` & `.profile` first, `home-manager` will take charge of these files.
- Find `username` and `useremail` in `flake.nix` and change them to your own ones.

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
- Copy the template files (`flake.nix` & `justfile`) for the corresponding language to the project's root directory.
- Run `just dev`.
- Entering the directory will automatically activate the development environment.
