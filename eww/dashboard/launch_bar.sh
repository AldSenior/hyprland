#!/bin/bash

## Files and CMD
FILE="$HOME/.cache/eww_launch.dashboard"
CFG="$HOME/.config/eww/dashboard/"
EWW=`which eww`

## Run eww daemon if not running already
if [[ ! `pidof eww` ]]; then
	${EWW} daemon
	sleep 1
fi

## Open widgets 
run_eww() {
	${EWW} --config "$CFG" open-many \
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
}

## Launch or close widgets accordingly
if [[ ! -f "$FILE" ]]; then
	touch "$FILE"
	run_eww
else
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
	rm "$FILE"
fi