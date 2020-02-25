dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../lib/dye4b/dye4b.sh"
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../lib/string/lib_string.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# It returns the M2_HOME and PATH ENV variables content.
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
#   -d <maven_installation_dir>
# Returns:
#   string ${mvn_env_content}
#   BASH_BACKGROUND
#   BASH_FOREGROUND
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
mvn_env_content() {
  if [[ $# -eq 2 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -d)
          shift
          mvn_dir="${1}"
          ;;
        *)
          usage_mvn_env_content \
            LOG_ERROR \
            "mvn_env_content" \
            ${UNKNOWN_FUNCTION_OPTION_CODE} \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_mvn_env_content \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    if [[ -d "${mvn_dir}" ]]; then

read -r -d '' mvn_env_content<<EOF
export M2_HOME=${mvn_dir}
EOF

read -r -d '' path_env<<"EOF"
export PATH=${PATH}:${M2_HOME}/bin
EOF

  echo -e ""${mvn_env_content}"\n"${path_env}""

    else

      error \
        -o "mvn_env_content" \
        -d "invalid directory" \
        -dfg "${BASH_FOREGROUND}" \
        -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}

    fi

  else

    usage_mvn_env_content \
      LOG_ERROR \
      "mvn_env_content" \
      ${INVALID_NUMBER_PARAMETERS_CODE} \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

  return ${NO_ERRORS_CODE}
}

usage_mvn_env_content() {
read -r -d '' temp_mvn_env_content<<"EOF"
Usage: mvn_env_content -<OPTIONS>\n
  OPTIONS       PARAMS                      DESCRIPTION\n
    -d          <maven_installation_dir>     The Maven installation dir.\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "mvn_env_content" \
    -d "${temp_mvn_env_content}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}

#######################################
# Setup Maven.
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
#   -d <maven_installation_dir>
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
setup_mvn() {

  URL_DELIMITER='/'
  MVN_DIR_INDEX=0
  FILE_EXT="*.tar.gz"
  BASH_FILE_PATH="/etc/bash.bashrc"

  if [[ $# -eq 2 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -d)
          shift
          mvn_dir="${1}"
          ;;
        *)
          usage_setup_mvn \
            LOG_ERROR \
            "setup_mvn" \
            ${UNKNOWN_FUNCTION_OPTION_CODE} \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_setup_mvn \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    if [[ -d "${mvn_dir}" ]]; then

      cd "${mvn_dir}"
      tarball_dir="$(find "${mvn_dir}" -type f -name "${FILE_EXT}")"

      if [[ $? -eq 0 ]]; then

        tar_output="$(tar xvzf "${tarball_dir}")"
        last_line="${tar_output##*$'\n'}"
        mvn_dir_name="$(substring -s "${last_line}" -d "${URL_DELIMITER}" -i ${MVN_DIR_INDEX})"
        mvn_path="${mvn_dir}"/"${mvn_dir_name}"
        rm "${tarball_dir}"
        mvn_env_content -d "${mvn_path}" >> "${BASH_FILE_PATH}"

      else

        error \
          -o "setup_mvn" \
          -d "couldn't find the following file "${tarball_dir}"." \
          -dfg "${BASH_FOREGROUND}" \
          -dbg "${BASH_BACKGROUND}"
        return ${ERROR_CODE}

      fi

    else

      error \
        -o "setup_mvn" \
        -d "invalid installation directory." \
        -dfg "${BASH_FOREGROUND}" \
        -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}

    fi

  else

    usage_setup_mvn \
      LOG_ERROR \
      "setup_mvn" \
      ${INVALID_NUMBER_PARAMETERS_CODE} \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

  info \
    -o "setup_mvn" \
    -d "Maven installed !" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
  return ${NO_ERRORS_CODE}
}

usage_setup_mvn() {
read -r -d '' temp_setup_mvn<<"EOF"
Usage: install_maven -<OPTIONS>\n
  OPTIONS       PARAMS                      DESCRIPTION\n
    -d          <maven_installation_dir>     The Maven installation dir.\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "setup_mvn" \
    -d "${temp_setup_mvn}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}