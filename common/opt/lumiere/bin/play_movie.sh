#!/bin/bash

# -k: kill current player
# -o <n>: offset (0 for random)
# -l <n>: layer
# -r <n>: repeat n times (0 for loop)
# -a <0-255>: alpha
# -p <path>: movie file
# -f <w|b>: fade

source /opt/lumiere/bin/vars.inc

OFFSET=0
LAYER=1
LOOP=1
ALPHA=255
PATH=
FADE=

DO_RAND_OFFSET=""
KILL=""

while getopts ":hko:l:r:a:p:f:" opt; do
    case $opt in
        o)
            if [[ "$OPTARG" == "0" ]]
            then
                DO_RAND_OFFSET=y
            else
                OFFSET=$OPTARG
            fi
            ;;
        l)
            LAYER=$OPTARG
            ;;
        r)
            LOOP=$OPTARG
            ;;
        a)
            ALPHA=$OPTARG
            ;;
        p)
            PATH=$OPTARG
            ;;
        f)
            FADE=$OPTARG
            ;;
        k)
            KILL=y
            ;;
        h)
            echo "$0 -p path"
            echo "=================================================="
            echo "  -o <n>   : offset, 0 for random offset"
            echo "  -l <n>   : layer, default is layer 1"
            echo "  -r <n>   : repeat, default is 1, 0 for infinite"
            echo "  -a <n>   : alpha, 0 (transparent) - 255 (opaque)"
            echo "  -p <path>: file path"
            echo "  -f <w|b> : fade in and out to white or black"
            echo "  -k       : kill currently running player(s)"
            echo "=================================================="
            exit 1
            ;;
       \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

if [[ "$DO_RAND_OFFSET" == "y" ]]
then
    echo "OK: $DO_RAND_OFFSET"
    MOVIE_BYTES=$(/usr/bin/stat -c %s $PATH)
    OFFSET=$(/usr/bin/shuf -i 0-$MOVIE_BYTES -n 1)
fi

if [[ "$FADE" == "b" ]]
then
    fade_atob
elif [[ "$FADE" == "w" ]]
then
    fade_atow
fi

if [[ "$KILL" == "y" ]]
then
    /usr/bin/killall player.bin
fi
$LUMIERE_BIN/player.bin $LOOP $LAYER $ALPHA $OFFSET $PATH &

if [[ "$FADE" == "b" ]]
then
    fade_btoa
elif [[ "$FADE" == "w" ]]
then
    fade_wtoa
fi
