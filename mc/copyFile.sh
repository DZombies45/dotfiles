#!/bin/bash

FROM="$1"
TO="$2"

if [ -z "$FROM" ] || [ -z "$TO" ]; then
  echo "Usage: copyfile.sh from to"
  exit 1
fi

echo "Menghapus $TO/*"
rm -rf "$TO"/*

echo "Menyalin dari $FROM ke $TO"
cp -r "$FROM"/* "$TO"

echo "Done!"