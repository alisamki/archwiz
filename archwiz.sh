#!/bin/bash

update_system() {
    yad --info --text="Updating system..."
    sudo pacman -Syu
}

remove_orphans() {
    yad --info --text="Removing orphaned packages..."
    sudo pacman -Rns $(pacman -Qdtq)
}

clear_cache() {
    yad --info --text="Clearing package cache..."
    sudo pacman -Sc
}

update_aur() {
    if command -v paru &> /dev/null; then
        yad --info --text="Updating AUR packages with paru..."
        paru -Syu
    elif command -v yay &> /dev/null; then
        yad --info --text="Updating AUR packages with yay..."
        yay -Syu
    else
        yad --error --text="No AUR helper found. Install paru or yay."
    fi
}

update_flatpak() {
    yad --info --text="Updating Flatpak packages..."
    flatpak update
}

full_upgrade() {
    yad --info --text="Performing full system upgrade and cleanup..."
    sudo pacman -Syu && sudo pacman -Rns $(pacman -Qdtq) && sudo pacman -Sc && flatpak update
}

system_health() {
    yad --info --text="Checking system health...\n\nDisk Usage:\n$(df -h)\n\nMemory Usage:\n$(free -h)\n\nSystem Journal Errors:\n$(journalctl -p 3 -xb --no-pager)"
}

remove_unused_flatpak() {
    yad --info --text="Removing unused Flatpak packages..."
    flatpak uninstall --unused
}

show_menu() {
    yad --width=400 --height=300 --title="Archwiz - Arch Manager" --form \
        --field="1) Update System":BTN "bash -c 'sudo pacman -Syu'" \
        --field="2) Remove Orphans":BTN "bash -c 'remove_orphans'" \
        --field="3) Clear Package Cache":BTN "bash -c 'clear_cache'" \
        --field="4) Update AUR Packages":BTN "bash -c 'update_aur'" \
        --field="5) Update Flatpak Packages":BTN "bash -c 'update_flatpak'" \
        --field="6) Full System Upgrade and Cleanup":BTN "bash -c 'full_upgrade'" \
        --field="7) Check System Health":BTN "bash -c 'system_health'" \
        --field="8) Remove Unused Flatpak Packages":BTN "bash -c 'remove_unused_flatpak'" \
        --field="9) Display Disk Usage":BTN "bash -c 'yad --info --text="Disk Usage:\n$(df -h)"'" \
        --field="10) Exit":BTN "exit 0"
}

# Launch GUI menu
show_menu
