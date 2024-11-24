#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

# Unload all plists in the folder
for plist in "$SCRIPT_DIR/Agent"/*.plist; do
  if [ -f "$plist" ]; then
    $LOG_COMMAND "$plist unloading..."
    launchctl unload "$plist" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
  fi
done

$LOG_COMMAND "end"