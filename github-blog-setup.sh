#!/usr/bin/env bash
set -e

sudo apt-get update
sudo apt-get install ruby-full build-essential zlib1g-dev

sudo gem install jekyll bundler webrick

bundle config set path 'vendor/bundle'

bundle add webrick || true

bundle update github-pages
bundle install
bundle exec jekyll serve --baseurl=""