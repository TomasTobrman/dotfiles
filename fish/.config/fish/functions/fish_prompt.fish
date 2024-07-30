function fish_prompt
	__tirea_util_set_default TIREA_PROMPT_SPARSE true
	__tirea_util_set_default TIREA_PROMPT_ORDER dir git duration

	if test "$TIREA_PROMPT_SPARSE" = "true"
		echo
	end

	for i in $TIREA_PROMPT_ORDER
		eval __tirea_section_$i
	end
	set_color normal
end
