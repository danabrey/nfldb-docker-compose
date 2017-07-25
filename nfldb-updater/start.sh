#!/bin/bash

psql -h db -p 5432 -U nfldb nfldb < /nfldb.sql

# https://github.com/torhve/pix/issues/2 could not open temporary statistics file "/var/run/postgresql/9.3-main.pg_stat_tmp/global.tmp": No such file or directory
mkdir -p /var/run/postgresql/9.3-main.pg_stat_tmp

# Workaround for https://github.com/BurntSushi/nfldb/issues/194
psql -h db -p 5432 -U nfldb nfldb -c "INSERT into team values('JAX','Jacksonville', 'Jaguars');"
nfldb-update
psql -h db -p 5432 -U nfldb nfldb -c "UPDATE play SET pos_team = 'JAC' WHERE pos_team = 'JAX';"
psql -h db -p 5432 -U nfldb nfldb -c "DELETE FROM team WHERE team_id = 'JAX';"

nfldb-update --interval 120