#!/bin/bash

LOG_FILE="/Users/Shared/Script/Shell/Log/Log.log"

if [ -z "$2" ]; then
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
else
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1: $2" >> "$LOG_FILE"
fi