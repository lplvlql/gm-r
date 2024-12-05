#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

BLUETOOTH_POWER_PREV=-1

while true; do

    # Check if bluetooth is on or off
    BLUETOOTH_POWER=$( /opt/homebrew/bin/blueutil --power )

    if [[ "$BLUETOOTH_POWER" == "0" && "$BLUETOOTH_POWER_PREV" != "0" ]]; then
        /bin/bash "$SCRIPT_DIR/Shell/Bluetooth/Disconnect.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
    fi

    if [[ "$BLUETOOTH_POWER" == "1" ]]; then
        /bin/bash "$SCRIPT_DIR/Shell/Bluetooth/Connect.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
    fi

    # Store last bluetooth state
    BLUETOOTH_POWER_PREV=$BLUETOOTH_POWER
    
    # Sleep for 8 seconds before checking again
    sleep 8
done

$LOG_COMMAND "end"