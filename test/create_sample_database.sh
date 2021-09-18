#!/bin/sh
set -eu
SCRIPT_DIR=$(cd $(dirname $0); pwd)

. "$SCRIPT_DIR"/config.sh
. "$SCRIPT_DIR"/common.sh

set +e
${PSQL_NO_DB} -c "CREATE DATABASE sampledb ENCODING='UTF8' LC_COLLATE='C' LC_CTYPE='C' TEMPLATE=template0;"
echo RC=$?
set -e

${PSQL} <<__EOT__
CREATE TABLE sample_table (
    key1 CHAR(20) NOT NULL,
    char1 CHAR(10),
    varchar1 VARCHAR,
    varchar2 VARCHAR(10),
    smallint1 SMALLINT,
    integer1 INTEGER,
    bigint1 BIGINT,
    double1 DOUBLE PRECISION,
    real1 REAL,
    numeric1 NUMERIC,
    numeric2 NUMERIC(10,3),
    timestamp1 TIMESTAMP,
    timestamp2 TIMESTAMP(3),
    timestamp3 TIMESTAMP(0),
    timestamptz1 TIMESTAMP WITH TIME ZONE,
    timestamptz2 TIMESTAMP(3) WITH TIME ZONE,
    timestamptz3 TIMESTAMP(0) WITH TIME ZONE,
    interval1 INTERVAL,
    date1 DATE,
    bool1 BOOLEAN,
    json1 JSON,
    jsonb1 JSONB,
    PRIMARY KEY (key1)
);
__EOT__
