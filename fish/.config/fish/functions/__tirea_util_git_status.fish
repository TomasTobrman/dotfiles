function __tirea_util_git_status
	__tirea_util_set_default TIREA_GIT_PROMPT_ORDER untracked added modified renamed deleted stashed unmerged diverged ahead behind
	__tirea_util_set_default TIREA_GIT_STATUS_COLOR $TIREA_COLOR_BASE13
	__tirea_util_set_default TIREA_GIT_STATUS_ICON $TIREA_ICON_GIT_STATUS_CLEAN

	set -l git_status
	set -l is_ahead
	set -l is_behind

	set -l index (command git status --porcelain 2>/dev/null -b)
	set -l trimmed_index (string split \n $index | string sub --start 1 --length 2)

	for i in $trimmed_index
		if test (string match '\?\?' $i)
			set git_status untracked $git_status
		end
		if test (string match '*A*' $i)
			set git_status added $git_status
		end
		if test (string match '*M*' $i)
			set git_status modified $git_status
		end
		if test (string match '*R*' $i)
			set git_status renamed $git_status
		end
		if test (string match '*D*' $i)
			set git_status deleted $git_status
		end
		if test (string match '*U*' $i)
			set git_status unmerged $git_status
		end
	end

	# Check for stashes
	if test -n (echo (command git rev-parse --verify refs/stash 2>/dev/null))
		set git_status stashed $git_status
	end

	# Check whether the branch is ahead
	if test (string match '*ahead*' $index)
		set is_ahead true
	end

	# Check whether the branch is behind
	if test (string match '*behind*' $index)
		set is_behind true
	end

	# Check whether the branch has diverged
	if test "$is_ahead" = "true" -a "$is_behind" = "true"
		set git_status diverged $git_status
	else if test "$is_ahead" = "true"
		set git_status ahead $git_status
	else if test "$is_behind" = "true"
		set git_status behind $git_status
	end

	set -l full_git_status
	for i in $TIREA_GIT_PROMPT_ORDER
		set i (string upper $i)
		set git_status (string upper $git_status)
		if contains $i in $git_status
			set -l status_symbol TIREA_ICON_GIT_STATUS_$i
			set full_git_status "$$status_symbol$full_git_status"
		end
	end

	if test -n "$full_git_status"
		set -g TIREA_GIT_STATUS_COLOR $TIREA_COLOR_BASE10
		set -g TIREA_GIT_STATUS_ICON $full_git_status
	else
		set -g TIREA_GIT_STATUS_COLOR $TIREA_COLOR_BASE13
		set -g TIREA_GIT_STATUS_ICON $TIREA_ICON_GIT_STATUS_CLEAN
	end
end
