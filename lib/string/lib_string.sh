dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../dye4b/dye4b.sh"
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../pbb/string/lib_string.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# Splits a string given a delimiter, and return a substring represented by the given index.
# Globals:
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -s <string>
#   -d <delimitier>
#   -i <index>
# Returns:
#   ${substr}   The substring at the given index.
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
substring() {

if [[ $# -eq 6 ]]; then
  while (( "$#" )); do
    case "${1}" in
      -s)
        shift
        string="${1}"
        ;;
      -d)
        shift
        delimiter="${1}"
        ;;
      -i)
        shift
        index="${1}"
        ;;
      *)
        msg="${UNKNOWN_FUNCTION_OPTION}"
        error_msg="$(err ${UNKNOWN_FUNCTION_OPTION_CODE} "${msg}")"
        usage_substring "${error_msg}"
        return ${UNKNOWN_FUNCTION_OPTION_CODE}
        ;;
    esac

    shift

  done

  substr="$(split "${string}" "${delimiter}" ${index})"
  echo "${substr}"

else

    msg="${INVALID_NUMBER_PARAMETERS}"
    error_msg="$(err ${INVALID_NUMBER_PARAMETERS_CODE} "${msg}")"
    usage_substring "${error_msg}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

fi
}

usage_substring() {
  echo -e "\n"
  echo -e "substring: "${1}"\n"
  echo -e 'Usage: substring -<OPTIONS>\n'
  echo -e '    OPTIONS       PARAMS                           DESCRIPTION\n'
  echo -e '    -s            <string>                         String to split.\n'
  echo -e '    -d            <delimiter>                      Delimiter.\n'
  echo -e '    -i            <index>                          String index to extract.\n'
}

#######################################
# Extract a given pattern from a string.
# Globals:
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -s <string>
#   -p <pattern>
# Returns:
#   ${substr}   The extracted substring.
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
substring_patn_end() {

if [[ $# -eq 4 ]]; then
  while (( "$#" )); do
    case "${1}" in
      -s)
        shift
        string="${1}"
        ;;
      -p)
        shift
        pattern="${1}"
        ;;
      *)
        msg="${UNKNOWN_FUNCTION_OPTION}"
        error_msg="$(err ${UNKNOWN_FUNCTION_OPTION_CODE} "${msg}")"
        usage_substring_patn_end "${error_msg}"
        return ${UNKNOWN_FUNCTION_OPTION_CODE}
        ;;
    esac

    shift

  done

  substr="$(rstrip "${string}" "${pattern}")"
  echo "${substr}"

else

  msg="${INVALID_NUMBER_PARAMETERS}"
  error_msg="$(err ${INVALID_NUMBER_PARAMETERS_CODE} "${msg}")"
  usage_substring_patn_end "${error_msg}"
  return ${INVALID_NUMBER_PARAMETERS_CODE}

fi
}

usage_substring_patn_end() {
  echo -e "\n"
  echo -e "substring_patn_end: "${1}"\n"
  echo -e 'Usage: substring_patn_end -<OPTIONS>\n'
  echo -e '    OPTIONS       PARAMS                           DESCRIPTION\n'
  echo -e '    -s            <string>                         String to split.\n'
  echo -e '    -p            <pattern>                        Pattern to extract.\n'
}




