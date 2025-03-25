#!/bin/bash

if eww windows | grep -q '*weather'; then
    eww close weather
    eww close spotify
    eww close apps
    eww close audio
    eww close screen
    eww close profile
    eww close more
else
    eww open weather
    eww open spotify
    eww open apps
    eww open audio
    eww open screen
    eww open profile
    eww open more
fi