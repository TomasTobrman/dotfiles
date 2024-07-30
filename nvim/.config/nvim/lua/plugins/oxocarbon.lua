return {
	"nyoom-engineering/oxocarbon.nvim",
	lazy = false,
	prioroty = 1000,
	config = function()
		vim.opt.background = "dark"
		vim.cmd.colorscheme "oxocarbon"
	end,
}
