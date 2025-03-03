return -- Lua
{
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = 0.65,
			backdrop = 0.75,
		},
	},
	keys = {
		{
			"<leader>Z",
			function()
				require("zen-mode").toggle()
			end,
			mode = { "n" },
			desc = "Find and switch Git branches",
		},
	},
}
