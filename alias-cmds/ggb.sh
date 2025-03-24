#!/bin/sh
set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <grep-string>"
    exit 1
fi

for location in $(git grep -n $1 | cut -d ':' -f 1,2 | uniq); do
    file=${location%:*}
    ln=${location#*:}
    git blame $file -L $ln,+1 -f -n -e | grep $1
done
