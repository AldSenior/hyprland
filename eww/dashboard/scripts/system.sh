#!/bin/bash

# Функция для получения текущей яркости
get_brightness() {
    brightness=$(brightnessctl g)
    if [ -z "$brightness" ]; then
        echo "0"
        return
    fi
    brightness_percent=$(echo "scale=2; $brightness / 26666 * 100" | bc)
    printf "%.0f" "$brightness_percent"
}

# Функция для получения текущей громкости
get_volume() {
    if command -v pactl &>/dev/null; then
        if pactl list sinks | grep -q 'Mute: yes'; then
            echo "0"
        else
            volume=$(pactl list sinks | grep -A 10 "State: RUNNING" | grep 'Volume:' | awk '{print $5}' | cut -d '%' -f1)
            echo "${volume:0:3}"
        fi
    else
        echo "pactl not found"
    fi
}

# Функция для получения текущего уровня микрофона
get_mic_level() {
    if command -v pactl &>/dev/null; then
        mic_level=$(pactl list sources | grep 'Volume:' | awk -F/ '{print $2}' | awk '{print $1}' | head -n 3 | tail -n 1)
        echo "${mic_level%\%}"
    else
        echo "pactl not found"
    fi
}

# Основной цикл для обновления значений
# while true; do
#     brightness=$(get_brightness)
#     volume=$(get_volume)
#     mic_level=$(get_mic_level)

#     # Обновляем значения в eww (или другом инструменте)
#     eww update brightness="$brightness"
#     eww update volume="$volume"
#     eww update mic_level="$mic_level"

#     # Ждем 1 секунду перед следующим обновлением
#     sleep 1
# done