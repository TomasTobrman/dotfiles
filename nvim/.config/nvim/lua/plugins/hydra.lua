return {
	"anuvyklack/hydra.nvim",
	event = "VeryLazy",
	config = function()
		local hydra = require("hydra")

		hydra({
			name = "Side scroll",
			mode = "n",
			body = "z",
			heads = {
				{ "h", "5zh" },
				{ "l", "5zl", { desc = "←/→" } },
				{ "H", "zH" },
				{ "L", "zL", { desc = "half screen ←/→" } },
			},
		})

		hydra({
			name = "Window resizing",
			mode = "n",
			body = "<c-w>",
			heads = {
				{ "+", "<c-w>+" },
				{ "-", "<c-w>-" },
				{ "<", "<c-w><" },
				{ ">", "<c-w>>" },
			},
		})
	end
}
