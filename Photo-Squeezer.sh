#!/bin/bash

# Welcome message and user input
echo "Welcome to the Photo squeezer!"
IFS= read -p "Enter the desired image quality (0-100): " QUALITY
IFS= read -p "Enter the desired target width (pixels): " TARGET_WIDTH
IFS= read -p "Enter the directory containing your photos: " PHOTO_DIR
IFS= read -p "Enter the desired output directory (leave blank for current directory): " OUTPUT_DIR

DEFAULT_QUALITY=75
DEFAULT_TARGET_WIDTH=1000

if [[ -z "$QUALITY" ]]; then QUALITY=$DEFAULT_QUALITY fi
if [[ -z "$TARGET_WIDTH" ]]; then TARGET_WIDTH=$DEFAULT_TARGET_WIDTH fi
if [[ -z "$PHOTO_DIR" ]]; then PHOTO_DIR=$(pwd) fi
if [[ -z "OUTPUT_DIR" ]]; then OUTPUT_DIR=$(pwd) fi

# Loop through all files in the directory
for file in "$PHOTO_DIR"/*; do
  # Check if it's a regular file and has a supported image extension
  if [[ -f "$file" && ( "$file" =~ \.(jpg|jpeg|png|webp)$ ) ]]; then
    # Get the filename without extension
    filename="${file%.*}"
    
    # Get the original image size
    original_size=$(identify -format "%wx%h" "$file")
    
    # Resize the image with appropriate scaling (maintains aspect ratio)
    convert "$file" -resize "$TARGET_WIDTH>" "$filename-resized.png"
    
    # Check if resize operation was successful
    if [[ $? -eq 0 ]]; then 
      cwebp -q "$QUALITY" -m 6 "$filename-resized.png" -o "$filename.webp"
      echo "Converted and resized $file to $filename.webp (Original size: $original_size)"
    else
      echo "Error resizing $file. Skipping conversion."
    fi
    
    # Clean up the temporary resized image (regardless of success)
    rm "$filename-resized.png"
    mv "$filename.webp" "$OUTPUT_DIR"
  fi
done

echo "Conversion complete!"
