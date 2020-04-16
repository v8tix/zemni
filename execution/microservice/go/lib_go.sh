dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../../../lib/dye4b/dye4b.sh"

BASH_BACKGROUND="$(bgc -c black)"
BASH_FOREGROUND="$(fg_ce -c white -e normal)"

#######################################
# Install gRPC Health Probe.
# Globals:
#   BASH_FOREGROUND
#   BASH_BACKGROUND
#   NO_ERRORS_CODE
# Returns:
#   NO_ERRORS_CODE
#######################################
install_gRPC_health_probe() {
  GRPC_HEALTH_PROBE_VERSION=v0.3.2
  wget -qO /bin/grpc_health_probe \
    https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64
  chmod +x /bin/grpc_health_probe
  if [[ $? -eq 0 ]]; then
    info \
      -o "install_gRPC_health_probe" \
      -d "gRPC Health Probe installed !" \
      -dfg "${BASH_FOREGROUND}" \
      -dbg "${BASH_BACKGROUND}"
      return ${NO_ERRORS_CODE}
  else
    error \
      -o "install_gRPC_health_probe" \
      -d "gRPC Health Probe couldn't being installed !" \
      -dfg "${BASH_FOREGROUND}" \
      -dbg "${BASH_BACKGROUND}"
      return ${ERROR_CODE}
  fi
}