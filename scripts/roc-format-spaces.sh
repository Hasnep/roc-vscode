#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 0 ]]; then
    echo "usage: $0 <file>..." >&2
    exit 1
fi

roc fmt "$@"
sd '\t' '    ' "$@"
# shellcheck disable=SC2016
sd --across '\n\n#(\s*)\^' '\n#$1^' "$@"
