#!/bin/sh
set -eu
SCRIPT_DIR=$(cd $(dirname $0); pwd)

. "$SCRIPT_DIR"/config.sh
. "$SCRIPT_DIR"/common.sh

if [ $# -ne 1 ]
then
    echo "usage: $0 table_name"
    exit 1
fi

${PSQL} -Aqt -F "$(printf '\t')" -c "\\d $1"
