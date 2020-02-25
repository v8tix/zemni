dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../../lib/dye4b/dye4b.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# Setup Git.
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
#    -u          <user_name>
#    -m          <user_email>
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
setup_git() {
  if [[ $# -eq 4 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -u)
          shift
          user_name="${1}"
          ;;
        -m)
          shift
          user_email="${1}"
          ;;
        *)
         usage_setup_git \
            LOG_ERROR \
            "setup_git" \
            ${UNKNOWN_FUNCTION_OPTION_CODE} \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_setup_git \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    git config --global user.name "${user_name}"
    git config --global user.email "${user_email}"
    git config --list

    info \
      -o "setup_git" \
      -d "GIT installed !" \
      -dfg "${BASH_FOREGROUND}" \
      -dbg "${BASH_BACKGROUND}"
    return ${NO_ERRORS_CODE}

  else

    usage_setup_git \
      LOG_ERROR \
      "setup_git" \
      ${INVALID_NUMBER_PARAMETERS_CODE} \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi
}

usage_setup_git() {
read -r -d '' temp_setup_git<<"EOF"
Usage: setup_git -<OPTIONS>\n
  OPTIONS       PARAMS                  DESCRIPTION\n
    -u          <user_name>             The git user name.\n
    -m          <user_email>            The git user email.\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "setup_git" \
    -d "${temp_setup_git}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}