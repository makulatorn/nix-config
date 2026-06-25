#!/bin/bash

# Kill any existing instances to avoid background conflicts
killall picom

# Start cleanly using the NixOS system configuration definitions
picom -b
