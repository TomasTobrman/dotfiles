function lt --wraps ls --description "List contents of directory using recursive tree format"
	command eza --group-directories-first -T $argv
end
