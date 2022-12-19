
local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if treesitter_ok then
	treesitter.setup({
		ensure_installed = "all",
		ignore_install = {},
		highlight = { enable = true },
		indent = {
			enable = true,
			disable = { "python" },
		},
		autopairs = { enable = true },
	})

	local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
	if autopairs_ok then
		autopairs.setup({
			check_ts = true,
			disable_filetypes = {
				"TelescopePrompt",
			},
		})
	end

	local autotag_ok, autotag = pcall(require, "nvim-ts-autotag")
	if autotag_ok then
		autotag.setup()
	end

	local comment_ok, comment = pcall(require, "Comment")
	if comment_ok then
		comment.setup({
			mappings = {
				basic = false,
				extra = false,
			},
		})
	end
end
