#!/bin/bash
# Скрипт для отображения текущей раскладки клавиатуры в Hyprland

# Получаем текущую раскладку с помощью hyprctl и берём последнее значение
layout=$(hyprctl devices | awk '/active keymap:/ {print $3}' | tail -n 1)

# Отображаем раскладку с иконкой
case $layout in
    "English")
        echo "⌨️ US"
        ;;
    "Russian")
        echo "⌨️ RU"
        ;;
    *)
        echo "⌨️ $layout"
        ;;
esac