function __tirea_section -a color icon content
	printf "%s%s %s %s%s %s %s " \
		(set_color --background $color) \
		(set_color --bold 262626) \
		$icon \
		(set_color --background 262626) \
		(set_color --bold $color) \
		$content \
		(set_color normal)
end
