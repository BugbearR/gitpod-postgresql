#!/bin/sh

TIMESTAMP=$(date "+%Y%m%dT%H%M%S")

. ./common.sh
. ./config.sh

NAME=${1:-$TIMESTAMP}

if [ -e data/$NAME ]; then
    echo data/$NAME is already exist.
    exit 1
fi

askYesNo "backup tables. ok?" || exit 1

function psql_backup_table_tsv()
{
    psql $PSQL_CONNECT_OPTIONS -c "\\copy $1 to '$2' with delimiter E'\\t'"
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
