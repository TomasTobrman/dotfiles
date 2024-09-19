return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local servers = {
			clangd = require("plugins.lsp.clangd"),
			lua_ls = require("plugins.lsp.lua_ls"),
			astro = require("plugins.lsp.astro"),
			intelephense = require("plugins.lsp.intelephense"),
			jdtls = require("plugins.lsp.jdtls"),
			omnisharp = require("plugins.lsp.omnisharp"),
		}

		local opts = { noremap = true, silent = true }
		local on_attach = function(_, bufnr)
			opts.buffer = bufnr

			opts.desc = "[c]ode [a]ctions"
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "[r]ename"
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		for server, settings in pairs(servers) do
			settings.capabilities = capabilities
			settings.on_attach = on_attach
			lspconfig[server].setup(settings)
		end
	end,
}
