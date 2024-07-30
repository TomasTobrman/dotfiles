function __tirea_section_duration
	__tirea_util_set_default TIREA_EXEC_TIME_ELAPSED 5

	set -l command_duration $CMD_DURATION

	if test -n "$command_duration" -a "$command_duration" -gt (math "$TIREA_EXEC_TIME_ELAPSED * 1000")
		set -l human_command_duration (echo $command_duration | __tirea_util_human_time)
		__tirea_section \
			$TIREA_COLOR_BASE08 \
			$TIREA_ICON_TIMER \
			$human_command_duration
	end
end
