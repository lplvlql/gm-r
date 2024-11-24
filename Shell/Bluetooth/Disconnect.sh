#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script/"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

$LOG_COMMAND "start"

# Path to the Homebrew and Blueutil setup scripts
/bin/bash "$SCRIPT_DIR/Shell/Install/Homebrew.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
/bin/bash "$SCRIPT_DIR/Shell/Install/Blueutil.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1

# Check if Bluetooth is on or off
BLUETOOTH_POWER=$( /opt/homebrew/bin/blueutil --power )
if [[ $BLUETOOTH_POWER == "0" ]]; then
    $LOG_COMMAND "exit - bluetooth off"
    exit 0
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

$LOG_COMMAND "end"