#!/usr/bin/env bash
set -e
bundle config set path 'vendor/bundle'

# bundle update github-pages
bundle install
bundle exec jekyll serve --baseurl=""