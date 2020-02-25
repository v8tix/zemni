dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../../lib/dye4b/dye4b.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# Setup group and user.
# Globals:
#   BASH_BACKGROUND
#   BASH_FOREGROUND
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -uid <user_id>
#   -gid <group_id>
#   -un  <user_name>
#   -gn  <group_name>
# Returns:
#   BASH_BACKGROUND
#   BASH_FOREGROUND
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
setup_group_user() {
    if [[ $# -eq 8 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -uid)
          shift
          user_id="${1}"
          ;;
        -gid)
          shift
          group_id="${1}"
          ;;
        -un)
          shift
          user_name="${1}"
          ;;
        -gn)
          shift
          group_name="${1}"
          ;;
        *)
          usage_setup_group_user \
            LOG_ERROR \
            "setup_group_user" \
            "${UNKNOWN_FUNCTION_OPTION_CODE}" \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_setup_group_user \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    groupadd -r -g ${group_id} "${group_name}" && useradd -m -d /home/"${user_name}" --no-log-init -r -u ${user_id} -g ${group_name} -s /bin/bash "${user_name}"
    USER_INFO="$(cat /etc/passwd | grep "${user_name}")"

  else

    usage_setup_group_user \
      LOG_ERROR \
      "setup_group_user" \
      "${INVALID_NUMBER_PARAMETERS_CODE}" \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

  info \
    -o "setup_group_user" \
    -d "user ""${USER_INFO}"" added !" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
  return ${NO_ERRORS_CODE}
}

usage_setup_group_user() {
read -r -d '' temp_setup_group_user<<"EOF"
Usage: setup_group_user -<OPTIONS>\n
  OPTIONS       PARAMS                      DESCRIPTION\n
    -uid        <user_id>                   The user's ID.\n
    -gid        <group_id>                  The group's ID.\n
    -un         <user_name>                 The user's name.\n
    -gn         <group_name>                The group's name.\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "setup_group_user" \
    -d "${temp_setup_group_user}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}