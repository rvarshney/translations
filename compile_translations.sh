#!/bin/bash

# Compile locale translations from .po files into .mo files
# after translation strings have been updated

if [ $# -ne "1" ]
then
  echo "Usage: `basename $0` <locale>"
  exit 1
fi

locale=$1

echo "Compiling translations..."
./setup.py compile_catalog --domain django --directory locale --locale "$locale"
./setup.py compile_catalog --domain djangojs --directory locale --locale "$locale"

