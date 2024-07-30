function ll --wraps ls --description "List contents of directory using long format"
	command eza --group-directories-first -lh $argv
end
