#!/bin/bash

# Copyright 2018 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

export LD_PRELOAD=/usr/lib64/libnss_wrapper.so
export NSS_WRAPPER_PASSWD=/tmp/passwd
export NSS_WRAPPER_GROUP=/tmp/group
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RESET="\033[0m"

function enable_debugging() {
    if [[ ${CRUNCHY_DEBUG:-false} == "true" ]]
    then
        echo_info "Turning debugging on.."
        export PS4='+(${BASH_SOURCE}:${LINENO})> ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
        set -x
    fi
}

function ose_hack() {
    export USER_ID=$(id -u)
    export GROUP_ID=$(id -g)
    envsubst < /opt/cpm/conf/passwd.template > /tmp/passwd
    envsubst < /opt/cpm/conf/group.template > /tmp/group
}

function env_check_err() {
    if [[ -z ${!1} ]]
    then
        echo_err "$1 environment variable is not set, aborting."
        exit 1
    fi
}

function env_check_warn() {
    if [[ -z ${!1} ]]
    then
        echo_warn "$1 environment variable is not set."
    fi
}

function env_check_info() {
    if [[ ! -z ${!1} ]]
    then
        echo_info "$2"
    fi
}

function dir_check_err() {
    if [[ -d ${!1} ]]
    then
        echo_err "The $1 directory does not exist and is required."
        exit 1
    fi
}

function echo_err() {
    echo -e "${RED?}$(date) ERROR: ${1?}${RESET?}"
}

function echo_info() {
    echo -e "${GREEN?}$(date) INFO: ${1?}${RESET?}"
}

function echo_warn() {
    echo -e "${YELLOW?}$(date) WARN: ${1?}${RESET?}"
}

function custom_config() {
    config=${1?}
    mode=${2?}
    dir=${3?}
    owner=${4?}
    echo_info "Custom ${config?} detected.  Applying custom configuration.."
    cp ${config?} ${dir?}
    chown ${owner?} ${dir?}
    chmod ${mode?} ${dir?}
}
