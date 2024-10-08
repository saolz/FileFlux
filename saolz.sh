#!/bin/bash

# Check for file argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

FILE_PATH="$1"

# Upload the file using curl
curl -X POST -F "file=@${FILE_PATH}" https://saolz.pythonanywhere.com/upload

echo "Upload completed."
