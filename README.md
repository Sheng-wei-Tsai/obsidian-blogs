# obsidian-blogs

## Obsidian to Hugo Blog Pipeline
This repository contains my personal blog, which is created using a seamless workflow from Obsidian notes to a Hugo-powered website deployed on GitHub Pages.
### Overview
I write and organize my thoughts in Obsidian, then use a custom automation pipeline to transform these notes into a beautiful static website built with Hugo and the Terminal theme.
### Live Site
Visit my blog at: https://sheng-wei-tsai.github.io/obsidian-blogs
### Workflow

1. Content Creation: I write all blog posts in Obsidian, taking advantage of its powerful knowledge management features
2. Automation: A custom script handles the conversion from Obsidian markdown to Hugo-compatible format
3. Build: Hugo generates a static site with the Terminal theme
4. Deploy: The site is automatically deployed to GitHub Pages

### Technical Stack

- Content Management: Obsidian
- Static Site Generator: Hugo
- Theme: Terminal
- Hosting: GitHub Pages
- Automation: Custom Bash scripts

### Repository Structure
obsidian-blogs/
├── content/          # Hugo content (generated from Obsidian)
├── static/           # Static assets
├── themes/           # Hugo themes
├── config.toml       # Hugo configuration
└── updateblog.sh     # Automation script for the Obsidian → Hugo pipeline

### Local Development
To run this blog locally:

1. Clone this repository
2. Make sure Hugo is installed on your system
3. Run hugo server -D to start a local development server
4. Visit http://localhost:1313/obsidian-blogs/ in your browser

### Deployment
The blog is automatically deployed to GitHub Pages using the included updateblog.sh script, which:

1. Syncs content from Obsidian to Hugo
2. Processes any image links
3. Builds the site with Hugo
4. Commits and pushes changes to GitHub
5. Deploys to the gh-pages branch

License
This project is licensed under the MIT License - see the LICENSE file for details.
