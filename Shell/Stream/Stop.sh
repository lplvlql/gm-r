#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"

APP_ACTIVATE="$SCRIPT_DIR/Apple/App/Activate.scpt"
APP_MENU="$SCRIPT_DIR/Apple/App/Menu.scpt"
APP_QUIT="$SCRIPT_DIR/Apple/App/Quit.scpt"

# Apps to quit
TARGET=$1
MUSIC="Music"
OBS="OBS"

# Quit the apps
osascript "$APP_QUIT" "$OBS"
osascript "$APP_QUIT" "$MUSIC"
osascript "$APP_QUIT" "$TARGET"