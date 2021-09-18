createRealtimeTimestamp() {
    date "+%Y%m%dT%H%M%S"
}

if [ ! ${TIMESTAMP:+x} ]; then
    export TIMESTAMP=$(createRealtimeTimestamp)
fi

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

PSQL="psql $PSQL_CONNECT_OPTIONS $TARGET_DB"
PSQL_NO_DB="psql $PSQL_CONNECT_OPTIONS template1"
