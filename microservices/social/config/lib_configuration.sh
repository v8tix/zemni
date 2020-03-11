dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../lib/dye4b/dye4b.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# It returns the Spring default profile.
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
#   -sp <spring_profile>
#   -cd <config_directory>
#   -td <template_config_directory>
#   -c <connection_file_directory>
#   -h <microservice_host>
#   -p <microservice_port>
#   -v <microservice_version>
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
profile_configuration() {
  CONN_FILE_NAME="database_uri"
  if [[ $# -eq 14 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -sp)
          shift
          spring_profile="${1}"
          ;;
        -cd)
          shift
          config_dir="${1}"
          ;;
        -td)
          shift
          config_templates_dir="${1}"
          ;;
        -c)
          shift
          connection_file_dir="${1}"
          ;;
        -h)
          shift
          microservice_host="${1}"
          ;;
        -p)
          shift
          microservice_port="${1}"
          ;;
        -v)
          shift
          microservice_version="${1}"
          ;;
        *)
          usage_profile_configuration \
            LOG_ERROR \
            "profile_configuration" \
            "${UNKNOWN_FUNCTION_OPTION_CODE}" \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_profile_configuration \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    if [[ ! -d "${config_dir}" ]]; then
      error \
      -o "profile_configuration" \
      -d "directory: "${config_dir}" not found !" \
      -dfg "${BASH_FOREGROUND}" \
      -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}
    fi

    if [[ -n "${spring_profile}" ]];then
      if [[ "${spring_profile}" == "dev" || "${spring_profile}" == "prod" ]];then
        cp ${config_templates_dir}/application-d.yml ${config_dir}/application-default.yml
        sed -i "s/<1>/${spring_profile}/g" ${config_dir}/application-default.yml
        cp ${config_templates_dir}/application-x.yml ${config_dir}/application-${spring_profile}.yml
        CONNECTION_URI=$(<${CONN_FILE_NAME})
        sed -i "s+<1>+"${CONNECTION_URI}"+g" ${config_dir}/application-${spring_profile}.yml
        sed -i "s/<2>/${microservice_version}/g" ${config_dir}/application-${spring_profile}.yml
        sed -i "s/<3>/${microservice_port}/g" ${config_dir}/application-${spring_profile}.yml
        sed -i "s/<4>/${microservice_host}/g" ${config_dir}/application-${spring_profile}.yml
      else
        error \
        -o "profile_configuration" \
        -d "invalid parameter" \
        -dfg "${BASH_FOREGROUND}" \
        -dbg "${BASH_BACKGROUND}"
        return ${ERROR_CODE}
      fi
    else
      error \
        -o "profile_configuration" \
        -d "invalid parameter" \
        -dfg "${BASH_FOREGROUND}" \
        -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}
    fi

  else

    usage_profile_configuration \
      LOG_ERROR \
      "profile_configuration" \
      "${INVALID_NUMBER_PARAMETERS_CODE}" \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

  return ${NO_ERRORS_CODE}
}

usage_profile_configuration() {
read -r -d '' temp_profile_configuration<<"EOF"
Usage: profile_configuration -<OPTIONS>\n
  OPTIONS       PARAMS                      DESCRIPTION\n
    -sp          <spring_profile>            The Spring profile. Possible values: [dev, prod].\n
    -cd          <config_directory>          The configuration directory.\n
    -td          <template_config_directory> The template configuration directory.\n
    -c          <connection_file_directory>  The file containing the database connection URI (File name must be database_uri).\n
    -h          <microservice_host>          The host allocated for the Social microservice.\n
    -p          <microservice_port>          The microservice port.\n
    -v          <microservice_version>       The microservice version.\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "profile_configuration" \
    -d "${temp_profile_configuration}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}