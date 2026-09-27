#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 0 ]]; then
    echo "usage: $0 <version>" >&2
    exit 1
fi

VERSION="$1"

if ! command -v jj >&2; then
 echo "Jujutsu (jj) is not installed." >&2
exit 2
 fi

jj new --message="Release v$VERSION" main
sd '"version": "\d+.\d+.\d+",' "\"version\": \"$VERSION\"," package.json
sd 'version = "\d+.\d+.\d+";' "version = \"$VERSION\";" flake.nix
jj bookmark create "release-v$VERSION"
