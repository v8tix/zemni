dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../lib/dye4b/dye4b.sh"
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../lib/string/lib_string.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# It returns the JAVA_HOME and PATH ENV variables content.
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
#   -d <java_installation_dir>
# Returns:
#   string ${java_env_content}
#   BASH_BACKGROUND
#   BASH_FOREGROUND
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
java_env_content() {
  if [[ $# -eq 2 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -d)
          shift
          java_dir="${1}"
          ;;
        *)
          usage_java_env_content \
            LOG_ERROR \
            "java_env_content" \
            "${UNKNOWN_FUNCTION_OPTION_CODE}" \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_java_env_content \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    if [[ -d "${java_dir}" ]]; then

read -r -d '' java_env_content<<EOF
export JAVA_HOME=${java_dir}
EOF

read -r -d '' path_env<<"EOF"
export PATH=${PATH}:${JAVA_HOME}/bin
EOF

  echo -e ""${java_env_content}"\n"${path_env}""

    else

      error \
        -o "java_env_content" \
        -d "invalid directory" \
        -dfg "${BASH_FOREGROUND}" \
        -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}

    fi

  else

    usage_java_env_content \
      LOG_ERROR \
      "java_env_content" \
      "${INVALID_NUMBER_PARAMETERS_CODE}" \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

  return ${NO_ERRORS_CODE}
}

usage_java_env_content() {
read -r -d '' temp_java_env_content<<"EOF"
Usage: java_env_content -<OPTIONS>\n
  OPTIONS       PARAMS                      DESCRIPTION\n
    -d          <java_installation_dir>     The Java installation dir.\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "java_env_content" \
    -d "${temp_java_env_content}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}

#######################################
# Setup Java JDK.
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
#   -d <java_installation_dir>
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
setup_java() {

  URL_DELIMITER='/'
  JAVA_DIR_INDEX=0
  FILE_EXT="*.tar.gz"
  BASH_FILE_PATH="/etc/bash.bashrc"

  if [[ $# -eq 2 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -d)
          shift
          java_installation_dir="${1}"
          ;;
        *)
          usage_setup_java \
            LOG_ERROR \
            "setup_java" \
            "${UNKNOWN_FUNCTION_OPTION_CODE}" \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_setup_java \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    if [[ -d "${java_installation_dir}" ]]; then

      cd "${java_installation_dir}"
      tarball_dir="$(find "${java_installation_dir}" -type f -name "${FILE_EXT}")"

      if [[ $? -eq 0 ]]; then

        tar_output="$(tar xvzf "${tarball_dir}")"
        last_line="${tar_output##*$'\n'}"

        java_dir_name="$(substring -s "${last_line}" -d "${URL_DELIMITER}" -i ${JAVA_DIR_INDEX})"
        java_path="${java_installation_dir}"/"${java_dir_name}"
        rm "${tarball_dir}"
        java_env_content -d "${java_path}" >> "${BASH_FILE_PATH}"
        source "${BASH_FILE_PATH}"
        update-alternatives --install "/usr/bin/java" "java" ""${java_path}"/bin/java" 0
        update-alternatives --install "/usr/bin/javac" "javac" ""${java_path}"/bin/javac" 0
        update-alternatives --set java ""${java_path}"/bin/java"
        update-alternatives --set javac ""${java_path}"/bin/javac"
        JAVA_ALTERNATIVE="$(update-alternatives --list java)"
        JAVAC_ALTERNATIVE="$(update-alternatives --list javac)"
        info \
          -o "Java Alternatives" \
          -d ""${JAVA_ALTERNATIVE}" ; "${JAVAC_ALTERNATIVE}"" \
          -dfg "${BASH_FOREGROUND}" \
          -dbg "${BASH_BACKGROUND}"

      else

        error \
          -o "setup_java" \
          -d "couldn't find the following file "${tarball_dir}"." \
          -dfg "${BASH_FOREGROUND}" \
          -dbg "${BASH_BACKGROUND}"
        return ${ERROR_CODE}

      fi

    else

      error \
        -o "setup_java" \
        -d "invalid installation directory." \
        -dfg "${BASH_FOREGROUND}" \
        -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}

    fi

  else

    usage_setup_java \
      LOG_ERROR \
      "setup_java" \
      "${INVALID_NUMBER_PARAMETERS_CODE}" \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

  info \
    -o "setup_java" \
    -d "Amazon Corretto OpenJDK installed !" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
  return ${NO_ERRORS_CODE}
}

usage_setup_java() {
read -r -d '' temp_setup_java<<"EOF"
Usage: setup_java -<OPTIONS>\n
  OPTIONS       PARAMS                      DESCRIPTION\n
    -d          <java_installation_dir>     The Java installation dir.\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "setup_java" \
    -d "${temp_setup_java}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}