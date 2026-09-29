# Testing

`just test-fast` runs everything that does not need a built extension;
`just test` also builds the VSIX and tests it end to end.

## Test what you fly

The extension is tested as users receive it. `just build` produces one VSIX, and
`just test-vsix` installs that exact file into a throwaway VS Code profile and
drives it, through VS Code's public API, against a real Roc language server.
Nothing in that run loads the extension from the source tree.

```sh
just test-fast                       # type-check, tooling unit tests, grammar tests
just build                           # build/roc-vscode-<version>.vsix
just check-vsix                      # inspect the VSIX without launching VS Code
just test-vsix                       # integration battery against the VSIX
just test-vsix-matrix                # ...on the minimum supported and stable VS Code
just test                            # all of the above, in that order
```

`test-vsix` takes an optional VSIX path and these options:

| Option | Meaning |
|---|---|
| `--roc PATH` | Roc executable. Defaults to `$ROC_PATH`, then `roc` on `PATH`. |
| `--roc pinned` | Download, verify and use the nightly pinned in `test/roc-nightly.json`. CI uses this. |
| `--vscode-version V` | `stable` (default), `insiders`, an exact version, or `minimum` for the oldest version allowed by the VSIX's `engines.vscode`. |
| `--grep PATTERN` | Only run matching tests. |
| `--keep` | Keep the sandbox (profile, installed extension, workspace) for inspection. |

How a run is put together:

1. **Artifact checks** (`scripts/vsix-lib.mjs`) read the VSIX as a zip: the
   declared entry point, grammar, language configuration and icons must be
   present; sources, tests and tooling must not be; the version must agree with
   the file name and `package.json`. The SHA-256 is printed and repeated on
   success, so a release can be tied to the run that tested it.
2. **The Roc server** is resolved once and must answer `experimental-lsp --help`.
3. **A sandbox** is created with its own user-data and extensions directories
   and a copy of `test/fixtures/workspace`. `roc.path` is set in its user
   settings. The VSIX is installed with VS Code's own CLI, and the run stops
   unless it is then the only extension installed.
4. **The test driver** in `test/driver` is the only thing loaded from source. It
   is a separate, empty extension that hosts Mocha suites; the product is never
   given to VS Code as a development extension, because that would hide
   packaging mistakes.
5. After VS Code exits, the harness checks that the language server it left
   running has exited too.

The suites, in `test/driver/suites`:

- `01-activation`: the installed copy is the VSIX under test, it stays inactive
  until a `.roc` file opens, starts exactly one server from `roc.path`, and
  applies the packaged language configuration.
- `02-lsp`: diagnostics, hover, definition, references, highlights, symbols,
  completion (including the `.` trigger), rename, folding and selection ranges,
  inlay hints, code actions, semantic tokens and formatting. These assert the
  bridge, not the compiler: a result arrives, is a VS Code object, points inside
  the document, and edits apply.
- `03-editing`: unsaved edits, broken then repaired syntax, non-ASCII and CRLF
  positions, close and reopen, two documents, rapid edits with overlapping
  requests.
- `09-lifecycle`: restart really replaces the process, repeated restarts do not
  leak, a missing or non-LSP executable fails with a message naming the path and
  the `roc.path` setting and then recovers, and a changed `roc.path` is used.

When the extension cannot start a server at all, the first suite to need one
reports why and the rest fail immediately instead of timing out one by one.

CI builds the VSIX once: `build.yaml` tests that file on both ends of
the VS Code range, re-checks its digest, and uploads the same bytes to the
release.

### Running the Nix parts without Nix installed

The flake build, real Biome and the pre-commit hooks only exist inside Nix. A
container is enough to run them against the working tree:

```sh
docker run --rm -v roc-vscode-nix:/nix -v "$PWD":/work -w /work \
  -e NIX_CONFIG="experimental-features = nix-command flakes" nixos/nix \
  sh -c 'git config --global --add safe.directory /work &&
         nix develop --command pre-commit run --all-files;
         chown -R '"$(id -u):$(id -g)"' /work'
```

Replace the inner command with `nix build --print-out-paths .#roc-vscode-vsix`
to produce the VSIX exactly as CI does, then test it with `just test-vsix`.
After changing `package-lock.json`, refresh the flake's `npmDeps` hash with
`nix run nixpkgs#prefetch-npm-deps -- package-lock.json`. Note that the `biome`
package on npm is an unrelated project; the formatter comes from Nix.

