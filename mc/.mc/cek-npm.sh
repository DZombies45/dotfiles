#!/data/data/com.termux/files/usr/bin/bash
# Cek banyak URL sekaligus, cari perintah "npm i" / "npm install", gabung ke satu JSON.
# Pakai:
#   ./cek-npm.sh urls.txt
# urls.txt isinya satu URL per baris.

URLFILE="$1"
OUTFILE="npm_install.json"

if [ -z "$URLFILE" ] || [ ! -f "$URLFILE" ]; then
  echo "Pakai: ./cek-npm.sh <file-daftar-url.txt>"
  echo "Isi file: satu URL per baris."
  exit 1
fi

result="[]"

while IFS= read -r url || [ -n "$url" ]; do
  # skip baris kosong / komentar
  [ -z "$url" ] && continue
  case "$url" in \#*) continue ;; esac

  echo "Cek: $url"
  html=$(curl -sL "$url")

  # Hapus semua tag HTML (jadi spasi, biar kata antar-tag tidak nyambung),
  # lalu decode entity HTML yang umum. Perlu ini karena situs TypeDoc/shiki
  # memecah teks kode jadi banyak <span> per token.
  text=$(echo "$html" \
    | sed -e 's/<[^>]*>/ /g' \
          -e 's/&amp;/\&/g' -e 's/&lt;/</g' -e 's/&gt;/>/g' \
          -e 's/&quot;/"/g' -e "s/&#39;/'/g")

  matches=$(echo "$text" | grep -oE 'npm[[:space:]]+i(nstall)?[[:space:]]+[A-Za-z0-9@._/-]+' | tr -s ' ' | sort -u)

  if [ -z "$matches" ]; then
    echo "  -> tidak ditemukan"
    entry=$(jq -n --arg url "$url" '{url: $url, commands: []}')
  else
    entry=$(jq -n --arg url "$url" \
                  --argjson commands "$(echo "$matches" | jq -R . | jq -s .)" \
                  '{url: $url, commands: $commands}')
  fi

  result=$(echo "$result" | jq --argjson entry "$entry" '. + [$entry]')
done < "$URLFILE"

echo "$result" > "$OUTFILE"
echo ""
echo "Selesai. Tersimpan ke $OUTFILE"
cat "$OUTFILE"

