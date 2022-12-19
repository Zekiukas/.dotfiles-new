local feline_ok, feline = pcall(require, "feline")
local palette_ok, palette = pcall(require, "catppuccin.palettes")
local git_ok, git = pcall(require, "gitsigns")

if feline_ok and palette_ok and git_ok then
	palette = palette.get_palette()
	local lsp = require("feline.providers.lsp")
	local lsp_severity = vim.diagnostic.severity

	local assets = {
		left_separator = "",
		right_separator = "",
		bar = "█",
		mode_icon = "",
		dir = "  ",
		file = "  ",
		lsp = {
			server = "  ",
			error = "  ",
			warning = "  ",
			info = "  ",
			hint = "  ",
		},
		git = {
			branch = "  ",
			added = "  ",
			changed = "  ",
			removed = "  ",
		},
	}

	local mode_colors = {
		["n"] = { "normal", palette.lavender },
		["no"] = { "n-pending", palette.lavender },
		["i"] = { "insert", palette.lavender },
		["ic"] = { "insert", palette.lavender },
		["t"] = { "terminal", palette.lavender },
		["v"] = { "visual", palette.lavender },
		["V"] = { "v-line", palette.lavender },
		[""] = { "v-block", palette.lavender },
		["R"] = { "replace", palette.lavender },
		["Rv"] = { "v-replace", palette.lavender },
		["s"] = { "select", palette.lavender },
		["S"] = { "s-line", palette.lavender },
		[""] = { "s-block", palette.lavender },
		["c"] = { "command", palette.lavender },
		["cv"] = { "command", palette.lavender },
		["ce"] = { "command", palette.lavender },
		["r"] = { "prompt", palette.lavender },
		["rm"] = { "more", palette.lavender },
		["r?"] = { "confirm", palette.lavender },
		["!"] = { "shell", palette.lavender },
	}

	git.setup({
		signcolumn = false
	})

	local function any_git_changes()
		local gst = vim.b.gitsigns_status_dict -- git stats
		if gst then
			if
				gst["added"] and gst["added"] > 0
				or gst["removed"] and gst["removed"] > 0
				or gst["changed"] and gst["changed"] > 0
			then
				return true
			end
		end
		return false
	end

	local statusbar_components = {
		active = {
			{},
			{},
			{},
		},
		inactive = {
			{},
			{},
			{},
		},
	}

	statusbar_components.active[1][1] = {
		provider = assets.bar,
		hl = {
			bg = palette.mantle,
			fg = mode_colors[vim.fn.mode()][2],
		},
	}

	statusbar_components.active[1][2] = {
		provider = assets.mode_icon,
		hl = {
			bg = palette.mantle,
			fg = mode_colors[vim.fn.mode()][2],
		},
	}

	statusbar_components.active[1][3] = {
		provider = function()
			return " " .. mode_colors[vim.fn.mode()][1] .. " "
		end,
		hl = {
			bg = palette.mantle,
			fg = mode_colors[vim.fn.mode()][2],
		},
	}

	statusbar_components.active[1][4] = {
		provider = "git_branch",
		icon = assets.git.branch,
		hl = {
			bg = palette.mantle,
			fg = palette.yellow,
		},
		right_sep = assets.bar,
	}

	statusbar_components.active[1][5] = {
		provider = "git_diff_added",
		hl = {
			fg = palette.green,
			bg = palette.mantle,
		},
		icon = assets.git.added,
	}

	statusbar_components.active[1][6] = {
		provider = "git_diff_changed",
		hl = {
			fg = palette.orange,
			bg = palette.mantle,
		},
		icon = assets.git.changed,
	}

	statusbar_components.active[1][7] = {
		provider = "git_diff_removed",
		hl = {
			fg = palette.red,
			bg = palette.mantle,
		},
		icon = assets.git.removed,
	}

	statusbar_components.active[3][1] = {
		provider = "diagnostic_hints",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.HINT)
		end,
		hl = {
			fg = palette.text,
			bg = palette.mantle,
		},
		icon = assets.lsp.hint,
	}

	statusbar_components.active[3][2] = {
		provider = "diagnostic_info",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = {
			fg = palette.teal,
			bg = palette.mantle,
		},
		icon = assets.lsp.info,
	}

	statusbar_components.active[3][3] = {
		provider = "diagnostic_warnings",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.WARN)
		end,
		hl = {
			fg = palette.yellow,
			bg = palette.mantle,
		},
		icon = assets.lsp.warning,
	}

	statusbar_components.active[3][4] = {
		provider = "diagnostic_errors",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
		end,
		hl = {
			fg = palette.red,
			bg = palette.mantle,
		},
		icon = assets.lsp.error,
	}

	statusbar_components.active[3][5] = {
		provider = function()
			if next(vim.lsp.buf_get_clients()) ~= nil then
				return assets.lsp.server
			else
				return ""
			end
		end,
		hl = {
			fg = palette.blue,
			bg = palette.mantle,
		},
		left_separator = " ",
	}

	statusbar_components.active[3][6] = {
		provider = "line_percentage",
		left_sep = assets.bar,
		right_sep = assets.bar,
		hl = {
			bg = palette.mantle,
			fg = palette.lavender,
		},
	}

	statusbar_components.active[3][7] = {
		provider = assets.bar,
		hl = {
			bg = palette.lavender,
			fg = palette.lavender,
		},
	}

	feline.setup {
		components = statusbar_components,
	}

	feline.winbar.setup()
end
