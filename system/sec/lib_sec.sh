dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../lib/dye4b/dye4b.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

########################################################
# Remove all the SUID and SGID permissions.
# Globals:
#   BASH_BACKGROUND
#   BASH_FOREGROUND
#   NO_ERRORS_CODE
# Arguments:
#   None.
# Returns:
#   NO_ERRORS_CODE
########################################################
remove_all_sperm() {
for i in $(find / -type f \( -perm /u=s -o -perm /g=s \)); do
    chmod ug-s "${i}"
done

info \
  -o "remove_all_sperm" \
  -d "All SUID and SGID permissions removed !" \
  -dfg "${BASH_FOREGROUND}" \
  -dbg "${BASH_BACKGROUND}"

return ${NO_ERRORS_CODE}
}

########################################################
# Remove all the SUID and SGID permissions except ping.
# Globals:
#   BASH_BACKGROUND
#   BASH_FOREGROUND
#   NO_ERRORS_CODE
# Arguments:
#   None.
# Returns:
#   NO_ERRORS_CODE
########################################################
remove_all_sperm_allow_ping() {
for i in $(find / -type f \( -perm /u=s -o -perm /g=s \)); do
  PING_DIR='/bin/ping'
  if [[ ""${PING_DIR}"" != *""${i}""* ]]; then
    chmod ug-s ""${i}""
  fi
done

info \
  -o "remove_all_sperm_allow_ping" \
  -d "All SUID and SGID permissions removed except the ping utility!" \
  -dfg "${BASH_FOREGROUND}" \
  -dbg "${BASH_BACKGROUND}"

return ${NO_ERRORS_CODE}
}




