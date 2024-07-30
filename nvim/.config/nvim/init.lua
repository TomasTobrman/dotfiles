if vim.loader then vim.loader.enable() end

for _, module in pairs({
	"tirea.options",
	"tirea.keys",
	"tirea.lazy",
	"tirea.autocmds",
}) do
	local ok, err = pcall(require, module)
	if not ok then vim.api.nvim_err_writeln("Could not load " .. module .. "\n\n" .. err) end
end
