function la --wraps ls --description "List contents of directory, including hidden files in directory using long format"
	command eza --group-directories-first -lah $argv
end
