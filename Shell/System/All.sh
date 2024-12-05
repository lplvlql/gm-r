#!/bin/bash

SCRIPT_DIR="/Users/Shared/Script"
LOG_COMMAND="/bin/bash $SCRIPT_DIR/Shell/Log/Log.sh $0"

SYSTEM_DIR="$SCRIPT_DIR/Shell/System"
#/bin/bash $SYSTEM_DIR/PowerLog.sh &
#/bin/bash $SYSTEM_DIR/BluetoothLog.sh &
/bin/bash $SYSTEM_DIR/Wait8.sh &
wait