#!/usr/bin/env bash

package_json_version=$(jq -r .version package.json)
flake_version=$(nix eval --json .#roc-vscode.version | jq -r .)

if [ "$package_json_version" != "$flake_version" ]; then
  echo "Version mismatch, package.json has $package_json_version flake.nix has $flake_version" >&2
  exit 1
fi
