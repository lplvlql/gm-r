#!/bin/bash

# Start sudo session for the entire script
echo "0596" | sudo -S -v
sudo -E /bin/bash "$1" && sudo -k