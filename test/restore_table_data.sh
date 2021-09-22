#!/bin/sh
set -eu
SCRIPT_DIR=$(cd $(dirname $0); pwd)

. "$SCRIPT_DIR"/config.sh
. "$SCRIPT_DIR"/common.sh

TARGET_TABLES_FILE="$SCRIPT_DIR"/target_tables.txt

if [ $# -lt 1 ]; then
    echo usage $0 backup_name
fi

NAME=$1

if [ ! -e "$DATA_DIR"/$NAME ]; then
    echo data/$NAME is not found.
    exit 1
fi

while read table
do
    if [ ! -r data/$NAME/$table.tsv ]; then
        echo "can't read data/$NAME/$table.tsv . stop."
        exit 1
    fi
done < "$TARGET_TABLES_FILE"

askYesNo "restore tables. ok?" || exit 1

mkdir -p data_before_restore
mkdir data_before_restore/$TIMESTAMP
RC=$?
if [ $RC -ne 0 ]; then
    exit 1
fi

while read table
do
    psql_backup_table_tsv $table data_before_restore/$TIMESTAMP/$table.tsv
done < "$TARGET_TABLES_FILE"

while read table
do
    psql_restore_table_tsv $table data/$NAME/$table.tsv
done < "$TARGET_TABLES_FILE"
