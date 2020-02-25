#!/usr/bin/env bash
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../dye4b.sh"

#Your Unix bash default background colour
BASH_BACKGROUND="$(bgc -c black)"
#Your Unix bash default foreground colour
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

ORIGIN="What is Lorem Ipsum?"
DESCRIPTION="is simply dummy text of the printing and typesetting industry."

warn -o "${ORIGIN}" -d "${DESCRIPTION}" -dfg "${BASH_FOREGROUND}" -dbg "${BASH_BACKGROUND}"
info -o "${ORIGIN}" -d "${DESCRIPTION}" -dfg "${BASH_FOREGROUND}" -dbg "${BASH_BACKGROUND}"
error -o "${ORIGIN}" -d "${DESCRIPTION}" -dfg "${BASH_FOREGROUND}" -dbg "${BASH_BACKGROUND}"
