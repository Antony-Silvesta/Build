#!/bin/bash

echo "Starting Selenium Tests..."

# Detect operating system and print appropriate message
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
    echo "This is a Unix-based system (Linux or macOS)."
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32"* ]]; then
    echo "This is a Windows-based system."
else
    echo "Unsupported OS type: $OSTYPE"
    exit 1
fi
