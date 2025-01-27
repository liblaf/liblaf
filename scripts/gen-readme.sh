#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

uv run scripts/repo-list.py --output projects.yaml
prettier --write projects.yaml
uvx awesome-list-generator projects.yaml > projects.md
cat config/header.md projects.md > README.md
rm --force --verbose projects.md
prettier --write README.md
