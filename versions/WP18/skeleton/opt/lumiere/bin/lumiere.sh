#!/bin/bash

source /opt/lumiere/bin/vars.inc

killall -9 lm_player.bin
killall -9 lm_receiver_wp18
killall -9 lm_fade.bin

echo "start fader service"
/usr/bin/lm_fade.bin $FADER_PORT $FADER_LAYER $FADER_DELAY &

if [[ "$START_RECEIVER" = true ]]
then
    echo "start receiver"
    /usr/bin/lm_receiver $FADER_PORT &
fi

sleep 1

#echo none > /sys/class/leds/led0/trigger

$LUMIERE_SEQ/$LUMIERE_SEQ_STARTER &
