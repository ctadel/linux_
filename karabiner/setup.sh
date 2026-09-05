#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
assets_dir="$HOME/.config/karabiner/assets/complex_modifications"
target="$assets_dir/prajwal_shortcuts.json"
config="$repo_dir/karabiner.json"
live_config="$HOME/.config/karabiner/karabiner.json"
tmp_live_config="$live_config.tmp.$$"

mkdir -p "$assets_dir"
ln -sfn "$repo_dir/prajwal_shortcuts.json" "$target"
if command -v jq >/dev/null 2>&1 && [ -f "$config" ]; then
	jq --slurpfile source "$repo_dir/prajwal_shortcuts.json" '
		.profiles |= map(
						if .name == "Prajwal" then
				.complex_modifications.rules = $source[0].rules
			elif .name == "Prajwal Command Layout" or .name == "Prajwal Legacy" then
				empty
			elif .name == "Guest" then
				{name: "Guest"}
			else
				.
			end
		)
				| if any(.profiles[]; .name == "Prajwal") then . else .profiles += [{name: "Prajwal"}] end
		| if any(.profiles[]; .name == "Guest") then . else .profiles += [{name: "Guest"}] end
	' "$config" > "$tmp_live_config"
	mv "$tmp_live_config" "$live_config"
	printf '%s\n' "Built live config with Prajwal rules and reset Guest to standard macOS behavior."
else
	printf '%s\n' "Skipped profile synchronization: jq or $config is unavailable."
fi
printf '%s\n' "Linked $target to $repo_dir/prajwal_shortcuts.json"
printf '%s\n' "Generated $live_config from $config and $repo_dir/prajwal_shortcuts.json"
