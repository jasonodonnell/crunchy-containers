#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PGSSLROOTCERT=${DIR?}/configs/ca.crt
export PGSSLCRL=${DIR?}/configs/ca.crl
export PGSSLCERT=${DIR?}/configs/client.crt
export PGSSLKEY=${DIR?}/configs/client.key
