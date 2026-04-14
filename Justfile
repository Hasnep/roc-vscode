root_dir := justfile_dir()
build_dir := root_dir / "build"
dist_dir := root_dir / "dist"
images_dir := root_dir / "images"
src_dir := root_dir / "src"
syntaxes_dir := root_dir / "syntaxes"

[parallel]
build: build-js build-logo
    mkdir -p {{ build_dir }}
    vsce package --out={{ build_dir / "roc.vsix" }}

build-js:
    esbuild \
        {{ src_dir / "extension.ts" }} \
        --bundle \
        --format=cjs \
        --minify \
        --sources-content=false \
        --platform=node \
        --outfile={{ dist_dir / "extension.js" }} \
        --external:vscode

# Convert the logo from an SVG to a PNG
build-logo:
    inkscape \
        {{ images_dir / "roc-logo.svg" }} \
        --export-filename={{ images_dir / "roc-logo.png" }} \
        --export-dpi=300

# Build the extension whenever a source file is changed
watch:
    esbuild \
        {{ src_dir / "extension.ts" }} \
        --bundle \
        --format=cjs \
        --sourcemap \
        --sources-content=false \
        --platform=node \
        --outfile={{ dist_dir / "extension.js" }} \
        --external:vscode \
        --watch

# Run all the tests
[parallel]
test: test-extension test-textmate-grammar

# Test the extension
[linux]
test-extension:
    xvfb-run -a npm run test

# Test the extension
[macos]
test-extension:
    npm run test

# Run the textmate grammar tests
test-textmate-grammar:
    npx --no-install --call 'textmate-grammar-test syntaxes/tests/**/*.roc'
    @# Skip snapshot tests for now
    @# npx --no-install --call 'textmate-grammar-test syntaxes/snapshots/**/*.roc.snap'

# Update the snapshot tests for the textmate grammar
update-snapshots:
    npx --no-install --call 'textmate-grammar-snap -u syntaxes/snapshots/*.roc'
