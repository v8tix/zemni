dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../common.sh"

#######################################
# Prints the actual date in the given format %Y-%m-%dT%H:%M:%S%z.
# Globals:
#   None.
# Arguments:
#   None.
# Returns:
#   {date_format} String.
#######################################
date_format(){
  echo "$(date +'%Y-%m-%dT%H:%M:%S%z')"
}

#######################################
# Prints an error description.
# Globals:
#   None.
# Arguments:
#   ${1} The error code.
#   ${2} The error description.
# Returns:
#   {date, error_code, description} String.
#######################################
err() {
  echo "{\"date\":\""$(date_format)"\", \"error_code\":"${1}", \"description\":\""${2}\""}"
}

########################################################
# Verifies if the parameter $1 is a number.
# Globals:
#   NO_ERRORS_CODE
#   ERROR_CODE
# Arguments:
#   ${1}  Number.
# Returns:
#   0      If the given parameter is a number.
#   1      Otherwise.
########################################################
is_number() {
  re='^[0-9]+$'
  if [[ "${1}" =~ $re ]] ; then
   return ${NO_ERRORS_CODE}
  else
   return ${ERROR_CODE}
  fi
}

#######################################
# Checks if the code returned by a determined function is zero.
# Globals:
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS_CODE
#   INVALID_NUMBER_PARAMETERS
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -co  <code>
#   -err <error>
# Returns:
# ${error_msg} String.
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS_CODE
#   INVALID_NUMBER_PARAMETERS
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
check_returned_code(){
  if [[ $# -eq 4 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -co)
          shift
          code="${1}"
          ;;
        -err)
          shift
          error="${1}"
          ;;
        *)
          msg="${UNKNOWN_FUNCTION_OPTION}"
          error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
          usage_check_returned_code "${error_msg}"
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    is_number "${code}"

    if [[ $? -eq ${NO_ERRORS_CODE} ]]; then

      if [[ ${code} -eq ${NO_ERRORS_CODE} ]]; then

        return ${NO_ERRORS_CODE}

      else

        error_msg="$(err "${code}" "${error}")"
        echo "${error_msg}"
        return ${code}

      fi

    else

      msg="not a number."
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_check_returned_code "${error_msg}"
      return ${ERROR_CODE}

    fi

  else

    msg="${INVALID_NUMBER_PARAMETERS}"
    error_msg="$(err "${INVALID_NUMBER_PARAMETERS_CODE}" "${msg}")"
    usage_check_returned_code "${error_msg}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

}

usage_check_returned_code() {
  echo -e "\n"
  echo -e "check_returned_code "${1}"\n"
  echo -e 'Usage: check_returned_code -<OPTIONS>\n'
  echo -e '    OPTIONS     PARAMS              DESCRIPTION\n'
  echo -e '    -co         <code>              Function returned code.\n'
  echo -e '    -err        <error>             Error description.\n'
}