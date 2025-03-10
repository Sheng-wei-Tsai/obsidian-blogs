import os
import re
import shutil

# Paths
posts_dir = "/Users/tsaishengwei/workspace/github.com/Sheng-wei-Tsai/obsidian-blogs/content/posts"
attachments_dir = "/Users/tsaishengwei/Documents/Attachments"
static_images_dir = "/Users/tsaishengwei/workspace/github.com/Sheng-wei-Tsai/obsidian-blogs/static/images"

# Ensure the target directory exists
os.makedirs(static_images_dir, exist_ok=True)

print(f"Checking if directories exist:")
print(f"Posts directory exists: {os.path.exists(posts_dir)}")
print(f"Attachments directory exists: {os.path.exists(attachments_dir)}")
print(f"Static images directory exists: {os.path.exists(static_images_dir)}")

# Count for statistics
files_processed = 0
images_found = 0
images_copied = 0
errors = 0

# Step 1: Process each markdown file in the posts directory
for filename in os.listdir(posts_dir):
    if filename.endswith(".md"):
        filepath = os.path.join(posts_dir, filename)
        print(f"\nProcessing file: {filepath}")
        files_processed += 1

        try:
            with open(filepath, "r", encoding="utf-8") as file:
                content = file.read()

            # Step 2: Find all image references using Obsidian-style pattern
            # Pattern for Obsidian-style links ![[image.png]]
            pattern = r'!\[\[([^]]+\.(png|jpg|jpeg|gif|svg))\]\]'

            # Find all matches
            matches = re.findall(pattern, content, re.IGNORECASE)

            # Extract just the filenames from the tuples returned by re.findall
            image_files = [img[0] for img in matches]

            if image_files:
                print(f"Found {len(image_files)} image references in {filename}")
                print(f"Images found: {image_files}")
                images_found += len(image_files)
            else:
                print(f"No image references found in {filename}")
                # Debug: Print a small sample of the content to verify
                print(f"Content sample: {content[:200]}...")

            # Step 3: Process each image
            for image_filename in image_files:
                # Replace spaces with underscores for safer filenames
                safe_image_name = image_filename.replace(' ', '_')

                # Step 4: Copy the image to the Hugo static/images directory if it exists
                # Try multiple possible locations for the source image
                possible_sources = [
                    os.path.join(attachments_dir, image_filename),
                    # Add more potential paths if needed
                ]

                image_dest = os.path.join(static_images_dir, safe_image_name)
                copied = False

                for source in possible_sources:
                    if os.path.exists(source):
                        try:
                            print(f"Copying: {source} -> {image_dest}")
                            shutil.copy2(source, image_dest)
                            images_copied += 1
                            copied = True
                            break
                        except Exception as e:
                            print(f"Error copying file: {e}")
                            errors += 1

                if not copied:
                    print(f"Could not find source for image: {image_filename}")
                    print(f"Tried: {possible_sources}")
                    errors += 1

        except Exception as e:
            print(f"Error processing file {filename}: {e}")
            errors += 1

print("\n--- Summary ---")
print(f"Files processed: {files_processed}")
print(f"Image references found: {images_found}")
print(f"Images successfully copied: {images_copied}")
print(f"Errors encountered: {errors}")
print("Script execution completed.")
