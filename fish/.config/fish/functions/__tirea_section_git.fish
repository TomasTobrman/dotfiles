function __tirea_section_git
	eval __tirea_util_git_status

	set -l git_branch (echo (command git rev-parse --abbrev-ref HEAD 2>/dev/null))
	[ -z $git_branch ]; and return

	__tirea_section \
		$TIREA_GIT_STATUS_COLOR \
		$TIREA_GIT_STATUS_ICON \
		$git_branch
end
