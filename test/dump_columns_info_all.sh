#!/bin/sh
set -eu
SCRIPT_DIR=$(cd $(dirname $0); pwd)

. "$SCRIPT_DIR"/config.sh
. "$SCRIPT_DIR"/common.sh

TARGET_TABLES_FILE="$SCRIPT_DIR"/target_tables.txt

while IFS= read line || [ -n "$line" ]
do
    ${PSQL} -Aqt -F "$(printf '\t')" -c "\\d $line" > "$line".columns.tsv
done < "$TARGET_TABLES_FILE"
