#!/usr/bin/env bash
set -euo pipefail

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "Error: Not a Git repo." >&2
  exit 1
fi

git fetch --all --prune

DEFAULT_BRANCH="main"

git checkout "$DEFAULT_BRANCH"

git reset --hard "origin/$DEFAULT_BRANCH"

git clean -fdx

for br in $(git for-each-ref --format='%(refname:short)' refs/heads/); do
  if [[ "$br" != "$DEFAULT_BRANCH" ]]; then
    git branch -D "$br"
  fi
done

git checkout "$DEFAULT_BRANCH"

echo "✅ Clear Git Done."
