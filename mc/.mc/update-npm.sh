#!/data/data/com.termux/files/usr/bin/bash
# Ubah npm_install.json (hasil cek-npm.sh) jadi format grup:
#   mc-ui = semua paket (server + server-ui)
#   mc    = hanya @minecraft/server
#   ui    = hanya @minecraft/server-ui
# masing-masing dipecah beta / stable berdasarkan ada tidaknya "-beta" di versi.
#
# Pakai:
#   ./format-npm.sh npm_install.json > grouped.json

INFILE="${1:-npm_install.json}"
OUTFILE=".mc-template.json"

if [ ! -f "$INFILE" ]; then
  echo "File tidak ditemukan: $INFILE"
  echo "Pakai: ./format-npm.sh <npm_install.json>"
  exit 1
fi

jq '
  ([.[].commands[]] | map(sub("^npm\\s+i(nstall)?\\s+"; "")) | unique) as $specs
  | {
      "mc-ui": {
        beta:   ($specs | map(select(test("-beta")))),
        stable: ($specs | map(select(test("-beta") | not)))
      },
      "mc": {
        beta:   ($specs | map(select(test("^@minecraft/server@") and test("-beta")))),
        stable: ($specs | map(select(test("^@minecraft/server@") and (test("-beta") | not))))
      },
      "ui": {
        beta:   ($specs | map(select(test("^@minecraft/server-ui@") and test("-beta")))),
        stable: ($specs | map(select(test("^@minecraft/server-ui@") and (test("-beta") | not))))
      }
    }
' "$INFILE" | tee "$OUTFILE"

echo ""
echo "Tersimpan ke $OUTFILE"

