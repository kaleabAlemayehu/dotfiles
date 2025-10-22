#!/usr/bin/env bash

# Stow all directories in the current directory
for dir in */; do
    # Remove trailing slash
    dir=${dir%*/}
    # Skip .git directory
    if [ "$dir" != ".git" ]; then
        echo "Stowing $dir"
        stow --no-folding -v -t ~ "$dir"
    fi
done

echo "All directories have been stowed."
