#!/bin/bash

# Set base URLs
BASE_URL="https://saolz.pythonanywhere.com"
UPLOAD_URL="$BASE_URL/upload"
LIST_URL="$BASE_URL/files"

# Function to list existing files
list_files() {
    echo "Fetching the list of files..."
    curl -s "$LIST_URL"
}

# Function to upload a file
upload_file() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: upload <file_path>"
        return 1
    fi

    FILE_PATH="$1"
    echo "Uploading file: $FILE_PATH"

    # Upload the file
    curl -X POST -F "file=@${FILE_PATH}" "$UPLOAD_URL"
}

# Function to download a file
download_file() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: download <file_name>"
        return 1
    fi

    FILE_NAME="$1"
    DOWNLOAD_URL="$BASE_URL/files/$FILE_NAME"  # Adjust if needed

    echo "Checking for existing files..."
    if curl -s "$LIST_URL" | grep -q "$FILE_NAME"; then
        echo "File found. Downloading..."
        curl -O "$DOWNLOAD_URL"
        echo "Download completed."
    else
        echo "File not found on the server."
        return 1
    fi
}

# Main menu
while true; do
    echo "Choose an option:"
    echo "1. List files"
    echo "2. Upload a file"
    echo "3. Download a file"
    echo "4. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            list_files
            ;;
        2)
            read -p "Enter the file path to upload: " file_path
            upload_file "$file_path"
            ;;
        3)
            read -p "Enter the file name to download: " file_name
            download_file "$file_name"
            ;;
        4)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
