#!/bin/bash
cd ~/dotfiles || exit
pacman -Qqe > pkglists/pkglist.txt
pacman -Qqem > pkglists/aurlist.txt

if ! git diff --quiet; then
    git add pkglists/
    git commit -m "Update package lists: $(date '+%Y-%m-%d %H:%M')"
    git push origin main
fi
