#!/bin/sh
set -eu
SCRIPT_DIR=$(cd $(dirname $0); pwd)

. "$SCRIPT_DIR"/config.sh
. "$SCRIPT_DIR"/common.sh

${PSQL} -Aqt -F "$(printf '\t')" <<__EOT__
SELECT
    table_schema,
    table_name,
    column_name,
    ordinal_position,
    data_type,
    character_maximum_length,
    numeric_precision,
    numeric_precision_radix,
    numeric_scale,
    datetime_precision
FROM
    information_schema.columns
WHERE
    table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY table_schema, table_name, ordinal_position
__EOT__
