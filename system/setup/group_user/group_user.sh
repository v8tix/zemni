#!/usr/bin/env bash
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/lib_group_user.sh"
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../common.sh"

setup_group_user -uid ${USER_ID} -gid ${GROUP_ID} -un "${USER_NAME}" -gn "${GROUP_NAME}"




