dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../colourash/colourash.sh"

#######################################
# Prints a message in the warn log format.
# Globals:
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -o    <origin>
#   -d    <description>
#   -dfg  <default_foreground>
#   -dbg  <default_background>
# Returns:
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
warn(){
  if [[ $# -eq 8 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -o)
          shift
          origin="${1}"
          ;;
        -d)
          shift
          description="${1}"
          ;;
        -dfg)
          shift
          default_fg="${1}"
          ;;
        -dbg)
          shift
          default_bg="${1}"
          ;;
        *)
          msg="${UNKNOWN_FUNCTION_OPTION}"
          error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
          usage_warn "${error_msg}"
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    legend_fg="$(fg_ce -c yellow -e bold)"
    legend_fg_error="$(check_returned_code -co "$?" -err "${legend_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${legend_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_warn "${error_msg}"
      return ${ERROR_CODE}

    fi

    date_fg="$(fg_ce -c yellow -e normal)"
    date_fg_error="$(check_returned_code -co "$?" -err "${date_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${date_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_warn "${error_msg}"
      return ${ERROR_CODE}

    fi

    origin_fg="$(fg_ce -c yellow -e normal)"
    origin_fg_error="$(check_returned_code -co "$?" -err "${origin_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${origin_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_warn "${error_msg}"
      return ${ERROR_CODE}

    fi

    description_fg="$(fg_ce -c yellow -e normal)"
    description_fg_error="$(check_returned_code -co "$?" -err "${description_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${description_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_warn "${error_msg}"
      return ${ERROR_CODE}

    fi

    log \
      -l "WARN" \
      -o "${origin}" \
      -d "${description}" \
      -dfg "${default_fg}" \
      -dbg "${default_bg}" \
      -lfg "${legend_fg}" \
      -dtfg "${date_fg}" \
      -ofg "${origin_fg}" \
      -dcfg "${description_fg}"

    return ${NO_ERRORS_CODE}

  else

    msg="${INVALID_NUMBER_PARAMETERS}"
    error_msg="$(err "${INVALID_NUMBER_PARAMETERS_CODE}" "${msg}")"
    usage_warn "${error_msg}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

}

usage_warn() {
  echo -e "\n"
  echo -e "warn: "${1}"\n"
  echo -e 'Usage: warn -<OPTIONS>\n'
  echo -e '    OPTIONS     PARAMS                                     DESCRIPTION\n'
  echo -e '    -o          <origin>                          The function that returned the error.\n'
  echo -e '    -d          <description>                     The error description.\n'
  echo -e '    -dfg        <default_foreground>              The foreground established.\n'
  echo -e '    -dbg        <default_background>              The background established.\n'
}

#######################################
# Prints a message in the error log format.
# Globals:
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -o    <origin>
#   -d    <description>
#   -dfg  <default_foreground>
#   -dbg  <default_background>
# Returns:
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
error(){
  if [[ $# -eq 8 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -o)
          shift
          origin="${1}"
          ;;
        -d)
          shift
          description="${1}"
          ;;
        -dfg)
          shift
          default_fg="${1}"
          ;;
        -dbg)
          shift
          default_bg="${1}"
          ;;
        *)
          msg="${UNKNOWN_FUNCTION_OPTION}"
          error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
          usage_error "${error_msg}"
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    legend_fg="$(fg_ce -c red -e bold)"
    legend_fg_error="$(check_returned_code -co "$?" -err "${legend_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${legend_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_error "${error_msg}"
      return ${ERROR_CODE}

    fi

    date_fg="$(fg_ce -c red -e normal)"
    date_fg_error="$(check_returned_code -co "$?" -err "${date_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${date_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_error "${error_msg}"
      return ${ERROR_CODE}

    fi

    origin_fg="$(fg_ce -c red -e normal)"
    origin_fg_error="$(check_returned_code -co "$?" -err "${origin_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${origin_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_error "${error_msg}"
      return ${ERROR_CODE}

    fi

    description_fg="$(fg_ce -c red -e normal)"
    description_fg_error="$(check_returned_code -co "$?" -err "${description_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${description_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_error "${error_msg}"
      return ${ERROR_CODE}

    fi

    log \
      -l "ERROR" \
      -o "${origin}" \
      -d "${description}" \
      -dfg "${default_fg}" \
      -dbg "${default_bg}" \
      -lfg "${legend_fg}" \
      -dtfg "${date_fg}" \
      -ofg "${origin_fg}" \
      -dcfg "${description_fg}"

    return ${NO_ERRORS_CODE}

  else

    msg="${INVALID_NUMBER_PARAMETERS}"
    error_msg="$(err "${INVALID_NUMBER_PARAMETERS_CODE}" "${msg}")"
    usage_error "${error_msg}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

}

usage_error() {
  echo -e "\n"
  echo -e "error: "${1}"\n"
  echo -e 'Usage: error -<OPTIONS>\n'
  echo -e '    OPTIONS     PARAMS                                     DESCRIPTION\n'
  echo -e '    -o          <origin>                          The function that returned the error.\n'
  echo -e '    -d          <description>                     The error description.\n'
  echo -e '    -dfg        <default_foreground>              The foreground established.\n'
  echo -e '    -dbg        <default_background>              The background established.\n'
}

#######################################
# Prints a message in the info log format.
# Globals:
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -o    <origin>
#   -d    <description>
#   -dfg  <default_foreground>
#   -dbg  <default_background>
# Returns:
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
info(){
  if [[ $# -eq 8 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -o)
          shift
          origin="${1}"
          ;;
        -d)
          shift
          description="${1}"
          ;;
        -dfg)
          shift
          default_fg="${1}"
          ;;
        -dbg)
          shift
          default_bg="${1}"
          ;;
        *)
          msg="${UNKNOWN_FUNCTION_OPTION}"
          error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
          usage_info "${error_msg}"
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    legend_fg="$(fg_ce -c green -e bold)"
    legend_fg_error="$(check_returned_code -co "$?" -err "${legend_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${legend_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_info "${error_msg}"
      return ${ERROR_CODE}

    fi

    date_fg="$(fg_ce -c green -e normal)"
    date_fg_error="$(check_returned_code -co "$?" -err "${date_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${date_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_info "${error_msg}"
      return ${ERROR_CODE}

    fi

    origin_fg="$(fg_ce -c green -e normal)"
    origin_fg_error="$(check_returned_code -co "$?" -err "${origin_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${origin_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_info "${error_msg}"
      return ${ERROR_CODE}

    fi

    description_fg="$(fg_ce -c green -e normal)"
    description_fg_error="$(check_returned_code -co "$?" -err "${description_fg}")"

    if [[ $? -ne ${NO_ERRORS_CODE} ]]; then

      msg="${description_fg_error}"
      error_msg="$(err "${ERROR_CODE}" "${msg}")"
      usage_info "${error_msg}"
      return ${ERROR_CODE}

    fi

    log \
      -l "INFO" \
      -o "${origin}" \
      -d "${description}" \
      -dfg "${default_fg}" \
      -dbg "${default_bg}" \
      -lfg "${legend_fg}" \
      -dtfg "${date_fg}" \
      -ofg "${origin_fg}" \
      -dcfg "${description_fg}"

    return ${NO_ERRORS_CODE}

  else

    msg="${INVALID_NUMBER_PARAMETERS}"
    error_msg="$(err "${INVALID_NUMBER_PARAMETERS_CODE}" "${msg}")"
    usage_info "${error_msg}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

}

usage_info() {
  echo -e "\n"
  echo -e "info: "${1}"\n"
  echo -e 'Usage: info -<OPTIONS>\n'
  echo -e '    OPTIONS     PARAMS                                     DESCRIPTION\n'
  echo -e '    -o          <origin>                          The function that returned the error.\n'
  echo -e '    -d          <description>                     The error description.\n'
  echo -e '    -dfg        <default_foreground>              The foreground established.\n'
  echo -e '    -dbg        <default_background>              The background established.\n'
}

#######################################
# Prints a message in a custom log format.
# Globals:
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
# Arguments:
#   -l    <legend>
#   -o    <origin>
#   -d    <description>
#   -dfg  <default_foreground>
#   -dbg  <default_background>
#   -lfg  <legend_foreground>
#   -dtfg <date_foreground>
#   -ofg  <origin_foreground>
#   -dcfg <description_foreground>
# Returns:
#   ERROR_CODE
#   INVALID_NUMBER_PARAMETERS
#   INVALID_NUMBER_PARAMETERS_CODE
#   NO_ERRORS_CODE
#   UNKNOWN_FUNCTION_OPTION
#   UNKNOWN_FUNCTION_OPTION_CODE
#######################################
log(){
  if [[ $# -eq 18 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -l)
          shift
          legend="${1}"
          ;;
        -o)
          shift
          origin="${1}"
          ;;
        -d)
          shift
          description="${1}"
          ;;
        -dfg)
          shift
          default_fg="${1}"
          ;;
        -dbg)
          shift
          default_bg="${1}"
          ;;
        -lfg)
          shift
          legend_fg="${1}"
          ;;
        -dtfg)
          shift
          date_fg="${1}"
          ;;
        -ofg)
          shift
          origin_fg="${1}"
          ;;
        -dcfg)
          shift
          description_fg="${1}"
          ;;
        *)
          msg="${UNKNOWN_FUNCTION_OPTION}"
          error_msg="$(err "${UNKNOWN_FUNCTION_OPTION_CODE}" "${msg}")"
          usage_log "${error_msg}"
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    set_default=""${default_bg}""${default_fg}""
    echo -ne ""${set_default}"\n"
    echo -ne ""${set_default}"["${legend_fg}""${legend}""$(esc_ctrl)""${set_default}"]"
    echo -ne "["${date_fg}""$(date_format)""$(esc_ctrl)""${set_default}"]"
    echo -ne "["${origin_fg}""${origin}""$(esc_ctrl)""${set_default}"]:"
    echo -ne  ""${description_fg}""${description}""$(esc_ctrl)""${set_default}"\n\n"

    clear_colour_config
    return ${NO_ERRORS_CODE}

  else

    msg="${INVALID_NUMBER_PARAMETERS}"
    error_msg="$(err "${INVALID_NUMBER_PARAMETERS_CODE}" "${msg}")"
    usage_log "${error_msg}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi

}

usage_log() {
  echo -e "\n"
  echo -e "log: "${1}"\n"
  echo -e 'Usage: log -<OPTIONS>\n'
  echo -e '    OPTIONS     PARAMS                                     DESCRIPTION\n'
  echo -e '    -l          <legend>                          The log legend.\n'
  echo -e '    -o          <origin>                          The function that returned the error.\n'
  echo -e '    -d          <description>                     The error description.\n'
  echo -e '    -dfg        <default_foreground>              The foreground established.\n'
  echo -e '    -dbg        <default_background>              The background established.\n'
  echo -e '    -lfg        <legend_foreground>               The legend foreground.\n'
  echo -e '    -dtfg       <date_foreground>                 The date foreground.\n'
  echo -e '    -ofg        <origin_foreground>               The origin foreground.\n'
  echo -e '    -dcfg       <description_foreground>          The description foreground.\n'
}