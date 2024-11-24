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

    PAIRED=$( /opt/homebrew/bin/blueutil --paired )
    if [[ $PAIRED != *$ADDRESS* ]]; then
        $LOG_COMMAND "$DEVICE pairing..."
        /opt/homebrew/bin/blueutil --pair "$DEVICE" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
    else
        $LOG_COMMAND "$DEVICE paired."
    fi

    PAIRED=$( /opt/homebrew/bin/blueutil --paired )
    CONNECTED=$( /opt/homebrew/bin/blueutil --connected )
    if [[ "$PAIRED" != *$ADDRESS* ]]; then
        $LOG_COMMAND "$DEVICE unpaired."
    elif [[ $CONNECTED != *$ADDRESS* ]]; then
        $LOG_COMMAND "$DEVICE connecting..."
        /opt/homebrew/bin/blueutil --connect "$DEVICE" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
    else
        $LOG_COMMAND "$DEVICE connected."
    fi
done

$LOG_COMMAND "end"