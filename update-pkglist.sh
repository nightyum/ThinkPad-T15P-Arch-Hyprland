#!/bin/bash
cd ~/.dotfiles || exit
pacman -Qqe > pkglist/pkglist.txt
pacman -Qqem > pkglist/aurlist.txt

if ! git diff --quiet; then
    git add pkglists/
    git commit -m "Update package lists: $(date '+%Y-%m-%d %H:%M')"
    git push origin main
fi
