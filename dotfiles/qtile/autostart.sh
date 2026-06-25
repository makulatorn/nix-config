#!/bin/bash

# Kill any existing instances to avoid background conflicts
killall picom

feh --bg-center /home/trasha/img/colemak_dh_main_ansi.png &

# Start cleanly using the NixOS system configuration definitions
picom -b
