#!/bin/bash

cat ~/.config/xmonad/xmonad.hs \
	| sed -n '/---- Key bindings --/,/---- Mouse bindings --/p' \
	| grep -e '++' -e '\[ ("' -e ', ("' \
	| sed -e 's/, (//' -e 's/\[ (//' \
	| sed -e 's/, .*)/ /' \
	| sed -e 's/-- \(.*\)/"\1"/' \
	| awk 'split($0, a, "\"") {$1 = a[2]} {$2 = a[4]} {printf "%-30s\t%s\n", $1, $2}' \
	| yad --text-info --geometry=1000x1155

