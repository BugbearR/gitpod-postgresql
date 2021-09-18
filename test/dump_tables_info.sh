#!/bin/sh
set -eu
SCRIPT_DIR=$(cd $(dirname $0); pwd)

. "$SCRIPT_DIR"/config.sh
. "$SCRIPT_DIR"/common.sh

${PSQL} -Aqt -F "$(printf '\t')" <<__EOT__
SELECT
    table_schema || '.' || table_name,
    table_type
FROM
    information_schema.tables
WHERE
    table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY table_schema, table_name
__EOT__
