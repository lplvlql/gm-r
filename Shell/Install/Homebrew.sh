#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

# Check if Homebrew is installed
if [ -f "/opt/homebrew/bin/brew" ]; then
    $LOG_COMMAND "exit - homebrew installed"
    exit 0
fi

$LOG_COMMAND "homebrew installing..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1

$LOG_COMMAND "end"