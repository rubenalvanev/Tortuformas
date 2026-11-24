#!/bin/sh
printf '\033c\033]0;%s\a' Tortuformas
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Tortuformas.x86_64" "$@"
