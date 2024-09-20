#!/bin/sh

__status_block.sh "󰌌" "$(setxkbmap -query | awk 'END{print $2}')" "#161616" "#525252"

