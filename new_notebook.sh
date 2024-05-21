#!/bin/bash

# Directory containing the notebooks
NOTEBOOK_DIR="notebooks/"

# Find all *.ipynb files in the directory and extract the leading integers from their filenames
numbers=($(find "$NOTEBOOK_DIR" -maxdepth 1 -name "*.ipynb" -exec basename {} \; | sed -E 's/^([0-9]+) - .*/\1/' | sort -n))

# Find the largest number (N)
if [ ${#numbers[@]} -eq 0 ]; then
    N=0
else
    N=${numbers[${#numbers[@]}-1]}
fi

# Increment N to get the new notebook number
new_number=$((N + 1))

# Prompt the user for a notebook title
read -p "Enter the notebook title: " title

# Create the new notebook filename
new_notebook="${NOTEBOOK_DIR}${new_number} - ${title}.ipynb"

# Create an empty notebook file (JSON format)
echo '{"cells":[],"metadata":{},"nbformat":4,"nbformat_minor":2}' > "$new_notebook"

echo "New notebook created: $new_notebook"

# Open the new notebook in Visual Studio Code
code "$new_notebook"
