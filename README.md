## Install

### Determinate Nix (recommended)

> Skip this step if `nix store info` already works.

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --nix-build-group-id 40000 --nix-build-user-id-base 40000
```

> The default `GID=30000` is occupied on our servers, use `40000` instead.

### Apply flakes

NOTES:
- Backup your `.bashrc` & `.profile` first, `home-manager` will take charge of these files.
- Find `username` and `useremail` in `flake.nix` and change them to your own ones.
- Choose your favorite shell in `home/shell/default.nix`, e.g., use `imports = [ ./fish.nix ];` to enable the fish shell.

Inside this directory, run `just s`, or manually run the follows:

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

## Tips: Relocating the Nix Store Using Bind Mount

If your root partition (`/`) is running out of space due to a growing `/nix` directory (our servers only have 32G for `/`), you can move it to a larger partition (e.g., `/home/`, `/var`) using a **Bind Mount** instead of a symbolic link (symlink is not allowed for the Nix store and its parent directories).

1. **Stop Services**: 
   `sudo systemctl stop nix-daemon.socket nix-daemon.service`
2. **Sync Data**: 
   `sudo rsync -aHAXS --progress /nix/ /home/nix/`
3. **Check Integrity**:
   `sudo diff -rq --no-dereference /nix /home/nix`
4. **Remove Old Directory**: 
   `sudo rm /nix`
5. **Execute Bind Mount**: 
   `sudo mount --bind /home/nix /nix`
6. **Persist the Change**: 
   Add the following line to your `/etc/fstab` to ensure it remounts on reboot:
   `/home/nix  /nix  none  bind  0  0`
7. **Restart Services**: 
   `sudo systemctl start nix-daemon.socket nix-daemon.service`

**Result**: Your Nix data physically resides in `/home/nix`, but the system safely accesses it via `/nix`, keeping your root partition clean.
