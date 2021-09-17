#!/bin/sh

. ./config.sh

# psql -Aqt --csv <<__EOT__
psql $PSQL_CONNECT_OPTIONS -Aqt -F "$(printf '\t')" <<__EOT__
SELECT
    table_schema,
    table_name,
    table_type
FROM
    information_schema.tables
WHERE
    table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY table_schema, table_name
__EOT__
