#!/usr/bin/env bash
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/lib_locale.sh"
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../../common.sh"

setup_locale -i "${INPUT_FILE}" -f "${CHARMAP_FILE}" -a "${ALIAS}"