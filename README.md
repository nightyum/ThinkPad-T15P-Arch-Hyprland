# ThinkPad T15p — Arch + Hyprland Dotfiles

Personal configuration for Arch Linux + Hyprland on a ThinkPad T15p.
Used for fast system recovery when setting up a new device.

## Repo Structure

### Package Lists
- `pkglist.txt` — packages installed from official repositories (pacman)
- `aurlist.txt` — packages installed from the AUR (yay)

### Automation
- `update-pkglist.sh` — script that regenerates the package lists and auto-commits/pushes changes to git
- `pkglist-git.hook` — pacman hook that triggers the script on package install/remove/upgrade
  (install to `/etc/pacman.d/hooks/`)

## System Recovery on a New Device

```bash
# 1. Install packages from official repositories
sudo pacman -S --needed - < pkglist.txt

# 2. Install packages from the AUR
yay -S --needed - < aurlist.txt
```

## Setting Up the Auto-Commit Hook

1. Make the script executable:
```bash
chmod +x update-pkglist.sh
```

2. Install the pacman hook:
```bash
sudo cp pkglist-git.hook /etc/pacman.d/hooks/
```

3. Make sure the paths inside `update-pkglist.sh` and `pkglist-git.hook` (the `Exec=` line) point to the actual location of this repo on your machine.

Once installed, the hook automatically regenerates `pkglist.txt` and `aurlist.txt` and commits/pushes them to this repo after every `pacman`/`yay` install, remove, or upgrade — no manual steps needed.

## Testing the Hook

To verify the hook actually triggers on install/remove (not just when running the script manually):

```bash
# Install a small test package
sudo pacman -S cowsay

# Check that a new commit was created and pushed
cd ~/.dotfiles
git log --oneline -3

# Remove it and check again
sudo pacman -R cowsay
git log --oneline -3
```

If a new commit shows up after each command, the hook is working correctly.

> Note: if the package is already installed, pacman will skip the transaction entirely
> (`there is nothing to do`), and the hook won't fire. Use `-R` first if you need to re-test `-S`.

## Requirements

- Arch Linux
- [yay](https://github.com/Jguer/yay) (AUR helper)
- git, configured with SSH access to this repo (for the auto-commit hook to work)
