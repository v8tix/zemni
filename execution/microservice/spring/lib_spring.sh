dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../lib/dye4b/dye4b.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# Run the microservice.
# Globals:
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -f <fatjar_dir>
#   -c <spring_config_dir>
#   -t <java_io_tmpdir>
# Returns:
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
run() {
  if [[ $# -eq 6 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -f)
          shift
          fatjar_dir="${1}"
          ;;
        -c)
          shift
          spring_config_dir="${1}"
          ;;
        -t)
          shift
          java_io_tmpdir="${1}"
          ;;
        *)
          usage_run \
            LOG_ERROR \
            "run" \
            "${UNKNOWN_FUNCTION_OPTION_CODE}" \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_run \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    java -Djava.io.tmpdir="${java_io_tmpdir}" -jar "${fatjar_dir}" --spring.config.location="file://${spring_config_dir}"
    return ${NO_ERRORS_CODE}

  else

    usage_run \
      LOG_ERROR \
      "run" \
      "${INVALID_NUMBER_PARAMETERS_CODE}" \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi
}

usage_run() {
read -r -d '' temp_run<<"EOF"
Usage: run -<OPTIONS>\n
  OPTIONS       PARAMS                      DESCRIPTION\n
    -f          <fatjar_dir>                The microservice full path.\n
    -c          <spring_config_dir>         The Spring configuration files path.\n
    -t          <java_io_tmpdir>            The Java IO temporal directory.\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "run" \
    -d "${temp_run}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}
