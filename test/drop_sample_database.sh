#!/bin/sh
set -eu
SCRIPT_DIR=$(cd $(dirname $0); pwd)

. "$SCRIPT_DIR"/config.sh
. "$SCRIPT_DIR"/common.sh

set +e
${PSQL_NO_DB} -c "DROP DATABASE sampledb;"
echo RC=$?
set -e
