#!/usr/bin/env bash
# Refresh every pinned sha in .claude-plugin/marketplace.json to the upstream HEAD of its ref.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MANIFEST="$ROOT/.claude-plugin/marketplace.json"

command -v gh >/dev/null || { echo "gh is required" >&2; exit 1; }
command -v jq >/dev/null || { echo "jq is required" >&2; exit 1; }

changed=0
tmp="$(mktemp)"
cp "$MANIFEST" "$tmp"

count="$(jq '.plugins | length' "$MANIFEST")"
for ((i = 0; i < count; i++)); do
  name="$(jq -r ".plugins[$i].name" "$MANIFEST")"
  type="$(jq -r ".plugins[$i].source.source // empty" "$MANIFEST")"
  case "$type" in
    github) repo="$(jq -r ".plugins[$i].source.repo" "$MANIFEST")" ;;
    git-subdir) repo="$(jq -r ".plugins[$i].source.url" "$MANIFEST" | sed -E 's#^https://github.com/##; s#\.git$##')" ;;
    *) continue ;;
  esac
  ref="$(jq -r ".plugins[$i].source.ref // \"HEAD\"" "$MANIFEST")"
  old="$(jq -r ".plugins[$i].source.sha // empty" "$MANIFEST")"
  new="$(gh api "repos/$repo/commits/$ref" --jq .sha)"
  if [[ "$old" != "$new" ]]; then
    echo "$name: ${old:0:7} -> ${new:0:7} ($repo@$ref)"
    jq --arg sha "$new" ".plugins[$i].source.sha = \$sha" "$tmp" > "$tmp.next" && mv "$tmp.next" "$tmp"
    changed=1
  fi
done

if [[ "$changed" -eq 1 ]]; then
  mv "$tmp" "$MANIFEST"
  echo "Updated $MANIFEST"
else
  rm -f "$tmp"
  echo "All pins are current."
fi
