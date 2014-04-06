#!/bin/bash

# Script to extract, auto translate with Potpie and compile
# them into xh locale translation strings

AUTO_TRANSLATE_DIR="/tmp/tmp.$RANDOM"
AUTO_TRANSLATE_JS_DIR="/tmp/tmp.$RANDOM"

TRANSLATION="$(mktemp '/tmp/translation.XXXXX')"
TRANSLATION_JS="$(mktemp '/tmp/translation_js.XXXXX')"

echo "Extracting xh translations..."
./setup.py --quiet extract_messages --mapping-file babel.cfg --input-dirs . --output-file $TRANSLATION --add-comments TRANSLATOR:
./setup.py --quiet extract_messages --mapping-file babel_js.cfg --input-dirs . --output-file $TRANSLATION_JS --add-comments TRANSLATOR:

echo "Auto-translating xh locale using Potpie..."
./auto_translate.py $TRANSLATION $AUTO_TRANSLATE_DIR/out.po mixed
./auto_translate.py $TRANSLATION_JS $AUTO_TRANSLATE_JS_DIR/out_js.po mixed

if [ "$1" == "init_catalog" ]
then
    echo "Initializing xh locale..."
    ./setup.py init_catalog --domain django --input-file $AUTO_TRANSLATE_DIR/out.po --output-dir locale --locale "xh"
    ./setup.py init_catalog --domain djangojs --input-file $AUTO_TRANSLATE_JS_DIR/out_js.po --output-dir locale --locale "xh"
else
    echo "Updating xh locale..."
    ./setup.py update_catalog --domain django --input-file $AUTO_TRANSLATE_DIR/out.po --output-dir locale --locale "xh" --no-fuzzy-matching
    ./setup.py update_catalog --domain djangojs --input-file $AUTO_TRANSLATE_JS_DIR/out_js.po --output-dir locale --locale "xh" --no-fuzzy-matching
fi

echo "Compiling xh translations..."
./compile_translations.sh xh

echo "Removing temp files..."
rm $TRANSLATION
rm $TRANSLATION_JS
rm -r $AUTO_TRANSLATE_DIR
rm -r $AUTO_TRANSLATE_JS_DIR

