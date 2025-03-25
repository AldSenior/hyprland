#!/bin/bash

# Путь к папке с обоями
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Получить список обоев
WALLPAPERS=("$WALLPAPER_DIR"/*)
CURRENT_INDEX=0

# Функция для установки обоев
set_wallpaper() {
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "${WALLPAPERS[$CURRENT_INDEX]}"
    hyprctl hyprpaper wallpaper "eDP-1,${WALLPAPERS[$CURRENT_INDEX]}"
    notify-send "Wallpaper Changed" "New wallpaper: $(basename "${WALLPAPERS[$CURRENT_INDEX]}")"
}

# Функция для отображения миниатюр
show_wallpapers() {
    SELECTED=$(ls "$WALLPAPER_DIR" | wofi --dmenu --prompt "Выберите обои:" --style /home/arthur/.config/wofi/style.css --conf /home/arthur/.config/wofi/config)
    if [[ -n "$SELECTED" ]]; then
        WALLPAPER="$WALLPAPER_DIR/$SELECTED"
        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload "$WALLPAPER"
        hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER"
        
        notify-send "Wallpaper Changed" "New wallpaper: $SELECTED"
    fi
}

# Основное меню
case "$1" in
    "next")
        CURRENT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))
        set_wallpaper
        ;;
    "prev")
        CURRENT_INDEX=$(( (CURRENT_INDEX - 1 + ${#WALLPAPERS[@]}) % ${#WALLPAPERS[@]} ))
        set_wallpaper
        ;;
    "select")
        show_wallpapers
        ;;
    *)
        echo "Usage: $0 {next|prev|select}"
        exit 1
        ;;
esac
