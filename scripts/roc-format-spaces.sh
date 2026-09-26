#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 0 ]]; then
    echo "usage: $0 <file>..." >&2
    echo "Formats Roc files for textmate grammar tests."
    echo "Uses 'roc fmt', but replaces tab characters with spaces."
    echo 'Lines ending with the comment "# \" will not have a blank line following them.'
    exit 1
fi

roc fmt "$@"
sd '\t' '    ' "$@"
# shellcheck disable=SC2016
sd --across '\n\n#(\s*)\^' '\n#$1^' "$@"
sd --across '# \\\n\n' '# \\\n' "$@"
