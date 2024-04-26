#!/bin/bash

# Set the directory containing the photos here (replace 'path/to/your/photos' with your actual path)
PHOTO_DIR="input"

# Quality level (0-100, lower means smaller size, higher quality loss)
QUALITY=75

# Target resolution (widthxheight)
TARGET_RESOLUTION="1000"

# Loop through all files in the directory
for file in "$PHOTO_DIR"/*; do
  # Check if it's a regular file and has a supported image extension
  if [[ -f "$file" && ( "$file" =~ \.(jpg|jpeg|png|webp)$ ) ]]; then
    # Get the filename without extension
    filename="${file%.*}"
    
    # Get the original image size
    original_size=$(identify -format "%wx%h" "$file")
    
    # Resize the image with appropriate scaling (maintains aspect ratio)
    convert "$file" -resize "$TARGET_RESOLUTION>" "$filename-resized.png"
    
    # Check if resize operation was successful
    if [[ $? -eq 0 ]]; then
      # Convert the resized image to WebP with the specified quality
      cwebp -q "$QUALITY" "$filename-resized.png" -o "$filename.webp"
      echo "Converted and resized $file to $filename.webp (Original size: $original_size)"
    else
      echo "Error resizing $file. Skipping conversion."
    fi
    
    # Clean up the temporary resized image (regardless of success)
    rm "$filename-resized.png"
    mv "$filename.webp" "./output"
  fi
done

echo "Conversion complete!"
