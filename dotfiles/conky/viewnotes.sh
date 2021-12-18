#!/bin/bash

task conky | sed '/^$/d' | sed '/^Desc/d' | sed '/^---/d' | sed '/ task[s]\?$/d' > notes.txt
cat ~/notes.txt | sed 's/^/ \${color #ddddff}${font Font Awesome 5 Free Solid:size=10} ${font SF Pro Display Thin:size=15}\$color /g'
