#!/bin/bash

default_value=1
input_value=${1:-$default_value}

commit_count=$(git log | grep '^commit' | wc -l)

if [ "$commit_count" -lt "$input_value" ]; then
    echo "commit quantity ($commit_count) is less than input ($input_value), please run 'git pull' or change your number"
else
    target_commit=$(git log | grep '^commit' | tail -n "$input_value" | head -n 1 | cut -c8-47)
    if [ -z "$target_commit" ]; then
        echo "Error: Failed to find the target commit."
        exit 1
    fi
    git reset --hard "$target_commit"
    echo "now you are in commit $target_commit"
fi
