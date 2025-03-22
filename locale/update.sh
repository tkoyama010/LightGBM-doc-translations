#!/bin/sh
# update transifex pot and local po files

set -ex

# SPHINXINTL_TRANSIFEX_ORGANIZATION_NAME=tkoyama010
# SPHINXINTL_TRANSIFEX_PROJECT_NAME=LightGBM-docs
# TX_TOKEN=...

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

SPHINX_SOURCE_DIR="$SCRIPT_DIR/../LightGBM/docs"

POT_DIR="$SCRIPT_DIR/pot"

echo "Using Sphinx source directory: $SPHINX_SOURCE_DIR"
ls -l "$SPHINX_SOURCE_DIR"

sphinx-build -T -D plot_gallery=0 -b gettext "$SPHINX_SOURCE_DIR" "$POT_DIR"

sphinx-intl update-txconfig-resources -p "$POT_DIR" -d "$SCRIPT_DIR"

cat "$SCRIPT_DIR/.tx/config"

tx push -s --skip

rm -R -f "$SCRIPT_DIR/ja"

tx pull --silent -f -l ja

git checkout "$SCRIPT_DIR/.tx/config"
