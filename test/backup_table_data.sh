#!/bin/sh
set -eu
SCRIPT_DIR=$(cd $(dirname $0); pwd)

. "$SCRIPT_DIR"/config.sh
. "$SCRIPT_DIR"/common.sh

NAME=${1:-$TIMESTAMP}

if [ -e data/$NAME ]; then
    echo data/$NAME is already exist.
    exit 1
fi

if [ \( ! -f target_tables.txt \) -o \( ! -r target_tables.txt \) ]; then
    echo please create target_tables.txt
    exit 1
fi

askYesNo "backup tables. ok?" || exit 1

psql_backup_table_tsv()
{
    ${PSQL} -c "\\copy $1 to '$2' with delimiter E'\\t'"
}

mkdir -p data
mkdir data/$NAME
RC=$?
if [ $RC -ne 0 ]; then
    exit 1
fi

while read table
do
    psql_backup_table_tsv $table data/$NAME/$table.tsv
done < target_tables.txt
