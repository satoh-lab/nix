## Install

### Multi-user installation (recommended)

> Skip this step if `nix store info` already works.

```bash
NIX_BUILD_GROUP_ID=40000 NIX_FIRST_BUILD_UID=40001 sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

> The default `GID=30000` is occupied on our servers, use `40000` instead.

Enable experimental features and add optional substituters:

```bash
echo "experimental-features = nix-command flakes auto-allocate-uids
auto-allocate-uids = true
substituters = https://cache.nixos.org https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://mirror.sjtu.edu.cn/nix-channels/store" \
| sudo tee -a /etc/nix/nix.conf
```

### Apply flakes

NOTES:
- Backup your `.bashrc` & `.profile` first, `home-manager` will take charge of these files.
- Find `username` and `useremail` in `flake.nix` and change them to your own ones.

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

If your root partition (`/`) is running out of space due to a growing `/nix` directory (our servers only have 32G for `/`), you can move it to a larger partition (e.g., `/var`) using a **Bind Mount** instead of a symbolic link (symlink is not allowed for the Nix store and its parent directories).

1. **Stop Services**: 
   `sudo systemctl stop nix-daemon.socket nix-daemon.service`
2. **Relocate Data**: 
   `sudo mv /nix /var/nix`
3. **Prepare Mount Point**: 
   `sudo rm /nix` (remove the failed symlink) and `sudo mkdir /nix` (create a clean directory).
4. **Execute Bind Mount**: 
   `sudo mount --bind /var/nix /nix`
5. **Persist the Change**: 
   Add the following line to your `/etc/fstab` to ensure it remounts on reboot:
   `/var/nix  /nix  none  bind  0  0`
6. **Restart Services**: 
   `sudo systemctl daemon-reload && sudo systemctl start nix-daemon.socket nix-daemon.service`

**Result**: Your Nix data physically resides in `/var`, but the system safely accesses it via `/nix`, keeping your root partition clean.
