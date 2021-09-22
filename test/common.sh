PSQL="psql $PSQL_CONNECT_OPTIONS $TARGET_DB"
PSQL_NO_DB="psql $PSQL_CONNECT_OPTIONS template1"

createRealtimeTimestamp() {
    date "+%Y%m%dT%H%M%S"
}

askYesNo() {
    while :
    do
        read -p "$1""(y/n)" askYesNo_ans
        case $askYesNo_ans in
            [Yy]) return 0;;
            [Yy][Ee][Ss]) return 0;;
            [Nn]) return 1;;
            [Nn][Oo]) return 1;;
        esac
    done
}

psql_backup_table_tsv()
{
    ${PSQL} -c "\\copy $1 to '$2' with delimiter E'\\t'"
}

psql_restore_table_tsv()
{
    ${PSQL} -c "truncate $1;"
    ${PSQL} -c "\\copy $1 from '$2' with delimiter E'\\t'"
}

if [ ! ${TIMESTAMP:+x} ]; then
    export TIMESTAMP=$(createRealtimeTimestamp)
fi
