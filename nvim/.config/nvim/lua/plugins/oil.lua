return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"-",
			function()
				require("oil").open_float()
			end,
			mode = "n",
			desc = "Open parent directory",
		},
	},
	opts = {
		default_file_explorer = true,
		delete_to_trash = false,
		use_default_keymaps = false,
		keymaps = {
			["g?"] = "actions.show_help",
			["<cr>"] = "actions.select",
			["<c-s>"] = "actions.select_vsplit",
			["<c-h>"] = "actions.select_split",
			["<c-t>"] = "actions.select_tab",
			["<c-p>"] = "actions.preview",
			["q"] = "actions.close",
			["<c-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
		},
		win_options = {
			wrap = false,
			signcolumn = "no",
			cursorcolumn = false,
			foldcolumn = "0",
			spell = false,
			list = false,
			conceallevel = 3,
			concealcursor = "nvic",
		},
		view_options = {
			show_hidden = false,
		},
		float = {
			padding = 2,
			max_width = 80,
			max_height = 16,
			border = "rounded",
		},
	},
}
