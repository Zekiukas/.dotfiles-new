local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if catppuccin_ok then
	vim.g.catppuccin_flavour = "mocha"
	local palette = require("catppuccin.palettes").get_palette()

	catppuccin.setup({
		transparent_background = true,
		styles = {
			comments = { "italic" },
			properties = { "italic" },
			types = { "bold" },
		},
		integrations = {
			markdown = true,
			cmp = true,
			treesitter = true,
			telescope = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "bold" },
					warnings = { "italic" },
				},
			},
		},
		custom_highlights = {
			-- transparency fixes
			WinSeparator = { bg = "NONE", fg = "NONE" },
			NormalFloat = { bg = "NONE" },
			DiagnosticError = { bg = "NONE" },
			DiagnosticWarn = { bg = "NONE" },
			DiagnosticInfo = { bg = "NONE" },
			DiagnosticHint = { bg = "NONE" },
			DiagnosticVirtualTextError = { bg = "NONE" },
			DiagnosticVirtualTextWarn = { bg = "NONE" },
			DiagnosticVirtualTextInfo = { bg = "NONE" },
			DiagnosticVirtualTextHint = { bg = "NONE" },

			-- editor
			CursorLine = { bg = palette.surface0 },
			EndOfBuffer = { fg = "#7480C2" },
			Whitespace = { fg = palette.surface2 },
		    Comment = {fg = "#ec6868"},
		},
	})

	vim.cmd("colorscheme catppuccin")
end
