dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../lib/dye4b/dye4b.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# Debian Buster repos.
# Globals:
#   NO_ERRORS_CODE
# Arguments:
#   None
# Returns:
#   ${sources_content} String
#   NO_ERRORS_CODE
#######################################
generate_sources_content() {
read -r -d '' sources_content<<"EOF"
deb http://deb.debian.org/debian buster main contrib non-free
deb-src http://deb.debian.org/debian buster main contrib non-free
deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free
deb http://deb.debian.org/debian buster-updates main contrib non-free
deb-src http://deb.debian.org/debian buster-updates main contrib non-free
EOF

echo "${sources_content}"
return ${NO_ERRORS_CODE}
}

#######################################
# Setup repos.
# Globals:
#   BASH_FOREGROUND
#   BASH_BACKGROUND
#   NO_ERRORS_CODE
# Returns:
#   NO_ERRORS_CODE
#######################################
setup_repos() {
  generate_sources_content > "/etc/apt/sources.list"
  apt update
  apt -y upgrade
  info -o "setup_repos" -d "repos updated !" -dfg "${BASH_FOREGROUND}" -dbg "${BASH_BACKGROUND}"
  return ${NO_ERRORS_CODE}
}