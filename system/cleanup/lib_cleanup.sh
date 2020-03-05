dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../lib/dye4b/dye4b.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

########################################################
# Remove documentation.
# Globals:
#   BASH_BACKGROUND
#   BASH_FOREGROUND
#   NO_ERRORS_CODE
# Arguments:
#   None.
# Returns:
#   NO_ERRORS_CODE
########################################################
remove_docs() {
rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/*
info \
  -o "remove_docs" \
  -d "documentation removed !" \
  -dfg "${BASH_FOREGROUND}" \
  -dbg "${BASH_BACKGROUND}"
return ${NO_ERRORS_CODE}
}

########################################################
# Remove logs.
# Globals:
#   BASH_BACKGROUND
#   BASH_FOREGROUND
#   NO_ERRORS_CODE
# Arguments:
#   None.
# Returns:
#   NO_ERRORS_CODE
########################################################
remove_logs() {
find /var | grep '\.log$' | xargs rm -v
info \
  -o "remove_logs" \
  -d "logs removed !" \
  -dfg "${BASH_FOREGROUND}" \
  -dbg "${BASH_BACKGROUND}"
return ${NO_ERRORS_CODE}
}

########################################################
# Remove cache.
# Globals:
#   BASH_BACKGROUND
#   BASH_FOREGROUND
#   NO_ERRORS_CODE
# Arguments:
#   None.
# Returns:
#   NO_ERRORS_CODE
########################################################
remove_cache() {
apt autoremove
apt clean
info \
  -o "remove_cache" \
  -d "apt cache removed !" \
  -dfg "${BASH_FOREGROUND}" \
  -dbg "${BASH_BACKGROUND}"
return ${NO_ERRORS_CODE}
}

########################################################
# Remove locales list.
# Globals:
#   BASH_BACKGROUND
#   BASH_FOREGROUND
#   NO_ERRORS_CODE
# Arguments:
#   None.
# Returns:
#   NO_ERRORS_CODE
########################################################
remove_locales() {
rm -rf /var/lib/apt/lists/*
info \
  -o "remove_locales" \
  -d "locales removed !" \
  -dfg "${BASH_FOREGROUND}" \
  -dbg "${BASH_BACKGROUND}"
return ${NO_ERRORS_CODE}
}