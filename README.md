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

## Installing the Pacman Hook

```bash
sudo cp pkglist-git.hook /etc/pacman.d/hooks/
```

Once installed, the hook automatically updates `pkglist.txt` and `aurlist.txt` and commits/pushes them to this repo after every `pacman`/`yay` install, remove, or upgrade — no manual steps needed.

## Requirements

- Arch Linux
- [yay](https://github.com/Jguer/yay) (AUR helper)
- git, configured with SSH access to this repo (for the auto-commit hook to work)
