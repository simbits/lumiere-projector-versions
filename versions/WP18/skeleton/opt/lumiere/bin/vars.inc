#!/bin/bash

WALLID=1

LUMIERE_SEQ_STARTER=start.sh

START_RECEIVER=false

LUMIERE_PATH=/opt/lumiere
LUMIERE_BIN=/opt/lumiere/bin
LUMIERE_MEDIA=/opt/lumiere/media
LUMIERE_SEQ=$LUMIERE_BIN/sequences

export LD_LIBRARY_PATH=/opt/vc/lib

FADER_PORT=9999
FADER_ADDR=localhost
FADER_LAYER=500
FADER_DELAY=10000

FADE_ATOB=1
FADE_BTOA=2
FADE_ATOW=3
FADE_WTOA=4

function fade_atob {
    echo $FADE_ATOB | /usr/bin/netcat $FADER_ADDR $FADER_PORT
}

function fade_btoa {
    echo $FADE_BTOA | /usr/bin/netcat $FADER_ADDR $FADER_PORT
}

function fade_atow {
    echo $FADE_ATOW | /usr/bin/netcat $FADER_ADDR $FADER_PORT
}

function fade_wtoa {
    echo $FADE_WTOA | /usr/bin/netcat $FADER_ADDR $FADER_PORT
}
