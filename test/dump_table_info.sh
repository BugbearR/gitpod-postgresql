#!/bin/sh

. ./config.sh

# psql -Aqt --csv <<__EOT__
psql $PSQL_CONNECT_OPTIONS -Aqt -F "$(printf '\t')" <<__EOT__
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
