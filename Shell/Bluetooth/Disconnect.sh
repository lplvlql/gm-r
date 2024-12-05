#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script/"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

# Turn bluetooth back on temporarily
BLUETOOTH_POWER=$( /opt/homebrew/bin/blueutil --power )
if [[ $BLUETOOTH_POWER == "0" ]]; then
    /opt/homebrew/bin/blueutil --power 1 >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
fi

# DEVICES
source "$SCRIPT_DIR/Shell/Bluetooth/List.sh"
for DEVICE in "${DEVICES[@]}"; do
    ADDRESS=$( echo "$DEVICE" | tr '[:upper:]' '[:lower:]' | tr ':' '-' )

    CONNECTED=$( /opt/homebrew/bin/blueutil --connected )
    if [[ $CONNECTED == *$ADDRESS* ]]; then
        $LOG_COMMAND "$DEVICE disconnecting..."
        /opt/homebrew/bin/blueutil --disconnect "$DEVICE" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
    else
        $LOG_COMMAND "$DEVICE disconnected."
    fi

    PAIRED=$( /opt/homebrew/bin/blueutil --paired )
    if [[ $PAIRED == *$ADDRESS* ]]; then
        $LOG_COMMAND "$DEVICE unpairing..."
        /opt/homebrew/bin/blueutil --unpair "$DEVICE" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
    else
        $LOG_COMMAND "$DEVICE unpaired."
    fi
done

# Turn bluetooth back off
if [[ $BLUETOOTH_POWER == "0" ]]; then
    sleep 2
    /opt/homebrew/bin/blueutil --power 0 >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
fi

$LOG_COMMAND "end"