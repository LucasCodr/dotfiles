#!/bin/bash

# Convert all PNG files in the current directory to WebP
for file in *.png; do
  [ -e "$file" ] || continue
  base="${file%.png}"
  ffmpeg -i "$file" -c:v libwebp "${base}.webp" && echo "Conversion complete"
done
