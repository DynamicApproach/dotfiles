#!/bin/bash

# https://wakatime.com/terminal Installing for zsh (with project detection)
sudo pip3 install wakatime

API_KEY="${WAKATIME_API_KEY:-}"

if [ -z "$API_KEY" ]; then
    echo "WakaTime API key not found in environment variable (WAKATIME_API_KEY). Please set it up."
    exit 1
fi

if grep --quiet 'api_key=.' ~/.wakatime.cfg; then
    echo "WakaTime API-key already configured."
else
    echo "Configuring WakaTime API key..."
    echo -e "[settings]\napi_key=$API_KEY" >>~/.wakatime.cfg
fi
mkdir -p ~/.wakatime
chmod 700 ~/.wakatime
