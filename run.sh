#!/bin/bash

if [ ! -f /etc/os-release ]; then
    echo "This script is intended to run on a Linux system."
    exit 1
fi

source /etc/os-release

if [ -z "$ID" ]; then
    echo "Could not determine the Linux distribution."
    exit 1
fi

echo "Detected Linux distribution: $ID"

TARGET_DIR="./$ID"
if [ ! -d "$TARGET_DIR" ]; then
    echo "No setup script available for the '$ID' distribution."
    exit 1
fi

echo "Executing all scripts in '$TARGET_DIR'..."

pushd "$TARGET_DIR" > /dev/null || exit 1

if [ -f "setup.sh" ]; then
    echo "Running setup.sh..."
    if [ ! -x "setup.sh" ]; then
        chmod +x "setup.sh"
    fi
    ./setup.sh
else
    echo "No setup.sh found in '$TARGET_DIR'."
fi

popd > /dev/null || exit 1
