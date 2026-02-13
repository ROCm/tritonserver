#!/bin/bash
# AMD ROCm entrypoint: runs entrypoint.d scripts then exec's the command.

# Gather parts in alpha order
shopt -s nullglob extglob
SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
declare -a PARTS=( "${SCRIPT_DIR}/entrypoint.d"/*@(.txt|.sh) )
shopt -u nullglob extglob

# Execute the entrypoint parts
for file in "${PARTS[@]}"; do
  case "${file}" in
    *.txt) cat "${file}";;
    *.sh)  source "${file}";;
  esac
done

echo

# This script can either be a wrapper around arbitrary command lines,
# or it will simply exec bash if no arguments were given
if [[ $# -eq 0 ]]; then
  exec "/bin/bash"
else
  exec "$@"
fi
