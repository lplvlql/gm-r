#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

while true; do

    /bin/bash "$SCRIPT_DIR/Shell/Bluetooth/Connect.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
    
    # Sleep for 10 seconds before checking again
    sleep 10
done

$LOG_COMMAND "end"