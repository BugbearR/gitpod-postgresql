set -e

. ./config.sh

set +e
psql $PSQL_CONNECT_OPTIONS -c "CREATE DATABASE sampledb ENCODING='UTF8' LC_COLLATE='C' LC_CTYPE='C' TEMPLATE=template0;"
echo RC=$?
