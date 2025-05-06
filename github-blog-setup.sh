#!/usr/bin/env bash
set -e

sudo apt-get update
sudo apt-get install -y software-properties-common build-essential zlib1g-dev

sudo apt-add-repository -y ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install -y ruby3.1 ruby3.1-dev

sudo gem install bundler jekyll webrick --no-document

bundle config set path 'vendor/bundle'

bundle add webrick || true

bundle update github-pages
bundle install
bundle exec jekyll serve --baseurl=""