#!/bin/sh
set -eu
SCRIPT_DIR=$(cd $(dirname $0); pwd)

. "$SCRIPT_DIR"/config.sh
. "$SCRIPT_DIR"/common.sh

NAME=${1:-$TIMESTAMP}

TARGET_TABLES_FILE="$SCRIPT_DIR"/target_tables.txt

if [ -e data/$NAME ]; then
    echo data/$NAME is already exist.
    exit 1
fi

if [ \( ! -f "$TARGET_TABLES_FILE" \) -o \( ! -r "$TARGET_TABLES_FILE" \) ]; then
    echo please create $TARGET_TABLES_FILE
    exit 1
fi

askYesNo "backup tables. ok?" || exit 1

mkdir -p data
mkdir data/$NAME
RC=$?
if [ $RC -ne 0 ]; then
    exit 1
fi

while read table
do
    psql_backup_table_tsv $table data/$NAME/$table.tsv
done < "$TARGET_TABLES_FILE"
