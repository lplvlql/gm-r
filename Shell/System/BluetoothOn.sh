#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

/bin/bash "$SCRIPT_DIR/Shell/Bluetooth/Connect.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1

$LOG_COMMAND "end"