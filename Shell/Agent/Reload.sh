#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

# Unload the agents
/bin/bash "$SCRIPT_DIR/Shell/Agent/Unload.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1

# Load the agents
/bin/bash "$SCRIPT_DIR/Shell/Agent/Load.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1

$LOG_COMMAND "end"