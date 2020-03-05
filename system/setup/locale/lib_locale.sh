dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../lib/dye4b/dye4b.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# Setup the locale.
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
#   -i <input_file>
#   -f <charmap_file>
#   -a <alias>
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
setup_locale() {
  if [[ $# -eq 6 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -i)
          shift
          input_file="${1}"
          ;;
        -f)
          shift
          charmap_file="${1}"
          ;;
        -a)
          shift
          alias="${1}"
          ;;
        *)
          usage_setup_locale \
            LOG_ERROR \
            "setup_locale" \
            "${UNKNOWN_FUNCTION_OPTION_CODE}" \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_setup_locale \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    localedef -i "${input_file}" -c -f "${charmap_file}" -A /usr/share/locale/locale.alias "${alias}"

  else

    usage_setup_locale \
      LOG_ERROR \
      "setup_locale" \
      "${INVALID_NUMBER_PARAMETERS_CODE}" \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

  info \
    -o "setup_locale" \
    -d """${alias}"" established !" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
  return ${NO_ERRORS_CODE}
}

usage_setup_locale() {
read -r -d '' temp_setup_locale<<"EOF"
Usage: setup_locale -<OPTIONS>\n
  OPTIONS       PARAMS                      DESCRIPTION\n
    -i          <input_file>                Specify the locale definition file to compile.
    -f          <charmap_file>              Specify the file that defines the symbolic character names that are used by the input file.
    -a          <alias>                     The locale's alias.\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "setup_locale" \
    -d "${temp_setup_locale}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}