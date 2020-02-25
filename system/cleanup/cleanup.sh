#!/usr/bin/env bash
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/lib_cleanup.sh"

remove_docs
remove_logs
remove_locales
remove_cache

