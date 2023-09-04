#!/bin/bash

cat /dev/location > /dev/null &

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed."
    apk add python3
fi

# Check if pip is installed
if ! command -v pip &> /dev/null; then
    echo "pip is not installed."
    apk add py-pip
fi

# Install Python packages
pip install python-telegram-bot telethon

# Check if the installation was successful
if [ $? -ne 0 ]; then
    echo "Failed to install Python packages."
    exit 1
fi

# Create a temporary file to store the downloaded script
temp_script=$(mktemp)

# Download the Python script using wget
if ! wget -q "https://raw.githubusercontent.com/kekoDev/telethon-with-echo/main/bot-ios.py" -O "$temp_script"; then
    echo "Failed to download the Python script."
    exit 1
fi

# Run the downloaded Python script
if ! python3 "$temp_script"; then
    echo "Failed to run the Python script."
    exit 1
fi

# Clean up the temporary file
rm "$temp_script"
