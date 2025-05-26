#!/bin/bash

# source https://github.com/hyprwm/Hyprland/discussions/4283?sort=new#discussioncomment-8648109

export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

enable_touchpad() {
    printf "true" >"$STATUS_FILE"
    notify-send -u low "Enabling touchpad"
    hyprctl keyword '$TOUCHPAD_ENABLED' "true" -r
}

disable_touchpad() {
    printf "false" >"$STATUS_FILE"
    notify-send -u low -i "Disabling touchpad"
    hyprctl keyword '$TOUCHPAD_ENABLED' "false" -r
}

if ! [ -f "$STATUS_FILE" ]; then
  enable_touchpad
else
  if [ $(cat "$STATUS_FILE") = "true" ]; then
    disable_touchpad
  elif [ $(cat "$STATUS_FILE") = "false" ]; then
    enable_touchpad
  fi
fi
