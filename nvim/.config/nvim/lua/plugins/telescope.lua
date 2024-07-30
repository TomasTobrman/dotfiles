return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = { { "<leader>f", "", mode = "n", desc = "[f]ind" } },
	cmd = "Telescope",
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"build",
					"vendor",
					"node_modules",
				},
				mappings = {
					i = {
						["<c-k>"] = actions.move_selection_previous,
						["<c-j>"] = actions.move_selection_next,
						["<c-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>",  { desc = "[f]ind [f]iles" })
		vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>",     { desc = "[f]ind [b]uffer" })
		vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",    { desc = "[f]ind [r]ecent" })
		vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>",   { desc = "[f]ind [s]tring" })
		vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "[f]ind [c]urrent" })
	end,
}
