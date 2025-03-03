local cfg = require("dap").configurations
-- environment = {
--     LOG_LEVEL = "debug",
-- },
for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
	cfg[language] = {
		-- Debug server side
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch server",
			program = vim.fn.getcwd() .. "/server.js",
			cwd = vim.fn.getcwd(),
			externalConsole = false,
			console = "integratedTerminal",
			sourceMaps = true,
		},
		-- Debug single nodejs files
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			console = "integratedTerminal",
			sourceMaps = true,
		},
		-- Debug nodejs processes (make sure to add --inspect when you run the process)
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			port = "3000",
		},
		-- Debug web applications (client side)
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch & Debug Chrome",
			url = function()
				local co = coroutine.running()
				return coroutine.create(function()
					vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
						if url == nil or url == "" then
							return
						else
							coroutine.resume(co, url)
						end
					end)
				end)
			end,
			webRoot = vim.fn.getcwd(),
			protocol = "inspector",
			sourceMaps = true,
			userDataDir = false,
		},
		-- Divider for the launch.json derived configs
		{
			name = "----- ↓ launch.json configs (if available) ↓ -----",
			type = "",
			request = "launch",
		},
	}
end
