#!/bin/bash

# Получаем список доступных Wi-Fi сетей и убираем заголовок
networks=$(nmcli --fields "SSID" device wifi list | sed 1d)

# Убираем лишние пробелы и невидимые символы из SSID
networks=$(echo "$networks" | sed 's/^[ \t]*//;s/[ \t]*$//')

# Выводим список сетей через wofi и получаем выбранную пользователем сеть
selected=$(echo "$networks" | wofi --dmenu --prompt "Выберите сеть Wi-Fi")

# Если пользователь ничего не выбрал, выходим
if [ -z "$selected" ]; then
    notify-send "Ошибка" "Сеть не выбрана." --icon=dialog-error
    exit 1
fi

# Убираем лишние пробелы и невидимые символы из выбранного SSID
selected=$(echo "$selected" | sed 's/^[ \t]*//;s/[ \t]*$//')

# Запрашиваем пароль для выбранной сети
password=$(wofi --dmenu --password --prompt "Введите пароль для сети $selected")

# Если пароль не введен, выходим
if [ -z "$password" ]; then
    notify-send "Ошибка" "Пароль не введен." --icon=dialog-error
    exit 1
fi

# Подключаемся к выбранной сети
echo "Подключаемся к сети: '$selected'"
nmcli device wifi connect "$selected" password "$password"

# Проверяем успешность подключения
if [ $? -eq 0 ]; then
    notify-send "Успех" "Успешно подключено к '$selected'." --icon=network-wireless
else
    notify-send "Ошибка" "Не удалось подключиться к '$selected'." --icon=dialog-error
fi