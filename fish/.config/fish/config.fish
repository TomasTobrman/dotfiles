if status is-interactive
	setenv EDITOR nvim

	setenv XDG_CONFIG_HOME "$HOME/.config"
	setenv XDG_DATA_HOME   "$HOME/.local/share"
	setenv XDG_STATE_HOME  "$HOME/.local/state"
	setenv XDG_CACHE_HOME  "$HOME/.cache"

	setenv _JAVA_AWT_WM_NONREPARENTING 1 

	fish_add_path "$HOME/bin"
	fish_add_path "/etc/sudoers.d"

	alias pacman-clear='sudo pacman -Rsn $(pacman -Qdtq)'
end
