
local cmp_ok, cmp = pcall(require, "cmp")
local ls_ok, ls = pcall(require, "luasnip")

if cmp_ok and ls_ok then
	icons = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "ﰠ",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "塞",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
		TypeParameter = "",
	}

	local snip = ls.snippet
	local inode = ls.insert_node
	local tnode = ls.text_node
	local fmt = require("luasnip.extras.fmt").fmt
	local same = function(index)
		return ls.function_node(function(arg)
			return arg[1]
		end, { index })
	end

	ls.add_snippets("css", {
		snip("rosewater", tnode("#f5e0dc")),
		snip("flamingo", tnode("f2cdcd")),
		snip("pink", tnode("#f5c2e7")),
		snip("mauve", tnode("#cba6f7")),
		snip("red", tnode("#f38ba8")),
		snip("maroon", tnode("#eba0ac")),
		snip("peach", tnode("#fab387")),
		snip("yellow", tnode("#f9e2af")),
		snip("green", tnode("#a6e3a1")),
		snip("teal", tnode("#94e2d5")),
		snip("sky", tnode("#89dceb")),
		snip("sapphire", tnode("#74c7ec")),
		snip("blue", tnode("#89b4fa")),
		snip("lavender", tnode("#b4befe")),
		snip("text", tnode("#cdd6f4")),
		snip("subtext1", tnode("#bac2de")),
		snip("subtext0", tnode("#a6adc8")),
		snip("overlay2", tnode("#9399b2")),
		snip("overlay1", tnode("#7f849c")),
		snip("overlay0", tnode("#6c7086")),
		snip("surface2", tnode("#585b70")),
		snip("surface1", tnode("#45475a")),
		snip("surface0", tnode("#313244")),
		snip("base", tnode("#1e1e2e")),
		snip("mantle", tnode("#181825")),
		snip("crust", tnode("#11111b"))
	})

	ls.add_snippets("typescript", {
		snip("imp", fmt([[import {{ {1} }} from "{2}";]], {
			inode(1, ""),
			inode(2, ""),
		})),

		snip("fn", fmt([[
			{5}function {1}({2}): {3} {{
				{4}
			}}
		]], {
			inode(1, "myFunction"),
			inode(2, "args: any"),
			inode(3, "void"),
			inode(4, ""),
			inode(5, ""),
		})),
	})
    ls.add_snippets("cpp", {
        snip("nma", fmt([[
        #include <bits/stdc++.h>
        using namespace std;
        int main() {{
            {1}
        }}
        ]],{
                inode(1, "/* code */")
            }))
    })
	cmp.setup({
		snippet = {
			expand = function(args)
				ls.lsp_expand(args.body)
			end,
		}, 
		mapping = cmp.mapping.preset.insert {
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<cr>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif ls.expandable() then
					ls.expand()
				elseif ls.expand_or_jumpable() then
					ls.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif ls.jumpable(-1) then
					ls.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		formatting = {
			format = function(_entry, vim_item)
				vim_item.kind = icons[vim_item.kind] or ""
				return vim_item
			end
		},
		experimental = {
			ghost_text = true,
		},
		sources = {
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "path" },
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
	})

	local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
	local handlers_ok, handlers = pcall(require, "nvim-autopairs.completion.handlers")
	if cmp_autopairs_ok and handlers_ok then
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({
			filetypes = {
				["*"] = {
					["("] = {
						kind = {
							cmp.lsp.CompletionItemKind.Function,
							cmp.lsp.CompletionItemKind.Method,
						},
						handler = handlers["*"],
					}
				}
			}
		}))
	end
end
