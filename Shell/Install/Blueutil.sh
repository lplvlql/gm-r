#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh Blueutil.sh"

$LOG_COMMAND "start"

# Check if blueutil is installed
if [ ! -f "/opt/homebrew/bin/blueutil" ]; then
    $LOG_COMMAND "blueutil installing..."
    /opt/homebrew/bin/brew install blueutil >/dev/null 2>&1
fi

$LOG_COMMAND "end"