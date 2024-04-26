
# Photo Squeezer: Convert and Compress Images for Web

This Bash script automates image conversion and compression to WebP format, a modern image format that offers superior compression ratios compared to JPEG while maintaining comparable quality. It's ideal for optimizing images for websites to improve loading times and user experience.

This script relies on two external tools: convert from ImageMagick and cwebp from the WebP library. Here's how to install them on various Linux distributions:

## Installation ImageMagick
Debian/Ubuntu:
```bash
sudo apt install imagemagick
```
Fedora/CentOS/RHEL:
```bash
sudo dnf install ImageMagick
```
Arch Linux:
```bash
sudo pacman -Sy imagemagick
```
## Installation cwebp
https://developers.google.com/speed/webp/download

## Install script
Open a terminal window
```bash
git clone https://github.com/ImSabetDariush/Photo-Squeezer.git
cd Photo-Squeezer
chmod +x Photo-Squeezer.sh
```
Now run script 
```bash
./Photo-Squeezer.sh
```
