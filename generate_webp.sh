#!/bin/bash
#==============================================================================
#title           :generate_webp.sh
#usage           :Run this script with WSL on Windows or Bash shell on Unix/Linux
#                :This is intended to be run from the root website directory
#                :Adjust target location for conversion as needed
#prerequisite    :WebP tools installed
#==============================================================================

TARGET_PATH="$(cd "$(dirname "$0")" && pwd)/assets/img/remote/*"

for file in $TARGET_PATH; do

    DUP_CHECK=$(readlink -f "$file" | sed 's/\.[^.]*$//')

    # Skip webps
    if [[ $file == *.webp ]]; then
        continue
    # Check to see if a WEBP of the same name already exists
    elif [[ -f "$DUP_CHECK.webp" ]]; then
        echo "WEBP for $(basename "$file") already exists. Skipping..."
        continue
    # Convert GIFs
    elif [[ $file == *.gif ]]; then
        echo "Converting ./assets/img/remote/$(basename "${file}") --> webp"
        gif2webp -q 90 "$(echo "$file" | sed -e 's/\*/ /g' -e 's/^"//' -e 's/"$//')" \
            -o "$(echo "$file" | sed -e 's/\*/ /g' -e 's/^"//' | sed 's/.[^.]*$//').webp" \
            -mt -quiet
    # Convert still images
    elif [[ $file == *.jpg ]] || [[ $file == *.jpeg ]] || [[ $file == *.png ]] || [[ $file == *.tiff ]]; then
        echo "Converting ./assets/img/remote/$(basename "${file}") --> webp"
        cwebp -q 90 "$(echo "$file" | sed -e 's/\*/ /g' -e 's/^"//' -e 's/"$//')" \
            -o "$(echo "$file" | sed -e 's/\*/ /g' -e 's/^"//' | sed 's/.[^.]*$//').webp" \
            -mt -quiet
    fi
done
