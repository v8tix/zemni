#!/usr/bin/env bash
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/lib_configuration.sh"
HOST="localhost"
PORT=8080
VERSION=1.0.0.v20200309
CONFIG_OUTPUT_DIR="/home/v8tix/Public/Projects/libs/zemni/microservices/social/config"
DATABASE_CONNECTION_DIR="/home/v8tix/Public/Projects/libs/zemni/microservices/social/config"
CONFIG_TEMPLATE_DIR="/home/v8tix/Public/Projects/libs/zemni/microservices/social/config"
SPRING_PROFILE="dev"
profile_configuration -cd ${CONFIG_OUTPUT_DIR} -sp ${SPRING_PROFILE} -td ${CONFIG_TEMPLATE_DIR} -c ${DATABASE_CONNECTION_DIR} -h ${HOST} -p ${PORT} -v ${VERSION}