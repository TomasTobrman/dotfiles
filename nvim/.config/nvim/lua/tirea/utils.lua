local M = {}

M.is_plugin_loaded = function(plugin_name)
	return require("lazy.core.config").plugins[plugin_name]._.loaded
end

return M
