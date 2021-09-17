#!/bin/sh

TIMESTAMP=$(date "+%Y%m%dT%H%M%S")

. ./common.sh
. ./config.sh

if [ $# -lt 1 ]; then
    echo usage $0 backup_name
fi

NAME=$1

if [ ! -e data/$NAME ]; then
    echo data/$NAME is not found.
    exit 1
fi

while read table
do
    if [ ! -r data/$NAME/$table.tsv ]; then
        echo "can't read data/$NAME/$table.tsv . stop."
        exit 1
    fi
done < target_tables.txt

askYesNo "restore tables. ok?" || exit 1

function psql_backup_table_tsv()
{
    psql $PSQL_CONNECT_OPTIONS -c "\\copy $1 to '$2' with delimiter E'\\t'"
}

function psql_restore_table_tsv()
{
    psql $PSQL_CONNECT_OPTIONS -c "truncate $1;"
    psql $PSQL_CONNECT_OPTIONS -c "\\copy $1 from '$2' with delimiter E'\\t'"
}

mkdir -p data_before_restore
mkdir data_before_restore/$TIMESTAMP
RC=$?
if [ $RC -ne 0 ]; then
    exit 1
fi

while read table
do
    psql_backup_table_tsv $table data_before_restore/$TIMESTAMP/$table.tsv
done < target_tables.txt

while read table
do
    psql_restore_table_tsv $table data/$NAME/$table.tsv
done < target_tables.txt
