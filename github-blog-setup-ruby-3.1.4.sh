#!/usr/bin/env bash
set -e

PROJECT_DIR="$(pwd)"

sudo apt-get update
sudo apt-get install -y \
  git build-essential libssl-dev libreadline-dev zlib1g-dev \
  libyaml-dev libffi-dev autoconf bison

if [ ! -d "$HOME/.rbenv" ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
fi

if [ ! -d "$HOME/.rbenv/plugins/ruby-build" ]; then
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if [ -f "$HOME/.zshrc" ] && ! grep -q 'rbenv init - zsh' "$HOME/.zshrc"; then
  cat << 'EOF' >> "$HOME/.zshrc"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"
EOF
fi

RUBY_VER="3.1.4"
rbenv install -s "$RUBY_VER"
rbenv global "$RUBY_VER"
rbenv rehash

gem install bundler jekyll webrick --no-document
rbenv rehash

cd "$PROJECT_DIR"

bundle config set --local path 'vendor/bundle'
# bundle add webrick --skip-install || true
# bundle add github-pages --group jekyll_plugins --skip-install
# bundle update github-pages
bundle install

bundle exec jekyll serve --baseurl=""
