#!/bin/bash

# Script to extract translation strings for the given locale

if [ $# -ne "1" ]
then
    echo "Usage: `basename $0` <locale>"
    exit 1
fi

locale=$1

TRANSLATION="$(mktemp /tmp/django_XXXXXX)"
TRANSLATION_JS="$(mktemp /tmp/djangojs_XXXXXX)"

echo "Extracting strings from the source..."
./setup.py --quiet extract_messages --mapping-file babel.cfg --input-dirs . --output-file $TRANSLATION --no-location --add-comments TRANS:
./setup.py --quiet extract_messages --mapping-file babel_js.cfg --input-dirs . --output-file $TRANSLATION_JS --no-location --add-comments TRANS:

echo "Updating fanmgmt translations..."
./setup.py update_catalog --domain django --input-file $TRANSLATION --output-dir locale --locale "$locale" --no-fuzzy-matching
./setup.py update_catalog --domain djangojs --input-file $TRANSLATION_JS --output-dir locale --locale "$locale" --no-fuzzy-matching

echo "Removing temp files..."
rm $TRANSLATION
rm $TRANSLATION_JS

