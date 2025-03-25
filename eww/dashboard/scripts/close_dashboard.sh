#!/bin/bash

## Files and CMD
FILE="$HOME/.cache/eww_launch.dashboard"
CFG="$HOME/.config/eww/dashboard/"
EWW=`which eww`

## Close all widgets
${EWW} --config "$CFG" close \
    profile \
    github \
    youtube \
    reddit \
    telegram \
    spotify \
    time \
    weather \
    apps \
    poweroff \
    sleep \
    logout \
    reboot \
    system \
    resources \
    close_button

if [[ -f "$FILE" ]]; then
    rm "$FILE"
fi