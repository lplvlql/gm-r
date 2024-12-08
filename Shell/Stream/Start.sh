#!/bin/bash

# Define script directory and specific app scripts
SCRIPT_DIR="/Users/Shared/Script"

APP_ACTIVATE="$SCRIPT_DIR/Apple/App/Activate.scpt"
APP_MENU="$SCRIPT_DIR/Apple/App/Menu.scpt"
APP_QUIT="$SCRIPT_DIR/Apple/App/Quit.scpt"

APP_WINDOW_ID="$SCRIPT_DIR/Swift/App/WindowID.swift"
FILE_READ="$SCRIPT_DIR/Swift/File/Read.swift"
FILE_WRITE="$SCRIPT_DIR/Swift/File/Write.swift"
JSON_WRITE="$SCRIPT_DIR/Swift/Json/Write.swift"

# Apps to control
TARGET=$1
MUSIC="Music"
OBS="OBS"

# Quit existing apps
osascript "$APP_QUIT" "$OBS"
osascript "$APP_QUIT" "$MUSIC"
osascript "$APP_QUIT" "$TARGET"

# Read JSON file for app settings
JSON_PATH="$HOME/Library/Application Support/obs-studio/basic/scenes/$TARGET.json"
FILE_DATA=$(swift "$FILE_READ" "$JSON_PATH")

# Start target app
APP=$TARGET
osascript "$APP_ACTIVATE" "$APP"
WINDOW_ID=$(swift "$APP_WINDOW_ID" "$APP")
FILE_DATA=$(swift "$JSON_WRITE" "$FILE_DATA" "sources.name==$APP.settings.window" "$WINDOW_ID" "int")
osascript "$APP_MENU" "$APP" "0" "Window" "0" "Minimize"

# Start music app
APP=$MUSIC
osascript "$APP_ACTIVATE" "$APP"
# Shuffle music
osascript "$APP_MENU" "$APP" "0" "Controls" "0" "Genius Shuffle"
WINDOW_ID=$(swift "$APP_WINDOW_ID" "$APP")
FILE_DATA=$(swift "$JSON_WRITE" "$FILE_DATA" "sources.name==$APP.settings.window" "$WINDOW_ID" "int")
# Visualizer for music
osascript "$APP_MENU" "$APP" "0" "Window" "0" "Visualizer"
WINDOW_ID=$(swift "$APP_WINDOW_ID" "$APP")
FILE_DATA=$(swift "$JSON_WRITE" "$FILE_DATA" "sources.name==$APP Visualizer.settings.window" "$WINDOW_ID" "int")
# Minimize all windows
osascript "$APP_MENU" "$APP" "0" "Window" "0" "Minimize All"

# Write modified JSON back to file
swift "$FILE_WRITE" "$JSON_PATH" "$FILE_DATA"

# Start OBS app
APP=$OBS
osascript "$APP_ACTIVATE" "$APP"
osascript "$APP_MENU" "$APP" "0" "Scene Collection" "0" "$APP"
# Uncomment if needed for streaming control
# osascript "$APP_MENU" "$APP" "1" "0" "0" "Start Streaming"