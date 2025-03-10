#!/bin/bash
set -euo pipefail

# Change to the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Set up Obsidian to Hugo copy paths
sourcePath="/Users/tsaishengwei/Desktop/Obsidian-blogs/posts"
destinationPath="/Users/tsaishengwei/workspace/github.com/Sheng-wei-Tsai/obsidian-blogs/content/posts"

# Set up GitHub repository
myrepo="Henry's Blog Repo"

# Check necessary commands
for cmd in git rsync python3 hugo; do
    if ! command -v $cmd &> /dev/null; then
        echo "$cmd is not installed or not in PATH."
        exit 1
    fi
done

# Step 1: Check if Git is initialized, if not then initialize
if [ ! -d ".git" ]; then
    echo "Initializing Git repository..."
    git init
    git remote add origin $myrepo
else
    echo "Git repository already initialized."
    if ! git remote | grep -q 'origin'; then
        echo "Adding remote origin..."
        git remote add origin $myrepo
    fi
fi

# Step 2: Use rsync to sync posts from Obsidian to Hugo content folder
echo "Syncing posts from Obsidian..."

if [ ! -d "$sourcePath" ]; then
    echo "Source path does not exist: $sourcePath"
    exit 1
fi

if [ ! -d "$destinationPath" ]; then
    echo "Destination path does not exist: $destinationPath"
    exit 1
fi

rsync -av --delete "$sourcePath/" "$destinationPath/"

# Step 3: Use Python script to process image links in Markdown files
echo "Processing image links in Markdown files..."
if [ ! -f "images.py" ]; then
    echo "Python script images.py not found."
    exit 1
fi

if ! python3 images.py; then
    echo "Failed to process image links."
    exit 1
fi

# Step 4: Ensure baseURL is set correctly in config.toml or config.yaml
echo "Checking baseURL settings..."
if [ -f "config.toml" ]; then
    # Check if baseURL is already set to GitHub Pages URL
    if ! grep -q "^baseURL\s*=\s*[\"']https://sheng-wei-tsai.github.io/obsidian-blogs[\"']" config.toml; then
        echo "Updating baseURL in config.toml..."
        sed -i '' 's|^baseURL\s*=.*|baseURL = "https://sheng-wei-tsai.github.io/obsidian-blogs"|' config.toml
    fi

    # Ensure theme is set correctly
    if ! grep -q "^theme\s*=\s*[\"']terminal[\"']" config.toml; then
        echo "Updating theme setting in config.toml..."
        sed -i '' 's|^theme\s*=.*|theme = "terminal"|' config.toml
    fi
elif [ -f "config.yaml" ] || [ -f "config.yml" ]; then
    CONFIG_FILE=$([ -f "config.yaml" ] && echo "config.yaml" || echo "config.yml")
    # Check if baseURL is already set to GitHub Pages URL
    if ! grep -q "^baseURL:\s*https://sheng-wei-tsai.github.io/obsidian-blogs" $CONFIG_FILE; then
        echo "Updating baseURL in $CONFIG_FILE..."
        sed -i '' 's|^baseURL:.*|baseURL: https://sheng-wei-tsai.github.io/obsidian-blogs|' $CONFIG_FILE
    fi

    # Ensure theme is set correctly
    if ! grep -q "^theme:\s*terminal" $CONFIG_FILE; then
        echo "Updating theme setting in $CONFIG_FILE..."
        sed -i '' 's|^theme:.*|theme: terminal|' $CONFIG_FILE
    fi
else
    echo "Warning: No config.toml or config.yaml file found."
fi

# Step 5: Build Hugo site with specified theme
echo "Building Hugo site with terminal theme..."
if ! hugo -t terminal --minify; then
    echo "Hugo build failed."
    exit 1
fi

# Step 6: Ensure .nojekyll file exists in public directory
echo "Creating .nojekyll file..."
touch public/.nojekyll

# Step 7: Add changes to Git
echo "Staging Git changes..."
if git diff --quiet && git diff --cached --quiet; then
    echo "No changes to stage."
else
    git add .
fi

# Step 8: Commit changes with dynamic message
commit_message="New blog post $(date +'%Y-%m-%d %H:%M:%S')"
if git diff --cached --quiet; then
    echo "No changes to commit."
else
    echo "Committing changes..."
    git commit -m "$commit_message"
fi

# Step 9: Push all changes to main branch
echo "Deploying to GitHub main branch..."
if ! git push origin main; then
    echo "Push to main branch failed."
    exit 1
fi

# Step 10: Push public folder to gh-pages branch
echo "Deploying to GitHub Pages (gh-pages branch)..."
if git branch --list | grep -q 'gh-pages-temp'; then
    git branch -D gh-pages-temp
fi

if ! git subtree split --prefix public -b gh-pages-temp; then
    echo "Subtree split failed."
    exit 1
fi

if ! git push origin gh-pages-temp:gh-pages --force; then
    echo "Push to gh-pages branch failed."
    git branch -D gh-pages-temp
    exit 1
fi

git branch -D gh-pages-temp

echo "All done! Site has been synced, processed, committed, built, and deployed."
