dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../common.sh"
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/lib_colourash.sh"

#######################################
# Returns a string which contains an ANSI Colour Control Code.
# Globals:
#   BACKGROUND_CTRL_CODE
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -c <colour>
# Possible values for option -c: [black, red, green, yellow, blue, magenta, cyan, white].
# Possible values for option -e: [normal, bold, faint, italic, single, slow, fast, reverse, invisible].
# Returns:
#   ${c_ctrl} String that contains an ANSI Colour Control Code.
#   BACKGROUND_CTRL_CODE
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
bgc(){
  if [[ $# -eq 2 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -c)
          shift
          colour="${1}"
          ;;
        *)
          msg="${UNKNOWN_FUNCTION_OPTION}"
          error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
          usage_bgc "${error_msg}"
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    c_ctrl="$(colour_ctrl -c "${colour}")"
    c_ctrl_error="$(check_returned_code -co $? -err "${c_ctrl}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${c_ctrl_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_bgc "${error_msg}"
      return ${ERROR_CODE}

    fi

    echo "${c_ctrl}" | sed "s/\?/"${BACKGROUND_CTRL_CODE}"/g"
    return ${NO_ERRORS_CODE}

  else

    msg="${INVALID_NUMBER_PARAMETERS}"
    error_msg="$(err "${INVALID_NUMBER_PARAMETERS_CODE}" "${msg}")"
    usage_bgc "${error_msg}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi
}

usage_bgc() {
  echo -e "\n"
  echo -e "bgc: "${1}"\n"
  echo -e 'Usage: bgc -<OPTIONS>\n'
  echo -e '    OPTIONS     PARAMS                  DESCRIPTION\n'
  echo -e '    -c          <colour>     [black, red, green, yellow, blue, magenta, cyan, white]\n'
}

#######################################
# Returns a string which contains an ANSI Colour Control Code and an ANSI SGR Effect Control Code.
# Globals:
#   ERROR_CODE
#   FOREGROUND_CTRL_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -c <colour>
#   -e <effect>
# Possible values for option -c: [black, red, green, yellow, blue, magenta, cyan, white].
# Possible values for option -e: [normal, bold, faint, italic, single, slow, fast, reverse, invisible].
# Returns:
#   ${c_ctrl} String that contains an ANSI Colour Control Code and an ANSI SGR Effect Control Code.
#   ERROR_CODE
#   FOREGROUND_CTRL_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
fg_ce(){
  if [[ $# -eq 4 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -c)
          shift
          colour="${1}"
          ;;
        -e)
          shift
          effect="${1}"
          ;;
        *)
          msg="${UNKNOWN_FUNCTION_OPTION}"
          error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
          usage_fg_ce "${error_msg}"
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    e_ctrl="$(effect_ctrl -e "${effect}")"
    e_ctrl_error="$(check_returned_code -co $? -err "${e_ctrl}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${e_ctrl_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_fg_ce "${error_msg}"
      return ${ERROR_CODE}

    fi

    c_ctrl="$(colour_ctrl -c "${colour}")"
    c_ctrl_error="$(check_returned_code -co $? -err "${c_ctrl}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${c_ctrl_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_fg_ce "${error_msg}"
      return ${ERROR_CODE}

    fi

    if [[ ${e_ctrl} -eq ${NO_ERRORS_CODE} ]]; then

      echo "${c_ctrl}" | sed "s/\?/"${FOREGROUND_CTRL_CODE}"/g" | sed "s/\;/""/g"

    else

      echo "${c_ctrl}" | sed "s/\?/"${FOREGROUND_CTRL_CODE}"/g" | sed "s/\m/;"${e_ctrl}"m/g"

    fi

    return ${NO_ERRORS_CODE}

  else

    msg="${INVALID_NUMBER_PARAMETERS}"
    error_msg="$(err "${INVALID_NUMBER_PARAMETERS_CODE}" "${msg}")"
    usage_fg_ce "${error_msg}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi
}

usage_fg_ce() {
  echo -e "\n"
  echo -e "fg_ce: "${1}"\n"
  echo -e 'Usage: fg_ce -<OPTIONS>\n'
  echo -e '    OPTIONS     PARAMS                  DESCRIPTION\n'
  echo -e '    -c          <colour>    [black, red, green, yellow, blue, magenta, cyan, white]\n'
  echo -e '    -e          <effect>   [normal, bold, faint, italic, single, slow, fast, reverse, invisible]\n'
}

#######################################
# Returns a string with an ANSI Colour Control Code.
# Globals:
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -c <colour>
# Possible values for option -c: [black, red, green, yellow, blue, magenta, cyan, white].
# Returns:
#   String An ANSI Colour Control Code.
#   NOTE: the control code includes a ? char that must be replaced by 3 or 4 (for foreground and background respectively)
#   0      No errors.
#   1      Function error.
#   2      Invalid number of parameters.
#   3      Unknown function option.
#######################################
colour_ctrl(){
  if [[ $# -eq 2 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -c)
          shift
          colour="${1}"
          ;;
        *)
          msg="${UNKNOWN_FUNCTION_OPTION}"
          error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
          usage_colour_ctrl "${error_msg}"
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    case "${colour}" in
      black)
        echo "\e[?0m"
        ;;
      red)
        echo "\e[?1m"
        ;;
      green)
        echo "\e[?2m"
        ;;
      yellow)
        echo "\e[?3m"
        ;;
      blue)
        echo "\e[?4m"
        ;;
      magenta)
        echo "\e[?5m"
        ;;
      cyan)
        echo "\e[?6m"
        ;;
      white)
        echo "\e[?7m"
        ;;
      *)
        msg="unknown colour."
        error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
        usage_colour_ctrl "${error_msg}"
        return ${UNKNOWN_FUNCTION_OPTION_CODE}
        ;;
      esac

      return ${NO_ERRORS_CODE}

  else

    msg="${INVALID_NUMBER_PARAMETERS}"
    error_msg="$(err "${INVALID_NUMBER_PARAMETERS_CODE}" "${msg}")"
    usage_colour_ctrl "${error_msg}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi
}

usage_colour_ctrl() {
  echo -e "\n"
  echo -e "colour_ctrl: "${1}"\n"
  echo -e 'Usage: colour_ctrl -<OPTIONS>\n'
  echo -e '    OPTIONS     PARAMS                  DESCRIPTION\n'
  echo -e '    -c          <colour>   [black, red, green, yellow, blue, magenta, cyan, white]\n'
}

#######################################
# Returns a string with an ANSI SGR Effect Control Code.
# Globals:
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -e <effect>
# Possible values for option -e: [normal, bold, faint, italic, single, slow, fast, reverse, invisible].
# Returns:
#   string An ANSI SGR Effect Control Code.
#   0      No errors.
#   1      Function error.
#   2      Invalid number of parameters.
#   3      Unknown function option.
#######################################
effect_ctrl(){
  if [[ $# -eq 2 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -e)
          shift
          effect="${1}"
          ;;
        *)
          msg="${UNKNOWN_FUNCTION_OPTION}"
          error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
          usage_effect_ctrl "${error_msg}"
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    case "${effect}" in
      normal)
        echo "0"
        ;;
      bold)
        echo "1"
        ;;
      faint)
        echo "2"
        ;;
      italic)
        echo "3"
        ;;
      single)
        echo "4"
        ;;
      slow)
        echo "5"
        ;;
      fast)
        echo "6"
        ;;
      reverse)
        echo "7"
        ;;
      invisible)
        echo "8"
        ;;
      *)
        msg="unknown effect."
        error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
        usage_effect_ctrl "${error_msg}"
        return ${UNKNOWN_FUNCTION_OPTION_CODE}
        ;;
      esac

      return ${NO_ERRORS_CODE}

  else

    msg="${INVALID_NUMBER_PARAMETERS}"
    error_msg="$(err "${INVALID_NUMBER_PARAMETERS_CODE}" "${msg}")"
    usage_effect_ctrl "${error_msg}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi
}

usage_effect_ctrl() {
  echo -e "\n"
  echo -e "effect_ctrl: "${1}"\n"
  echo -e 'Usage: effect_ctrl -<OPTIONS>\n'
  echo -e '    OPTIONS     PARAMS                             DESCRIPTION\n'
  echo -e '    -e          <effect>   [normal, bold, faint, italic, single, slow, fast, reverse, invisible]\n'
}

#######################################
# Returns a string with the ANSI escape control code.
# Globals:
#   NO_ERRORS_CODE
# Arguments:
#   None.
# Returns:
#   String the ANSI escape control code.
#   NO_ERRORS_CODE
#######################################
esc_ctrl(){
  echo "\e[0m"
  return ${NO_ERRORS_CODE}
}

#######################################
# Clear all previous colour configurations (background and foreground)
# Globals:
#   NO_ERRORS_CODE
# Arguments:
#   None.
# Returns:
#   ${esc} String with the ANSI clear control code.
#   NO_ERRORS_CODE
#######################################
clear_colour_config(){
  esc="$(esc_ctrl)"
  echo -e "${esc}"
  return ${NO_ERRORS_CODE}
}