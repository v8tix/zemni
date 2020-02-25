dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../lib/dye4b/dye4b.sh"
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../lib/string/lib_string.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# Package a Java application.
# Globals:
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -d  <vol_dir>
#   -g  <git_ssh>
# Returns:
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
package() {
  URL_DELIMITER="/"
  URL_INDEX=1
  PATTERN=".git"

  if [[ $# -eq 4 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -d)
          shift
          vol_dir="${1}"
          ;;
        -g)
          shift
          git_ssh="${1}"
          ;;
        *)
          usage_run \
            LOG_ERROR \
            "package" \
            ${UNKNOWN_FUNCTION_OPTION_CODE} \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_run \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    repo_name="$(substring -s "${git_ssh}" -d "${URL_DELIMITER}" -i ${URL_INDEX})"
    dir_name="$(substring_patn_end -s "${repo_name}" -p "${PATTERN}")"

    if [[ ! -d "${vol_dir}" ]]; then
        error \
        -o "package" \
        -d "invalid directory: "${vol_dir}"" \
        -dfg "${BASH_FOREGROUND}" \
        -dbg "${BASH_BACKGROUND}"
        return ${ERROR_CODE}
    fi

    if [[ ! -d "${vol_dir}" ]]; then
        error \
        -o "package" \
        -d "invalid directory: "${vol_dir}"" \
        -dfg "${BASH_FOREGROUND}" \
        -dbg "${BASH_BACKGROUND}"
        return ${ERROR_CODE}
    fi

    cd "${vol_dir}" || exit ${ERROR_CODE}
    git clone "${git_ssh}"

    code=$?

    if [[ $code -ne 0 ]]; then
      error \
      -o "package" \
      -d "Git failed with code: $code" \
      -dfg "${BASH_FOREGROUND}" \
      -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}
    fi

    ls "${vol_dir}"

    git_repo_dir=""${vol_dir}"/"${dir_name}""

    if [[ ! -d "${git_repo_dir}" ]]; then
      error \
      -o "package" \
      -d "invalid directory: "${git_repo_dir}"" \
      -dfg "${BASH_FOREGROUND}" \
      -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}
    fi

    cd "${git_repo_dir}" || exit ${ERROR_CODE}
    /opt/apache-maven-3.6.2/bin/mvn clean package -Pdev -DskipTests=true

    if [[ $? -ne 0 ]]; then
      error \
      -o "package" \
      -d "maven couldn't package the app" \
      -dfg "${BASH_FOREGROUND}" \
      -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}
    fi

    target_dir=""${git_repo_dir}"/target/"

    if [[ ! -d "${target_dir}" ]]; then
      error \
      -o "package" \
      -d "directory: "${target_dir}" not found !" \
      -dfg "${BASH_FOREGROUND}" \
      -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}
    fi

    cd "${target_dir}" || exit ${ERROR_CODE}
    jar_file="$(find "${target_dir}" -name "*.jar")"
    jar_name="${jar_file##*/}"
    cp "${jar_name}" "${vol_dir}"
    rm -rf "${git_repo_dir}/"
    return ${NO_ERRORS_CODE}

  else

    usage_package \
      LOG_ERROR \
      "package" \
      ${INVALID_NUMBER_PARAMETERS_CODE} \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi
}

usage_package() {
read -r -d '' temp_package<<"EOF"
Usage: package -<OPTIONS>\n
  OPTIONS       PARAMS                      DESCRIPTION\n
    -d          <vol_dir>                   The volume mount directory.\n
    -g          <git_ssh>                   The Git repo (ssh).\n
EOF

if [[ "${1}" -eq 1 ]]; then

  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"

else

  warn \
    -o "package" \
    -d "${temp_package}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"

fi
}
