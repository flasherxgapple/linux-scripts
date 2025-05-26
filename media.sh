#!/bin/bash

music_icon="󰽰"  

if playerctl status > /dev/null 2>&1; then
    current_track=$(playerctl metadata --format "{{ title }} - {{ artist }}")
    output=$(playerctl status)
    status=""
    
    if [[ $output == "Playing" ]]; then
        status="playing - "
    elif [[ $output == "Paused" ]]; then
        status="paused - "
    elif [[ $output == "Stopped" ]]; then
        status="stopped - "
    fi

    if [ -z "$current_track" ]; then
        echo "!player"
    else
        max_length=50
        if [ ${#current_track} -gt $max_length ]; then
            current_track="${current_track:0:max_length}..."
        fi
        
        echo "$status  $current_track"
    fi
else
    echo "!player"
fi
