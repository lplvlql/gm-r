#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

POWER_STATE=""
BLUETOOTH_STATE=""

$LOG_COMMAND "start"

# Start streaming logs related to powerd
log stream --predicate 'process == "powerd" AND eventMessage contains "UseActiveState:"' | while read -r line
  do
    # Log the incoming line
    #$LOG_COMMAND "$line"

    OFF=$( [[ "$line" == *"UseActiveState:0"* ]] && echo "true" || echo "false" )
    ON=$( [[ "$line" == *"UseActiveState:1"* ]] && echo "true" || echo "false" )

    #$LOG_COMMAND "POWER OFF $OFF"
    #$LOG_COMMAND "POWER ON $ON"

    if [[ "$OFF" == "true" && "$POWER_STATE" != "OFF" ]]; then
      $LOG_COMMAND "Power off..."
      /bin/bash "$SCRIPT_DIR/Shell/System/PowerOff.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
      POWER_STATE="OFF"
    elif [[ "$ON" == "true" && "$POWER_STATE" != "ON" ]]; then
      $LOG_COMMAND "Power on..."
      /bin/bash "$SCRIPT_DIR/Shell/System/PowerOn.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
      POWER_STATE="ON"
    fi
  done

$LOG_COMMAND "end"
