#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
PLIST_DIR="$SCRIPT_DIR/Agent"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

# Load all plists
for plist in "$PLIST_DIR"/*.plist; do
  if [ -f "$plist" ]; then
    $LOG_COMMAND "$plist loading..."
    launchctl load "$plist" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
  fi
done

$LOG_COMMAND "end"