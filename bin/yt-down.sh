yt-dlp -x \
--audio-format mp3 \
--audio-quality 0 \
--replace-in-metadata "title" "- YouTube" "" \
--parse-metadata "%(uploader)s:%(meta_artist)s" \
-o "%(title)s - %(artist)s.%(ext)s" \
$1
