#!/bin/sh
set -eu
SCRIPT_DIR=$(cd $(dirname $0); pwd)

. "$SCRIPT_DIR"/config.sh
. "$SCRIPT_DIR"/common.sh

while :
do
    T=$(createRealtimeTimestamp)
    echo $TIMESTAMP
    echo $T
    sleep 1
done

