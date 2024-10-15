vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	desc = "Set correct filetype to .h and .c files",
	pattern = { "*.c", "*.h" },
	callback = function()
		vim.opt_local.filetype = "c"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	desc = "Set correct filetype to shader files",
	pattern = { "*.vert", "*.frag" },
	callback = function()
		vim.opt_local.filetype = "glsl"
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Expand Tab for filetypes",
	pattern = { "c", "cpp", "haskell", "lhaskell" },
	callback = function()
		vim.opt_local.expandtab = true
	end,
})
