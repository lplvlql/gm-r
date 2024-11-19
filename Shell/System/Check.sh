#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh Check.sh"

$LOG_COMMAND "start"

# Start streaming logs related to the lock UI and display states
log stream --predicate 'eventMessage contains "Lockscreen" AND (eventMessage contains "lockUIShowing" OR eventMessage contains "shield" OR eventMessage contains "displaySleeping")' | while read -r line
  do
    # Log the incoming line
    $LOG_COMMAND "$line"

    SHIELD=$(echo "$line" | grep -q "Shield: true" && echo true || echo false)
    LOCK_UI_SHOWING=$(echo "$line" | grep -q "lockUIShowing: true" && echo true || echo false)
    DISPLAY_SLEEPING=$(echo "$line" | grep -q "displaySleeping: true" && echo true || echo false)

    #[ "$LOCK_UI_SHOWING" == "true" ] && 
    if [ "$SHIELD" == "true" ] && [ "$DISPLAY_SLEEPING" == "true" ]; then
        $LOG_COMMAND "Mac sleeping..."
        /bin/bash "$SCRIPT_DIR/Shell/System/Sleep.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
    else
        $LOG_COMMAND "Mac waking..."
        /bin/bash "$SCRIPT_DIR/Shell/System/Wake.sh" >> >(while read line; do $LOG_COMMAND "$line"; done) 2>&1
    fi
  done

$LOG_COMMAND "end"
