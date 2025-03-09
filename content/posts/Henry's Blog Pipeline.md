---
title: My first obsidian blog
date: 2025-03-09
draft: false
tags:
  - obsidian
  - hugo
  - github
---


# Obsidian
- Obsidian is the BEST notes app in the world. 

## The Setup
- Create a new folder labeled *blog-posts* . This is where I will add my blog posts
- ... that's all i need to do 
- Actually find out where my Obsidian directories are. Right click my *blog-posts* folder and choose *show in system explorer*
- I'' need this directory in upcoming steps. 
- path: "/Users/tsaishengwei/Desktop/Obsidian-blogs/blog-posts"

## Setting up Hugo
### Install Hugo
- https://gohugo.io/installation
- CLI: ```brew install hugo```
- Theme: https://themes.gohugo.io/
1. use git submodule - ```bash
git submodule add -f https://github.com/panr/hugo-theme-terminal.git themes/terminal

2. Config the theme
```
baseurl = "/" languageCode = "en-us" # Add it only if you keep the theme in the `themes` directory. # Remove it if you use the theme as a remote Hugo Module. theme = "terminal" pagerSize = 5 [params] # dir name of your main content (default is `content/posts`). # the list of set content will show up on your index page (baseurl). contentTypeName = "posts" # if you set this to 0, only submenu trigger will be visible showMenuItems = 2 # show selector to switch language showLanguageSelector = false # set theme to full screen width fullWidthTheme = false # center theme with default width centerTheme = false # if your resource directory contains an image called `cover.(jpg|png|webp)`, # then the file will be used as a cover automatically. # With this option you don't have to put the `cover` param in a front-matter. autoCover = true # set post to show the last updated # If you use git, you can set `enableGitInfo` to `true` and then post will automatically get the last updated showLastUpdated = false # Provide a string as a prefix for the last update date. By default, it looks like this: 2020-xx-xx [Updated: 2020-xx-xx] :: Author # updatedDatePrefix = "Updated" # whether to show a page's estimated reading time # readingTime = false # default # whether to show a table of contents # can be overridden in a page's front-matter # Toc = false # default # set title for the table of contents # can be overridden in a page's front-matter # TocTitle = "Table of Contents" # default # Set date/time format for posts # This will impact the date/time displayed on # index.html, the posts list page, and on posts themselves # This value can also be configured per-post on front matter # If you have any issues with the timezone rendering differently # than you expected, please ensure your timezone is correctly set # on your server. # This value can be customized according to Hugo documentation: # https://gohugo.io/functions/time/format/ # Default value (no changes needed): # dateFormat = "2006-01-02" # Example format, with date, time, and timezone abbreviation: # dateFormat = "2006-01-02 3:04:06 PM MST" [params.twitter] # set Twitter handles for Twitter cards # see https://developer.twitter.com/en/docs/tweets/optimize-with-cards/guides/getting-started#card-and-content-attribution # do not include @ creator = "" site = "" [languages] [languages.en] languageName = "English" title = "Terminal" [languages.en.params] subtitle = "A simple, retro theme for Hugo" owner = "" keywords = "" copyright = "" menuMore = "Show more" readMore = "Read more" readOtherPosts = "Read other posts" newerPosts = "Newer posts" olderPosts = "Older posts" missingContentMessage = "Page not found..." missingBackButtonLabel = "Back to home page" minuteReadingTime = "min read" words = "words" [languages.en.params.logo] logoText = "Terminal" logoHomeLink = "/" [languages.en.menu] [[languages.en.menu.main]] identifier = "about" name = "About" url = "/about" [[languages.en.menu.main]] identifier = "showcase" name = "Showcase" url = "/showcase"

```
3. Create a same folder as *blog-posts* same as on obsidian 
4. Then Syncing Obsidian to Hugo 
5. hugo path: "/Users/tsaishengwei/workspace/github.com/Sheng-wei-Tsai/henryblogs/content/blog-posts"
- rsync -av --delete "sourcepath" "destinationpath"

##### Prerequisites 
- Install Git & Go 

### git config 
- git config --global --list 
- user.email=henry88002605@gmail.com
- user.name=Henry Tsai

## Images

![[mickey-st-patricks-day.png]]