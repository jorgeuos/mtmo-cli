#!/bin/bash
# MIT License
# Copyright (c) 2022 Jorge Powers

set -e

SCRIPT=$(readlink "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
# $(cd "$(dirname "${0}")" && pwd)
export SCRIPTPATH

ZSHRC=$HOME/.zshrc


# Get all shell options
if [[ -z $ZSHRC ]]; then
  # shellcheck source=/dev/null
  . "$HOME/.zshrc"
fi

cli_help() {
  cli_name=${0##*/}
  echo "
$cli_name
MTMO CLI
Version: $(cat "$SCRIPTPATH"/VERSION)
https://github.com/jorgeuos/mtmo-cli
Usage: $cli_name [command]
Commands:
  vue    Build vue files
  *         Help
"
  exit 1
}

case "$1" in
  vue|v)
    "$SCRIPTPATH/commands/vue" "$@" | tee -ia "$SCRIPTPATH/logs/vue_${2}.log"
    ;;
  help)
    cli_help
    ;;
  *)
    ./console "$@"
    ;;
esac