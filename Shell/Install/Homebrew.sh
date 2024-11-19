#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh Homebrew.sh"

$LOG_COMMAND "start"

# Check if Homebrew is installed
if [ ! -f "/opt/homebrew/bin/brew" ]; then
    $LOG_COMMAND "Homebrew installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
fi

$LOG_COMMAND "end"