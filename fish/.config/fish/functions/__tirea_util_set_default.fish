function __tirea_util_set_default -a var
	if not set -q $var
		set -g $var $argv[2..-1]
	end
end
