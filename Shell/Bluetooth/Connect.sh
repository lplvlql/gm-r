#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script/"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh Connect.sh"

$LOG_COMMAND "start"

# Path to the Homebrew and Blueutil setup scripts
/bin/bash "$SCRIPT_DIR/Shell/Install/Homebrew.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
/bin/bash "$SCRIPT_DIR/Shell/Install/Blueutil.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1

# Array of Bluetooth devices by their MAC addresses
DEVICES=()
DEVICES+=("AC:97:38:6B:2A:52") # Apple Keys
DEVICES+=("D0:C0:50:BD:AC:B1") # Apple Mouse
DEVICES+=("D0:C0:50:BB:F3:48") # Apple Pad
# DEVICES+=("60:FD:A6:1D:BB:D8") # Apple AirPods
# DEVICES+=("F7:D6:A2:54:11:CC") # Kinesis Advantage
# DEVICES+=("58:10:31:D0:14:93") # Sony DualSense

# Loop to connect all specified Bluetooth devices
for DEVICE in "${DEVICES[@]}"; do
    # Check if the device is connected
    CONNECTED=$( /opt/homebrew/bin/blueutil --is-connected "$DEVICE" )
    if [ "$CONNECTED" == "1" ]; then
        $LOG_COMMAND "$DEVICE connected."
    else
        $LOG_COMMAND "$DEVICE connecting..."
        /opt/homebrew/bin/blueutil --connect "$DEVICE" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
    fi
done

$LOG_COMMAND "end"