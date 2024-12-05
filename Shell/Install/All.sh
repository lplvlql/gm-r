#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script/"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

# Path to the Homebrew and Blueutil setup scripts
/bin/bash "$SCRIPT_DIR/Shell/Install/Homebrew.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
/bin/bash "$SCRIPT_DIR/Shell/Install/Blueutil.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
/bin/bash "$SCRIPT_DIR/Shell/Install/Coreutils.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1

$LOG_COMMAND "end"