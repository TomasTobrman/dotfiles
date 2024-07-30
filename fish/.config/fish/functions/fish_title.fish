function fish_title
	set -q argv[1]; or set argv st
	set -l dir (prompt_pwd --dir-length=0)
	echo $argv;
end
