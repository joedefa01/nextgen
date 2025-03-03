local cfg = require("dap").configurations

cfg.python = {
	{
		type = "python",
		request = "launch",
		name = "Debug Current File",
		program = "${file}",
		console = "integratedTerminal",
		pythonPath = function()
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
	{
		type = "python",
		request = "attach",
		name = "Attach to remote process...",
		connect = {
			host = function()
				return vim.fn.input("Host: ")
			end,
			port = function()
				return vim.fn.input("Port: ")
			end,
		},
		mode = "remote",
		pythonPath = function()
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
}
