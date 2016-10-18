#!/bin/bash

source /opt/lumiere/bin/vars.inc

modprobe usb-storage

# set mask and black background
# (already set in S01Lumiere)
#echo "setting mask and background"
#$LUMIERE_BIN/pngview.bin -b 0x0000 /opt/lumiere/media/clouds_mask.png &

echo "start fader service"
$LUMIERE_BIN/fade $FADER_PORT $FADER_LAYER $FADER_DELAY &

if [[ "$START_RECEIVER" = true ]]
then
    echo "start receiver"
    $LUMIERE_PATH/bin/receiver $FADER_PORT &
fi

sleep 1

#echo none > /sys/class/leds/led0/trigger

$LUMIERE_SEQ/$LUMIERE_SEQ_STARTER &
