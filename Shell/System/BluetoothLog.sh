#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

POWER_STATE=""
BLUETOOTH_STATE=""

$LOG_COMMAND "start"

# Start streaming logs related to bluetoothd
log stream --predicate 'process == "bluetoothd" AND eventMessage contains "PowerState:"' | while read -r line
  do
    # Log the incoming line
    #$LOG_COMMAND "$line"

    OFF=$( [[ "$line" == *"PowerState:0"* ]] && echo "true" || echo "false" )
    ON=$( [[ "$line" == *"PowerState:1"* ]] && echo "true" || echo "false" )

    #$LOG_COMMAND "BLUETOOTH OFF $OFF"
    #$LOG_COMMAND "BLUETOOTH ON $ON"

    if [[ "$OFF" == "true" && "$BLUETOOTH_STATE" != "OFF" ]]; then
        $LOG_COMMAND "Bluetooth off..."
        /bin/bash "$SCRIPT_DIR/Shell/System/BluetoothOff.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
        BLUETOOTH_STATE="OFF"
    elif [[ "$ON" == "true" && "$BLUETOOTH_STATE" != "ON" ]]; then
        $LOG_COMMAND "Bluetooth on..."
        /bin/bash "$SCRIPT_DIR/Shell/System/BluetoothOn.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
        BLUETOOTH_STATE="ON"
    fi
  done

$LOG_COMMAND "end"
