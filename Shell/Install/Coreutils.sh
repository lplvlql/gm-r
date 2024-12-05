#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

# Check if coreutils is installed
if [ -f "/opt/homebrew/bin/gtimeout" ]; then
    $LOG_COMMAND "exit - coreutils installed"
    exit 0
fi

$LOG_COMMAND "coreutils installing..."
/opt/homebrew/bin/brew install coreutils >/dev/null 2>&1

$LOG_COMMAND "end"