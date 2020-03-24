dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../lib/dye4b/dye4b.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# Setup OpenSSH.
# Globals:
#   unknown_function_option
#   invalid_number_parameters
#   invalid_number_parameters_code
#   unknown_function_option_code
#   no_errors_code
#   error_code
# Arguments:
#   -pt   <ssh_port>
#   -root <root_access>
#   -rst  <restart_ssh_service>
# Possible values for option -root: [0 allowed, 1 not allowed].
# Possible values for option -rst:  [0 restart, 1 don't restart].
# Returns:
#   0      No errors.
#   1      Function error.
#   2      Invalid number of parameters.
#   3      Unknown function option.
#######################################
setup_openssh() {

  cp /etc/ssh/sshd_config /etc/ssh/sshd_config_copy
  root_access_const=0
  rst_service=0

  if [[ $# -eq 6 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -pt)
          shift
          ssh_port="${1}"
          ;;
        -root)
          shift
          root_access="${1}"
          ;;
        -rst)
          shift
          restart_service="${1}"
          ;;
        *)
          usage_setup_openssh \
            LOG_ERROR \
            "setup_openssh" \
            "${UNKNOWN_FUNCTION_OPTION_CODE}" \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_setup_openssh \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    if [[ -z "${ssh_port}" ]]; then

      sed -i "s/#Port 22/Port 22/" /etc/ssh/sshd_config

    else

      sed -i "s/#Port 22/Port "${ssh_port}"/" /etc/ssh/sshd_config

    fi

    if [[ ${root_access} -eq ${root_access_const} ]]; then

      sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

    fi

    if [[ ${restart_service} -eq ${rst_service} ]]; then

      service ssh restart

    fi


    info \
      -o "setup_openssh" \
      -d "OpenSSH configuration applied !" \
      -dfg "${BASH_FOREGROUND}" \
      -dbg "${BASH_BACKGROUND}"
    return ${NO_ERRORS_CODE}

  else

    usage_setup_openssh \
      LOG_ERROR \
      "setup_openssh"
      "${INVALID_NUMBER_PARAMETERS_CODE}" \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi
}

usage_setup_openssh() {
read -r -d '' temp_setup_openssh<<"EOF"
Usage: setup_openssh -<OPTIONS>\n
  OPTIONS       PARAMS                  DESCRIPTION\n
    -pt         <ssh_port>              The SSH port.\n
    -root       <root_access>           Allows root access via SSH [0 allowed, 1 not allowed].\n
    -rst        <restart_ssh_service>   Restart the ssh service [0 restart, 1 don't restart].\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "setup_openssh" \
    -d "${temp_setup_openssh}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}

#######################################
# Setup a Public Key.
# Globals:
#   unknown_function_option
#   invalid_number_parameters
#   invalid_number_parameters_code
#   unknown_function_option_code
#   no_errors_code
#   error_code
# Arguments:
#    -user       <linux_user>
#    -root       <root_access>
#    -f          <file_name>
#    -m          <user_email>
#    -ph         <ssh_passphrase>
#    -pt         <ssh_port>
# Possible values for option -root: [0 allowed, 1 not allowed].
# Returns:
#   0      No errors.
#   1      Function error.
#   2      Invalid number of parameters.
#   3      Unknown function option.
#######################################
setup_pk() {
  rst_service=0

  if [[ $# -eq 12 ]]; then
    while (( "$#" )); do
      case "${1}" in
        -user)
          shift
          user="${1}"
          ;;
        -ph)
          shift
          ssh_passphrase="${1}"
          ;;
        -pt)
          shift
          ssh_port="${1}"
          ;;
        -f)
          shift
          file_name="${1}"
          ;;
        -m)
          shift
          user_email="${1}"
          ;;
        -root)
          shift
          root_access="${1}"
          ;;
        *)
          usage_setup_pk \
            LOG_ERROR \
            "setup_pk"
            "${UNKNOWN_FUNCTION_OPTION_CODE}" \
            "${UNKNOWN_FUNCTION_OPTION}"
          usage_setup_pk \
            LOG_WARNING
          return ${UNKNOWN_FUNCTION_OPTION_CODE}
          ;;
      esac

      shift

    done

    if [[ -z "${ssh_passphrase}" ]]; then

      ssh-keygen -t rsa -b 4096 -C "${user_email}" -N "" -f "${file_name}"
      eval "$(ssh-agent -s)"
      ssh-add "${file_name}"
      ssh-add -l
      setup_openssh \
        -pt "${ssh_port}" \
        -root "${root_access}" \
        -rst "${rst_service}"

    else

      ssh-keygen -t rsa -b 4096 -C "${user_email}" -N "${ssh_passphrase}" -f "${file_name}"
      eval "$(ssh-agent -s)"
      echo "echo ${ssh_passphrase}" > pass.sh
      chmod 700 ./pass.sh
      cat "${file_name}" | SSH_ASKPASS=./pass.sh ssh-add -
      ssh-add -l
      setup_openssh \
        -pt "${ssh_port}" \
        -root "${root_access}" \
        -rst "${rst_service}"

    fi

    ssh_dir=/home/"${user}"/.ssh
    
    if [[ -d "${ssh_dir}" ]]; then

      chmod 666 "${file_name}"
      chmod 644 "${file_name}".pub
      mv "${file_name}" "${ssh_dir}"
      mv "${file_name}.pub" "${ssh_dir}"

    else

      chmod 666 "${file_name}"
      chmod 644 "${file_name}".pub
      mkdir "${ssh_dir}"
      mv "${file_name}" "${ssh_dir}"
      mv "${file_name}.pub" "${ssh_dir}"

    fi

    chmod 700 ssh_dir=/home/"${user}"/.ssh

    info \
      -o "setup_pk" \
      -d "OpenSSH installation successful !" \
      -dfg "${BASH_FOREGROUND}" \
      -dbg "${BASH_BACKGROUND}"
    return ${NO_ERRORS_CODE}

  else

    usage_setup_pk \
      LOG_ERROR \
      "setup_pk"
      "${INVALID_NUMBER_PARAMETERS_CODE}" \
      "${INVALID_NUMBER_PARAMETERS}"
    return ${INVALID_NUMBER_PARAMETERS_CODE}

  fi
}

usage_setup_pk() {
read -r -d '' temp_setup_pk<<"EOF"
Usage: setup_pk -<OPTIONS>\n
  OPTIONS       PARAMS                  DESCRIPTION\n
    -user       <linux_user>            The system linux user.\n
    -root       <root_access>           Allows access via SSH [0 allowed, 1 not allowed].\n
    -f          <file_name>             The file name for the new key.\n
    -m          <user_email>            The user email.\n
    -ph         <ssh_passphrase>        The secure passphrase.\n
    -pt         <ssh_port>              The new ssh port.\n
EOF

if [[ "${1}" -eq 1 ]]; then
  error \
    -o "${2}" \
    -d "$(err "${3}" "${4}")" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
else
  warn \
    -o "setup_pk" \
    -d "${temp_setup_pk}" \
    -dfg "${BASH_FOREGROUND}" \
    -dbg "${BASH_BACKGROUND}"
fi
}


