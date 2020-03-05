#!/usr/bin/env bash
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/lib_ssh.sh"
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../common.sh"

setup_pk \
  -root "${ROOT_ACCESS}"  \
  -f "${FILE_NAME}"  \
  -m "${USER_EMAIL}" \
  -ph "" \
  -pt ""