#!/bin/bash

source /opt/cpm/bin/common_lib.sh
enable_debugging
ose_hack

custom_config "/pgconf/postgresql.conf" 600 "${PGDATA?}" "postgres:postgres"
custom_config "/pgconf/pg_hba.conf" 600 "${PGDATA?}" "postgres:postgres"
custom_config "/pgconf/pg_ident.conf" 600 "${PGDATA?}" "postgres:postgres"
custom_config "/pgconf/server.key" 400 "${PGDATA?}" "postgres:postgres"
custom_config "/pgconf/server.crt" 400 "${PGDATA?}" "postgres:postgres"
custom_config "/pgconf/ca.crt" 600 "${PGDATA?}" "postgres:postgres"
custom_config "/pgconf/ca.crl" 600 "${PGDATA?}" "postgres:postgres"
