function __tirea_section_dir
	set -l dir (prompt_pwd --dir-length=0)

	__tirea_section \
		$TIREA_COLOR_BASE11 \
		$TIREA_ICON_SHELL \
		$dir
end
