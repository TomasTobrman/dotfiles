
local palette1 = {
	["black"]		= "#222323",
	["lblack"]		= "#363636",
	["red"]			= "#ee3a5b",
	["lred"]		= "#ea6262",
	["green"]		= "#5bbe61",
	["lgreen"]		= "#a7d074",
	["yellow"]		= "#ffd877",
	["lyellow"]		= "#fcea9e",
	["blue"]		= "#0ba6da",
	["lblue"]		= "#8db7ff",
	["magenta"]		= "#9b5984",
	["lmagenta"]	= "#bc75ab",
	["cyan"]		= "#9ba5d7",
	["lcyan"]		= "#bbccee",
	["white"]		= "#eaf0d8",
	["lwhite"]		= "#ffeced",
}

local colors = { ansi = {}, brights = {}, indexed = {}, }

colors.background = "#202020"
colors.foreground = "#f0f6f0"

colors.cursor_bg = palette1.white
colors.cursor_fg = palette1.black
colors.cursor_border = palette1.white

colors.ansi = {
	palette1.black,
	palette1.red,
	palette1.green,
	palette1.yellow,
	palette1.blue,
	palette1.magenta,
	palette1.cyan,
	palette1.white,
}

colors.brights = {
	palette1.lblack,
	palette1.lred,
	palette1.lgreen,
	palette1.lyellow,
	palette1.lblue,
	palette1.lmagenta,
	palette1.lcyan,
	palette1.lwhite,
}

return colors
